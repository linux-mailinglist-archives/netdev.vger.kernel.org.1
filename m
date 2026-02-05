Return-Path: <netdev+bounces-257097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF/zImBjhGkK2wMAu9opvQ
	(envelope-from <netdev+bounces-257097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:31:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE09F0C92
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A05B30059B7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57576392806;
	Thu,  5 Feb 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl2CUnR6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DC38E5D9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283744; cv=none; b=A8g/yTyyxAGgRnCxFXKFsgL5gPHnlwxKqE+wIordNqViFoQfJIC0bxv+6be0KqEXWB7CbsMdprTHMTEaa1tFxysNYb12WGvozYj8OsOmJsrZ8NTikPH+UhxQ4BjTNJ1L3dqyFjXsUwchNuioI7wVp6FATo/9K8MtepTTch9MqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283744; c=relaxed/simple;
	bh=w6nbP2PwYj07RChntj1mSAJ0DeW4Siy9rhGIob2an+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmL4wPt8IXg+AGcvOIZBfVgYXk+Xof3ZWLviBfLJ6cdVyzKCN0Q8YNj8ACfOA5+bxMPNZppGgojDg58rgQydlb4dw+9WNEY7MuFyvOAouWfmF/xqnNNtTzEb1caIsDgDOlSHUWgsn5xhNjdgv/STLr/qAVcf/S5ia2viwWu6NnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl2CUnR6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770283743; x=1801819743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w6nbP2PwYj07RChntj1mSAJ0DeW4Siy9rhGIob2an+k=;
  b=kl2CUnR69d5l40fNR+yktv65Du52BJew/LlV9T8VmKB39mLuIqWNr5lw
   5P2qos9nx2b72s0gp7oWjedDp0ZnWK1TD30zbhhWlbP+IlAvqTvQdw7zP
   Jqnpyh86dKYUFLnsg1W8ARE9MI+ibE/ZoIDjkwL7MNPcozPS5u3QHQo1h
   NXAyLC0Utd2hqmWNF8xx0NfpGWmUEc5dZy6rnyzSWg2i461FYO5GNYwmA
   aT867poCtqI75TzRKgRWd/ggeL9eDtEMktqXoEzTAW/JnMKnV/SeX1RDN
   bx0kx+r8E6CgaDWbilC5cRz4LhsLx+qSzxii5QXpmxJfvbOageiiDqH1F
   Q==;
X-CSE-ConnectionGUID: whbIzGFlSw+2QdFQjO93Qg==
X-CSE-MsgGUID: aZFc4aMcRTysFu/SQWQ44Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71518191"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71518191"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:29:03 -0800
X-CSE-ConnectionGUID: aSCF9iKZTo2jBEQexOE1aQ==
X-CSE-MsgGUID: wFTXJgwRSCOCiIjNfaV7xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214974740"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2026 01:29:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnvfW-00000000jfQ-0PhL;
	Thu, 05 Feb 2026 09:28:58 +0000
Date: Thu, 5 Feb 2026 17:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nikhil.rao@amd.com,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	sdf@fomichev.me, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <202602051720.YfZO23pZ-lkp@intel.com>
References: <20260205001935.11562-3-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205001935.11562-3-nikhil.rao@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257097-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2EE09F0C92
X-Rspamd-Action: no action

Hi Nikhil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikhil-P-Rao/xsk-Fix-fragment-node-deletion-to-prevent-buffer-leak/20260205-082128
base:   net/main
patch link:    https://lore.kernel.org/r/20260205001935.11562-3-nikhil.rao%40amd.com
patch subject: [PATCH net 2/2] xsk: Fix zero-copy AF_XDP fragment drop
config: xtensa-randconfig-r072-20260205 (https://download.01.org/0day-ci/archive/20260205/202602051720.YfZO23pZ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051720.YfZO23pZ-lkp@intel.com/

New smatch warnings:
net/xdp/xsk.c:191 xsk_rcv_zc() warn: inconsistent indenting

Old smatch warnings:
arch/xtensa/include/asm/thread_info.h:97 current_thread_info() warn: inconsistent indenting

vim +191 net/xdp/xsk.c

   162	
   163	static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
   164	{
   165		struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
   166		u32 frags = xdp_buff_has_frags(xdp);
   167		struct xdp_buff_xsk *pos, *tmp;
   168		struct list_head *xskb_list;
   169		u32 num_desc = 1;
   170		u32 contd = 0;
   171	
   172		if (frags) {
   173			num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
   174			contd = XDP_PKT_CONTD;
   175		}
   176	
   177		if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
   178			xs->rx_queue_full++;
   179			return -ENOBUFS;
   180		}
   181	
   182		__xsk_rcv_zc(xs, xskb, len, contd);
   183		if (likely(!frags))
   184			return 0;
   185	
   186		xskb_list = &xskb->pool->xskb_list;
   187		list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
   188			if (list_is_singular(xskb_list))
   189				contd = 0;
   190			len = pos->xdp.data_end - pos->xdp.data;
 > 191			 __xsk_rcv_zc(xs, pos, len, contd);
   192			list_del_init(&pos->list_node);
   193		}
   194	
   195		return 0;
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

