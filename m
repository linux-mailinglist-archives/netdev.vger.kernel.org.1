Return-Path: <netdev+bounces-249448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C6D1942E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 172803065B7B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F775392B63;
	Tue, 13 Jan 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bRljttlM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F035CB73;
	Tue, 13 Jan 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312841; cv=none; b=dNebUpFddBU3/l5JH3cK6xyQtib99K6JAIQTrHyIo3u8lQTishkp304ulllz9GBNXfwz38YNSesDejz2NG0A5Xvi62ZublHcH0o+qRSic9U+yBTWGfM+JgUtacvHG7UEaB0Zek397oMF+FSXz6pCnCFP6cQLMsQKxGswB7xY8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312841; c=relaxed/simple;
	bh=eAsYFhyprHWUdqiRkSJa08ECPPyeqN56Ew9mY98h1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoyf4MrT8LCrmlrEEDCNBrHzaUV0IBe3SvJpxSeNh/2bYFAEl+vLe03QxBB0kFUrFJG0mPINn0gXDLH35mExW17WVD0P0FIyDn98Ee0akmgyPomn6iTz8hSzT+QPJl+WfiRbyTsLHLSuSZa4wBQPbudGSjZYHK2C0rtKg1UjWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bRljttlM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qtQk3v4rRJM84t9rEVAB0irnBh63oX5nb6UzSl4ai5M=; b=bRljttlMN6p/FhKzIi3t2+Y3A2
	0kufUrccpgBgtpX+47gYxWFn6P7ssntYAqerRB73LWJgOHLLJ74W4e2Qre9PNJwFUgA7EqEy9UY5W
	V1Qh2PykgaElvxKqVIMy4GKVAR+2c0p94JX56K3bpTWig7zvZUw2vhh0g5s6zlPj+dpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfewU-002dZq-3P; Tue, 13 Jan 2026 15:00:18 +0100
Date: Tue, 13 Jan 2026 15:00:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: support using
 non-MediaTek DSA switches
Message-ID: <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch>
References: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>

On Tue, Jan 13, 2026 at 03:11:54AM +0000, Daniel Golle wrote:
> MediaTek's Ethernet Frame Engine is tailored for use with their
> switches. This broke checksum and VLAN offloading when attaching a
> DSA switch which does not use MediaTek special tag format.

This has been seen before. The Freescale FEC has similar problems when
combined with a Marvell switch, it cannot find the IP header, and so
checksum offloading does not work.

I thought we solved this be modifying the ndev->feature of the conduit
interface to disable such offloads. But i don't see such code. So i
must be remembering wrongly.

This is assuming the frame engine respects these flags:

/usr/sbin/ethtool -k enp2s0
Features for enp2s0:
rx-checksumming: on
tx-checksumming: on
	tx-checksum-ipv4: on
	tx-checksum-ip-generic: off [fixed]
	tx-checksum-ipv6: on
	tx-checksum-fcoe-crc: off [fixed]
	tx-checksum-sctp: off [fixed]

When you combine a Marvell Ethernet interface with a Marvell switch
offloading works of course. So it probably does require some logic in
the MAC driver to determine if the switch is of the same vendor or
not.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index e68997a29191b..654b707ee27a1 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1459,6 +1459,26 @@ static void setup_tx_buf(struct mtk_eth *eth, struct mtk_tx_buf *tx_buf,
>  	}
>  }
>  
> +static bool mtk_uses_dsa(struct net_device *dev)
> +{
> +#if IS_ENABLED(CONFIG_NET_DSA)
> +	return netdev_uses_dsa(dev) &&
> +	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
> +#else
> +	return false;
> +#endif

I think the concept of determining if the switch is using a specific
tag in order to enable/disable acceleration should be generic. So i
would try to make this an helper in include/next/dsa.h. Any MAC driver
can then use it.

> @@ -1531,7 +1551,7 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
>  		/* tx checksum offload */
>  		if (info->csum)
>  			data |= TX_DMA_CHKSUM_V2;
> -		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
> +		if (mtk_is_netsys_v3_or_greater(eth) && mtk_uses_dsa(dev))
>  			data |= TX_DMA_SPTAG_V3;

This looks to be in the hot path. Do you really want to do this
evaluation on every frame? You can change the tag protocol via sysfs,
however, dsa_tree_change_tag_proto() will only allow you to change the
tag while the conduit interface is down. So it should be safe to look
at the tag protocol once during open, and cache the result somewhere
local, struct mtk_eth? That should avoid a few cache misses.

> @@ -3192,6 +3212,14 @@ static netdev_features_t mtk_fix_features(struct net_device *dev,
>  		}
>  	}
>  
> +	if ((features & NETIF_F_IP_CSUM) &&
> +	    non_mtk_uses_dsa(dev))
> +		features &= ~NETIF_F_IP_CSUM;
> +
> +	if ((features & NETIF_F_IPV6_CSUM) &&
> +	    non_mtk_uses_dsa(dev))
> +		features &= ~NETIF_F_IPV6_CSUM;
> +


When is mtk_fix_features() actually called? I don't know without
looking at the core. You will want it when open is called, when the
tagging protocol is fixed.

	Andrew

