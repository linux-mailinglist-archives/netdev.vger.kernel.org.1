Return-Path: <netdev+bounces-178401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB8A76D93
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A503A82A6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFE215F5D;
	Mon, 31 Mar 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lde1OVph"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC87214A90;
	Mon, 31 Mar 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450245; cv=none; b=qV9bcAll/dXa3xIIOlaaTlaIXYP4Vmtw+PbwbIIVPb85jnssqhqbbLzG+i1MGcUhV+7a4fpx2e86nTE6i6QCiUy/SO5ZW0xX9EOpbv9nSeiaCf4qaY80AKci9nQR8ONZMX9Y5CV7epA0pUpb5kQGHOP6ezATPo3Y80+hZnNXtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450245; c=relaxed/simple;
	bh=W5IkG6CzmoQxTTfBZXkRe1Tz4Qq4ydM2xIKYA5CEC+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5dNHVBBuwUdH56pd+4qPwGbsuI3wVqEiRE1Bi6V2CMCSNJb81iRmQCZ0+bTr4+Q9oNVz8bhee607WcAeKvXt1LB60Xsx38LTClLgjpL/M55+bnL8HBKIBjpy1tk3JrM27VkqFHobdKHv3g3BCOWwr5Z1FnWxJfAafdPWOGOw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lde1OVph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A815C4CEE5;
	Mon, 31 Mar 2025 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743450245;
	bh=W5IkG6CzmoQxTTfBZXkRe1Tz4Qq4ydM2xIKYA5CEC+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lde1OVphjSPpoSO4Hk6XylrdVbNeB3sDZ/ZzD8jJcL+B/FEvYjY7N47JOChudzgEI
	 GpcO6EsjWMOerh+geFp87aMv6Cp9/2P8vYHVy4O1XsXc42HnHe8LfkFdbd+pZR8YAa
	 mus1JeKDJNf2fsXfFJ3ZprnI0HJ+6z5gAsvEk4ZIaPBRqnGAB8map8SxVw+cHjckh6
	 8Gq2AtsQCoTFSkjeIYFaIiq+AeX73iV79EctKNfRtXK2c3jt7pZCJ1olJL7eQueHf6
	 4+4rtqw7b5LsReOCg7BDJ0IRKSMe4xa+LAiZFbGapZTJ1pyltKubYGpKI+6NUyggZg
	 GkM23GbjZvM0w==
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
In-Reply-To: <Z-qgo5gl6Qly-Wur@Mac.home> (Boqun Feng's message of "Mon, 31 Mar
	2025 07:03:15 -0700")
References: <87jz8ichv5.fsf@kernel.org> <87o6xu15m1.ffs@tglx>
	<67ddd387.050a0220.3229ca.921c@mx.google.com>
	<20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>
	<8n9Iwb8Z00ljHvj7jIWUybn9zwN_JLhLSWrljBKG9RE7qQx4MTMqUkTJeVeBZtexynIlqH1Lgt6g0ofLLwnoyQ==@protonmail.internalid>
	<Z96zstZIiPsP4mSF@Mac.home> <871puoelnj.fsf@kernel.org>
	<RGjlasf3jfs3sL9TWhGeAJxH0MNvvn0DDqGl9FVo2JNvwTDpUqrr_V515QzLaEp0T4B1m6PJ0z7Jpw1obiG58w==@protonmail.internalid>
	<Z-qgo5gl6Qly-Wur@Mac.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 31 Mar 2025 21:43:50 +0200
Message-ID: <87ecyd3s09.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Sat, Mar 22, 2025 at 11:40:21PM +0100, Andreas Hindborg wrote:
>> Hi All,
>>
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>>
>> > On Sat, Mar 22, 2025 at 11:07:03AM +0900, FUJITA Tomonori wrote:
>> >> Thank you all!
>> >>
>> >> On Fri, 21 Mar 2025 14:00:52 -0700
>> >> Boqun Feng <boqun.feng@gmail.com> wrote:
>> >>
>> >> > On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
>> >> >> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
>> >> >> >> Could you add me as a reviewer in these entries?
>> >> >> >>
>> >> >> >
>> >> >> > I would like to be added as well.
>> >> >>
>> >> >> Please add the relevant core code maintainers (Anna-Maria, Frederi=
c,
>> >> >> John Stultz and myself) as well to the reviewers list, so that thi=
s does
>> >> >> not end up with changes going in opposite directions.
>> >> >>
>> >> >
>> >> > Make sense, I assume you want this to go via rust then (althought we
>> >> > would like it to go via your tree if possible ;-))?
>> >>
>> >
>> > Given Andreas is already preparing the pull request of the hrtimer
>> > abstraction to Miguel, and delay, timekeeping and hrtimer are related,
>> > these timekeeping/delay patches should go via Andreas (i.e.
>> > rust/hrtimer-next into rust/rust-next) if Thomas and Miguel are OK with
>> > it. Works for you, Andreas? If so...
>> >
>> >> Once the following review regarding fsleep() is complete, I will subm=
it
>> >> patches #2 through #6 as v12 for rust-next:
>> >>
>> >> https://lore.kernel.org/linux-kernel/20250322.102449.8951743360606490=
75.fujita.tomonori@gmail.com/
>> >>
>> >> The updated MAINTAINERS file will look like the following.
>> >>
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index cbf84690c495..858e0b34422f 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -10370,6 +10370,18 @@ F:	kernel/time/timer_list.c
>> >>  F:	kernel/time/timer_migration.*
>> >>  F:	tools/testing/selftests/timers/
>> >>
>> >> +DELAY AND SLEEP API [RUST]
>> >> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> >> +R:	Boqun Feng <boqun.feng@gmail.com>
>> >> +R:	Andreas Hindborg <a.hindborg@kernel.org>
>> >
>> > ... this "R:" entry would be "M:",
>> >
>> >> +R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
>> >> +R:	Frederic Weisbecker <frederic@kernel.org>
>> >> +R:	Thomas Gleixner <tglx@linutronix.de>
>> >> +L:	rust-for-linux@vger.kernel.org
>> >> +L:	linux-kernel@vger.kernel.org
>> >
>> > +T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
>> >
>> >> +S:	Maintained
>> >
>> > I will let Andreas decide whether this is a "Supported" entry ;-)
>> >
>> >> +F:	rust/kernel/time/delay.rs
>> >> +
>> >>  HIGH-SPEED SCC DRIVER FOR AX.25
>> >>  L:	linux-hams@vger.kernel.org
>> >>  S:	Orphan
>> >> @@ -23944,6 +23956,17 @@ F:	kernel/time/timekeeping*
>> >>  F:	kernel/time/time_test.c
>> >>  F:	tools/testing/selftests/timers/
>> >>
>> >> +TIMEKEEPING API [RUST]
>> >
>> > and similar things for this entry as well.
>> >
>> >> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> >> +R:	Boqun Feng <boqun.feng@gmail.com>
>> >> +R:	Andreas Hindborg <a.hindborg@kernel.org>
>> >> +R:	John Stultz <jstultz@google.com>
>> >> +R:	Thomas Gleixner <tglx@linutronix.de>
>> >
>> > +R:      Stephen Boyd <sboyd@kernel.org>
>> >
>> > ?
>> >
>> >> +L:	rust-for-linux@vger.kernel.org
>> >> +L:	linux-kernel@vger.kernel.org
>> >> +S:	Maintained
>> >> +F:	rust/kernel/time.rs
>> >> +
>> >
>> > Tomo, let's wait for Andreas' rely and decide how to change these
>> > entries. Thanks!
>>
>> My recommendation would be to take all of `rust/kernel/time` under one
>> entry for now. I suggest the following, folding in the hrtimer entry as
>> well:
>>
>> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>> M:	Andreas Hindborg <a.hindborg@kernel.org>
>
> Given you're the one who would handle the patches, I think this make
> more sense.
>
>> R:	Boqun Feng <boqun.feng@gmail.com>
>> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Tomo, does this look good to you?
>
>> R:	Lyude Paul <lyude@redhat.com>
>> R:	Frederic Weisbecker <frederic@kernel.org>
>> R:	Thomas Gleixner <tglx@linutronix.de>
>> R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
>> R:	John Stultz <jstultz@google.com>
>
> We should add:
>
> R:      Stephen Boyd <sboyd@kernel.org>
>
> If Stephen is not against it.

Yes =F0=9F=91=8D

>
>> L:	rust-for-linux@vger.kernel.org
>> S:	Supported
>> W:	https://rust-for-linux.com
>> B:	https://github.com/Rust-for-Linux/linux/issues
>> T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
>> F:	rust/kernel/time.rs
>> F:	rust/kernel/time/
>>
>> If that is acceptable to everyone, it is very likely that I can pick 2-6
>> for v6.16.
>>
>
> You will need to fix something because patch 2-6 removes `Ktime` ;-)

Yea, but `Instant` is almost a direct substitution, right? Anyway, Tomo
can send a new spin and change all the uses of Ktime, or I can do it. It
should be straight forward. Either way is fine with me.


Best regards,
Andreas Hindborg




