Return-Path: <netdev+bounces-123343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503096494F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074DC1C2243E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB601B14FF;
	Thu, 29 Aug 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PBsta0pW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823B1B14FA;
	Thu, 29 Aug 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943589; cv=none; b=oTYzrQNApbo+eatuLQvZp2popiBvSQMMQ+4e9DduU4idSgj/cJpRIhuVFrUNzMyX2xBAY9xDZlXI7uLgIqbYzSiTJHccqXosWQG8kepAn6aspywXKnVGdNh6Qa7jz6ECGl6HTcaKQggCtv7QbNA6aC0vkn1XKBQ2+8sHhUXp7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943589; c=relaxed/simple;
	bh=FIrKZ7eFEap29RyzpJNG+rDeVQSYhnoanvSiHXY8nvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+OHYHmKsFlb78TA6TWDrGWIWQd9hTSfvaZLjyIrBR87Bf2Pspr999iRQyaxkq/2fTtA4WHI+VMIRu5V03xG9IzPAV38eES4H9VkItKm7jRsxU4PRsMd7Zijv3QhACdVB0lK4Xguy7Yr6ES31A0ruiaf62hXK30hXptEJhu/OYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBsta0pW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pKAEHrlxI9H+II4MqA/rpzR3mfsca14ExRhLsNlJG8Y=; b=PBsta0pWa97i7SIHSI4lyUGqIB
	bInXMWu8DFRTLrJgzyvVQZT22DLSsxnnabc80wfJye1DORhYnhUrAH9tqP6VOe8S8AaPldb/bH31s
	qehvP8SNl20V4K15MyXH/YwjnWMi6yR1zMtHhQhfLKNc/733wyEdQWn6aWrA7k6t+/UU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjgcL-0062zG-LU; Thu, 29 Aug 2024 16:59:21 +0200
Date: Thu, 29 Aug 2024 16:59:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <f8978a4a-aa9d-4f36-ab40-5068f859bfec@lunn.ch>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-6-shaojijie@huawei.com>
 <20240828183954.39ea827f@kernel.org>
 <b3d6030e-14a3-4d5f-815c-2f105f49ea6a@huawei.com>
 <20240829074339.426e298b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829074339.426e298b@kernel.org>

On Thu, Aug 29, 2024 at 07:43:39AM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 10:40:07 +0800 Jijie Shao wrote:
> > on 2024/8/29 9:39, Jakub Kicinski wrote:
> > > On Tue, 27 Aug 2024 21:14:49 +0800 Jijie Shao wrote:  
> > >> +static int hbg_net_open(struct net_device *dev)
> > >> +{
> > >> +	struct hbg_priv *priv = netdev_priv(dev);
> > >> +
> > >> +	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
> > >> +		return 0;
> > >> +
> > >> +	netif_carrier_off(dev);  
> > > Why clear the carrier during open? You should probably clear it once on
> > > the probe path and then on stop.  
> > 
> > In net_open(), the GMAC is not ready to receive or transmit packets.
> > Therefore, netif_carrier_off() is called.
> > 
> > Packets can be received or transmitted only after the PHY is linked.
> > Therefore, netif_carrier_on() should be called in adjust_link.
> 
> But why are you calling _off() during .ndo_open() ?
> Surely the link is also off before ndo_open is called?

I wounder what driver they copied?

The general trend is .probe() calls netif_carrier_off(). After than,
phylib/phylink is in control of the carrier and the MAC driver does
not touch it. in fact, when using phylink, if you try to change the
carrier, you will get SHOUTED at from Russell.

	Andrew

