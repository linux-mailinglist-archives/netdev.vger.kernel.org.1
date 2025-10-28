Return-Path: <netdev+bounces-233598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9EC1620E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F99D1C24579
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31934B185;
	Tue, 28 Oct 2025 17:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C121346E59;
	Tue, 28 Oct 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672277; cv=none; b=RpvwolCX7pC6CsdTUeNslkug4T1uFU0M0tyriaUZFemM64/jVn9mfsmNOMGL5GVWsP4VWEBRZ48igu97ZG/xAIMvr0zIzjsva0sDMVKl1kHC21M43wTAnWyz++IwCOMCJdDemBUCnZs94AApMjR57ZrLegeVFUGese3ZHWURMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672277; c=relaxed/simple;
	bh=BDlhpu+T4Rp4k38oLWisBDyf4v7KrBVQfdo5tGjha5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB7sIOTgM2RawAHzHHUBgs35rjbljSXHTBM33/rkRlfrQXPpQrKa9G0OZntiZP+Ekng7gz7kfjJI5nw2TSqo5+oh3FrgiJ8eNX5nPbHFyzTHP/AlHP5wc9BIA0FeO8iqnd5eAjb+wa/o2oTX8wtUpFqEL6ERhWTZ7L5TDpqgK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDnQk-000000002HE-31lQ;
	Tue, 28 Oct 2025 17:24:22 +0000
Date: Tue, 28 Oct 2025 17:24:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 11/12] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Message-ID: <aQD8QnK-bnuptPlU@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
 <20251028002841.zja7km3oesczrlo3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028002841.zja7km3oesczrlo3@skbuf>

On Tue, Oct 28, 2025 at 02:28:41AM +0200, Vladimir Oltean wrote:
> On Sun, Oct 26, 2025 at 11:48:23PM +0000, Daniel Golle wrote:
> > Add support for a new DSA tagging protocol driver for the MaxLinear
> > GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
> > special tag inserted between the source MAC address and the EtherType
> > field to indicate the source and destination ports for frames
> > traversing the CPU port.
> > 
> > Implement the tag handling logic to insert the special tag on transmit
> > and parse it on receive.
> > [...]
> > --- /dev/null
> > +++ b/net/dsa/tag_mxl-gsw1xx.c
> > [...]
> > +#define GSW1XX_TX_CLASS_SHIFT		0
> > +#define GSW1XX_TX_CLASS_MASK		GENMASK(3, 0)
> 
> Using FIELD_PREP() would eliminate these _SHIFT definitions and _MASK
> would also go away from the macro names.

Ack, using FIELD_PREP() and FIELD_GET() does improve readability and
I'll use that.

> 
> > +
> > +/* Byte 3 */
> > +#define GSW1XX_TX_PORT_MAP_LOW_SHIFT	0
> > +#define GSW1XX_TX_PORT_MAP_LOW_MASK	GENMASK(7, 0)
> > +
> > +/* Byte 4 */
> > +#define GSW1XX_TX_PORT_MAP_HIGH_SHIFT	0
> > +#define GSW1XX_TX_PORT_MAP_HIGH_MASK	GENMASK(7, 0)
> > +
> > +#define GSW1XX_RX_HEADER_LEN		8
> 
> Usually you use two separate macros when the lengths are not equal, and
> you set .needed_headroom to the largest value.

A single macro
#define GSW1XX_HEADER_LEN			8
will do the trick as they are anyway equal, right?

> > [...]
> > +	u8 *gsw1xx_tag;
> > +
> > +	/* provide additional space 'GSW1XX_TX_HEADER_LEN' bytes */
> > +	skb_push(skb, GSW1XX_TX_HEADER_LEN);
> > +
> > +	/* add space between MAC address and Ethertype */
> > +	dsa_alloc_etype_header(skb, GSW1XX_TX_HEADER_LEN);
> > +
> > +	/* special tag ingress */
> > +	gsw1xx_tag = dsa_etype_header_pos_tx(skb);
> > +	gsw1xx_tag[0] = 0x88;
> > +	gsw1xx_tag[1] = 0xc3;
> 
> Could you write this as a u16 pointer, to make it obvious to everyone
> it's an EtherType, and define the EtherType constant in
> include/uapi/linux/if_ether.h, to make it a bit more visible that it's
> in use?

Defining the EtherType in the appropriate header makes sense (even though
0x88c3 is just the default and configuration of the chip allows to set it
to anything else, or even have it omitted entirely).

Using __be16 to access the tag fields will make the whole thing
sensitive to endianess, which is a bit messy. I would prefer to keep
using u8 type and some shifting and masking of the EtherType constant
similar to how it is done in tag_dsa.c. Also note that the datasheet
describes the special tag byte-by-byte, and there is even a 16-bit field
which crosses word boundaries, GSW1XX_TX_PORT_MAP_LOW and
GSW1XX_TX_PORT_MAP_HIGH (ie. it is obvious that this wasn't intended to
be accessed as 16-bit words). So I'd rather make it easy to understand
how the tag driver matches the datasheet instead of using __be16 just
for the sake of the EtherType.

I've implemented and tested using __be16 now, and it doesn't look very
bad either, especially when skipping the PORT_MAP_HIGH/LOW part because
on the actually produced chips there anyway aren't ever more than 6
ports, so one anyway always only accesses the LOW part of the portmap.

If you like to use __be16 (like eg. the realtek taggers) I will proceed
like that in v4.

> > [...] 
> > +	if (gsw1xx_tag[0] != 0x88 && gsw1xx_tag[1] != 0xc3) {
> > +		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
> > +		dev_warn_ratelimited(&dev->dev,
> > +				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
> > +				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
> > +				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);
> 
> I think you could print the tag with %*ph, according to
> https://elixir.bootlin.com/linux/v6.17.5/source/lib/vsprintf.c#L2453
> (needs testing)

I've tested that and it works fine (looks slightly different of course due
to the missing '0x' prefix, but that doesn't matter for debugging)

> > [...]
> > +	/* remove the GSW1xx special tag between MAC addresses and the current
> > +	 * ethertype field.
> > +	 */
> > +	skb_pull_rcsum(skb, GSW1XX_RX_HEADER_LEN);
> > +	dsa_strip_etype_header(skb, GSW1XX_RX_HEADER_LEN);
> 
> You're not setting skb->offload_fwd_mark but you implement
> port_bridge_join() so you offload L2 switching. If a packet gets flooded
> from port A to the CPU and also to port B, don't you see that the
> software bridge also creates a packet copy that it sends to port B a
> second time?

No, the opposite is true. If I set
dsa_default_offload_fwd_mark(skb);
forwarding between the ports no longer works.
It can well be that this is an existing flaw in the driver, as tag_gswip.c
also doesn't set offload_fwd_mark.

