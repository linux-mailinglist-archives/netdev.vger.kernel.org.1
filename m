Return-Path: <netdev+bounces-167993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C578AA3D19C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6476171E8A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207E86333;
	Thu, 20 Feb 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9HjhRzX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D2442C;
	Thu, 20 Feb 2025 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034833; cv=none; b=JV26oK1R68my2mKGP9QPTpEZkaR+PY+b3OsH7uunm4IfQf2GcI7JLK03/aictX5SqbDI7plE5dWoujvlxkL8xJEj0kYFfkDNdSQBqbDbN/yfPUE6yWlytc1D29UuTwcjsvn4JpCpekR2mRIzvUU+yitAdI2U/3a7asD/qggEAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034833; c=relaxed/simple;
	bh=AjVnpHD2v2Yt6Kmq2yAOC5tiCK3gGmXJmt/gK2edgdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTMmYCTfNtpAnZOUWzGBwz7HWgDsi5bxTiR1EaYJHuHnMpaZjYdHqFykrsouCdWQevGb5XqHxCUadD8e3eRe1OV2IO+uF+AQYHN7gPOjKz80jSjDrzXCX1BQAxQdWuVPip22EfYk/V2X4T/PHmILMVQk6+Plw/qi55B/pCZARCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9HjhRzX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740034830; x=1771570830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AjVnpHD2v2Yt6Kmq2yAOC5tiCK3gGmXJmt/gK2edgdI=;
  b=e9HjhRzXlNtRMU0U5PwDvr6ID3LeGov+tncWP0nUqksfwDTiMz3xOZCc
   0HhgG2SLboVkHr3xhks/boPyaqsRcYfKPEKcF9fdLVv/DKQanXAqwRcEM
   nossX5Y2ZLBBWaAVqdzi79tVBQBrtelsYbAAFPjtyDync/K4lmK6oIkdp
   2e+28aLOGtED+T8bxZ4pU8IUjTclXaEvZCHHix8wXaEabZN4xhS6/TYqJ
   MStmot4GjPxoLbfnpvKA+v3bJBpoz+3RxliYEbST30qHaYshJZZmtEOaA
   +VSISszjcvz/c1d6dXXdlE27g1v5GuzOEpWGIn9uPzruMii9NxsF/GzD8
   Q==;
X-CSE-ConnectionGUID: kuhrqjW0RDSqXf2/NJ5vFg==
X-CSE-MsgGUID: m8icS4HwTviuY28+LyDmAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44450184"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44450184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:00:29 -0800
X-CSE-ConnectionGUID: kc2+8xHwQka5NTUIeHSFww==
X-CSE-MsgGUID: vC2LJc8pRmePBXEk75jnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119041836"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:00:27 -0800
Date: Thu, 20 Feb 2025 07:56:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Russell King <linux@armlinux.org.uk>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
Message-ID: <Z7bSLq1vkYJUzvGM@mev-dev.igk.intel.com>
References: <20250217055843.19799-1-nick.hu@sifive.com>
 <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
 <CAKddAkBZWZqY+-TERah+Q+WUfkqzcpFMA=ySSuTxxBjfP7tKZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKddAkBZWZqY+-TERah+Q+WUfkqzcpFMA=ySSuTxxBjfP7tKZg@mail.gmail.com>

On Thu, Feb 20, 2025 at 10:47:40AM +0800, Nick Hu wrote:
> Hi Jacob
> 
> On Thu, Feb 20, 2025 at 7:29 AM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >
> >
> >
> > On 2/16/2025 9:58 PM, Nick Hu wrote:
> > Nit: subject should include the "net" prefix since this is clearly a bug
> > fix.
> >
> I've added the 'net' prefix to the subject 'net: axienet: Set
> mac_managed_pm'. Is there something I'm missing?
> 

It should be [PATCH net] net: axienet: Set mac_managed_pm
Like here for example [1]. You can look at netdev FAQ [2]. It is
described there how to specify the subject.

Probably you don't need to resend it only because of that.

[1] https://lore.kernel.org/netdev/CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=xv=E=utokb3pCQ@mail.gmail.com/T/#m2b5603fbf355216ab035aa0f69c10c5f4ba98772
[2] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Thanks,
Michal

> > > The external PHY will undergo a soft reset twice during the resume process
> > > when it wake up from suspend. The first reset occurs when the axienet
> > > driver calls phylink_of_phy_connect(), and the second occurs when
> > > mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
> > > external PHY does not reinitialize the internal PHY, which causes issues
> > > with the internal PHY, resulting in the PHY link being down. To prevent
> > > this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> > > function.
> > >
> > > Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and retain established link"")
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > ---
> >
> > Otherwise, the fix seems correct to me.
> >
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> >
> > >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > index 2ffaad0b0477..2deeb982bf6b 100644
> > > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > @@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *pdev)
> > >
> > >       lp->phylink_config.dev = &ndev->dev;
> > >       lp->phylink_config.type = PHYLINK_NETDEV;
> > > +     lp->phylink_config.mac_managed_pm = true;
> > >       lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> > >               MAC_10FD | MAC_100FD | MAC_1000FD;
> > >
> >
> 
> Regards,
> Nick

