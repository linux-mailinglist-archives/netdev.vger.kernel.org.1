Return-Path: <netdev+bounces-216769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E73B3517C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CF91B60661
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A91F75A6;
	Tue, 26 Aug 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3hp2HnJG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B761FCE;
	Tue, 26 Aug 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174741; cv=none; b=NwUs/Zfre2MP/EIoMSK3aEU/4Z6Msu3+G0iPJpJie0Ucm5QbdcRDRULyJDq3zdPS513xOxfHnBwJDT1hMQF2ErSRO71wjztWkYmEMniquR+Lvw/GWIRhehAKB9mKhrJGQQWBNWIJO/rxW/2pozKTiw5vylm2z501Xmqwjjcc5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174741; c=relaxed/simple;
	bh=76YmnrjD4MciwYymmuQ5KBtrF864lIDkREwJhmkIuwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR2HvD0T2B4daOKq3YQRYiUOzo15PwFX246DWjpiM+ukAi4oIHrSCTmWzTwbP6ICteNCIw1Bb9CUyQrJo/ow/17zeDAY5y6WjWxmb5x6tkF5TmlLM7k1tKnCWejc1PdLtkwjyr/u0Fo76etSrfuWcD5NFOhp/fl4AmAbLkvtY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hp2HnJG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JxbbNRdx7n85CoL4FK3+Au8xkQY9IwHl0isje+BKaWU=; b=3hp2HnJGp8kYtiT5GQP+O3PM05
	UN03952Q+e9TWfgpH4sx12EjDx0T/C2F5ReKO9WdlQihdLqdK1xVlyBlqZtOYEFjLASxqjJQ8Lve7
	odv609CdBhruZCpO6NRFvc4kkqVDtPcU/PhpxyN/jiWe/VfEc9iA99twZhJBOe8Qvez0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqjGq-0061Xv-DR; Tue, 26 Aug 2025 04:18:48 +0200
Date: Tue, 26 Aug 2025 04:18:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <dd494b15-8173-4b17-a631-f19e9dddf9b1@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250825221507.vfvnuaxs7hh2jy7d@skbuf>
 <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>

> > > +static struct sk_buff *
> > > +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> > > +{
> > > +     struct dsa_port *dp = dsa_user_to_port(netdev);
> > > +     unsigned int port = dp->index;
> > > +     __be16 *tag;
> > > +     u16 tx;
> > > +
> > > +     skb_push(skb, YT921X_TAG_LEN);
> > > +     dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> > > +
> > > +     tag = dsa_etype_header_pos_tx(skb);
> > > +
> > > +     /* We might use yt921x_priv::tag_eth_p, but
> > > +      * 1. CPU_TAG_TPID could be configured anyway;
> > > +      * 2. Are you using the right chip?
> >
> > The tag format sort of becomes fixed ABI as soon as user space is able
> > to run "cat /sys/class/net/eth0/dsa/tagging", see "yt921x", and record
> > it to a pcap file. Unless the EtherType bears some other meaning rather
> > than being a fixed value, then if you change it later to some other
> > value than 0x9988, you'd better also change the protocol name to
> > distinguish it from "yt921x".
> >
> 
> "EtherType" here does not necessarily become EtherType; better to
> think it is a key to enable port control over the switch. It could be
> a dynamic random value as long as everyone gets the same value all
> over the kernel, see the setup process of the switch driver. Ideally
> only the remaining content of the tag should become the ABI (and is
> actually enforced by the switch), but making a dynamic "EtherType" is
> clearly a worse idea so I don't know how to clarify the fact...

If i remember correctly, the Marvell switches allow you to set the
EtherType they use. We just use the reset default value. It has been
like this since somewhere around 2008, and nobody has needed another
value.

What use case do you have for using a different value?

	Andrew

