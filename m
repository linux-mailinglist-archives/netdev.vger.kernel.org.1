Return-Path: <netdev+bounces-209295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B9B0EF2B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB411C86568
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3328C869;
	Wed, 23 Jul 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL7q6tLR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CE286D4C;
	Wed, 23 Jul 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264996; cv=none; b=rpsceNJiiTlmttRal6AdStt/MDfjIFTqad3W/Yqe3owY0jQXNnVaLXeYip7rUnply/eTz8iEjOejgSPPbaeLT23kmuEHjGpCBihSmOPChykjpjWtxr3h3uyAGh+VbNZg2PuiPaJm9bgycQGIl1EwJoiRTD1Je/3EKz5Zz/HB8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264996; c=relaxed/simple;
	bh=WhkDfPWxEQjwvi3fU4SbkTPCUohJ6FleVNUjJZPG13U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew4jP+60lCjYAW3yrHHbe08OSupbKpT0PvLsXmLkBEOy63nBr/noFQxAtcCPbwYXJ5f75rPdlrZryBJg6Rp98XsaABTGY3SgtPgMTueRmW+CwaZAhtSqAvAi29U3tC8ZsrCn9hBiX9BtasSElvJqMA+F4MJ/CPP9Hs81VRInMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL7q6tLR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753264994; x=1784800994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhkDfPWxEQjwvi3fU4SbkTPCUohJ6FleVNUjJZPG13U=;
  b=gL7q6tLRdZnNf6XuB6TLwCukQSezEIHf/kwY/8pkjbilifks2YD7vkY/
   3LOH1g4/9CM7soluhscOcbWYHswxEof1r7YwWGUXrqOjUCO51hwplYbSr
   FaQIH3p1npmUDUBffTK8ciNyJELMuxKZdMtet5MsbvalSd0YUQH7oyd6r
   3BwEbeU6Va+LcHq7j/Jrwp1avX0PJxD1qkjKDbJoJF/zhFgtebX/murIx
   FrhU+GxmnIh4cf6l72nGp4CWy47BDnjtPrTTfO/QZ9gUb9C5GA1XhLjUb
   KNlRFrWuVD/0hzKjAFP97SObXxjZ76vWvt07i3KmWqGGJh7mEZImsdBqG
   Q==;
X-CSE-ConnectionGUID: eqd3SvmNT4S+GbWm/bHiCA==
X-CSE-MsgGUID: NgMUTJzDTrSeTBl2Oyz2mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="72998214"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="72998214"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 03:03:14 -0700
X-CSE-ConnectionGUID: mIkY/a2kTDSEaf5JhyP2Yg==
X-CSE-MsgGUID: QRYuMu3DT1y8PMW5QV9AIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164849013"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jul 2025 03:03:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueWJZ-000JDD-0K;
	Wed, 23 Jul 2025 10:03:09 +0000
Date: Wed, 23 Jul 2025 18:02:24 +0800
From: kernel test robot <lkp@intel.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, git@amd.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	vineeth.karumanchi@amd.com
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
Message-ID: <202507231739.LnkR6Gdd-lkp@intel.com>
References: <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722154111.1871292-4-vineeth.karumanchi@amd.com>

