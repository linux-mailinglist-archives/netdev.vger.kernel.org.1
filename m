Return-Path: <netdev+bounces-211734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF8B1B5D3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214DD3A1AAB
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BA27AC5A;
	Tue,  5 Aug 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AZKhwYtC"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4D27AC3D;
	Tue,  5 Aug 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402579; cv=pass; b=RbHw6iNXSDfEFquaQT5GW1If+R7mp7H+AZLlN2zFAFrmINqBZTyTa+5l+46h7+x/Iwnj3OVG4EpVODQ1NZPKPOstUDzS1tI3UMg34pPqYXrqllZUEA+f2bkoIvUY6W2gBK4c9m6VKxKqUJJ8xz1nw2IbiU0v54eaqFKyEEOreyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402579; c=relaxed/simple;
	bh=/QgH0A8R3cgOTDRRPLoaPXVvMdgUw/ShCoYTRlnwe5E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=unSgfKy3gxMCnLj58I1BnOWU583kpTDRih8Fe6KwiT4798v9OpAKpf9jRd9sPjmScWRpna9b4i0oIEOzP0DYgy0b7ehJcgPh6GhzTXeTUdYKbu4r/IQ3D0CmSLfWTTb6dGS59qtUeSUNkAzP3c3TT7tbfjaS06UWe0QFzXgUXgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AZKhwYtC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754402506; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nUxhhGeOYWGMSQq4TuGXcvsj5fJLVw6BzO0J2+6PRP7K++lLNSLLyr+hceuGHL1wIvFqdGkri/uKMfzHQFX/QT4eVGVjFWpdkpZz9L0hCDwqJHKRzrQh0z4jwQtQQ4vMxM76jp1x4pLjwtbfXd/+LUw1hNGIFFpFxshpATbOkkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754402506; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JNx5rDCPViP8TmHGLeMc30Mcr6Nu/C+gsNm2VgM8q3k=; 
	b=DEg18Hedavq1UC6n5lcYbEs/BcNWiMYH/y5qRJqCMy7XgVYNKOGsxIwtOq6N9bMVovrxWIKboTDrmN5tV4BWVHbcqeM1+wPKrfW6yniB2cEqY3P9TVSgQp30AlSltVbGIb5I2+cko4oY9RNgajDAVfZtxDs8pahb1EMPeR86shk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754402506;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=JNx5rDCPViP8TmHGLeMc30Mcr6Nu/C+gsNm2VgM8q3k=;
	b=AZKhwYtCEHXknT2qM4gusLK3yM7vzwulKxfcIl1gH9XlLuC6UBdcgo+qUDHxYCWT
	Z2f73JsOnaJwFfNu+hypWleN9q1V1LI6uLP7TPuasyEUD7lQqR2PJNhEmPbhnn1oclO
	H6aMXIVIx7Oswkej9nvjIHb6ihjbJH+FdRsj3TfM=
Received: by mx.zohomail.com with SMTPS id 1754402502293977.7687680728351;
	Tue, 5 Aug 2025 07:01:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
Date: Tue, 5 Aug 2025 11:01:22 -0300
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org,
 andrew@lunn.ch,
 hkallweit1@gmail.com,
 tmgross@umich.edu,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 a.hindborg@samsung.com,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 tglx@linutronix.de,
 arnd@arndb.de,
 jstultz@google.com,
 sboyd@kernel.org,
 mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tgunders@redhat.com,
 me@kloenk.dev,
 david.laight.linux@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCB831D1-8786-41BC-A95B-44F0BEE71990@collabora.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
 <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
 <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 2 Aug 2025, at 08:06, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Sat Aug 2, 2025 at 3:42 AM CEST, FUJITA Tomonori wrote:
