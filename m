Return-Path: <netdev+bounces-97648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313978CC8EE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55B01F219D8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E331474B8;
	Wed, 22 May 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="gG8Z7TsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85467C081
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416218; cv=none; b=lyTUAU7uiH64wV/gVgVDb9shMnwju2MJjmkP3HfNrTCCI6E/9HYSsI9rjVpS/QOZYzT0W5hiw806TuMcOQEv1fV6Akdl8a51guMTU3gG5ONNZjqzB/5sw0LFH8FBvA6MkGLt84510EEIvwi0j6GGjhnvoG8WkMZ5ZUMfaAbMc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416218; c=relaxed/simple;
	bh=GTY1UL3ISuBXBH1b8ZdpROf0vanIEWsIZCi9JOsQ1hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAr7hex+tQTclZl2gdb/OWpo4w6L0+FKKsLjS/UjilRqotcyd4QHvPve4poH7Au1+6XK8zCtbOS3REtksI36uxq/KCbJvZXG+sCMEpkVOFGF8z9zvM1o+RV3V23GKKsbNEaf81JL77LE6HHDyA2WtLe+CXcyi5uBaXGsTiB4lO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=gG8Z7TsK; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=GTY1UL3ISuBXBH1b8ZdpROf0vanIEWsIZCi9JOsQ1hs=; b=gG8Z7TsKDW30vkqL/e5/Er9us3
	Czkp0sMjI+Lkyma2vmdVlCax12NLARFOvw7N/Cerz1cmN2vgN+99EyeKO8uas+e6Zuvjr1XsgxSDw
	JsAIfZ29DQ4JUlqbQzfJE0A64haZsYb/y8Y5c8b2f2Kx7jzN/HorCbCJL40ztlBzm9E25of/UF58c
	eXmjTCIFax4zkaus5IDir225KTHvyfvqivAlsTrAvklY7JNdT2iIoEORgARPu5sQ/C1dsdFrVcTU6
	ZvHDCj08H+A4oqjq1Upt2K9XJ/LMwlPZbxTjdKx85wIOFb9GntNpbTm2sGAdRerKh8VZOvKok4S/s
	TetWPX3A==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9uGU-000evo-1P;
	Wed, 22 May 2024 22:16:54 +0000
Message-ID: <f0f54f62-1c76-4fb8-8e8e-b2a11049b156@gedalya.net>
Date: Thu, 23 May 2024 06:16:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [resend] color: default to dark background
To: Stephen Hemminger <stephen@networkplumber.org>,
 Dragan Simic <dsimic@manjaro.org>
Cc: netdev@vger.kernel.org
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
 <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
 <20240522143354.0214e054@hermes.local>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <20240522143354.0214e054@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 5:33 AM, Stephen Hemminger wrote:

> The color handling of iproute2 was inherited from other utilities such as vim.
> There doesn't appear to be any library or standardization, all this ad-hoc.

Looking at the vim code, and playing around with the program, I
have a few observations.

The snippet you quoted isn't doing anything brilliant. It just
assumes that certain types of terminals are dark, regardless of
the implementation and configuration. All you can really say is
that terminals are often dark which is what I was saying here in
the first place.

I'm not seeing any justification for assuming dark in certain
cases and light otherwise. The code just happens to be that way.

More importantly, vim does happen to actually work. So far I was
only able to get it to show dark blue on a black background by
setting TERM=ansi.

The results are what is important. Vim has its own various color
palettes and it's a serious full-screen app, uses the terminfo
library, its support for terminals is much more complex than just
two palettes. One way or another, we need to fix this, probably
not by linking against ncurses, and "assuming terminal backgrounds
are light" isn't the nugget of wisdom vim has to offer.


