Return-Path: <netdev+bounces-289643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HCkGIzoDGpnpwUAu9opvQ
	(envelope-from <netdev+bounces-289643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE77585D06
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7DFD300343D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EA2DCC01;
	Tue, 19 May 2026 22:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46827979A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230842; cv=none; b=pZyBD7EtMw7ZCOxPReJ63AuD00fpTH/CYX2x5ujnrncfulNY5QGUnkrhAjJN0L6TYA+mGAEhpEyKirWt1fOKLaXycqfhK2FXS2OqpaeLZby4g0cGfgcPeEbXIshPmZnMxQlKQx5aP90X8fmQPJiMogBur2B7B36eRzrMjPc/qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230842; c=relaxed/simple;
	bh=QN+tBPchy1of2PoSfnYbNYsiKxxSxFCF7yziM0YtxV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2/lU6mQB93EjnFItzsYWouqoTbMeQzxDenKAn9n5bzMYbhh7JuhFjlgPm4AmwR9tMABNbMPSWJVii/hmBj3NvwN0Z9MsTE1qXRS7RiDTM3mV+U1J82qcl6fRY4YBvjgUZGzHjFp7r/ekkdmFy8KdUe5wLb9JUho7svDm/mZbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPTDO-0000000031r-48rm;
	Tue, 19 May 2026 22:47:07 +0000
Date: Tue, 19 May 2026 23:47:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <agzoaMnmeVpjiFC0@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
 <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
 <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
 <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289643-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Queue-Id: DDE77585D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:14:24PM +0200, Andrew Lunn wrote:
> > > Hi Markus
> > >
> > > It would be good to take a step back and explain the concepts here in
> > > the commit message. An MDIO bus as 32 addresses, as defined by
> > > 802.3. Why do we need the concept of a port when we have addresses?
> > >
> > > Once you explain the concept, we can maybe suggest a better name. Or
> > > throw the whole concept out because it is not needed.
> > 
> > I'm just trying to give the properties in the info structure the right 
> > name that resembles its function. The driver already builds upon
> > the "port" naming.
> > 
> > Where does this come from?
> > 
> > - The hardware has 1-4 SMI busses
> > - Each bus serves up to 32 addresses
> > - A switch has X physical ports
> > - The mdio controller can only be fed with "physical port"
> 
> So in general, the MDIO API uses an address in the range 0-31, as
> defined in C22/C45. I would try to do any sort of mapping of ports to
> MDIO addresses in a layer above MDIO. Maybe that is not possible, i
> only partially remember the discussion about this hardware. But if it
> is going to get more complex, i really would suggest pulling it out
> into a layer above, and let the MDIO driver simply do MDIO.

The problem is that the hardware doesn't let you access the MDIO
busses directly -- you *have to* setup a mapping and then access each
PHY using the mapped port index. Also hardware PHY polling *has* to be
used to configure the MAC as there is no (known) way to directly
configure most of the MACs (but only a small number which is typically
used for SFPs), so setting up the mapping also for that is mandatory
and cannot be avoided.

The driver does it's best to present MDIO busses with the PHYs available
with their actual (ie. as on the hardware) addresses 0-31 towards Linux,
so PHY drivers, packages or even userland tools all work as expected.
But internally it will have to setup this mapping port->(bus, phy), and
then reverse-resolve each (bus, phy)->port.

