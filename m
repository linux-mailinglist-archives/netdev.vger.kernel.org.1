Return-Path: <netdev+bounces-184604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C797A9659B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F07A5793
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FB214A94;
	Tue, 22 Apr 2025 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNMvgoMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699F214815;
	Tue, 22 Apr 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316778; cv=none; b=H6q08drlIXGiXDLO23X/ITJPIOAFPw0iMv99ibEmXkWl6MQnsbpqASrsvSJDYJaIJsWAEdhVsMl0LYRFgOQ+MGhf8y1i0ByTWKAaEy3pwUrRREkGXv93UQT4+4X3RpgMu35CVF1eefKfI8BiVLWcorVrAMIKMIWBjaIceq7duuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316778; c=relaxed/simple;
	bh=zBdyi2R9Lkw9tHEasbCLnDpaXuNn2xb91rzlh3ywO7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1dGHTBOF4OsKfYW1aH223NAGU7VVs2ZEhX6wPtciLAZnyjmWt/kpao4vgTkjHu7x6vyrbAEVYqrOn5p2svqdVaM+l/kDlPSmsXjonOnlJaJD1Yx3McRQyIBWLsONxzIT19K7Cddr+SsHYUrvxEIv1iLa6/UlX3m9ZBJdfu2+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNMvgoMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AABC4CEEF;
	Tue, 22 Apr 2025 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745316777;
	bh=zBdyi2R9Lkw9tHEasbCLnDpaXuNn2xb91rzlh3ywO7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FNMvgoMXoicOi9N84cvWyw/627EaP8c/B31+dwNTir3+vDFFnUMa/ByaMeQwif1q/
	 cpwBKO7JICYSqToP6NBIVY0+CwS7ZDPhBOH3+pfHRlJOzNIXxp3tf+qMHhGxpVnBVb
	 uyvff7dkuRT2Lk2es+0uP+Mny5VjkTpJ6i+k19kW3NPk0+qFMR3KcyBlfBFGv3CIKb
	 dQxvXSgDSyuhIgOF8xXlLnlIDTmHDEawIXsKujv59qPZFvzAPMUwJRZ5i1grkIpwXu
	 3hNtz+UO6dHqEjm9FkaKSe0HCQYar8sZWoxp1J936PHU/1x17BGmj92kQ+TmHjDlCU
	 0xniIqxVIShnA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <boqun.feng@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <gary@garyguo.net>,  <me@kloenk.dev>,  <daniel.almeida@collabora.com>,
  <linux-kernel@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,  <tmgross@umich.edu>,
  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <bjorn3_gh@protonmail.com>,  <benno.lossin@proton.me>,
  <a.hindborg@samsung.com>,  <aliceryhl@google.com>,
  <anna-maria@linutronix.de>,  <frederic@kernel.org>,
  <tglx@linutronix.de>,  <arnd@arndb.de>,  <jstultz@google.com>,
  <sboyd@kernel.org>,  <mingo@redhat.com>,  <peterz@infradead.org>,
  <juri.lelli@redhat.com>,  <vincent.guittot@linaro.org>,
  <dietmar.eggemann@arm.com>,  <rostedt@goodmis.org>,
  <bsegall@google.com>,  <mgorman@suse.de>,  <vschneid@redhat.com>,
  <tgunders@redhat.com>,  <david.laight.linux@gmail.com>
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
In-Reply-To: <20250416.124624.303652240226377083.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Wed, 16 Apr 2025 12:46:24 +0900")
References: <87lds3cjgx.fsf@kernel.org>
	<20250414.205954.2258973048785103265.fujita.tomonori@gmail.com>
	<67fe9efe.d40a0220.aa401.b05f@mx.google.com>
	<E9nr7KtdtfgTx8OzOOMM6dg3LRl1-BqtqXj6-tGosNOz6Gi2PvOpoyiiqPGv_9nL8hfBOcnCbGP-LfBKIjlV9A==@protonmail.internalid>
	<20250416.124624.303652240226377083.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 22 Apr 2025 12:07:02 +0200
