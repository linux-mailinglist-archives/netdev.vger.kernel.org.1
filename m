Return-Path: <netdev+bounces-268721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCBeDxWruWlDMAIAu9opvQ
	(envelope-from <netdev+bounces-268721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:27:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D72B18A0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746C230D1C8D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE433A02F;
	Tue, 17 Mar 2026 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="N+HwWDtK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103682C234A;
	Tue, 17 Mar 2026 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775547; cv=none; b=Z7faxttX4Q37sUI2a9Yx/hDXaFFYk60oICbEyldrk0L2mn638GrIGK3uMxa0DvtB+Sn+UEyvzq5jbF5y0AL6nF5pg1q+H4aEs9B4Tdk3l3stBaEp38eDhRCH5od2NdY78Z6x6QV7PAEV6ZmN/13udjMChujaCH7kXqfTN2ThrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775547; c=relaxed/simple;
	bh=LVtdzrz+CfKQeR9PIzXXHL3xpnIjxt3oa5d7Xk5WDEA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bsAkueMTHHyla7iok1Ki3YMbxASkvLiteOWP6681pQI0zbtS+lRQcIjcp13KYoNNrNTTWsBEFGJQw5tRZLjsUpevCxYhg2HvlT8ZlGmUmCeCIdrq4UNUXnXEFOxDe/aKoUPN1h0OYicBJfJvJ9r1Ttrj4lHHYXKi3FCTS9n+CTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=N+HwWDtK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC72AA5005;
	Tue, 17 Mar 2026 20:25:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773775542; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JtZHJKH8B+jPdquQz03PKnwuqGYHc8VkwThcSvgSfwY=;
	b=N+HwWDtKwGn3F4M/O6m7rcohZgsDJZ3kYMSux6/9RAVle57lrfszCS1NKOO+61XJytL67n
	KRNEXVNPWl/EI+GWn6qiIt0TWoawx6CQI0h9yyuM340/CNKkCjvxBNwJOsL0yAeGcM6Ypd
	ov4sa9RwicNja0jrO9QO06Id5/kwgfgZmqFVC/ynDkNKRsLzaPakxsWfAEKw/VnVrQmQV9
	zfVEvABFhVFw/R/ysschxY8cDDYPq+4gPHFE8e4XLupove7aoXrONbNAiGg75R+dVXVBL7
	5S5MayzkqTRZTRX01icHMSpC2s9RWqcPuNS0U6CcxzoPowvn8vqP/hOAgYHLPQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 20:25:38 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, opendmb@gmail.com, arnd@arndb.de, hkallweit1@gmail.com,
 florian.fainelli@broadcom.com, bhargava.marreddy@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, edumazet@google.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, mbloch@rooftopnetworks.de,
 netdev@vger.kernel.org, davem@davemloft.net,
 rajashekar.hudumula@broadcom.com, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org, vikas.gupta@broadcom.com
Subject: Re: [net-next,v2,4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260317162030.1759004-1-horms@kernel.org>
References: <20260315214914.1555777-5-nb@tipi-net.de>
 <20260317162030.1759004-1-horms@kernel.org>
Message-ID: <a93f7e93293e18e12501839af3c328bf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,broadcom.com,google.com,lunn.ch,redhat.com,rooftopnetworks.de,vger.kernel.org,davemloft.net];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid,linux.dev:url]
X-Rspamd-Queue-Id: 9F8D72B18A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.3.2026 17:20, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see 
> https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: bcmgenet: add XDP_TX support
> 
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
> completion within the RX poll path.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index f6a2567af7cb..922895bc7461 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -3637,6 +3782,7 @@ static void bcmgenet_timeout(struct net_device 
>> *dev, unsigned int txqueue)
>> 
>>  	for (q = 0; q <= priv->hw_params->tx_queues; q++)
>>  		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
>> +	bcmgenet_dump_tx_queue(&priv->tx_rings[DESC_INDEX]);
> 
> Does this trigger an out-of-bounds array access?
> 
> Looking at bcmgenet_dump_tx_queue():
> 
> static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
> {
> 	...
> 	struct netdev_queue *txq = netdev_get_tx_queue(priv->dev, 
> ring->index);
> 	...
> }
> 
> For the XDP TX ring, ring->index is DESC_INDEX (16), so this calls
> netdev_get_tx_queue(priv->dev, 16). But the device only has 5 TX queues
> (indices 0-4), allocated via alloc_etherdev_mqs() with 
> GENET_MAX_MQ_CNT+1=5.
> 
> This means the code accesses dev->_tx[16] which is beyond the allocated
> array, and the returned txq pointer points to memory past the array. 
> This
> is then dereferenced by netif_tx_queue_stopped(txq) which reads 
> txq->state
> from invalid memory.
> 
> In debug builds this triggers DEBUG_NET_WARN_ON_ONCE, and it could 
> crash or
> corrupt data.

I must have overlooked this, when I was refactoring to ring 16 in v2. 
Will be fixed in v3

Thanks
Nicolai

