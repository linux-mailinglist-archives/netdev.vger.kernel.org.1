Return-Path: <netdev+bounces-266241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AFOLaRJsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:41:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947F254F8F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1315B31511ED
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E43C8702;
	Tue, 10 Mar 2026 16:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1E397E86;
	Tue, 10 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160271; cv=none; b=FPuGF2h5YFXURWACENwL7K5F9Bh6eF7uSdu/gj2cN/oXh617f+U11WT6pIOs1LJzlwBYP4n3e476RWzq4h3+hZqNrbm8sKWwNfy3rlvuCrWoaIwxcn8K7maVGfAj0199Z5uA4dvRwe+yGhuBbm554kz1vp8TDNTVYEPrBdWkPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160271; c=relaxed/simple;
	bh=nMc1yGitZ3z8TClppuCHc/RI3mVXUSjTwzJKN1zQHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7Cny0kXdr7/R93rMjfyTFn++0unWY3wWHDSZfc71iiblfYnnh7DAtfc0TEIbiBsrb+U4DBkT5D33GOVgov+GLJGveCElQj2Mjuf33vwOmXDraJbFi+qPACTxjdxS7h0jur3MThDqbWsHOr/ELjViDb1tWSWe+WeTFXoymk8OAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vzzyw-000000004zb-3z4g;
	Tue, 10 Mar 2026 16:30:55 +0000
Date: Tue, 10 Mar 2026 16:30:51 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <abBHO9f3oqkgyW5e@makrotopia.org>
References: <cover.1773102942.git.daniel@makrotopia.org>
 <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
 <20260310155340.urq5nudvdxrl6sfx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310155340.urq5nudvdxrl6sfx@skbuf>
X-Rspamd-Queue-Id: 6947F254F8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266241-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.744];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 05:53:40PM +0200, Vladimir Oltean wrote:
> Hi Daniel,
> 
> On Tue, Mar 10, 2026 at 12:40:29AM +0000, Daniel Golle wrote:
> >  * drop manually resetting port learning state on bridge<->standalone
> >    transitions, DSA framework takes care of that
> (...)
> > +	/* Revert leaving port to its single-port bridge */
> > +	if (!join) {
> > +		dp = dsa_to_port(ds, port);
> > +
> > +		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> > +		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> > +		priv->ports[port].flood_block = 0;
> > +		priv->ports[port].learning = false;
> 
> So is this needed or not? Change log says "drop" but code says "keep".
> 
> The core does:
> dsa_port_bridge_leave()
> -> dsa_port_switchdev_unsync_attrs()
>    -> dsa_port_clear_brport_flags()
>       -> dsa_port_bridge_flags() // BR_LEARNING in mask and not in val

Sorry, I just forgot to remove it there. It should not be needed, but
I'll rebuild and test without it to be sure.

> 
> > +		ret = mxl862xx_set_bridge_port(ds, port);
> > +		if (err)
> > +			ret = err;
> > +
> > +		mxl862xx_port_fast_age(ds, port);
> > +	}
> (...)
> >  * manually mxl862xx_port_fast_age() in mxl862xx_port_stp_state_set()
> >    to avoid FDB poisoning due to race condition
> (...)
> > +	/* Revert leaving port to its single-port bridge */
> > +	if (!join) {
> > +		dp = dsa_to_port(ds, port);
> > +
> > +		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> > +		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> > +		priv->ports[port].flood_block = 0;
> > +		priv->ports[port].learning = false;
> > +		ret = mxl862xx_set_bridge_port(ds, port);
> > +		if (err)
> > +			ret = err;
> > +
> > +		mxl862xx_port_fast_age(ds, port);
> > +	}
> 
> I only requested this to be done on mxl862xx_port_stp_state_set(), as a
> consequence to your workaround, not on mxl862xx_port_bridge_leave() ->
> mxl862xx_update_bridge().

I'll remove that then, it was already present in v1.

