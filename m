Return-Path: <netdev+bounces-258829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF6MLUedkmmpvAEAu9opvQ
	(envelope-from <netdev+bounces-258829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7D140DAE
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA433009FA2
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BFD2C0F79;
	Mon, 16 Feb 2026 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGe9xKos"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8B2C11D9;
	Mon, 16 Feb 2026 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771216044; cv=none; b=O0C457rP39pRygAu5HILXNuWFFiCx+4UFJa8F3ediE7z4Z4VwJxdMx7++6EMCktUKiuMaD7omg18AlWolwHZsnhK1wpQAGfs8Sdb8qurmerD2znnbxBpbzP+AlVEllc9ZbnGbNHGbt29F4m93FdbsE1/ctoSZuIt6wfOhyqoSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771216044; c=relaxed/simple;
	bh=zS5aTFEiXNs11x2klWT5blaxKck2RbkmlTT/mT+crYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC+YGIFuoFULQIM2BeHcpGVgHtyW1l032wX9bwcfHb2rKLq+PNAr4IH+rM5HiSe2rBpDHvLAgH+NOYp7HK8xxV8JRauq/SoW10SeYLtgVcIdOyU/efwZglP2TMY10xTCA7qrbqxvYf7du6e/jnOlwP6eRQQScxrU9xz7OqKGGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGe9xKos; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771216043; x=1802752043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zS5aTFEiXNs11x2klWT5blaxKck2RbkmlTT/mT+crYE=;
  b=DGe9xKosj47Os+ywuQnFF6XT6wqWaCyKQZE8i1ozsF1WGYo9S3IJmWG5
   eDFLopUJYKXVTm7I0JQg66IrFCM0kvYoYzQYR8ZEuh8RwmtwXk1SxTpDC
   jnh/6h6ZX+mVdo3Nc0aLUMm+fHd14YmxeLst3AN3a9q5pHjJxO0y0To99
   H8LlMj/g8nYxuuVZf3RfEkcLvmp0v9wMVALvOcO13NVXLEP8N6G75oG9o
   lMpiPTr6temx1S51tYCTu9wAJH/Zk06RRiHBv3v1rq05rLCGO1ZYSRHgJ
   tWk3irrJRUJcHVdQWsUNrE2zdJzll4u8cJbD9zQr4THlzlzYnax36/4TN
   w==;
X-CSE-ConnectionGUID: 6XdSMm8KQE28g2yxWGOEmw==
X-CSE-MsgGUID: 4HLEbecnSKKnlVs6jXHoAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72468994"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72468994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 20:27:22 -0800
X-CSE-ConnectionGUID: EV1xUuohR4Slxdcg/tTu7g==
X-CSE-MsgGUID: 34AHIvdUQZKD3IQxzWa6iw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Feb 2026 20:27:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrqCb-00000000zOK-39zz;
	Mon, 16 Feb 2026 04:27:17 +0000
Date: Mon, 16 Feb 2026 12:26:28 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
Message-ID: <202602161215.LxHBWhAv-lkp@intel.com>
References: <20260215204353.3645744-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215204353.3645744-7-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,bytedance.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-258829-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1FF7D140DAE
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20260213]
[cannot apply to horms-ipvs/master v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/sockmap-Annotate-sk-sk_data_ready-for-UDP/20260216-044819
base:   linus/master
patch link:    https://lore.kernel.org/r/20260215204353.3645744-7-kuniyu%40google.com
patch subject: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
config: x86_64-buildonly-randconfig-004-20260216 (https://download.01.org/0day-ci/archive/20260216/202602161215.LxHBWhAv-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260216/202602161215.LxHBWhAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602161215.LxHBWhAv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/core/skmsg.o: in function `sk_psock_skb_ingress':
>> net/core/skmsg.c:608:(.text+0x2037): undefined reference to `udp_sock_rfree'


vim +608 net/core/skmsg.c

   575	
   576	static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
   577					u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
   578	{
   579		struct sock *sk = psock->sk;
   580		bool is_udp = sk_is_udp(sk);
   581		struct sk_msg *msg;
   582		int err = -EAGAIN;
   583	
   584		msg = alloc_sk_msg(gfp_flags);
   585		if (!msg)
   586			goto out;
   587	
   588		if (is_udp)
   589			spin_lock_bh(&sk->sk_receive_queue.lock);
   590	
   591		if (skb->sk != sk || is_udp) {
   592			if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
   593				goto unlock;
   594	
   595			if (!sk_rmem_schedule(sk, skb, skb->truesize))
   596				goto unlock;
   597		}
   598	
   599		/* This will transition ownership of the data from the socket where
   600		 * the BPF program was run initiating the redirect to the socket
   601		 * we will eventually receive this data on. The data will be released
   602		 * from skb_consume found in __tcp_bpf_recvmsg() after its been copied
   603		 * into user buffers.
   604		 */
   605		skb_set_owner_r(skb, sk);
   606	
   607		if (is_udp) {
 > 608			skb->destructor = udp_sock_rfree;
   609			spin_unlock_bh(&sk->sk_receive_queue.lock);
   610		}
   611	
   612		err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
   613		if (err < 0)
   614			goto free;
   615	out:
   616		return err;
   617	
   618	unlock:
   619		if (is_udp)
   620			spin_unlock_bh(&sk->sk_receive_queue.lock);
   621	free:
   622		kfree(msg);
   623		goto out;
   624	}
   625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

