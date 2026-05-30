Return-Path: <netdev+bounces-293313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uInGGp+KGmrT5QgAu9opvQ
	(envelope-from <netdev+bounces-293313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:58:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72360B82C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D79A3011F23
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDB36A017;
	Sat, 30 May 2026 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JJo2ZKhA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007A311C1D
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124316; cv=none; b=XTd9JdAcsMdAJb6QkM8P3avvLYutKp7Stf8fhnTmiejBJvxJMokMHli2j3SyhxevlgMeaSOpZSXpk0yhcgfycK8jqblZXpOnH1GggTJTSCWo66p5oK/JdzmMJFKeXaLV/JqqB7sSGNwDXq2LI5QOitjLOLkR+1ou5VObrt2MSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124316; c=relaxed/simple;
	bh=9GC+nvGm089STHURZhvaw1HjQysmJhqOGo43lkNVNv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki44fKL4z0TFhfS6OS6RAm5+i8fR8AKKrt6vKTdpp25cq+QuBZ/Iu3QCJrbhBX1Epwy3paMJKOKKNHZtn5ZPZyebYCLJfCDXytoe680N7emSjP2eXcx+DBfxvtcmMbfM1BQ0Q8pDKlFZrgcJ7hsUwlAARLw5gI7n6pfH2RuVp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JJo2ZKhA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6CDAE4E42D98;
	Sat, 30 May 2026 06:58:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25CF86073B;
	Sat, 30 May 2026 06:58:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFDE810888650;
	Sat, 30 May 2026 08:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780124310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=x9nvez9wtVVvGLqRBtzT4pg4jyQA0HGsCNg6shTRZ2Y=;
	b=JJo2ZKhA0uokfeXNVjofcZHDUYsQgQthaxmQgCg8Y95pPFO0HquRnlwhANKY4Mp9p8N8ZJ
	200KH6nCYqa9PEf+uWsv4GPHNuNaoVeLQ42oPjIj9dl/27J4yFo2f6BFvCB/euPkPhdQAD
	PixPXEPmFSFTrZXg5PijWJmaFodDTj3+3EQ1fev8nHoe/5IRVmtqBd7aPrr0zkauvSyAJO
	26Cv2a6wEjxs0cCqV8HM1ceXWJMWDJ74K7o8AAWyHQHBQSR2V/3A4xAd8+pyk8dn3CaUyG
	tVRkokIZJo+wSw+qLJkAcp56YKb2PWo+Gl+NcEkxBkYTJuUJyHhR+IIMcL7/Fw==
Message-ID: <4a919501-b3f2-489a-ac9d-a7f8709abf6e@bootlin.com>
Date: Sat, 30 May 2026 08:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 02/10] net: phy: phy_link_topology: Track
 ports in phy_link_topology
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
 <20260521121040.1199622-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260521121040.1199622-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293313-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: BF72360B82C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/21/26 14:10, Maxime Chevallier wrote:
> phy_port is aimed at representing the various physical interfaces of a
> net_device. They can be controlled by various components in the link,
> such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.
> 
> Let's therefore make so we keep track of all the ports connected to a
> netdev in phy_link_topology. The only ports added for now are phy-driven
> ports.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
>  include/linux/phy_link_topology.h   | 18 ++++++++++
>  include/linux/phy_port.h            |  2 ++
>  net/core/dev.c                      |  1 +
>  4 files changed, 74 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index fdfafd951905..207128303ca2 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/phy_link_topology.h>
> +#include <linux/phy_port.h>
>  #include <linux/phy.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/xarray.h>
> @@ -22,6 +23,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
>  	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
>  	topo->next_phy_index = 1;
>  
> +	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
> +	topo->next_port_index = 1;
> +
>  	dev->link_topo = topo;
>  
>  	return 0;
> @@ -44,12 +48,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
>  	return dev->link_topo;
>  }
>  
> +int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
> +{
> +	struct phy_link_topology *topo;
> +	int ret;
> +
> +	topo = phy_link_topo_get_or_alloc(dev);
> +	if (IS_ERR(topo))
> +		return PTR_ERR(topo);
> +
> +	/* Attempt to re-use a previously allocated port_id */
> +	if (port->id)
> +		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);

Sashiko says :

"
  If this port is moved to a different netdev (which has a separate
  topology), and its old port->id happens to be in use by another port
  in the new topology, will xa_insert() return -EBUSY?

  Since there is no fallback to xa_alloc_cyclic() on -EBUSY and the
  stale ID is never reset to 0 upon removal, does this permanently
  prevent the port from attaching to the new topology?
"

So we can't move a port to another netdev, the closest thing we can
conceivably to is unbind/rebind a net_device while the phy_device
stays alive. Even then, we'll be re-adding this ports to a fresh
topology, so no collision risk here.

We don't re-set the port id to 0 upon removal on purpose, as implied
by the comment we try to reuse the id, as a much more common case is
that we attach/detach the phy_device that controls this port during
.ndo_open/close, and we don't want the port id to change at each
link flap

Maxime

