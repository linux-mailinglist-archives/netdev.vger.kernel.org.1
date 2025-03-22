Return-Path: <netdev+bounces-176941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24AA6CCEA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 22:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E093B1E48
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452111E7C08;
	Sat, 22 Mar 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hijyaLZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AC1BC5C;
	Sat, 22 Mar 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680500; cv=none; b=UXp1gcuZT403vTcKIkQNb9fGQBKB4ikYpMnuRnzhhg1cJbT8iVuWUR5gjYNxc+z9OVjQ5w4KYiSNGtBzY+54EpwxF/qh4Z0TnXsNPwLwxYVRTuIUs2ZxxLdJrh0n1b5XDtjyXfbmbRaooYxOZWmYrEOqbu0ho0B5/tBAF0U2Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680500; c=relaxed/simple;
	bh=U71RNqUGZ+Lus/4E2mE5hWToUl3/b+yqzqc/fKz+QTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fct8N0b3btOB9v/2kZn0OAiB6g7AXTmOkU761sCEIkphj3+cnCuumEJ4KbGyvg1S2YGxD5RFp5E6I74n/Qw0wOCWHFCz7yWEAXhTaDjRKwXwA0LGSAt8130XUUN9GkGo5ViJ6vDauUcY3oRrd0zDWTpAjCTHIWGfCyZMA/Wt7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hijyaLZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379E2C4CEE4;
	Sat, 22 Mar 2025 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680500;
	bh=U71RNqUGZ+Lus/4E2mE5hWToUl3/b+yqzqc/fKz+QTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hijyaLZftH9iS/29xIBvicM0ykjnjPGUS3cGeYlej/4P9fD7sJvWkoNswOuyevcjH
	 XfV540VdPyr/lcT9e9qDCIs3nY4rS2NB599gcThSGTDbhkmuJ5MNLnCEg1u7Sy7vsX
	 x7dcZdU5C7F4ZWTmtwSHcK/ADglPKCven2v9pNJsV4nxK7Lkb6EQ7aaSeGoP2k9xFD
	 caMHB9iLEpqacv/TMMBP9Ntpu9QDfFjly0cYXbyFILZCn5t03yxzcVduV3jJkYmp+d
	 aB91bKfjxF+EKwEsy0+jBPvaPb4ZeN0JSIO7AkrFd0jydtsAnaBw6NmrfZw+CATGr0
	 Bvv/PFpoxHiJg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Gary Guo <gary@garyguo.net>,  Alice Ryhl
 <aliceryhl@google.com>,  Fiona Behrens <me@kloenk.dev>,
  rust-for-linux@vger.kernel.org,  netdev@vger.kernel.org,  andrew@lunn.ch,
  hkallweit1@gmail.com,  tmgross@umich.edu,  ojeda@kernel.org,
  alex.gaynor@gmail.com,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,
  anna-maria@linutronix.de,  frederic@kernel.org,  tglx@linutronix.de,
  arnd@arndb.de,  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 5/8] rust: time: Add wrapper for fsleep() function
In-Reply-To: <20250220070611.214262-6-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:07 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-6-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 15:10:17 +0100
Message-ID: <87a59db1h2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

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
>
> Link: https://rust-for-linux.com/klint [1]
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



