Return-Path: <netdev+bounces-117384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EC894DB03
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE681C20DA6
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2161494C3;
	Sat, 10 Aug 2024 06:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0504085D
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723270644; cv=none; b=l5q9j3k6b9A5O7Lz+pr4M8nKBL+Gi8/bzQ1gPgOEG++Kr+G7k3s0VhwidLB15AFXy2rFtbq+r0B3kuQCdylIY9OypEz1SXaO2hTJz+RkIED6jA48M6cweArETG1rH/cxwXTCcth/+NLj9y54SgAvSr/rRQkRcTy0JWRzFE20P84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723270644; c=relaxed/simple;
	bh=3G2xvIVxQ9xAaCRHUkSUICl9SMXsX+BHBEkyWUYkFhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeuVwdRI9fhRd9ID8HETbndhXDu0iyUOvyc6aH8naxiK1nSDmnExBMhop8AxSc4mPuDrxSg1g9QSuN3mEyUMNT5Bfv4ZB32ZHeBNTaaTGRUjuH7rxw34J9hA4YRD8qTN6qTMbq5QC12LVQJtBD1bL86/sFucQocrzS53NpbV1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1scfPG-0005E2-T8; Sat, 10 Aug 2024 08:16:50 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1scfPE-005pzl-Bc; Sat, 10 Aug 2024 08:16:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1scfPE-00Cbp7-0m;
	Sat, 10 Aug 2024 08:16:48 +0200
Date: Sat, 10 Aug 2024 08:16:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <ZrcF0HyEUMSudk5M@pengutronix.de>
References: <20240809072440.3477125-3-o.rempel@pengutronix.de>
 <202408100348.U6S1jP0z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202408100348.U6S1jP0z-lkp@intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Aug 10, 2024 at 03:57:35AM +0800, kernel test robot wrote:
> Hi Oleksij,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/phy-Add-Open-Alliance-helpers-for-the-PHY-framework/20240809-172119
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240809072440.3477125-3-o.rempel%40pengutronix.de
> patch subject: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing support
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408100348.U6S1jP0z-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/phy/open_alliance_helpers.c: In function 'oa_1000bt1_get_ethtool_cable_result_code':
> >> drivers/net/phy/open_alliance_helpers.c:34:25: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
>       34 |         u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
>          |                         ^~~~~~~~~

Huh.. why it builds on arm?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