>> On Mon, 28 Jul 2025 15:13:45 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>> On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
>>>> +/// This process continues until either `cond` returns `true` or =
the timeout,
>>>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` =
is `None`,
>>>> +/// polling continues indefinitely until `cond` evaluates to =
`true` or an error occurs.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// ```rust,ignore
>>>=20
>>> Why ignore? This should be possible to compile test.
>>=20
>> =
https://lore.kernel.org/rust-for-linux/CEF87294-8580-4C84-BEA3-EB72E63ED7D=
F@collabora.com/
>=20
> I disagree with that. 'ignore' should only be used if we can't make it =
compile.
>=20
> In this case we can make it compile, we just can't run it, since =
there's no real
> HW underneath that we can read registers from.
>=20
> An example that isn't compiled will eventually be forgotten to be =
updated when
> things are changed.
>=20
>>>> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
>>>=20
>>> I think the parameter here can just be `&Io<SIZE>`.
>>>=20
>>>> +///     // The `op` closure reads the value of a specific status =
register.
>>>> +///     let op =3D || -> Result<u16> { dev.read_ready_register() =
};
>>>> +///
>>>> +///     // The `cond` closure takes a reference to the value =
returned by `op`
>>>> +///     // and checks whether the hardware is ready.
>>>> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
>>>> +///
>>>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), =
Some(Delta::from_secs(3))) {
>>>> +///         Ok(_) =3D> {
>>>> +///             // The hardware is ready. The returned value of =
the `op`` closure isn't used.
>>>> +///             Ok(())
>>>> +///         }
>>>> +///         Err(e) =3D> Err(e),
>>>> +///     }
>>>> +/// }
>>>> +/// ```
>>>> +///
>>>> +/// ```rust
>>>> +/// use kernel::io::poll::read_poll_timeout;
>>>> +/// use kernel::time::Delta;
>>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>>> +///
>>>> +/// let lock =3D KBox::pin_init(new_spinlock!(()), =
kernel::alloc::flags::GFP_KERNEL)?;
>>>> +/// let g =3D lock.lock();
>>>> +/// read_poll_timeout(|| Ok(()), |()| true, =
Delta::from_micros(42), Some(Delta::from_micros(42)));
>>>> +/// drop(g);
>>>> +///
>>>> +/// # Ok::<(), Error>(())
>>>> +/// ```
>>>> +#[track_caller]
>>>> +pub fn read_poll_timeout<Op, Cond, T>(
>>>> +    mut op: Op,
>>>> +    mut cond: Cond,
>>>> +    sleep_delta: Delta,
>>>> +    timeout_delta: Option<Delta>,
>>>> +) -> Result<T>
>>>> +where
>>>> +    Op: FnMut() -> Result<T>,
>>>> +    Cond: FnMut(&T) -> bool,
>>>> +{
>>>> +    let start =3D Instant::now();
>>>> +    let sleep =3D !sleep_delta.is_zero();
>>>> +
>>>> +    if sleep {
>>>> +        might_sleep();
>>>> +    }
>>>=20
>>> I think a conditional might_sleep() is not great.
>>>=20
>>> I also think we can catch this at compile time, if we add two =
different variants
>>> of read_poll_timeout() instead and be explicit about it. We could =
get Klint to
>>> catch such issues for us at compile time.
>>=20
>> Your point is that functions which cannot be used in atomic context
>> should be clearly separated into different ones. Then Klint might be
>> able to detect such usage at compile time, right?
>>=20
>> How about dropping the conditional might_sleep() and making
>> read_poll_timeout return an error with zero sleep_delta?
>=20
> Yes, let's always call might_sleep(), the conditional is very error =
prone. We
> want to see the warning splat whenever someone calls =
read_poll_timeout() from
> atomic context.
>=20
> Yes, with zero sleep_delta it could be called from atomic context =
technically,
> but if drivers rely on this and wrap this into higher level helpers =
it's very
> easy to miss a subtle case and end up with non-zero sleep_delta within =
an atomic
> context for some rare condition that then is hard to debug.
>=20
> As for making read_poll_timeout() return a error with zero =
sleep_delta, I don't
> see a reason to do that. If a driver wraps read_poll_timeout() in its =
own
> function that sometimes sleeps and sometimes does not, based on some =
condition,
> but is never called from atomic context, that's fine.
>=20
>> Drivers which need busy-loop (without even udelay) can
>> call read_poll_timeout_atomic() with zero delay.
>=20
> It's not the zero delay or zero sleep_delta that makes the difference  =
it's
> really the fact the one can be called from atomic context and one =
can't be.

Perhaps it=E2=80=99s worth it to clarify that in the docs for the future =
versions?

I feel like =E2=80=9Csleep_delta =3D=3D 0 -> this doesn=E2=80=99t sleep =
-> it=E2=80=99s fine to
use this in an atomic context=E2=80=9D is a somewhat expected thought =
process.
Also, this will lead to the confusion I mentioned, i.e. =E2=80=9Cwhy do =
I need to
use the atomic version if I can pass 0 for sleep_delta?=E2=80=9D

I mean, the added context in this thread explains it, but it=E2=80=99s =
probably
worth it to make sure that the docs also do.

Just my humble opinion.

=E2=80=94 Daniel=

