Return-Path: <netdev+bounces-224200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DCB8232B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C52A819D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE8311597;
	Wed, 17 Sep 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDDhwxbk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B53112A1;
	Wed, 17 Sep 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149655; cv=none; b=k4qrY/XLmShQodL6W6SAvUK2j1+vK21kL1joj4JDGv0LDaLIm6sAgn/y9A7oOh073nx+JFZu8MIiXX/9s8iC7vF2VXivX3790geEIiAK3ayO1RFlHBMZ2DzdAvx7LILAN9zPcr9DzRRS9B9No8dZkVBXlkFBl7dpD+zf4xV/aWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149655; c=relaxed/simple;
	bh=z5aUyn8esdedtU49mhVPTZw8U7IDxTGO/BUaAI/eVc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYU7geAOtpUZOM11w0sQveLTvxqx1wKRUUVpnvmgJwSeW1mFABPRW0CIlIkRBZztBuCuo1BX1eMApuFiOTH2lXqktGCF7zSmwBHsro2Np+Vmu6TZBicohUKQZtTiwIW2cgLKDzOBynP4iVl3kkrkCFZ8lOD/AjZIPLkZWu6xv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDDhwxbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18268C4CEE7;
	Wed, 17 Sep 2025 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758149653;
	bh=z5aUyn8esdedtU49mhVPTZw8U7IDxTGO/BUaAI/eVc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDDhwxbk05spzhEuUTjELdBpi/vcVfTquXJ0xQRksKIGXbGBQeo8hef4TMeDoMDGU
	 BIpdgHAv8ULGeXAyb0p+7+bEV1Tf2NzDoUjJdbXXZU1OW1PwC76E62ALG8dHeg4FJH
	 5weCZ5b/4Pl3wIMyMdwq4hpEwTVlP6kvgdsKoY+abl76cnVM17bmqgbTGKn5BRTTRf
	 KyLv35rP+AxIajSR3Tl/rP4zxk4GELQYoQtSwyZz6KTVXvucSMSiS31t10zwWgtXBD
	 YElcaWl/dAYvBZnF2wpsTBlMctgMm/0t1KVjZ6b+qkgXPH9wdSqj5gXNfQYEcqFfZi
	 PhBbeDAFr/auw==
Date: Wed, 17 Sep 2025 15:54:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Rohan G Thomas <rohan.g.thomas@intel.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <20250917155412.7b2af4f1@kernel.org>
In-Reply-To: <20250917154920.7925a20d@kernel.org>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
	<20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
	<20250917154920.7925a20d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 15:49:20 -0700 Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 16:17:19 +0800 Rohan G Thomas via B4 Relay wrote:
> > From: Rohan G Thomas <rohan.g.thomas@altera.com>
> > 
> > On hardware with Tx VLAN offload enabled, add the VLAN tag
> > length to the skb length before checking the Qbv maxSDU.
> > Add 4 bytes for 802.1Q an add 8 bytes for 802.1AD tagging.
> > 
> > Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
> > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 8c8ca5999bd8ad369eafa0cd8448a15da55be86b..c06c947ef7764bf40291a556984651f4edd7cb74 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4537,6 +4537,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	bool has_vlan, set_ic;
> >  	int entry, first_tx;
> >  	dma_addr_t des;
> > +	u32 sdu_len;
> >  
> >  	tx_q = &priv->dma_conf.tx_queue[queue];
> >  	txq_stats = &priv->xstats.txq_stats[queue];
> > @@ -4553,13 +4554,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> >  			return stmmac_tso_xmit(skb, dev);
> >  	}
> >  
> > -	if (priv->est && priv->est->enable &&
> > -	    priv->est->max_sdu[queue] &&
> > -	    skb->len > priv->est->max_sdu[queue]){
> > -		priv->xstats.max_sdu_txq_drop[queue]++;
> > -		goto max_sdu_err;
> > -	}
> > -
> >  	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
> >  		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
> >  			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
> > @@ -4575,6 +4569,23 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	/* Check if VLAN can be inserted by HW */
> >  	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
> >  
> > +	sdu_len = skb->len;
> > +	if (has_vlan) {
> > +		/* Add VLAN tag length to sdu length in case of txvlan offload */
> > +		if (priv->dev->features & NETIF_F_HW_VLAN_CTAG_TX)
> > +			sdu_len += VLAN_HLEN;
> > +		if (skb->vlan_proto == htons(ETH_P_8021AD) &&
> > +		    priv->dev->features & NETIF_F_HW_VLAN_STAG_TX)
> > +			sdu_len += VLAN_HLEN;  
> 
> Is the device adding the same VLAN tag twice if the proto is 8021AD?
> It looks like it from the code, but how every strange..
> 
> In any case, it doesn't look like the driver is doing anything with 
> the NETIF_F_HW_VLAN_* flags right? stmmac_vlan_insert() works purely
> off of vlan proto. So I think we should do the same thing here?

I suppose the double tagging depends on the exact SKU but first check
looks unnecessary. Maybe stmmac_vlan_insert() should return the number
of vlans it decided to insert?

> > +	}
> > +
> > +	if (priv->est && priv->est->enable &&
> > +	    priv->est->max_sdu[queue] &&
> > +	    sdu_len > priv->est->max_sdu[queue]) {
> > +		priv->xstats.max_sdu_txq_drop[queue]++;
> > +		goto max_sdu_err;
> > +	}
> > +
> >  	entry = tx_q->cur_tx;
> >  	first_entry = entry;
> >  	WARN_ON(tx_q->tx_skbuff[first_entry]);
> >   
> 


