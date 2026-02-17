Return-Path: <netdev+bounces-259023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DDEJ6thlGlfDQIAu9opvQ
	(envelope-from <netdev+bounces-259023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:40:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F114C08B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B9430214E5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353C3542CF;
	Tue, 17 Feb 2026 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQqBwSlg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAD28D8DB
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331986; cv=none; b=ZQ6lCduJmyhkQtoURTylp0sNMj1U1mgsfWjaLA6BHHG8CG7NMb+uFPCBp3E/4R/OFQSlqwSNm3fIkGQ8jlKiPjPtMuPGNMapyYDdu4Bb/gRlmWs2HQ9tGVNPA0x85OR13lwGujFH0wDIyXrQE0R+dUros0a2HQYQdqgBp/8b3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331986; c=relaxed/simple;
	bh=jkvscVY8jhU91bgbPbEIsETUtHOFLH8AOKAEllmL2rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euPffuT/5eWxcw3CF/wFRDrXryplaRJR93Vydmyk8GIGXPtURm4A/CEFChDx3+UhIH3t4nxlSKh6rrrAQ+c+3RluhIyqivJuikjjAhavv9GHP9XsQL7AzFxfBQqnT4/UWfYq468Licoz2abKrkfnlYDAOAOJDZHmCMLxodN2r0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQqBwSlg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771331985; x=1802867985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jkvscVY8jhU91bgbPbEIsETUtHOFLH8AOKAEllmL2rk=;
  b=PQqBwSlgdtTZDPzOTPhEbHt/35E4doQ/JS7SGnsnYXuXK1dI1kkYxSGW
   NZ3ISeYMP2bG7eoQ22tmu6X0NpaR7/LGzuUiKmv/4Xp4DPyulfspIpZTm
   GeFalHURDQoVJ4gnSAlNgPXugDAtDcuNGqM7U24Kise43kdjHzZDhyDE7
   HOfap5qJdIdfqFxeFAFAAXgWDaMtalUiXIFM9zAkwIjBf4aC5GXR9BbDY
   /su9FVFYSxKuPhzZOy4L+4RVQM0RjBxpU7DpL0wB3eU1fKtHu5befuKWe
   pAvyLYQwticm2CAkOl3f5Z8zbjxN9v5upsubRWseRUmS0husLB1T1xND7
   w==;
X-CSE-ConnectionGUID: tK8qK1AkSUeu+LQIzUVlag==
X-CSE-MsgGUID: UODwKethS8mj/6sy9FfIQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="89810018"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="89810018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 04:39:45 -0800
X-CSE-ConnectionGUID: 6kfB+UeyR7uRw1igXSIHzQ==
X-CSE-MsgGUID: 2+/IDyIFRpyfXaTbOlIbZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="218003122"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2026 04:39:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsKMc-000000010xY-2ggC;
	Tue, 17 Feb 2026 12:39:38 +0000
Date: Tue, 17 Feb 2026 20:39:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nikhil.rao@amd.com,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	sdf@fomichev.me, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kerneljasonxing@gmail.com
Subject: Re: [PATCH net v3 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <202602172046.vf9DtpdF-lkp@intel.com>
References: <20260217012346.22468-3-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217012346.22468-3-nikhil.rao@amd.com>
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
	TAGGED_FROM(0.00)[bounces-259023-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF6F114C08B
X-Rspamd-Action: no action

Hi Nikhil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikhil-P-Rao/xsk-Fix-fragment-node-deletion-to-prevent-buffer-leak/20260217-092448
base:   net/main
patch link:    https://lore.kernel.org/r/20260217012346.22468-3-nikhil.rao%40amd.com
patch subject: [PATCH net v3 2/2] xsk: Fix zero-copy AF_XDP fragment drop
config: powerpc64-randconfig-002-20260217 (https://download.01.org/0day-ci/archive/20260217/202602172046.vf9DtpdF-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602172046.vf9DtpdF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602172046.vf9DtpdF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/xdp/xsk.c:183:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     183 |         if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/xdp/xsk.c:201:9: note: uninitialized use occurs here
     201 |         return err;
         |                ^~~
   net/xdp/xsk.c:183:2: note: remove the 'if' if its condition is always false
     183 |         if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     184 |                 xs->rx_queue_full++;
         |                 ~~~~~~~~~~~~~~~~~~~~
     185 |                 goto err;
         |                 ~~~~~~~~~
     186 |         }
         |         ~
   net/xdp/xsk.c:171:9: note: initialize the variable 'err' to silence this warning
     171 |         int err;
         |                ^
         |                 = 0
   1 warning generated.


vim +183 net/xdp/xsk.c

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
   173		if (frags) {
   174			num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
   175			contd = XDP_PKT_CONTD;
   176		} else {
   177			err = __xsk_rcv_zc(xs, xskb, len, contd);
   178			if (err)
   179				goto err;
   180			return 0;
   181		}
   182	
 > 183		if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
   184			xs->rx_queue_full++;
   185			goto err;
   186		}
   187	
   188		__xsk_rcv_zc(xs, xskb, len, contd);
   189		xskb_list = &xskb->pool->xskb_list;
   190		list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
   191			if (list_is_singular(xskb_list))
   192				contd = 0;
   193			len = pos->xdp.data_end - pos->xdp.data;
   194			__xsk_rcv_zc(xs, pos, len, contd);
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

