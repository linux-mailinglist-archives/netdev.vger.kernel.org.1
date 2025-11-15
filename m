Return-Path: <netdev+bounces-238864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36735C607A9
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D53B224211
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE42F60CA;
	Sat, 15 Nov 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkTmjLcI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488829D266;
	Sat, 15 Nov 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763218820; cv=none; b=Cw8zgdbtygwjzvS2KSpFKG+wYcQ+UwavTYKnIZ6YiwIQ3uErZqrtRweLY3BnSp/FX153AX5m/coM08A/BCH2dDqJyw3vJdphW0YmbdsfGGf9V5Nap/T2nw1fmjs2K49unFmzIo0i9gmsP3kCrKuFyvrVXeMYK/Tuavt+rguns8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763218820; c=relaxed/simple;
	bh=ndcPSZW3JOVHmw7oovdYbGWmn8uW+fs4og7Ao3WKs/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVW5ek2EH9rtTwfcEsP4UVqb7W+hlIntHOmSZhV8qV5IOfbb/idkXjy/1Pbi3k+wCwXRVUh8jLPfcs1CQnA6dvA/Y2lU8QbZtLb1X39Sa8oEEwzauMwI2I9zHTyj5bcH7zR1kMuFiGNYKaBOVkLr+/7fY8IZzEYrN6U1zYl+ceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkTmjLcI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763218819; x=1794754819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndcPSZW3JOVHmw7oovdYbGWmn8uW+fs4og7Ao3WKs/4=;
  b=kkTmjLcIoz68Yp6e/FeXZUGYUhQWtU1f3ope+hyioONuTnssxXNTOCeW
   90nWA1sJB7t5XHVVYAvPFcmXgtaXZ2NX7WnrEhgRjzkuXI1sv5To8K2a6
   7xvC4lgC/Yz/PFEDcVrtbcRH92EWYpBaNR1RdHIAnPS2dowUyvxQeEgpP
   7x+I78qMewinY9d8hTaPeFp9OpmPy/hV+eik03bD1jROP8qxhGtUTm3Nk
   9LnlV5RwJUolYcuvY2FGcq5VnD/76Xj9Q4q36hJDss5ROf4nGioTd337j
   3Zq06Jv4GRiKpJFm3U+UhB6n5O2BrpOZwfC90anWKVL54k9UYxvu3mYly
   Q==;
X-CSE-ConnectionGUID: DBOXzB+NS8qTrbm/tS3A3g==
X-CSE-MsgGUID: IipgK5b6RxWrYcHM9ptTQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="82916820"
X-IronPort-AV: E=Sophos;i="6.19,307,1754982000"; 
   d="scan'208";a="82916820"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 07:00:19 -0800
X-CSE-ConnectionGUID: bV69B+1GRr+QOuViJSOWHQ==
X-CSE-MsgGUID: 7ORA28maSR2i67CxfehwsA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Nov 2025 07:00:14 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKHl6-00082o-1s;
	Sat, 15 Nov 2025 15:00:12 +0000
