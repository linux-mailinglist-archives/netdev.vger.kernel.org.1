Return-Path: <netdev+bounces-255832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLESLmWBgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:50:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7CCB346
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B75F1300EC85
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298ED3587B0;
	Mon,  2 Feb 2026 10:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A527AC57;
	Mon,  2 Feb 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029410; cv=none; b=FajzpvHKxZbFtN6CmHGpmKbSb9VDRDk3YAb7z9KU1JdC4+A8wK+MCFOm3wNlOqgQBa0K6dh75lBgnUCjk+jv3AJzFFuU5odJByxDcbSvtehIv3MJysZBJWYFC1+gDQNy2REzkdM4gsW8lMxon1QoXkkpjwd7OjdxrXW/YgzY6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029410; c=relaxed/simple;
	bh=PrAr4oc7DZafAQph7WxUSFYgWT9PkyhMnMgrH2OP4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlDQ0E2vjmmzNJi/wHjUZ/2nvvxYAyZZnyKRvAQiIdqgUSTLj8RRTRZ1hghPVOTsJRN6V+ZGGO4Voh4rsty9nvzkcRK7QU3Y6ie3+qOCdj9XwNpJBY8+SloELJI0f5v4zNud2m5y4+Aub396maPwiQJsDQ6m3uNJfVbnojTUv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmrVD-000000007vl-0czR;
	Mon, 02 Feb 2026 10:49:55 +0000
