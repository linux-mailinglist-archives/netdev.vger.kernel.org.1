Return-Path: <netdev+bounces-186525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444CA9F84C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619727AED49
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8F2951D8;
	Mon, 28 Apr 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8QfYLCf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F61B3934;
	Mon, 28 Apr 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864233; cv=none; b=KVDGDvsXFJ5ekSbAfX0npOsb80Vyw+elakfbu0xGoGQBO8IVwvujHssCAtg+2tnukcCaxR5eH0yYTtJEhlKnRTMzDzlC0oZaTrGd/ZvWifErNQWl2W4dz96Jf1ofCXC8OQo0eTWVaulJhyyLcBlTBdMd8Sf/H03wGFfH4+p3vnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864233; c=relaxed/simple;
	bh=Y1DSDc1Cb+MniuTTVRtcL44FfEn7caDQAAMJwCKlyHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GE3+CSdDkbklvnGGMtf3WF4g6HmbVx57uIFO5uQ2TzdJ05Aeioq2ZhWB1lZbIyuLyXnHYdR99SWceA+sIp8FR+tj/bQ1ucAh7gxljo3yrYsiWRtp1YKcQ/5Sg2jAVFNEY1kKWMVD6nmPaIQQmvLnfZE0SGGwFKFdlxggaJBiTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8QfYLCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9526DC4CEE4;
	Mon, 28 Apr 2025 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864232;
	bh=Y1DSDc1Cb+MniuTTVRtcL44FfEn7caDQAAMJwCKlyHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T8QfYLCfKZRhkunaHwEHeDkJM2azc+73pBQV+8y+O76/a0eltWcJCe5hotrZUkw2T
	 6kcN6XxnJarRXKdiRCx77cNqyUnZL9a4766S+qLHAHxfufcgV7pm/dK9r5JQIqhVUy
	 swwfvYp+ClLv7YjGPvIiHp5TV4vSz/Eew6OnQWDLtn1BOqOiRBNZ4oV/tSQPxIMoFi
	 uTnd4AeLTJig+O7TWCjlotOIbub3Q/Kc7fXtoFywA2PE7NE70Xelb3RzB9P2TmghW5
	 2QTbU2V/V8NLT34vUuvHeIYYWtHyiGofvAXImQiWUEQ5plyBp0WuQvGQi6lu9IrTkP
	 YOvDLeQ6FOrLQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  "Gary Guo" <gary@garyguo.net>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Fiona Behrens" <me@kloenk.dev>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,
  <linux-kernel@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,  <tmgross@umich.edu>,
  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <bjorn3_gh@protonmail.com>,  <benno.lossin@proton.me>,
  <a.hindborg@samsung.com>,  <anna-maria@linutronix.de>,
  <frederic@kernel.org>,  <tglx@linutronix.de>,  <arnd@arndb.de>,
  <jstultz@google.com>,  <sboyd@kernel.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <juri.lelli@redhat.com>,
  <vincent.guittot@linaro.org>,  <dietmar.eggemann@arm.com>,
  <rostedt@goodmis.org>,  <bsegall@google.com>,  <mgorman@suse.de>,
  <vschneid@redhat.com>,  <tgunders@redhat.com>,
  <david.laight.linux@gmail.com>,  <boqun.feng@gmail.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
In-Reply-To: <20250423192857.199712-6-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 24 Apr 2025 04:28:55 +0900")
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
	<6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
	<20250423192857.199712-6-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 28 Apr 2025 20:16:47 +0200
Message-ID: <871ptc40ds.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Tomonori,

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add a wrapper for fsleep(), flexible sleep functions in
> include/linux/delay.h which typically deals with hardware delays.
>
> The kernel supports several sleep functions to handle various lengths
> of delay. This adds fsleep(), automatically chooses the best sleep
> method based on a duration.
>
> sleep functions including fsleep() belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
>
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.

I get an error when building this patch for arm32:

  + kernel-make -j 96 O=/home/aeh/src/linux-rust/test-build-arm-1.78.0 vmlinux modules
  ld.lld: error: undefined symbol: __aeabi_uldivmod
  >>> referenced by kernel.df165ca450b1fd1-cgu.0
  >>>               rust/kernel.o:(kernel::time::delay::fsleep) in archive vmlinux.a
  >>> did you mean: __aeabi_uidivmod
  >>> defined in: vmlinux.a(arch/arm/lib/lib1funcs.o)

Looks like a division function of some sort is not defined. Can you
reproduce?


Best regards,
Andreas Hindborg



