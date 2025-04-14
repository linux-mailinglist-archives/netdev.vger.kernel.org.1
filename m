Return-Path: <netdev+bounces-182054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF0A87862
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C84016F032
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5051B0439;
	Mon, 14 Apr 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5NT3ooc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908021624CE;
	Mon, 14 Apr 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614278; cv=none; b=Sh7ECoLKk5LgA2akQu7xsskuu50ql+2M0eTn7Uy4svWgrdnDwrW9D4OgAGHiTFqiFNEqKL9OYfUEmxChx1I3Tet7o++3MQBt4s1ib3TOIltCdH4HMX+5SGUyMwYhrxfJgBddXFZxHzr0aJnqITuYLa31Et5hcJN1MBOIvvmcGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614278; c=relaxed/simple;
	bh=e8t9Yt/78Y9gJKGdmcEE+Tpq2s1D34EAKw9+eAeebPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8hYVs+1jDTlB0VEJWgiz/ESS+0fWXfWqW2dObFkZ88J/y54iNlx84aaU5YkiUtWqtuj+Mdg/HKTbyYZ9KUsriJS3x2XZvkPta0vPTPjVMLDdWz2MCBExYJ8Sbh58rLlXBFyN7go1OcNC84/rYZMpLBpEfH364UsuB6Y6do38hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5NT3ooc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE8AC4CEE2;
	Mon, 14 Apr 2025 07:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744614278;
	bh=e8t9Yt/78Y9gJKGdmcEE+Tpq2s1D34EAKw9+eAeebPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q5NT3oocdPwqqKncN8reoub2EWcy4spT2POT/eTUEvYw8X3+fpT5X0+yPGdUmZE/T
	 MJCMTaNroQF3vRg8TWn5ubN5OK/Cmbw5iWXkzNqsJxmvfvTQd/nU6DDSrA9LLvoqzK
	 1ja+o3MdwAiRIcYD7qHNdRFAe4B5vqqVXYpBz0YmPlwHY3Q0qKOEcz62uamiX7rjpL
	 Sx9runKySf8m+A83VzBW+Z40b+11j4bwGdhOdbJZCdJCySUT60cSBKShhGKS1579gq
	 zLhQMbvlCXfrFmpiiATFr1f8dK6QYVvPF16nHBMXVgQFFhiBTWJAlrWEik/G/Rzwfh
	 5Gvt3rDJE+MRg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  "Gary Guo" <gary@garyguo.net>,  "Fiona
 Behrens" <me@kloenk.dev>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <linux-kernel@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,
  <tmgross@umich.edu>,  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
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
In-Reply-To: <67fc517b.050a0220.301460.dfe7@mx.google.com> (Boqun Feng's
	message of "Sun, 13 Apr 2025 17:06:15 -0700")
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
	<20250413104310.162045-4-fujita.tomonori@gmail.com>
	<gfamC5NjhLe9s4hmTvSZ7QKdHWaDanKv8IgocjF5GbeWMHvfFm0bGedvpqm5ZedrHFp-Nl6jEQC3618e3UQRrQ==@protonmail.internalid>
	<67fc517b.050a0220.301460.dfe7@mx.google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 14 Apr 2025 09:04:14 +0200
Message-ID: <87lds3cjgx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
>> Introduce a type representing a specific point in time. We could use
>> the Ktime type but C's ktime_t is used for both timestamp and
>> timedelta. To avoid confusion, introduce a new Instant type for
>> timestamp.
>>
>> Rename Ktime to Instant and modify their methods for timestamp.
>>
>> Implement the subtraction operator for Instant:
>>
>> Delta = Instant A - Instant B
>>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> I probably need to drop my Reviewed-by because of something below:
>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
> [...]
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index ce53f8579d18..27243eaaf8ed 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -68,7 +68,7 @@
>>  //! `start` operation.
>>
>>  use super::ClockId;
>> -use crate::{prelude::*, time::Ktime, types::Opaque};
>> +use crate::{prelude::*, time::Instant, types::Opaque};
>>  use core::marker::PhantomData;
>>  use pin_init::PinInit;
>>
>> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
>>
>>      /// Start the timer with expiry after `expires` time units. If the timer was
>>      /// already running, it is restarted with the new expiry time.
>> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
>> +    fn start(self, expires: Instant) -> Self::TimerHandle;
>
> We should be able to use what I suggested:
>
> 	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/
>
> to make different timer modes (rel or abs) choose different expire type.
>
> I don't think we can merge this patch as it is, unfortunately, because
> it doesn't make sense for a relative timer to take an Instant as expires
> value.

I told Tomo he could use `Instant` in this location and either he or I
would fix it up later [1].

I don't want to block the series on this since the new API is not worse
than the old one where Ktime is overloaded for both uses.


Best regards,
Andreas Hindborg



[1] https://lore.kernel.org/all/877c41v7kf.fsf@kernel.org


