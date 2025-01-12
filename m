Return-Path: <netdev+bounces-157501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DDA0A755
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 06:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D602816786A
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EE148FF2;
	Sun, 12 Jan 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOvmso/h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09B1487D1;
	Sun, 12 Jan 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736661480; cv=none; b=lnzH6X9DDegYJu9175jg+toRXMMmcbVrqC4OS48crXPhvnFsc5hZU9TbZbw+ei6UMpz4U+Epkq/e14eY30/DwmxMPDp7GzRd8KzhOAJvLvtuexWK/pfscJYJ05LbpnBPrG2rQLTfEIHwR1m6ZH7BI7x4mnWNLZLy3FM2qBckL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736661480; c=relaxed/simple;
	bh=ozgWqf0jx/xZWk8QEPu4QqCu7tBlhGv6X58/iOsGaWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiAydOZU2LhXi9TDC+csKHPWoex1hSa8L33CQEGssphAPA7OU3moo0GFtXN6EPTaTXQcfR/AX4lbvpsE34JsddpEWS9Y9OkeiGdQ8fWQtM6U5LN3dTTCchLDGu1OeMjSXY+4wftYxT9IapG/A5CnMUwyz3N/viO9b12JCE5wwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOvmso/h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736661478; x=1768197478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ozgWqf0jx/xZWk8QEPu4QqCu7tBlhGv6X58/iOsGaWY=;
  b=hOvmso/hVP2/L8d4H663ZGOw9plgRwOnZY7yYhLb9iLRiV+ZQ0+isKPz
   WTl78BnMDpjuaU0MuDglekqsEr2qnHykldc28E9WCMmvdR7/HBJi+otgg
   2NgFrpBgGVoLcb8fUGUNFoGBQ0hRToGg9YspkOUEwLvswgf3HtLyETFSV
   TDGlEsP9Go4sKyfA6Pe3mVTR8nL/6aAwg71GqAXV7uorpDJvSPyfECfjM
   nJcS0aQRm3ZOASaEpXR7VFMbPcfCpBDGa53T21YawbCGP6EwGXepCMu9M
   3ny+iZ/XxIcJhySmSVpw6q9zT1hbfAR7RedT4jeBn/z7Fqv3ICLEwcq3U
   A==;
X-CSE-ConnectionGUID: 6JoybwxGSR+wQUN5qQy8tw==
X-CSE-MsgGUID: S/nfU0pzSpWkTF5yUJtuig==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="36193456"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="36193456"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 21:57:58 -0800
X-CSE-ConnectionGUID: 6TJ5VRYGSDmcyVlv6817Vg==
X-CSE-MsgGUID: eXAiOD7STdqItYNfRXINjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109226748"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jan 2025 21:57:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWqyt-000Lcx-1U;
	Sun, 12 Jan 2025 05:57:51 +0000
Date: Sun, 12 Jan 2025 13:57:36 +0800
From: kernel test robot <lkp@intel.com>
To: Potin Lai <potin.lai.pt@gmail.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Patrick Williams <patrick@stwcx.xyz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v2 2/2] net/ncsi: fix state race during channel probe
 completion
Message-ID: <202501121302.XcB6e2qZ-lkp@intel.com>
References: <20250111-fix-ncsi-mac-v2-2-838e0a1a233a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-fix-ncsi-mac-v2-2-838e0a1a233a@gmail.com>

Hi Potin,

kernel test robot noticed the following build errors:

[auto build test ERROR on fc033cf25e612e840e545f8d5ad2edd6ba613ed5]

