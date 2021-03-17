import OpenCombine

extension Publisher {
    /// Adds an anonymous subscriber to the publisher. The subscription
    /// will automatically be kept alive until the publisher finishes or
    /// is manually cancelled. The returned cancellable doesn't have to be
    /// retained by the caller.
    @discardableResult public func start() -> AnyCancellable {
        var cancellable: AnyCancellable!

        cancellable = handleEvents(receiveCancel: {
            cancellable = nil
        }).sink(receiveCompletion: { _ in
            cancellable = nil
        }, receiveValue: { _ in  })

        return cancellable
    }

    @discardableResult
    public func startWithFinished(_ onFinished: @escaping () -> Void) -> AnyCancellable {
        handleEvents(receiveCompletion: { completion in
            if case .finished = completion {
                onFinished()
            }
        })
        .start()
    }

    @discardableResult
    public func startWithCompletion(_ onComplete: @escaping (Subscribers.Completion<Failure>) -> Void) -> AnyCancellable {
        handleEvents(receiveCompletion: { completion in
            onComplete(completion)
        })
        .start()
    }

    @discardableResult
    public func startWithFailed(_ onError: @escaping (Error) -> Void) -> AnyCancellable {
        handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                onError(error)
            }
        })
        .start()
    }

    @discardableResult
    public func startWithResult(_ onResult: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        handleEvents(receiveOutput: { output in
            onResult(.success(output))
        }, receiveCompletion: { completion in
            if case let .failure(error) = completion {
                onResult(.failure(error))
            }
        })
        .start()
    }

    @discardableResult
    public func startWithOutput(_ onResult: @escaping (Output) -> Void) -> AnyCancellable {
        handleEvents(receiveOutput: { output in
            onResult(output)
        }, receiveCompletion: { _ in })
        .start()
    }
}