Date: Sat, 15 Nov 2025 22:59:16 +0800
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
Subject: Re: [v2, net-next 08/12] bng_en: Add support for TPA events
Message-ID: <202511152221.4M9h7dkH-lkp@intel.com>
References: <20251114195312.22863-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114195312.22863-9-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Query-PHY-and-report-link-status/20251115-040224
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251114195312.22863-9-bhargava.marreddy%40broadcom.com
patch subject: [v2, net-next 08/12] bng_en: Add support for TPA events
config: parisc-randconfig-001-20251115 (https://download.01.org/0day-ci/archive/20251115/202511152221.4M9h7dkH-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511152221.4M9h7dkH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511152221.4M9h7dkH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnge/bnge_txrx.c: In function 'bnge_tpa_end':
>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:548:7: warning: variable 'gro' set but not used [-Wunused-but-set-variable]
     bool gro;
          ^~~


vim +/gro +548 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c

   530	
   531	static inline struct sk_buff *bnge_tpa_end(struct bnge_net *bn,
   532						   struct bnge_cp_ring_info *cpr,
   533						   u32 *raw_cons,
   534						   struct rx_tpa_end_cmp *tpa_end,
   535						   struct rx_tpa_end_cmp_ext *tpa_end1,
   536						   u8 *event)
   537	{
   538		struct bnge_napi *bnapi = cpr->bnapi;
   539		struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
   540		struct net_device *dev = bn->netdev;
   541		struct bnge_tpa_info *tpa_info;
   542		u8 *data_ptr, agg_bufs;
   543		struct sk_buff *skb;
   544		u16 idx = 0, agg_id;
   545		dma_addr_t mapping;
   546		unsigned int len;
   547		void *data;
 > 548		bool gro;
   549	
   550		agg_id = TPA_END_AGG_ID(tpa_end);
   551		agg_id = bnge_lookup_agg_idx(rxr, agg_id);
   552		agg_bufs = TPA_END_AGG_BUFS(tpa_end1);
   553		tpa_info = &rxr->rx_tpa[agg_id];
   554		if (unlikely(agg_bufs != tpa_info->agg_count)) {
   555			netdev_warn(bn->netdev, "TPA end agg_buf %d != expected agg_bufs %d\n",
   556				    agg_bufs, tpa_info->agg_count);
   557			agg_bufs = tpa_info->agg_count;
   558		}
   559		tpa_info->agg_count = 0;
   560		*event |= BNGE_AGG_EVENT;
   561		bnge_free_agg_idx(rxr, agg_id);
   562		idx = agg_id;
   563		gro = !!(bn->priv_flags & BNGE_NET_EN_GRO);
   564		data = tpa_info->data;
   565		data_ptr = tpa_info->data_ptr;
   566		prefetch(data_ptr);
   567		len = tpa_info->len;
   568		mapping = tpa_info->mapping;
   569	
   570		if (unlikely(agg_bufs > MAX_SKB_FRAGS || TPA_END_ERRORS(tpa_end1))) {
   571			bnge_abort_tpa(cpr, idx, agg_bufs);
   572			if (agg_bufs > MAX_SKB_FRAGS)
   573				netdev_warn(bn->netdev, "TPA frags %d exceeded MAX_SKB_FRAGS %d\n",
   574					    agg_bufs, (int)MAX_SKB_FRAGS);
   575			return NULL;
   576		}
   577	
   578		if (len <= bn->rx_copybreak) {
   579			skb = bnge_copy_skb(bnapi, data_ptr, len, mapping);
   580			if (!skb) {
   581				bnge_abort_tpa(cpr, idx, agg_bufs);
   582				return NULL;
   583			}
   584		} else {
   585			u8 *new_data;
   586			dma_addr_t new_mapping;
   587	
   588			new_data = __bnge_alloc_rx_frag(bn, &new_mapping, rxr,
   589							GFP_ATOMIC);
   590			if (!new_data) {
   591				bnge_abort_tpa(cpr, idx, agg_bufs);
   592				return NULL;
   593			}
   594	
   595			tpa_info->data = new_data;
   596			tpa_info->data_ptr = new_data + bn->rx_offset;
   597			tpa_info->mapping = new_mapping;
   598	
   599			skb = napi_build_skb(data, bn->rx_buf_size);
   600			dma_sync_single_for_cpu(bn->bd->dev, mapping,
   601						bn->rx_buf_use_size, bn->rx_dir);
   602	
   603			if (!skb) {
   604				page_pool_free_va(rxr->head_pool, data, true);
   605				bnge_abort_tpa(cpr, idx, agg_bufs);
   606				return NULL;
   607			}
   608			skb_mark_for_recycle(skb);
   609			skb_reserve(skb, bn->rx_offset);
   610			skb_put(skb, len);
   611		}
   612	
   613		if (agg_bufs) {
   614			skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, idx, agg_bufs,
   615						      true);
   616			/* Page reuse already handled by bnge_rx_agg_netmems_skb(). */
   617			if (!skb)
   618				return NULL;
   619		}
   620	
   621		skb->protocol = eth_type_trans(skb, dev);
   622	
   623		if (tpa_info->hash_type != PKT_HASH_TYPE_NONE)
   624			skb_set_hash(skb, tpa_info->rss_hash, tpa_info->hash_type);
   625	
   626		if (tpa_info->vlan_valid &&
   627		    (dev->features & BNGE_HW_FEATURE_VLAN_ALL_RX)) {
   628			__be16 vlan_proto = htons(tpa_info->metadata >>
   629						  RX_CMP_FLAGS2_METADATA_TPID_SFT);
   630			u16 vtag = tpa_info->metadata & RX_CMP_FLAGS2_METADATA_TCI_MASK;
   631	
   632			if (eth_type_vlan(vlan_proto)) {
   633				__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
   634			} else {
   635				dev_kfree_skb(skb);
   636				return NULL;
   637			}
   638		}
   639	
   640		skb_checksum_none_assert(skb);
   641		if (likely(tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_L4_CS_CALC)) {
   642			skb->ip_summed = CHECKSUM_UNNECESSARY;
   643			skb->csum_level =
   644				(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
   645		}
   646	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

