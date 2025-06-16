Return-Path: <netdev+bounces-198053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDBADB160
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6289B188B381
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004222E06F0;
	Mon, 16 Jun 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="avfpS6nZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAB2E06E0;
	Mon, 16 Jun 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079566; cv=none; b=hszTOkOHw6+xKS0cIRF/oY28o+05ARSMkNrmnFaL3FAYde38SO4a3BHXDkbdTtez5IKzxfDW6M/CMiy93aBXp7Mu6ZO/Km9YOqxkt769OuH4/2uBklz8LSeBLMEMqpJUqUD/gRzXC3PvjFnacbpYtRY89aucAtyTL7l6MrpFtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079566; c=relaxed/simple;
	bh=CuYtgieWF4URffDKBDTk16YnYn/RE5FqB0DlCr6y9CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgBwB2LGpO2TROToG6JhCbez8FatQlWEyt0MexH1b4meWf/I7/r4R74hmv3ddRH3+K9UG/dp+tDyyte7a2D6R9JHtHk73hZF4TrMU0Ehc7g8mOkZQTGr7uvj9SelfWLedZ8UAfAp3eEvhetmeOL5QffqFMy0SqNLzvoalZHsQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=avfpS6nZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QDQN6GYwYKn7ZOSeeLgojQdiSLD5+Ckw667EaUGQn3w=; b=avfpS6nZPx9dBOEfOKh6rjQJK8
	2HvqMW3l8yGneKnvb9QJzID+F1h4B8Csv6RK8n8Yo6zQIuaI/vwO8ZOEGYXKl+0fAkYlBe3+TgH1S
	dODfZ0mY8JAWliWP7a4yTzpQCKtYXitfuYkWxuw1CsFJI/HN6mleJRpMy15ngGAouF4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uR9dd-00G2pC-KC; Mon, 16 Jun 2025 15:12:37 +0200
Date: Mon, 16 Jun 2025 15:12:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Message-ID: <4877c76a-d0c1-41d7-95c6-553542e2d9b1@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>
 <729dfa8c-6eca-42c6-b9fd-5333208a0a69@lunn.ch>
 <PAXPR04MB8510A1946372F37B5F97E9F28870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510A1946372F37B5F97E9F28870A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Mon, Jun 16, 2025 at 01:42:08AM +0000, Wei Fang wrote:
> > >  drivers/net/ethernet/freescale/fec_main.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > > b/drivers/net/ethernet/freescale/fec_main.c
> > > index 6b456372de9a..f238cb60aa65 100644
> > > --- a/drivers/net/ethernet/freescale/fec_main.c
> > > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > > @@ -1860,8 +1860,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16
> > queue_id, int budget)
> > >  		    fep->bufdesc_ex &&
> > >  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
> > >  			/* Push and remove the vlan tag */
> > > -			struct vlan_hdr *vlan_header =
> > > -					(struct vlan_hdr *) (data + ETH_HLEN);
> > > +			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
> > 
> > This is not 'obviously correct', so probably the commit message needs expanding.
> > 
> > static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb) {
> > 	return (struct vlan_ethhdr *)skb->data; }
> > 
> > I can see a few lines early:
> > 
> > 		data = skb->data;
> > 
> > but what about the + ETH_HLEN?
> > 
> 
> The type of vlan_header has been changed from "struct vlan_hdr *" to
> "struct vlan_ethhdr *", so it is correct to use skb->data directly.

Doh! I missed that, sorry. Maybe extend the commit message, you
mention skb_vlan_eth_hdr() but you could add something like

... and change the type of vlan_header to struct vlan_ethhdr to take
into account the ethernet header plus vlan header is returned.

With that, please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

