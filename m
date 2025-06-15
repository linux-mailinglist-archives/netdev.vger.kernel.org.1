Return-Path: <netdev+bounces-197857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30DFADA116
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 07:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4111D171EA9
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F2224AE0;
	Sun, 15 Jun 2025 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feUKtGyL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4F11CBA
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749966201; cv=none; b=QujA3WVXSQS2doQWZsrwS+XLeHuNTHYmYsRNOwtLRQus8GWkj2qKIbwsO6sYWSt7Vcj19yfxJX0Cp32Y0RfEKpEr+FRiwzvzky6fekGIdhc+fghIelMWiovfBbEWXS3SOFZ/HBNip+RQ89QdBINTQIYuBg4SDdYs2PT4escjHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749966201; c=relaxed/simple;
	bh=k68FAfgMglpcJTS0vfGq/UQgs9713DxFaWhf75YtcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYP5QTnOaY9PwJezsColaVBzvEnrKleyYJ03+j9eWuLtAylfr34x4lxLtHoiRNODiuSG8QLXUeP/T+wpxz8oO9jaLe1NCT6P679cYqexH5rUY6NieCW+HmXD7wxhO9yNVOGnraETiO2fPcW6eNlHCRcSGqP68SjLsfkGKAXuuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feUKtGyL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749966200; x=1781502200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k68FAfgMglpcJTS0vfGq/UQgs9713DxFaWhf75YtcZ4=;
  b=feUKtGyLMBAKPHXgqm0aPvCTqWiCW9HsGm8M6i5dy08ZKkoZMIQGhAgo
   fbtLm+5ThK2+rEVfyisvGzHNJJFCcuOoJcakMKeDeDNbJjQmldQ5QSfgd
   tGRLZoOrs3xDTKf45gyv+vOGi4NdRFsWzr8EUDeEAMwHTX48HAWgJTubL
   meI6cSZWZyss1aOAJ0guVVfHIvShc8ebSqrYD7XeF5DMuk8fxiWJnr2+8
   dcMsVyrJJV6SzNGnVpUz7U/MvKB1Go6x0t3L/NZV+kXKk02MSNUPnCdN6
   F1fzdRMHONn/IEJ/2FfC279hXkGDNuYu/JHW7meK6Zyh7Yv9dOntMlJF+
   A==;
X-CSE-ConnectionGUID: nfk6ZzwqQQWCvrt4bxoNFA==
X-CSE-MsgGUID: lD/rnXmHRSeSCvh5TPKVRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="51245900"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="51245900"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 22:43:20 -0700
X-CSE-ConnectionGUID: NAPRCpU6TCeXqvT9VG8ilA==
X-CSE-MsgGUID: Gptpnn2XRSe33Tbjnn+j1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="148016526"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Jun 2025 22:43:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQg9C-000E92-1S;
	Sun, 15 Jun 2025 05:43:14 +0000
Date: Sun, 15 Jun 2025 13:42:19 +0800
From: kernel test robot <lkp@intel.com>
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jv@jvosburgh.net, wilder@us.ibm.com,
	pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com, i.maximets@ovn.org,
	amorenoz@redhat.com, haliu@redhat.com
Subject: Re: [PATCH net-next v3 2/4] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <202506151306.ebIcSmWf-lkp@intel.com>
References: <20250614014900.226472-3-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614014900.226472-3-wilder@us.ibm.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wilder/bonding-Adding-struct-bond_arp_target/20250614-095027
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250614014900.226472-3-wilder%40us.ibm.com
patch subject: [PATCH net-next v3 2/4] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
config: openrisc-randconfig-r133-20250615 (https://download.01.org/0day-ci/archive/20250615/202506151306.ebIcSmWf-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250615/202506151306.ebIcSmWf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506151306.ebIcSmWf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/bonding/bond_options.c:1244:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] target_ip @@     got unsigned long long const [usertype] value @@
   drivers/net/bonding/bond_options.c:1244:34: sparse:     expected restricted __be32 [addressable] [usertype] target_ip
   drivers/net/bonding/bond_options.c:1244:34: sparse:     got unsigned long long const [usertype] value
   drivers/net/bonding/bond_options.c: note: in included file:
>> include/net/bonding.h:810:55: sparse: sparse: Using plain integer as NULL pointer
--
   drivers/net/bonding/bond_main.c: note: in included file:
>> include/net/bonding.h:810:55: sparse: sparse: Using plain integer as NULL pointer

vim +1244 drivers/net/bonding/bond_options.c

  1224	
  1225	static int bond_option_arp_ip_targets_set(struct bonding *bond,
  1226						  const struct bond_opt_value *newval)
  1227	{
  1228		int ret = -EPERM;
  1229		struct bond_arp_target target;
  1230	
  1231		if (newval->string) {
  1232			if (strlen(newval->string) < 1 ||
  1233			    bond_arp_ip_target_opt_parse(newval->string + 1, &target)) {
  1234				netdev_err(bond->dev, "invalid ARP target specified\n");
  1235				return ret;
  1236			}
  1237			if (newval->string[0] == '+')
  1238				ret = bond_option_arp_ip_target_add(bond, target);
  1239			else if (newval->string[0] == '-')
  1240				ret = bond_option_arp_ip_target_rem(bond, target);
  1241			else
  1242				netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
  1243		} else {
> 1244			target.target_ip = newval->value;
  1245			ret = bond_option_arp_ip_target_add(bond, target);
  1246		}
  1247	
  1248		return ret;
  1249	}
  1250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

