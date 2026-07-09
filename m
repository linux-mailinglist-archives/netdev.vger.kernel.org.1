Return-Path: <netdev+bounces-306093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DsDWOb5gT2oHfgIAu9opvQ
	(envelope-from <netdev+bounces-306093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:50:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F772E7AF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:50:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="eTvWoI/P";
	dkim=pass header.d=redhat.com header.s=google header.b=NF4rGnOu;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306093-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC5C3072D3D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE23EF0CD;
	Thu,  9 Jul 2026 08:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF203EA95C
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586888; cv=none; b=nDGVpjr5u9w6+JaAlPKaOhUnnzX/zg3SO2GHaYNFzp1uJVt4vBBo+zoirQxNm7ouC/GXoA4kJzrmnfKxKxvCYuDUzvd0Y0RMo6ntrBgM43XgFPvZqJlx3SlY4OP03MjKbUtcgqr0iHlYqiUNXqc0dlC44BeVxtOyppK9NGk5j98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586888; c=relaxed/simple;
	bh=/L+tqpwaYO9W0zF/nWpLyI2lH1dRyW25/cwwkrtvFjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImyjZzCJk6sOjj/68nLRQ8AVdF7KJDn9j9XCkiJ9/dafT04FyHIMJfjCaUoUsA4Ax/tPSpZbOePQHRRsIXeSseXpR2HGTu2bSYy0vi5gLt3eLSABgnxPvlowImznYtQ4yAdFXSPi2EqWiGuG+XF4GvQGoQeqoUzY1whbI/m6u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTvWoI/P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NF4rGnOu; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783586885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
	b=eTvWoI/PmjUhg4ylvuzo0ytJEVhiryAyw19hegCI2stkIAVK3rvBDG+q9oNof6eAHlXfEm
	DNP2nOl0PRwgPbrqRYNrjTMGGo8QpWz5nnNFhWQREPforAhdqjQ5/wVBX492pFCdT98YDS
	yERRJ1+Kx1BSwXpmRSmeqLRB/VLTpbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-8d4RxHbVPo-3CZuWs4_pnw-1; Thu, 09 Jul 2026 04:48:04 -0400
X-MC-Unique: 8d4RxHbVPo-3CZuWs4_pnw-1
X-Mimecast-MFC-AGG-ID: 8d4RxHbVPo-3CZuWs4_pnw_1783586883
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493e0042895so9639435e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783586883; x=1784191683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
        b=NF4rGnOuBsGMgTryhWYuj6quxb6GKMPKZR6iYqqK8COomx9ijVgAR6F1S6LGPEVhm2
         GRsg8qjBD1H61Boqw8PP82NaeziAn8gDRRRi3zrTQD7OKBNQif9ssiJaoOFm61KdVGcE
         cR/gYBFEVRHgtc/YTu8/06IXZ2/IIrsrUGI2jWyJI44JFwkOggLHOGXF7qbf4m4t5Ft+
         MTxjl0dlp3N+JTeUtdVmoZgBAvyA7d09mip727jPh6COYjW90XmfpCfwFFMl7uV8bjT9
         Qifdjynowg+lRucb3ZVuguyMWPwzZVs655lF1tsLjqyzZPypN/b8bnPuWZ2IPuBtQPfp
         r4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586883; x=1784191683;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
        b=Aj/2AIycOSbj5q7bADTimVbXMqwqEvYsm23FYHWQYLHvhfSEUIbzOonzMNzpitoKWL
         W2eeFIFFprEkSEQ7JtZe3aalHAzLcPA69Sq7AuUNIjwLS3cqcndURmtBd3JMHrJD2j0/
         IY8v3QrtpzN6dvSQHfojlASsWSD8jPYOIshDq6HAYevPKkw0JxEZUl/IDC7A1wD5m0Xo
         98k+CJRH9EprhLuyLxGoMfKb82JSR1qPYT8ERFwInp7DVOBPZBWLVWsV+ruqPzK2TdYJ
         Jr9Wn7FAm7Kso1WwQRf4O+OwTEFRHxgAR+SGJVSZtnPrzswUg97iMLWafhCTtnDzeQjv
         EW/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBqoAj1t/izXQ8lHdQdYhnTu7rGyMA7mx4aM1vqEjRgH3R/AK3O0nWLKyE/qZMFe5bxpF8ux4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLeFYpKmyCYtnDRrG4pWnUs6qmpJxXDq4DAsA4eNu6dggZ/sK
	B5WNZsr3aRXmNFI+PX9t/Hxhs3aJGTMjBNPRWOT2AyezEWEnNml6GV7r2zLJ+bwmbpGAZPmN+SZ
	Z6aXeF8QHI2sLSnmPkLSs8sDsOscAlMPy9eNxBNO8DOtBd9NM8gPgLlw0Jw==
X-Gm-Gg: AfdE7cmG+ajb6ompffLYorA8xdo5rrIa36Redj70NUIoSdiTe8ZpJpfXwczDq1rAfVH
	icDRsXvMnTclfL44jcdnVW4EHjoO6wXwbZcMKyLBCHboXnu72EYG2zGr7C8oZDep3q6WcfCgubQ
	bdG9SVj8Az8GfMRduvVjJYvnG5jUs/ahDCe9i9PoDnZbYWRt2RrGNBFeHoi+kT/Sm7oFkvIeuE+
	GbrqoFvz2k/nfU72fU6gEbQp/TbCoRiXcPtVJl7NU4aoVkbi63RBkqZaUXSd3bjqbPKXQCL9XQm
	wQdL9oZuT2WS6Dbk3h0jtYtdI7N7Ldo3xlKk+xZsA14mgRSgHGOyS8GaXwBFtQql9ZINkBf5YJl
	6TVwU4HCi5TG/ZkngLe4KFKGgr4qahp4/MowbiAyXfMOucDinHc/V17dYlcQAMAHp1nGU18KwYo
	kPYSQX5+MJhN60
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id 5b1f17b1804b1-493e68d145dmr61356355e9.30.1783586883329;
        Thu, 09 Jul 2026 01:48:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id 5b1f17b1804b1-493e68d145dmr61355965e9.30.1783586882805;
        Thu, 09 Jul 2026 01:48:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a58853sm97520615e9.1.2026.07.09.01.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:48:02 -0700 (PDT)
Message-ID: <656ea643-bf7d-4ad0-9020-7ca3f49f9e82@redhat.com>
Date: Thu, 9 Jul 2026 10:47:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: macb: drop in-flight Tx SKBs on close
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jeff Garzik <jeff@garzik.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
References: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A1F772E7AF

On 7/2/26 5:37 PM, Théo Lebrun wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only close will
> trigger the added expressions. In macb_open() and macb_alloc_consistent()
> failure cases, queues' tx_skb just got allocated and are empty.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> Changes in v4:
> - Drop the skb_drop_reason code. No other Ethernet driver does that and
>   the reasoning (because our stats are broken) is a bad one.
> - Take Rb trailer from Nicolai.
> - Drop <hskinnemoen@atmel.com> email that gets rejected.
> - Rebase upon latest net/main (d8e8b85a85fe).
> - Link to v3: https://patch.msgid.link/20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com
> 
> Changes in v3:
> - Drop stats fixing. A proper fix deserves its own net-next refactoring
>   series to migrate to netdev_stat_ops (ynltool uAPI), which will come
>   in later. We keep the tx_dropped++ because they are safe as every
>   other context is disabled when macb_free_consistent() is called.
> - Rebased to latest net/main (406e8a651a7b), nothing to report.
> - Link to v2: https://patch.msgid.link/20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com
> 
> Changes in v2:
> - Increment tx_dropped stat once per SKB, not once per frame.
> - Reset tx_head & tx_tail to avoid keeping stalled cursors.
> - Fix SKB dropped reasons throughout by adding the reason as parameter
>   to macb_tx_unmap(). This is a new patch. Then the drop-all-on-close
>   fix can use this ability to report we are not consuming SKBs.
> - Add increment to stats->tx_dropped on DMA mapping failure and
>   tx_error_task. Done as separate patches (3 and 4).
> - Rebase upon net/main @ 46f74a3f7d57, nothing to report.
> - Link to v1: https://patch.msgid.link/20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fd282a1700fb..d394f1f43b68 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2668,8 +2668,25 @@ static void macb_free_consistent(struct macb *bp)
>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb = NULL;
> +		if (queue->tx_skb) {
> +			unsigned int dropped = 0, tail;
> +
> +			for (tail = queue->tx_tail; tail != queue->tx_head;
> +			     tail++) {
> +				if (macb_tx_skb(queue, tail)->skb)
> +					dropped++;
> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
> +			}
> +
> +			queue->stats.tx_dropped += dropped;
> +			bp->dev->stats.tx_dropped += dropped;
> +
> +			kfree(queue->tx_skb);
> +			queue->tx_skb = NULL;
> +		}
> +
> +		queue->tx_head = 0;
> +		queue->tx_tail = 0;

Both sashikos noted this could race vs tx_error_task, but it looks like
a pre-existing issue, and I think it should be addressed with a
follow-up patch.

/P


