Return-Path: <netdev+bounces-212281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A0B1EEBC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1501746B3
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC65221F34;
	Fri,  8 Aug 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FFPaZ5Kx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195661F63CD;
	Fri,  8 Aug 2025 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679993; cv=none; b=HCFaDMLPwD3tDnj2IsH/SrJ5mVSH3DMS56YJs26d4pXiLikEttOVXH6EATholIynpXl+dXn8/xIMcvSumtrstuWCxvXCpjcdUQBoh1H9ANYVggMbkyXPitWjhR9+yXwE7RFiG6IRhpw4Cng/kV2yBoOIth89Krg1pO730g6kAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679993; c=relaxed/simple;
	bh=6zB+09k9q/K+mfdFZsTuCT1DPpHDUFQXyuQKS5lyp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0F6lMMT37YyJdSgUbh9glxV4TeZeLGAW9rURNZLszz4HESfvkGHjN/jpISpWCURonN9smJ9+/1gy6JhhhamhvJ5JbT1i6LrEOj2aBWNkI4jeU4h3uCX6AMzXlEWEyyvHNkIoCy6ZVcQm4rpYwPxp3zll5Bfg73t9xynIrBW7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FFPaZ5Kx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G4HKiQec4+nudt9w21R7YT69fpU8DGeinsRM/HaGuos=; b=FFPaZ5KxaTZteVr+zqKgY/GVQw
	mDWvej1OFKwWJ4UZbX4yfXrQzk4yHsL/0O/4t5G3/FWBpZG/wis/DeOWoS93/Qin19oqpqN8alRWU
	3dDoPPjC9C2yB4YVmlNG7EisZHaL3qj7S842Ay1YjAh3iqyotvXPHHcAtXQafuCOMIGE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ukSPn-0044x1-4D; Fri, 08 Aug 2025 21:06:07 +0200
Date: Fri, 8 Aug 2025 21:06:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: tag_yt921x: add support for Motorcomm
 YT921x tags
Message-ID: <1bfb3b4f-eae3-4454-8d61-674bed3a8673@lunn.ch>
References: <20250808173808.273774-1-mmyangfl@gmail.com>
 <20250808173808.273774-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808173808.273774-2-mmyangfl@gmail.com>

On Sat, Aug 09, 2025 at 01:38:02AM +0800, David Yang wrote:
> Add support for Motorcomm YT921x tags, which includes a configurable
> ethertype field (default to 0x9988).

Hi David

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

We are in the merge window at the moment, so you need to post patches
as RFC. And you need to indicate the tree in the Subject: line.

> +#define YT921X_TAG_PORT_ENf	BIT(15)
> +#define YT921X_TAG_RX_PORTf	GENMASK(14, 11)
> +#define YT921X_TAG_TX_PORTf	GENMASK(10, 0)
> +#define  YT921X_TAG_TX_PORTnv(port)	BIT(port)

These lower case letters at the end are unusual. What do they
represent?

> +static struct sk_buff *
> +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(netdev);
> +	__be16 *tag;
> +
> +	skb_push(skb, YT921X_TAG_LEN);
> +	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> +
> +	tag = (__be16 *)(skb->data + 2 * ETH_ALEN);

dsa_etype_header_pos_tx() ?

> +static struct sk_buff *
> +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	__be16 *tag;
> +	u16 rx;
> +	int rx_port;

Reverse Christmas tree. Longest to shortest.

    Andrew

---
pw-bot: cr

