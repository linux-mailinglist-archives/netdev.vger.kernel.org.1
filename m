Return-Path: <netdev+bounces-102665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FD90424C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2323B22B7D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCF44C6E;
	Tue, 11 Jun 2024 17:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958911720
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126379; cv=none; b=M0BFRO2YZcrlpjzz4whbuETKcN6xEECl4ETH+ZodQPVMMJScAIaWiy3VcqVuPNsMIE2EOvXQRrQLNX7M7Xm1IZ0KGVsI8D9oPFg9TA94n/DYjWw5I2JmZrNiWbyGXkTTmSBablsvK8PenGW/3gokCLREuVqihEcs2y/4Y0b4x3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126379; c=relaxed/simple;
	bh=dlurBqN4FHYLeAMMj2H8k6rc3jwi4Ntwn2Vdp55SRGg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc9lq0gdMlP8kexConuoLjfV0XOIM4DRrBmG0t4N+eCD27CVmJnW+vFC8Iwp6vb40YHlNMJoiXWSk5QJN7fBxRcSi6obMBIpdLasVNE52+8ovRQiUJ8tOsTzS8fF6ZsV3v6Ti/rYMCOysgjEgXhymP6VBg9jGfd1aAGQvyo98Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id c1dcc4e0-2816-11ef-8e57-005056bdf889;
	Tue, 11 Jun 2024 20:19:28 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Jun 2024 20:19:27 +0300
To: kernel test robot <lkp@intel.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a
 select_pcs() implementation
Message-ID: <ZmiHH7hzV9eWZsCU@surfacebook.localdomain>
References: <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
 <202406112331.DvtIlhjT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406112331.DvtIlhjT-lkp@intel.com>

Tue, Jun 11, 2024 at 11:41:38PM +0800, kernel test robot kirjoitti:
> Hi Russell,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-add-select_pcs-platform-method/20240611-024301
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/E1sGgCN-00Fact-0x%40rmk-PC.armlinux.org.uk
> patch subject: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a select_pcs() implementation
> config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20240611/202406112331.DvtIlhjT-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406112331.DvtIlhjT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406112331.DvtIlhjT-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c: In function 'intel_mgbe_common_data':
> >> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:601:9: error: expected expression before '}' token
>      601 |         }
>          |         ^
> 

...

> 7310fe538ea5c9 Ong Boon Leong             2021-03-15  595  	/* Intel mgbe SGMII interface uses pcs-xcps */
> c82386310d9572 Ong Boon Leong             2022-06-15  596  	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
> c82386310d9572 Ong Boon Leong             2022-06-15  597  	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
> 7310fe538ea5c9 Ong Boon Leong             2021-03-15  598  		plat->mdio_bus_data->has_xpcs = true;
> 83f55b01dd9030 Russell King (Oracle       2024-05-29  599) 		plat->mdio_bus_data->default_an_inband = true;
> 178a34a9b7ccb3 Russell King (Oracle       2024-06-10  600) 		plat->select_pcs = intel_mgbe_select_pcs,

Yeah, compiler wants semicolon here.

> 7310fe538ea5c9 Ong Boon Leong             2021-03-15 @601  	}

-- 
With Best Regards,
Andy Shevchenko



