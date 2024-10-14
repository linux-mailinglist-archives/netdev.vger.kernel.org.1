Return-Path: <netdev+bounces-135115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B099C5B4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B597B1C22978
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850F156F27;
	Mon, 14 Oct 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8WFUP8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IfsrtWuB"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0815855E;
	Mon, 14 Oct 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898227; cv=none; b=VBwxOow48SBgkCqrTEkQ0zso0vkNPSlieBDepBq98ojoEzsFvrF74poJwgOPgLtrJWEXdNBirFvUrDURKpLqrTqn0+FzLBSZOPUAgPab/5m7u+hazi4YHD3eJuYK7fgOwibctRJpT/moSPRHMRwS2c+zr+mjeJjUR58c40O+kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898227; c=relaxed/simple;
	bh=9QVxbVpVhyQGwImiKLgS/KDJ3Kza/nfhSesGL0lj6as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULLG/YEyDd6BZqSOboDwNHP9wECJLaidiw8u4UdUirME1W6qKarM6K4L4FlHO7mepmwh4j2dqiPkWeN5g4XhCTmvwSgBR1TNWkhY7CZ3K/4Gt7A7tzOzW1a3dxJSz/da0jdWcvoO9iNg6aQonWMnpz1xWOLIJpcEG25aitkAJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w8WFUP8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IfsrtWuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728898223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFSSEpHzXAxFCcOjA6FYQtxJMgP4CsxVlUoIiFwzjMo=;
	b=w8WFUP8RWWxM/S//EPmnt6cb75A193vLxC7WJBeDuEwVfeDgwqtZ7yZw0fnocXnJQLPTmb
	FrqW7igQHkb2P8ibTTsJ3rrhvDAjVaqwPywU6OjrewG0gBT9R0cB9TqHXs5FeEULWrvVGu
	1UB8K4TyyI/G3yWoA58MZpGxGtbjHYmc3dgQLYT1HmZZPG+fZvjzpI3GoHkks6bkQTB59o
	VtPivcIQpDY5whz3ITb8xIqL6i6zxt8R+/uCbJmnNk1rhtJZ8Gu5j4jZlbgNBBRxvzNQdr
	aabXWiUv/r5zeqFw+Y7z1MkgoFzjStVqI4quBvloSGOw6e/TvC6tyZwx0H5hZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728898223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFSSEpHzXAxFCcOjA6FYQtxJMgP4CsxVlUoIiFwzjMo=;
	b=IfsrtWuBupI6Z3PwZ/dev5IjGGGHw7SVV1aGeB66gPlOfPkpKbJXd3OIfA8BFkexEs9p7N
	jt7nW3I0L+gc5sDQ==
To: John Stultz <jstultz@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Miroslav Lichvar <mlichvar@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Christopher S Hall
 <christopher.s.hall@intel.com>
Subject: Re: [PATCH v2 06/25] timekeeping: Reorder struct timekeeper
In-Reply-To: <CANDhNCpPhS5nebGH_bA3G06Dmt6eFXAw9GyBEYmNZe2Z1WhS_Q@mail.gmail.com>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-6-554456a44a15@linutronix.de>
 <CANDhNCpPhS5nebGH_bA3G06Dmt6eFXAw9GyBEYmNZe2Z1WhS_Q@mail.gmail.com>
Date: Mon, 14 Oct 2024 11:30:22 +0200
Message-ID: <87msj7f2vl.fsf@somnus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Stultz <jstultz@google.com> writes:

