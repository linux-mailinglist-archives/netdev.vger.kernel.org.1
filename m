Return-Path: <netdev+bounces-273790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGMGFEFczGlmSgYAu9opvQ
	(envelope-from <netdev+bounces-273790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA6372E5C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 520713013DF4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFF03B4E97;
	Tue, 31 Mar 2026 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3+WQA9j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27093B0AD6
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000639; cv=none; b=S6F4QU38NPXKQigdfh2aAvzUZmfLLKiXLLenKvERyB7lNQPflGYeASfPc/CNVbTcder0BeA6efodOjzhFXWXuLx/ipzXqGCzPT9M0Jlf4QIse03uJf1wH1AdTyL5aKuf7DPJTPdNcBNnnHVoTLF3NQ9oC6R+7nsTjDK7sTm92DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000639; c=relaxed/simple;
	bh=wj0/xKBgALzavOxAhIq01G4Rvn8u+bDBzb3YZdAlTlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvCO4EhIeX+6HrTduq+PKEeVUOIAysHzjGmHL3rEi1jlh/pKrWVfpn98Phtx/VH7pw0tyBU3Jn18nlwDEK1UTGMbsUAwh6d+58txJNloozF7/lp87ly3xcwktWhGmtciuBTXJxLdG4t9LwHVqNJDUQcVm9mVa8O1LJPuToOomnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3+WQA9j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775000637; x=1806536637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wj0/xKBgALzavOxAhIq01G4Rvn8u+bDBzb3YZdAlTlc=;
  b=M3+WQA9jAmMfl/nq1t9o6Ppuw9DCpmOlr7x/vI6s0Dfi3h3gQVnQbMzJ
   94idZ6J6neF26e3BTuVBWxqHO/uSvApMNeMXbbr/W16OiS6WGTP7diMks
   nlplcEBnZ1Em5jNBsf7/rCClISYbzo8oNDxsjAD+Mh2x3QHvs2vgl7Xoa
   cwNW7vZCe9RMfmfIoG9qQOlUSScUYvFrM43WAv6YG+u7jVbiLcOfPhhGe
   ww1DbGc8OnwXptC1t/pIOCfZYeaIiggwIxCPJ5iL4GM24pMOk2nz1rHus
   dUpVbahZbrslxaWk7kYhd42mjc0yPBWSKN8qOYgB+8rva9oZijRwnohjm
   g==;
X-CSE-ConnectionGUID: UEjmN85+Q9GoLbsqMru0CA==
X-CSE-MsgGUID: DAykrzZWS6W/tLGl1qeQIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86332442"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86332442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:43:57 -0700
X-CSE-ConnectionGUID: yz9R+XOgSIyjpugxB6yAEA==
X-CSE-MsgGUID: /G3vij3ISleQfy8tNz8KFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="257008198"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Mar 2026 16:43:54 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7ikQ-000000004Qb-2pib;
	Tue, 31 Mar 2026 23:43:50 +0000
Date: Wed, 1 Apr 2026 07:43:02 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v9 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
Message-ID: <202604010708.Yck6IfPj-lkp@intel.com>
References: <20260330223143.2394706-3-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330223143.2394706-3-weibunny.kernel@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273790-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: EDFA6372E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Wang/psp-add-admin-non-admin-version-of-psp_device_get_locked/20260331-065558
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330223143.2394706-3-weibunny.kernel%40gmail.com
patch subject: [PATCH v9 net-next 2/5] psp: add new netlink cmd for dev-assoc and dev-disassoc
config: sh-randconfig-r113-20260401 (https://download.01.org/0day-ci/archive/20260401/202604010708.Yck6IfPj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010708.Yck6IfPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010708.Yck6IfPj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/psp/psp_nl.c:494:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct psp_dev [noderef] __rcu *_n_ @@     got struct psp_dev *psd @@
   net/psp/psp_nl.c:494:13: sparse:     expected struct psp_dev [noderef] __rcu *_n_
   net/psp/psp_nl.c:494:13: sparse:     got struct psp_dev *psd

vim +494 net/psp/psp_nl.c

   449	
   450	int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
   451	{
   452		struct psp_dev *psd = info->user_ptr[0];
   453		struct psp_assoc_dev *psp_assoc_dev;
   454		struct net_device *assoc_dev;
   455		u32 assoc_ifindex;
   456		struct sk_buff *rsp;
   457		struct net *net;
   458		int nsid;
   459	
   460		if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
   461			return -EINVAL;
   462	
   463		if (info->attrs[PSP_A_DEV_NSID]) {
   464			nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
   465	
   466			net = get_net_ns_by_id(genl_info_net(info), nsid);
   467			if (!net) {
   468				NL_SET_BAD_ATTR(info->extack,
   469						info->attrs[PSP_A_DEV_NSID]);
   470				return -EINVAL;
   471			}
   472		} else {
   473			net = get_net(genl_info_net(info));
   474		}
   475	
   476		psp_assoc_dev = kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
   477		if (!psp_assoc_dev) {
   478			put_net(net);
   479			return -ENOMEM;
   480		}
   481	
   482		assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
   483		assoc_dev = netdev_get_by_index(net, assoc_ifindex,
   484						&psp_assoc_dev->dev_tracker,
   485						GFP_KERNEL);
   486		if (!assoc_dev) {
   487			put_net(net);
   488			kfree(psp_assoc_dev);
   489			NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
   490			return -ENODEV;
   491		}
   492	
   493		/* Check if device is already associated with a PSP device */
 > 494		if (cmpxchg(&assoc_dev->psp_dev, NULL, psd)) {
   495			NL_SET_ERR_MSG(info->extack,
   496				       "Device already associated with a PSP device");
   497			netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
   498			put_net(net);
   499			kfree(psp_assoc_dev);
   500			return -EBUSY;
   501		}
   502	
   503		psp_assoc_dev->assoc_dev = assoc_dev;
   504		rsp = psp_nl_reply_new(info);
   505		if (!rsp) {
   506			rcu_assign_pointer(assoc_dev->psp_dev, NULL);
   507			netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
   508			put_net(net);
   509			kfree(psp_assoc_dev);
   510			return -ENOMEM;
   511		}
   512	
   513		list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
   514	
   515		put_net(net);
   516	
   517		psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
   518	
   519		return psp_nl_reply_send(rsp, info);
   520	}
   521	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

