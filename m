Return-Path: <netdev+bounces-248536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF4D0AD21
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 665CC3027D8E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4352FB99E;
	Fri,  9 Jan 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hDQ+8S3I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796E4594A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971427; cv=none; b=piuXmyUJcn8jx8nZ0Hk4q2C8v2kG1tpEVewjQdm3T/WWPGT4k08hmft0XTdU8w4HooINREY2yylOXrHG+ZWVhS0BTgQDnCyZSrIQP8nkLx4n2W0dVZIg8jn38zwvN0ssbDfwe3sK6ngiU9HesWmpNg4r84C+mFw6c0aBPJmBvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971427; c=relaxed/simple;
	bh=uFfLdk7OIYAAT5P4MwAgbPAByhvdYu40L3b+wFXsWOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/zDYjTAKu41nsA/+Swi/Zd7DRVhkC/9hZSIT2KONpHvRfYJij407hySmWowhXT7XMwykPe+LtS1kBM4uaRO6HV8+EmY0wUC94j8+sv15dXmK+oKLp9lZyLShyKX1NlvfAQVHOaPE3xbJxCknfuXfnctAVC23ELeAGffzUY+T+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hDQ+8S3I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GaE+7NMrtqWHqP2Lum8eOgSAyKs0W+uLFBpql4ZfuHk=; b=hDQ+8S3I0qcjo1v5Siww4zg71J
	z5H3L5RUBBzRJuJ0yMfD8mbFdcExfa3MH1EVfbqBR/uykr6ZRe1OGlLr7uvoAaN131YqFCcd9jlJt
	nuAb60ruKhtoJBA+rHRgaCz6kmNE2K7uesHZi+SJ2Zo3+ekdWwakd0rDiKloffw281eeCBGwLkdNw
	mR96pVvtzJujEpa/DT9UWMzCztFuc+orTvUV9Vu92Isdtolu2yHa3FYVdKVGWygShs7L90CZv6Ikk
	32rUkcXPcLGYspt6an3apfBvNl4avPOl7uCaYGIy5BB3U49miCs2qIR92ye7TueWCoWgJh3ZJ/t2D
	2i6XR5PA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1veE84-000000003xe-1V8m;
	Fri, 09 Jan 2026 15:10:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1veE82-000000003PY-2ET3;
	Fri, 09 Jan 2026 15:10:18 +0000
Date: Fri, 9 Jan 2026 15:10:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed PHYs
 with static array
Message-ID: <aWEaWvV_0SfylwW5@shell.armlinux.org.uk>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
 <20260108181102.4553d618@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108181102.4553d618@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 08, 2026 at 06:11:02PM -0800, Jakub Kicinski wrote:
> On Tue, 6 Jan 2026 17:56:26 +0100 Heiner Kallweit wrote:
> > +/* The DSA loop driver may allocate 4 fixed PHY's, and 4 additional
> > + * fixed PHY's for a system should be sufficient.
> > + */
> > +#define NUM_FP	8
> > +
> >  struct fixed_phy {
> > -	int addr;
> >  	struct phy_device *phydev;
> >  	struct fixed_phy_status status;
> >  	int (*link_update)(struct net_device *, struct fixed_phy_status *);
> > -	struct list_head node;
> >  };
> >  
> > +static struct fixed_phy fmb_fixed_phys[NUM_FP];
> >  static struct mii_bus *fmb_mii_bus;
> > -static LIST_HEAD(fmb_phys);
> > +static DEFINE_IDA(phy_fixed_ida);
> 
> Isn't IDA an overkill for a range this tiny?
> IDA is useful if the ID range is large and may be sparse.
> Here a bitmap would suffice.
> 
> DECLARE_BITMAP(phy_fixed_ids, NUM_FP); 
> 
> id = find_first_zero_bit(phy_fixed_ids, NUM_FP);
> if (id >= NUM_FP)
> 	return -ENOSPC;
> 
> set_bit(id, phy_fixed_ids);

Racy without locking.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

