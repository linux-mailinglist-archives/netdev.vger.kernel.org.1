Return-Path: <netdev+bounces-278601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKSYC6vQ3ml0IgAAu9opvQ
	(envelope-from <netdev+bounces-278601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE03FF1D9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54AF9301A903
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E303BF69E;
	Tue, 14 Apr 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNamr9HD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E260383C9D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210081; cv=none; b=JP5SOlSSEDsUluke8vzSFm80l9hinQxxBt1PrP1P2vqYT2wSGhJFGKrhmc0GofKM9C3RVi1c5fHJnaguG1mSxe83gyuJvo4RAppqymzlsUY3phf0o4sbz4HSug1wI4/GeWzfRVPjTeqVWUYAFKfUDgvIzsxBgqHXEkglWPAL+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210081; c=relaxed/simple;
	bh=vZo9dbW4pd0F5AHbJWgmGW8QYcZboCRAl+ucLogtGY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8CzDkwyB2QDrHi18JGsSVp/H69OLq+IumeM9e+vf+gAsCvMlJyjhF80ZlX1eiCfY1iJVnLd4e4OR0eDH5MOaeYNyMpFARFdJovYgv87Tn7I22EiwWMN1CfByChSpHeBKgFG+RRU5IqD50z6Wh5oSOkemfO3TPF2WwGrv8aoihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNamr9HD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776210080; x=1807746080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZo9dbW4pd0F5AHbJWgmGW8QYcZboCRAl+ucLogtGY0=;
  b=kNamr9HDNnVevaC7aLbEveQhDkw7soXCRFThcl0YbdSXzR7LdDU0XScy
   FMJJkQTOxffINyyPKd6qkduzMFYl+tzwEZedruzguW/oDanLkH0s0QcuB
   E7uCVLrTWGBR7eyEf5c7AMtmbmb/+uIiL9KONSV/fHqyqjwIlAtyt6an+
   teE8nvJ9axGAb6b42vntV83DZhaZ5OupuNoqB9WHmeTWB3s8XezKeP+4y
   WWecx8wciGv60GdenU4rhBiSPYu+sOCwaoKXJcAJXx+/mRNKJyy+QHqNk
   Yp7DDF2h3BOsrFRJtleDAxTCRYOmno9lQIX/+/PFeG3W2YVNJBJwRhz+v
   w==;
X-CSE-ConnectionGUID: XrnY1hwoSh+Zl0R4Y6M0Tw==
X-CSE-MsgGUID: 4Vv9vR2eQgmz1y1pw7OLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94747597"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94747597"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 16:41:19 -0700
X-CSE-ConnectionGUID: psX7x4ebS3mO40OdMfdXeg==
X-CSE-MsgGUID: y2mulXTsRuKwr4EwSdEP/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235188687"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Apr 2026 16:41:17 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCnNa-000000001xV-1kfX;
	Tue, 14 Apr 2026 23:41:14 +0000
Date: Wed, 15 Apr 2026 07:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stefanha@redhat.com, sgarzare@redhat.com,
	mst@redhat.com, jasowang@redhat.com, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix accept queue count leak on transport
 mismatch in recv_listen
Message-ID: <202604150747.6LyaJckM-lkp@intel.com>
References: <20260413085243.73200-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413085243.73200-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 63EE03FF1D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dudu,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on net/main net-next/main linus/master horms-ipvs/master v7.0 next-20260414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dudu-Lu/vsock-virtio-fix-accept-queue-count-leak-on-transport-mismatch-in-recv_listen/20260414-233232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20260413085243.73200-1-phx0fer%40gmail.com
patch subject: [PATCH] vsock/virtio: fix accept queue count leak on transport mismatch in recv_listen
config: sparc-randconfig-001-20260415 (https://download.01.org/0day-ci/archive/20260415/202604150747.6LyaJckM-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604150747.6LyaJckM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604150747.6LyaJckM-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/vmw_vsock/virtio_transport_common.c:1:2: warning: data definition has no type or storage class
     sk_acceptq_added(sk);
     ^~~~~~~~~~~~~~~~
   net/vmw_vsock/virtio_transport_common.c:1:2: error: type defaults to 'int' in declaration of 'sk_acceptq_added' [-Werror=implicit-int]
   net/vmw_vsock/virtio_transport_common.c:1:2: warning: parameter names (without types) in function declaration
   In file included from include/linux/virtio_vsock.h:7,
                    from net/vmw_vsock/virtio_transport_common.c:15:
>> include/net/sock.h:1080:20: error: conflicting types for 'sk_acceptq_added'
    static inline void sk_acceptq_added(struct sock *sk)
                       ^~~~~~~~~~~~~~~~
   net/vmw_vsock/virtio_transport_common.c:1:2: note: previous declaration of 'sk_acceptq_added' was here
     sk_acceptq_added(sk);
     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sk_acceptq_added +1080 include/net/sock.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  1079  
^1da177e4c3f415 Linus Torvalds 2005-04-16 @1080  static inline void sk_acceptq_added(struct sock *sk)
^1da177e4c3f415 Linus Torvalds 2005-04-16  1081  {
288efe8606b62d0 Eric Dumazet   2019-11-05  1082  	WRITE_ONCE(sk->sk_ack_backlog, sk->sk_ack_backlog + 1);
^1da177e4c3f415 Linus Torvalds 2005-04-16  1083  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  1084  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