url:    https://github.com/intel-lab-lkp/linux/commits/Potin-Lai/net-ncsi-fix-locking-in-Get-MAC-Address-handling/20250111-190440
base:   fc033cf25e612e840e545f8d5ad2edd6ba613ed5
patch link:    https://lore.kernel.org/r/20250111-fix-ncsi-mac-v2-2-838e0a1a233a%40gmail.com
patch subject: [PATCH v2 2/2] net/ncsi: fix state race during channel probe completion
config: arm64-randconfig-002-20250112 (https://download.01.org/0day-ci/archive/20250112/202501121302.XcB6e2qZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501121302.XcB6e2qZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501121302.XcB6e2qZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ncsi/ncsi-manage.c:1494:40: error: no member named 'max_package' in 'struct ncsi_dev_priv'
    1494 |                 if (ndp->package_probe_id + 1 < ndp->max_package)
         |                                                 ~~~  ^
   1 error generated.


vim +1494 net/ncsi/ncsi-manage.c

  1357	
  1358	static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
  1359	{
  1360		struct ncsi_dev *nd = &ndp->ndev;
  1361		struct ncsi_package *np;
  1362		struct ncsi_cmd_arg nca;
  1363		unsigned char index;
  1364		int ret;
  1365	
  1366		nca.ndp = ndp;
  1367		nca.req_flags = NCSI_REQ_FLAG_EVENT_DRIVEN;
  1368		switch (nd->state) {
  1369		case ncsi_dev_state_probe:
  1370			nd->state = ncsi_dev_state_probe_deselect;
  1371			fallthrough;
  1372		case ncsi_dev_state_probe_deselect:
  1373			ndp->pending_req_num = 8;
  1374	
  1375			/* Deselect all possible packages */
  1376			nca.type = NCSI_PKT_CMD_DP;
  1377			nca.channel = NCSI_RESERVED_CHANNEL;
  1378			for (index = 0; index < 8; index++) {
  1379				nca.package = index;
  1380				ret = ncsi_xmit_cmd(&nca);
  1381				if (ret)
  1382					goto error;
  1383			}
  1384	
  1385			nd->state = ncsi_dev_state_probe_package;
  1386			break;
  1387		case ncsi_dev_state_probe_package:
  1388			ndp->pending_req_num = 1;
  1389	
  1390			nca.type = NCSI_PKT_CMD_SP;
  1391			nca.bytes[0] = 1;
  1392			nca.package = ndp->package_probe_id;
  1393			nca.channel = NCSI_RESERVED_CHANNEL;
  1394			ret = ncsi_xmit_cmd(&nca);
  1395			if (ret)
  1396				goto error;
  1397			nd->state = ncsi_dev_state_probe_channel;
  1398			break;
  1399		case ncsi_dev_state_probe_channel:
  1400			ndp->active_package = ncsi_find_package(ndp,
  1401								ndp->package_probe_id);
  1402			if (!ndp->active_package) {
  1403				/* No response */
  1404				nd->state = ncsi_dev_state_probe_dp;
  1405				schedule_work(&ndp->work);
  1406				break;
  1407			}
  1408			nd->state = ncsi_dev_state_probe_cis;
  1409			if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC) &&
  1410			    ndp->mlx_multi_host)
  1411				nd->state = ncsi_dev_state_probe_mlx_gma;
  1412	
  1413			schedule_work(&ndp->work);
  1414			break;
  1415		case ncsi_dev_state_probe_mlx_gma:
  1416			ndp->pending_req_num = 1;
  1417	
  1418			nca.type = NCSI_PKT_CMD_OEM;
  1419			nca.package = ndp->active_package->id;
  1420			nca.channel = 0;
  1421			ret = ncsi_oem_gma_handler_mlx(&nca);
  1422			if (ret)
  1423				goto error;
  1424	
  1425			nd->state = ncsi_dev_state_probe_mlx_smaf;
  1426			break;
  1427		case ncsi_dev_state_probe_mlx_smaf:
  1428			ndp->pending_req_num = 1;
  1429	
  1430			nca.type = NCSI_PKT_CMD_OEM;
  1431			nca.package = ndp->active_package->id;
  1432			nca.channel = 0;
  1433			ret = ncsi_oem_smaf_mlx(&nca);
  1434			if (ret)
  1435				goto error;
  1436	
  1437			nd->state = ncsi_dev_state_probe_cis;
  1438			break;
  1439		case ncsi_dev_state_probe_keep_phy:
  1440			ndp->pending_req_num = 1;
  1441	
  1442			nca.type = NCSI_PKT_CMD_OEM;
  1443			nca.package = ndp->active_package->id;
  1444			nca.channel = 0;
  1445			ret = ncsi_oem_keep_phy_intel(&nca);
  1446			if (ret)
  1447				goto error;
  1448	
  1449			nd->state = ncsi_dev_state_probe_gvi;
  1450			break;
  1451		case ncsi_dev_state_probe_cis:
  1452		case ncsi_dev_state_probe_gvi:
  1453		case ncsi_dev_state_probe_gc:
  1454		case ncsi_dev_state_probe_gls:
  1455			np = ndp->active_package;
  1456			ndp->pending_req_num = 1;
  1457	
  1458			/* Clear initial state Retrieve version, capability or link status */
  1459			if (nd->state == ncsi_dev_state_probe_cis)
  1460				nca.type = NCSI_PKT_CMD_CIS;
  1461			else if (nd->state == ncsi_dev_state_probe_gvi)
  1462				nca.type = NCSI_PKT_CMD_GVI;
  1463			else if (nd->state == ncsi_dev_state_probe_gc)
  1464				nca.type = NCSI_PKT_CMD_GC;
  1465			else
  1466				nca.type = NCSI_PKT_CMD_GLS;
  1467	
  1468			nca.package = np->id;
  1469			nca.channel = ndp->channel_probe_id;
  1470	
  1471			ret = ncsi_xmit_cmd(&nca);
  1472			if (ret)
  1473				goto error;
  1474	
  1475			if (nd->state == ncsi_dev_state_probe_cis) {
  1476				nd->state = ncsi_dev_state_probe_gvi;
  1477				if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY) && ndp->channel_probe_id == 0)
  1478					nd->state = ncsi_dev_state_probe_keep_phy;
  1479			} else if (nd->state == ncsi_dev_state_probe_gvi) {
  1480				nd->state = ncsi_dev_state_probe_gc;
  1481			} else if (nd->state == ncsi_dev_state_probe_gc) {
  1482				nd->state = ncsi_dev_state_probe_gls;
  1483			} else {
  1484				nd->state = ncsi_dev_state_probe_cis;
  1485				ndp->channel_probe_id++;
  1486			}
  1487	
  1488			if (ndp->channel_probe_id == ndp->channel_count) {
  1489				ndp->channel_probe_id = 0;
  1490				nd->state = ncsi_dev_state_probe_dp;
  1491			}
  1492			break;
  1493		case ncsi_dev_state_probe_dp:
