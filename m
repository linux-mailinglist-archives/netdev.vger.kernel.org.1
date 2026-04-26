Return-Path: <netdev+bounces-281178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGr6G9Ba7mk4sgAAu9opvQ
	(envelope-from <netdev+bounces-281178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10846AC45
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F994300104C
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA527AC31;
	Sun, 26 Apr 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="awSVN9xK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08D243951;
	Sun, 26 Apr 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777228490; cv=none; b=HndOBHMPXijJCBtS8aMjIDdVUdC9Ng+XoKokQEnxf0cTIYBmzfKdnGTaGep2VL0KIJt6GALI9uvGDHwillFlrYHzZAIa9swXPBkBygdQIBDuCmgPUu6rqt46y2IuCU3rSe1Y9ilcCgzIXLp7R2RgA+NUvG51mO7EvZpJ64DwZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777228490; c=relaxed/simple;
	bh=SH7snzGO1Oqyj8FB8dQS+axja7hQPbAthI2Pp3nxoRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/XaLk/QeEvY8uNsqHJFeYXLSkcNIaJKdUSIPC5owGCfksH79hrBH64QoWeOBeCSDoPZ3AQjRPFTGGsUglnOpI+cgpy0gh8opvWMB8p9s4BoszpmN7WnVyIW+0F2miuXntuVqdVj0lQsl4lnNRYeQjpCZDa3F5YxO/S7RgwlxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=awSVN9xK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QGQIvI2830108;
	Sun, 26 Apr 2026 11:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LsTIyc0FHesrsRM8PCsYgl4nv
	G/DV3+GHkOpG75uv5c=; b=awSVN9xKcmMqSgzMSrPXkfs1JWrYMJDcCC60fBGZz
	H1GaPj7Ga0Q1w27X4mqGBcPAIqa0LntF3tm6OTEKzBRoNyWRiDVYeemunvIjVo+K
	lEu7gGgPwiwWKrJty5g53eK1AN1RMKUU2VhpSkGMoxbwBe/fXhqQz6Pi9xP7HM8b
	oBlh9xVQwCTFzjskFZgfFqLlSug3M8eWY7B0mFnkXrMgMkRhaTTEjzYxBjlKq7hp
	ZupJBbsRZUphcmIiSFPQ0WLgZsvbSBVkXIKoOZ8X4I8bzL8A2w3+55KpB8Jj0BZG
	owsYmh9zsNHX8pJLIPNaX9Mv9iRBFNFkR+1F3CCW6tcpg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dshv88eau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 11:05:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 11:05:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 11:05:51 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 21E993F703F;
	Sun, 26 Apr 2026 11:05:47 -0700 (PDT)
Date: Sun, 26 Apr 2026 23:35:46 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: javen <javen_xu@realsil.com.cn>
CC: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Message-ID: <20260426180546.GA791856@kernel-ep2>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-10-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260420021957.1756-10-javen_xu@realsil.com.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDIwMCBTYWx0ZWRfX3s8WJ2Qs3lt4
 CxdX03evCwdC5W6Cj3aGbgThSFfEPIQAoWj2G41Oxtb+63XWoa75Xt+LxwUAamBf+0OXyVZxjPR
 cIg9U8+FIy6ctfIwzcgj6aJ2PXEXq41UZEsVgpGc9y5c4a1xcbrdwVmvi+CElBgTwbdkY/5ngCj
 Q0OWQ8p+ZT7C0ck3MWhO4+EbMcE2re4Qbf6spL7128Ve4aZcFO2+l4zKVvpd9b5uRPC3mp95MUW
 OGbQnMgyy03A/+RX3Xt6CAgS8IgjjNfpPHF/Ma+1qZLGwek6frH39BaKLdqjCHgZ1iy3w/4KhyC
 RDHoHdkUkolTPAAdWyuX1lMxqqPsirihdRfKQzbaHk7HyQt87Pyum8aLGvUj+9/hZRLgpV+YJqE
 l6sFG1+RGQkUrSA4VHTrHukwEJPdH0VUnxfe577rFEipCLL21itOI0o8jz+8tEOGsYz6FXX9P0O
 h6X2OaO4kPobLtufEMw==
X-Proofpoint-GUID: IHOOcOcg9jSkgUI_2d0BnZZxenOJj6yX
X-Authority-Analysis: v=2.4 cv=ILgyzAvG c=1 sm=1 tr=0 ts=69ee53ff cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=YYF7fsvRAAAA:8
 a=B6RS_f03LED8NFB7mlgA:9 a=CjuIK1q_8ugA:10 a=A1P4WKtVarNJ2X4oDzNE:22
X-Proofpoint-ORIG-GUID: IHOOcOcg9jSkgUI_2d0BnZZxenOJj6yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_06,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 4F10846AC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281178-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Hi,
On 2026-04-20 at 07:49:57, javen (javen_xu@realsil.com.cn) wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch add support for changing rx queues by ethtool. We can set rx
> 1, 2, 4, 8 by ethtool -L eth1 rx num.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6b574fc336d6..57087abe7d88 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6518,6 +6518,72 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_get_channels(struct net_device *dev,
> +				 struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +
> +	ch->max_rx = tp->HwSuppNumRxQueues ? tp->HwSuppNumRxQueues : 1;
> +	ch->max_tx = tp->HwSuppNumTxQueues ? tp->HwSuppNumTxQueues : 1;
> +	ch->max_other = 0;
> +	ch->max_combined = 0;
> +
> +	ch->rx_count = tp->num_rx_rings;
> +	ch->tx_count = tp->num_tx_rings;
> +	ch->other_count = 0;
> +	ch->combined_count = 0;
> +}
> +
> +static int rtl8169_set_channels(struct net_device *dev,
> +				struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	bool if_running = netif_running(dev);
> +	int i;
> +
> +	if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
> +		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (ch->rx_count == 0 || ch->tx_count == 0)
> +		return -EINVAL;
> +	if (ch->rx_count > tp->HwSuppNumRxQueues ||
> +	    ch->tx_count > tp->HwSuppNumTxQueues)
> +		return -EINVAL;
> +	if (ch->other_count || ch->combined_count)
> +		return -EINVAL;
> +
> +	if (ch->rx_count == tp->num_rx_rings &&
> +	    ch->tx_count == tp->num_tx_rings)
> +		return 0;
> +
Revisit the above checks, they are not needed since ethtool code does all these.
> +	if (if_running)
> +		rtl8169_close(dev);
> +
> +	tp->num_rx_rings = ch->rx_count;
> +	tp->num_tx_rings = ch->tx_count;
> +
> +	tp->rss_enable = (tp->num_rx_rings > 1 && tp->rss_support);
Please help me understand your HW..Is there a condition where there are
multi Rx queues but HW do not support RSS? I dont know how traffic is distributed
across queues in that case (maybe - pinning flows to individual queues via
ntuple or TC ?)

Thanks,
Sundeep

> +
> +	for (i = 0; i < tp->HwSuppIndirTblEntries; i++) {
> +		if (tp->rss_enable)
> +			tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +		else
> +			tp->rss_indir_tbl[i] = 0;
> +	}
> +
> +	if (tp->rss_enable)
> +		tp->InitRxDescType = RX_DESC_RING_TYPE_RSS;
> +	else
> +		tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
> +
> +	if (if_running)
> +		return rtl_open(dev);
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -6536,6 +6602,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.nway_reset		= phy_ethtool_nway_reset,
>  	.get_eee		= rtl8169_get_eee,
>  	.set_eee		= rtl8169_set_eee,
> +	.get_channels		= rtl8169_get_channels,
> +	.set_channels		= rtl8169_set_channels,
>  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
>  	.set_link_ksettings	= rtl8169_set_link_ksettings,
>  	.get_ringparam		= rtl8169_get_ringparam,
> -- 
> 2.43.0
> 

