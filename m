Return-Path: <netdev+bounces-179028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00789A7A16F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E1518961B0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCB24A07E;
	Thu,  3 Apr 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxA0WqbV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D92E3385;
	Thu,  3 Apr 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677696; cv=none; b=pV0NbWrVFi3XtxnC+RQ9rzb2FYeJDdQ9Q2JZCQjs3qmGhxrSBtCUpQVk3OsLLMUriSoJT86zfUJavHdjp5fs5qCB/Srhq4PNQSMzi+PC+jMIfllpwxahPubblKGWUrJK7XqvQuLlPynFNPqIgKEjrVoNKbLwT1H9nDR1gfXfyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677696; c=relaxed/simple;
	bh=QvBZ5cyCcgLfkLnVqPUR4UnS84sKWcyrUwMg47MI12g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbiyGhQPx5rAVoiGMRsSy8T2RTOMyzs02vfLBofspyPeB5X/64b69c7KSNlwh6dt/zvRFiAAexgsEw54kLBT7bZ/cUywxDfubC3VSwSSxssqVXuWi0AVnJZgkldLPnpeYP7zBXPe0FP6TbNvjJXj5WitcDNer+NZRVU+2yKhyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxA0WqbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CB6C4CEE3;
	Thu,  3 Apr 2025 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743677694;
	bh=QvBZ5cyCcgLfkLnVqPUR4UnS84sKWcyrUwMg47MI12g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FxA0WqbVF19+zdRqfr6x5kfvdJ8YdjP5uyJ2p/z4+2NiyereeXESF4KB5CIT/cGuB
	 vy96fQVrYb8WDNyGbxsJdY9Z7EuuES/q7zhfI+Yc5tnjm8X1oQV11oCGUzENisE1UH
	 21tYkCZR5jKvNbubvUvnlFne3vi7PebKAezEvhyJcxjI2WCKrkBrOp6sstJqK/YHU7
	 RUOFM/8J56RwjotFNqTAse1EpXvh+t+yR4rf562VwgPQJh+V8flTcU3ZkoZ7cveb0s
	 3Omkr0evvEnoHJrnq/3b+V5R+9w22p41h/lc3DglBBa7/eVg2JlXKKsWOBzFxDXAZo
	 6aGSBZjCuIDIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <boqun.feng@gmail.com>,  <tglx@linutronix.de>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,
  <tmgross@umich.edu>,  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <a.hindborg@samsung.com>,
  <aliceryhl@google.com>,  <anna-maria@linutronix.de>,
  <frederic@kernel.org>,  <arnd@arndb.de>,  <jstultz@google.com>,
  <sboyd@kernel.org>,  <mingo@redhat.com>,  <peterz@infradead.org>,
  <juri.lelli@redhat.com>,  <vincent.guittot@linaro.org>,
  <dietmar.eggemann@arm.com>,  <rostedt@goodmis.org>,
  <bsegall@google.com>,  <mgorman@suse.de>,  <vschneid@redhat.com>,
  <tgunders@redhat.com>,  <me@kloenk.dev>,  <david.laight.linux@gmail.com>
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
In-Reply-To: <20250403.171809.1101736852312477056.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Thu, 03 Apr 2025 17:18:09 +0900")
References: <RGjlasf3jfs3sL9TWhGeAJxH0MNvvn0DDqGl9FVo2JNvwTDpUqrr_V515QzLaEp0T4B1m6PJ0z7Jpw1obiG58w==@protonmail.internalid>
	<Z-qgo5gl6Qly-Wur@Mac.home> <87ecyd3s09.fsf@kernel.org>
	<RK_ErPB4YECyHEkLg8UNaclPYHIV40KuRFSNkYGroL8uT39vud-G3iRgR2a7c11Sb7mXgU6oeb_pukIeTOk9sQ==@protonmail.internalid>
	<20250403.171809.1101736852312477056.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 03 Apr 2025 12:54:40 +0200
Message-ID: <877c41v7kf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Mon, 31 Mar 2025 21:43:50 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>>>> If that is acceptable to everyone, it is very likely that I can pick 2-6
>>>> for v6.16.
>>>>
>>>
>>> You will need to fix something because patch 2-6 removes `Ktime` ;-)
>>
>> Yea, but `Instant` is almost a direct substitution, right? Anyway, Tomo
>> can send a new spin and change all the uses of Ktime, or I can do it. It
>> should be straight forward. Either way is fine with me.
>
> `Delta`? Not `Instant`.

It depends. Current hrtimer takes `Ktime` and supports
`HrTimerMode::Absolute` and `HrTimerMode::Relative`. With `Delta` and
`Instant` we should take `Instant` for `HrTimerMode::Absolute` and
`Delta` for `HrTimerMode::Relative`. The API needs to be modified a bit
to make that work though. Probably we need to make the start function
generic over the expiration type or something.

If you want to, you can fix that. If not, you can use `Instant` for the
relative case as well, and we shall interpret it as duration. Then I
will fix it up later. Your decision.

> All Ktime in hrtimer are passed to hrtimer_start_range_ns(), right?

Yes, that is where they end up.

> I'll send a new version shortly.

Great :)


Best regards,
Andreas Hindborg



