Return-Path: <netdev+bounces-267102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIOMCy3OsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:31:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6A27361C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A44F302F93C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C897335F16F;
	Thu, 12 Mar 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+Y9EVw/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B136D9E4
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325782; cv=none; b=GAmdbDykb4+rKPfBOUi49Sytm4935mRt8Ml2U7qOWBO2Ew9NNJpPPn0OW583ghGVRYRd4aWSr2HAoYMlVuolr3rw0R88EqYkHN9sxpzXG/JUC+CB+Co6iiOB9F90yIULgTxN+x2k0qAaGtLskwny2KIBroX5ZOdKdFMIxPRjaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325782; c=relaxed/simple;
	bh=Y0+sYgTWA2dV+l0uHQP9RWviBqnC7bXHitpIc8NuJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl0qjPAkoxrcUDBVuYUGUyhsBMlifP57EjylIsuDk1z1i0NwbMPERqQt4WJ8/28SH3Pjmu+TgBjDyIO5OhY06khTnOSyWOtzLUWlgpTuQI5JnwEIO3pD/VFxlrCqAEKsBGGVpcJNjyLYtyzp3jdvvKQMLQlS7mdPI9YzE5OWO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+Y9EVw/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773325781; x=1804861781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0+sYgTWA2dV+l0uHQP9RWviBqnC7bXHitpIc8NuJ/w=;
  b=Q+Y9EVw/oq05E5CFLpe6VERnWbt7eB5WImpbstuGsxwTARTwdpaBD9to
   FeXqr8pdvfNHg754dfOPOpVitHqEf4+LWAkMnTGuUXEcDvEFDXEam0dFb
   lugFC954R7mL9oSGwbGthUHlP36/sDOSWijJ+kXNdNqHgJMvDbTLDdECq
   7Zn+jxfwgUk9Ch/C8S8hrGlUiWb8WlEs5pHSjIqJRuwsM97AjgsoIl6jb
   3kUMFVYyBR3YdDyZEzgHRTy1N8eJfmo2LQps48LTNF+xokfqxaZeP23k0
   gb8kiS/ThAu/oP4UHC19Ng6qmZR/V46/2RLuVFSaJLBe0/Z56k3qbbJsz
   g==;
X-CSE-ConnectionGUID: cUd3Sy2kSoST/pICWkJ+9w==
X-CSE-MsgGUID: mQc4Bq5ATkO1bWMp2GqULA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85773964"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85773964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:29:40 -0700
X-CSE-ConnectionGUID: ISAwfUKDQKmCZFh6mr3uqg==
X-CSE-MsgGUID: mm9DTY2bRh+1JemURCzhvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218641907"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2026 07:29:37 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0h2c-000000002Yh-1IpV;
	Thu, 12 Mar 2026 14:29:34 +0000
Date: Thu, 12 Mar 2026 22:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH net v9 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <202603122214.8Anoxrmq-lkp@intel.com>
References: <20260311115414.31243-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311115414.31243-3-xuanzhuo@linux.alibaba.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,redhat.com,lunn.ch,google.com,kernel.org,linux.alibaba.com,resnulli.us,solid-run.com];
	TAGGED_FROM(0.00)[bounces-267102-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 28A6A27361C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio-net-correct-hdr_len-handling-for-VIRTIO_NET_F_GUEST_HDRLEN/20260311-200042
base:   net/main
patch link:    https://lore.kernel.org/r/20260311115414.31243-3-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net v9 2/2] virtio-net: correct hdr_len handling for tunnel gso
config: i386-randconfig-061-20260312 (https://download.01.org/0day-ci/archive/20260312/202603122214.8Anoxrmq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603122214.8Anoxrmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603122214.8Anoxrmq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net.c: note: in included file:
>> include/linux/virtio_net.h:238:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio16 [usertype] hdr_len @@     got restricted __le16 [usertype] @@
   include/linux/virtio_net.h:238:22: sparse:     expected restricted __virtio16 [usertype] hdr_len
   include/linux/virtio_net.h:238:22: sparse:     got restricted __le16 [usertype]

vim +238 include/linux/virtio_net.h

   225	
   226	static inline void virtio_net_set_tnl_hdrlen(const struct sk_buff *skb,
   227						     struct virtio_net_hdr *hdr)
   228	{
   229		u16 hdr_len;
   230	
   231		hdr_len = skb_inner_transport_offset(skb);
   232	
   233		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   234			hdr_len += sizeof(struct udphdr);
   235		else
   236			hdr_len += inner_tcp_hdrlen(skb);
   237	
 > 238		hdr->hdr_len = cpu_to_le16(hdr_len);
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

