Return-Path: <netdev+bounces-259240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIKFJwyIlWnqSAIAu9opvQ
	(envelope-from <netdev+bounces-259240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:36:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F73C154C2C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC8D300B055
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC633CE81;
	Wed, 18 Feb 2026 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A1kuHgv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A25B1CB;
	Wed, 18 Feb 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407351; cv=none; b=O06bxt+hanGkfHXUdMchyEGXO+iCVnRb2fpe7mDRklViM1yDSqXo3rTj/iypBFM79u+p08npOZL4umV6RgD8UwNArJt23aLmlYHt63pfPSNi6m9Js5uOhKTTMmQIkxeVAINmhA/gY7DdA9hxBc+eOIZjOCL6/v6nRYKNov3DMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407351; c=relaxed/simple;
	bh=UC89tnAJ/TaJfObea4vuqfLAsYoUeHdpLM/Ry6iKVPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5+on4kBylfZ2iiZJjeNiN6iFZNsFLJKBnfGc2YXQeVLrDY3lqeBJvbwihuESSP7JAmB3CDOXazj+IHHJaktupXn7aqciqSdFVlMMT1aeWumXEnbfauB+cH0OPCMRSD4LgpVJxXf7WS03mPgX8jn19SPRQ4VNcDvoX3evAs/xEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A1kuHgv/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D06CB4E40F41;
	Wed, 18 Feb 2026 09:35:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93E0160738;
	Wed, 18 Feb 2026 09:35:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C542B103688BE;
	Wed, 18 Feb 2026 10:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771407345; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/1pklFYcQL1hVqt59Ida+Q2VbdHjCuaFWFKrwPhmtMg=;
	b=A1kuHgv/oLJe43UGhNiPEWwcT4+YFn2/0F2pBnb2u8Q9tL5yIJa82nQj7GtsDToPFozDX4
	hCjozvQ8s41PuUIy1YKFtf13uNhHYAr07J7F/xcFNsxivrjNnM7KqmRKeYx/t7iBFA9Xre
	vuaQUNGZfePJBgzPAYW30ls8LCK8KVdMUO7/0OUh/k+ILK+zp0jICNc+TO359xaXrErxkP
	vm9h6cFhHo2C2atJwOqSXLhyL8sClrx9yg+yUTwV9Q7HqbcjpWUsKOcIJmdcFDMiopI+Ko
	nmJhhlgHf1pZO/UpkXECwK+fUIkPa206Iq1BetNRaQOJ2voAXn99o8QpiHoVjg==
Message-ID: <d7f94a94-3782-4d34-a3d6-a631a6b020cf@bootlin.com>
Date: Wed, 18 Feb 2026 10:35:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
 <20260129201535.317d90bd@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260129201535.317d90bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259240-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F73C154C2C
X-Rspamd-Action: no action

Hi Jakub,

On 1/30/26 5:15 AM, Jakub Kicinski wrote:
> Sorry for the nit but:
> 
> On Tue, 27 Jan 2026 10:06:47 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>>   	case DSA_TAG_PROTO_KSZ9893:
>>   	case DSA_TAG_PROTO_KSZ9477:
>> +	case DSA_TAG_PROTO_KSZ8463:
>>   	case DSA_TAG_PROTO_LAN937X:
> 
> This..
> 
>>   #define KSZ9477_NAME "ksz9477"
>>   #define KSZ9893_NAME "ksz9893"
>>   #define LAN937X_NAME "lan937x"
>> +#define KSZ8463_NAME "ksz8463"
> 
> this
> 
>> @@ -457,6 +526,7 @@ static struct dsa_tag_driver *dsa_tag_driver_array[] = {
>>   	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
>>   	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),
>>   	&DSA_TAG_DRIVER_NAME(lan937x_netdev_ops),
>> +	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),
> 
> and this - appear to have been alphabetically sorted previously, now
> we're just adding at the end.


Good catch, I'll fix this in next iteration (once net-next re-opens).


Best regards,
Bastien