> On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> struct timekeeper is ordered suboptimal vs. cachelines. The layout,
>> including the preceding seqcount (see struct tk_core in timekeeper.c) is:
>>
>>  cacheline 0:   seqcount, tkr_mono
>>  cacheline 1:   tkr_raw, xtime_sec
>>  cacheline 2:   ktime_sec ... tai_offset, internal variables
>>  cacheline 3:   next_leap_ktime, raw_sec, internal variables
>>  cacheline 4:   internal variables
>>
>> So any access to via ktime_get*() except for access to CLOCK_MONOTONIC_R=
AW
>> will use either cachelines 0 + 1 or cachelines 0 + 2. Access to
>> CLOCK_MONOTONIC_RAW uses cachelines 0 + 1 + 3.
>>
>> Reorder the members so that the result is more efficient:
>>
>>  cacheline 0:   seqcount, tkr_mono
>>  cacheline 1:   xtime_sec, ktime_sec ... tai_offset
>>  cacheline 2:   tkr_raw, raw_sec
>>  cacheline 3:   internal variables
>>  cacheline 4:   internal variables
>>
>> That means ktime_get*() will access cacheline 0 + 1 and CLOCK_MONOTONIC_=
RAW
>> access will use cachelines 0 + 2.
>>
>> Update kernel-doc and fix formatting issues while at it. Also fix a typo
>> in struct tk_read_base kernel-doc.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Acked-by: John Stultz <jstultz@google.com>
>
>> ---
>>  include/linux/timekeeper_internal.h | 102 +++++++++++++++++++++--------=
-------
>>  1 file changed, 61 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekee=
per_internal.h
>> index 902c20ef495a..430e40549136 100644
>> --- a/include/linux/timekeeper_internal.h
>> +++ b/include/linux/timekeeper_internal.h
>> @@ -26,7 +26,7 @@
>>   * occupies a single 64byte cache line.
>>   *
>>   * The struct is separate from struct timekeeper as it is also used
>> - * for a fast NMI safe accessors.
>> + * for the fast NMI safe accessors.
>>   *
>>   * @base_real is for the fast NMI safe accessor to allow reading clock
>>   * realtime from any context.
>> @@ -44,33 +44,41 @@ struct tk_read_base {
>>
>>  /**
>>   * struct timekeeper - Structure holding internal timekeeping values.
>> - * @tkr_mono:          The readout base structure for CLOCK_MONOTONIC
>> - * @tkr_raw:           The readout base structure for CLOCK_MONOTONIC_R=
AW
>> - * @xtime_sec:         Current CLOCK_REALTIME time in seconds
>> - * @ktime_sec:         Current CLOCK_MONOTONIC time in seconds
>> - * @wall_to_monotonic: CLOCK_REALTIME to CLOCK_MONOTONIC offset
>> - * @offs_real:         Offset clock monotonic -> clock realtime
>> - * @offs_boot:         Offset clock monotonic -> clock boottime
>> - * @offs_tai:          Offset clock monotonic -> clock tai
>> - * @tai_offset:                The current UTC to TAI offset in seconds
>> - * @clock_was_set_seq: The sequence number of clock was set events
>> - * @cs_was_changed_seq:        The sequence number of clocksource chang=
e events
>> - * @next_leap_ktime:   CLOCK_MONOTONIC time value of a pending leap-sec=
ond
>> - * @raw_sec:           CLOCK_MONOTONIC_RAW  time in seconds
>> - * @monotonic_to_boot: CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
>> - * @cycle_interval:    Number of clock cycles in one NTP interval
>> - * @xtime_interval:    Number of clock shifted nano seconds in one NTP
>> - *                     interval.
>> - * @xtime_remainder:   Shifted nano seconds left over when rounding
>> - *                     @cycle_interval
>> - * @raw_interval:      Shifted raw nano seconds accumulated per NTP int=
erval.
>> - * @ntp_error:         Difference between accumulated time and NTP time=
 in ntp
>> - *                     shifted nano seconds.
>> - * @ntp_error_shift:   Shift conversion between clock shifted nano seco=
nds and
>> - *                     ntp shifted nano seconds.
>> - * @last_warning:      Warning ratelimiter (DEBUG_TIMEKEEPING)
>> - * @underflow_seen:    Underflow warning flag (DEBUG_TIMEKEEPING)
>> - * @overflow_seen:     Overflow warning flag (DEBUG_TIMEKEEPING)
>> + * @tkr_mono:                  The readout base structure for CLOCK_MON=
OTONIC
>> + * @xtime_sec:                 Current CLOCK_REALTIME time in seconds
>> + * @ktime_sec:                 Current CLOCK_MONOTONIC time in seconds
>> + * @wall_to_monotonic:         CLOCK_REALTIME to CLOCK_MONOTONIC offset
>> + * @offs_real:                 Offset clock monotonic -> clock realtime
>> + * @offs_boot:                 Offset clock monotonic -> clock boottime
>> + * @offs_tai:                  Offset clock monotonic -> clock tai
>> + * @tai_offset:                        The current UTC to TAI offset in=
 seconds
>> + * @tkr_raw:                   The readout base structure for CLOCK_MON=
OTONIC_RAW
>> + * @raw_sec:                   CLOCK_MONOTONIC_RAW  time in seconds
>> + * @clock_was_set_seq:         The sequence number of clock was set eve=
nts
>> + * @cs_was_changed_seq:                The sequence number of clocksour=
ce change events
>> + * @monotonic_to_boot:         CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
>> + * @cycle_interval:            Number of clock cycles in one NTP interv=
al
>> + * @xtime_interval:            Number of clock shifted nano seconds in =
one NTP
>> + *                             interval.
>> + * @xtime_remainder:           Shifted nano seconds left over when roun=
ding
>> + *                             @cycle_interval
>> + * @raw_interval:              Shifted raw nano seconds accumulated per=
 NTP interval.
>> + * @next_leap_ktime:           CLOCK_MONOTONIC time value of a pending =
leap-second
>> + * @ntp_tick:                  The ntp_tick_length() value currently be=
ing
>> + *                             used. This cached copy ensures we consis=
tently
>> + *                             apply the tick length for an entire tick=
, as
>> + *                             ntp_tick_length may change mid-tick, and=
 we don't
>> + *                             want to apply that new value to the tick=
 in
>> + *                             progress.
>> + * @ntp_error:                 Difference between accumulated time and =
NTP time in ntp
>> + *                             shifted nano seconds.
>> + * @ntp_error_shift:           Shift conversion between clock shifted n=
ano seconds and
>> + *                             ntp shifted nano seconds.
>> + * @ntp_err_mult:              Multiplication factor for scaled math co=
nversion
>> + * @skip_second_overflow:      Flag used to avoid updating NTP twice wi=
th same second
>> + * @last_warning:              Warning ratelimiter (DEBUG_TIMEKEEPING)
>> + * @underflow_seen:            Underflow warning flag (DEBUG_TIMEKEEPIN=
G)
>> + * @overflow_seen:             Overflow warning flag (DEBUG_TIMEKEEPING)
>>   *
>>   * Note: For timespec(64) based interfaces wall_to_monotonic is what
>>   * we need to add to xtime (or xtime corrected for sub jiffy times)
>> @@ -88,10 +96,25 @@ struct tk_read_base {
>>   *
>>   * @monotonic_to_boottime is a timespec64 representation of @offs_boot =
to
>>   * accelerate the VDSO update for CLOCK_BOOTTIME.
>> + *
>> + * The cacheline ordering of the structure is optimized for in kernel u=
sage
>> + * of the ktime_get() and ktime_get_ts64() family of time accessors. St=
ruct
>> + * timekeeper is prepended in the core timekeeeping code with a sequence
>> + * count, which results in the following cacheline layout:
>> + *
>> + * 0:  seqcount, tkr_mono
>> + * 1:  xtime_sec ... tai_offset
>> + * 2:  tkr_raw, raw_sec
>> + * 3,4: Internal variables
>> + *
>> + * Cacheline 0,1 contain the data which is used for accessing
>> + * CLOCK_MONOTONIC/REALTIME/BOOTTIME/TAI, while cacheline 2 contains the
>> + * data for accessing CLOCK_MONOTONIC_RAW.  Cacheline 3,4 are internal
>> + * variables which are only accessed during timekeeper updates once per
>> + * tick.
>
> Would it make sense to add divider comments or something in the struct
> to make this more visible? I fret in the context of a patch, a + line
> adding a new structure element that breaks the ordered alignment might
> not be obvious.

This is an argument! I'll add simple comments with /* Cachline X: */

Thanks,

	Anna-Maria

