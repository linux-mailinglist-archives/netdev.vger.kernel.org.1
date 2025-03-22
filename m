Return-Path: <netdev+bounces-176938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF9A6CCE7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531797A79B6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB81E51EB;
	Sat, 22 Mar 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brTGsvs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D10481A3;
	Sat, 22 Mar 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680447; cv=none; b=SH4Nmtjt6hCTK9sbV1bj+TPxPWrFZd0u4q6wrDL9+dY7rkwLk+nwFpEDmddr+tWm0AYoMZYV9pVey4aSRT3gi6qQzVlJ4XCy5ZZQZar/HBjg6eq4UItfg/8H2pB58cCu3B24Q7sBM8MkqgeWWFI+prs7P5v5rkKXKAl/II4JFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680447; c=relaxed/simple;
	bh=xgM6B2hrMkh6nbwl6jM9g7DFAMiBeSDbDqVP1STpuII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrN6TBu63OZz+WLFvtXAnbxhc6bvCqNsbOGkwwa8/Mon2zJUbOFfRrmhV/I0VikrSb3vmKwxJEE5KUdkgTBlCiO2D5VQBecxSYVS9X9Qe4C8HwUzikOjmX4AzHkcHRFVuZMySf1FGnrXm28ZOkq5wtS9LTCBS8CRjo3VWeC2wbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brTGsvs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4CDC4CEDD;
	Sat, 22 Mar 2025 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680446;
	bh=xgM6B2hrMkh6nbwl6jM9g7DFAMiBeSDbDqVP1STpuII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=brTGsvs8p8F0Tkcb1WJhDRBzFTOkB9EkybB7VpKM6jZTN+VBu+Os4l6rrsRi3kb+2
	 lkJ+iACVFnLMaGdt8WMxD9Wr/90DkiSCmUgTyJkxUNlVlNo5DwEYZuUXKxzKXSt3wq
	 bFwG0qfx2CPKSTwb8JQ+CWOibO8aG7gQCoSE+9/IxRBJvjT7D7HZG0v6f3wbndAnVW
	 Py5+uoMZUimjweaYrgGTtWssKwjQJ9WdSTIM0znomg+iCeF67L7B0b3KMws9SNyc55
	 IwyakfQqAQu3G/IIAf5lQVYkBqLVV/kSIUHJ27B0XoDUO/Q8tURxpkNJhWLCFzg/Ao
	 awHNsBI0KwoQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  rust-for-linux@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  me@kloenk.dev,
  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
In-Reply-To: <20250220070611.214262-8-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:09 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 17:02:31 +0100
Message-ID: <87y0wx9hpk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Tomonori,

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/kernel.c  |  18 +++++++
>  rust/kernel/cpu.rs     |  13 +++++
>  rust/kernel/error.rs   |   1 +
>  rust/kernel/io.rs      |   2 +
>  rust/kernel/io/poll.rs | 120 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  7 files changed, 156 insertions(+)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io/poll.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 9565485a1a54..16d256897ccb 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -14,6 +14,7 @@
>  #include "cred.c"
>  #include "device.c"
>  #include "err.c"
> +#include "kernel.c"
>  #include "fs.c"
>  #include "io.c"
>  #include "jump_label.c"
> diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
> new file mode 100644
> index 000000000000..f04c04d4cc4f
> --- /dev/null
> +++ b/rust/helpers/kernel.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +
> +void rust_helper_cpu_relax(void)
> +{
> +	cpu_relax();
> +}
> +
> +void rust_helper___might_sleep_precision(const char *file, int len, int line)
> +{
> +	__might_sleep_precision(file, len, line);
> +}
> +
> +void rust_helper_might_resched(void)
> +{
> +	might_resched();
> +}
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> new file mode 100644
> index 000000000000..eeeff4be84fa
> --- /dev/null
> +++ b/rust/kernel/cpu.rs
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
> +///
> +/// It also happens to serve as a compiler barrier.
> +pub fn cpu_relax() {
> +    // SAFETY: FFI call.

I don't think this safety comment is sufficient. There are two other
similar comments further down.

> +    unsafe { bindings::cpu_relax() }
> +}
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index f6ecf09cb65f..8858eb13b3df 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -64,6 +64,7 @@ macro_rules! declare_err {
>      declare_err!(EPIPE, "Broken pipe.");
>      declare_err!(EDOM, "Math argument out of domain of func.");
>      declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(ETIMEDOUT, "Connection timed out.");
>      declare_err!(ERESTARTSYS, "Restart the system call.");
>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d4a73e52e3ee..be63742f517b 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -7,6 +7,8 @@
>  use crate::error::{code::EINVAL, Result};
>  use crate::{bindings, build_assert};
>  
> +pub mod poll;
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// By itself, the existence of an instance of this structure does not provide any guarantees that
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..5977b2082cc6
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure and
> +/// checks its result using the condition closure `cond`.
> +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.
> +/// This process continues until either `cond` returns `true` or the timeout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
> +/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore
> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
> +///     // The `op` closure reads the value of a specific status register.
> +///     let op = || -> Result<u16> { dev.read_ready_register() };
> +///
> +///     // The `cond` closure takes a reference to the value returned by `op`
> +///     // and checks whether the hardware is ready.
> +///     let cond = |val: &u16| *val == HW_READY;
> +///
> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
> +///         Ok(_) => {
> +///             // The hardware is ready. The returned value of the `op`` closure isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) => Err(e),
> +///     }
> +/// }
> +/// ```
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g = lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```

I am guessing this example is present to test the call to `might_sleep`.
Could you document the reason for the test. As an example, this code is
not really usable. `#[test]` was staged for 6.15, so perhaps move this
to a unit test instead?

The test throws this BUG, which is what I think is also your intention:

  BUG: sleeping function called from invalid context at rust/doctests_kernel_generated.rs:3523
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 171, name: kunit_try_catch
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  1 lock held by kunit_try_catch/171:
  #0: ffff8881003ce598 (rust/doctests_kernel_generated.rs:3521){+.+.}-{3:3}, at: rust_helper_spin_lock+0xd/0x10
  CPU: 0 UID: 0 PID: 171 Comm: kunit_try_catch Tainted: G                 N 6.14.0-rc7+ #14
  Tainted: [N]=TEST
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  Call Trace:
  <TASK>
  dump_stack_lvl+0x7b/0xa0
  dump_stack+0x14/0x16
  __might_resched_precision+0x22f/0x240
  __might_sleep_precision+0x39/0x70
  _RNvNtNtCs1cdwasc6FUb_6kernel2io4poll11might_sleep+0x19/0x20
  rust_doctest_kernel_io_poll_rs_0+0xa5/0x1f0
  kunit_try_run_case+0x73/0x150
  ? trace_hardirqs_on+0x5a/0x90
  kunit_generic_run_threadfn_adapter+0x1a/0x30
  kthread+0x219/0x230
  ? kunit_try_catch_run+0x230/0x230
  ? __do_trace_sched_kthread_stop_ret+0x50/0x50
  ret_from_fork+0x35/0x40
  ? __do_trace_sched_kthread_stop_ret+0x50/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>

Kunit does not pick this up as a failure, but it _should_, and hopefully
it will soon (TM).

So, we should probably expect failure when we get that fixed. And
perhaps for now disable the test or add a TODO to change to expect fail
when we fix kunit.


Best regards,
Andreas Hindborg



