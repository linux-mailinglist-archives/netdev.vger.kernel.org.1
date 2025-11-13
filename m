Return-Path: <netdev+bounces-238195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF8C55B51
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918493AD112
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4D30AD03;
	Thu, 13 Nov 2025 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6HHZh63"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57203016F3;
	Thu, 13 Nov 2025 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009488; cv=none; b=Ujz5W1WhWPPJlzSdEwTbt3UNX3PRCMQZcRyVflECEL8xuFx8OxlAF3ZVNHBJCCFr+DIkFPdYlifaaOiT7NM9YQk5sWn2EBtvDgp1driSS/eNhcqJ3cFNyyiy0U0tEHO4X+tLmF0/HbqfTfoPejYaHQNzOB60p0Eed/zf/ryDTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009488; c=relaxed/simple;
	bh=p3MURnA8+a2AwomYf173Mk7f1ObrU5IPQOpsrQZftQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXZecP0fWsn6U3VW8U8Xlq2ywrIjhSY1W6rlH+2/rkTRvYTSY2UxcPEjSsaCvqpjRPbpzBX4a0T3/2Ck8rAqsNlToUtFhLJaHI2R/roI9BkUSXiyvag8HEKSYlbr/ylLLg6+GaApp90SbzXEjsj1IS/8owHf2fix55ai6tmG5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6HHZh63; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009486; x=1794545486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3MURnA8+a2AwomYf173Mk7f1ObrU5IPQOpsrQZftQQ=;
  b=D6HHZh63T6Airy6DgX8XAVoJv+DW4n2qfiaoN686vZkKavXYufNWwXTe
   HYGT0KGVK4jnM0KKBYO5WghzS69bp2kdzIIxmtiuWfr27tQO9mUeEWiAQ
   n8FVAJ5V5GQhxcIG+nMD9xEfxwTWwDRtR0PrRz/enp889i7WMpisJHXjV
   HA1AmpUsGMK9UzTtXtbueoGtzhzZxxfx0X1ap/6SWkLB/2XwUS+/IHhun
   KzRlPeTy5kBErQYqmnH/I9I0Nz+JrKt0UDrsupluX1v9PqmwkS6VB6gik
   Ujr4WSzTJ7KnVqVF00iMWVlMisUt0EzgtIN174jT/6RzjfkHiYhRet9/t
   Q==;
X-CSE-ConnectionGUID: JIJhBl8nQ+20KE5iifK8fQ==
X-CSE-MsgGUID: jUpNZ6cATEKoDdRPDdX6mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65008618"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65008618"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:51:24 -0800
X-CSE-ConnectionGUID: 0qpWsKeBSk63twkjHQv99Q==
X-CSE-MsgGUID: 47EDhLe7TFu7KyKCFhWF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="194586219"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2025 20:51:22 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPIl-0004tP-0A;
	Thu, 13 Nov 2025 04:51:19 +0000
Date: Thu, 13 Nov 2025 12:51:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 08/12] bng_en: Add support for TPA events
Message-ID: <202511130005.Y0cxF4Ms-lkp@intel.com>
References: <20251111205829.97579-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111205829.97579-9-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Query-PHY-and-report-link-status/20251112-050616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251111205829.97579-9-bhargava.marreddy%40broadcom.com
patch subject: [net-next 08/12] bng_en: Add support for TPA events
config: arc-randconfig-001-20251112 (https://download.01.org/0day-ci/archive/20251113/202511130005.Y0cxF4Ms-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130005.Y0cxF4Ms-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511130005.Y0cxF4Ms-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:477:24: warning: 'bnge_gro_func' defined but not used [-Wunused-function]
    static struct sk_buff *bnge_gro_func(struct bnge_tpa_info *tpa_info,
                           ^~~~~~~~~~~~~


vim +/bnge_gro_func +477 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c

   476	
 > 477	static struct sk_buff *bnge_gro_func(struct bnge_tpa_info *tpa_info,
   478					     int payload_off, int tcp_ts,
   479					     struct sk_buff *skb)
   480	{
   481	#ifdef CONFIG_INET
   482		u16 outer_ip_off, inner_ip_off, inner_mac_off;
   483		u32 hdr_info = tpa_info->hdr_info;
   484		int iphdr_len, nw_off;
   485	
   486		inner_ip_off = BNGE_TPA_INNER_L3_OFF(hdr_info);
   487		inner_mac_off = BNGE_TPA_INNER_L2_OFF(hdr_info);
   488		outer_ip_off = BNGE_TPA_OUTER_L3_OFF(hdr_info);
   489	
   490		nw_off = inner_ip_off - ETH_HLEN;
   491		skb_set_network_header(skb, nw_off);
   492		iphdr_len = (tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_IP_TYPE) ?
   493			     sizeof(struct ipv6hdr) : sizeof(struct iphdr);
   494		skb_set_transport_header(skb, nw_off + iphdr_len);
   495	
   496		if (inner_mac_off) { /* tunnel */
   497			__be16 proto = *((__be16 *)(skb->data + outer_ip_off -
   498						    ETH_HLEN - 2));
   499	
   500			bnge_gro_tunnel(skb, proto);
   501		}
   502	#endif
   503		return skb;
   504	}
   505	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

