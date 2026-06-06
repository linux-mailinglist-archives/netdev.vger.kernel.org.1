Return-Path: <netdev+bounces-296074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULtVFU3KI2oXygEAu9opvQ
	(envelope-from <netdev+bounces-296074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60464CD19
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RAD1qRWe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296074-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296074-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6ED301083F
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C426A08A;
	Sat,  6 Jun 2026 07:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7722F388;
	Sat,  6 Jun 2026 07:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730438; cv=none; b=EFAOD5Hk2U2CGVqwoMa7x3qhWU1Vc4qcKt+UcDFD3wUyoJI8QCzWGXJLoMJlMGPonB1/anmQFJq1DGhe+HIvEZBo5WUWPQYVdNhVxrtwlF6IDeSb5d9VZsEuigVNRbPPfRCJomyPogWyu3pVRodcxuOrfizfmVoqWS6KjSVCK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730438; c=relaxed/simple;
	bh=oLrCTrusbE1Dnnw5x61HR6wXcNqfs6DUM2PSApOo1rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUdXB4vFbEe3AvQipd0MK9PAiaDoqx+aZ+zqkslkokVgzBUpoyq+vPcu2E4aY35oNcnSlROJyWv0/kwephqGxAEyyL/uK6LkWVfaPf2TKvuy0jE6ecxqbY01KpxVzvmPvGu8V55ppz/dEhSTAysEgwKZHsHb/BwKXY1Vlcz2/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAD1qRWe; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780730436; x=1812266436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLrCTrusbE1Dnnw5x61HR6wXcNqfs6DUM2PSApOo1rg=;
  b=RAD1qRWecXCMvpvwVDOq59r7m/iqnejGXzdjKE0jAichHNpgK376QoTM
   oBxWEhS+No/Cea3WOo0DojLKZq45hy50TKYCx4g6r8tuX3ujSJXCQXzxv
   ugmWFxJAmDlKtS67dO7wEqWB3D8w846OVxuoIjwwo5foc3wNlMfUiNvuM
   jvqcg+jI+BB29KDoc+PdqQRggBDVqQC1dSmTKNR5VaLneUnRoTsdAuSRh
   kFcsBhcuuimb9A6U++D9QmEwD88i9hF9jHmIcc6frfKFxOM0bVUPswtCS
   3AmdlO0u618hQER/rEZKBUPv78uYsgrO/L4xdIDnnFs6nZPtNDJvPl0cL
   w==;
X-CSE-ConnectionGUID: oojvUS7xQZ6zAJlTc+uUHw==
X-CSE-MsgGUID: kZjLmR7tQW69Rd1UZdzKgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="93040148"
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; 
   d="scan'208";a="93040148"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 00:20:35 -0700
X-CSE-ConnectionGUID: XF/uVrspQyKHeQ4MdppY7g==
X-CSE-MsgGUID: 2wq0+D3ZSgORxZGDxgERwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; 
   d="scan'208";a="275258416"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2026 00:20:33 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVlKY-000000002nd-3jPK;
	Sat, 06 Jun 2026 07:20:30 +0000
Date: Sat, 6 Jun 2026 09:19:51 +0200
From: kernel test robot <lkp@intel.com>
To: Divya Mankani <divyakm@cs.unc.edu>, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Divya Mankani <divyakm@unc.edu>
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen
Message-ID: <202606060907.y54Wngh6-lkp@intel.com>
References: <20260605191922.12720-1-divyakm@unc.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605191922.12720-1-divyakm@unc.edu>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-296074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:divyakm@cs.unc.edu,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-kbuild-all@lists.linux.dev,m:horms@kernel.org,m:virtualization@lists.linux.dev,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,m:divyakm@unc.edu,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF60464CD19

Hi Divya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.16-rc1 next-20260605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Divya-Mankani/vsock-virtio-fix-memory-leak-in-virtio_transport_recv_listen/20260606-032557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20260605191922.12720-1-divyakm%40unc.edu
patch subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260606/202606060907.y54Wngh6-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260606/202606060907.y54Wngh6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606060907.y54Wngh6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/vmw_vsock/virtio_transport_common.c: In function 'virtio_transport_recv_listen':
>> net/vmw_vsock/virtio_transport_common.c:1538:13: warning: unused variable 'ret' [-Wunused-variable]
    1538 |         int ret;
         |             ^~~
>> net/vmw_vsock/virtio_transport_common.c:1535:28: warning: unused variable 'vsk' [-Wunused-variable]
    1535 |         struct vsock_sock *vsk = vsock_sk(sk);
         |                            ^~~


vim +/ret +1538 net/vmw_vsock/virtio_transport_common.c

c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1528  
06a8fc78367d07 Asias He           2016-07-28  1529  /* Handle server socket */
06a8fc78367d07 Asias He           2016-07-28  1530  static int
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1531  virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1532  			     struct virtio_transport *t)
06a8fc78367d07 Asias He           2016-07-28  1533  {
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1534  	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
06a8fc78367d07 Asias He           2016-07-28 @1535  	struct vsock_sock *vsk = vsock_sk(sk);
06a8fc78367d07 Asias He           2016-07-28  1536  	struct vsock_sock *vchild;
06a8fc78367d07 Asias He           2016-07-28  1537  	struct sock *child;
c0cfa2d8a788fc Stefano Garzarella 2019-11-14 @1538  	int ret;
06a8fc78367d07 Asias He           2016-07-28  1539  
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1540  	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
a69686327e4291 Bobby Eshleman     2026-01-21  1541  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
06a8fc78367d07 Asias He           2016-07-28  1542  		return -EINVAL;
06a8fc78367d07 Asias He           2016-07-28  1543  	}
06a8fc78367d07 Asias He           2016-07-28  1544  
06a8fc78367d07 Asias He           2016-07-28  1545  	if (sk_acceptq_is_full(sk)) {
a69686327e4291 Bobby Eshleman     2026-01-21  1546  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
06a8fc78367d07 Asias He           2016-07-28  1547  		return -ENOMEM;
06a8fc78367d07 Asias He           2016-07-28  1548  	}
06a8fc78367d07 Asias He           2016-07-28  1549  
d7b0ff5a866724 Michal Luczaj      2024-11-07  1550  	/* __vsock_release() might have already flushed accept_queue.
d7b0ff5a866724 Michal Luczaj      2024-11-07  1551  	 * Subsequent enqueues would lead to a memory leak.
d7b0ff5a866724 Michal Luczaj      2024-11-07  1552  	 */
d7b0ff5a866724 Michal Luczaj      2024-11-07  1553  	if (sk->sk_shutdown == SHUTDOWN_MASK) {
a69686327e4291 Bobby Eshleman     2026-01-21  1554  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
d7b0ff5a866724 Michal Luczaj      2024-11-07  1555  		return -ESHUTDOWN;
d7b0ff5a866724 Michal Luczaj      2024-11-07  1556  	}
d7b0ff5a866724 Michal Luczaj      2024-11-07  1557  
b9ca2f5ff7784d Stefano Garzarella 2019-11-14  1558  	child = vsock_create_connected(sk);
06a8fc78367d07 Asias He           2016-07-28  1559  	if (!child) {
a69686327e4291 Bobby Eshleman     2026-01-21  1560  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
06a8fc78367d07 Asias He           2016-07-28  1561  		return -ENOMEM;
06a8fc78367d07 Asias He           2016-07-28  1562  	}
06a8fc78367d07 Asias He           2016-07-28  1563  
06a8fc78367d07 Asias He           2016-07-28  1564  	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
06a8fc78367d07 Asias He           2016-07-28  1565  
3b4477d2dcf270 Stefan Hajnoczi    2017-10-05  1566  	child->sk_state = TCP_ESTABLISHED;
06a8fc78367d07 Asias He           2016-07-28  1567  
06a8fc78367d07 Asias He           2016-07-28  1568  	vchild = vsock_sk(child);
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1569  	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1570  			le32_to_cpu(hdr->dst_port));
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1571  	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1572  			le32_to_cpu(hdr->src_port));
06a8fc78367d07 Asias He           2016-07-28  1573  
b09fac3ae8b655 Divya Mankani      2026-06-06  1574  	/* Lock the parent listener socket to synchronize with a potential
b09fac3ae8b655 Divya Mankani      2026-06-06  1575  	 * simultaneous shutdown thread running __vsock_release().
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1576  	 */
b09fac3ae8b655 Divya Mankani      2026-06-06  1577  	lock_sock(sk);
b09fac3ae8b655 Divya Mankani      2026-06-06  1578  
b09fac3ae8b655 Divya Mankani      2026-06-06  1579  	/* Check if the listener socket was shut down while we were
b09fac3ae8b655 Divya Mankani      2026-06-06  1580  	 * creating and configuring the child socket.
b09fac3ae8b655 Divya Mankani      2026-06-06  1581  	 */
b09fac3ae8b655 Divya Mankani      2026-06-06  1582  	if (sk->sk_shutdown == SHUTDOWN_MASK) {
b09fac3ae8b655 Divya Mankani      2026-06-06  1583  		release_sock(sk);
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1584  		release_sock(child);
a69686327e4291 Bobby Eshleman     2026-01-21  1585  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1586  		sock_put(child);
b09fac3ae8b655 Divya Mankani      2026-06-06  1587  		return -ESHUTDOWN;
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1588  	}
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1589  
52bcb57a4e8a08 Dudu Lu            2026-04-13  1590  	sk_acceptq_added(sk);
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1591  	if (virtio_transport_space_update(child, skb))
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1592  		child->sk_write_space(child);
c0cfa2d8a788fc Stefano Garzarella 2019-11-14  1593  
06a8fc78367d07 Asias He           2016-07-28  1594  	vsock_insert_connected(vchild);
06a8fc78367d07 Asias He           2016-07-28  1595  	vsock_enqueue_accept(sk, child);
71dc9ec9ac7d3e Bobby Eshleman     2023-01-13  1596  	virtio_transport_send_response(vchild, skb);
06a8fc78367d07 Asias He           2016-07-28  1597  
b09fac3ae8b655 Divya Mankani      2026-06-06  1598  	/* Safely release both locked objects */
b09fac3ae8b655 Divya Mankani      2026-06-06  1599  	release_sock(sk);
06a8fc78367d07 Asias He           2016-07-28  1600  	release_sock(child);
06a8fc78367d07 Asias He           2016-07-28  1601  
06a8fc78367d07 Asias He           2016-07-28  1602  	sk->sk_data_ready(sk);
06a8fc78367d07 Asias He           2016-07-28  1603  	return 0;
06a8fc78367d07 Asias He           2016-07-28  1604  }
06a8fc78367d07 Asias He           2016-07-28  1605  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

