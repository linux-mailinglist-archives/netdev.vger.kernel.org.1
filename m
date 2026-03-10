Return-Path: <netdev+bounces-266291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMoXDadhsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:23:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5442565A9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF29630066BA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC272D131D;
	Tue, 10 Mar 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYo1q8N8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A792C3271;
	Tue, 10 Mar 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167010; cv=none; b=H56CUvJXOv87c5XXO3iVHsXpW3Yfl4JOSptk5mGtan3xlnqUwynOXxCFJJ8yzGNwJZgZdA3fWP6aOJcZ94ZqtJrrswEgyjc6nHzUcaYZWh1DxhupUyrAVTKQbEJIIaIN1eBbg0l1kX0tcUUFUcie4Hu0bOsnFl2qR0bdWCJCJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167010; c=relaxed/simple;
	bh=E1f0TxwOn//X5WWXgx7BcvifZ5WmGbh5lyUwp5ZXFK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFfraH2xfNl0uGq88mAmDMY2e2i2YzX9986xFZ1Rnezi0nmsoPvTmj32Q+xJei72UwbEL/4BNmUZYTqHPnmhI7Y92r34XM+6Y37dSSzYknsMMt76eWZOm4N79/XbUywO1YYiWom44Hq8w9QGdzA6z4Pd8CYLdPMhi73Tn7qrttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYo1q8N8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773167010; x=1804703010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1f0TxwOn//X5WWXgx7BcvifZ5WmGbh5lyUwp5ZXFK0=;
  b=VYo1q8N85dDOKgEdIH93E6YQD6u3dBr6t5Dx09V8i6pLy8i5HbJnXqDL
   DOUUBSv3D/2FtDYht+vetBH81GNDr3+7Fs3Y1MZiLFb15sis/9CMhSS8E
   AukC9oO2Q76/onmWlGrI0Qo4RpzxwyOflWVKvnxtK0v46YYtyKaWF1UMt
   kC1s/Ni9a95gwTDRtkO8uPK3kTT42VNP+ukNlxVbn1dcIBznCIZo/cV2e
   FS1lJw9ulQE6E0p1a+V4CuJ6PSSZp0Cuo+osOawon+NdvT0IbrDZJnxcb
   opBntzx8lv/nLjokSqHlyzrkDiZEigDBKQ5Jet5TNzQqXcEmCvl0Rnvgq
   A==;
X-CSE-ConnectionGUID: 6KPnBCuWSseQUiX9aMuvQQ==
X-CSE-MsgGUID: bC7+lhXeTEmIXqT/ZIArxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74104143"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74104143"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:23:30 -0700
X-CSE-ConnectionGUID: OzN23mFiQIqKUHI3v51zFg==
X-CSE-MsgGUID: VVJRAk/nQqCBT88cDReU8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="243211739"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Mar 2026 11:23:27 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w01jm-0000000006Y-0VcS;
	Tue, 10 Mar 2026 18:23:22 +0000
Date: Wed, 11 Mar 2026 02:22:46 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <202603110244.wZ0G0ef2-lkp@intel.com>
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
X-Rspamd-Queue-Id: CB5442565A9
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
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266291-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Maciej,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-use-__xsk_rcv_zc_safe-for-ZC-multi-buffer-Rx-processing/20260310-222557
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260310133024.422464-1-maciej.fijalkowski%40intel.com
patch subject: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260311/202603110244.wZ0G0ef2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110244.wZ0G0ef2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110244.wZ0G0ef2-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/xdp/xsk.c: In function 'xsk_rcv_zc':
>> net/xdp/xsk.c:188:9: error: implicit declaration of function '__xsk_rcv_zc_safe'; did you mean '__xsk_rcv_zc'? [-Wimplicit-function-declaration]
     188 |         __xsk_rcv_zc_safe(xs, xskb, len, contd);
         |         ^~~~~~~~~~~~~~~~~
         |         __xsk_rcv_zc


vim +188 net/xdp/xsk.c

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

