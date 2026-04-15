Return-Path: <netdev+bounces-278604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BzrNk3W3mnwIwAAu9opvQ
	(envelope-from <netdev+bounces-278604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:05:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA83FF34E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF9530457C6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE42744F;
	Wed, 15 Apr 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eq+seCv3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19759BA45
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211522; cv=none; b=fIta9EF3YPweVY+jkrYRUvG71dISDTmYEM6YO1grStpJMd031xc+Gyvo1YoTJmor/53sRjrvReUSc/rbGoS3drXtW3aBNr/qWrrZ2NIUQeskjceRRm2ZLbCSFWUw4o6wGJ6hX5NBGnijMu1epwIqaOCN3SflaF/BIauVFB57GlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211522; c=relaxed/simple;
	bh=fQje050jDuyd96KgCNCMqmUH2G68XSqEHGGCVHawldU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXcsOWQHGHS3GJGj9WpYHwLjKwRJ7h2THREPxWd6t+v0NFe0v/SkMOUA6IA3ouznMt+o4imbO5iqye0APVZhZOCCK3FSK7FlDsPFiLfcvye2bVcDTL8DYsAODGMGPw6yZ4mKo/Bqe4QCBITHzINIcts1l66vxfz54CBdXUSoyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eq+seCv3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776211522; x=1807747522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQje050jDuyd96KgCNCMqmUH2G68XSqEHGGCVHawldU=;
  b=eq+seCv3q0yjwv7u3OgzopMGuRRj+wL+DR9ZQ828BqtGi0x2rlJ8q2md
   UzZY0Un1MdgLsIvD2iOBsblNqNgKh4DGCS8EI5DpCR/2Lpx+NYspAdaxw
   sbW4IDAhMfdTZHWAqqG4jzEl2/o0zgvM0E1UNqYva3wJFpFpszWkF2TuQ
   zSHGMvGN0lqQWXB7nKjSf3sH+MjtXFERpu/s3Nd/co31Q6uNwMHVgG6Jm
   bUFA0RXhJAqfEZ/prA/p75LcmF9g5af3WLomeeJbvOVmYpE7MFLZJDw0F
   yQ6lVucJYlQPfeJayzO4vLwc+XdfHgFmUFmLM6Vv95UjLhCuXWY9STvvL
   Q==;
X-CSE-ConnectionGUID: XCGFBuUlSdKMLZAvSpNenQ==
X-CSE-MsgGUID: QThJJ8RQQEWlV7Ari2rzPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88260238"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88260238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 17:05:21 -0700
X-CSE-ConnectionGUID: xB+3kYvpQQyOKv2LxeNgYg==
X-CSE-MsgGUID: rZ+GFvWIT3atgyfE0y8q0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="268224377"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Apr 2026 17:05:19 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCnkq-000000001zX-140H;
	Wed, 15 Apr 2026 00:05:16 +0000
Date: Wed, 15 Apr 2026 08:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stefanha@redhat.com, sgarzare@redhat.com,
	mst@redhat.com, jasowang@redhat.com, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix accept queue count leak on transport
 mismatch in recv_listen
Message-ID: <202604150741.iQBI3cGE-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278604-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 03CA83FF34E
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
config: arc-randconfig-001-20260415 (https://download.01.org/0day-ci/archive/20260415/202604150741.iQBI3cGE-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604150741.iQBI3cGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604150741.iQBI3cGE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/vmw_vsock/virtio_transport_common.c:1:9: warning: data definition has no type or storage class
       1 |         sk_acceptq_added(sk);
         |         ^~~~~~~~~~~~~~~~
>> net/vmw_vsock/virtio_transport_common.c:1:9: error: type defaults to 'int' in declaration of 'sk_acceptq_added' [-Werror=implicit-int]
>> net/vmw_vsock/virtio_transport_common.c:1:9: warning: parameter names (without types) in function declaration
   In file included from include/linux/virtio_vsock.h:7,
                    from net/vmw_vsock/virtio_transport_common.c:15:
>> include/net/sock.h:1080:20: error: conflicting types for 'sk_acceptq_added'; have 'void(struct sock *)'
    1080 | static inline void sk_acceptq_added(struct sock *sk)
         |                    ^~~~~~~~~~~~~~~~
   net/vmw_vsock/virtio_transport_common.c:1:9: note: previous declaration of 'sk_acceptq_added' with type 'int()'
       1 |         sk_acceptq_added(sk);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1 net/vmw_vsock/virtio_transport_common.c

   > 1		sk_acceptq_added(sk);
     2	// SPDX-License-Identifier: GPL-2.0-only
     3	/*
     4	 * common code for virtio vsock
     5	 *
     6	 * Copyright (C) 2013-2015 Red Hat, Inc.
     7	 * Author: Asias He <asias@redhat.com>
     8	 *         Stefan Hajnoczi <stefanha@redhat.com>
     9	 */
    10	#include <linux/spinlock.h>
    11	#include <linux/module.h>
    12	#include <linux/sched/signal.h>
    13	#include <linux/ctype.h>
    14	#include <linux/list.h>
    15	#include <linux/virtio_vsock.h>
    16	#include <uapi/linux/vsockmon.h>
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

