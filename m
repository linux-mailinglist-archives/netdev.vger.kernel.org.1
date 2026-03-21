Return-Path: <netdev+bounces-270257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lq3BSwIv2nRqQMAu9opvQ
	(envelope-from <netdev+bounces-270257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:05:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF32E745A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1769301AA97
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131434B434;
	Sat, 21 Mar 2026 21:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E330EF92;
	Sat, 21 Mar 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127144; cv=none; b=JyH+eZXzc8gQQoBvsJmyvBNQ5TQiBkdAhaMKWrW3VcfAQK1Bm9Fz8s0QpY73ZMi0HI82ak/dtBxQLTQbDureiRWkU6Mx0GjcBzsPh7ndHBIHBJsLQzjHWW+WtbER2sa9KUG8qifPZxza7cVnlpsZLd+IGsgCYIWG10ilNrOm/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127144; c=relaxed/simple;
	bh=cqL4pabk5Mn3pSGlXTZYVKg4cnVN4J58TrX8bmsKJgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSO4+nazlX9qPNULIpx+P6Oi8RPsQQj3JIMnwTG+6NCO8PbJ1D5pm1pZ5FU1Q0cZE/GWz7rU1YfyfqtCGbc9IeprVrqGMxErui0XRtflbIiqV8NlGyJSQ0Vn5bXJE++NaqKYZCz8KJ+CXYl2jlc5HLkGGTdGZjlnin4wb0IA2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w43Vq-000000000x1-3Xvi;
	Sat, 21 Mar 2026 21:05:38 +0000
Date: Sat, 21 Mar 2026 21:05:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC v3 4/4] net: dsa: initial support for MT7628 embedded switch
Message-ID: <ab8IHwC4RfHG5wvv@makrotopia.org>
References: <20260321194340.2140783-1-joey@tinyisr.com>
 <20260321194340.2140783-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321194340.2140783-5-joey@tinyisr.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270257-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEAF32E745A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 09:43:40PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch.
> 
> The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
> port that is internally attached to the SoCs CPU MAC and serves as the
> CPU port.
> 
> The switch hardware has a very limited 16 entry VLAN table. Configuring
> VLANs is the only way to control switch forwarding. Currently 6 entries
> are used by tag_8021q to isolate the ports. Double tag feature is
> enabled to force the switch to append the VLAN tag even if the incoming
> packet is already tagged, this simulates VLAN-unaware functionality and
> simplifies the tagger implementation.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> [...]
> +static int mt7628_setup_internal_mdio(struct dsa_switch *ds,
> +				      struct device_node *node)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc(esw->dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "MT7628 internal MDIO bus";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(ds->dev));
> +	bus->priv = esw;
> +	bus->read = mt7628_mii_read;
> +	bus->write = mt7628_mii_write;
> +	bus->parent = esw->dev;
> +
> +	ret = devm_of_mdiobus_register(esw->dev, bus, node);

As mentioned in the binding comment:
- The MDIO bus is exclusively used to speak with the built-in PHYs.
- The PHY addresses match the port IDs.
- Only Clause-22 read/write operations are supported.
- There is no way to connect an external PHY (no MII interface
  exposed on external pins)

Imho it would hence be much easier to just use DSA's simple .phy_read
and .phy_write operations instead of registering a bus manually in the
driver, and even requiring a description of the MDIO bus in device
tree.

If you want to reserve the option of adding PHY-specific DT properties
in future (eg. for PHY-controlled LEDs? but afair the LEDs are
controlled by the switch itself and SoC-level pinctrl), at least set
`ds->user_mii_bus = bus;` to make the device tree description
optional. Completely omitting the whole bus definition and changing
mt7628_mii_read and mt7628_mii_write to be useful as .phy_read and
.phy_write ops in struct dsa_switch is the better option for simple
legacy hardware like that imho. See b53 driver, for example.

@DSA maintainers: correct me if I'm wrong and, for which ever reason,
using the .phy_read/.phy_write ops is discouraged in new drivers, even
for dead-simple hardware like that one.

