Return-Path: <netdev+bounces-252292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPD5HAQOcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1097066325
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CF108C41A1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DA338918;
	Thu, 22 Jan 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Wuyy8UzA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C436CE08;
	Thu, 22 Jan 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080525; cv=none; b=XUq0QKcP/cNpGIMqPoWOHEuTM7mxjGJmLc16BfuoiIay3cMP0fTJdvIJHay2UBgX8ENGG81S6gdHI1WJISOAkETRBwzhL9jtlqkzG0vnGJgsyLLC1gGp28vjfvB61eeFEhTu8RHLzN6HLC00/PFtBLrTCcx4KnxFI+D6h6EDjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080525; c=relaxed/simple;
	bh=h1giZtsB/z1ncnT7Kdd8RjQNvMtm8GL9Rur+9cHE7Ks=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv4OfffBp1hqeh36jl0LDMAHgWiirgqpwGPZ3KWpKTx+ZhbORfFBp5GsvbAuOsc7WeWrCDLRWHUv/b5jm9bgyCKgf6JqyBfNsaTWAjxIK7rvkjUYQvILRCPRR3/W+bmYP4TCEpogP9StyV1mAfcxWcMsrHE0xJWgu7E7i3h1nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Wuyy8UzA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DBC5D2088A;
	Thu, 22 Jan 2026 12:15:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwZozS-n_4bO; Thu, 22 Jan 2026 12:15:19 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D9A0F205F0;
	Thu, 22 Jan 2026 12:15:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D9A0F205F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769080519;
	bh=HB1o3cSlES3N9jwC3IjsicH/RhSXuhNwFgEttq1N9G8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Wuyy8UzAnA0GpDmxEogH8ARa72o1TMQjZUa23Fzw9EL04A7vE1CyPcxxaDPJ4feoN
	 dM+y3PLXrhqbRmzioWFWNp0WMd1tU+qwnPTb9aBOIpnkvlZkxdsuVq4MNKJuQbiTU7
	 Af7dBmq8veF6Lpre+BPELmr/geXQZbvbleXuzAoXpT2t8qEAEG3/GstbOeVAnNDxz5
	 pQrcHUnm0WXgX6gwkI3oAFx5bhaq8uxFUYtc8HWodBvwcMV4pEqQ4ayuTijtfMnF7h
	 GaTdLs8xJt36B8sA03DjI0D5hm2QPxJJn5vT3EtqqmIlS1OeB4PEjL8tdN2CPZVUjQ
	 ZQbiQKUA0/8og==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 12:15:19 +0100
Received: (nullmailer pid 1699603 invoked by uid 1000);
	Thu, 22 Jan 2026 11:15:18 -0000
Date: Thu, 22 Jan 2026 12:15:18 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>,
	Boris Pismenny <borisp@mellanox.com>, "David S. Miller"
	<davem@davemloft.net>, Florian Westphal <fw@strlen.de>, Guy Shapiro
	<guysh@mellanox.com>, Ilan Tayari <ilant@mellanox.com>, Kristian Evensen
	<kristian.evensen@gmail.com>, Leon Romanovsky <leon@kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, Raed Salem <raeds@mellanox.com>, Raed Salem
	<raeds@nvidia.com>, Saeed Mahameed <saeedm@mellanox.com>, Yossi Kuperman
	<yossiku@mellanox.com>, Network Development <netdev@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
Message-ID: <aXIGxmCB2QU86-iA@secunet.com>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mellnaox.com,mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252292-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[secunet.com,none];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,ib_gid_table_entry:email,secunet.com:mid,secunet.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1097066325
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 05:24:22PM +0900, Tetsuo Handa wrote:
> A debug patch in linux-next-20260121
> ( https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=fc0f090e41e652d158f946c616cdd82baed3c8f4 )
> has demonstrated that calling xfrm_dev_state_flush()/xfrm_dev_policy_flush()
> when (dev->features & NETIF_F_HW_ESP) == 0 helps releasing "struct net_device" refcount.
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
>   ref_tracker: netdev@ffff88805d3c0628 has 1/1 users at
>        xfrm_dev_state_add+0x6f4/0xc40 net/xfrm/xfrm_device.c:316
>        xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
>        xfrm_add_sa+0x34ca/0x4230 net/xfrm/xfrm_user.c:1022
>        xfrm_user_rcv_msg+0x746/0xb20 net/xfrm/xfrm_user.c:3507
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>        xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3529
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
>        __sock_sendmsg net/socket.c:752 [inline]
>        ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
>        ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
>        __sys_sendmsg net/socket.c:2696 [inline]
>        __do_sys_sendmsg net/socket.c:2701 [inline]
>        __se_sys_sendmsg net/socket.c:2699 [inline]
>        __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   
>   infiniband: balance for netdevsim0@ib_gid_table_entry is 0
>   ***** Releasing 1 refcount on 0000000000000000
>   ***** Refcount for netdevsim0 changed from 2 to 1
> 
> The bond_master_netdev_event(NETDEV_UNREGISTER) case is already calling
> xfrm_dev_state_flush() without checking (dev->features & NETIF_F_HW_ESP) != 0.
> Therefore, I assume that (dev->features & NETIF_F_HW_ESP) != 0 check in
> xfrm_dev_down() is wrong, and I would like to propose
> 
>  static int xfrm_dev_down(struct net_device *dev)
>  {
> - 	if (dev->features & NETIF_F_HW_ESP) {
> -		xfrm_dev_state_flush(dev_net(dev), dev, true);
> -		xfrm_dev_policy_flush(dev_net(dev), dev, true);
> - 	}
> +	xfrm_dev_state_flush(dev_net(dev), dev, true);
> +	xfrm_dev_policy_flush(dev_net(dev), dev, true);
>  
>  	return NOTIFY_DONE;
>  }

Hm, I'd say we should not try to offload to a device that does
not support NETIF_F_HW_ESP.

> 
> change as a fix for "unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2"
> problem.
> 
> 
> 
> But I have a question regarding security_xfrm_state_delete()/security_xfrm_policy_delete().
> 
> xfrm_dev_state_flush_secctx_check() calls security_xfrm_state_delete() which can make
> xfrm_dev_state_flush() no-op by returning an error value.
> xfrm_dev_policy_flush_secctx_check() calls security_xfrm_policy_delete() which can make
> xfrm_dev_policy_flush() no-op by returning an error value.
> 
> Since xfrm_dev_state_flush()/xfrm_dev_policy_flush() are called by NETDEV_UNREGISTER
> event (which is a signal for releasing all resources that prevent "struct net_device"
> references from dropping), making xfrm_dev_state_flush()/xfrm_dev_policy_flush() no-op (by
> allowing security_xfrm_state_delete()/security_xfrm_policy_delete() to return an error) is
> a denial-of-service bug.

This means that the calling task doesn't have the permission to delete the
state, some LSM has a policy the does not grant this permission.

> 
> Therefore, I wonder what are security_xfrm_state_delete() and security_xfrm_policy_delete()
> for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check() ?

This might violate a LSM policy then.

