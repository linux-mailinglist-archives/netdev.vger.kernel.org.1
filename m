Return-Path: <netdev+bounces-214701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B209B2AEFC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795D53B913A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA332C31F;
	Mon, 18 Aug 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PCsinSPX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751132C30D;
	Mon, 18 Aug 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536845; cv=none; b=tYkTUEbLMa2mc5sKkuMaLN/hLxhvdzflC8ZYOa/aueiRDTvE2HOUscV47s8omQpmImik6xYVsQvLcg/+rMm3wEcy3FSl/25FrDVawzirRsyYq+2nwGjVfN3/0FYiuoObk4tPEHSN9dUoFL5TmPd+wLFOGu10uUfqVKLbcdf6NKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536845; c=relaxed/simple;
	bh=hE5t9B6Shi9Ybo0lmLwLwnoyR9TJD3s9+k43+86ILrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdsyP6sNQdav+x9E5r/VRtLWFiwaP2Q0WEwH2/kJdhkeUOPOWiVuNmvyVgKKt50kiO24eFhdSz75ioifdQRG+vqYMIgLQvLqZwigXKYlYPhaT1OUPhuWBf4UvFh63F9nzk7E9NJpBgjn/+0Vrt5AdRagUHCV58MPMQnJsTkCRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PCsinSPX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jlZZQu+WNjwvmLVxsfJzjEiVwK0JBq9B0DUkumWUBhs=; b=PCsinSPXy2ZQR7Nd7BdB7gqzAe
	Cr7HbYwRAlaBS7qk4Vdv5AAfO1lPHoay/KHIShvKjWtUxe5Z7kdExTMWp5zJPwgpTuqLkfWETQI4y
	0Cmhzq51ARbicCj7/ZL+CTlm74rh2KeKwZwzISPh+shFg8jQUYT/uz8uz3GUYB1IlPJ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo3KF-0055GX-EZ; Mon, 18 Aug 2025 19:07:15 +0200
Date: Mon, 18 Aug 2025 19:07:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <2ac97f29-bfc2-4674-9569-278bb4492676@lunn.ch>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
 <20250818162445.1317670-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818162445.1317670-3-mmyangfl@gmail.com>

> +static struct sk_buff *
> +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(netdev);
> +	unsigned int port = dp->index;
> +	struct dsa_port *partner;
> +	__be16 *tag;
> +	u16 tx;
> +
> +	skb_push(skb, YT921X_TAG_LEN);
> +	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	/* We might use yt921x_priv::tag_eth_p, but
> +	 * 1. CPU_TAG_TPID could be configured anyway;
> +	 * 2. Are you using the right chip?
> +	 */
> +	tag[0] = htons(ETH_P_YT921X);
> +	/* Service VLAN tag not used */
> +	tag[1] = 0;
> +	tag[2] = 0;
> +	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
> +	if (dp->hsr_dev)
> +		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
> +			tx |= YT921X_TAG_TX_PORTn(partner->index);

As far as i remember, this was not in v1. When i spotting this in v2
that made me comment you should not add new features in revision of a
patch.

Does the current version of the DSA driver support hsr? Is this
useful? Maybe it would be better to add hsr support as a follow up
patch?

> +static struct sk_buff *
> +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	unsigned int port;
> +	__be16 *tag;
> +	u16 rx;
> +
> +	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> +		return NULL;
> +
> +	tag = (__be16 *)skb->data;
> +
> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[1]);
> +	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
> +		netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
> +		return NULL;
> +	}
> +
> +	port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);
> +	if (unlikely(!skb->dev)) {
> +		netdev_err(netdev, "Cannot locate rx port %u\n", port);
> +		return NULL;
> +	}

O.K. Stop. Think.

You changed the rate limiting to an unlimiting netdev_err().

What is the difference? Under what conditions would you want to use
rate limiting? When would you not use rate limiting?

Please reply and explain why you made this change.

	Andrew

