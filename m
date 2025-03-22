Return-Path: <netdev+bounces-176942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C471A6CD02
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A853B1894256
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8561E9B3E;
	Sat, 22 Mar 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csIFGbR7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0711DF72C;
	Sat, 22 Mar 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742683249; cv=none; b=R7mfpxN0U8BxeMtSl7RbphCywXmxqw71CyaUsHmwhZxvGX1IrzpnSW/XXCyopMU7ffuvHZXshhqad0B+lEos5wyhzgxFiMakvsE79bd2rC0X6kLKfy6QXwkZmEXfjJVosgImrFJAGTSgNT670nxXfo9eCXSUCZnSRX+Ch7C6VP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742683249; c=relaxed/simple;
	bh=kaGJw1UN+eBP3ZezlrS616HN8vMDvS2SbeAfdkGtfyU=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=LuIHcScY216tyLn/oBSSWPSqIBOA8F2P2zMdkmCIciHpybXtM4r//2LWv73C9KvBQXNpdbcS65YifpmwmhbgyU6RuFfEB5xS6iKJg3LWLWWjfv6A6fR14qsMJrgdo/M6sgkB6Befqo+PwhY8ZmGFVDuIMy4p56YqkqI8QaJGJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csIFGbR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FB5C4CEDD;
	Sat, 22 Mar 2025 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742683249;
	bh=kaGJw1UN+eBP3ZezlrS616HN8vMDvS2SbeAfdkGtfyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=csIFGbR7M0A7dEy3uy8Zts0U0jDb7wD8qDsOFpPkH50/PQTuuwjSY7kJZMN3T2pyL
	 E0D2fMGpS2rWoof3KuDQ6RS1f3EEW46SRVzlMS/+inRzr/YP4nvB6rmnWfvQlMq60d
	 MfbRqTh0+npCq73qO34o11jfTqCOBUqAdNbEK5B+C7u4H2gnWyMBRqIYNwyNYOIzBr
	 b2SpMf2adOKXJeKykbxZFTVXbiRv0DbJdsNY98YBXygcRCGG+VVuLY2Tl3cNvbtR3w
	 tfcgOEGULR7X5vFaS2ur/nLyGaJ9e26wUOFo6nekS0J9FWOR9347KxZzyHkb3B5JH3
	 c09h0y3klkTxA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,  <tglx@linutronix.de>,
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
In-Reply-To: <Z96zstZIiPsP4mSF@Mac.home> (Boqun Feng's message of "Sat, 22 Mar
	2025 05:57:22 -0700")
Message-ID: <871puoelnj.fsf@kernel.org>
References: <87jz8ichv5.fsf@kernel.org> <87o6xu15m1.ffs@tglx>
	<67ddd387.050a0220.3229ca.921c@mx.google.com>
	<20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>
	<8n9Iwb8Z00ljHvj7jIWUybn9zwN_JLhLSWrljBKG9RE7qQx4MTMqUkTJeVeBZtexynIlqH1Lgt6g0ofLLwnoyQ==@protonmail.internalid>
	<Z96zstZIiPsP4mSF@Mac.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 23:40:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi All,

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Sat, Mar 22, 2025 at 11:07:03AM +0900, FUJITA Tomonori wrote:
>> Thank you all!
>>
>> On Fri, 21 Mar 2025 14:00:52 -0700
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> > On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
>> >> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
>> >> >> Could you add me as a reviewer in these entries?
>> >> >>
>> >> >
>> >> > I would like to be added as well.
>> >>
>> >> Please add the relevant core code maintainers (Anna-Maria, Frederic,
>> >> John Stultz and myself) as well to the reviewers list, so that this does
>> >> not end up with changes going in opposite directions.
>> >>
>> >
>> > Make sense, I assume you want this to go via rust then (althought we
>> > would like it to go via your tree if possible ;-))?
>>
>
> Given Andreas is already preparing the pull request of the hrtimer
> abstraction to Miguel, and delay, timekeeping and hrtimer are related,
> these timekeeping/delay patches should go via Andreas (i.e.
> rust/hrtimer-next into rust/rust-next) if Thomas and Miguel are OK with
> it. Works for you, Andreas? If so...
>
>> Once the following review regarding fsleep() is complete, I will submit
>> patches #2 through #6 as v12 for rust-next:
>>
>> https://lore.kernel.org/linux-kernel/20250322.102449.895174336060649075.fujita.tomonori@gmail.com/
>>
>> The updated MAINTAINERS file will look like the following.
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cbf84690c495..858e0b34422f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10370,6 +10370,18 @@ F:	kernel/time/timer_list.c
>>  F:	kernel/time/timer_migration.*
>>  F:	tools/testing/selftests/timers/
>>
>> +DELAY AND SLEEP API [RUST]
>> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +R:	Boqun Feng <boqun.feng@gmail.com>
>> +R:	Andreas Hindborg <a.hindborg@kernel.org>
>
> ... this "R:" entry would be "M:",
>
>> +R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
>> +R:	Frederic Weisbecker <frederic@kernel.org>
>> +R:	Thomas Gleixner <tglx@linutronix.de>
>> +L:	rust-for-linux@vger.kernel.org
>> +L:	linux-kernel@vger.kernel.org
>
> +T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
>
>> +S:	Maintained
>
> I will let Andreas decide whether this is a "Supported" entry ;-)
>
>> +F:	rust/kernel/time/delay.rs
>> +
>>  HIGH-SPEED SCC DRIVER FOR AX.25
>>  L:	linux-hams@vger.kernel.org
>>  S:	Orphan
>> @@ -23944,6 +23956,17 @@ F:	kernel/time/timekeeping*
>>  F:	kernel/time/time_test.c
>>  F:	tools/testing/selftests/timers/
>>
>> +TIMEKEEPING API [RUST]
>
> and similar things for this entry as well.
>
>> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +R:	Boqun Feng <boqun.feng@gmail.com>
>> +R:	Andreas Hindborg <a.hindborg@kernel.org>
>> +R:	John Stultz <jstultz@google.com>
>> +R:	Thomas Gleixner <tglx@linutronix.de>
>
> +R:      Stephen Boyd <sboyd@kernel.org>
>
> ?
>
>> +L:	rust-for-linux@vger.kernel.org
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +F:	rust/kernel/time.rs
>> +
>
> Tomo, let's wait for Andreas' rely and decide how to change these
> entries. Thanks!

My recommendation would be to take all of `rust/kernel/time` under one
entry for now. I suggest the following, folding in the hrtimer entry as
well:

DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
M:	Andreas Hindborg <a.hindborg@kernel.org>
R:	Boqun Feng <boqun.feng@gmail.com>
R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
R:	Lyude Paul <lyude@redhat.com>
R:	Frederic Weisbecker <frederic@kernel.org>
R:	Thomas Gleixner <tglx@linutronix.de>
R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
R:	John Stultz <jstultz@google.com>
L:	rust-for-linux@vger.kernel.org
S:	Supported
W:	https://rust-for-linux.com
B:	https://github.com/Rust-for-Linux/linux/issues
T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
F:	rust/kernel/time.rs
F:	rust/kernel/time/

If that is acceptable to everyone, it is very likely that I can pick 2-6
for v6.16.

I assume patch 1 will go through the sched/core tree, and then Miguel
can pick 7.

Best regards,
Andreas Hindborg



