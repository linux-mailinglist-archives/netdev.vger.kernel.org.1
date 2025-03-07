Return-Path: <netdev+bounces-172874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A31A565E2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3386168B05
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5120C00B;
	Fri,  7 Mar 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xf0NPPDi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2A20D4FE
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344878; cv=none; b=IkwdpxWjYdy2XlfNl72Pg/TCp/iV+UAij8Pl/i5bYCHOxbrMeVO0D5FVSJWGfE9/LzpSfINtWHYeMKIoeiXsQthxd3bOHaIIpczF1Obxq92idJ6QkH2rwowKIrMzAq5THbj9OzFW9SfU9S/6DgogHTgYvE9IOpCBMT9P7WMeEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344878; c=relaxed/simple;
	bh=yRfIVS+UqKnrEjZ0DSlu48JRvEdXsauMc01zJ6F2h7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blypkQUuiM1F201CMWNLQ0GtbJAwsj1JvmZzH5zCg6FLS1vkA6IXCOGGaYwj2IDqlxT0i4d9/X+5BRf1tmUc+zW2Pk7IF+iauFqup78j2ekY3leDQL5XrKsc9y7++2kq2ySda1zsEeYm0L6hSibj9aCEgNDoaxmi4v3Ua2QllyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xf0NPPDi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741344877; x=1772880877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRfIVS+UqKnrEjZ0DSlu48JRvEdXsauMc01zJ6F2h7U=;
  b=Xf0NPPDisGC3LSdwkP9l5mvuAqWfxdMDpNjGf7s/d7wCgA9Wf4TpSScU
   q/CoWagZocdz/n/bG6ADoRi2HA1OaOXNWBVzj9IHkaz4c7IheGbo0DBP2
   kORydBhP/5uk5fxRdSFcQygx+9kp1kiJrWSaSlPU3jyOgRsjAZXpMbh4o
   kmhwpFuxt9CwLVAo8Ek1aifFgD52Bam7DZePo1NCttTwjbIYELUf3gXrL
   nbprpeCePIRgWxloAZnOmRQ0vvSpvA/3CHmAG6w3O5SwJM4HAulgd0u7F
   u3GGgFe1kidOtlcAx2SJZsEEKh//6o0eoDHoBhWs7CHRfF6bUTP18xFzf
   Q==;
X-CSE-ConnectionGUID: yRgFFM/oTKiqosGJmRN0ug==
X-CSE-MsgGUID: Fz2NqNuzQ1WJg9bDiGMhDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64831077"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64831077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:54:37 -0800
X-CSE-ConnectionGUID: zhpYvAzyRfGrvcrHk581oA==
X-CSE-MsgGUID: OV6kapyRRIyAKi3FvKx8Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119120578"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2025 02:54:34 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqVLc-0000L3-0J;
	Fri, 07 Mar 2025 10:54:32 +0000
Date: Fri, 7 Mar 2025 18:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Message-ID: <202503071846.PFKkO7SH-lkp@intel.com>
References: <740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/udp_tunnel-create-a-fast-path-GRO-lookup/20250306-235952
base:   net-next/main
patch link:    https://lore.kernel.org/r/740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni%40redhat.com
patch subject: [PATCH net-next 2/2] udp_tunnel: use static call for GRO hooks when possible
config: arm-wpcm450_defconfig (https://download.01.org/0day-ci/archive/20250307/202503071846.PFKkO7SH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071846.PFKkO7SH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071846.PFKkO7SH-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/udp_offload.c: In function 'udp_tunnel_gro_rcv':
>> net/ipv4/udp_offload.c:172:16: error: returning 'struct sk_buff *' from a function with incompatible return type 'struct skbuff *' [-Wincompatible-pointer-types]
     172 |         return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv4/udp_offload.c: In function 'udp_gro_receive':
>> net/ipv4/udp_offload.c:782:12: error: assignment to 'struct sk_buff *' from incompatible pointer type 'struct skbuff *' [-Wincompatible-pointer-types]
     782 |         pp = udp_tunnel_gro_rcv(sk, head, skb);
         |            ^
   In file included from include/linux/seqlock.h:19,
                    from include/linux/dcache.h:11,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from net/ipv4/udp_offload.c:9:
   net/ipv4/udp_offload.c: In function 'udpv4_offload_init':
>> net/ipv4/udp_offload.c:932:21: error: 'udp_tunnel_gro_type_lock' undeclared (first use in this function); did you mean 'udp_tunnel_gro_rcv'?
     932 |         mutex_init(&udp_tunnel_gro_type_lock);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:64:23: note: in definition of macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^~~~~
   net/ipv4/udp_offload.c:932:21: note: each undeclared identifier is reported only once for each function it appears in
     932 |         mutex_init(&udp_tunnel_gro_type_lock);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:64:23: note: in definition of macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^~~~~


vim +172 net/ipv4/udp_offload.c

   167	
   168	static struct skbuff *udp_tunnel_gro_rcv(struct sock *sk,
   169						 struct list_head *head,
   170						 struct sk_buff *skb)
   171	{
 > 172		return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

