Return-Path: <netdev+bounces-266683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA0aCPeLsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:36:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D83266A79
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262DC303E2F1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686F33F5A2;
	Wed, 11 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="na0bOpVr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51A31F9A3
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243364; cv=none; b=NtpddDUeR01x2biCpgVFAsDaF78nJJ0VY1eXNwMLo9JC4U/rlUhmLQ0FeRh6HXCt2IveAAM2J8GuVEBw702GkyLqoF+xVFCZkFtQKhkCkGTlJgNgZvncljmkAV60zB1vnNBVlNENgyCZrGoAHFzJPSgxDZ4qGo7gxlU5GdQ3UqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243364; c=relaxed/simple;
	bh=aIFDm+wj1MnwWVi8m/zngqc8LcZmSluMDGXGFs5i+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8sA5g8Mfd+p5Nz4n1wneiM3yd95P3nMT+5UuIBTYLZe3MBwvaw3WgjoegPXo2EZvOrRLmF6ooSCMHeAxuLStUfiHW07hoQU0P8cmE6X/XUcZgjhbnkeuQr6rj3ut6FaHQyteV3nYqKnPre0jkfw/aUCepb4njMbHq4ymAAMzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=na0bOpVr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FB631A2D72;
	Wed, 11 Mar 2026 15:36:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61BF660004;
	Wed, 11 Mar 2026 15:36:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 644B710368F58;
	Wed, 11 Mar 2026 16:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773243359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MCaWQJMEcm+4uX5U+lNfbT4AOEoWdHPd6YnrMl3k3Ws=;
	b=na0bOpVrbOe9TNUDMGm6PM7G9p+7LJbK3L7uPQQV1yS5ksJ7K65B/YzjLOjXy54mpB43go
	F6M76IVfu5xF0wANGSqZFHxsyvdndZqsNq+VoIOv0ZybhIUS0DC62IOyBZSgpPeiJ+l3eZ
	NeA2dUPNprOc6YckYPy2AxsDEErBa96jrW8lA6nVbq1+u26ycyrbt/cVzo91EimUYFR+Ja
	7gWoR/o/XbgslPPSAB3T6j9s9f/p5lPDa1W3Bxg/h0ByeHeOqQDRdWnoXqnd3U3ZyAj56R
	L7+lZCfIVh3moBPtNtXA7SvW66zOjlsTfE7XB5Sm/WKG+zO2JRUEJXRYWhXJTw==
Message-ID: <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
Date: Wed, 11 Mar 2026 16:35:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 76D83266A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 11/03/2026 16:22, Andrew Lunn wrote:
>> If we take an example with a 10G PHY, we may have :
>>
>> +----SoC-----+
>> |            |
>> |  MAC       |- drivers/net/ethernet
>> |   |        |
>> | Base-R PCS |- could be in drivers/net/pcs, or directly
>> |   |        | in the MAC driver
>> |   |        |
>> |  SerDes    |- May be in drivers/phy, maybe handled by firmware,
>> |   |        |  maybe by the MAC driver, maybe by the PCS driver ?
>> +---|--------+
>>     |
>>     | 10GBase-R
>>     |
>> +---|-PHY+
>> |   |    |
>> | SerDes | \
>> |   |    | |
>> |  PCS   | |
>> |   |    |  > All of that handled by the drivers/net/phy PHY driver
>> |  PMA   | |
>> |   |    | |
>> |  PMD   | /
>> +---|----+
>>     |
>>     v 10GBaseT
> 
> We should also keep in mind this is a "simple" PHY. If you have a PHY
> which does rate adaptation it looks more like:
> 
> +---|-PHY+
> |   |    |
> | SerDes |
> |   |    |
> |  PCS   |
> |   |    |
> |  MAC   |
> |   |    |
> | packet |
> | buffer |
> |   |    |
> |  MAC   |
> |   |    |
> |  PCS   |
> |   |    |
> |  PMA   |
> |   |    |
> |  PMD   |
> +---|----+
>     |
>     v 10GBaseT
> 
> So there is potentially 5 more loopback points?

Good point indeed

> 
> Jakub proposal had the concept of 'depth'. Maybe we need that to
> handle having the same block repeated a few times as you go towards
> the media?

So, the same name + depth ?

 +---|-PHY+
 |   |    |
 | SerDes |
 |   |    |
 |  PCS   | component = PHY, name = "pcs", depth = 0
 |   |    |
 |  MAC   |
 |   |    |
 | packet |
 | buffer |
 |   |    |
 |  MAC   |
 |   |    |
 |  PCS   | component = PHY, name = "pcs", depth = 1
 |   |    |
 |  PMA   |
 |   |    |
 |  PMD   |
 +---|----+
     |
     v 10GBaseT

I think I like this idea of depth + name, as we can consider omitting
the depth information when it's not needed (e.g. simple PHY with 1 PCS),
to keep the API simple.

To continue with your example, with combo-port PHYs we may get multiple
PMA/PMD instances, one per port, that's even more loopback points.

We could potentially associate these with phy_port though ?

> We should also think about when we have a PHY acting as a MII
> converter. You see the Marvell PHY placed between the MAC and the SFP
> cage. That has a collection of blocks which can do loopback. And then
> we could have either a Base-T module/PHY in the cage, with more of the
> same blocks, or a fibre modules with loopback.

For that we have what we need with phy_link_topology, as each PHY has
its index, we should be good to go in that regard hopefully :)

Maxime

