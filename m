Return-Path: <netdev+bounces-176939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85870A6CCE8
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 22:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B67175A12
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E831E5B6B;
	Sat, 22 Mar 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHeIW1vq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFA1BC5C;
	Sat, 22 Mar 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680463; cv=none; b=XKLjCTA4gcBFTWUlxVFmHPY04xf8Y5Pc/4QJVYvEcmzUwUKrtsfOinKlbYVxH/HhZzDpWJm3Ui83rLD+ONhHz4VZ9OX4CirjHFfv2L6EqjRZM1lyqUVHvlKhRfW7BElNkDvkCjy4VAYh7JM4eJTz+fS3QX1yGoUIsJdUCv17JEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680463; c=relaxed/simple;
	bh=976EshGXr//jv+OUmY36TCnIJ7dtEQZj98pLhY1fKhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvVsZT9FoSTrHNkhrAyj237JKC5jbSB71LI2oTYxCrt8JSWrezq5sl4qMMsZH0butXwE0wZkbnfztOsv8aWjhMXB37BxyBSGZhE1SeiSGPHsSn7TbTp5oYYR8U7ainc9ao+9xCSqedjKB4IVBeTReKJU4mHBktUZSjuJAgtslIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHeIW1vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80AEC4CEEF;
	Sat, 22 Mar 2025 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680463;
	bh=976EshGXr//jv+OUmY36TCnIJ7dtEQZj98pLhY1fKhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BHeIW1vqmwHfJn9/VYMj4CbpG5AwTNjJoIX4OukUjGEns2Fx89pm2v2zbmbMYeknx
	 aZxfPkonuLL8Wx/eDcYLWAoz6f4gXf8vKHUtlZsDJRWwcAeAQ5yH64YeCIJZs8sM9W
	 C1RC71SOhPQtlcQbXW0Camskcjr/G3mUfbOIWCcKYvGO8yU9ryDp11NGOa14bOIwHk
	 7wVfP/SQ3awGDs0R7Fn8INmEu7tqAvBnYuUBQIVE/j/Ef1kQeTTpap+jYw4kRiyzem
	 7hggsDu3C0ng82z+V+Z0bc4sa+4nZpGx4r/5rEAcXHa/LCIWyUUnBMHXKQTu5LJz/t
	 TegrNMSRJlMLw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: frederic@kernel.org,  linux-kernel@vger.kernel.org,
  daniel.almeida@collabora.com,  gary@garyguo.net,  aliceryhl@google.com,
  me@kloenk.dev,  rust-for-linux@vger.kernel.org,  netdev@vger.kernel.org,
  andrew@lunn.ch,  hkallweit1@gmail.com,  tmgross@umich.edu,
  ojeda@kernel.org,  alex.gaynor@gmail.com,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,
  anna-maria@linutronix.de,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 5/8] rust: time: Add wrapper for fsleep() function
In-Reply-To: <20250322.102449.895174336060649075.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Sat, 22 Mar 2025 10:24:49 +0900 (JST)")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-6-fujita.tomonori@gmail.com>
	<Z93io9rkpRMiXEKi@pavilion.home>
	<20250322.102449.895174336060649075.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 15:15:38 +0100
Message-ID: <874izlb185.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> On Fri, 21 Mar 2025 23:05:23 +0100
> Frederic Weisbecker <frederic@kernel.org> wrote:
>

[...]

>>> +/// `delta` must be within `[0, i32::MAX]` microseconds;
>>> +/// otherwise, it is erroneous behavior. That is, it is considered a b=
ug
>>> +/// to call this function with an out-of-range value, in which case th=
e function
>>> +/// will sleep for at least the maximum value in the range and may warn
>>> +/// in the future.
>>> +///
>>> +/// The behavior above differs from the C side [`fsleep()`] for which =
out-of-range
>>> +/// values mean "infinite timeout" instead.
>>=20
>> And very important: the behaviour also differ in that the C side takes
>> usecs while this takes nsecs. We should really disambiguate the situation
>> as that might create confusion or misusage.
>>=20
>> Either this should be renamed to fsleep_ns() or fsleep_nsecs(), or this =
should
>> take microseconds directly.
>
> You meant that `Delta` type internally tracks time in nanoseconds?
>
> It's true but Delta type is a unit-agnostic time abstraction, designed
> to represent durations across different granularities =E2=80=94 seconds,
> milliseconds, microseconds, nanoseconds. The Rust abstraction always
> tries to us Delta type to represent durations.
>
> Rust's fsleep takes Delta, internally converts it in usecs, and calls
> C's fsleep.
>
> Usually, drivers convert from a certain time unit to Delta before
> calling fsleep like the following, so misuse or confusion is unlikely
> to occur, I think.
>
> fsleep(Delta::from_micros(50));
>
> However, as you pointed out, there is a difference; C's fsleep takes
> usecs while Rust's fsleep takes a unit-agnostic time type. Taking this
> difference into account, if we were to rename fsleep for Rust, I think
> that a name that is agnostic to the time unit would seem more
> appropriate. Simply sleep(), perhaps?

I would prefer to keep the same name. But if we must change it, how
about `flexible_sleep` to indicate the behavior?

And just to reiterate what Tomonori already said, it is not possible to
call this method with an integer,

  fsleep(500)

will not compile. A unit based conversion into `Duration` is required.


Best regards,
Andreas Hindborg



