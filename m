Return-Path: <netdev+bounces-273327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCaNI/PqymkkBQYAu9opvQ
	(envelope-from <netdev+bounces-273327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:28:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E936174D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E0B33013259
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509D3A0B31;
	Mon, 30 Mar 2026 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="JeBRqh3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7A393DC0;
	Mon, 30 Mar 2026 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906095; cv=none; b=GhVMB4+HFxKTD9ZdUbSvmqeTRup/JNlCWqKgY0OBY+hdtsAZud/l0b1KrZ/B9WHx4/8BcgM7drqALYcxCvj6aAU4tOk6u5Vcn+dMtLCL8Hml8+eL1ZqeB55gCjdvqtPcoE9MhLHG11NLSNGNhfqgS7X6q+t79isidAXb/u/4EKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906095; c=relaxed/simple;
	bh=RGzzjA3cO5lOP4zYnieGtpbAuRH0n/z6+PkwuEAeOPU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mrMTgUl7S47JJBYA+KrofowSloqfxB/N0PQn4QRhhCq7VQ7lOphOKw5zSofVvXNvPJBMLXaL1EgkYK1S5Io6R46xIAvqgH8InJyWAuFqUesoqIgHMcT5N9F0RRZnbXLGjZvQATtjbkq2EnJNw8gY7x+4rIDb83v0SWfrOGvv9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=JeBRqh3f; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E580A5859;
	Mon, 30 Mar 2026 23:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774906088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6AHq37SYNpV92QtLJ7jyu7yaBhME6ugDGHhS8peisI0=;
	b=JeBRqh3fcBRIldXz+JRAj0ekJgngWRi5/T/ccfn0Bs8/wScwxkmXu/1RomNqPXtGrqe6gl
	Yj3GTM4Uj3WjBqR0ZQAfVdC0qzTLZEyHZSXI8y6tneN55oFRddtL9lzR7B1KVJX0RUWyvR
	8v76jXD2xgZ8RvYw3DTozchbcm7KV2+sgZiq7BWxKpx+ZNRxkVuo1YO/3m4sYVM/HZl21o
	iDg7qQ4yMBrS7a0dZyUCwfn1/jq3sGNMuowyjme2tPt7I5wFfCV5x6h2JY/4KAEdQ98kRy
	PeMRj3iv0TFz0V+qYVbj9y+u0y8iHUbSyO5hc3UVNcSeIZ7gacC/bvWPkd4zWw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 23:28:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <c79a7b7e-9e1c-4b3b-8ef0-2d4144dccc25@gmail.com>
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-5-nb@tipi-net.de>
 <c79a7b7e-9e1c-4b3b-8ef0-2d4144dccc25@gmail.com>
Message-ID: <862233b8c5ad9384201b833f9916e69a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-273327-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.422];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 325E936174D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30.3.2026 20:15, Mohsin Bashir wrote:
>> +static bool
>> +bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>> +			struct xdp_frame *xdpf, bool dma_map)
>> +{
>> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
>> +	struct device *kdev = &priv->pdev->dev;
>> +	struct enet_cb *tx_cb_ptr;
>> +	dma_addr_t mapping;
>> +	unsigned int dma_len;
>> +	u32 len_stat;
>> +
>> +	spin_lock(&ring->lock);
>> +
> 
> So we acquire lock on per-packet basis on the XDP_TX path? Do you think 
> we can batch this?

Patch 4 only has one caller so the lock inside was fine. Patch 5
adds ndo_xdp_xmit which needs batching, so it moves the lock out
to the callers. XDP_TX processes one frame at a time in NAPI context
so batching doesn't apply there.

Note: v5 of this series was posted two days ago [1].

[1] 
https://lore.kernel.org/netdev/20260328230513.415790-1-nb@tipi-net.de/

Thanks
Nicolai

