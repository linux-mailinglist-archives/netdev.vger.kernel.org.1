Return-Path: <netdev+bounces-257798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBnRGajTh2mTdgQAu9opvQ
	(envelope-from <netdev+bounces-257798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 01:07:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F91076FF
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 01:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B65D30160E1
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4A4C9D;
	Sun,  8 Feb 2026 00:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689471FD4;
	Sun,  8 Feb 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770509218; cv=none; b=Nek9jznZ4TqlBjVVNedrfLDQ1ycr6o2J6KzGNPZscvwkwUFYtMcIY6uhnbFIo9jgH4jWmNccR0E6UwIn9kRCi5x+soWOGn9btsrWXGmvkOdX4MoRLa/2B44CI6WqDIU23iZrZTqRuNK4/6ajhkX5glaVv56zcG2pgEz21tpbtww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770509218; c=relaxed/simple;
	bh=HEuRv9yTtRl6sHMC2RKh4CDTkHLLVecluzq6wjSj2sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhlgmrSawdjauQnWRnC15ycNxcfenC8iRyToPls4ruD6i4ZOA+p5HMje1EQO8MhHMcD+Y7quIlF+q4Qm87j2sP6Q/AFom76dZuOQOL+p3EGqvkiwx1TqiCZKqOebj08UGD81ShqK7Kx2YKy+SU0Dmb7gIDuccvROrmk/Zh8iWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vosK4-000000007Cx-2JQD;
	Sun, 08 Feb 2026 00:06:44 +0000
Date: Sun, 8 Feb 2026 00:06:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v14 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aYfTkEg4ijo_qjqJ@makrotopia.org>
References: <cover.1770433307.git.daniel@makrotopia.org>
 <ccde07e8cf33d8ae243000013b57cfaa2695e0a9.1770433307.git.daniel@makrotopia.org>
 <20260207215902.mtsg43zeoadqqfz5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207215902.mtsg43zeoadqqfz5@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.6:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.5:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E7F91076FF
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 11:59:02PM +0200, Vladimir Oltean wrote:
> On Sat, Feb 07, 2026 at 03:07:27AM +0000, Daniel Golle wrote:
> > +/* PHY access via firmware relay */
> > +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> > +				 int devadd, int reg)
> > +{
> > +	struct mdio_relay_data param = {
> > +		.phy = port,
> > +		.mmd = devadd,
> > +		.reg = cpu_to_le16(reg),
> > +	};
> > +	int ret;
> > +
> > +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return le16_to_cpu(param.data);
> > +}
> > +
> > +static int mxl862xx_phy_write_mmd(struct mxl862xx_priv *priv, int port,
> > +				  int devadd, int reg, u16 data)
> > +{
> > +	struct mdio_relay_data param = {
> > +		.phy = port,
> > +		.mmd = devadd,
> > +		.reg = cpu_to_le16(reg),
> > +		.data = cpu_to_le16(data),
> > +	};
> > +
> > +	return MXL862XX_API_WRITE(priv, INT_GPHY_WRITE, param);
> > +}
> > +
> > +static int mxl862xx_phy_read_mii_bus(struct mii_bus *bus, int port, int regnum)
> > +{
> > +	return mxl862xx_phy_read_mmd(bus->priv, port, 0, regnum);
> > +}
> > +
> > +static int mxl862xx_phy_write_mii_bus(struct mii_bus *bus, int port,
> > +				      int regnum, u16 val)
> > +{
> > +	return mxl862xx_phy_write_mmd(bus->priv, port, 0, regnum, val);
> > +}
> > +
> > +static int mxl862xx_phy_read_c45_mii_bus(struct mii_bus *bus, int port,
> > +					 int devadd, int regnum)
> > +{
> > +	return mxl862xx_phy_read_mmd(bus->priv, port, devadd, regnum);
> > +}
> > +
> > +static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int port,
> > +					  int devadd, int regnum, u16 val)
> > +{
> > +	return mxl862xx_phy_write_mmd(bus->priv, port, devadd, regnum, val);
> > +}
> 
> You took inspiration from the wrong place with the mii_bus ops prototypes,
> specifically with the "int port" argument.
> 
> The second argument does not hold the port, it holds the PHY address.
> I.e. in this case:
>                 port@6 {
>                     reg = <6>;
>                     phy-handle = <&phy5>;
>                     phy-mode = "internal";
>                 };
>                 phy5: ethernet-phy@5 {
>                     reg = <5>;
>                 };
> 
> "int port" is 5, not 6.
> 
> Your source of inspiration are the prototypes of an mii_bus used as
> ds->user_mii_bus. We have a different set of requirements there, because
> ds->user_mii_bus exists for the case where the PHY is not described in
> the device tree, so the port index is given as argument and the
> user_mii_bus is responsible for internally translating the port index to
> a PHY address.
> 
> So while the use of "int port" as argument name for these operations is
> justifiable in some cases, it is not applicable to this driver, and will
> be a pitfall for anyone who has to modify or debug this code.

Ack. While not completely correct from the beginning I should have
addressed that and changed the parameter to 'int addr' when I started to
count physical ports from 0 and no longer hide the microcontroller --
from that moment on the PHY address and the port address are no longer
equal.

I will post a follow-up series to address this and also the removal of
the 'label' property from the DT binding example once this has been
merged. Both cases don't justify a "Fixes:"-tag though, but I'll just
try to be fast, so both can still be applied before net-next closes.

