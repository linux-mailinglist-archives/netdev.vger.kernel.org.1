Return-Path: <netdev+bounces-210507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE895B13AB7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B9E3B5A92
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF3265298;
	Mon, 28 Jul 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="d2TpskC8"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039413D51E;
	Mon, 28 Jul 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706787; cv=pass; b=fO3lTkUIQSsM1QHJ60t1wYGHEtMVQvwDWL7WNmSr+i9nmu729K1z7du1AKQCppC5c3mE/UVsd1ecOTvd+8UCP6ahbPMUj5Mhb1dhhhht5c1ss3tAiuT1Vf5pjeHkXtgliJb9ATz38yd6yvrXSreVTgslAsCZy/DlEWIlM8GHEFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706787; c=relaxed/simple;
	bh=kV8CJI/+KnMlti7TMONXwOLw9gZXIDDlxj16Vo3N7eY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lCGZYLRbCF38E17gbNyxztqMXO3x8YmfohJHFvDR1YQbUgvT+0c3npj/lJJHo1DnnhXYnIGloKn9k5MnwoOjveMRhotShzuYVKuVnlYctxe99KgDuFULMRIH1mTzV+zq2kCcEn4rN7Vpo5p/+IPOdiaZXuWP5XAaU+9QpGx6UEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=d2TpskC8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753706704; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jtdd1t1JN/f4Z96MpnLWjYbm85CyGjLA3c1VeRZEwmeZT0ax+rFOx1jbHw7uwmcEOToL5l/+wd9SW18SBQNkckeu0uKIj4fHrQuuW3gGcHabn58EMRaF2J1ub41c72kfkGNP/yxD+/YV91pn0ULK49IK+kapjRbC5Oe1sSA9KOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753706704; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kV8CJI/+KnMlti7TMONXwOLw9gZXIDDlxj16Vo3N7eY=; 
	b=RoIDKrmGatcUCMkxBtBtwjorlqQ1TIUHDX+kEZbxTCNvDuwpaG22d0TX72a9q3X2CBiIXcRVHO0pdtiIbyAcX4SC3H0gKeiOPDMle6I6AWW3Dhrr4s2uhaW17+I7ITutnravNd3EwGWBKYKcvqomhN8jhxIqpsgdyJ1dcC7EAPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753706704;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kV8CJI/+KnMlti7TMONXwOLw9gZXIDDlxj16Vo3N7eY=;
	b=d2TpskC8W8Dt/+ME6qROJSfeTd5XSw1E4PiPjd/5VjaB3FSSstCRYKvVfle0y51H
	ifom2Nnto6ENZDftIF7GQ7QOmQIM7w3FvRUY3KB7JpI5//7fLBjMmgOoIHoqW2X6VKL
	bG9kINxg5FGH1Bs2HQ6dp5sNl9LBQajWujeqaegE=
Received: by mx.zohomail.com with SMTPS id 1753706698669132.7674815409531;
	Mon, 28 Jul 2025 05:44:58 -0700 (PDT)
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
In-Reply-To: <20250220070611.214262-8-fujita.tomonori@gmail.com>
Date: Mon, 28 Jul 2025 09:44:39 -0300
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
 me@kloenk.dev,
 david.laight.linux@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Fujita,

> On 20 Feb 2025, at 04:06, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>=20
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>=20
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>=20
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>=20
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>=20
> Link: https://rust-for-linux.com/klint [1]
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

This appears to be the last version of this patch. Do you have any plans =
to
keep working on it? Is there anything I can do to help? :)

If you don=E2=80=99t have the time to work on this, I can pick it up for =
you.

=E2=80=94 Daniel


