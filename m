Return-Path: <netdev+bounces-211456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A8B18E21
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29B9AA25C8
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0F20E00B;
	Sat,  2 Aug 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHgaNxMu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8751C5A;
	Sat,  2 Aug 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754132772; cv=none; b=Tb32sWVcYpKbXgWYzJ1LXu3ImtFbI/CENdZfn3PEPIGccSKOw32uHRPxcq6emRpbyqnPJeYSr6P3PXO42D607NWXPK7k2Lzol3sxSOTIEacsb8zw8VPm5BVpkbXwmZAmQCec+UdFUfAvwuVhUZHaCioOUryRHzHwDe8admpl2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754132772; c=relaxed/simple;
	bh=wO/0xNKUbzTU56dEYazYrjq8PgdNLrb8k5XeUIBX4hY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dwKCVeASBq36kcSR4voh0tb8mz1LxI4alS35Kdy5Mm/bTpcGn6o1BzU2HLE7KNQgx/Nyy3gyupvs2xJphSBRky3A4R6kuIjv88Fn1SHXKLwi22j/JkU6zKis7Cx+jFiw40RqZ1vXID+R5buXQMnyHjHTowfwMGhCnyxTWe21et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHgaNxMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DEBC4CEEF;
	Sat,  2 Aug 2025 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754132772;
	bh=wO/0xNKUbzTU56dEYazYrjq8PgdNLrb8k5XeUIBX4hY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=JHgaNxMu94KYlx63eWISHMJ9fTc80FBXI4EcixD4Q5AbLlyQtYdChZAaKvSPKtyVv
	 fmboTehX2+jK8ClaYbjnMWno/80rEcG8WgXPkxjfCPWmgBWBkUhLIWOD5/n48Ptf9s
	 p5OsqgX2VDUZ1/kqu6peMQx7IY64zk7Z4v3+MMRY0qPF1UX+4WIAc3BQH1La6uP2YX
	 ioYJXqskS0SBeU3D0OygwxwSh5DRBEvee+RbkYduJ4NbVULdoggBg47hTINFyDmpJv
	 y9dr/IdbBaYLvuuqdQ3kIheu7gXAKETqt7t20bPmei0OdJ+NEjXD8hT0/wrAEzWsIq
	 lWJ47xKcFfXXw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Aug 2025 13:06:04 +0200
Message-Id: <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <daniel.almeida@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <tmgross@umich.edu>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
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
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
 <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
In-Reply-To: <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>

On Sat Aug 2, 2025 at 3:42 AM CEST, FUJITA Tomonori wrote:
> On Mon, 28 Jul 2025 15:13:45 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>> On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
>>> +/// This process continues until either `cond` returns `true` or the t=
imeout,
>>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `N=
one`,
>>> +/// polling continues indefinitely until `cond` evaluates to `true` or=
 an error occurs.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```rust,ignore
>>=20
>> Why ignore? This should be possible to compile test.
>
> https://lore.kernel.org/rust-for-linux/CEF87294-8580-4C84-BEA3-EB72E63ED7=
DF@collabora.com/

I disagree with that. 'ignore' should only be used if we can't make it comp=
ile.

In this case we can make it compile, we just can't run it, since there's no=
 real
HW underneath that we can read registers from.

An example that isn't compiled will eventually be forgotten to be updated w=
hen
things are changed.

>>> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
>>=20
>> I think the parameter here can just be `&Io<SIZE>`.
>>=20
>>> +///     // The `op` closure reads the value of a specific status regis=
ter.
>>> +///     let op =3D || -> Result<u16> { dev.read_ready_register() };
>>> +///
>>> +///     // The `cond` closure takes a reference to the value returned =
by `op`
>>> +///     // and checks whether the hardware is ready.
>>> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
>>> +///
>>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some=
(Delta::from_secs(3))) {
>>> +///         Ok(_) =3D> {
>>> +///             // The hardware is ready. The returned value of the `o=
p`` closure isn't used.
>>> +///             Ok(())
>>> +///         }
>>> +///         Err(e) =3D> Err(e),
>>> +///     }
>>> +/// }
>>> +/// ```
>>> +///
>>> +/// ```rust
>>> +/// use kernel::io::poll::read_poll_timeout;
>>> +/// use kernel::time::Delta;
>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>> +///
>>> +/// let lock =3D KBox::pin_init(new_spinlock!(()), kernel::alloc::flag=
s::GFP_KERNEL)?;
>>> +/// let g =3D lock.lock();
>>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), So=
me(Delta::from_micros(42)));
>>> +/// drop(g);
>>> +///
>>> +/// # Ok::<(), Error>(())
>>> +/// ```
>>> +#[track_caller]
>>> +pub fn read_poll_timeout<Op, Cond, T>(
>>> +    mut op: Op,
>>> +    mut cond: Cond,
>>> +    sleep_delta: Delta,
>>> +    timeout_delta: Option<Delta>,
>>> +) -> Result<T>
>>> +where
>>> +    Op: FnMut() -> Result<T>,
>>> +    Cond: FnMut(&T) -> bool,
>>> +{
>>> +    let start =3D Instant::now();
>>> +    let sleep =3D !sleep_delta.is_zero();
>>> +
>>> +    if sleep {
>>> +        might_sleep();
>>> +    }
>>=20
>> I think a conditional might_sleep() is not great.
>>=20
>> I also think we can catch this at compile time, if we add two different =
variants
>> of read_poll_timeout() instead and be explicit about it. We could get Kl=
int to
>> catch such issues for us at compile time.
>
> Your point is that functions which cannot be used in atomic context
> should be clearly separated into different ones. Then Klint might be
> able to detect such usage at compile time, right?
>
> How about dropping the conditional might_sleep() and making
> read_poll_timeout return an error with zero sleep_delta?

Yes, let's always call might_sleep(), the conditional is very error prone. =
We
want to see the warning splat whenever someone calls read_poll_timeout() fr=
om
atomic context.

Yes, with zero sleep_delta it could be called from atomic context technical=
ly,
but if drivers rely on this and wrap this into higher level helpers it's ve=
ry
easy to miss a subtle case and end up with non-zero sleep_delta within an a=
tomic
context for some rare condition that then is hard to debug.

As for making read_poll_timeout() return a error with zero sleep_delta, I d=
on't
see a reason to do that. If a driver wraps read_poll_timeout() in its own
function that sometimes sleeps and sometimes does not, based on some condit=
ion,
but is never called from atomic context, that's fine.

> Drivers which need busy-loop (without even udelay) can
> call read_poll_timeout_atomic() with zero delay.

It's not the zero delay or zero sleep_delta that makes the difference  it's
really the fact the one can be called from atomic context and one can't be.

