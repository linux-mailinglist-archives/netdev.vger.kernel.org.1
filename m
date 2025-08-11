Return-Path: <netdev+bounces-212430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CDB203FF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F75F16E7DE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31122425E;
	Mon, 11 Aug 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo6PFPZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDD221F09;
	Mon, 11 Aug 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905377; cv=none; b=mx77MWB35cVPuFaa99L3IGJpSq4TQKKPXmrbQ2J+D1zorIKMPwRLr6VpzpMJihaP9rKSC8KJgmYmCCm8Pkw0XE4H0yynnYC42xdRjqQ/sBit9v0kb9S9DxVvqmWOb8wo6WuTtrVeQmYiu5jOFW4n0hmdYlTC6sD1G6mZPSu2BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905377; c=relaxed/simple;
	bh=8FokdP0RSTBt/P39LgCOsTHUzPcgNeFkIbO8ny7/gHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1mh5WemhnG3HMDwraNdnZPEUhSm2c8xL0IZDtmMvkLcejQDV9NyQPOXirV1VK65SNcynWjowMwv3HqZ3Om/JW4son/Rod0XJ320WhuUkZ4S8E271lLLKnbCmgFTFLDPNaZe7HxFrcUKA4ymGhcAJc3FVIwvVEgI/341fBT7wPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo6PFPZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD69CC4CEED;
	Mon, 11 Aug 2025 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905376;
	bh=8FokdP0RSTBt/P39LgCOsTHUzPcgNeFkIbO8ny7/gHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Wo6PFPZPWIoLRqTcUjCqZWuW1JRj0D5QnDYKQJnmsoowl1vqXn6XkhgpZSmqsYQjd
	 Z8GJTfCkX/lvVgliu7tFxxXV2qUJmPtpvJoa85qupVFFL+e+qQvcC4tqcS9Vc6rLt3
	 8Vm14wt7qw3V3W227z0710YY4LPRfG93Qw5Yz+4nowbkKXvjLM/8jMf3aD9n3tP3HA
	 6FSFbULISznTBUCva1JjrALegBb53z9rJnBxeZAfPFnpjJgDMfMGv5Fi0LvC/aLUjV
	 vb88PgaoYoG162Xgd1erIBCRLnEKg07HNyv7THE8kfXtGL/Tlr+PvvXwhY321UeEn1
	 zgDBJWQFFKx6g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
In-Reply-To: <20250811.105320.1421518245611388442.fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
 <87y0wx9hpk.fsf@kernel.org>
 <huGw-FNRjvsPJK5CIsoI3puxml780Rr5GbJB6xg92PGzQOCMRTwC_utxTpn8u7G1sNjqq35iWOTNANpVUuip4w==@protonmail.internalid>
 <20250811.105320.1421518245611388442.fujita.tomonori@gmail.com>
Date: Mon, 11 Aug 2025 11:42:46 +0200
Message-ID: <878qjqgpnt.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Sorry, I somehow missed this email.
>
> On Sat, 22 Mar 2025 17:02:31 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>>> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
>>> +///
>>> +/// It also happens to serve as a compiler barrier.
>>> +pub fn cpu_relax() {
>>> +    // SAFETY: FFI call.
>>
>> I don't think this safety comment is sufficient. There are two other
>> similar comments further down.
>
> Updated the comment.
>
>>> +/// ```rust
>>> +/// use kernel::io::poll::read_poll_timeout;
>>> +/// use kernel::time::Delta;
>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>> +///
>>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>>> +/// let g = lock.lock();
>>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>>> +/// drop(g);
>>> +///
>>> +/// # Ok::<(), Error>(())
>>> +/// ```
>>
>> I am guessing this example is present to test the call to `might_sleep`.
>
> I also guess so. Boqun wrote this test, IIRC.
>
>> Could you document the reason for the test. As an example, this code is
>> not really usable. `#[test]` was staged for 6.15, so perhaps move this
>> to a unit test instead?
>>
>> The test throws this BUG, which is what I think is also your intention:
>
> might_sleep() doesn't throw BUG(), just a warning. Can the test
> infrastructure handle such?

As I wrote, kunit does not handle this. But I am confused about the
bug/warn comment. The trace I pasted clearly says "BUG"?

I think we should just remove this test for now.


Best regards,
Andreas Hindborg



