Return-Path: <netdev+bounces-258993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAjwAXo6lGntAgIAu9opvQ
	(envelope-from <netdev+bounces-258993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:52:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76514A8E8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E00843008C18
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66331A568;
	Tue, 17 Feb 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wi75lAlt"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7331A55B
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321975; cv=none; b=GooRd89MZxnqOIui1Tco0Axt45bpSCuRzLbAnWnfq9CKmVi3t75yioH3CNIVH156c0jaL9GNCfUkKO1x8DK9wsYUXwmJ+KD7C7+pe5YPMjF2LdLaU1OUaqL74fWlB68QKtbhTsTCV3qsEPoIPCw1J9JYOZDHDvSKN7oBG2Rf8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321975; c=relaxed/simple;
	bh=urBAo1uE+9Oyo4pvlXX3YvRNxi0nKsHUyTDoo/qLv4o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMCM4peKERdAYD4XmJijdIe6oBfK7g629QPPQEPOSnNY+DwfCSOO/rYaFrvjncNzqKNy0ycnYg9qd9CSJNnJOgcU2MFRLuyvc8+fSdwEqwxfP3wQ4TcQdK8WIDbG+VAM73dfTjl0GKOXSjaWPfLgAeqD0ZVrIojM3P2cE1h39cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wi75lAlt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7D15E20508;
	Tue, 17 Feb 2026 10:52:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tE6ZPodfIbeR; Tue, 17 Feb 2026 10:52:44 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 79169201CC;
	Tue, 17 Feb 2026 10:52:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 79169201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771321964;
	bh=UWhs/rVcbJWRSCN11hOjwD4iKxtYTROMwtADZVuCsuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wi75lAltdCbDr1Ly+v2coGve4Gi+RrVZaxW93ZiFL8oXI8J45TqsarO/wM9sfGAeO
	 dFj1gRXHb4CMggEdtWIQ3Rodcd6f450JWB/DXWDIxKNIhcGUASJhK5f/KVQizkfNhB
	 5EeNklV3yv1zEoFYg88W2nDxF/j2xzJXWbFgXT9atmszvDGgXYvsBMLVsiobTcE8wL
	 PBvRawiwD7ZLRDKBSU1CzrP2q1mclKL4o6e36QPzro9cxskNVIiEPGcy3FRpP0Pz3g
	 clbFvNhNzHSetDgg/P3SrCTvmwsoDX150Fgg13j4mrORLBjava0rrVsSrt7aZFu39q
	 xpDptd2Ggyxzw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 10:52:43 +0100
Received: (nullmailer pid 2052322 invoked by uid 1000);
	Tue, 17 Feb 2026 09:52:43 -0000
Date: Tue, 17 Feb 2026 10:52:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Sabrina Dubroca <sd@queasysnail.net>, Leon Romanovsky <leon@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>, Guy Shapiro
	<guysh@mellanox.com>, Yossi Kuperman <yossiku@mellanox.com>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: always flush state and policy upon
 NETDEV_UNREGISTER event
Message-ID: <aZQ6a3PfFfJGcOeW@secunet.com>
References: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258993-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E76514A8E8
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:42:47PM +0900, Tetsuo Handa wrote:
> syzbot is reporting that "struct xfrm_state" refcount is leaking.
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
>   ref_tracker: netdev@ffff888052f24618 has 1/1 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>        netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
>        xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
>        xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
>        xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
>        xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
>        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
>        xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
>        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
>        __sys_sendmsg+0x16d/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This is because commit d77e38e612a0 ("xfrm: Add an IPsec hardware
> offloading API") implemented xfrm_dev_unregister() as no-op despite
> xfrm_dev_state_add() from xfrm_state_construct() acquires a reference
> to "struct net_device".
> I guess that that commit expected that NETDEV_DOWN event is fired before
> NETDEV_UNREGISTER event fires, and also assumed that xfrm_dev_state_add()
> is called only if (dev->features & NETIF_F_HW_ESP) != 0.
> 
> Sabrina Dubroca identified steps to reproduce the same symptoms as below.
> 
>   echo 0 > /sys/bus/netdevsim/new_device
>   dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
>   ip xfrm state add src 192.168.13.1 dst 192.168.13.2 proto esp \
>      spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128   \
>      offload crypto dev $dev dir out
>   ethtool -K $dev esp-hw-offload off
>   echo 0 > /sys/bus/netdevsim/del_device
> 
> Like these steps indicate, the NETIF_F_HW_ESP bit can be cleared after
> xfrm_dev_state_add() acquired a reference to "struct net_device".
> Also, xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit
> when acquiring a reference to "struct net_device".
> 
> Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
> re-introduced the NETDEV_UNREGISTER event to xfrm_dev_event(), but that
> commit for unknown reason chose to share xfrm_dev_down() between the
> NETDEV_DOWN event and the NETDEV_UNREGISTER event.
> I guess that that commit missed the behavior in the previous paragraph.
> 
> Therefore, we need to re-introduce xfrm_dev_unregister() in order to
> release the reference to "struct net_device" by unconditionally flushing
> state and policy.
> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Now applied to the ipsec tree, thanks a lot!