> 1494			if (ndp->package_probe_id + 1 < ndp->max_package)
  1495				ndp->pending_req_num = 1;
  1496			else
  1497				nca.req_flags = 0;
  1498	
  1499			/* Deselect the current package */
  1500			nca.type = NCSI_PKT_CMD_DP;
  1501			nca.package = ndp->package_probe_id;
  1502			nca.channel = NCSI_RESERVED_CHANNEL;
  1503			ret = ncsi_xmit_cmd(&nca);
  1504			if (ret)
  1505				goto error;
  1506	
  1507			/* Probe next package */
  1508			ndp->package_probe_id++;
  1509			if (ndp->package_probe_id >= 8) {
  1510				/* Probe finished */
  1511				ndp->flags |= NCSI_DEV_PROBED;
  1512				break;
  1513			}
  1514			nd->state = ncsi_dev_state_probe_package;
  1515			ndp->active_package = NULL;
  1516			break;
  1517		default:
  1518			netdev_warn(nd->dev, "Wrong NCSI state 0x%0x in enumeration\n",
  1519				    nd->state);
  1520		}
  1521	
  1522		if (ndp->flags & NCSI_DEV_PROBED) {
  1523			/* Check if all packages have HWA support */
  1524			ncsi_check_hwa(ndp);
  1525			ncsi_choose_active_channel(ndp);
  1526		}
  1527	
  1528		return;
  1529	error:
  1530		netdev_err(ndp->ndev.dev,
  1531			   "NCSI: Failed to transmit cmd 0x%x during probe\n",
  1532			   nca.type);
  1533		ncsi_report_link(ndp, true);
  1534	}
  1535	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

