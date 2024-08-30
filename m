Return-Path: <netdev+bounces-123748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A09666AF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6099F1C2356F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600A1B5ED1;
	Fri, 30 Aug 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0uGNjvE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61A1B3B15
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034702; cv=none; b=YiFT63xyoRQy1boEcKhgmovTIFzjviQw/PbfYvpoeXaABZKEBVpWGm6WaxBlhEVEcGSvUwm1gNoH6cHnoDeMtueyFcIxM6klnJL2+sqKiEGx4MfaCN4Xnev4jX5jya7lCUzeQV6Y1cmdTtDLGocVavYXkBi8yVC2A+AshnN1wWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034702; c=relaxed/simple;
	bh=ST63oNtWEeahws4ZxuLG9rvw0D9cMNAgPwp86IE+CKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmU6iuZRsE3LBh4pNktaEVCojKEbdhQn5p93t06d+0fK/DnPfAUxlmKokSND8qUWzFngfE/kBrr6elw7s/Nh6/BL/ot4AydH5Ri6DTTOt9/yeeYkUsaa+kaJt4gfjuC5/em9hEOz/Hno+M4FThQImrJWY7rjBxoxf8Kf2uWQTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0uGNjvE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725034700; x=1756570700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ST63oNtWEeahws4ZxuLG9rvw0D9cMNAgPwp86IE+CKc=;
  b=b0uGNjvEpUToWRf713PJUvT6QX+wQHr8UEMxnwKKGFHpdDLTrLHGTrMs
   LsJy1ZCPxUismTJi05eGwyMTo+HNCNS3UpIi0+P8oWRbxgzpydvZYZQLz
   gcEjSYrgB6iu0yytng0pCEsO1t4HdLbjlgyKrBnm2kyd58LOdybGFvQlg
   CNdmG/WOtYLduv3lLZmfROKNfD9eU283NzNlN+7BZiVZx/yuwgFalyjsh
   UINvpSKGqLrTGlOZPFRGx69V0mOz1CJV1XdDTiTHsfdGu8pF7C9po5qd2
   trM7h5vLIBQH87wh+UQ4h2FTE+ylapbXmsj4KV1WnRWsXwwmd9ffla4Xs
   g==;
X-CSE-ConnectionGUID: cKOWMrCSTpO75rzq5Tjvvg==
X-CSE-MsgGUID: V5HRRROPTguioHd3y+TTrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23838210"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23838210"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:18:20 -0700
X-CSE-ConnectionGUID: 0fd0LFhmQR6AJjg59QDGAw==
X-CSE-MsgGUID: 7HgnHx48TEy6IrrwdgYPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64445691"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Aug 2024 09:18:17 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4KF-0001dO-0D;
	Fri, 30 Aug 2024 16:18:15 +0000
Date: Sat, 31 Aug 2024 00:18:10 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <202408310023.xSozGTYj-lkp@intel.com>
References: <20240829204922.1674865-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829204922.1674865-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-txtimestamp-add-SCM_TS_OPT_ID-test/20240830-045630
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240829204922.1674865-1-vadfed%40meta.com
patch subject: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408310023.xSozGTYj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310023.xSozGTYj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310023.xSozGTYj-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/sock.c: In function '__sock_cmsg_send':
>> net/core/sock.c:2862:14: error: 'SCM_TS_OPT_ID' undeclared (first use in this function); did you mean 'IPCORK_TS_OPT_ID'?
    2862 |         case SCM_TS_OPT_ID:
         |              ^~~~~~~~~~~~~
         |              IPCORK_TS_OPT_ID
   net/core/sock.c:2862:14: note: each undeclared identifier is reported only once for each function it appears in


vim +2862 net/core/sock.c

  2828	
  2829	int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
  2830			     struct sockcm_cookie *sockc)
  2831	{
  2832		u32 tsflags;
  2833	
  2834		switch (cmsg->cmsg_type) {
  2835		case SO_MARK:
  2836			if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  2837			    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
  2838				return -EPERM;
  2839			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2840				return -EINVAL;
  2841			sockc->mark = *(u32 *)CMSG_DATA(cmsg);
  2842			break;
  2843		case SO_TIMESTAMPING_OLD:
  2844		case SO_TIMESTAMPING_NEW:
  2845			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2846				return -EINVAL;
  2847	
  2848			tsflags = *(u32 *)CMSG_DATA(cmsg);
  2849			if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
  2850				return -EINVAL;
  2851	
  2852			sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
  2853			sockc->tsflags |= tsflags;
  2854			break;
  2855		case SCM_TXTIME:
  2856			if (!sock_flag(sk, SOCK_TXTIME))
  2857				return -EINVAL;
  2858			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
  2859				return -EINVAL;
  2860			sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
  2861			break;
> 2862		case SCM_TS_OPT_ID:
  2863			/* allow this option for UDP sockets only */
  2864			if (!sk_is_udp(sk))
  2865				return -EINVAL;
  2866			tsflags = READ_ONCE(sk->sk_tsflags);
  2867			if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
  2868				return -EINVAL;
  2869			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2870				return -EINVAL;
  2871			sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
  2872			sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
  2873			break;
  2874		/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
  2875		case SCM_RIGHTS:
  2876		case SCM_CREDENTIALS:
  2877			break;
  2878		default:
  2879			return -EINVAL;
  2880		}
  2881		return 0;
  2882	}
  2883	EXPORT_SYMBOL(__sock_cmsg_send);
  2884	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

