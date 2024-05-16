Return-Path: <netdev+bounces-96714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6885A8C7467
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220192819E5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362F143887;
	Thu, 16 May 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ofNxsnre"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA0143754;
	Thu, 16 May 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854240; cv=none; b=QWEI0mc+5s0QRXSCdmA0O7Jl6Tp5jXv0jlFaL9/2VIdna7KtYKVqbskIXJJpeJr+kgI/6krduP4HqKblhk4+mIfn4TZgWxg1Wtg4uuMI3NIwM/hCGGzm9KIWgT2qulI8mS3kG38HT6QJwGn4x4yXs0P99yjOndPvaXNygc0zt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854240; c=relaxed/simple;
	bh=ugAWDM1qcmrWTtKMSTkkvc0MnR1N8NG07aVhZyc9Avw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHRkGnTEylsf88IMQqOD2/ZZ4r1HecYmECugl48azlE0jq3/pJz/g5wxuNAN6kPBNZgAbxe8MHIH9JN0IeOINwOTR7ybbPR89Vp40cptSJw8XINJGmhyeyUXl4iJSgRET7tudNYi3lmKStZnuLCPFCiktsbvgCPA9o5f8WSBzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ofNxsnre; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715854237;
	bh=ugAWDM1qcmrWTtKMSTkkvc0MnR1N8NG07aVhZyc9Avw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ofNxsnreO1XE/kyXC7ZuR3rY6V4IutCD9oOaUATenbvbQsjVohi9FgRTlITcOb9PZ
	 dNnJPWBBR4z18EGOqiPm1gF1E+VvieBbt4bFQAVqyX7UewABZnh1SsuxxMtpIE3piP
	 qpfXmqZdlGzgC2/IpnR1n3PxjbrI9hx0f/q1BWYpvhaIH4FlDLto4UEYIzyZDhp4Yh
	 2i5McbxDiyUGAkfk2H4sn/dwIx531RWun2FaJjDjVvJmAHQxHwssYJYGsGwv181f//
	 WPFGDeUzq/0Kb45dPjOFyVyT+t/fgwObBv9y5JFs1zIZZPvvwyvvDb1pHQcRlowEbi
	 9ZopzBNxptJ/w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1D90C3780C13;
	Thu, 16 May 2024 10:10:36 +0000 (UTC)
Message-ID: <f9e09d27-4e28-4ed9-95a5-66c8dba6d499@collabora.com>
Date: Thu, 16 May 2024 12:10:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add missing check
 for rhashtable_init
To: Chen Ni <nichen@iscas.ac.cn>, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240516092427.3897322-1-nichen@iscas.ac.cn>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240516092427.3897322-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/05/24 11:24, Chen Ni ha scritto:
> Add check for the return value of rhashtable_init() and return the error
> if it fails in order to catch the error.
> 
> Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/net/ethernet/mediatek/mtk_ppe.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index 0acee405a749..f7e5e6e52cdf 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -884,12 +884,15 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
>   	struct mtk_ppe *ppe;
>   	u32 foe_flow_size;
>   	void *foe;
> +	int ret;
>   
>   	ppe = devm_kzalloc(dev, sizeof(*ppe), GFP_KERNEL);
>   	if (!ppe)
>   		return NULL;
>   
> -	rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	ret = rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	if (ret)
> +		return NULL;

return PTR_ERR(ret);

..then in mtk_eth_soc.c, you will have to fix the check:
			if (!eth->ppe[i]) {

to IS_ERR_OR_NULL( ... )

Cheers,
Angelo

>   
>   	/* need to allocate a separate device, since it PPE DMA access is
>   	 * not coherent.