Hi Vineeth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vineeth-Karumanchi/net-macb-Define-ENST-hardware-registers-for-time-aware-scheduling/20250722-234618
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250722154111.1871292-4-vineeth.karumanchi%40amd.com
patch subject: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE command offload support
config: i386-randconfig-015-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231739.LnkR6Gdd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231739.LnkR6Gdd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231739.LnkR6Gdd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/cadence/macb_main.c:4109:7: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
    4108 |                 netdev_err(ndev, "Too many TAPRIO entries: %lu > %d queues\n",
         |                                                            ~~~
         |                                                            %zu
    4109 |                            conf->num_entries, bp->num_queues);
         |                            ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/cadence/macb_main.c:4212:6: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
    4211 |         netdev_dbg(ndev, "TAPRIO setup: %lu entries, base_time=%lld ns, cycle_time=%llu ns\n",
         |                                         ~~~
         |                                         %zu
    4212 |                    conf->num_entries, conf->base_time, conf->cycle_time);
         |                    ^~~~~~~~~~~~~~~~~
   include/net/net_debug.h:66:46: note: expanded from macro 'netdev_dbg'
      66 |                 netdev_printk(KERN_DEBUG, __dev, format, ##args); \
         |                                                  ~~~~~~    ^~~~
   drivers/net/ethernet/cadence/macb_main.c:4235:7: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
    4234 |         netdev_info(ndev, "TAPRIO configuration completed successfully: %lu entries, %d queues configured\n",
         |                                                                         ~~~
         |                                                                         %zu
    4235 |                     conf->num_entries, hweight32(configured_queues));
         |                     ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/cadence/macb_main.c:4088:12: warning: unused function 'macb_taprio_setup_replace' [-Wunused-function]
    4088 | static int macb_taprio_setup_replace(struct net_device *ndev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +4109 drivers/net/ethernet/cadence/macb_main.c

  4087	
  4088	static int macb_taprio_setup_replace(struct net_device *ndev,
  4089					     struct tc_taprio_qopt_offload *conf)
  4090	{
  4091		u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
  4092		struct queue_enst_configs  *enst_queue;
  4093		u32 configured_queues = 0, speed = 0;
  4094		struct tc_taprio_sched_entry *entry;
  4095		struct macb *bp = netdev_priv(ndev);
  4096		struct ethtool_link_ksettings kset;
  4097		struct macb_queue *queue;
  4098		unsigned long flags;
  4099		int err = 0, i;
  4100	
  4101		/* Validate queue configuration */
  4102		if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {
  4103			netdev_err(ndev, "Invalid number of queues: %d\n", bp->num_queues);
  4104			return -EINVAL;
  4105		}
  4106	
  4107		if (conf->num_entries > bp->num_queues) {
  4108			netdev_err(ndev, "Too many TAPRIO entries: %lu > %d queues\n",
> 4109				   conf->num_entries, bp->num_queues);
  4110			return -EINVAL;
  4111		}
  4112	
  4113		if (start_time < 0) {
  4114			netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
  4115				   conf->base_time);
  4116			return -ERANGE;
  4117		}
  4118	
  4119		/* Get the current link speed */
  4120		err = phylink_ethtool_ksettings_get(bp->phylink, &kset);
  4121		if (unlikely(err)) {
  4122			netdev_err(ndev, "Failed to get link settings: %d\n", err);
  4123			return err;
  4124		}
  4125	
  4126		speed = kset.base.speed;
  4127		if (unlikely(speed <= 0)) {
  4128			netdev_err(ndev, "Invalid speed: %d\n", speed);
  4129			return -EINVAL;
  4130		}
  4131	
  4132		enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
  4133		if (!enst_queue)
  4134			return -ENOMEM;
  4135	
  4136		/* Pre-validate all entries before making any hardware changes */
  4137		for (i = 0; i < conf->num_entries; i++) {
  4138			entry = &conf->entries[i];
  4139	
  4140			if (entry->command != TC_TAPRIO_CMD_SET_GATES) {
  4141				netdev_err(ndev, "Entry %d: unsupported command %d\n",
  4142					   i, entry->command);
  4143				err = -EOPNOTSUPP;
  4144				goto cleanup;
  4145			}
  4146	
  4147			/* Validate gate_mask: must be nonzero, single queue, and within range */
  4148			if (!is_power_of_2(entry->gate_mask)) {
  4149				netdev_err(ndev, "Entry %d: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
  4150					   i, entry->gate_mask);
  4151				err = -EINVAL;
  4152				goto cleanup;
  4153			}
  4154	
  4155			/* gate_mask must not select queues outside the valid queue_mask */
  4156			if (entry->gate_mask & ~bp->queue_mask) {
  4157				netdev_err(ndev, "Entry %d: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
  4158					   i, entry->gate_mask, bp->num_queues);
  4159				err = -EINVAL;
  4160				goto cleanup;
  4161			}
  4162	
  4163			/* Check for start time limits */
  4164			start_time_sec = div_u64(start_time, NSEC_PER_SEC);
  4165			if (start_time_sec > ENST_MAX_START_TIME_SEC) {
  4166				netdev_err(ndev, "Entry %d: Start time %llu s exceeds hardware limit\n",
  4167					   i, start_time_sec);
  4168				err = -ERANGE;
  4169				goto cleanup;
  4170			}
  4171	
  4172			/* Check for on time limit*/
  4173			if (entry->interval > ENST_MAX_HW_INTERVAL(speed)) {
  4174				netdev_err(ndev, "Entry %d: interval %u ns exceeds hardware limit %lu ns\n",
  4175					   i, entry->interval, ENST_MAX_HW_INTERVAL(speed));
  4176				err = -ERANGE;
  4177				goto cleanup;
  4178			}
  4179	
  4180			/* Check for off time limit*/
  4181			if ((conf->cycle_time - entry->interval) > ENST_MAX_HW_INTERVAL(speed)) {
  4182				netdev_err(ndev, "Entry %d: off_time %llu ns exceeds hardware limit %lu ns\n",
  4183					   i, conf->cycle_time - entry->interval,
  4184					   ENST_MAX_HW_INTERVAL(speed));
  4185				err = -ERANGE;
  4186				goto cleanup;
  4187			}
  4188	
  4189			enst_queue[i].queue_id = order_base_2(entry->gate_mask);
  4190			enst_queue[i].start_time_mask =
  4191				(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
  4192					  (start_time % NSEC_PER_SEC);
  4193			enst_queue[i].on_time_bytes =
  4194				ENST_NS_TO_HW_UNITS(entry->interval, speed);
  4195			enst_queue[i].off_time_bytes =
  4196				ENST_NS_TO_HW_UNITS(conf->cycle_time - entry->interval, speed);
  4197	
  4198			configured_queues |= entry->gate_mask;
  4199			total_on_time += entry->interval;
  4200			start_time += entry->interval;
  4201		}
  4202	
  4203		/* Check total interval doesn't exceed cycle time */
  4204		if (total_on_time > conf->cycle_time) {
  4205			netdev_err(ndev, "Total ON %llu ns exceeds cycle time %llu ns\n",
  4206				   total_on_time, conf->cycle_time);
  4207			err = -EINVAL;
  4208			goto cleanup;
  4209		}
  4210	
  4211		netdev_dbg(ndev, "TAPRIO setup: %lu entries, base_time=%lld ns, cycle_time=%llu ns\n",
  4212			   conf->num_entries, conf->base_time, conf->cycle_time);
  4213	
  4214		/* All validations passed - proceed with hardware configuration */
  4215		spin_lock_irqsave(&bp->lock, flags);
  4216	
  4217		/* Disable ENST queues if running before configuring */
  4218		if (gem_readl(bp, ENST_CONTROL))
  4219			gem_writel(bp, ENST_CONTROL,
  4220				   GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET);
  4221	
  4222		for (i = 0; i < conf->num_entries; i++) {
  4223			queue = &bp->queues[enst_queue[i].queue_id];
  4224			/* Configure queue timing registers */
  4225			queue_writel(queue, ENST_START_TIME, enst_queue[i].start_time_mask);
  4226			queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
  4227			queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
  4228		}
  4229	
  4230		/* Enable ENST for all configured queues in one write */
  4231		gem_writel(bp, ENST_CONTROL, configured_queues);
  4232		spin_unlock_irqrestore(&bp->lock, flags);
  4233	
  4234		netdev_info(ndev, "TAPRIO configuration completed successfully: %lu entries, %d queues configured\n",
  4235			    conf->num_entries, hweight32(configured_queues));
  4236	
  4237	cleanup:
  4238		kfree(enst_queue);
  4239		return err;
  4240	}
  4241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

