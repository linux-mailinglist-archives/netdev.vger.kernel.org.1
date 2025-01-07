Return-Path: <netdev+bounces-155804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD56A03D4D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D68718868FD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07231E411D;
	Tue,  7 Jan 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="pCQQK4OB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AczSDlp6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20371E0DD1;
	Tue,  7 Jan 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248113; cv=none; b=jmkgVUsVpBzKQacmeKmvTLvjBpiPBqFbwrzDedE8UnrN2ZKcrvT2PVh3rhedEzpoQB7nH9mO25ig8n4bkbPZoI0KREIl8eUiZOLKBvWoyiucuZgh6cErXYdFym0S1s9YX400qNbx7jtua+jGE16B6ZjWOXtSVxKmOK7ZBMx56YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248113; c=relaxed/simple;
	bh=RlWyTX+XcTJeN0bI1moKQoQc9SfTqbi4tdSrXOnGPQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9EZHOZQll3bv9tTroJ3LaMIMw5uWjlkXgn0/+orb+XBJnJ6Opku9O9YfR7jOwA6AwGEOlweWv+eodSBjJQVrpQO+mWFPP21pGf7bQUKF7/0sYGHxNKcC6PeOy3EK+rvgKtn/ZnYBtepl3IQJV2CUdKhE6VE+JYQ+VA/twRt1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=pCQQK4OB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AczSDlp6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71977254016F;
	Tue,  7 Jan 2025 06:08:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jan 2025 06:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736248106; x=
	1736334506; bh=hlfkDoC9hGqVwxToayc/tl4N76vhna1dTss6xUhfO8g=; b=p
	CQQK4OB/ARwqsHo9HUSzgfD+f447g2uolvTKsrAu7vItSBYxAkxc1fE5oC4WdMIW
	BfwRuy4YMNoUIg9Bj8IVBRtJsyQ9gGpq8LVWiAbG9Ba4R4p8T4QKofeSN3GFjal/
	oXhSRCy15meVwh1hwb4rOTjex1bDu76nrlGPy493EJNzmcY1AGNv3b4viurVrb92
	uUWI3/OTkcMcEg89jnNDcTFKs2you7+VPWNhp4ijN5ma/Pijq09olYFq9XVGb2o5
	8kt2xOlPXOL6caFPcRaukTUmU8FYsRuGUrVrZ6mI1lbzLi4sRmJmJqMR+PwV95sQ
	cLqNVqh2EEOqkHC0rfZSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736248106; x=1736334506; bh=hlfkDoC9hGqVwxToayc/tl4N76vhna1dTss
	6xUhfO8g=; b=AczSDlp6Lw0dodb+E1j3ZuXovi5u75aGQL9f10Drk81nuQ0gg+P
	lUCslioDAVQlITog4hvYe54RAZUSQf6FqEbxzQLmIkHbiA/+ahDO2sdKRbxJcjo7
	R01fTcSg6gvhZPQ2NuNUn1IV67S4euffddgGVEVfaMXNUmuyRE3Tko/6MUasw8nP
	jMtt9p6qKH3xdtl3tuJM2MOg27XGDMXa5slxDZHCSSRzoOcMosq/VN/2HPN+kSgQ
	xdH1BoLrPnuMeqjxYd6mYCJ00hwAOuGzqHJyclcVntoVWXVL7E6zL+5hJtOm+1SS
	maWBXCpcAUYRBU1JbMP1vwNMbaB5/MYCoag==
X-ME-Sender: <xms:KQt9Z6bDNvuYEWBKob2X8jdD6kb0LCpHtcqK9YRl02eZ4h5QmFprtw>
    <xme:KQt9Z9aNFsPKj5_uZBSxR81qnDF3mqaMn8WfhiqW0MQ6X7VlEpxR7RucL8ryv-UUQ
    Tyjy8XXvUruH4nIYuw>