> 
> The framework actually has logic to fast age the FDB. A standalone port
> is in BR_STATE_FORWARDING, and a leaving/joining bridge port goes
> through BR_STATE_DISABLED - del_nbp() -> br_stp_disable_port().
> So we have a guaranteed STP transition based on which this hook runs:
> 
> dsa_port_switchdev_unsync_attrs():
> 	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
> 	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
> 	 */
> 	dsa_port_set_state_now(dp, BR_STATE_FORWARDING, true);
> ->
> 		/* Fast age FDB entries or flush appropriate forwarding database
> 		 * for the given port, if we are moving it from Learning or
> 		 * Forwarding state, to Disabled or Blocking or Listening state.
> 		 * Ports that were standalone before the STP state change don't
> 		 * need to fast age the FDB, since address learning is off in
> 		 * standalone mode.
> 		 */
> 
> 		if ((dp->stp_state == BR_STATE_LEARNING ||
> 		     dp->stp_state == BR_STATE_FORWARDING) &&
> 		    (state == BR_STATE_DISABLED ||
> 		     state == BR_STATE_BLOCKING ||
> 		     state == BR_STATE_LISTENING))
> 			dsa_port_fast_age(dp);
> 
> so I think fast aging is unnecessary here.
> 
> Your workaround is different, DSA doesn't know that
> dsa_port_set_state(BR_STATE_LEARNING) with dp->learning == false
> actually temporarily enables learning. It assumes it doesn't, so it
> doesn't call dsa_port_fast_age(). That's why you have to do it.

Understood. Thank you for explaining the context in detail.

> 
> 
> Did you reply to my comment from v1 to remove the "bool join" false
> sharing from mxl862xx_update_bridge()? Because you didn't, and I'm not
> sure why.

I wanted to reply to that but then forgot...
You sample code below makes it much more clear also what you meant,
and I will follow your suggestion in v3.


> 
> I meant to see:
> 
> static int mxl862xx_sync_bridge_members(struct dsa_switch *ds,
> 					struct mxl862xx_bridge *mxlbridge)
> {
> 	struct mxl862xx_priv *priv = ds->priv;
> 	int member, ret = 0;
> 
> 	/* Update all current bridge members' portmaps */
> 	for_each_set_bit(member, mxlbridge->portmap,
> 			 MXL862XX_MAX_BRIDGE_PORTS) {
> 		struct dsa_port *dp = dsa_to_port(ds, member);
> 		int err;
> 
> 		/* Build portmap: CPU port + all bridge members except self */
> 		bitmap_copy(priv->ports[member].portmap, mxlbridge->portmap,
> 			    MXL862XX_MAX_BRIDGE_PORTS);
> 		__clear_bit(member, priv->ports[member].portmap);
> 		__set_bit(dp->cpu_dp->index, priv->ports[member].portmap);
> 
> 		err = mxl862xx_set_bridge_port(ds, member);
> 		if (err)
> 			ret = err;
> 	}
> 
> 	return ret;
> }
> 
> static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
> 				     struct dsa_bridge bridge,
> 				     bool *tx_fwd_offload,
> 				     struct netlink_ext_ack *extack)
> {
> 	struct mxl862xx_bridge *mxlbridge;
> 
> 	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> 	if (!mxlbridge) {
> 		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
> 		if (IS_ERR(mxlbridge))
> 			return PTR_ERR(mxlbridge);
> 	}
> 
> 	__set_bit(port, mxlbridge->portmap);
> 	priv->ports[port].bridge = mxlbridge;
> 
> 	/* The operation may fail mid way and there is no way to restore
> 	 * the driver in sync with a known FW state. So we consider FW
> 	 * I/O failure as catastrophic, no point to complicate the
> 	 * driver by restoring mxlbridge->portmap or the bridge pointer.
> 	 */
> 	return mxl862xx_sync_bridge_members(ds, mxlbridge);
> }
> 
> static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
> 				       struct dsa_bridge bridge)
> {
> 	struct dsa_port *dp = dsa_to_port(ds, port);
> 	struct mxl862xx_bridge *mxlbridge;
> 	int err;
> 
> 	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> 	if (!mxlbridge)
> 		return;
> 
> 	__clear_bit(port, mxlbridge->portmap);
> 	priv->ports[port].bridge = NULL;
> 
> 	err = mxl862xx_sync_bridge_members(ds, mxlbridge);
> 	if (err) {
> 		dev_err(ds->dev,
> 			"failed to sync bridge members after port %d left: %pe\n",
> 			port, ERR_PTR(err));
> 	}
> 
> 	/* Revert leaving port, omitted by the sync above, to its
> 	 * single-port bridge
> 	 */
> 	bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> 	__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> 	priv->ports[port].flood_block = 0;
> 	err = mxl862xx_set_bridge_port(ds, port);
> 	if (err) {
> 		dev_err(ds->dev,
> 			"failed to update bridge port %d state: %pe\n", port,
> 			ERR_PTR(err));
> 	}
> 
> 	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> 	if (bitmap_empty(mxlbridge->portmap, MXL862XX_MAX_BRIDGE_PORTS))
> 		mxl862xx_free_bridge(ds, mxlbridge);
> }

