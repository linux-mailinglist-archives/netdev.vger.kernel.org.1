Return-Path: <netdev+bounces-125453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B401196D1CC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A641F27C37
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014601990BA;
	Thu,  5 Sep 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpxZhktJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJ+cdTu7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211A198E9F;
	Thu,  5 Sep 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524147; cv=none; b=qG3neMjfMFXyHfmRbLq5WPuGIdzZoN0lqTOMl8KziBFlwp19PsaOq2163GJSz3Lo4W5OKjOg4OTWwCxn3b8/vzTUysL55vOsZ8deUpobZPEABSaUe8yBX0H8GhNsFnO8JOSWLclIk4h+IQmiwlFFu+JNE1FzplmFgb/mJBBsQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524147; c=relaxed/simple;
	bh=IGpqu0AbEfFcQHlaTnL8FB0oZgedhXai5ctdiIf//jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHBUtSz7YM62WWOxrbhTlLB+Sktzv035iJ8mWOM3iYiySqa39lr9MB9MBXXmyyV3Hc5XL3D8PJodcN5fr5p5ViGdGtiobDqGe/MW9boIQu9cFIayjMbyP4uDxlt/CSv/b2CknDTXXn5hLiexz65r53fifOondba4e31naB5xTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpxZhktJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJ+cdTu7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725524142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj6M6KVALb8ItmdIZXewANkqyGRtAWppUkT1S7x+yxo=;
	b=RpxZhktJFaMziweFeqWFY2ODP3AELVAapvPbAS32isz7DMRXQqqnfCnAXIG/vo+VVM5lqz
	Bk07pz2LTDwxIF+lCqZa2EAvM8gQwSKbpnhs6Yr+pzEpKE1rQIceApTWy2xjZeJXxh13gI
	tBhSQTp8ddqd3XfBuptTKhV1P8vJuEg+fYF2kMCEBXgbfWK+reBrmECSl8HT+tsfqFSO1j
	NGAPMTWLEAijIjdIaswglTcpK4wmajtio4YZyJaOumZu1fQVLuYtaniJYrVzt3ifqQZn4W
	0BBvJXXDdO4+SesppsBktnYamqG7T3a/XJ9sfQpFvP0z0AVensFF9+GeXGGclA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725524142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj6M6KVALb8ItmdIZXewANkqyGRtAWppUkT1S7x+yxo=;
	b=gJ+cdTu79Soa0DwW49qt4TU7i4Dk579rmL2O7XO7J6D42aGnObjvdAMzpxjs3nwR2mDmB2
	F9Xe4RoO0QR2EeDQ==
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 netdev@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
In-Reply-To: <a269cf5e-2ba0-40c3-a7f2-9afa0e8c6926@lunn.ch>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-12-e98760256370@linutronix.de>
 <a269cf5e-2ba0-40c3-a7f2-9afa0e8c6926@lunn.ch>
Date: Thu, 05 Sep 2024 10:15:42 +0200
Message-ID: <87y1464itt.fsf@somnus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Lunn <andrew@lunn.ch> writes:

>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index 6b7d40d49129..b09490e08365 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -1374,11 +1374,12 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
>>   * @regnum: The register on the MMD to read
>>   * @val: Variable to read the register into
>>   * @cond: Break condition (usually involving @val)
>> - * @sleep_us: Maximum time to sleep between reads in us (0
>> - *            tight-loops).  Should be less than ~20ms since usleep_range
>> - *            is used (see Documentation/timers/timers-howto.rst).
>> + * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
>> + *            read usleep_range() function description for details and
>> + *            limitations.
>>   * @timeout_us: Timeout in us, 0 means never timeout
>>   * @sleep_before_read: if it is true, sleep @sleep_us before read.
>> + *
>>   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
>
> I know it is not in scope for what you are trying to fix, but there
> should be a : after Returns
>
> * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either

I have to do a v2 of the series anyway. So if it helps, I can add the
missing colon after "Returns" in all those function descriptions I touch
and expand the commit message by:

  While at it fix missing colon after "Returns" in function description
  as well.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

Thanks,

        Anna-Maria

