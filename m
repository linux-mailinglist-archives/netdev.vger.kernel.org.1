Return-Path: <netdev+bounces-97799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA18CD4ED
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B5A286044
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691014A4F1;
	Thu, 23 May 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="Y9SHNvLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBFD13B7BC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471562; cv=none; b=pzcozdHYQ6wsxEU2FWunsHL/25JOlryyGFV6sD3E//zTbk2pfOpbT5ek4uCOfw19eNh4YJCRmrZrd0NX4DjVQPf9J9RjZmR/vw2dEB1bBR5scSXZJt5H0N41KS/mCTvRkfNbRkBOduo/Vij4Ya0kZNbp2pux0A67cYG+Hb+a1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471562; c=relaxed/simple;
	bh=8T0lWtmnYMaubAQTVBls379erdZvPIMoMxzh0j4T+SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTZlBpuU/6a7yXBh+h8o5uM0Jw2/rdYVhfcpLuqCWopFV+4tIPYUyKeIgiilhUKwN3IREJnUpNzh3yL8I0qZFdI+7Uq4o1KiABP8IKdAlUIDj8ZHNlmvnKGV290BtXb9M1u/nEp0YBRZ+IYZeQFNckYE0hssB2zwRgUpDJFTvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=Y9SHNvLo; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=rg99GQ3O6+JuUSWdHbid6QML4XUYIU1j9Dyr0J5Jv78=; b=Y9SHNvLoo05wmSgjcC3J55nc1H
	nzGgi2YkSVGszduETLFgKVsN3/dFxpA3Ie7HZtSirmyXjOrgNtc4m1kaOeaQBg7tIMIUbakposn0M
	sPtUJJCfAMzdUwql+r3dNmpUerjoPhV2eezGvyrkxRGeW2o2jKbGWWmSWTL+BOj5bo9zCqHXwbre2
	7bABeDJRyFnPVqvk6GuiPlmoDf4Zzx3fVhEcJUbb42v9BRJjxPbFCo2FyN5NDFTzdv8PDb94m2T6K
	niMWDpU+3fhiWXnfCcFAxY/YFxIb+uV+gzpn/HOPmQCWhHodMJ6stLfDfSSBJxmrIqzC8JpvpBrwn
	+hAi1z7A==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA8f7-000gGY-2J;
	Thu, 23 May 2024 13:39:18 +0000
Message-ID: <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
Date: Thu, 23 May 2024 21:39:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Dragan Simic <dsimic@manjaro.org>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 9:23 PM, Dragan Simic wrote:

>> For what problem?
>> Obviously, for the problem your patch attempts to solve.

When nothing is indicated and a genuine _guess_ must be made, or a _default_ should be set, should that be dark or light?
This is not a coding question.
All defaults should be good in some situations and bad in fewer situations.
Having a default does not preclude reducing the number of cases it is relied upon. Those are different matters.

>> Yes I asked Debian in the first place to leave colors disabled by
>> default, but nevertheless `ip` is still broken for most users if and
>> when colors are enabled, whether at runtime or build time.
> Well, the coloring support in ip(8) can't be broken if the users
> configure it at runtime accordingly, i.e. following the background
> color configured in their terminal emulator(s), right?

Absolutely right. The manpage says so and it is tested, working.

>>> If Debian configures the terminal emulators it ships to use dark
>>> background,
>> Do they? Or is that the nearly universal default?
> Frankly, I don't know for sure because I don't use many different
> terminal emulators, but you as the submitter of this patch perhaps
> should know that better.  However, terminal emulators must be
> configured somehow, because it makes no sense whatsoever that they're
> having their background colors hardcoded.

If you use the word "configure" to refer to the default behavior, set by 
upstream and not modified by the distribution, then fine, yes.

It's just a way of saying "terminals tend to be dark".

>>> why not configure the ip(8) utility the same way, i.e. by setting
>>> COLORFGBG in files placed in the /etc/profile.d directory,
>> COLORFGBG where set is automatically set by the terminal emulator. It
>> would be more sensible to add this feature to more terminal emulators,
>> upstream.
> Of course, but that would take a lot of time, both to implement it
> everywhere and for the new feature to reach the users.  Shipping
> a few additional files in the /etc/profile.d directory would be a
> reasonable stopgap measure.
No, it would be totally broken as explained.
>> Should Debian come up with a patch that magically adjusts this
>> variable every time the user changes their background color (in one
>> terminal emulator... and another color in another terminal
>> emulator...?)
> That's a valid concern.  Perhaps some documentation could be provided,
> to help the users who alter their background colors.

Already documented in the iputils2 manpage and elsewhere.

>> And what about linux virtual terminals (a.k.a non-graphical consoles)?
>>
> In my 25+ years of Linux experience, I've never seen one with a
> background color other than black.

Which is why it's such a reasonable assumption for iputils2 to male.

(BTW I have seen non-black vt colors... just happens to be true. But not 
so common)

>> In summary, if the best we can do is manually set COLORFGBG when using
>> a light background then that's the best we can do. I don't see how
>> Debian can possibly help with that.
>> On the iproute2 side, a rock-bottom ultimate default background color
>> assumption will always be needed and that should be dark.
> As others already pointed out, "should be light" or "should be dark"
> can be seen as personal preference.

It can and should be seen as begging the question of what is more common 
in the reality out there.

The matter of personal preference is whether deep blue on black is a bad 
choice.

What is the more common background color is a question of fact, not 
preference. We don't get to have preferred facts. I just do not know how 
to find out what the fact is, so I must use reserved language and say I 
_think_ dark is more common.



