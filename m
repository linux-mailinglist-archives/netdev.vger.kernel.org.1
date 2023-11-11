Return-Path: <netdev+bounces-47181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3F7E8A74
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 12:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67671F20F51
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324412B7A;
	Sat, 11 Nov 2023 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMN9fsyb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8015678
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 11:04:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902DB3AA8;
	Sat, 11 Nov 2023 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699700688; x=1731236688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKsMwuafOZwoy0GmZuR9O/Rq8lZfnlbj8aei6lxUmuI=;
  b=SMN9fsybQC2toaJzF9DC8PzYGyPpH3PMs4b3Z2Bxo7qG64VbpN0NWbNU
   8IbaX15wiNfXCQubT0S2/VrScHxGj6EPB+KvuDTWBo+SLXF8JzmEx6Udr
   Jw6AD4YYZgcUG8ixJ9yJzcIQqPRb3G8heBF2SlHy8APhBdcdT+kiD0XR4
   MBubB2triQld9UZhwG+Ktkq41Kioc6gJ1h6VBY7BAofJZVTx/p7gV5khy
   MFoOsJ/KbpILkVrmo014EPW5fYqCOQc6o/9EOE7LXPZQT/b9JPHT9/Ekp
   /qwBGYcN6u1p7mF+vRDMm4bW9UboDo22PFwtmjDccfIFq4hJjvMhMwAfN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369601039"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="369601039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 03:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="12050365"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Nov 2023 03:04:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1ln5-000AOI-2p;
	Sat, 11 Nov 2023 11:04:39 +0000
Date: Sat, 11 Nov 2023 19:03:47 +0800
From: kernel test robot <lkp@intel.com>
To: Min Li <lnimi@hotmail.com>, richardcochran@gmail.com, lee@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <202311111829.GoGXlH8b-lkp@intel.com>
References: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>

Hi Min,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Min-Li/ptp-clockmatrix-support-32-bit-address-space/20231110-044554
base:   net-next/main
patch link:    https://lore.kernel.org/r/MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA%40MW5PR03MB6932.namprd03.prod.outlook.com
patch subject: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit address space
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231111/202311111829.GoGXlH8b-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111829.GoGXlH8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111829.GoGXlH8b-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_clockmatrix.c:1257:50: warning: implicit conversion from 'int' to 'u16' (aka 'unsigned short') changes value from 537972560 to 53072 [-Wconstant-conversion]
    1257 |         u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
         |             ~~~~~~~                                     ^~~~~~~
   include/linux/mfd/idt8a340_reg.h:454:43: note: expanded from macro 'SCRATCH'
     454 | #define SCRATCH                           0x2010cf50
         |                                           ^~~~~~~~~~
   include/linux/mfd/idt8a340_reg.h:673:55: note: expanded from macro 'IDTCM_FW_REG'
     673 | #define IDTCM_FW_REG(FW, VER, REG)      (((FW) < (VER)) ? (REG) : (REG##_##VER))
         |                                                            ^~~
   drivers/ptp/ptp_clockmatrix.c:1257:16: warning: implicit conversion from 'int' to 'u16' (aka 'unsigned short') changes value from 537972556 to 53068 [-Wconstant-conversion]
    1257 |         u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
         |             ~~~~~~~   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mfd/idt8a340_reg.h:673:63: note: expanded from macro 'IDTCM_FW_REG'
     673 | #define IDTCM_FW_REG(FW, VER, REG)      (((FW) < (VER)) ? (REG) : (REG##_##VER))
         |                                                                    ^~~~~~~~~~~
   <scratch space>:144:1: note: expanded from here
     144 | SCRATCH_V520
         | ^~~~~~~~~~~~
   include/linux/mfd/idt8a340_reg.h:455:43: note: expanded from macro 'SCRATCH_V520'
     455 | #define SCRATCH_V520                      0x2010cf4c
         |                                           ^~~~~~~~~~
   2 warnings generated.


vim +1257 drivers/ptp/ptp_clockmatrix.c

