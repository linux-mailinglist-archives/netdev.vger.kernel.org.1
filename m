Return-Path: <netdev+bounces-266364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCVyMDuXsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:12:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C7258C31
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E71303A918
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57703E023A;
	Tue, 10 Mar 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpPjMQCp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767383CFF4F;
	Tue, 10 Mar 2026 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180636; cv=none; b=lz0R5VAXAhH48Lwtv0Ecmg3+TQ3o4pbPqIFCDzhlOTXyFLa1LEzsZkiUNXxzQY8AZ9vz3hgad9PNNYZA3bL9REaWYffIE8MWw0UyISvcy9nNPhwKNevHXLqwmxOUV4edEYGOSlKbkW3kE71lMmc/RDjOTrsNwItiUheWnCkjL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180636; c=relaxed/simple;
	bh=LGf7Kaidv2GQPcQDZz9qxc5JFxu4+rtVauMwHWogG2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP/7eStFqVVMNTn6p0b3PRD7GMp7Z7R3Ncp7WQDMMNKkFQbmk+DYsKV5wsv3Zuo9zq2qZvsPujIsae1+40w1IRbE7dUGqikeA/qIGTP2I/mvecTDVKDNW+/wsPuKmlHiIj3IVdla6svQ3q2BLbT3HeyyCsHX24/7yGiZZ+E2Q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpPjMQCp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180636; x=1804716636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGf7Kaidv2GQPcQDZz9qxc5JFxu4+rtVauMwHWogG2A=;
  b=jpPjMQCpoC1/XvnlPeKWQolJKUzQXsWKdlw1RJizf5cuVZ1K/I43vj5V
   uz+qmAf7uczhbsmU6GG9P/bmUDEclbLSFoCu6pe7aZzwK/HPQoOTlefEU
   mYolnq+OAQub3p8UYLXOlpJIhfmBvx45D5GR7YkgUbeHpuaelMyqDs9w0
   ks/Niup6SAtGuT9Ng7khlMLfInH/QP5PhY9Jw8ZGHKiT02n7Qin2ZZdkG
   86K8F+yE63jKbqlK+YpbCWPgJq4NdlgaSY8E4GKnC1OvTU0cf2fihjrkR
   0HRgoVBIy5u/pqr/xbjzYzaA5jG5aNOEl6/VqnCFuZ4PdqTvqT8B0ttye
   A==;
X-CSE-ConnectionGUID: IPGJlGEtTsexOzBzG5eVLg==
X-CSE-MsgGUID: vFov3ttuTyiwIef8gHIybw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85717241"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85717241"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:10:35 -0700
X-CSE-ConnectionGUID: 8YtaUo58SPa+QM0pyMdfBw==
X-CSE-MsgGUID: 7DKPCwGlR32znkWSeRkF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224948111"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2026 15:10:32 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w05Ha-000000000Ma-0yAa;
	Tue, 10 Mar 2026 22:10:30 +0000
Date: Wed, 11 Mar 2026 06:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, magnus.karlsson@intel.com,
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <202603110534.EYw1bSxj-lkp@intel.com>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
X-Rspamd-Queue-Id: 2F9C7258C31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266364-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Maciej,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-use-__xsk_rcv_zc_safe-for-ZC-multi-buffer-Rx-processing/20260310-222557
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260310133024.422464-1-maciej.fijalkowski%40intel.com
patch subject: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260311/202603110534.EYw1bSxj-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 122f0b13a237b5024747b4ee99002590cc9a220a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110534.EYw1bSxj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110534.EYw1bSxj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/xdp/xsk.c:188:2: error: call to undeclared function '__xsk_rcv_zc_safe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     188 |         __xsk_rcv_zc_safe(xs, xskb, len, contd);
         |         ^
   net/xdp/xsk.c:188:2: note: did you mean '__xsk_rcv_zc'?
   net/xdp/xsk.c:146:12: note: '__xsk_rcv_zc' declared here
     146 | static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
         |            ^
   1 error generated.


vim +/__xsk_rcv_zc_safe +188 net/xdp/xsk.c

   162	
   163	static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
   164	{
   165		struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
   166		u32 frags = xdp_buff_has_frags(xdp);
   167		struct xdp_buff_xsk *pos, *tmp;
   168		struct list_head *xskb_list;
   169		u32 contd = 0;
   170		u32 num_desc;
   171		int err;
   172	
   173		if (likely(!frags)) {
   174			err = __xsk_rcv_zc(xs, xskb, len, contd);
   175			if (err)
   176				goto err;
   177			return 0;
   178		}
   179	
   180		contd = XDP_PKT_CONTD;
   181		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
   182		if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
   183			xs->rx_queue_full++;
   184			err = -ENOBUFS;
   185			goto err;
   186		}
   187	
 > 188		__xsk_rcv_zc_safe(xs, xskb, len, contd);
   189		xskb_list = &xskb->pool->xskb_list;
   190		list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
   191			if (list_is_singular(xskb_list))
   192				contd = 0;
   193			len = pos->xdp.data_end - pos->xdp.data;
   194			__xsk_rcv_zc_safe(xs, pos, len, contd);
   195			list_del_init(&pos->list_node);
   196		}
   197	
   198		return 0;
   199	err:
   200		xsk_buff_free(xdp);
   201		return err;
   202	}
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

