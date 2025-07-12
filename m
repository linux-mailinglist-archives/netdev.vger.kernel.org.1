Return-Path: <netdev+bounces-206328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E50B02AA3
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA417A35FB
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA172749DF;
	Sat, 12 Jul 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b="XFdUpPCs"
X-Original-To: netdev@vger.kernel.org
Received: from novek.ru (unknown [31.204.180.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340C217666;
	Sat, 12 Jul 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.204.180.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752319770; cv=none; b=fEgS6xarkKbCuf7syNNidrxUChXu3XsNa4LU7ffRTISBEL5XXOK/nVhdFRnj3pfJK2ZWSiww7jnuMR66StecGTO8GUhD4KDCm6V3bPcAet+iLZ6FK+U8uOHyo1w52QfVUV1QAiGqWU8SATosLTdEL1xuz0NCWI+ke+bMS6MKNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752319770; c=relaxed/simple;
	bh=A68MIpu2o+3aP80ishkA6hIBQc7sAGWI/79FDp800YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AD9P2N4QtKUd9PMqFFcnNzGRuRC0RhWC+CC4RtreLnNODLa5tRCDLdWuMSy0Z8FV+qrF6gDBGCI76rJbI5xbPkK+S3lkV55VbmPo4xEMhTB9Uj6Kh8w0DuzrcqFlRCXMrDMGaAnUzBAFPoM0VkajnrZrK3U9bnDXyhq8cUhxw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru; spf=pass smtp.mailfrom=novek.ru; dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b=XFdUpPCs; arc=none smtp.client-ip=31.204.180.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novek.ru
Received: from [10.57.205.117] (unknown [161.12.70.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by novek.ru (Postfix) with ESMTPSA id 69E595070E3;
	Sat, 12 Jul 2025 14:39:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru 69E595070E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
	t=1752320362; bh=A68MIpu2o+3aP80ishkA6hIBQc7sAGWI/79FDp800YY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFdUpPCsinUlxK2zAsbzp7ctaH2+owaFXSxcuvzdeC+SHbE/U3TStfX/G1rCamVZD
	 cTMTWKdSOFr4+W77Bs5OwwfIlBwHf9DGbK6hChPSe1X2APwmO8wp9ONLCTkAGC4ObW
	 BwxUKa5ZGRQvF3mHKrKFk5uIVsH+OinUt5CplaN8=
Message-ID: <4379893b-387c-4d39-b5a9-006e1298b583@novek.ru>
Date: Sat, 12 Jul 2025 12:29:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: enetc: remove unnecessary
 CONFIG_FSL_ENETC_PTP_CLOCK check
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: fushi.peng@nxp.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-11-wei.fang@nxp.com>
From: Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <20250711065748.250159-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

On 11.07.2025 07:57, Wei Fang wrote:
> The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
> only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
> safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
>   drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index ef002ed2fdb9..4325eb3d9481 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>   		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
>   	}
>   
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
> -	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
> +	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
>   		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
>   }
>   
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index ce3fed95091b..c65aa7b88122 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
>   {
>   	int hw_idx = i;
>   
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
> +	if (rx_ring->ext_en)
>   		hw_idx = 2 * i;
>   
>   	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
> @@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
>   
>   	new_rxbd++;
>   
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
> +	if (rx_ring->ext_en)
>   		new_rxbd++;
>   
>   	if (unlikely(++new_index == rx_ring->bd_count)) {

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

