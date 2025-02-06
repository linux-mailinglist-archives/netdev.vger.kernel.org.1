Return-Path: <netdev+bounces-163706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782BA2B65F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FB41884741
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BFD2417F4;
	Thu,  6 Feb 2025 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUZh0+q3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAC2417E0;
	Thu,  6 Feb 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883256; cv=none; b=GCQtSeCgmVnx3gY0GYLUaNOxz1/rQBGIEW50vPS6Afj4rPc1cgn58fowLQlwkGP3cSmSszczF0V65dEFrTD6xEZljQDwodlzKJ9pnz+iWfuAcKx1SShM9wCTPuT1QWDB6FwaXy7P/JA6yrDcQIpe16BAy8ZEu+IBq3KwdSZebss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883256; c=relaxed/simple;
	bh=boGdQ7S8b0YyNfxIm4I50jD6mtmzak8c74/jeqYssO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6d9CAK2PXTvNUzBqynqe6PFtM1POTx8Ow+SHjbpX5rsIQFdKt24ZGRVtyJNPX6kzDGSWThhAXddqo8KcnvcPGQwqA49gL89O7BcYWz+iWGTIjKz2aLo5CcZq23MJ4fQp67J6IreyXtfb15XgY+YMDmZWON2DxJxvMZ4aerQuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUZh0+q3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738883254; x=1770419254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boGdQ7S8b0YyNfxIm4I50jD6mtmzak8c74/jeqYssO4=;
  b=cUZh0+q3LZecYwv1gA2KcouWYhKMkxw/EY+NyzJQZCQD8roCwQVY5TMh
   ZTysU5fj+fg6rArHIdm+gIQxKAQgw8sviPfz/WeQvYRXqGyNhW+tB6Qwd
   rKTroNEZ1yn4mCi2Pkv0cS8s0m91x+XQUUAXJVVO63FPpz5edUb87cRuQ
   /O5gpNZcd+RmQ44m7hlyeZLp/zWtKmayk2j8zu7yf9heTh6Sw4tOiyT/4
   x3hHwCLm2Y8pH98taMsya3qQN8Gw1id/O0A6p5GUd2+nVFjMc2iFWt+nM
   /41FN/sYMcatr9RXti373upCr6uvHdlGg+jSBca560ldFD6ilWNCRjU6A
   w==;
X-CSE-ConnectionGUID: aQnjfIthT8uO+B9tvW5pQQ==
X-CSE-MsgGUID: XxxKqonRQ/m3qZwpnoBBmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50946249"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50946249"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 15:07:32 -0800
X-CSE-ConnectionGUID: EQwYRrGCRW2DHPzG7W2gkg==
X-CSE-MsgGUID: q85618KpRbu5Bb86PHmPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111132680"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2025 15:07:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgAxw-000xUd-1j;
	Thu, 06 Feb 2025 23:07:24 +0000
Date: Fri, 7 Feb 2025 07:06:33 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 10/13] net: airoha: Introduce PPE initialization
 via NPU
Message-ID: <202502070610.tbfoIwkS-lkp@intel.com>
References: <20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 135c3c86a7cef4ba3d368da15b16c275b74582d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-airoha-Move-airoha_eth-driver-in-a-dedicated-folder/20250206-022555
base:   135c3c86a7cef4ba3d368da15b16c275b74582d3
patch link:    https://lore.kernel.org/r/20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01%40kernel.org
patch subject: [PATCH net-next 10/13] net: airoha: Introduce PPE initialization via NPU
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250207/202502070610.tbfoIwkS-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502070610.tbfoIwkS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502070610.tbfoIwkS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/devcoredump.h:8,
                    from drivers/net/ethernet/airoha/airoha_npu.c:7:
   drivers/net/ethernet/airoha/airoha_npu.c: In function 'airoha_npu_run_firmware':
>> drivers/net/ethernet/airoha/airoha_npu.c:200:30: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     200 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/ethernet/airoha/airoha_npu.c:200:17: note: in expansion of macro 'dev_err'
     200 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                 ^~~~~~~
   drivers/net/ethernet/airoha/airoha_npu.c:200:60: note: format string is defined here
     200 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                                                          ~~^
         |                                                            |
         |                                                            long int
         |                                                          %d
   drivers/net/ethernet/airoha/airoha_npu.c:220:30: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     220 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/ethernet/airoha/airoha_npu.c:220:17: note: in expansion of macro 'dev_err'
     220 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                 ^~~~~~~
   drivers/net/ethernet/airoha/airoha_npu.c:220:60: note: format string is defined here
     220 |                 dev_err(dev, "%s: fw size too overlimit (%ld)\n",
         |                                                          ~~^
         |                                                            |
         |                                                            long int
         |                                                          %d


vim +200 drivers/net/ethernet/airoha/airoha_npu.c

   187	
   188	static int airoha_npu_run_firmware(struct airoha_npu *npu, struct reserved_mem *rmem)
   189	{
   190		struct device *dev = &npu->pdev->dev;
   191		const struct firmware *fw;
   192		void __iomem *addr;
   193		int ret;
   194	
   195		ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
   196		if (ret)
   197			return ret;
   198	
   199		if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
 > 200			dev_err(dev, "%s: fw size too overlimit (%ld)\n",
   201				NPU_EN7581_FIRMWARE_RV32, fw->size);
   202			ret = -E2BIG;
   203			goto out;
   204		}
   205	
   206		addr = devm_ioremap(dev, rmem->base, rmem->size);
   207		if (!addr) {
   208			ret = -ENOMEM;
   209			goto out;
   210		}
   211	
   212		memcpy_toio(addr, fw->data, fw->size);
   213		release_firmware(fw);
   214	
   215		ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
   216		if (ret)
   217			return ret;
   218	
   219		if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
   220			dev_err(dev, "%s: fw size too overlimit (%ld)\n",
   221				NPU_EN7581_FIRMWARE_DATA, fw->size);
   222			ret = -E2BIG;
   223			goto out;
   224		}
   225	
   226		memcpy_toio(npu->base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
   227	out:
   228		release_firmware(fw);
   229	
   230		return ret;
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

