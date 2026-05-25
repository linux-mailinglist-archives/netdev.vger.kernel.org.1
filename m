Return-Path: <netdev+bounces-291339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMFaARJdFGqPMwcAu9opvQ
	(envelope-from <netdev+bounces-291339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A225CBBDF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C844A300E27F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099243F0A8F;
	Mon, 25 May 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YvyoTK7Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C7388E76;
	Mon, 25 May 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719436; cv=none; b=TpEbb0v3POppYHv/Kyj9wgP/cBVuhq5De7Q/CmXnYrL71+Z/b39w5lMrAyvEE9/aOuWu0vpwxwMcWdU7Z/YO/wX2bJsYgvm1p0WKP6Abht/ECcT6foBUEDYTSaY3t/Sj9xT+cM5bp1cs30ZOdAxJZSGiRDuK69fGfQ3zz0Zd7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719436; c=relaxed/simple;
	bh=c7j3mYtpmyl2MGE0v2vgwj/TkNfEtevu0YmWFfnKhMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KETIplQ4dsxLMbpjumAXRBLi7PPoIYy8POTyCz98W+zgnkyUWOnWZPfIBt+bOxBLWl+40Xl2TwuzoJIsWlNFXR8bDssqly6/UnfKTpq5BkC9GAZ6Huu2PtccDLizw/DdH+sKE3442wHBHjNUSsOS443oFRMOF8Z/glcCXU0q4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YvyoTK7Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WWCy27/OL3Xjr6IwZxDw6f5CDkc66vxOiZ83cP4BEoA=; b=YvyoTK7YZFgEF2fvSXpZFsv3/L
	Daf/5jWHyQvPSviWZcWJrU4SoqLASMF3FLYoK9TnKulJS+aa2/IybS3+VQK78AnHQ9JNni5onjhVl
	8tP0vt/ZmdnDN0iIwUCxRnE8Uyd5CFQ7YUJbpS0N85+uZkdmO1m3Qs5NwOVijy+VD2IQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRWJz-004TmY-Am; Mon, 25 May 2026 16:30:23 +0200
Date: Mon, 25 May 2026 16:30:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Message-ID: <5b25361d-ea72-4653-82c0-af8723873e58@lunn.ch>
References: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
 <CY8PR02MB92494894582414C9D8FA1A2E830A2@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92494894582414C9D8FA1A2E830A2@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291339-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 70A225CBBDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 05:35:55AM +0000, Selvamani Rajagopal wrote:
> > > diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> > > index 68b0e4647..d302e04c8 100644
> > > --- a/drivers/net/phy/ncn26000.c
> > > +++ b/drivers/net/phy/ncn26000.c
> > > @@ -162,6 +162,39 @@ static int ncn26000_config_intr(struct phy_device *phydev)
> > > return 0;
> > > }
> > >
> > > +/* Directly accessing via Clause 45 read avoids the extra
> > > + * SPI accesses required by indirect access.
> > > + */
> > > +static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
> > > +{
> > > + struct mii_bus *bus = phydev->mdio.bus;
> > > + int addr = phydev->mdio.addr;
> > > +
> > > + return __mdiobus_c45_read(bus, addr, dev, reg);
> > > +}
> > 
> > This needs more explanation. Maybe you need to look into
> > phydev->is_c45.
> 
> Andew,
> 

> I spent some time to understand the is_c45 flag. As far as I can
> see, this is the only way. See my reasons below, to see if it makes
> sense.

O.K. Lets keep with it, but please do some refactoring. We have the
same code in microchip_t1s.c, for the same reason. Please pull it out
of that driver, and put it next to genphy_read_mmd_unsupported(),
along with the explanation of why it is needed.

      Andrew

