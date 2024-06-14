Return-Path: <netdev+bounces-103457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6FE9082FC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284E228439D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227212DD8E;
	Fri, 14 Jun 2024 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QWLKlybd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F48479;
	Fri, 14 Jun 2024 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718339658; cv=none; b=Hl4eAxZGb2ljfh6pRkfzHeDYcHRJpBZRehJ0wV3A0t2RpGCIZoRZRxbyblSikCRxxWMYjJE66swC6+iyRh833GRcRLNxkxyHZkaq53UTdFO2bpPdyhwto5EfI3HfF5xsrpP2ZprDZxkxR2LGFY0I4ucy6WHGuFBB/HtDZ9QlTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718339658; c=relaxed/simple;
	bh=6oLS7NlxzKsN5itD6m/GaOkmu+FsXpvr3txVhSx2uN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl1PXoNDKuXq+blzfbgBOa/ElMGInj3eX8r+dN3nswZf6WdiohJlc3lPE711xep8TJQnjBi6IfNTwy+snmcH4eaUbFQhg4qB69GnGTtctI9MHO3aEL5Vy/B9mJx6NjcDaVYuGiEutuW2+HnTomWmflED86uk1duY532966Mq6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QWLKlybd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718339656; x=1749875656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6oLS7NlxzKsN5itD6m/GaOkmu+FsXpvr3txVhSx2uN4=;
  b=QWLKlybdB8F0TrywFKHfjSIunVhwGH5O2YoSlgd/6fZL41RLmIqaCTAL
   aj95ZaxEMuZiHdsO+vCzOFDUDYPpsO8m2JT5/lzGbOYuT+eMdp1rRcPs3
   c0xDzOl7Jw6IKVTQtbdJ11YA+VaDPinUTRDUg6xkdQLQI7GF2QiGBiD3k
   3/fGdQps8HfcpGm+oPIhQUmB/GCAgpk8Xux98htu64V7a5x60P3NPq/em
   T+gRh0bzzN/JvxNGrjK5rBKwDfwKUmI5a3v44xnGVh8ipC65kil8E1Ads
   FjSjJi+2eYBUgvTN6OvgNSNlzbGa1fonD1s0QVtwVHSvgWx7TXHqIe3Wo
   w==;
X-CSE-ConnectionGUID: bLxVCISsTUiZ12rdpwUNiw==
X-CSE-MsgGUID: jnaoROPnQyGXQjHlrCKWBQ==
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="194899419"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 21:34:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 21:33:45 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 21:33:44 -0700
Date: Fri, 14 Jun 2024 10:00:58 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <sbauer@blackbox.su>,
	<hmehrtens@maxlinear.com>, <lxu@maxlinear.com>, <hkallweit1@gmail.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V4 1/3] net: lan743x: disable WOL upon resume to
 restore full data path operation
Message-ID: <ZmvHgg5SDYlrO9yB@HYD-DK-UNGSW21.microchip.com>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-2-Raju.Lakkaraju@microchip.com>
 <ZmqjYEs0G9pGQTog@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZmqjYEs0G9pGQTog@shell.armlinux.org.uk>

Hi Russell King,

The 06/13/2024 08:44, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, Jun 12, 2024 at 10:55:37PM +0530, Raju Lakkaraju wrote:
> > @@ -3728,6 +3729,30 @@ static int lan743x_pm_resume(struct device *dev)
> >               return ret;
> >       }
> >
> > +     ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> > +     netif_info(adapter, drv, adapter->netdev,
> > +                "Wakeup source : 0x%08X\n", ret);
> 
> Does this need to be printed at info level, or is it a debug message?

Print at info level helps the tester/sqa team to identify the root cause of
the wake and confirm the test cases.
In general, tester does not enable debug level messages for testing.

Still, if we need to change from info to debug, i can change.
Please let me know.

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

