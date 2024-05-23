Return-Path: <netdev+bounces-97816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A08CD5A6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA51F21F06
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D814B95D;
	Thu, 23 May 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jgQg9/4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304CC14B95F
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474263; cv=none; b=OpC4m7g9hQYJPmcfVrOLz3JQ3T19rjTNSYBbJMGrveGKh8KYCDDkHB2tfLe8r8hFmtrnZMkpttaI+ZsVmi0P8HXJT8vLQxu2zB87LHwwkNYn65Zfhk9a2cWC8WzW93S++V6FfRm6jIOa46pW9OANQvaiVRInZ6ta38WSuyKasYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474263; c=relaxed/simple;
	bh=be9nk2o1eTKqxCPN/9SzXOXQJJqAGKwEBTHo2LA7odw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LLooUiwg6PHaMZGUc2Q/YSz7SY1UTfXrl9VtkaQv5VoW6qju/SaoZtFuI2uAgPgWtEcX/tsyYGhCOZM9+Wg35lrohogRVCPt84sw0xPf2AJMy5B7o7MlmNp+YcQJk78kw+cCaK4cl/EGVu2ZqJl2JaJcS4zmyPd2bkGUAQH84go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jgQg9/4X; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716474259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4HJlZvUfTNkovrUp9Oox4dAn3Joe4pgm3xkHI5wSfU=;
	b=jgQg9/4Xq9WV/mLKVNng4f96+Q25ay3R2IzgjT7TPNySAogzGZI+/9sCJKDPRmgk1Ir8VW
	Y66My4bR84zLzgBJa6WD1MqDnixzHnbl1t6S6230xNlhVBvCjKLAGRGsjgnKLJCuFkmNcy
	mdXhceIi4XtZaG/XH+DjQ41xi6dWAr/Qc00cvv5cP0yppadjvlfO6DJ5xkcA/0D9jOWo7y
	Kz9m+GVFn3I6ctrJd9afUDpfTZUuayvnh5RsIRnir0otoAi+MYhp5ZA3lZFRAI2PWy2dtw
	/72hQOPLc+VQKaAVQ4NQsiSNPWBNORy6iMxIn6vNRaU9Q++Qgzv3aIHUIgwviA==
Date: Thu, 23 May 2024 16:24:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
 <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
 <c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
Message-ID: <c41ee2a968d1b839b8b9c7a3571ad107@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 16:11, Gedalya wrote:
> On 5/23/24 10:02 PM, Dragan Simic wrote:
>> See, once something becomes de facto standard, or some kind of de 
>> facto
>> standard, it becomes quite hard to change it.  It's often required to
>> offer much greater flexibility instead of just changing it.
>> 
> Flexibility is offered by the COLORFGBG variable. The entire time
> we've been talking only about cases where that is not set.

Yes, but the actual trouble is that COLORFGBG seems to be rarely set
automatically by the terminal emulators.

> Again, it is good to reduce to a minimum reliance on defaults. But
> aside from having a default the remaining option is to refuse to
> produce colors when COLORFGBG is not set, even when the user is
> explicitly asking for colors.

That's a very good proposal!  I'd highly support that behavior.

>>>> everywhere and for the new feature to reach the users.  Shipping
>>>> a few additional files in the /etc/profile.d directory would be a
>>>> reasonable stopgap measure.
>>> 
>>> No, it would be totally broken as explained.
>> 
>> It would be broken only for those users who change their background
>> color to some light color.  Though, it would be broken even with your
>> patch applied, right?  I see no difference in the end results, for the
>> users that reconfigure their terminals that way.
>> 
> /etc/profile.d is shell session configuration.
> 
> If you want you can come up with shell magic that would set
> environment variables depending on which terminal environment the
> shell is running in.

I had in mind setting COLORFGBG to dark background that way, not some
shell magic that would change it dynamically.

