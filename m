Return-Path: <netdev+bounces-246560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C6CEE511
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C963000DDA
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A952E975E;
	Fri,  2 Jan 2026 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lUQSooyi"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBC1EBA19
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352842; cv=none; b=fivKY/cTwhI3NDna5mkdN7JL9bD0+g3Z6bm9myBh0IWQvtcicwbWhFYLOCLWK2GgYQeUUfj29S/3ptFJKOUC+8DEAM/NUxZ8pvhkIL9jFwmIJZ3WHKP89thFAuc/J/nG+0/i7xRmizGfwCmXEybXOr6YMGCJZJzhFSQLhkpdAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352842; c=relaxed/simple;
	bh=ekma1JNtY3HapFlGPYJ1yaPfaPBCx4jLHOR+xVZRGXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqRRQM9JJdPl0iMf1+7k9crjMp1HUsqCRZ4+mXbwulnokqEzCa+HZGUYEScA7RUBldow7KnREb2Q88kY9Sjgi/53/IEdn89ozuHZ1H9HWsloCfJjsWSzw/fwaGOdwUPhs/5Fx3R9Xe6IDC/sYT3iHf4iVWro1g4XFj78w4C8GzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lUQSooyi; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6856f6aa-c6b8-4966-9dd2-9bf0315395c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767352837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjCw3B/ZE6UsbRGFFrEOWgoAv9dKcIBGeE3THIAgxpw=;
	b=lUQSooyi39lfIMRVjaV/kmKb7WdyvSWRxBnlGP3xc7CZNiG0dOFmTTzioIzLXkKrGeGHx9
	lasbtDCBKxbzFDV+WYUYuNUwnSsnqm+3PQ9iL5AzpZ0pAi2o/XZImmck8yhSNLNwagcyb2
	drVc+NYVSsYpBIhkYqQwHgaGHcI5Byo=
Date: Fri, 2 Jan 2026 11:20:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: mediatek: add null pointer check for hardware
 offloading
To: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
References: <20251231225206.3212871-1-Sebastian.Wolf@pace-systems.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251231225206.3212871-1-Sebastian.Wolf@pace-systems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/12/2025 22:52, Sebastian Roland Wolf wrote:
> From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
> 
> Add a null pointer check to prevent kernel crashes when hardware
> offloading is active on MediaTek devices.
> 
> In some edge cases, the ethernet pointer or its associated netdev
> element can be NULL. Checking these pointers before access is
> mandatory to avoid segmentation faults and kernel oops.
> 
> This improves the robustness of the validation check for mtk_eth
> ingress devices introduced in commit 73cfd947dbdb ("net: mediatek:
> add support for ingress traffic offloading").
> 
> Fixes: 73cfd947dbdb ("net: mediatek: add support for ingress traffic offloading")
> net: mediatek: Add null pointer check to prevent crashes with active hardware offloading.
> 
> Signed-off-by: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
> ---
>   drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index e9bd32741983..6900ac87e1e9 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -270,7 +270,8 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
>   		flow_rule_match_meta(rule, &match);
>   		if (mtk_is_netsys_v2_or_greater(eth)) {

The code dereferences eth here ...

>   			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
> -			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
> +			if (idev && eth && eth->netdev[0] &&

... but it is checked a couple of lines after.

Even more, the function starts with providing rhahstable to lookup
cookie. I'm really doubt eth can be NULL.
At the same time lack of eth->netdev[0] looks like a design problem,
because according to the code there might be up to 3 netdev devices
registered for ppe.

I'm not familiar with the code, but it would be better to have a splat
of crash to check what was exactly missing, and drgn can help you find
if there were other netdevs available at the moment of crash.

> +			    idev->netdev_ops == eth->netdev[0]->netdev_ops) {
>   				struct mtk_mac *mac = netdev_priv(idev);
>   
>   				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))


