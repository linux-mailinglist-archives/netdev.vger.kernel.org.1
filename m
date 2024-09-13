Return-Path: <netdev+bounces-128061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C981F977C04
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0921C243F0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385A1D5CC1;
	Fri, 13 Sep 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChTwYdiF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYcQqvQt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E81175D45;
	Fri, 13 Sep 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219007; cv=none; b=FENp/k7Z2StfxqhSQb0ErWoCYRdzmAA4n0mqs0FckZkVEuus4sVCvU+tZI3Dn35LwEmOIIWfQkSJAW6sdPkfJrRkAk5+O6A3g1aqFnC2gr/LrGk+RsnJv7ecs/8eN8dE7aMehMlCVicVv60uJ2jQx+fknFr26vFgo/5GN2VeIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219007; c=relaxed/simple;
	bh=/Yk90DKc/aneH7dYVNaU3ZDhP6KYYsYr1uFKvAyo0no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=li5PTN4KdPnNUZewTYIT7Z/VCbOwDHU1eUSG1izl2FeeI8zHRsfyOtjCSZwE+0Qa9wgewUPYCJHWo1XMgowD53nSNE/Cnh3rcHUhM9zu5gYYJMn8/JfuNhJS1XWTm08CiYs0Qi832TelGa7xGFHlCb4s629yg4OhZID8Gy9Eg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChTwYdiF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYcQqvQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726218998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/oB0qcVCjY5nSby5hZFJsFPaIcuJMtrbm7MdwgCGjo=;
	b=ChTwYdiFoDXBoZSPzAtIO2hqcg/le2NASqyPjsham+vtt5ZTXpryTLGPcpKf/7qw8Ivi54
	pJbEkt4tRaqNHgoWaL7y/4akgB4z7pID44p8lqvpc2xvh1x751YEkcDtermDR+Zct9o5/H
	4Pst2R58iBEom1R71WnwTJtNfph7MzkdNuzzS+prkvzubruBnQMuf2T8ze80aC46BQcRLC
	zPHbl+2ejsB9hpRrj7I1rOhopPMWnFykQYNJ0xrDDQJOUXyL1VfaHA3tsdJ2HgejPEA5Sw
	sSoINymcgBpbDUVhxwzWIEQqX1G5jKEKJPDLn9hPsPl/0ozuKfoxdiqvu6KHvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726218998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/oB0qcVCjY5nSby5hZFJsFPaIcuJMtrbm7MdwgCGjo=;
	b=qYcQqvQtDx8MnD6YedZOQJz09OomVNoX1NDJQmjwvB4ceHq7jMG2NpiOsVma2Dhy0uCHZF
	0dah6qOBkiM/ZWDQ==
To: Simon Horman <horms@kernel.org>
Cc: John Stultz <jstultz@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Miroslav Lichvar
 <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Christopher S Hall <christopher.s.hall@intel.com>
Subject: Re: [PATCH 10/24] timekeeping: Define a struct type for tk_core to
 make it reusable
In-Reply-To: <20240912073828.GC572255@kernel.org>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-10-f7cae09e25d6@linutronix.de>
 <20240912073828.GC572255@kernel.org>
Date: Fri, 13 Sep 2024 11:16:37 +0200
Message-ID: <87jzffj4lm.fsf@somnus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> On Wed, Sep 11, 2024 at 03:29:54PM +0200, Anna-Maria Behnsen wrote:
>> The struct tk_core uses is not reusable. As long as there is only a single
>> timekeeper, this is not a problem. But when the timekeeper infrastructure
>> will be reused for per ptp clock timekeepers, an explicit struct type is
>> required.
>> 
>> Define struct tk_data as explicit struct type for tk_core.
>> 
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> ...
>
> Hi Anna-Maria,
>
> I wonder if the order of this and the previous patch should
> be reversed, or the two patches should be squashed together.
>
> I am seeing a build failure with only patches 01-09/24 of this series
> applied, which seem to be resolved by applying this patch.
>
> .../timekeeping.c:1735:43: warning: declaration of 'struct tk_data' will not be visible outside of this function [-Wvisibility]
>  1735 | static __init void tkd_basic_setup(struct tk_data *tkd)
> ...

Oh, I'm sorry. I mixed something up. Thanks for letting me know, I'll
have a look at it and fix it!

	Anna-Maria


