Return-Path: <netdev+bounces-122424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B79613EA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1701F21322
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149D1C9DC2;
	Tue, 27 Aug 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALsTcoga"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F1C4EE3
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775845; cv=none; b=sia66DQjJ+DbeRUfT0FGklkxSDgtZDxsOfwSCPYPhK5cdgCm85e4xjliY3QGd9w1CQqsna0DXeoKj9huG1TrbSV2uGIZ4KUdO4oALtLUrePoRudRN0NUMKIStkL/sG4xmjHiqxF/QYjpWJ0OonDrcqMtYAkUWXBYT9vgowh41e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775845; c=relaxed/simple;
	bh=/tTl9pWQ1mVhlUOIkKeqFbmEBO0aqcpxpKOrmmgEI3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF81uEPscLFyt+m2jQwbHbpdm1drQ97Eqw3uXux+qbajvkG+QyI0zO6rbt7rBnetkWcUnhOC4pHvOj1vn5Wsw6d7ZGsVCwZk6TALBqQgSLbIvoOZe3R7Ok1MkowL/2CzyKhgqouqkIkK9FmTfmE+RvxButqWxZ9ZuyAJq4TJiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALsTcoga; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724775844; x=1756311844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/tTl9pWQ1mVhlUOIkKeqFbmEBO0aqcpxpKOrmmgEI3c=;
  b=ALsTcogaisZZm6lY9XPTQRhBZDx/sVU5CTCbCfsRd+DP+C1BovRaNA47
   bCgp/bcFJuZcGawbwMKaFLuTEhEtZAP9/145OozyxFl2KJpO/Tu6rNHaD
   aFV+I2cBbkPY/6OuWslXsNtr+o5njwP7r1a+mNCOfOzXx7O90LWITakE8
   gY4gYFILcJkLsxmk6ifK4Z5g11Zv5pu4AlG+Cy3G5d9OdtP57PsYM7R+n
   rNzhmOlUb/qflsabr8jrdEaiIAPA4AOEPBhDuWbirc634LP4w4ZF2CjLD
   k+oSrot1nO7txczgHtwkL0UhlBThcxHVs2yd6BcFppEVbSCxGJpC+rivw
   w==;
X-CSE-ConnectionGUID: dG5Uru51RDu5szUHZyq+1w==
X-CSE-MsgGUID: MnjT+bDmReavSBPS6XdIJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33924221"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="33924221"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 09:24:01 -0700
X-CSE-ConnectionGUID: eHCd9/HeRUmU4IqfrfIeXg==
X-CSE-MsgGUID: zY7MwNdhQcO1e1sRwilrrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62641730"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2024 09:23:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siyz6-000Jpu-2R;
	Tue, 27 Aug 2024 16:23:56 +0000
Date: Wed, 28 Aug 2024 00:23:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, sam@mendozajonas.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lihongbo22@huawei.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify
 the code
Message-ID: <202408280039.0XTdLUnn-lkp@intel.com>
References: <20240827025246.963115-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025246.963115-2-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/net-ncsi-Use-str_up_down-to-simplify-the-code/20240827-104622
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240827025246.963115-2-lihongbo22%40huawei.com
patch subject: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify the code
config: arc-randconfig-001-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280039.0XTdLUnn-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280039.0XTdLUnn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280039.0XTdLUnn-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:38,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from net/ncsi/ncsi-manage.c:9:
   net/ncsi/ncsi-manage.c: In function 'ncsi_choose_active_channel':
