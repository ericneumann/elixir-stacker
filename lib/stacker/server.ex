defmodule Stacker.Server do
  use GenServer

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def push_item(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  def pop_item() do
    GenServer.call __MODULE__, :pop
  end

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, initial_stack) do
    {reply, new_stack} = List.pop_at(initial_stack, 0)
    {:reply, reply, new_stack}
  end

  def terminate(reason, _initial_stack) do
    IO.puts "going awaaaaaay because #{reason}"
    System.halt(1)
  end

  def handle_cast({:push, item}, initial_stack) do
    {:noreply, initial_stack ++ [item]}
  end
end
