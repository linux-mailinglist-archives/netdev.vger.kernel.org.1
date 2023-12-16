Return-Path: <netdev+bounces-58237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD378159E4
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A6D1F22D66
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D22D623;
	Sat, 16 Dec 2023 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZs3k540"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279412E45;
	Sat, 16 Dec 2023 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702737380; x=1734273380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cXOxesxh+4lCmGM6sRJsNu5lJEjSqNCi2HOU/29rWQ=;
  b=UZs3k540C5gQNuLM+eVN/N8EhEdYU1AtoGqEjM11vrzT0UvciGGqo9gm
   ZEmpJGVmbe2jD6R1+ru9C5uJUVbwUZbqhkZSlLsgSC1SV+qFfi2DRJ9ga
   pXOPcirtAcLENrgUE44XGxpAhGWmyIRmUNxzcI102fbI4+uxMZhdixvzb
   jgouY/Yu/j10yYvGcyiZuzubF1Z+IuyavKQ4jlkoIwSMZwesaEQP8BA0I
   EZuyXFtmXT2QeLSxFc7zvi9G3twcNCJry8Kz2+gxhpEWNxDkKp42ntXzT
   JO4cNW6ZmSpm6pSthmupNDBqunlNIiURiadJPiWgHMocYT5fuJtW7VuT2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="385795932"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="385795932"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 06:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768320844"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="768320844"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2023 06:36:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEVm2-0001jm-30;
	Sat, 16 Dec 2023 14:36:14 +0000
Date: Sat, 16 Dec 2023 22:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@armlinux.org.uk, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <202312162238.aJCgm39Y-lkp@intel.com>
References: <20231214201442.660447-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-2-tobias@waldekranz.com>

Hi Tobias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Waldekranz/net-phy-marvell10g-Support-firmware-loading-on-88X3310/20231215-041703
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231214201442.660447-2-tobias%40waldekranz.com
patch subject: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware loading on 88X3310
config: x86_64-randconfig-123-20231216 (https://download.01.org/0day-ci/archive/20231216/202312162238.aJCgm39Y-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312162238.aJCgm39Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312162238.aJCgm39Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/marvell10g.c:620:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/net/phy/marvell10g.c:620:31: sparse:     expected unsigned int [addressable] [usertype] size
   drivers/net/phy/marvell10g.c:620:31: sparse:     got restricted __le32 [usertype]
>> drivers/net/phy/marvell10g.c:621:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/net/phy/marvell10g.c:621:31: sparse:     expected unsigned int [addressable] [usertype] addr
   drivers/net/phy/marvell10g.c:621:31: sparse:     got restricted __le32 [usertype]
>> drivers/net/phy/marvell10g.c:622:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [usertype] csum @@     got restricted __le16 [usertype] @@
   drivers/net/phy/marvell10g.c:622:31: sparse:     expected unsigned short [addressable] [usertype] csum
   drivers/net/phy/marvell10g.c:622:31: sparse:     got restricted __le16 [usertype]
>> drivers/net/phy/marvell10g.c:623:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] next_hdr @@     got restricted __le32 [usertype] @@
   drivers/net/phy/marvell10g.c:623:30: sparse:     expected unsigned int [addressable] [usertype] next_hdr
   drivers/net/phy/marvell10g.c:623:30: sparse:     got restricted __le32 [usertype]
   drivers/net/phy/marvell10g.c:624:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [usertype] csum @@     got restricted __le16 [usertype] @@
   drivers/net/phy/marvell10g.c:624:26: sparse:     expected unsigned short [addressable] [usertype] csum
   drivers/net/phy/marvell10g.c:624:26: sparse:     got restricted __le16 [usertype]

vim +620 drivers/net/phy/marvell10g.c

   595	
   596	static int mv3310_load_fw(struct phy_device *phydev)
   597	{
   598		const struct mv3310_chip *chip = to_mv3310_chip(phydev);
   599		const struct firmware *fw;
   600		struct mv3310_fw_hdr hdr;
   601		const u8 *sect;
   602		size_t i;
   603		u16 csum;
   604		int err;
   605	
   606		if (!chip->firmware_path)
   607			return -EOPNOTSUPP;
   608	
   609		err = request_firmware(&fw, chip->firmware_path, &phydev->mdio.dev);
   610		if (err)
   611			return err;
   612	
   613		if (fw->size & 1) {
   614			err = -EINVAL;
   615			goto release;
   616		}
   617	
   618		for (sect = fw->data; (sect + sizeof(hdr)) < (fw->data + fw->size);) {
   619			memcpy(&hdr, sect, sizeof(hdr));
 > 620			hdr.data.size = cpu_to_le32(hdr.data.size);
 > 621			hdr.data.addr = cpu_to_le32(hdr.data.addr);
 > 622			hdr.data.csum = cpu_to_le16(hdr.data.csum);
 > 623			hdr.next_hdr = cpu_to_le32(hdr.next_hdr);
   624			hdr.csum = cpu_to_le16(hdr.csum);
   625	
   626			for (i = 0, csum = 0; i < offsetof(struct mv3310_fw_hdr, csum); i++)
   627				csum += sect[i];
   628	
   629			if ((u16)~csum != hdr.csum) {
   630				dev_err(&phydev->mdio.dev, "Corrupt section header\n");
   631				err = -EINVAL;
   632				break;
   633			}
   634	
   635			err = mv3310_load_fw_sect(phydev, &hdr, sect + sizeof(hdr));
   636			if (err)
   637				break;
   638	
   639			if (!hdr.next_hdr)
   640				break;
   641	
   642			sect = fw->data + hdr.next_hdr;
   643		}
   644	
   645	release:
   646		release_firmware(fw);
   647		return err;
   648	}
   649	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

