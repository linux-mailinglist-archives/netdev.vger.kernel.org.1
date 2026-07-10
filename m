Return-Path: <netdev+bounces-306559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ONirHHHzUGro8wIAu9opvQ
	(envelope-from <netdev+bounces-306559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:28:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D7173B3F5
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RWMSyO+J;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306559-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306559-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D32A300D306
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31A8420E80;
	Fri, 10 Jul 2026 13:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9C223323
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:28:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690094; cv=none; b=sdeQju7AuBKiS0VxeC2Eb303OtFu6yDYtifBm9iMC+8xBoGYuYQG7pYPld31Gd3FDdk8j23txdjPvG/bGqPHB1IUKUZs8NSGgwqYMY5l3rkwqT1yH+4pqLbuUrczdclUHlqzIec1KeAp9C6dQOtb+z9/IvNChQKlCCEFj6kG0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690094; c=relaxed/simple;
	bh=pZmSyiar78n/0LuCmNk/GBrwaxL/D4ydZb4zaMp1dY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTYYdkH2cyiWe+Rw9sxXjdC+jnLtGVDQVdUoxUrVhXHvKbHsjt5bAawcLh1ie3Uku2HSXapaGluYK7iZw7vdj6+4nh2eg2d9Z9Bce3ZdSslXFuNflNiY8bB1pziD7DhVqMv6qOE8Fc3oIG8T5EGn9xwAhtwKcMlMrQuJQAeT+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWMSyO+J; arc=none smtp.client-ip=95.215.58.188
Message-ID: <a958c34d-c164-47d0-cd4a-74c696fd1c9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783690090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amL3HvAI8RhjX49cE615AnVjynSnuYoBEAx0wJv5xfc=;
	b=RWMSyO+Jw/f6QJyXJ9jWrmNsjispBHMkNfjbo2s3mADg7EfRlXpqFpo4+H44k+Y5r7qpqu
	8fCiZSAZ7ceB3BuJQRsT+CAnP0LPSlXi8tmPMvCK1CU0BfRmyGr0oWFioG+EQIe5/SsU6l
	zaSQyRHuCdeDm4v/6eUS7U6HWtvGX0E=
Date: Fri, 10 Jul 2026 09:27:51 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: dpaa: always set a valid mode I/F mode
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260706121011.1948906-1-mwalle@kernel.org>
 <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>
 <DJUSHXVKZ0OC.1VDMPW228IYHO@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <DJUSHXVKZ0OC.1VDMPW228IYHO@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D7173B3F5

On 7/10/26 05:39, Michael Walle wrote:
> Hi,
> 
> On Fri Jul 10, 2026 at 1:45 AM CEST, Sean Anderson wrote:
>> On 7/6/26 08:08, Michael Walle wrote:
>>> Before converting to the phylink interface, the init function would have
>>> set the correct mode in the maccfg2.
>>
>> So for reference, the old logic is
>>
>>          if (iface_speed < SPEED_1000)
>>                  tmp |= MACCFG2_NIBBLE_MODE;
>>          else if (iface_speed == SPEED_1000)
>>                  tmp |= MACCFG2_BYTE_MODE;
>>
>> which changes between nibble/byte mode depending on the max link speed
>> (e.g. phylink_interface_max_speed). Notably, neither is set for 2.5G.
> 
> Ahh you're right, I totally missed, that the speed parameter was
> actually max_speed, which was set by
> 
>    priv->speed = phy2speed[macdev->phy_if];
>    priv->max_speed = priv->speed;
> 
> FWIW, in the DPAA RM I have, there is no 2.5G speed. Are you sure,
> there are DTSEC controllers with 2.5Gbps support? The only board I
> found in the device trees is the T1023RDB which is using the memac.

It's listed as an option in the P5020/P5040 RMs (under "SerDes Lane
Assignments and Multiplexing"). Of course despite other parts of the
DPAARM referring to the dTSEC's 2.5G capabilities, the the dTSEC chapter
itself makes no mention of any speed higher than 1G.

As unlike U-Boot, Linux promises backwards compatibility even for
out-of-tree devicetrees, I kept the existing behavior when doing my
conversion on the off chance that someone had a board configured for
2.5G.

Given the similarities of 2.5G "SGMII" and SGMII, I suspect that the
settings should probably be the same for 2.5G as for 1G.

>> Can you try moving this write to dtsec_mac_config?
> 
> That worked! At least for SGMII. I don't have a board with another
> interface to test tough. I'll prepare a new version, making
> phylink_interface_max_speed() public and setting the correct value
> in .mac_config().

Well, we already have switch/case there, so you could just use that
since only RMII would default to nibble mode.

> Alternatively, we could move
> phylink_interface_max_speed() to the header as static inline, but
> that function isn't that small.
> 
>> And check in the RM
>> whether this is configured based on the interface (in which case we should
>> remove it from dtsec_link_up) or the link speed. And please also check what
>> the correct behavior for 2.5G should be.
> 
> This is an excerpt from the RM:
> 
> I/F Mode (bits 22-23):
>   This field determines the type of interface to which the MAC is
>   connected. Its default is 00.

Of course, this implies that it's OK to leave this field as 0, which is probably
why I left the logic as-is. But since you actually tested this (and I just tried
to piece things together from the RMs) we should set it.

>    00 Reserved
>    01 Used for all 10Mbps and 100Mbps speeds
>    10 Used for all 1Gbps speeds
>    11 Reserved
> 
> So you could read it both ways? But since the older driver was using
> the maximum interface speed..
> 
>> At one point I had the P-series RMs downloaded, but it appears I've misplaced
>> them...
> 
> FWIW, I think it's freely available as long as you're logged in with
> your NXP account.

I was at home without access to my NXP account :)

--Sean

> -michael
> 
>>
>> --Sean
>>
>>> After converting, init will just
>>> set 0 as the mode. According to the "QorIQ Data Path Acceleration
>>> Architecture (DPAA) Reference Manual", this is a reserved value. In
>>> fact, this will prevent the PCS to establish a link to a connected SGMII
>>> PHY. In turn, mac_link_up() is never called. Fix it by setting a
>>> non-reserved mode; mac_link_up() will then set the correct mode later.
>>>
>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>> FWIW, I've tested this with a Marvell 88E1112 PHY.
>>>
>>>    drivers/net/ethernet/freescale/fman/fman_dtsec.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> index fe35703c509e..566921d3a884 100644
>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> @@ -402,7 +402,10 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
>>>    	tmp |= MACCFG1_TX_FLOW;
>>>    	iowrite32be(tmp, &regs->maccfg1);
>>>    
>>> -	tmp = 0;
>>> +	/* write a non-reserved mode, otherwise the PCS won't establish a link
>>> +	 * and .mac_link_up() is never called.
>>> +	 */
>>> +	tmp = MACCFG2_NIBBLE_MODE;
>>>    
>>>    	tmp |= (cfg->preamble_len << MACCFG2_PREAMBLE_LENGTH_SHIFT) &
>>>    		MACCFG2_PREAMBLE_LENGTH_MASK;
> 


