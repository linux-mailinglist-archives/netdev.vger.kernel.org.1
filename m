Return-Path: <netdev+bounces-259331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwyB1nslWkXWgIAu9opvQ
	(envelope-from <netdev+bounces-259331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:44:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9B157D4F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A556300D166
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89033E345;
	Wed, 18 Feb 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZySGNd2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A83019BE;
	Wed, 18 Feb 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432963; cv=none; b=RBp3w/CyTIAHBkpB7Ir5wgpU70QYRhij/Ibmcb61WecUGJbC3Tqe+5WobJiM4FjmY2CWMRv9KNxfenZa7dM504Ry/LsTQ3nxT9g+ivYvP5YFvhWJdJ6OpqOG2BjgvtJFtzOK27oDpXjcHwKH+9D+fXg4WnAfXlHUOHzIVnDlXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432963; c=relaxed/simple;
	bh=hb79GXATBY0nO7ZfD0Alv1F48zIdia4/tYJWli/lWjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0IAmYNWD00Pqx2VGi8QOaJ5Cs0wmVIq0P+y5E7WACdKrENXJpUN2VN8hFZmQwqhnooo5/zCEdb2QRbPOo179jNBAC86Ol5N9LHHV/r/44WUvsV7YyovOIKTQJFP8yYTS/7BtZXLFQRo8UTgZynhp0CQ2OQWvLn9CwtE3lbJGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZySGNd2L; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6436EC63A10;
	Wed, 18 Feb 2026 16:42:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E7E75FA23;
	Wed, 18 Feb 2026 16:42:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 669A510368BFB;
	Wed, 18 Feb 2026 17:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771432957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=c7VImAKfrCSUXGyoTP17lKBBme+4xwNllcBjTdVddUY=;
	b=ZySGNd2Lp3w5+d7u7TZQvf3z/nSfz1DRi9Ow25SnIPhVPW2FUlqqxRDhyrqd25IgIRQ9jd
	mFjSSCe47aHCRg4mB119nC+9iOmo16BeBss+m+74k8tdHO92iCQX7iZguvALE8u+ytuFtu
	+hkIcpVa0xuoIU+dwPL5DEg/9ufC7L40s/9r16EmvLimCWaAthq4Y3sAtjBrfIjRf7gGRB
	5ip/QK4Jbxj2z+QqNiEaNMIGZG2v7uSl3ociMxHcr138w6CQM8kgxuBLJAHercNZQAoB7F
	RaftfnLrsfLdGyjc76r1E/loTmStiD+2L4rXmrXqWqh3CfRo9zMDerz9uwJJIg==
Message-ID: <983ba1c7-06d9-4474-ac6f-ef3878b31436@bootlin.com>
Date: Wed, 18 Feb 2026 17:42:32 +0100
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
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260218152551.vnqr7bl7yfrymrke@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259331-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 6CA9B157D4F
X-Rspamd-Action: no action

On 2/18/26 4:25 PM, Vladimir Oltean wrote:
> On Wed, Feb 18, 2026 at 04:21:26PM +0100, Bastien Curutchet wrote:
>>> You need to set port->last_tx_is_pdelayresp in the atomic section where
>>> you know for sure that there's a single TX timestampable skb in flight.
>>> There's no explicit lock which creates that atomic section, but the fact
>>> that the worker kthread of the tagger processes work items one by one is
>>> what gives you that guarantee.
>>
>> Thank you for the explanations. I suspected a race condition here but I
>> didn't know how to mitigate it. I tested a new version on my side with
>> port->last_tx_is_pdelayresp set in the ksz_port_deferred_xmit() worker and
>> it works fine.
> 
> Good.
> 
> Next question: if the logic is all in ksz_port_deferred_xmit(), which is
> sleepable and sends packets one by one, do you actually need to save the
> packet type in port->last_tx_is_pdelayresp? Can't you just keep a local
> variable with it?

Well, I think I could but it feels like a significant rework of the 
existing implementation. So far the register location is tied to the 
struct ksz_ptp_irq, since on all the other switches one interrupt bit is 
associated with one timestamp only. In fact, even on the KSZ8463 the 
same logic applies because there are two interrupt bits per port: one 
for the sync messages and one for the pdelay_req / pdelay_resp messages.

If I'm not mistaken, using a local variable here would mean moving the 
timestamp reading from ksz_ptp_msg_thread_fn() to 
ksz_port_deferred_xmit(). We would then need to check the type of each 
packet before sending it, in order to know where to read the timestamp 
after wait_for_completion() returns.



Best regards,
Bastien