X-ME-Received: <xmr:KQt9Z08AsaCuNYV7uA8tBhwltma63kPely9YvOVHLCFztssupkfaORLl9T-f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffoh
    hmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveekhffgtddvveejvedvgffffeeftedt
    fefhtdfgueetgeevuefftdffhfduhedvnecuffhomhgrihhnpehshiiikhgrlhhlvghrrd
    grphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrg
    hilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehshiiisghothdoiegrtgejfegsfegrsghfudgsheelkeekieeffhgrsehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepsghorhhi
    shhpsehnvhhiughirgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:KQt9Z8qHW4HQgdElEvtmG7n2w-PvAuulpvm1W_FsLtEdUET5X-KVWg>
    <xmx:KQt9Z1oRdOYhyCgTOv4np3inowf0RfZUloAVOzwx4i-Ba4NxCS9LFw>
    <xmx:KQt9Z6Tb4PKFAv_KJ3g5_zlaBqhmSGaSHPI9rlLeFmwhz6MMuhPpmg>
    <xmx:KQt9Z1pu4JQ78F1dZ5zUq-FAkk4A16Ihl-67Ilv7aNIjd_NUsNNqug>
    <xmx:Kgt9Z2QftbH5ZlzXGFed6IWxp_2_sS8ZzlujPmFNYsSOFLbMgbq5TJC0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 06:08:25 -0500 (EST)
Date: Tue, 7 Jan 2025 12:08:23 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: syzbot <syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com>
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in lock_sock_nested (5)
Message-ID: <Z30LJ6upikEXVxeE@hog>
References: <676d231b.050a0220.2f3838.0461.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <676d231b.050a0220.2f3838.0461.GAE@google.com>

2024-12-26, 01:34:19 -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1760eadf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
> dashboard link: https://syzkaller.appspot.com/bug?extid=6ac73b3abf1b598863fa
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122f74c4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155c0018580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz
> 
> The issue was bisected to:
> 
> commit 47069594e67e882ec5c1d8d374f6aab037511509
> Author: Sabrina Dubroca <sd@queasysnail.net>
> Date:   Thu Dec 12 15:36:05 2024 +0000
> 
>     tls: implement rekey for TLS1.3
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13da8018580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=103a8018580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17da8018580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
> Fixes: 47069594e67e ("tls: implement rekey for TLS1.3")
> 
> INFO: task syz-executor309:5851 blocked for more than 143 seconds.
>       Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor309 state:D stack:28496 pid:5851  tgid:5846  ppid:5845   flags:0x00004006

I'm getting a different (and IMO much more helpful in pointing out the
issue) trace when I run the repro:

BUG: TASK stack guard page was hit at ffffc9000294fff8 (stack is ffffc90002950000..ffffc90002958000)
[...]
Call Trace:
 <#DF>
 ? die+0x32/0x80
 ? handle_stack_overflow+0xa5/0xe0
 ? get_stack_info_noinstr+0x14/0x120
 ? exc_double_fault+0x140/0x180
 ? asm_exc_double_fault+0x1f/0x60
 ? mark_lock+0xfc/0x2370
 ? tls_sw_write_space+0x10/0x150
 </#DF>
 <TASK>
 tls_write_space+0xd4/0x170
 tls_write_space+0xfd/0x170
 tls_write_space+0xfd/0x170

 ... a few hundred more of those lines

 tls_write_space+0xfd/0x170
 tls_write_space+0xfd/0x170
 tls_write_space+0xfd/0x170
 sk_setsockopt+0x1b7a/0x48b0
 ? tracer_preempt_on+0xd7/0x490
 ? __pfx_sk_setsockopt+0x10/0x10
 ? find_held_lock+0x2d/0x110
 ? lock_release+0x44e/0x6f0
 do_sock_setsockopt+0x31e/0x3f0
 ? __pfx_do_sock_setsockopt+0x10/0x10
 ? __fget_files+0x1d9/0x370
 __sys_setsockopt+0x103/0x170
 __x64_sys_setsockopt+0xbe/0x160
 ? do_syscall_64+0x2a/0x140
 ? lockdep_hardirqs_on+0x74/0x100
 do_syscall_64+0x64/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f0f2fc4b1fd
[...]


I don't know why syzbot is only getting a hung task.


Anyway, good find by syzbot, I missed that when I wrote the rekey
code:

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9ee5a83c5b40..99ca4465f702 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -737,6 +737,10 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	else
 		ctx->rx_conf = conf;
 	update_sk_prot(sk, ctx);
+
+	if (update)
+		return 0;
+
 	if (tx) {
 		ctx->sk_write_space = sk->sk_write_space;
 		sk->sk_write_space = tls_write_space;

-- 
Sabrina

