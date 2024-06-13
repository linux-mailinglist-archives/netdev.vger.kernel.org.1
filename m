Return-Path: <netdev+bounces-103176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D85906A57
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB01287B9E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247591428E4;
	Thu, 13 Jun 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sf2Xdutx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090713DB99;
	Thu, 13 Jun 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275565; cv=none; b=HSg1k6lbfmUIgBT/qJHK3CzadcdE62BOV21Lcq5YXPdXYGbk61wc405GnvS2kcGxr2eA3LjCDbc+CVU/ZDuakgCeNF2WfzsP4Efgof5AcZBR/n/jGnE+DqJICFKsIdVfSvQ+IRTHVfBBvdmgWOAWRkjz7zUzwzMQgBKym2ZW/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275565; c=relaxed/simple;
	bh=h3HhNWpSBhM6/iN5PFWNZTn7S3jV9LLHYO1udt3vOvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5wFOY141PcY99phtsiOoCMrPc7TPaN2hAAbbVfWxhESuBO9r97lq8kXsv4E6hfsuhgoT5MJh54ViHMrU33DyYxZVCboAj0POxDtc4uRSpwh8Eea4/l1ZHGtRFmQZJapdGP0oaEKHxNpg9BbtnkN+Yr+JkLZQNBoVWYLtdD2U50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sf2Xdutx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e+9UQV1d9d8KOTY7gdJbPM2YDvK2G13gbviN0cq/CYE=; b=sf2XdutxFvey3XPuvpJP3f7V/R
	MuxpK/NV/vYwyBlVubMTfpEhHCQTvq6YzTiiSv5Npcoee9hEP9PS7VAgFqUea41iExFV0mgPXdMl2
	RinKRQuur9Ni3tOmEvVcf8tR/IPfRH6iNwW2NUPdaFVhbd9LrdtbUjih54tQLeepMyOnVhv/yKCgY
	wsWBG/y/zpbg2qNtoHPN3EPHa+tkCXa2V2mcFWAbXi/l6pNG07fFOiTMGvMTFILO+9hoVvLCx67P8
	2Y2DjIQowBEaEonVYc4GN1jiA+S+FKY0QsDE+jMe+p78KPeDXuzzET5xFMjqxbWjE9WoygvRCfisJ
	e3VY74rQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHhxh-00068q-33;
	Thu, 13 Jun 2024 11:45:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHhxh-0001AC-7C; Thu, 13 Jun 2024 11:45:45 +0100
Date: Thu, 13 Jun 2024 11:45:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Corinna Vinschen <vinschen@redhat.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: Enable TSO on VLANs
Message-ID: <ZmrN2W8Fye450TKs@shell.armlinux.org.uk>
References: <20240613023808.448495-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613023808.448495-1-0x1207@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 10:38:08AM +0800, Furong Xu wrote:
> @@ -4239,16 +4239,32 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct stmmac_txq_stats *txq_stats;
>  	int tmp_pay_len = 0, first_tx;
>  	struct stmmac_tx_queue *tx_q;
> -	bool has_vlan, set_ic;
> +	bool set_ic;
>  	u8 proto_hdr_len, hdr;
>  	u32 pay_len, mss;
>  	dma_addr_t des;
>  	int i;
> +	struct vlan_ethhdr *veth;
>  
>  	tx_q = &priv->dma_conf.tx_queue[queue];
>  	txq_stats = &priv->xstats.txq_stats[queue];
>  	first_tx = tx_q->cur_tx;
>  
> +	if (skb_vlan_tag_present(skb)) {
> +		/* Always insert VLAN tag to SKB payload for TSO frames.
> +		 *
> +		 * Never insert VLAN tag by HW, since segments splited by
> +		 * TSO engine will be un-tagged by mistake.
> +		 */
> +		skb_push(skb, VLAN_HLEN);
> +		memmove(skb->data, skb->data + VLAN_HLEN, ETH_ALEN * 2);
> +
> +		veth = skb_vlan_eth_hdr(skb);
> +		veth->h_vlan_proto = skb->vlan_proto;
> +		veth->h_vlan_TCI = htons(skb_vlan_tag_get(skb));
> +		__vlan_hwaccel_clear_tag(skb);
> +	}

I think drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c::
otx2_sq_append_skb() does something similar, but uses a helper
instead:

        if (skb_shinfo(skb)->gso_size && !is_hw_tso_supported(pfvf, skb)) {
                /* Insert vlan tag before giving pkt to tso */
                if (skb_vlan_tag_present(skb))
                        skb = __vlan_hwaccel_push_inside(skb);
                otx2_sq_append_tso(pfvf, sq, skb, qidx);
                return true;
        }

Maybe __vlan_hwaccel_push_inside() should be used here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

