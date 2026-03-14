Return-Path: <netdev+bounces-267840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FNG5GI27tWkd4QAAu9opvQ
	(envelope-from <netdev+bounces-267840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:48:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47C28EA76
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26F3C30095C7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0AC37F019;
	Sat, 14 Mar 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jXlK+OI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6A37F012;
	Sat, 14 Mar 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517703; cv=none; b=E+nCjYN4/3exXv6lnyDcYZ2aiKFQb7FWayKNbyEVrwiH0YmnqnLQ3Qi6mK6OZxY+vpe79WD/b3Sk76iXdfbZniQPIBIVYSQqIjM4Rgl6maEbSYdrGXhc90ve/kPc9wn670iiLpA24Yde2Lhzi/YqFbhNrvHFZfwGBwq11hYELs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517703; c=relaxed/simple;
	bh=BRmPvP2djIc9Yo/5niOAz8y1AvHloANjfvMUPdo+SWM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tVEAPEV+kSML1lSleWV1st3i/tX5A+39POffSeIcfLBT1abV4vmfJt3+ML/VfOsthD3WaLhdyviL7l0IPgtBEAasDSud9PMiBm9cQxJuawUIKaa6+NGifApc4exgHVsoAMdDyYnBODcBeyacb3t5itxzkMBx+f53gqtNcrMcbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jXlK+OI1; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13C4FA03C2;
	Sat, 14 Mar 2026 20:48:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773517692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ok9tNM7h4Im+PSk7ldF+1yMBmVwrI9z/4FmaPuam2SA=;
	b=jXlK+OI157yt4ln9lRiDcIv1qC7vYD569l4XzBCa9yOauwMXqkm/s5s1BB2xKJCeHyxZiZ
	O1ObJESiGZdEPfbKwkW/1OfMdqVwag2ee4J7wgZLBsx9pskeL31UlJHcxgQE1QoM03NC7C
	CyKPJPHjBnnUFyf6mUhRstJG3hNJWicpumeAyYR9ZiPOas3y3BKRkHrvHZVhT4NwMhBGQR
	43FlK5J9MZGf/PaQrFd/iw3JdPHrf+F/ClstXRq/A9sHdGREipCPCwQ9KE9pqTux026yg4
	lcyZSUgpjneMpi27GsOZ/9qfYR2LsetEVoBVQI8dbYELGs08nN0sRA0SH+Laew==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Mar 2026 20:48:07 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Eric Biggers <ebiggers@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <mbloch@rooftopnetworks.de>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <e3d33a3e-9552-4f2d-99b6-76a1e203603d@broadcom.com>
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <20260313092101.1344954-4-nb@tipi-net.de>
 <e3d33a3e-9552-4f2d-99b6-76a1e203603d@broadcom.com>
Message-ID: <efdd4208d96c720e34bf314dd1ba5d28@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 5A47C28EA76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.3.2026 23:48, Florian Fainelli wrote:
> On 3/13/26 02:20, Nicolai Buchwitz wrote:
>> Add XDP program attachment via ndo_bpf and execute XDP programs in the
>> RX path. Supported actions:
>> 
>>    - XDP_PASS: build SKB from the (possibly modified) xdp_buff and 
>> pass
>>      to the network stack, handling xdp_adjust_head/tail correctly
>>    - XDP_DROP: return the page to page_pool, no SKB allocated
>>    - XDP_ABORTED: same as DROP with trace_xdp_exception
>> 
>> XDP_TX and XDP_REDIRECT are not yet supported and will return
>> XDP_ABORTED.
>> 
>> The XDP hook runs after the HW error checks but before SKB 
>> construction,
>> so dropped packets avoid all SKB allocation overhead.
>> 
>> Advertise NETDEV_XDP_ACT_BASIC in xdp_features.
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> ---
> 
> [snip]
> 
>> @@ -2345,12 +2397,6 @@ static unsigned int bcmgenet_desc_rx(struct 
>> bcmgenet_rx_ring *ring,
>>   		hard_start = page_address(rx_page) + rx_off;
>>   		status = (struct status_64 *)hard_start;
>>   		dma_length_status = status->length_status;
>> -		if (dev->features & NETIF_F_RXCSUM) {
>> -			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>> -			if (rx_csum) {
>> -				/* defer csum setup to after skb is built */
>> -			}
>> -		}
> 
> Did you intend for that hunk to be deleted?

Yes, (kinda) intentional. Patch 1 moved the csum setup after SKB 
construction
(since we no longer have an SKB at that point), but left the early read
as a dead no-op - patch 3 then removed it. I'll clean this up in v2 by
dropping the dead block directly in patch 1 instead.

Nicolai

