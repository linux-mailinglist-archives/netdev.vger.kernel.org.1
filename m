Return-Path: <netdev+bounces-161295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DBCA2085D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE96F1884777
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506719AD90;
	Tue, 28 Jan 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="XxHz6jj5"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA74D51C;
	Tue, 28 Jan 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059520; cv=none; b=GKuR0oLaR+9Wae5EM4AXZwuIOqKbz1TJWTaGmOt3GUhhYPyjQzvc3rc80cpu3lrO3zzBknQyWy7YzxPNCyhPYFd64ZdTHSTIyE4E8UHGY6/C2GpnpJCWVWaOWsehj74m9deznY/ucduw+nkQzurucJQeYPburTU2RQi09JpVlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059520; c=relaxed/simple;
	bh=nbgNh2ka8IGioFY5l48FKQbMi5djBS7+tJU1H8GW7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUzm7UlVAo+pIkePWf3VvnvxprNa6zl/lwpFFyY8leuL4i/kArvI7UFFP0Y3YzA0PTbDKActV0lQ6p7e69T31a5oB84fQIq5kAn6+72Xi3kDyQ7w+4XtoW56W7WKRMeB2kon5f2sJaPQOTCAi2wVRYI5ELHcec2UTV2YuiWLS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=XxHz6jj5; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738059505; bh=nbgNh2ka8IGioFY5l48FKQbMi5djBS7+tJU1H8GW7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxHz6jj5E3xJe5oXjFMWqxaHRMaup2u9uWcuPIRmBVd8WjIORJUGHJz3akkUXyqJW
	 beId+c5/O2KmW8ClJLesAvYb/gHQHC6PIgNIC/PowJvnE/Jdp3v3cDoY9NFQ8H24e2
	 F/ElPgkGE807lPntharF9gueap923/L/t/44/YtY=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
 Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 2/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait
 to Ktime
Date: Tue, 28 Jan 2025 11:18:23 +0100
Message-ID: <7E7757E3-03BE-4110-A099-5D16ECD34C55@kloenk.dev>
In-Reply-To: <20250125101854.112261-3-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jan 2025, at 11:18, FUJITA Tomonori wrote:

> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because it is more efficient and we already do
> in the existing code (Ktime::sub).
>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

