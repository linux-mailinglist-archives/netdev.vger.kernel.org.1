Return-Path: <netdev+bounces-240214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA034C71959
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCBEF4E2076
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB31DF72C;
	Thu, 20 Nov 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGb6Etb7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF419E97B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599445; cv=none; b=dCGkEnaMtEqvGkbhq1ZSw529PAajPxWPJ3hUe/yjct7mjHiyWDEDFCGqBcQ6BDUtNghvOW4AZJ4w8o4K50i/LJILJHJETYYkTeMDZQ8jbZ5kyhnAR1NgZChaFMGr/9okAzJrHhybkLOfsgWz8qdsq9Oiu2jJPy6L/7RtTsfOmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599445; c=relaxed/simple;
	bh=j9rg6e2eAbuasOML5wHDFy3gDEnDj0LDk6jSRAhyyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DktJeMDli4uXsPjnCku6zN1bzDFjhtgiSZ0Og5GWHvD5W0OVtOkPtixoIU0Ty5UIjEEl6oXcWhaUvnGskh/y4zVPytRDouJvVrGU1P860ubPEiap1spdPcCy1TuzTK9dal0MKKvUv+Eos6Y0guarwyu0IvYkFKW7jHLDGvMWyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGb6Etb7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763599444; x=1795135444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9rg6e2eAbuasOML5wHDFy3gDEnDj0LDk6jSRAhyyzk=;
  b=aGb6Etb7yIML+/+aZUB/t8G2wueGkq3SzkIFm6vltjazdF6wi0FCvLDw
   IrH28GbR6a+shDUFbXMRVa91cMQrXyHYOArma55Pf5b9e1+VNppGNIYdK
   TuU1ZqiNxf+Fv3wceUumZptPCeJUneO4Y75l4RVH5PoDh9KchN4dzDHPn
   ysUHzkHexvdRjw7b/KxYq+AGfc5PdVSBGIE3M4phgwjD9spoczK+Y2r4I
   Y/BJnoeurUEIUHYXYMjpxDbmnacInP2NGbBdIQ0Q8/20TuV+PRKELWTVw
   mdEfqEJJy0biegK1Xdr89bJjoPPkqwY2yIKl6pFkTxWlP4MJZ0Qt13Yiy
   Q==;
X-CSE-ConnectionGUID: fcrvQkufSM68nczXvBlc5Q==
X-CSE-MsgGUID: +LPGW9HNQPKFUKnAmUwnSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="77015638"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="77015638"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:44:03 -0800
X-CSE-ConnectionGUID: RTxhISTHS62iKj2P88PN0w==
X-CSE-MsgGUID: ALeGpSJnQvy4irHKfiKXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="228527379"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Nov 2025 16:43:58 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLsmC-0003SB-0J;
	Thu, 20 Nov 2025 00:43:56 +0000
Date: Thu, 20 Nov 2025 08:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <202511200846.lqEgKwk3-lkp@intel.com>
References: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio-net-correct-hdr_len-handling-for-VIRTIO_NET_F_GUEST_HDRLEN/20251119-135650
base:   net/main
patch link:    https://lore.kernel.org/r/20251119055522.617-3-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for tunnel gso
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251120/202511200846.lqEgKwk3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511200846.lqEgKwk3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511200846.lqEgKwk3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/tun.c:59:
>> include/linux/virtio_net.h:218:7: error: use of undeclared identifier 'sinfo'
     218 |                 if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
         |                     ^
   1 error generated.


vim +/sinfo +218 include/linux/virtio_net.h

   209	
   210	static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
   211						 struct virtio_net_hdr *hdr,
   212						 bool little_endian,
   213						 bool guest_hdrlen)
   214	{
   215		u16 hdr_len;
   216	
   217		if (guest_hdrlen) {
 > 218			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
   219					       SKB_GSO_UDP_TUNNEL_CSUM)) {
   220				hdr_len = skb_inner_transport_offset(skb);
   221	
   222				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   223					hdr_len += sizeof(struct udphdr);
   224				else
   225					hdr_len += inner_tcp_hdrlen(skb);
   226			} else {
   227				hdr_len = skb_transport_offset(skb);
   228	
   229				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   230					hdr_len += sizeof(struct udphdr);
   231				else
   232					hdr_len += tcp_hdrlen(skb);
   233			}
   234		} else {
   235			/* This is a hint as to how much should be linear. */
   236			hdr_len = skb_headlen(skb);
   237		}
   238	
   239		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

