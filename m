Return-Path: <netdev+bounces-99142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB6D8D3CF6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F51F23065
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BABE1A0B16;
	Wed, 29 May 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="ip9OWK5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A391A0AED
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000605; cv=none; b=coHGZjtlR9zOH703+/cQCN/jV6oZZAF4m9PyehHbJoEjGf6poxoTlmzK+22+6W6Ju8RBfcCZj+Up+Q/oYx65njxOVEIvSRPPPRJ8E/3a8YwgPM2Nkrt7+5nCX5kvipqwVPnwMktrEV/8PlLoj3auTzAhXAs3N5LRYXgIvn0uMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000605; c=relaxed/simple;
	bh=FwDDMBroZherLDAnHd9LlMyOwagBrnxlKtwM/Qi8Cto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxjH6Z2ra9+aQyH8ERjRbVlhswwKRlQD4Sk8SiaaFFIU40DMAZtJexLeIWpptyYt0rwCAT/psXV4oF7yDyUdMhIRegOrHIHYr70NKyU93ybKJkgu4r9X+eYc6tcoSPw70HJBfjHpNBJ5tudh3P09QZKT6MSkDe3LcauppzP8iAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=ip9OWK5w; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description;
	bh=FwDDMBroZherLDAnHd9LlMyOwagBrnxlKtwM/Qi8Cto=; b=ip9OWK5wlBpAYNjc9RADEswLjH
	z/DXVjOgbxIUn2wDN9shE/Jw7X+bDkmBH1H0N+yf+BfgtgXbjM+GZuX3gY/lRVV4fikYfgKfAu0H2
	8mtL2lRIdaKcelGgKYnjNs3HQ08CgmaH/dyrR5lurBUcSZdrRUjQil3CJK95cR+vmK/TqtpEGsDtM
	H0dhPewuEYqRfzxCD7sLXSbE3DkuztaT3oM/GY5IOAJFexqw/rn5RsXm8RmW+J8cOHne+O11Hxpaq
	5OrEVzeBlrOJtySDtqujlJL7aoWVedp6c2llBpJJjl+DxYti0drAv1ThPXOt0tBYBHcOD9iuAeC4q
	VDBmyWAg==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sCMHz-000t6N-1t;
	Wed, 29 May 2024 16:36:35 +0000
Message-ID: <27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
Date: Thu, 30 May 2024 00:36:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iproute2: color: default to dark background
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
 <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 12:23 AM, David Ahern wrote:

> On 5/22/24 12:43 PM, Gedalya Nie wrote:
>> Since the COLORFGBG environment variable isn't always there, and
>> anyway it seems that terminals and consoles more commonly default
>> to dark backgrounds, make that assumption here.
> Huge assumption. For example, I have one setup that defaults to dark
> mode and another that defaults to light mode.

The code currently assumes light mode and it's generating complaints. It seems like we need to figure out a way to find some support for whatever is the best assumption.

>> Currently the iproute2 tools produce output that is hard to read
>> when color is enabled and the background is dark.
> I agree with that statement, but the tools need to figure out the dark
> vs light and adjust. We can't play games and guess what the right
> default is.
>
That's not possible.

COLORFGBG won't be allowed through by SSH servers.

If you try to write \e]11;?\a to the PTY you need to establish a timeout. There won't always be a response.
I'm not aware of any good way to do this, though I'm certainly not an expert. But I don't think that tools "figuring out dark vs light and adjusting" is a thing. If you just so happen to be happy with your results then so was I until Debian changed the way they build iproute2 and I never even used color overrides -- now I do. Tools just throw colors in your face and no, there is no really good and universally working way to be smart about it.
The fact remains that the code currently makes an assumption and I don't see why it is better than the other way around.
We need some kind of (possibly crude) way to assess what is more common, light or dark. But as I have pointed out already, as long as graphical terminal emulators are concerned, the reality out there is that people use themes and such and the ANSI color codes don't dictate the actual color displayed. But on a linux vt it is easier to say that the background will be dark, and it's neither simple to change the background nor to override the way ANSI colors are displayed.


