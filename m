Return-Path: <netdev+bounces-166770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53EA37418
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90ADD7A2F7D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B618FC79;
	Sun, 16 Feb 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="FuWyuDv9"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40D78F35;
	Sun, 16 Feb 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739708433; cv=pass; b=fJJZ87Uzub55mmhS6EfLihd0gGtgMdYL2LsJuBDj0GZu4N+gZ11+MlporR74UNZ39Ge/j8Z3Uz5SAjco7twVtG2PDl8gH65EmIK9Zy9QfdVd0C/HZ0JkpaJERxCYjtW4qy8/bEpQ6P8Vy8HYEVhOnmoBM+f7XlPQVY/41AuxaK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739708433; c=relaxed/simple;
	bh=LbvpX3NhMCUuvlS904PefdpjdyT0o4fW0FbuMpmkNMg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q6WoEV/D2WieCU0SpesWmc5LSR7uJtbrvTzLghjBW8E+vppT9A0cWFd4zGv2t8AfzFoCwKpntgAZzrTF4mG3Hnh+d2hmus2KAkCkyQlNedPEYKams90HbpjfeAI/VdH5gisIvFcg6HhMIsNS3y0wODv5/WMnxChmZGjHNWMbnf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FuWyuDv9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739708367; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NaqjREJQI/zRnVhI0c4eA79lhexcRcnhBvZwpVFG20//Ufz2ei6oX/ZrNdVKB3aoJPoHUgD01zWcfOWJJ/PdSJcihcKElSM/o3zVtwPcpltAlGIz9jkNA2oSKvanWAwx0/+eICuCNKHvKCeloCgoyIsGxIbb9pYrC2/7CTQYusY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739708367; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dUAN2vu7UIPXPb6wThOp1wBHlvZsTy/ndrn6Hqibs2U=; 
	b=kBp3BHX2txtvQRjFd3vSdShraloAPFGc7ZhomGIALXUzL9FhddZvkIjVEHSI1u91bVN83Fac4JLjqKXUnGg1kzJsrOWmu61FnY8oQpQvnXFvpR/fcMZl27lOqnKLeVfqNrF2cphmTj5o8zNLimeaVaPwqqzNuSdzxlZM1my47es=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739708367;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=dUAN2vu7UIPXPb6wThOp1wBHlvZsTy/ndrn6Hqibs2U=;
	b=FuWyuDv9TLn31A4QSW+7EizchDpR4ftscqgOovD/U/oz8pd2Id8ieHONoqZZ47zj
	Nd05Qcs0WiZgqvWpQG++j/KzLMmOIAgWjxeefX2fKJL2sXXO6qkVSb6biFKka3WimIo
	D+4LXCKWnWt+1bOlOpEIS3keDi8hGcQspyTdBzAc=
Received: by mx.zohomail.com with SMTPS id 1739708364340992.9290060619647;
	Sun, 16 Feb 2025 04:19:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250214.131330.2062210935756508516.fujita.tomonori@gmail.com>
Date: Sun, 16 Feb 2025 09:19:02 -0300
Cc: linux-kernel@vger.kernel.org,
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
 me@kloenk.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEF87294-8580-4C84-BEA3-EB72E63ED7DF@collabora.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
 <20250207132623.168854-8-fujita.tomonori@gmail.com>
 <3F610447-C8B9-4F9D-ABDA-31989024D109@collabora.com>
 <20250214.131330.2062210935756508516.fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Sorry, ended up replying privately by mistake, resending with everybody =
else on cc:

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94


> On 14 Feb 2025, at 01:13, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> On Fri, 7 Feb 2025 22:50:37 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
>>> +/// Polls periodically until a condition is met or a timeout is =
reached.
>>> +///
>>> +/// ```rust
>>> +/// use kernel::io::poll::read_poll_timeout;
>>> +/// use kernel::time::Delta;
>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>> +///
>>> +/// let lock =3D KBox::pin_init(new_spinlock!(()), =
kernel::alloc::flags::GFP_KERNEL)?;
>>> +/// let g =3D lock.lock();
>>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), =
Some(Delta::from_micros(42)));
>>> +/// drop(g);
>>> +///
>>> +/// # Ok::<(), Error>(())
>>=20
>> IMHO, the example section here needs to be improved.
>=20
> Do you have any specific ideas?
>=20
> Generally, this function is used to wait for the hardware to be
> ready. So I can't think of a nice example.

Just pretend that you=E2=80=99re polling some mmio address that =
indicates whether some hardware
block is ready, for example.

You can use =E2=80=9Cignore=E2=80=9D if you want, the example just has =
to illustrate how this function works, really.

Something like

```ignore
 /* R is a fictional type that abstracts a memory-mapped register where =
`read()` returns Result<u32> */
 fn wait_for_hardware(ready_register: R) {
     let op =3D || ready_register.read()?

     // `READY` is some device-specific constant that we are waiting =
for.
     let cond =3D  |value: &u32| { *value =3D=3D READY }

     let res =3D io::poll::read_poll_timeout (/* fill this with the =
right arguments */);

     /* show how `res` works, is -ETIMEDOUT returned on Err? */

     match res {
       Ok(<what is here?>) =3D> { /* hardware is ready */}
       Err(e) =3D> { /* explain that *value !=3D READY here? */ }

     /* sleep is Option<Delta>, how does this work? i.e.: show both =
None, and Some(=E2=80=A6) with some comments. */
 }=20
```

That=E2=80=99s just a rough draft, but I think it's going to be helpful =
for users.

=E2=80=94 Daniel=

