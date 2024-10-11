Return-Path: <netdev+bounces-134699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4599ADFC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B9D1F24008
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4E1D0948;
	Fri, 11 Oct 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="LZ+tSF9W"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2D10A1F;
	Fri, 11 Oct 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681525; cv=none; b=XhC4o6yfzMrw37yivFdSNwDKKloLe5vLZ8wkfz9YQBOVujNoS90BzvkeGk0GSx/DzIT+eeK3zfNsxZmMGDrOE/MekQq26u5I45CzsfrcWA8i5ZldyGxcnxA41vkb5M89AUJRDpTwt1NFFOPvDPiLTseanMBuLSrAVKdKEnpzLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681525; c=relaxed/simple;
	bh=q8fhvin208PWRe3ASvL8VB/S1FAEsxty2mOECPGJkhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ1aW9q02RWaTlWOb+kUP+eOpH6ZBfyHqmHkRRsKl21elDlabzm/d5392zzqSMGvsuU1E98HQY76JAJ4mT/n+06skePl5ytPFZ/05dJD/+qeoLanYRlWt3uhkggA9niyZW+DXeWPmVKBcG11I5kQlMCtPV38piE9cFA+2wKtlA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=LZ+tSF9W; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U4RHv9v6ZhC8cnkTz8y7JlOr/v6zNKbbWEOI5pht8Z0=; b=LZ+tSF9WCSrPPw0HNke0G7Gr07
	NEzrFV5VUbOdNehlee5ZPfU/R3GT/m3SZbBtGUfBKd/NXSRcxAVbLXFec7xoFCWk3ci2nXMjRvFgc
	Vcg8OtSxmJpPwIS0cvscKoNsO7R4bkGwz4f2/DOmR0+Y0BXqmqETD7atP+mOYLLAuawo=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szM5K-000000003cY-0f2y;
	Fri, 11 Oct 2024 22:18:02 +0200
Message-ID: <769f3405-9905-4a26-ba8a-baf30e591f54@engleder-embedded.com>
Date: Fri, 11 Oct 2024 22:17:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mtk_eth_soc: use ethtool_puts
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20241011200225.7403-1-rosenp@gmail.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241011200225.7403-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 11.10.24 22:02, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Tested on Belkin RT1800.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 9aaaaa2a27dc..6d93f64f8748 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -4328,10 +4328,8 @@ static void mtk_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>   	case ETH_SS_STATS: {
>   		struct mtk_mac *mac = netdev_priv(dev);
>   
> -		for (i = 0; i < ARRAY_SIZE(mtk_ethtool_stats); i++) {
> -			memcpy(data, mtk_ethtool_stats[i].str, ETH_GSTRING_LEN);
> -			data += ETH_GSTRING_LEN;
> -		}
> +		for (i = 0; i < ARRAY_SIZE(mtk_ethtool_stats); i++)
> +			ethtool_puts(&data, mtk_ethtool_stats[i].str);

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