Date: Mon, 2 Feb 2026 10:49:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, lxu@maxlinear.com,
	hkallweit1@gmail.com, yweng@maxlinear.com, ajayaraman@maxlinear.com,
	andrew@lunn.ch, netdev@vger.kernel.org, bxu@maxlinear.com,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, chad@monroe.io, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, edumazet@google.com,
	pabeni@redhat.com, cezary.wilmanski@adtran.com, davem@davemloft.net,
	john@phrozen.org, frankwu@gmx.de, jpovazanec@maxlinear.com,
	linux@armlinux.org.uk, fchan@maxlinear.com, horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aYCBS40IO_GwAEBy@makrotopia.org>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
 <20260131175243.1122906-2-kuba@kernel.org>
 <20260202094405.rsojaz5xmorubjfz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202094405.rsojaz5xmorubjfz@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255832-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,maxlinear.com,gmail.com,lunn.ch,vger.kernel.org,monroe.io,google.com,redhat.com,adtran.com,davemloft.net,phrozen.org,gmx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0CC7CCB346
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:44:05AM +0200, Vladimir Oltean wrote:
> On Sat, Jan 31, 2026 at 09:52:44AM -0800, Jakub Kicinski wrote:
> > > +static int mxl862xx_add_single_port_bridge(struct dsa_switch *ds, int port)
> > > +{
> > > +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> > > +	struct dsa_port *dp = dsa_to_port(ds, port);
> > > +	struct mxl862xx_bridge_alloc br_alloc = {};
> > > +	int ret;
> > > +
> > > +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
> > > +	if (ret) {
> > > +		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> > > +		return ret;
> > > +	}
> > > +
> > > +	br_port_cfg.bridge_id = br_alloc.bridge_id;
> > > +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> > > +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> > > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> > > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> > > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> > > +	br_port_cfg.src_mac_learning_disable = true;
> > > +	br_port_cfg.vlan_src_mac_vid_enable = false;
> > > +	br_port_cfg.vlan_dst_mac_vid_enable = false;
> > > +	br_port_cfg.bridge_port_map[0] = cpu_to_le16(BIT(dp->cpu_dp->index));
> > 
> > Can this dereference NULL pointers?
> 
> No. DSA will not make calls to ds->ops->port_setup() with "port" values
> for which dsa_to_port(ds, port) will not find a struct dsa_port *.

So I should again remove the check for !=NULL here and...

> > The dsa_to_port() function can return NULL if the port is not found in
> > the switch tree. The code stores the result in dp but doesn't check if
> > dp is NULL before dereferencing dp->cpu_dp->index.
> > 
> > Looking at include/net/dsa.h, dsa_to_port() returns NULL when the port
> > is not found:
> > 
> >     static inline struct dsa_port *dsa_to_port(struct dsa_switch *ds, int p)
> >     {
> >         struct dsa_switch_tree *dst = ds->dst;
> >         struct dsa_port *dp;
> > 
> >         list_for_each_entry(dp, &dst->ports, list)
> >             if (dp->ds == ds && dp->index == p)
> >                 return dp;
> > 
> >         return NULL;
> >     }
> > 
> > Additionally, even if dp is non-NULL, dp->cpu_dp could also be NULL if
> > the CPU port hasn't been properly assigned during initialization.
> 
> mxl862xx_add_single_port_bridge() has been called when all other port
> types except user ports have been excluded. All user and DSA ports have
> a non-NULL dp->cpu_dp pointer after dsa_tree_setup_cpu_ports() runs,
> i.e. also at the time of ds->ops->port_setup().

here, as well as in mxl862xx_setup_cpu_bridge(), right?

> 
> > > +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> > > +{
> > > +	struct mxl862xx_priv *priv = ds->priv;
> > > +	struct device *dev = ds->dev;
> > > +	struct device_node *mdio_np;
> > > +	struct mii_bus *bus;
> > > +	static int idx;
> > > +	int ret;
> > > +
> > > +	bus = devm_mdiobus_alloc(dev);
> > > +	if (!bus)
> > > +		return -ENOMEM;
> > > +
> > > +	bus->priv = priv;
> > > +	ds->user_mii_bus = bus;
> > > +	bus->name = KBUILD_MODNAME "-mii";
> > > +	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> > 
> > Can concurrent probes race on the idx variable?
> > 
> > The static int idx is shared across all driver instances and accessed
> > without synchronization. If multiple instances of this driver are probed
> > concurrently on different CPU cores, they could race on the idx++
> > operation potentially leading to duplicate MII bus IDs. MII bus IDs must
> > be unique system-wide.
> > 
> > [ ... ]
> 
> Technically ds->ops->setup() runs under dsa2_mutex, but the "static int idx"
> is still not ideal due to the ever-increasing index upon unbinding and
> rebinding.

As mentioned in my reply to Jakub[1] many drivers follow this pattern and it would
imho be a good idea to agree on a convention or even provide a helper function
which names the MII bus for DSA drivers. What do you think?

[1]: https://patchwork.kernel.org/comment/26768088/

> > > +static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
> > > +{
> > > +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> > > +	struct mxl862xx_priv *priv = ds->priv;
> > > +	u16 bridge_port_map = 0;
> > > +	struct dsa_port *dp;
> > > +
> > > +	/* CPU port bridge setup */
> > > +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> > > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> > > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> > > +
> > > +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> > > +	br_port_cfg.src_mac_learning_disable = false;
> > > +	br_port_cfg.vlan_src_mac_vid_enable = true;
> > > +	br_port_cfg.vlan_dst_mac_vid_enable = true;
> > > +
> > > +	/* include all assigned user ports in the CPU portmap */
> > > +	dsa_switch_for_each_user_port(dp, ds) {
> > > +		if (dp->cpu_dp->index != port)
> > > +			continue;
> > 
> > Can dp->cpu_dp be dereferenced safely here?
> > 
> > The code dereferences dp->cpu_dp->index without checking if cpu_dp is
> > NULL. While the DSA framework should ensure user ports have a CPU port
> > assigned during initialization, there is no explicit NULL check. If
> > cpu_dp is NULL for any reason such as incomplete initialization or
> > configuration error, this will cause a NULL pointer dereference and
> > kernel crash.
> 
> No incompletely initialized ports are published to dst->ports.

Will remove the !=NULL check then again, see above.

> 
> > > +	ret = dsa_register_switch(ds);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Is dev_set_drvdata() called too early?
> > 
> > The function calls dev_set_drvdata(dev, ds) before calling
> > dsa_register_switch(ds). If dsa_register_switch() fails, the function
> > returns the error but leaves the driver data pointing to an unregistered
> > switch.
> > 
> > This creates a problem for cleanup paths. The mxl862xx_remove() function
> > retrieves the switch with dev_get_drvdata() and calls
> > dsa_unregister_switch(ds). If probe failed, ds is not NULL so the check
> > passes but the switch was never successfully registered. Similarly,
> > mxl862xx_shutdown() could be called and would also operate on an
> > unregistered switch. While dsa_switch_shutdown() has a check for
> > ds->setup flag that provides some protection, this is fragile and could
> > lead to inconsistent state or crashes in error scenarios.
> > 
> > [Jakub] AI is a bit pedantic about leaving the drvdata pointer in place
> >         but I guess it's not a bad thing to clean up
> 
> Can somebody gently explain what is the point? It is easily testable
> that if mdio_driver :: probe() fails, .remove() or .shutdown() will not
> be called. It really does not matter whether dev_set_drvdata() was
> called or not.

