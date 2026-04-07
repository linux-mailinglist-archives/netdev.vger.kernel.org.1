Return-Path: <netdev+bounces-276078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK+qEtIu1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C03B1BB3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AB21300B501
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF63B27E7;
	Tue,  7 Apr 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V6l5s19C"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AD3A4F3B;
	Tue,  7 Apr 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578822; cv=none; b=D75IDXV50pZp3Skf2H7m94QfNex5yZ81TrdCkS0mV6WCmqH9s6shR4iVVp2QkKLQakoU7OzVpUPUJutxfxhwNYUs4gAltlqu1LQO7CffC5LwSjLYShP3VLbirqQUfDRqE5ZR/kk40VENFYojS/GYTuy74S8ThBDfe5jVgYGtBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578822; c=relaxed/simple;
	bh=1LkBwwUTdnp2CCjj2Qqlbef6zIfZdG9Qq2uWCyCHaoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmWcMZsYA/l6ufm0BOzdVKdVZxvCZtKXtdhhd8/ojRNkKdcN9q2b8JefDNxaOSe9RVgJXG5g3zcG+1mrUJSRjpHldNzn8jFFEu9WjGna9L6Sq9Eh4bpI3SY3NMVcZPkfv9UF+D2qk69PRTXIPEY9FJIcUjQNnhPYMvqm6CYeoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V6l5s19C; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775578821; x=1807114821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LkBwwUTdnp2CCjj2Qqlbef6zIfZdG9Qq2uWCyCHaoc=;
  b=V6l5s19Ceo7qGxxQTfVqviHwVcg4FWpwWZKpPSqLwXWv8BGmOmTF1IL4
   ZRjI0iciSiLC2DUwnd7W76VSw9TbIlG0pqKHb1dY5yDkoWacB6Q++3UIE
   dwUfIK0kbvq/0ETAX/EgH/jmDNXNKZmob3nakTGOWCEPVMIPVvKmOF7r+
   30c5JDSkgyDIoVFqrYVu/NLnb9HLw9LBuU+nITSjco5y5RN6x/G7dHoC/
   9Xmwh8MItRSRNC742V8vFBTnYB/VK0Hjg21NYgdmKYUrVCE8LKAeE2Zv6
   GQwrU2CVLjlerhrqJzz2nnbwwMoTK5tp3UhMmMndQzngmsspruhZXAAru
   w==;
X-CSE-ConnectionGUID: kE2JcDFDRDC9iquzR5ev1g==
X-CSE-MsgGUID: EBEutfKDTD6nkrexXeavBA==
X-IronPort-AV: E=Sophos;i="6.23,165,1770620400"; 
   d="scan'208";a="223035680"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 09:20:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 7 Apr 2026 09:19:51 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 7 Apr 2026 09:19:50 -0700
Date: Tue, 7 Apr 2026 09:19:49 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, Charles Perry
	<charles.perry@microchip.com>, <netdev@vger.kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <adUupYuD6tM3ahaR@bby-cbu-swbuild03.eng.microchip.com>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
 <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
 <b40dfafe-7e8f-4686-a743-31b097c84954@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b40dfafe-7e8f-4686-a743-31b097c84954@lunn.ch>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,microchip.com,vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276078-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: 493C03B1BB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 08:09:06PM +0200, Andrew Lunn wrote:
> On Thu, Apr 02, 2026 at 07:03:42PM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 02, 2026 at 03:31:52PM +0200, Andrew Lunn wrote:
> > > > +static int phy_write_barrier(struct phy_device *phydev)
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	err = phy_read(phydev, MII_PHYSID1);
> > > > +	if (err < 0)
> > > > +		return err;
> > > 
> > > There are a small number of MDIO busses which don't implement C22,
> > > only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
> > > -EINVAL for such a read. Returning the error than makes
> > > phy_disable_interrupts() fail, etc.
> > 
> > If it returns -EOPNOTSUPP (meaning, at least, that bus->read is not
> > implemented), do we want to issue a C45 read instead?
> 
> Maybe.
> 
> get_phy_c45_ids() first reads MDIO_MMD_PMAPMD : MII_PHYSID1. That
> seems like a safe option.

Here's where I'm at with this:

static void phy_write_barrier(struct phy_device *phydev)
{
       int err;
 
       err = mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, MII_PHYSID1);
       if (err == -EOPNOTSUPP)
               mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
                                __ffs(phydev->c45_ids.mmds_present),
                                MII_PHYSID1);
}

In part inspired by phylink_phy_read() in phylink.c

Do you think there's any way I can test this on my VSC8574 or VSC8541? It
supports some C45 registers for EEE but not the device discovery part.

Thanks,
Charles

