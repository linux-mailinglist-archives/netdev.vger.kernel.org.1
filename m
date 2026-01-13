Return-Path: <netdev+bounces-249581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB48D1B327
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40C5B30222ED
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461236AB65;
	Tue, 13 Jan 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="FTxlvjMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7eeCSDl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08615314B8C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335939; cv=none; b=XI1kFjaKZTnRb7icAl+Etik9ipA1QoUZoijyAgwH4Ihsz92qebibPUhH3T59ElfLQAAoDsIAxBwHieTYsZEvKdzcXcPLV4z5uCgQrhQcHuSUq7MFmoPhUXzJcecmOPL3/QGlfxOL4kA73Q5P8ups2xv17DcJW25qzdOjP0MDeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335939; c=relaxed/simple;
	bh=yGzpWRbA5AjTKDPc6vOJ/6T5P/NODHEmUWpUckg290A=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ssW/n0Z3UmnQ06k7W4ha0kvxFSaFX4ebaGJVv4BPpUGLpEiQ/VRoZlMnlqr4RIpgLlXNDvwWP2UgccHB9NeR/DjQkA0HnzeeiMtHMNck132I0lYoCO9ynEVCXlLN5sLi1HtPBkwiQZQkFiWShPwr/Xta4zQmiMCdtXRrxhyRiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=FTxlvjMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7eeCSDl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A24FEC0278;
	Tue, 13 Jan 2026 15:25:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 15:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1768335936; x=1768422336; bh=6XVcGV+xzwmJIkSLv8Glp
	982cQL/wnmrsEt6/qZUon4=; b=FTxlvjMUh5IB3uU7ZLZmRkE7bIY8bJn6UV8ix
	BzKzcJEU1KCXbTI0AUjt7/Ggi5ssRZfO1aqzLUscvsWOhtSnGtpuaBagGOOqtV0l
	tGv/+78N0JLJZSniN5kuby+Vx90dfLK2QZunbFehsW8i+pe9TVWFR87GHoKF0d6v
	lNLAmS57PwSDsYmC554PGiU2izc5DUdEv4qSD/pF8MPVaT5e/QiiPeROfCWqNgza
	mZNAANhePhe35hGuxrHJYncH4TBQDMaEqjwVSCA4aVRYYMo4f7G7YGohHXi/pfDY
	g5VrpXP5LquM48Bwey6gtdqe60LYFPIGjdcskShzZL4fK+ScQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768335936; x=1768422336; bh=6XVcGV+xzwmJIkSLv8Glp982cQL/wnmrsEt
	6/qZUon4=; b=q7eeCSDlusjytXvMisxfsuqkurEv2IdMoP/7jjx8XpOYKxu/ADr
	j4c1Rf2HR2qa2x/I+hNoAgQ29OFnUihzdCsQBH6+RRLthFeFXqnYYMjZUUy0OC8J
	hTBimR4Izde/SkC0honEw192mAxReAvSdC/CdpkKx1qVRhxu2YRSLmc4XvOc68ES
	SjWI+GidBZ/GOOU5WBX3pPuC0Ch28bWaQyNZyLHpITQ2uNLEKZ14mI/ZtcE2PgS6
	MUSOM0gA5FrHKtTceF5v20uFTxlPP+5fhTC3aaAt9VmhDgypm5eTTaPly35ehDnq
	dUvQYUG78QKByGgCJZUXsbzymFlDFj7sw6A==
X-ME-Sender: <xms:P6pmaSvNwN6aOPffiEG35rDFWdtVp0RhxirkupjV0jGbjB9b2S6USw>
    <xme:P6pmacaynItn7AFUXjUHtss4b4R5V_sMTk_eY___x-vt6Hf_To5tdBn9JPQi-VNXZ
    ZPRLSsPeg88cvO4z5-6NhHvRPAjMwuzns82278lvEAUT9NX_pTJFg>
