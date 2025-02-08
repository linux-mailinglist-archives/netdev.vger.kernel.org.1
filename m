Return-Path: <netdev+bounces-164269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8259A2D2C2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A2C16B0F7
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762E13C690;
	Sat,  8 Feb 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="WlMkGvY9"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC82125D6;
	Sat,  8 Feb 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738979546; cv=pass; b=gOoq/Cr2aVk3OFnTphdextmNSstadbCih2qVRnAtgKXQAbHEcWv1gfhrR50eqNsLpPNcdFeNDXND627ED/6PxcAmu75P3UsZk/Nlf2G7pzxsCo5IGWNXkUoGkdM/h1FaF92JqT1DD41BRURuQ0AQ0h5ctdf7uhLkq3XSnWLZfBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738979546; c=relaxed/simple;
	bh=T+OfHvGj/ItJulWwCxdDM20dP4A51QzDsoFZS5fuvUQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ah28NR5Igg8zy8CEmNsqKtpunAci2Nj19Wu6QhESECe04/KS1czIWzWFoTQFlhaBYXpUbMIPr/msKQrkmTuEGD+iYJiERk48G3AA6PS+VZNa1/LP6eGAq/KNUK7A63T+5sqT+VqgwjcmhoEaykWcyyt7srHT0uf0EriEVmi3dl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WlMkGvY9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738979461; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h2CVmME1bLtWs+lpPIUCddGbm75QUXyJduwQf2mWQqFO/uI5E0iZgWKVeMLNTe6UfHPvw9Qcu5m0p7bhP9Zr1Be6Tj4VUWPIx8c4ndS8Ts3uqSYO80thvKE+hqW1a/HWi12crxerRWw9YBNR9amrJAyhItRCMJButAip0Gqu0aQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738979461; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PnQQ74qGW3nrr9Iyl/h1mVaZVFhV1V7cZJEYI5JlgG8=; 
	b=cqAt0nrq/GcU6kEGElDS7vQX/ta0nrCRZs0lMHqXdH9Eh6l9mWjVUN0CrBNG07ANlRUFL17MXeg+D800kK/G595HRG3PkUmNluEr7fBga03szDXOEKdCfty/N22ap9jzft8H6H6YPRfqQe74dqRySKEdKiayvXDEqU2Zr/Ns5ec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738979461;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=PnQQ74qGW3nrr9Iyl/h1mVaZVFhV1V7cZJEYI5JlgG8=;
	b=WlMkGvY9HbEJdFULa/KOJp5WUFvpRz9192iI+n7Pq0RS5agXtuoFSiksyK3sbGiJ
	E97n8aE4MsZTtA6bwjxtnqv8f8xOtB+3A2YFfC2XHRsH+M9BjUBsmu29FnjD4RgL/m7
	Tj+8TmarbsOdpO9zVLX9miRCgZd5aGskP/9Usi4Q=
Received: by mx.zohomail.com with SMTPS id 1738979455913786.8061412149839;
	Fri, 7 Feb 2025 17:50:55 -0800 (PST)
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
In-Reply-To: <20250207132623.168854-8-fujita.tomonori@gmail.com>
Date: Fri, 7 Feb 2025 22:50:37 -0300
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
Message-Id: <3F610447-C8B9-4F9D-ABDA-31989024D109@collabora.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
 <20250207132623.168854-8-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi,

> +
> +/// Polls periodically until a condition is met or a timeout is =
reached.
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock =3D KBox::pin_init(new_spinlock!(()), =
kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g =3D lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), =
Some(Delta::from_micros(42)));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())

IMHO, the example section here needs to be improved.

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
> +        might_sleep(Location::caller());
> +    }
> +
> +    loop {
> +        let val =3D op()?;

I.e.: it=E2=80=99s not clear that `op` computes `val` until you read =
this.

> +        if cond(&val) {

It=E2=80=99s a bit unclear how `cond` works, until you see this line =
here.

It=E2=80=99s even more important to explain this a tad better, since it =
differs slightly from the C API.

Also, it doesn=E2=80=99t help that `Op` and `Cond` take and return the =
unit type in the
only example provided.

=E2=80=94 Daniel