Message-ID: <87cyd4bjcp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Tue, 15 Apr 2025 11:01:30 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
>> On Mon, Apr 14, 2025 at 08:59:54PM +0900, FUJITA Tomonori wrote:
>>> On Mon, 14 Apr 2025 09:04:14 +0200
>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>
>>> > "Boqun Feng" <boqun.feng@gmail.com> writes:
>>> >
>>> >> On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
>>> >>> Introduce a type representing a specific point in time. We could use
>>> >>> the Ktime type but C's ktime_t is used for both timestamp and
>>> >>> timedelta. To avoid confusion, introduce a new Instant type for
>>> >>> timestamp.
>>> >>>
>>> >>> Rename Ktime to Instant and modify their methods for timestamp.
>>> >>>
>>> >>> Implement the subtraction operator for Instant:
>>> >>>
>>> >>> Delta = Instant A - Instant B
>>> >>>
>>> >>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>> >>
>>> >> I probably need to drop my Reviewed-by because of something below:
>>> >>
>>> >>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> >>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>>> >>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> >>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> >>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> >>> ---
>>> >> [...]
>>> >>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> >>> index ce53f8579d18..27243eaaf8ed 100644
>>> >>> --- a/rust/kernel/time/hrtimer.rs
>>> >>> +++ b/rust/kernel/time/hrtimer.rs
>>> >>> @@ -68,7 +68,7 @@
>>> >>>  //! `start` operation.
>>> >>>
>>> >>>  use super::ClockId;
>>> >>> -use crate::{prelude::*, time::Ktime, types::Opaque};
>>> >>> +use crate::{prelude::*, time::Instant, types::Opaque};
>>> >>>  use core::marker::PhantomData;
>>> >>>  use pin_init::PinInit;
>>> >>>
>>> >>> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
>>> >>>
>>> >>>      /// Start the timer with expiry after `expires` time units. If the timer was
>>> >>>      /// already running, it is restarted with the new expiry time.
>>> >>> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
>>> >>> +    fn start(self, expires: Instant) -> Self::TimerHandle;
>>> >>
>>> >> We should be able to use what I suggested:
>>> >>
>>> >> 	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/
>>> >>
>>> >> to make different timer modes (rel or abs) choose different expire type.
>>> >>
>>> >> I don't think we can merge this patch as it is, unfortunately, because
>>> >> it doesn't make sense for a relative timer to take an Instant as expires
>>> >> value.
>>> >
>>> > I told Tomo he could use `Instant` in this location and either he or I
>>> > would fix it up later [1].
>>> >
>>
>> I saw that, however, I don't think we can put `Instant` as the parameter
>> for HrTimerPointer::start() because we don't yet know how long would the
>> fix-it-up-later take. And it would confuse users if they need a put an
>> Instant for relative time.
>>
>>> > I don't want to block the series on this since the new API is not worse
>>> > than the old one where Ktime is overloaded for both uses.
>>
>> How about we keep Ktime? That is HrTimerPointer::start() still uses
>> Ktime, until we totally finish the refactoring as Tomo show below?
>> `Ktime` is much better here because it at least matches C API behavior,
>> we can remove `Ktime` once the dust is settled. Thoughts?
>
> Either is fine with me. I'll leave it to Andreas' judgment.
>
> Andreas, if you like Boqun's approach, I'll replace the third patch
> with the following one and send v14.
>
> I added Ktime struct to hrtimer.rs so the well-reviewed changes to
> time.rs remain unchanged.

OK, Let's keep Ktime for hrtimer for now. I am OK with you putting
`Ktime` in `hrtimer.rs` but you could also put it in time.rs. If you
don't want to modify the patches that already has reviews, you can add
it back in a separate patch.

Either way we should add a `// NOTE: Ktime is going to be removed when
hrtimer is converted to Instant/Duration`.


Best regards,
Andreas Hindborg



