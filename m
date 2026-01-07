Return-Path: <netdev+bounces-247816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D02CFEDAD
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094BD32C0D8A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D938E12C;
	Wed,  7 Jan 2026 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r9ToOuIJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BA346ADA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801715; cv=none; b=pcFkQCCGU5X7FK3EWwFnBXDPqg/th/7RGRVdGbSHTx82gM7G1Q2dgOdD1AiyetPED6zfjYwSFL6B7jU6U8gqvBdH+skpXg4WKKJMFuoJ0d11hBF4FHk55JoejXsyyszPWgp14ShnEb635FY5a5dbdPOHpD9HDtYqBRiPg7uOsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801715; c=relaxed/simple;
	bh=L0u9//y6chj8Ld/Y+jYk7y3i1CHKtFQSVNTzQMyKIPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOx2wPgnmrhu5ftjoUcsOPMtUsJXo3C8GFoaGh9bQxrNpqeyVPZd/dFOMu9Q0vq3PfirgWauD3cLpJgwNafYEjbvsdh1sPmltodgGgcvUxcEDlDY0+TMkQsOgX18IhaEyPv3jXuysFIsCL2zjiMSXQB7xSnxcsSzmFbkmnrekpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r9ToOuIJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8DmKPa+Iu6AMQfLki8rghfkvljwdLexCJeQLeL1mYTo=; b=r9ToOuIJsJTXAJY79eKlf0A4ox
	ogiyXSgZkpf5TtfdLK0c2jThn8Ao7Hghl0mZFeJ+/Du6Yk4f7AS9Imfl6NJBQrrD4xpy5Y3/MUykH
	xpBwmqgmkk4ua1VDoVpkc7AsJq4zFuPrr6tZcKewdbnDHfIW/mxevNaLme686HHLZa0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdVyG-001pCr-AW; Wed, 07 Jan 2026 17:01:16 +0100
Date: Wed, 7 Jan 2026 17:01:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Message-ID: <1fc53a59-a4f2-4376-ae06-5947e366ccc4@lunn.ch>
References: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>

> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int port;
> +	__be16 *p;
> +	u16 etype;
> +	u16 tci;
> +
> +	if (unlikely(!pskb_may_pull(skb, KS8995_TAG_LEN))) {
> +		netdev_err(dev, "dropping packet, cannot pull\n");
> +		return NULL;
> +	}
> +
> +	p = dsa_etype_header_pos_rx(skb);
> +	etype = ntohs(p[0]);
> +
> +	if (etype == ETH_P_8021Q) {
> +		/* That's just an ordinary VLAN tag, pass through */
> +		return skb;

Should that actually happen? Normally all frames use the tag, and
anything without a tag we drop because we don't expect it.

> +	}
> +
> +	if ((etype & 0xFFF0U) != ETH_P_8021Q) {
> +		/* Not custom, just pass through */
> +		netdev_dbg(dev, "non-KS8995 ethertype 0x%04x\n", etype);
> +		return skb;
> +	}

Same here.

     Andrew

