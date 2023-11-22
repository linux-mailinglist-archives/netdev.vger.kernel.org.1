Return-Path: <netdev+bounces-50175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92B7F4C55
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA8AB20C91
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FDB24B35;
	Wed, 22 Nov 2023 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijOQkT5v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16397BC
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700670528; x=1732206528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVkBwGDQh0KTnGcPQwyuRgxpErlDOtTG1iq22743jm4=;
  b=ijOQkT5vHSG9PlytsQn72OjtCpG2owvJazDDuSTqMMBw0kM4J4ZlDbJn
   uQ7iKkRsXgjLOlGMqlHAcuxGy8QLkoD+Psito9MNWd4rANB8WwOiuM4bx
   C8mp7VcHVG7RtxdfI3S++2bS3Aff6nkBJ3/JZSJfLFJn4WhOWYGjbpeI2
   ZLxdXtiAuN8EiDMHVfsGVVPgMK9G/5pqPr/88dymrLgPkoGij638I4kVg
   nyXIbEJhSC6L55w2qGZyqYseBE3jfAxcQvBdx+o4j/Y+Zj9r5pP8lRaR1
   PtvmzW++eFINeImWcegO4+HLTKVyDPcnAmBwzxBAN96j9Fj77ciFjHnI5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382491241"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="382491241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 08:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1098488560"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="1098488560"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2023 08:27:46 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5q4l-0000gG-2y;
	Wed, 22 Nov 2023 16:27:43 +0000
Date: Thu, 23 Nov 2023 00:26:08 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH v2 net-next 4/4] amd-xgbe: use smn functions to avoid race
Message-ID: <202311222227.RtqixHxt-lkp@intel.com>
References: <20231116135416.3371367-5-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116135416.3371367-5-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-reorganize-the-code-of-XPCS-access/20231116-215630
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231116135416.3371367-5-Raju.Rangoju%40amd.com
patch subject: [PATCH v2 net-next 4/4] amd-xgbe: use smn functions to avoid race
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231122/202311222227.RtqixHxt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311222227.RtqixHxt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311222227.RtqixHxt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1194:2: error: call to undeclared function 'amd_smn_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1194 |         amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
         |         ^
   drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1194:2: note: did you mean 'pmd_mkwrite'?
   include/linux/pgtable.h:610:21: note: 'pmd_mkwrite' declared here
     610 | static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
         |                     ^
>> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1195:2: error: call to undeclared function 'amd_smn_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1195 |         amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
         |         ^
   drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1224:2: error: call to undeclared function 'amd_smn_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1224 |         amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
         |         ^
   drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1225:2: error: call to undeclared function 'amd_smn_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1225 |         amd_smn_read(0, pdata->smn_base + offset, &ctr_mmd_data);
         |         ^
   4 errors generated.
--
>> drivers/net/ethernet/amd/xgbe/xgbe-pci.c:316:3: error: call to undeclared function 'amd_smn_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     316 |                 amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
         |                 ^
   1 error generated.


vim +/amd_smn_write +1194 drivers/net/ethernet/amd/xgbe/xgbe-dev.c

  1172	
  1173	static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
  1174					 int mmd_reg)
  1175	{
  1176		unsigned int mmd_address, index, offset;
  1177		unsigned long flags;
  1178		int mmd_data;
  1179	
  1180		mmd_address = get_mmd_address(pdata, mmd_reg);
  1181	
  1182		/* The PCS registers are accessed using mmio. The underlying
  1183		 * management interface uses indirect addressing to access the MMD
  1184		 * register sets. This requires accessing of the PCS register in two
  1185		 * phases, an address phase and a data phase.
  1186		 *
  1187		 * The mmio interface is based on 16-bit offsets and values. All
  1188		 * register offsets must therefore be adjusted by left shifting the
  1189		 * offset 1 bit and reading 16 bits of data.
  1190		 */
  1191		offset = get_index_offset(pdata, mmd_address, &index);
  1192	
  1193		spin_lock_irqsave(&pdata->xpcs_lock, flags);
> 1194		amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> 1195		amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
  1196		mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
  1197					  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
  1198	
  1199		spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
  1200	
  1201		return mmd_data;
  1202	}
  1203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

