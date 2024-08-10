Return-Path: <netdev+bounces-117422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D7794DDBE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0946281CFE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17214F130;
	Sat, 10 Aug 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3tbH8Mmk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A01CAAC;
	Sat, 10 Aug 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723310537; cv=none; b=ae2dZtpi8A556KsZ9ErrvHu3kKLFWYIQn2oPrEFpIjde0chPXOsBiBjY2pBlMZEtzvneyc8fDZxTepPRMo1eUEEY+XZSrXsLK0zBJfhJcWJhEmIVQaGgSAGbW6l4auFKeoYaVxvDtKhpgJzgNEMjKuRnP4/uXRVwUvPbDXQWLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723310537; c=relaxed/simple;
	bh=FXcvZsPolqL78vPPT0fj30IQ54CpwbbG11VvpIXLn0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za8YD2RMR+KNG3t/kNVSxTwwdnZ35ufnJnKQqJzk7O8YjtX3AZDz0HS169gGAfRkQm7LxLlfJlKSiHqiV9ZG0RVeXF4t7rurki0SWIZ9z9UiDrs570B/EYlW62A+frQDDWjX+RCW4thRmz/OARQx8CYTudRxMUePaGgs+/Wp9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3tbH8Mmk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xnYMxGma7j6lkx7oGsCIXw80qgHtWv6p/jIGkWtN8fQ=; b=3tbH8MmkcrDScWiswTaS+m2U+q
	DYmTKgzzHnG+O7o6DCXeb5N6qh3Ge5tfE53i51H7jjCn/DjxrfieSeA2eZyL64LZbF5WifxeTFNWS
	tiJbbRBGdyBqvt3TyLZm+Q6YHRVYmAzbZQNFUVj52/MWki2q/H3asEsD55GoHL9UasOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scpmy-004SLQ-Sa; Sat, 10 Aug 2024 19:22:00 +0200
Date: Sat, 10 Aug 2024 19:22:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel test robot <lkp@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <52f84b76-3849-4fc7-94a3-fbaf23ce99af@lunn.ch>
References: <20240809072440.3477125-3-o.rempel@pengutronix.de>
 <202408100348.U6S1jP0z-lkp@intel.com>
 <ZrcF0HyEUMSudk5M@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrcF0HyEUMSudk5M@pengutronix.de>

On Sat, Aug 10, 2024 at 08:16:48AM +0200, Oleksij Rempel wrote:
> On Sat, Aug 10, 2024 at 03:57:35AM +0800, kernel test robot wrote:
> > Hi Oleksij,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/phy-Add-Open-Alliance-helpers-for-the-PHY-framework/20240809-172119
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240809072440.3477125-3-o.rempel%40pengutronix.de
> > patch subject: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing support
> > config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408100348.U6S1jP0z-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/net/phy/open_alliance_helpers.c: In function 'oa_1000bt1_get_ethtool_cable_result_code':
> > >> drivers/net/phy/open_alliance_helpers.c:34:25: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
> >       34 |         u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
> >          |                         ^~~~~~~~~
> 
> Huh.. why it builds on arm?

There has been a couple of reports like this recently. I suspect there
is a some architecture header pulling in the needed header, and m68k
does not.

You might want to compare drivers/net/phy/open_alliance_helpers.i for
arm and m68k.

    Andrew

