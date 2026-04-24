Return-Path: <netdev+bounces-280976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCjyCa9J62ntKgAAu9opvQ
	(envelope-from <netdev+bounces-280976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A345D4F7
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51599300737E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56D35DA77;
	Fri, 24 Apr 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XpcOZbkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851838B7A6;
	Fri, 24 Apr 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027256; cv=none; b=NbWZMmhyjyvaMNPWV4M8xvmkUKx6cMGK0LSdppmFB8lAOtBrhcK+aEywF8g1sz08JmRyukkmsp2nGRWphnbLHxwJs8EX+CENRtySCpgnglnnUr144AdAtmw0/4KLyFxkp+S28TkXfG9jgKXkRwu2CDGiQ8vZ7t0wCNqUN5eQ1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027256; c=relaxed/simple;
	bh=ra0spWUlavd514SMAgukniVNiGyiBJxnDLGWIrKLAF4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hNoywO/l+AdNADfkPmJn5ij/EmCy+Hk2oC3mQXb/zNCuIAUxh4eAtnIR+0XZJhof3FHKIu1ekbIfpkvGpiks9fErhsMv3A7Y57snrmvgMwZ+PMGzYdLlT7BkxTVDDYi+/xkDkAQiP6DNPG8FhdnWkQBgIEVyzCMyVEiSf26uY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XpcOZbkv; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFB1CA3C20;
	Fri, 24 Apr 2026 12:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777026648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vjSNcas3jlFNxzs2kV/iQLiDHeyejuhQ73BS26aMrqQ=;
	b=XpcOZbkv3qb3uEFOeHObHiYznmzpFnQxIClQpmlGv+qmxmz/+6R4MfTAlfsd0IOKtcROtl
	kvUQyA99CO8D3ROOLbslmNyR1xcuWkXE4nWmA6LSWkwp2gM+X+kKggk2NeIHiCji6rC4U0
	iYGVyjQDXs/Qvcyy4h/lAjvck834AgUVCZie01BS2XHnzRdWbkeuPWUxkRiQ/vRer7I64I
	Dc1R6DYY5nMwL/fX56pnshGRnKGxz71X7E8Ng4vCps3G5zk4oUzyKJ9YQ4KhnY/ntY3gTV
	fmD+calkQvnxPZ/oR1Ha07kq0NvVbNTdBhMpbCPBwZpKmPKdTh/IvoLPKPvUCA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 12:30:36 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com>
References: <20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com>
Message-ID: <1030f36978e299123c914917a15b934b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C71A345D4F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280976-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Théo,

thanks for your patch.

On 24.4.2026 12:01, Théo Lebrun wrote:
> [...]

> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		dropped = CIRC_CNT(queue->tx_head, queue->tx_tail,
> +				   bp->tx_ring_size);
> +		queue->stats.tx_dropped += dropped;
> +		bp->dev->stats.tx_dropped += dropped;

AFAIUI CIRC_CNT counts descriptor slots, not packets. A fragmented
skb uses multiple slots so tx_dropped would be overcounted?

> +
> +		for (tail = queue->tx_tail; tail != queue->tx_head; tail++)
> +			macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);

I might be missing something, but couldn't this crash on the
macb_alloc_consistent() -> out_err path after a previous close
with in-flight frames?

1. First close: the new loop runs and frees skbs, but tx_head and
    tx_tail are not reset. kfree(tx_skb) sets it to NULL.
2. Second open: macb_alloc_consistent() fails early (e.g. the tx
    dma_alloc_coherent on the first line) and jumps to out_err.
3. macb_free_consistent() runs again. CIRC_CNT is non-zero (stale
    from previous session). macb_tx_skb() dereferences queue->tx_skb
    which is NULL.

Or if the failure happens later, the loop would iterate over a
freshly kmalloc'd (uninitialized) tx_skb array and macb_tx_unmap()
would read garbage mapping/skb pointers.

Maybe reset tx_head = tx_tail = 0 after the loop, or guard with
if (queue->tx_skb)?

> +
>  		kfree(queue->tx_skb);
>  		queue->tx_skb = NULL;
>  		queue->tx_ring = NULL;
> 

> [...]

Thanks,
Nicolai

