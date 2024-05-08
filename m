Return-Path: <netdev+bounces-94609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE68BFFDB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFC828486B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE785626;
	Wed,  8 May 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9z0Xtzh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C78563D;
	Wed,  8 May 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178308; cv=none; b=U5HcZ+nwfFyODU/1ldNcZpbbwQpc071KxHINqxtlqj9SRLjU7uaR2zkpBdo8m1gNbERR1+oj/K1KIbh58gyasD+CXD1/QF/a51BNI/l/ABPyRMO2weSmmJDhKcnDH3I6aDHyHM29wMX1hvAjHhArhzuyOVQ47tfZfyzPkoDpfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178308; c=relaxed/simple;
	bh=Q8EdklBvi0mIChkWeowYvf8T5q15r9lrjv+MIn+aa8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDIbMmWg6jnmIp48eRKyzxPBHGFJRFXYdvHzu1HkHhWWTmMAGobgkBQvdr4L35e2meA9FO2vtUj9+n2T63570IfEPzJSHlWeXYXXtjcjB3pNN2x0X3SdaGeKnI06mM5U+uc9k+E4Xq/09igzVZGV4BvEE7z1qEeQZRBXcJGMOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9z0Xtzh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715178307; x=1746714307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8EdklBvi0mIChkWeowYvf8T5q15r9lrjv+MIn+aa8A=;
  b=T9z0XtzhoBVtTcJMYAbXL/ZZj4kcom3p1RnC1JU6y315BBN/kbd/2b7h
   QAYxGn2rJ29BZvB9n3G+g+DqyhYAE9FqIlcvM8k5lphxEqJVKQvViY8Yp
   UpXKnPZ0RDrFO55RXlFD//DSrrRS/osWJBYDnkxKB55sXHsqtN/PNzfHH
   prZBo4+SF3crUkp8j6C3Fcz4O+YVRokhV7Nnhtf5hZlvFL8o/QnN3wV2H
   okqMaKmQCce8hX/r48lPWLgPhpbx6dTWCOsSCrJpUSqTR4hTNXigJw252
   cNo9oo8Kxv3fJin3fVMmKzAqweC5kvPoJNayaD7X7WkrVaUJ+MjF8h1Vo
   Q==;
X-CSE-ConnectionGUID: em56PmwQRS61XQzFIPOk8w==
X-CSE-MsgGUID: A/StZNDHT2qAuXjQdNLAWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="13989191"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="13989191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:25:06 -0700
X-CSE-ConnectionGUID: Or+Y93ZeT4CuhZFdQnXcew==
X-CSE-MsgGUID: JdmqQmIHSvyVq4Yik03rsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="60070546"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 May 2024 07:25:02 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4iE8-0003ck-0U;
	Wed, 08 May 2024 14:25:00 +0000
Date: Wed, 8 May 2024 22:24:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jeroendb@google.com,
	pkaligineedi@google.com, shailend@google.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	willemb@google.com, hramamurthy@google.com, rushilg@google.com,
	ziweixiao@google.com, jfraker@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] gve: Add flow steering adminq commands
Message-ID: <202405082251.rL1Lk120-lkp@intel.com>
References: <20240507225945.1408516-5-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507225945.1408516-5-ziweixiao@google.com>

Hi Ziwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziwei-Xiao/gve-Add-adminq-mutex-lock/20240508-071419
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240507225945.1408516-5-ziweixiao%40google.com
patch subject: [PATCH net-next 4/5] gve: Add flow steering adminq commands
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240508/202405082251.rL1Lk120-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405082251.rL1Lk120-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405082251.rL1Lk120-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/google/gve/gve_adminq.c: In function 'gve_adminq_process_flow_rules_query':
>> drivers/net/ethernet/google/gve/gve_adminq.c:1259:15: warning: variable 'descriptor_end' set but not used [-Wunused-but-set-variable]
    1259 |         void *descriptor_end, *rule_info;
         |               ^~~~~~~~~~~~~~


vim +/descriptor_end +1259 drivers/net/ethernet/google/gve/gve_adminq.c

  1248	
  1249	/* In the dma memory that the driver allocated for the device to query the flow rules, the device
  1250	 * will first write it with a struct of gve_query_flow_rules_descriptor. Next to it, the device
  1251	 * will write an array of rules or rule ids with the count that specified in the descriptor.
  1252	 * For GVE_FLOW_RULE_QUERY_STATS, the device will only write the descriptor.
  1253	 */
  1254	static int gve_adminq_process_flow_rules_query(struct gve_priv *priv, u16 query_opcode,
  1255						       struct gve_query_flow_rules_descriptor *descriptor)
  1256	{
  1257		struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
  1258		u32 num_queried_rules, total_memory_len, rule_info_len;
> 1259		void *descriptor_end, *rule_info;
  1260	
  1261		total_memory_len = be32_to_cpu(descriptor->total_length);
  1262		if (total_memory_len > GVE_ADMINQ_BUFFER_SIZE) {
  1263			dev_err(&priv->dev->dev, "flow rules query is out of memory.\n");
  1264			return -ENOMEM;
  1265		}
  1266	
  1267		num_queried_rules = be32_to_cpu(descriptor->num_queried_rules);
  1268		descriptor_end = (void *)descriptor + total_memory_len;
  1269		rule_info = (void *)(descriptor + 1);
  1270	
  1271		switch (query_opcode) {
  1272		case GVE_FLOW_RULE_QUERY_RULES:
  1273			rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rules_cache);
  1274	
  1275			memcpy(flow_rules_cache->rules_cache, rule_info, rule_info_len);
  1276			flow_rules_cache->rules_cache_num = num_queried_rules;
  1277			break;
  1278		case GVE_FLOW_RULE_QUERY_IDS:
  1279			rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rule_ids_cache);
  1280	
  1281			memcpy(flow_rules_cache->rule_ids_cache, rule_info, rule_info_len);
  1282			flow_rules_cache->rule_ids_cache_num = num_queried_rules;
  1283			break;
  1284		case GVE_FLOW_RULE_QUERY_STATS:
  1285			priv->num_flow_rules = be32_to_cpu(descriptor->num_flow_rules);
  1286			priv->max_flow_rules = be32_to_cpu(descriptor->max_flow_rules);
  1287			return 0;
  1288		default:
  1289			return -EINVAL;
  1290		}
  1291	
  1292		return  0;
  1293	}
  1294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