X-ME-Received: <xmr:P6pmaSAyXj7tFBGk2ZOsNaYft_yQfeBRiWMqpl17NPmF9c1UQpjamSlfCOf7Olx6gPqrPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvrhhitgdrughumhgriigvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvse
    hluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehshiiisghothdolegttdekudgsudejjeejfeeiudehfhdvgeeijedvsehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P6pmac_NRTZaCgHgbZ__-FG_D_VS7HJtGbUrsdQSZ8tvViZYHDqj7w>
    <xmx:P6pmaWSXe9jWiYx6nav1JARaQTrqzAC4q6g1pVL4o7XrYC048Lx0zQ>
    <xmx:P6pmaYU0n_ZjBhXqI3lx3FvevtLFg6H_WvUfGU75_rcfP_k9J3J_rg>
    <xmx:P6pmaYQTOz9X_owo7MhvOFCvCAbDl-Fglt_MhcBWh0O8N-UcBR4WKQ>
    <xmx:QKpmac8S6KRzTFL4oup3XcptzjlKPTKjIAGqHUE4uT9jK9zpdtwgsfi2>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 15:25:35 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 6B09B9FCA9; Tue, 13 Jan 2026 12:25:34 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 69D5D9FC51;
	Tue, 13 Jan 2026 12:25:34 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com,
    syzbot+9c081b17773615f24672@syzkaller.appspotmail.com,
    Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] bonding: limit BOND_MODE_8023AD to Ethernet devices
In-reply-to: <20260113191201.3970737-1-edumazet@google.com>
References: <20260113191201.3970737-1-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Tue, 13 Jan 2026 19:12:01 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3222057.1768335934.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 12:25:34 -0800
Message-ID: <3222058.1768335934@famine>

Eric Dumazet <edumazet@google.com> wrote:

>BOND_MODE_8023AD makes sense for ARPHRD_ETHER only.

	Agreed.

	There are likely other ARPHRD_* types that don't make sense,
either.

	Assuming from the szybot logs that an interface named
"ip6gretap" means ARPHRD_IP6GRE, I don't see how ARPHRD_IP6GRE could
work for balance-alb or balance-tlb modes (which expect an Ethernet
header in the packets), and maybe not at all for bonding.

	Still, whether it works usefully is a separate question from
whether it panics, so this patch is certainly correct.

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J

>syzbot reported:
>
> BUG: KASAN: global-out-of-bounds in __hw_addr_create net/core/dev_addr_l=
ists.c:63 [inline]
> BUG: KASAN: global-out-of-bounds in __hw_addr_add_ex+0x25d/0x760 net/cor=
e/dev_addr_lists.c:118
>Read of size 16 at addr ffffffff8bf94040 by task syz.1.3580/19497
>
>CPU: 1 UID: 0 PID: 19497 Comm: syz.1.3580 Tainted: G             L      s=
yzkaller #0 PREEMPT(full)
>Tainted: [L]=3DSOFTLOCKUP
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
>Call Trace:
> <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
> check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
>  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>  __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
>  __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
>  __dev_mc_add net/core/dev_addr_lists.c:868 [inline]
>  dev_mc_add+0xa1/0x120 net/core/dev_addr_lists.c:886
>  bond_enslave+0x2b8b/0x3ac0 drivers/net/bonding/bond_main.c:2180
>  do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
>  do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3165
>  rtnl_changelink net/core/rtnetlink.c:3776 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
>  rtnl_newlink+0x161c/0x1c90 net/core/rtnetlink.c:4072
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>  ____sys_sendmsg+0x505/0x820 net/socket.c:2592
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
>  __sys_sendmsg+0x164/0x220 net/socket.c:2678
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0x1dc/0x560 arch/x86/entry/syscall_32.c:307
>  do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:332
> entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> </TASK>
>
>The buggy address belongs to the variable:
> lacpdu_mcast_addr+0x0/0x40
>
>Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_E=
THER")
>Reported-by: syzbot+9c081b17773615f24672@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/netdev/6966946b.a70a0220.245e30.0002.GAE@=
google.com/T/#u
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>---
> drivers/net/bonding/bond_main.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 3d56339a8a10d97664e6d8cb8b41a681e6e9efc5..0aca6c937297def91d5740dfd=
456800432b5e343 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1862,6 +1862,12 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
> 	 */
> 	if (!bond_has_slaves(bond)) {
> 		if (bond_dev->type !=3D slave_dev->type) {
>+			if (slave_dev->type !=3D ARPHRD_ETHER &&
>+			    BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>+				SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>+					     "8023AD mode requires Ethernet devices");
>+				return -EINVAL;
>+			}
> 			slave_dbg(bond_dev, slave_dev, "change device type from %d to %d\n",
> 				  bond_dev->type, slave_dev->type);
> =

>-- =

>2.52.0.457.g6b5491de43-goog
>

---
	-Jay Vosburgh, jv@jvosburgh.net

