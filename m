Return-Path: <netdev+bounces-210511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE2B13B15
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A13A171BFB
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA92676DE;
	Mon, 28 Jul 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSqCDE+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4642673BE;
	Mon, 28 Jul 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708434; cv=none; b=B5XX+qZHK82OtiLWdcX+gRMsa1Nb1Ks/e6m1VxQ8OrOq6Mrk8v5O6bechOVzxeVTcQfndL1jfI6LVJubIdMZ3ugDkcb5Iuh00YpLCkpZG3yo05zKmBRF/tS7DbXQjp1SJ5/b9LZsHIvyLJY1m2TSbGY2gcQSDJqQiIMUJ1LEDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708434; c=relaxed/simple;
	bh=iv0JxBRvZ7WR02RiHo40yoMEe7M/0o1fvAq6dWb/CC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EErkkkylWukqCXodbkJNHWIXLkBr+JD9s0+m9kSAootsduFTsyNuPe6aehbxBEhYJMoXjugrBUZxKDkaQxqE9k9cgn3Y0NSRTZxwNUu9q98gwwvqbxXjuafLdmJRl96HaRabU578FHWwbzdstSytXAA54wWc76VZPxBApZXhvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSqCDE+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48FC4CEE7;
	Mon, 28 Jul 2025 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753708433;
	bh=iv0JxBRvZ7WR02RiHo40yoMEe7M/0o1fvAq6dWb/CC4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JSqCDE+lO87RfltHUSMhJlTOrK6gsYOx1oMHvc2PBRoG63/wpyMFzQslkgceVPgkB
	 iep3JddRzg84LQwXdfnvVBsZbZT9b5Mm43bVYV9DYu5tDXSebKolV3L2CsTbnU9q1g
	 iOr3hn+mSu3PPH9uWn7VEIrgj5G4z2iLbPIACkkmQk4Qhnasm42iPvHu6fuYVNa/fq
	 BZgu0lu8z/IR9w1woLyqjMljnnjsAaxFJKOa9WI8wpH/aSLdSjIO7Uw41Q/n6zzuN/
	 0HlNMwKmi1jC9m2k0ukIJSswstGnk4Ngfv8EUq5ebhL5QpHAdWZATfVw4/Vum6Nep9
	 eyZjgBHAmCf3w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 15:13:45 +0200
Message-Id: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: <linux-kernel@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
 <tmgross@umich.edu>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
 <arnd@arndb.de>, <jstultz@google.com>, <sboyd@kernel.org>,
 <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <tgunders@redhat.com>, <me@kloenk.dev>,
 <david.laight.linux@gmail.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
In-Reply-To: <20250220070611.214262-8-fujita.tomonori@gmail.com>

On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
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
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/proces=
sor.h).
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin process=
or.
> +///
> +/// It also happens to serve as a compiler barrier.
> +pub fn cpu_relax() {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::cpu_relax() }
> +}

Please split this out in a separate patch.

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
>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signa=
l and will be restarted.");
>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d4a73e52e3ee..be63742f517b 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -7,6 +7,8 @@
>  use crate::error::{code::EINVAL, Result};
>  use crate::{bindings, build_assert};
> =20
> +pub mod poll;
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// By itself, the existence of an instance of this structure does not p=
rovide any guarantees that
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
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h)=
.
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure an=
d
> +/// checks its result using the condition closure `cond`.

I'd add an empty line here,

> +/// If `cond` returns `true`, the function returns successfully with the=
 result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.

and here.

> +/// This process continues until either `cond` returns `true` or the tim=
eout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `Non=
e`,
> +/// polling continues indefinitely until `cond` evaluates to `true` or a=
n error occurs.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore

Why ignore? This should be possible to compile test.

> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {

I think the parameter here can just be `&Io<SIZE>`.

> +///     // The `op` closure reads the value of a specific status registe=
r.
> +///     let op =3D || -> Result<u16> { dev.read_ready_register() };
> +///
> +///     // The `cond` closure takes a reference to the value returned by=
 `op`
> +///     // and checks whether the hardware is ready.
> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
> +///
> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(D=
elta::from_secs(3))) {
> +///         Ok(_) =3D> {
> +///             // The hardware is ready. The returned value of the `op`=
` closure isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) =3D> Err(e),
> +///     }
> +/// }
> +/// ```
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock =3D KBox::pin_init(new_spinlock!(()), kernel::alloc::flags:=
:GFP_KERNEL)?;
> +/// let g =3D lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some=
(Delta::from_micros(42)));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start =3D Instant::now();
> +    let sleep =3D !sleep_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep();
> +    }

I think a conditional might_sleep() is not great.

I also think we can catch this at compile time, if we add two different var=
iants
of read_poll_timeout() instead and be explicit about it. We could get Klint=
 to
catch such issues for us at compile time.

> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check ag=
ain.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) =3D timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call i=
t again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax(=
).
> +        cpu_relax();
> +    }
> +}

