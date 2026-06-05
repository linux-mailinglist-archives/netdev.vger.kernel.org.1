Return-Path: <netdev+bounces-295607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDCLA9Q/ImoSUQEAu9opvQ
	(envelope-from <netdev+bounces-295607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E871644D17
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:17:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=O4JDKQHB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295607-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED8A304915C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058E3064B2;
	Fri,  5 Jun 2026 03:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C2BEC27;
	Fri,  5 Jun 2026 03:17:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629431; cv=none; b=BTFcz9tr+uhz5GgilNXduhMkJB57rFg+F0ubGIIZKDLls3y7v/xMibi9VrBZaMj4Mmo1FdtD0gv2YmhDBczUWYJcGpNmM071dImVGo6VHFODaeV8mx39jmb7WCGrh2KnydruZ+aRAVjOwYTWAH9nUTUQU2kFGMJkZK8LnG6PezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629431; c=relaxed/simple;
	bh=xd/9j3/ENuPiwUbFsPg/j2s7qeB5GS10FkVFDPd8i7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uswuSYENICmFOoAZZTq/2jMgQg4sZb1M1ngPEYTl1jvjmLsgcYIacBwcfqGsE/vFAYzlWS57VgNQ/HqeXhB0PeMu0YdGoKi/atMBCdXVqEZkFOX3dxV9BdZznyECFg9KKDXLfVxJMwA8PfrU0p+BvAfwiqBQLcYX1tAfCP+vUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=O4JDKQHB; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1A571171EC;
	Fri,  5 Jun 2026 05:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780629419;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RYCdo5ZX9A+UjzMZvC7m8OuShR08M/FT//5UWv1YUdk=;
	b=O4JDKQHBac5LWiVU8tDEsrZ63KRNrPCl8jfFEVMDj8pi/lQqjVgUI8o3s7D0v9GOLa2J2z
	4nSRRb4YW3NX3ZkSpIzXqDTktp9yl6+nPnf4af3LtZ8rKQbAVn9Y5J+br+vm3VdHpmCa7v
	SXaLIWpSJeQFfyP9nOe8SqUKhcxgNcrXS6mD+cVSmsN/zYA1gtKULnMlgyeqVpaL+ORnsb
	EdGnYkVT/Mavapn2kIhoI2EdIWcRbi1ZgWKnOWaBxpPtIi/ElCXVz/PZCzrl+kgkHmIEdp
	TMEOMz/mmfP0NAQ44U7VsRHdb3Qes3xqYvxLlDY0wm4prE2a85BYPQXBV7jhcA==
Message-ID: <4098dafb-838e-4854-add6-cb3ce6668a70@nabladev.com>
Date: Fri, 5 Jun 2026 05:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lawson.fidelio@gmail.com, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, maxime.chevallier@bootlin.com,
 horms@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Tristram.Ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
 <20260604114119.170747-1-pabeni@redhat.com>
 <20260604193545.0a906598@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260604193545.0a906598@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295607-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:lawson.fidelio@gmail.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,bootlin.com,kernel.org,armlinux.org.uk,vger.kernel.org,tipi-net.de,exotec.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E871644D17

On 6/5/26 4:35 AM, Jakub Kicinski wrote:
> On Thu,  4 Jun 2026 13:41:19 +0200 Paolo Abeni wrote:
>>> @@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
>>>   	switch (tuna->id) {
>>>   	case ETHTOOL_PHY_DOWNSHIFT:
>>>   	case ETHTOOL_PHY_FAST_LINK_DOWN:
>>> +	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
>>> +	case ETHTOOL_PHY_LPF_BW:
>>> +	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
>>>   		if (tuna->len != sizeof(u8) ||
>>>   		    tuna->type_id != ETHTOOL_TUNABLE_U8)
>>>   			return -EINVAL;
>>
>> [Severity: High]
>> Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
>> equalizer tunables?
>>
>> This heavily couples the global API to the 8-bit register layout of the
>> KSZ87xx hardware without defining generic units like Hz for bandwidth.
> 
> AFAIK this is the one comment from AI that survives scrutiny.
> Seems unlikely we'd need more bits, but then again - why not.
> u32 should be our default for integer values, u8 is more for
> booleans.

Why waste memory space if we are already sure the space would not be used.

