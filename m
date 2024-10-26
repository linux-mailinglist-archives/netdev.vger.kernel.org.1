Return-Path: <netdev+bounces-139306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66239B1652
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DCC1C20FDA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068F1C5793;
	Sat, 26 Oct 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpy20pHh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55B217F27;
	Sat, 26 Oct 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729931939; cv=none; b=ZBy+RwzezlrOKdjCgKmeJYlzUDyW4UfvzbTjx/gr2dV3c/m/KzT1agd4U0CwjhvLAKQ/aSuC93ZYGrxZDQxKL7vXPCUBqbPCT6yPj3XyIG0a5lDU7u9A7hxer4TTgbX2XYLeIOrKO6PZESshex/k4YFyE77cAGiapxAPGho9KDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729931939; c=relaxed/simple;
	bh=mR1Pe8yt+v+w7zNW/aUeOjuoEFziwbo0p077UFbOUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBXkUkHvFJaZMqSSJEaBkv4G2+dcGjzK9BBHAx8MGGKehlTOH6XhkIOsaPl/VTD/Lb5SI15ssVE3CoHGLOz6u5nLMtyyp1zmbA7u0xt7BUhwiO6DvAFaHL3Fa0O90XYcoSEKpOapiCt++BnRFcWvMoydSrhkLf22TntefqyV8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpy20pHh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729931937; x=1761467937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mR1Pe8yt+v+w7zNW/aUeOjuoEFziwbo0p077UFbOUjk=;
  b=lpy20pHhUonioPhKhsDu8bzLJkU6CkoxJgNsCldZxzC84pJJEBJobyxl
   YZUYDVHbDMoNJmvsXx+Ei/rcH92xBms8VDmY0UGDBHqj8z4xQ0BMPbIzx
   xjed6e315g5vFPT/EVmWB+SF2sLao3++QBZD76g02dFKBBS9MgKtsL9ot
   runP9npfAaBUgI2uR9goRdFDfFT/Ke34U2G36F1UmdE9mvwJ7iU4dNWn2
   v3tC4Wn/m0f/vlV4GkWrjgJeHtMigF3/2r1zVb++s51pADZMn0Pbh0+vo
   8nvOFG27741qgR7yrH8xWyaScSoswbZvffyqafwV1IE0BmumfHCRPdZbo
   A==;
X-CSE-ConnectionGUID: DMVbx5ssR1SM/qwJDBBLPg==
X-CSE-MsgGUID: ntnqysrUTiiwqYLlvwIpqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40180029"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="40180029"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 01:38:57 -0700
X-CSE-ConnectionGUID: f6tmldosRFSxtWJoCpg8Lw==
X-CSE-MsgGUID: p4QyqgnwQwy8/SiNtIG4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="81069942"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Oct 2024 01:38:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4cJv-000ZRM-2R;
	Sat, 26 Oct 2024 08:38:51 +0000
Date: Sat, 26 Oct 2024 16:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: Re: [PATCH net-next 2/3] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
Message-ID: <202410261651.MiKpheOT-lkp@intel.com>
References: <20241025133727.27742-3-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025133727.27742-3-justin.iurman@uliege.be>

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Iurman/net-ipv6-ioam6_iptunnel-mitigate-2-realloc-issue/20241025-214849
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241025133727.27742-3-justin.iurman%40uliege.be
patch subject: [PATCH net-next 2/3] net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
config: arc-randconfig-001-20241026 (https://download.01.org/0day-ci/archive/20241026/202410261651.MiKpheOT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410261651.MiKpheOT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410261651.MiKpheOT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/ipv6/seg6_iptunnel.c: In function 'seg6_do_srh_encap':
>> net/ipv6/seg6_iptunnel.c:130:16: error: implicit declaration of function '__seg6_do_srh_encap'; did you mean 'seg6_do_srh_encap'? [-Werror=implicit-function-declaration]
     130 |         return __seg6_do_srh_encap(skb, osrh, proto, NULL);
         |                ^~~~~~~~~~~~~~~~~~~
         |                seg6_do_srh_encap
   net/ipv6/seg6_iptunnel.c: At top level:
>> net/ipv6/seg6_iptunnel.c:134:5: warning: no previous prototype for '__seg6_do_srh_encap' [-Wmissing-prototypes]
     134 | int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         |     ^~~~~~~~~~~~~~~~~~~
   net/ipv6/seg6_iptunnel.c: In function 'seg6_do_srh_inline':
>> net/ipv6/seg6_iptunnel.c:330:16: error: implicit declaration of function '__seg6_do_srh_inline'; did you mean 'seg6_do_srh_inline'? [-Werror=implicit-function-declaration]
     330 |         return __seg6_do_srh_inline(skb, osrh, NULL);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                seg6_do_srh_inline
   net/ipv6/seg6_iptunnel.c: At top level:
>> net/ipv6/seg6_iptunnel.c:334:5: warning: no previous prototype for '__seg6_do_srh_inline' [-Wmissing-prototypes]
     334 | int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         |     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +130 net/ipv6/seg6_iptunnel.c

   126	
   127	/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
   128	int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
   129	{
 > 130		return __seg6_do_srh_encap(skb, osrh, proto, NULL);
   131	}
   132	EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
   133	
 > 134	int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
   135				int proto, struct dst_entry *dst)
   136	{
   137		struct net *net = dev_net(skb_dst(skb)->dev);
   138		struct ipv6hdr *hdr, *inner_hdr;
   139		struct ipv6_sr_hdr *isrh;
   140		int hdrlen, tot_len, err;
   141		__be32 flowlabel;
   142	
   143		hdrlen = (osrh->hdrlen + 1) << 3;
   144		tot_len = hdrlen + sizeof(*hdr);
   145	
   146		err = skb_cow_head(skb, tot_len + (!dst ? skb->mac_len
   147							: LL_RESERVED_SPACE(dst->dev)));
   148		if (unlikely(err))
   149			return err;
   150	
   151		inner_hdr = ipv6_hdr(skb);
   152		flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
   153	
   154		skb_push(skb, tot_len);
   155		skb_reset_network_header(skb);
   156		skb_mac_header_rebuild(skb);
   157		hdr = ipv6_hdr(skb);
   158	
   159		/* inherit tc, flowlabel and hlim
   160		 * hlim will be decremented in ip6_forward() afterwards and
   161		 * decapsulation will overwrite inner hlim with outer hlim
   162		 */
   163	
   164		if (skb->protocol == htons(ETH_P_IPV6)) {
   165			ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
   166				     flowlabel);
   167			hdr->hop_limit = inner_hdr->hop_limit;
   168		} else {
   169			ip6_flow_hdr(hdr, 0, flowlabel);
   170			hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
   171	
   172			memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
   173	
   174			/* the control block has been erased, so we have to set the
   175			 * iif once again.
   176			 * We read the receiving interface index directly from the
   177			 * skb->skb_iif as it is done in the IPv4 receiving path (i.e.:
   178			 * ip_rcv_core(...)).
   179			 */
   180			IP6CB(skb)->iif = skb->skb_iif;
   181		}
   182	
   183		hdr->nexthdr = NEXTHDR_ROUTING;
   184	
   185		isrh = (void *)hdr + sizeof(*hdr);
   186		memcpy(isrh, osrh, hdrlen);
   187	
   188		isrh->nexthdr = proto;
   189	
   190		hdr->daddr = isrh->segments[isrh->first_segment];
   191		set_tun_src(net, skb_dst(skb)->dev, &hdr->daddr, &hdr->saddr);
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