>> net/ncsi/ncsi-manage.c:1284:44: error: implicit declaration of function 'str_up_down' [-Werror=implicit-function-declaration]
    1284 |                                            str_up_down(ncm->data[2] & 0x1));
         |                                            ^~~~~~~~~~~
   include/net/net_debug.h:66:60: note: in definition of macro 'netdev_dbg'
      66 |                 netdev_printk(KERN_DEBUG, __dev, format, ##args); \
         |                                                            ^~~~
>> net/ncsi/ncsi-manage.c:1282:44: warning: format '%s' expects argument of type 'char *', but argument 5 has type 'int' [-Wformat=]
    1282 |                                            "NCSI: Channel %u added to queue (link %s)\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1283 |                                            nc->id,
    1284 |                                            str_up_down(ncm->data[2] & 0x1));
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            int
   include/net/net_debug.h:66:50: note: in definition of macro 'netdev_dbg'
      66 |                 netdev_printk(KERN_DEBUG, __dev, format, ##args); \
         |                                                  ^~~~~~
   net/ncsi/ncsi-manage.c:1282:84: note: format string is defined here
    1282 |                                            "NCSI: Channel %u added to queue (link %s)\n",
         |                                                                                   ~^
         |                                                                                    |
         |                                                                                    char *
         |                                                                                   %d
   cc1: some warnings being treated as errors


vim +/str_up_down +1284 net/ncsi/ncsi-manage.c

  1224	
  1225	static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
  1226	{
  1227		struct ncsi_channel *nc, *found, *hot_nc;
  1228		struct ncsi_channel_mode *ncm;
  1229		unsigned long flags, cflags;
  1230		struct ncsi_package *np;
  1231		bool with_link;
  1232	
  1233		spin_lock_irqsave(&ndp->lock, flags);
  1234		hot_nc = ndp->hot_channel;
  1235		spin_unlock_irqrestore(&ndp->lock, flags);
  1236	
  1237		/* By default the search is done once an inactive channel with up
  1238		 * link is found, unless a preferred channel is set.
  1239		 * If multi_package or multi_channel are configured all channels in the
  1240		 * whitelist are added to the channel queue.
  1241		 */
  1242		found = NULL;
  1243		with_link = false;
  1244		NCSI_FOR_EACH_PACKAGE(ndp, np) {
  1245			if (!(ndp->package_whitelist & (0x1 << np->id)))
  1246				continue;
  1247			NCSI_FOR_EACH_CHANNEL(np, nc) {
  1248				if (!(np->channel_whitelist & (0x1 << nc->id)))
  1249					continue;
  1250	
  1251				spin_lock_irqsave(&nc->lock, cflags);
  1252	
  1253				if (!list_empty(&nc->link) ||
  1254				    nc->state != NCSI_CHANNEL_INACTIVE) {
  1255					spin_unlock_irqrestore(&nc->lock, cflags);
  1256					continue;
  1257				}
  1258	
  1259				if (!found)
  1260					found = nc;
  1261	
  1262				if (nc == hot_nc)
  1263					found = nc;
  1264	
  1265				ncm = &nc->modes[NCSI_MODE_LINK];
  1266				if (ncm->data[2] & 0x1) {
  1267					found = nc;
  1268					with_link = true;
  1269				}
  1270	
  1271				/* If multi_channel is enabled configure all valid
  1272				 * channels whether or not they currently have link
  1273				 * so they will have AENs enabled.
  1274				 */
  1275				if (with_link || np->multi_channel) {
  1276					spin_lock_irqsave(&ndp->lock, flags);
  1277					list_add_tail_rcu(&nc->link,
  1278							  &ndp->channel_queue);
  1279					spin_unlock_irqrestore(&ndp->lock, flags);
  1280	
  1281					netdev_dbg(ndp->ndev.dev,
> 1282						   "NCSI: Channel %u added to queue (link %s)\n",
  1283						   nc->id,
> 1284						   str_up_down(ncm->data[2] & 0x1));
  1285				}
  1286	
  1287				spin_unlock_irqrestore(&nc->lock, cflags);
  1288	
  1289				if (with_link && !np->multi_channel)
  1290					break;
  1291			}
  1292			if (with_link && !ndp->multi_package)
  1293				break;
  1294		}
  1295	
  1296		if (list_empty(&ndp->channel_queue) && found) {
  1297			netdev_info(ndp->ndev.dev,
  1298				    "NCSI: No channel with link found, configuring channel %u\n",
  1299				    found->id);
  1300			spin_lock_irqsave(&ndp->lock, flags);
  1301			list_add_tail_rcu(&found->link, &ndp->channel_queue);
  1302			spin_unlock_irqrestore(&ndp->lock, flags);
  1303		} else if (!found) {
  1304			netdev_warn(ndp->ndev.dev,
  1305				    "NCSI: No channel found to configure!\n");
  1306			ncsi_report_link(ndp, true);
  1307			return -ENODEV;
  1308		}
  1309	
  1310		return ncsi_process_next_channel(ndp);
  1311	}
  1312	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