3a6ba7dc779935 Vincent Cheng 2019-10-31  1253  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1254  static int idtcm_load_firmware(struct idtcm *idtcm,
3a6ba7dc779935 Vincent Cheng 2019-10-31  1255  			       struct device *dev)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1256  {
794c3dffacc166 Min Li        2021-09-13 @1257  	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
7ea5fda2b1325e Min Li        2020-07-28  1258  	char fname[128] = FW_FILENAME;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1259  	const struct firmware *fw;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1260  	struct idtcm_fwrc *rec;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1261  	u32 regaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1262  	int err;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1263  	s32 len;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1264  	u8 val;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1265  	u8 loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1266  
7ea5fda2b1325e Min Li        2020-07-28  1267  	if (firmware) /* module parameter */
7ea5fda2b1325e Min Li        2020-07-28  1268  		snprintf(fname, sizeof(fname), "%s", firmware);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1269  
930dfa56315517 Min Li        2021-09-24  1270  	dev_info(idtcm->dev, "requesting firmware '%s'", fname);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1271  
7ea5fda2b1325e Min Li        2020-07-28  1272  	err = request_firmware(&fw, fname, dev);
7ea5fda2b1325e Min Li        2020-07-28  1273  	if (err) {
930dfa56315517 Min Li        2021-09-24  1274  		dev_err(idtcm->dev,
1c49d3e947783b Vincent Cheng 2021-02-17  1275  			"Failed at line %d in %s!", __LINE__, __func__);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1276  		return err;
7ea5fda2b1325e Min Li        2020-07-28  1277  	}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1278  
930dfa56315517 Min Li        2021-09-24  1279  	dev_dbg(idtcm->dev, "firmware size %zu bytes", fw->size);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1280  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1281  	rec = (struct idtcm_fwrc *) fw->data;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1282  
794c3dffacc166 Min Li        2021-09-13  1283  	if (contains_full_configuration(idtcm, fw))
3a6ba7dc779935 Vincent Cheng 2019-10-31  1284  		idtcm_state_machine_reset(idtcm);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1285  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1286  	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
3a6ba7dc779935 Vincent Cheng 2019-10-31  1287  		if (rec->reserved) {
930dfa56315517 Min Li        2021-09-24  1288  			dev_err(idtcm->dev,
1c49d3e947783b Vincent Cheng 2021-02-17  1289  				"bad firmware, reserved field non-zero");
3a6ba7dc779935 Vincent Cheng 2019-10-31  1290  			err = -EINVAL;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1291  		} else {
3a6ba7dc779935 Vincent Cheng 2019-10-31  1292  			regaddr = rec->hiaddr << 8;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1293  			regaddr |= rec->loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1294  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1295  			val = rec->value;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1296  			loaddr = rec->loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1297  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1298  			rec++;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1299  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1300  			err = check_and_set_masks(idtcm, regaddr, val);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1301  		}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1302  
7ea5fda2b1325e Min Li        2020-07-28  1303  		if (err != -EINVAL) {
7ea5fda2b1325e Min Li        2020-07-28  1304  			err = 0;
7ea5fda2b1325e Min Li        2020-07-28  1305  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1306  			/* Top (status registers) and bottom are read-only */
9fe9b9792d7236 Min Li        2023-11-09  1307  			if (regaddr < SCSR_ADDR(GPIO_USER_CONTROL) || regaddr >= scratch)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1308  				continue;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1309  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1310  			/* Page size 128, last 4 bytes of page skipped */
77fdb168a3e2a6 Vincent Cheng 2021-02-17  1311  			if ((loaddr > 0x7b && loaddr <= 0x7f) || loaddr > 0xfb)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1312  				continue;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1313  
9fe9b9792d7236 Min Li        2023-11-09  1314  			err = idtcm_write(idtcm, SCSR_BASE, regaddr, &val, sizeof(val));
3a6ba7dc779935 Vincent Cheng 2019-10-31  1315  		}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1316  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1317  		if (err)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1318  			goto out;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1319  	}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1320  
7ea5fda2b1325e Min Li        2020-07-28  1321  	display_pll_and_masks(idtcm);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1322  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1323  out:
3a6ba7dc779935 Vincent Cheng 2019-10-31  1324  	release_firmware(fw);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1325  	return err;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1326  }
3a6ba7dc779935 Vincent Cheng 2019-10-31  1327  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

