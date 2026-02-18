Return-Path: <netdev+bounces-259333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMOVDp/tlWn7WgIAu9opvQ
	(envelope-from <netdev+bounces-259333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:49:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B1157E05
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A31D1300900E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025ED30AACF;
	Wed, 18 Feb 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pDstrx1/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC1274B46
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433371; cv=none; b=LZqan8/ptCST013R+4DDseGksLWAtBUhPFzu5Ihcm5DQffHU88UgVqjb4x3hZaeBtM5dlFsNaTN31IU6muotqphsmZPkDtwi9SC5KCK3uElUggfpOyCf7nGVjTgOQ90ym7I8zPcKtW3XNUEXoaDHdqDyXustGJmDsYCW+yViFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433371; c=relaxed/simple;
	bh=zLP4yCjA+n3eYM5xRhkl9YiYU69Xgg7J3PG2FHXDe6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUfSNtOOCoeupu8bLo2PTEKAWAob8BOOITRuWpsBBGnblWIM2FaIIa/TBXrcw1TxqlteGwL55FF7d47TpxA9r+sUn6pBxUo8iojojqSxx2CfQyCkeWlM19eV3fxqhUiCskMESVq1Lm1YRa064VcJnWjeo1dHJvqdaPXcn7XeDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pDstrx1/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 96D3E1A0434;
	Wed, 18 Feb 2026 16:49:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 653075FA23;
	Wed, 18 Feb 2026 16:49:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03B5C10368B8F;
	Wed, 18 Feb 2026 17:49:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771433367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BofRtcsPWhiz0cU5t+DtA1Y1xdCvvkgL54tYu8/3ASI=;
	b=pDstrx1/zkZqmgIBnffFGc+ZP5xXWNStMqJ6yvGd4aWqaa7YsDXI6rELX5V9Zdfzp04uwV
	q9/HOK6dVWsDF+ZqOdmn4BACIefun4337LzOb7uhuyQKhErsht70pWmPyTYnwIcATRoLld
	XFZeTxD+liYnwpvohq4R3rpJDevIlals2Rp73lmfcIe6Ed+hY/bstSqSsFjoTN0gVi7OMw
	PDS3UcVcMmBxsVjB7P/8RaNiP5+1wye7xKbwcvL9Yk+UyyMS0NSPPKPk3qihQzWetyuj8y
	V3sxzDctn/MyacNWhfRcOXpBhb/STSIFzQDD55wW6xto6w5PSu0v41oNujQ9fQ==
Message-ID: <6f430fc5-a789-4217-baf2-275a2223ea94@bootlin.com>
Date: Wed, 18 Feb 2026 17:49:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/8] net: dsa: microchip: Add two-step PTP
 support for KSZ8463
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
 <b4997be6-fe03-4ac1-8568-38e0a78dc602@bootlin.com>
 <20260218152551.vnqr7bl7yfrymrke@skbuf>
 <983ba1c7-06d9-4474-ac6f-ef3878b31436@bootlin.com>
 <20260218164710.rimvimmiaqampvy7@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260218164710.rimvimmiaqampvy7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259333-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: A95B1157E05
X-Rspamd-Action: no action



On 2/18/26 5:47 PM, Vladimir Oltean wrote:
> On Wed, Feb 18, 2026 at 05:42:32PM +0100, Bastien Curutchet wrote:
>> On 2/18/26 4:25 PM, Vladimir Oltean wrote:
>>> On Wed, Feb 18, 2026 at 04:21:26PM +0100, Bastien Curutchet wrote:
>>>>> You need to set port->last_tx_is_pdelayresp in the atomic section where
>>>>> you know for sure that there's a single TX timestampable skb in flight.
>>>>> There's no explicit lock which creates that atomic section, but the fact
>>>>> that the worker kthread of the tagger processes work items one by one is
>>>>> what gives you that guarantee.
>>>>
>>>> Thank you for the explanations. I suspected a race condition here but I
>>>> didn't know how to mitigate it. I tested a new version on my side with
>>>> port->last_tx_is_pdelayresp set in the ksz_port_deferred_xmit() worker and
>>>> it works fine.
>>>
>>> Good.
>>>
>>> Next question: if the logic is all in ksz_port_deferred_xmit(), which is
>>> sleepable and sends packets one by one, do you actually need to save the
>>> packet type in port->last_tx_is_pdelayresp? Can't you just keep a local
>>> variable with it?
>>
>> Well, I think I could but it feels like a significant rework of the existing
>> implementation. So far the register location is tied to the struct
>> ksz_ptp_irq, since on all the other switches one interrupt bit is associated
>> with one timestamp only. In fact, even on the KSZ8463 the same logic applies
>> because there are two interrupt bits per port: one for the sync messages and
>> one for the pdelay_req / pdelay_resp messages.
>>
>> If I'm not mistaken, using a local variable here would mean moving the
>> timestamp reading from ksz_ptp_msg_thread_fn() to ksz_port_deferred_xmit().
>> We would then need to check the type of each packet before sending it, in
>> order to know where to read the timestamp after wait_for_completion()
>> returns.
> 
> OK. I no longer had a git tree checked out with these patches, so I
> forgot you need the PTP type in the IRQ handler. It's fine the way you
> plan to send the next version. Thanks for checking.

Ok great, thank you.


Best regards,
Bastien

