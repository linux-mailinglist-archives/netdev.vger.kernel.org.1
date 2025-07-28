Return-Path: <netdev+bounces-210523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ADB13CDF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B999E188ECE7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2A26B76D;
	Mon, 28 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ByPwtBx8"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BF252906;
	Mon, 28 Jul 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712122; cv=pass; b=EKZGWmRKHTavhPa+e+f2ae0lPQTpySA+7Ex9e8Pdukuo7dlyLqJnLgDpzzqQFLZsDcrlYDalynGv8nPi2z6E3MrptEG+ckhZkliji0Js6SEl3Zr2YpvVmB780OYlps7mBkeTMxoTFouEwuvgtqa31v+fAhZvN7tju3Q3M7bUEuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712122; c=relaxed/simple;
	bh=18UOAEAJa0QBGkE9soJxN5IaPz6epEeCDUabYCLZGq0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s5jxlzzYgJmcfjyChyehQbt+wmHO3p39HUecLofvx4kAOjnI83RYVwyyIdr1aBAHD4VF2+pxsHq2BJ7Kaepg11oLZQOwYyoT3YQ1hL+S9gPwpvDLh5xMmsGh/l5Oii0ZvDgZZWXJTsBBgDLAIfckxZ/Yf8znZjLffDudRtFiYXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ByPwtBx8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753712051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VSBt/Lta3NtK3y4Qbh4pg7Np2VwKJsWGmbT1voONBZXst3PP9n7FOD2CQFdNF5tmVERfo+y9cFdMJc1bzWvrhaZDVyNJKs2KDwa66tKrweH+1MIuS1pgcxf3Kdv8+eZE3KEE+LcP+UH3v25eBOui3/0tpq2Po9SseoH1ZyEp0Kw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753712051; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=18UOAEAJa0QBGkE9soJxN5IaPz6epEeCDUabYCLZGq0=; 
	b=dtsz/28z6H8kQP0QH2Z3qokbA6+crD912fzWn92AnIjtZemyrOeCQYlljjJncNEe2Du5Xf/zBtYJkK/fFYvYl442rEQ1pxqrN9qnXgSDJdGS5gda6kYROfptH8d8Dnt/6ry1q84gR8XkSw9Kmg0NtadpO3waFwhICv6iv0wrPhw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753712051;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=18UOAEAJa0QBGkE9soJxN5IaPz6epEeCDUabYCLZGq0=;
	b=ByPwtBx8ZGi7y1qdEtOgN/4NjCH22LsuQhRxIOoOl8RJO2j88vVHWaCRwSSYf373
	eM6HpGnnYnJqF8/R/yiDp3YWRPpEKbCUmYdtd1cwU4915cx1IpGouNWWD8jZN7drLIW
	uRfulYayWoJyJQTX//6BvV0IiKgW1A9WiRnxKatA=
Received: by mx.zohomail.com with SMTPS id 1753712048618401.65548325429154;
	Mon, 28 Jul 2025 07:14:08 -0700 (PDT)
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
In-Reply-To: <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>
Date: Mon, 28 Jul 2025 11:13:46 -0300
Cc: kernel@dakr.org,
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
 david.laight.linux@gmail.com,
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C846EE5-6B1F-426C-A18F-88003EA6F9BC@collabora.com>
References: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
 <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
 <6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
 <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 28 Jul 2025, at 10:08, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> On Mon, 28 Jul 2025 14:57:16 +0200
> Danilo Krummrich <kernel@dakr.org> wrote:
>=20
>> On 7/28/25 2:52 PM, FUJITA Tomonori wrote:
>>> All the dependencies for this patch (timer, fsleep, might_sleep, =
etc)
>>> are planned to be merged in 6.17-rc1, and I'll submit the updated
>>> version after the rc1 release.
>>=20
>> Can you please Cc Alex and me on this?
>=20
> Sure.
>=20
> read_poll_timeout() works for drm drivers? read_poll_timeout_atomic()
> are necessary too?

Tyr needs read_poll_timeout_atomic() too, but I never really understood
if that's not achievable by setting sleep_delta=3D=3D0, which skips the
call to fsleep().

=E2=80=94 Daniel=

