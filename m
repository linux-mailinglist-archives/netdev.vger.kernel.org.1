Return-Path: <netdev+bounces-256082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hw/DwpXgWkFFwMAu9opvQ
	(envelope-from <netdev+bounces-256082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56361D3968
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 739653002D2D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80612F12D9;
	Tue,  3 Feb 2026 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIepjBf9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA432F12AF;
	Tue,  3 Feb 2026 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084101; cv=none; b=TdjJukUmV254+6n60O6MyChtJjvoadytIzXXSFtv6RLQOVzXHZcLgVLpJkywQmrUDJxeijArD5xfYv9gTnawdmRy9myABO8xrAVnxF2tArpZ86CJGl1V8uZgmhbn7DCE2wBBxsKmtc8Fn/koVjXTDwBD77dDgWJgPOXvifWWLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084101; c=relaxed/simple;
	bh=/go1/gIN+rKkRetNSo+qi6KG2NfbHky2ufZfgC40C0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3DmkjFO9q9x+DDZZPikRjzD86y4JE9AtBo24S0TDIxa6YUtQ5h4sn+L9yScgQH+jMh7zZNjLnhgPVGtQFReTJ3BkqaTlWoQsSOw6SSm4ZWPlY+fbp86cLmb/EsBXD0idH9NXpYl4uxE2rbyhgNBW0F2QdheWFWtg5QVJOxDEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIepjBf9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770084100; x=1801620100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/go1/gIN+rKkRetNSo+qi6KG2NfbHky2ufZfgC40C0k=;
  b=oIepjBf9nYeICDjH40D+CMNlf0cQjKjWCREY2TWJ2TmMeYG7OxTwp4rd
   5wpkoQNFoxcOifzSRmzSI35YEIzYwvEJ/Fz9WDCr+n+4nv5RrrLBe7KoO
   xlCn9TyjNI7JxKWHLbeojQ2IcXpfJzyYGtXtZ7G82uKRFA5vizB4gPb5W
   7ItP+auY1PHMWm2+7TFtQioBwnxBXknDdK5FaMvbrO9R50uARPs/xb3Xh
   NgPQ28EH4LDkwuE8W3JOZldE1vwiYDFmTJ3L/R2HzNOm+JrpmbaRxscO+
   PqkEvmdUd6fJNi1PRfEXmHe+oGgx2Ej6TIZsh7zAEiJmenYSZNSKn68GJ
   A==;
X-CSE-ConnectionGUID: g9/o6ZJrQmefR9GtNFrz6g==
X-CSE-MsgGUID: PigVhd6BSNu+HploujWBTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71150693"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71150693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:01:39 -0800
X-CSE-ConnectionGUID: Eltt1B2NSvefwS8+Ki2Yjg==
X-CSE-MsgGUID: JOoMF02DSHqvtYY0HIDQ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="240368922"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Feb 2026 18:01:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn5jR-00000000g8i-0IeS;
	Tue, 03 Feb 2026 02:01:33 +0000
Date: Tue, 3 Feb 2026 10:00:48 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	Shyam-sundar.S-k@amd.com, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH 2/3] net: amd-xgbe: add ARP offload ethtool self-test
Message-ID: <202602030920.SWN7cwzT-lkp@intel.com>
References: <20260202153542.1727429-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202153542.1727429-3-Raju.Rangoju@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256082-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: 56361D3968
X-Rspamd-Action: no action

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master v6.19-rc8 next-20260202]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/net-amd-xgbe-add-hardware-ARP-offload-support/20260202-235023
base:   net/main
patch link:    https://lore.kernel.org/r/20260202153542.1727429-3-Raju.Rangoju%40amd.com
patch subject: [PATCH 2/3] net: amd-xgbe: add ARP offload ethtool self-test
config: powerpc-randconfig-002-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030920.SWN7cwzT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030920.SWN7cwzT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030920.SWN7cwzT-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/net/ethernet/amd/xgbe/xgbe-selftest.o: in function `xgbe_test_arpoffload':
>> drivers/net/ethernet/amd/xgbe/xgbe-selftest.c:230: undefined reference to `arp_create'
   powerpc-linux-ld: net/core/selftests.o: in function `net_test_get_skb':
   net/core/selftests.c:104: undefined reference to `ip_send_check'
   powerpc-linux-ld: net/core/selftests.c:148: undefined reference to `udp4_hwcsum'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
   WARNING: unmet direct dependencies detected for NET_SELFTESTS
   Depends on [n]: NET [=y] && PHYLIB [=y] && INET [=n]
   Selected by [y]:
   - AMD_XGBE [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_AMD [=y] && (OF_ADDRESS [=y] || ACPI || PCI [=n]) && HAS_IOMEM [=y] && (X86 || ARM64 || COMPILE_TEST [=y]) && PTP_1588_CLOCK_OPTIONAL [=y]


vim +230 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

   194	
   195	static int xgbe_test_arpoffload(struct xgbe_prv_data *pdata)
   196	{
   197		unsigned char src[ETH_ALEN] = {0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
   198		unsigned char bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
   199		struct net_packet_attrs attr = {};
   200		struct net_test_priv *tdata;
   201		struct sk_buff *skb = NULL;
   202		u32 dst_ip = 0xabcdefab;
   203		u32 src_ip = 0xefdcbaef;
   204		int ret;
   205	
   206		/* Check if ARP offload is supported */
   207		if (!pdata->hw_feat.aoe)
   208			return -EOPNOTSUPP;
   209	
   210		tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
   211		if (!tdata)
   212			return -ENOMEM;
   213	
   214		tdata->ok = false;
   215		init_completion(&tdata->comp);
   216	
   217		tdata->pt.type = htons(ETH_P_ARP);
   218		tdata->pt.func = xgbe_test_arp_validate;
   219		tdata->pt.dev = pdata->netdev;
   220		tdata->pt.af_packet_priv = tdata;
   221		tdata->packet = &attr;
   222		dev_add_pack(&tdata->pt);
   223	
   224		attr.src = src;
   225		attr.ip_src = src_ip;
   226		attr.dst = bcast;
   227		attr.ip_dst = dst_ip;
   228	
   229		/* Create ARP request packet */
 > 230		skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, htonl(dst_ip),
   231				 pdata->netdev,	htonl(src_ip), NULL, src, bcast);
   232		if (!skb) {
   233			ret = -ENOMEM;
   234			goto free;
   235		}
   236	
   237		skb->pkt_type = PACKET_HOST;
   238		skb->dev = pdata->netdev;
   239		skb->protocol = htons(ETH_P_ARP);
   240	
   241		/* Enable ARP offload */
   242		xgbe_enable_arp_offload(pdata, dst_ip);
   243	
   244		ret = dev_set_promiscuity(pdata->netdev, 1);
   245		if (ret) {
   246			kfree_skb(skb);
   247			goto cleanup;
   248		}
   249	
   250		ret = dev_direct_xmit(skb, 0);
   251		if (ret)
   252			goto cleanup_promisc;
   253	
   254		/* Wait for ARP reply */
   255		wait_for_completion_timeout(&tdata->comp, NET_LB_TIMEOUT);
   256		ret = tdata->ok ? 0 : -ETIMEDOUT;
   257	
   258	cleanup_promisc:
   259		dev_set_promiscuity(pdata->netdev, -1);
   260	cleanup:
   261		xgbe_disable_arp_offload(pdata);
   262		dev_remove_pack(&tdata->pt);
   263	free:
   264		kfree(tdata);
   265		return ret;
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

