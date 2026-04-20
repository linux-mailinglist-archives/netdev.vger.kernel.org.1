Return-Path: <netdev+bounces-279742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCMINgEm5mmgsgEAu9opvQ
	(envelope-from <netdev+bounces-279742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:11:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093242B4E0
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B2A301C6EE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB63A0E84;
	Mon, 20 Apr 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0LZUzJJH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB478158535;
	Mon, 20 Apr 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690666; cv=none; b=lulRLFhN75002+ThitLiuBfJtAJ2Ggq7YGHusZUyLs30XhEhOj49NR4BBhd8gFs2gcWVekcPvH2EBk+mPBAgitmcYvVUU5xMemsvYIU7SXLVPyIh2xqWibGq7+Y2LQNZHFGJF2ZMI4egMcTuWCHz8zpp37mueb3L1KQpmKyr46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690666; c=relaxed/simple;
	bh=q/B7vQ8kcYyut4G3uDXNipmdSh3N47249MkEB2d8BaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leTq2fLyapIczrFILuhInW+QnvyTpvdURT++ZOVRPv2DYKWt7t8e/V8Y6utaAxOZr5K0FnoElu3e8zlj26ExGTdgHzOq8cnmW6naCvQNRJPIArN+PnltzSPe04Ws4z+0DdUQuqVLb9WVN6OJWTS+puFGSlCas4ZWZa5q6jFUTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0LZUzJJH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cfFXyz9e+eWwmFCINDndM2LDgyPtAyKfBixNU/3Jklc=; b=0LZUzJJHz5GpxxWPiF74m70dj6
	SlMzg4lUQlciNmbc9KdFaWSZj0xnKrcYTWq5s689U6saniWhzT6qMSWeONdcs6Ol6fMaV2LFDHIMm
	j1Jv2gUSNRlMmvQMeGfBtOd2V3hgnao6N7OI8s5KoU0iDKnupTpO/uD61NlaK0OHDthM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEoOp-00GkDz-2s; Mon, 20 Apr 2026 15:10:51 +0200
Date: Mon, 20 Apr 2026 15:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Message-ID: <c94f23f6-e353-4e88-af91-9e73d70d009d@lunn.ch>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-10-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420021957.1756-10-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-279742-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7093242B4E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
> +	if (if_running)
> +		rtl8169_close(dev);

I assume this releases all the memory from the rings?

> +
> +	tp->num_rx_rings = ch->rx_count;
> +	tp->num_tx_rings = ch->tx_count;
> +
> +	tp->rss_enable = (tp->num_rx_rings > 1 && tp->rss_support);
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

And this tries to allocate the memory needed for the rings? And if the
system is under memory pressure, it fails and your network is dead?

Please modify the code so that is first allocated the new rings and
then frees the old rings, so you can fail gracefully.

     Andrew

