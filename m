Return-Path: <netdev+bounces-97804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B838CD544
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E430AB22EB5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C5F1DFF8;
	Thu, 23 May 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Gz4MT9Mi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C514A627
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472961; cv=none; b=ZYGXRUzmTATM2j32iDSih659VYZi8gK5GMGUHoOSCq4lX6zIgjBz4E+AaEZFOBVZZpJr0IuCWxR3lDahX6uDTRs9EVLeGJ3sCwBDFRt8jzyWXg3+c7VIzseXHMDyofUtEKu5vHS7bmCwp/MRcnD9ofTyC+h/JzwZOhVlLuXGDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472961; c=relaxed/simple;
	bh=OQ/rwoZnNkYLWLe21Giar0ByVGRBIyGWyziQwrSTQ/Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Lz6hEqyqzYZ2qC8xwURpv9ZIbFjrr5mXb2+ZVQXsh72PVH/xvJ/9f9mmS3mks8yWzl+bIqSwQl7L4upsN+iAfw9wl8Fp4NieV4oVdGOPQwkDNglfV61AQ6CTZQyMjOUNRNCYuHbdF53kDtvkA/t8NThZeuQC/wM+qCoTY/5pX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Gz4MT9Mi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716472956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDKLGy3ICo624vMUJKp3RRF5dshqpwbWIlpRMHDTRlQ=;
	b=Gz4MT9Mi3NQva5VmOc67fmv6+ogt1qfP04sq0ImnYDRvBuMUl/Hzox22O33bJUBNCi2ZFW
	JncOw+av48/EzKGkrr1SHOjqmcqQizgzAOfc9dMmJvwf6/XU2e5O+aNqRFazaFQbV15l6J
	h+OxVAPskwkNPzwmxsW1GNWoqpNQ9jSU+2H1HFUMJYBI2QxpU6wrm/5szKVhWw4+YCWCCA
	U2LKjiVis49XlRYGBLsloy+smdt0gfF0/MvFJu7jc8rUu96PTMEIkpe2X+vI+tV0w9712A
	oG1mQEmbIXwnDupzBZkMS7Et1C0eH6N5HvQiQiHt5wlJXrFCJXOtLmybZ+uKSg==
Date: Thu, 23 May 2024 16:02:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
Message-ID: <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 15:39, Gedalya wrote:
> On 5/23/24 9:23 PM, Dragan Simic wrote:
> 
>>> For what problem?
>>> Obviously, for the problem your patch attempts to solve.
> 
> When nothing is indicated and a genuine _guess_ must be made, or a
> _default_ should be set, should that be dark or light?
> This is not a coding question.

See, once something becomes de facto standard, or some kind of de facto
standard, it becomes quite hard to change it.  It's often required to
offer much greater flexibility instead of just changing it.

> All defaults should be good in some situations and bad in fewer 
> situations.
> Having a default does not preclude reducing the number of cases it is
> relied upon. Those are different matters.

Yes, but again, please see my point above.

>>>> If Debian configures the terminal emulators it ships to use dark
>>>> background,
>>> 
>>> Do they? Or is that the nearly universal default?
>> 
>> Frankly, I don't know for sure because I don't use many different
>> terminal emulators, but you as the submitter of this patch perhaps
>> should know that better.  However, terminal emulators must be
>> configured somehow, because it makes no sense whatsoever that they're
>> having their background colors hardcoded.
> 
> If you use the word "configure" to refer to the default behavior, set
> by upstream and not modified by the distribution, then fine, yes.
> 
> It's just a way of saying "terminals tend to be dark".

Actually, "configure" can be used for both purposes, i.e. for the
default upstream settings, and for some adjustments to those settings,
performed by the distributions.  For example, some distributions may
adjust the background color to use some darker shade of gray, which
may be easier on the eyes, instead of using pitch black background
that may be the upstream default.

Though, I don't know what each and every distribution does, or what
each and every upstream default is.

>>>> why not configure the ip(8) utility the same way, i.e. by setting
>>>> COLORFGBG in files placed in the /etc/profile.d directory,
>>> COLORFGBG where set is automatically set by the terminal emulator. It
>>> would be more sensible to add this feature to more terminal 
>>> emulators,
>>> upstream.
>> 
>> Of course, but that would take a lot of time, both to implement it
>> everywhere and for the new feature to reach the users.  Shipping
>> a few additional files in the /etc/profile.d directory would be a
>> reasonable stopgap measure.
> 
> No, it would be totally broken as explained.

It would be broken only for those users who change their background
color to some light color.  Though, it would be broken even with your
patch applied, right?  I see no difference in the end results, for the
users that reconfigure their terminals that way.

>>> And what about linux virtual terminals (a.k.a non-graphical 
>>> consoles)?
>>> 
>> In my 25+ years of Linux experience, I've never seen one with a
>> background color other than black.
> 
> Which is why it's such a reasonable assumption for iputils2 to male.
> 
> (BTW I have seen non-black vt colors... just happens to be true. But
> not so common)

I saw those on Solaris only.

>>> In summary, if the best we can do is manually set COLORFGBG when 
>>> using
>>> a light background then that's the best we can do. I don't see how
>>> Debian can possibly help with that.
>>> On the iproute2 side, a rock-bottom ultimate default background color
>>> assumption will always be needed and that should be dark.
>> As others already pointed out, "should be light" or "should be dark"
>> can be seen as personal preference.
> 
> It can and should be seen as begging the question of what is more
> common in the reality out there.
> 
> The matter of personal preference is whether deep blue on black is a 
> bad choice.
> 
> What is the more common background color is a question of fact, not
> preference. We don't get to have preferred facts. I just do not know
> how to find out what the fact is, so I must use reserved language and
> say I _think_ dark is more common.

I see, and I do agree to a certain degree, but please see my point
about de facto standards.

