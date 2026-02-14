Return-Path: <netdev+bounces-258728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIQ1AwPgkGk+dgEAu9opvQ
	(envelope-from <netdev+bounces-258728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 21:50:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9513D2FB
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 21:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70FC43004615
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB426F29C;
	Sat, 14 Feb 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="PSez6Ojt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XThCVS1S"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0D548EE
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102205; cv=none; b=rMkUmMO7/IK5mQ08cJMO3gGrRGDRN4BaxkURW0WX1DVeytAWWEpDtWyhkBNEc2L3RZo7AYNAPinFpQt+6XnEPocCFbpeLWkcCCosbbF8P6rVP3Xt0DwAFEti8Ttf/LXmJB6g2LDa1nwiJNDWsnBAAPkHSCfpnTi4DuIt6eQFBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102205; c=relaxed/simple;
	bh=28s+eKhGpoxrUhVSGJfovIeYSBWvPFWiYhqDefjcb+o=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=l1gp8n7k025Mm12X/+rA+TiGRi2Lsjhoj8XSYVNSsQjHZ25N4KXmkOWzihDemWaQUfoHj36W/39z8P0Ur+FeDtW2L++iwGrSR7m8Ml1DQiPOfgQXJGZQm9+cA+SEKKaxYpnajuTAGYV/v+3IojHKShIqy3LcZa/5jViz3uQY3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=PSez6Ojt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XThCVS1S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DB33C1D000B9;
	Sat, 14 Feb 2026 15:50:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 14 Feb 2026 15:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1771102201; x=1771188601; bh=pKwjzk5ROdZFJ/2HCHGr/
	+Szce4gix2P0qia+lbp6L8=; b=PSez6OjtgUXbpv5HR6+vR2MFoiYAWVVfSzKYC
	JD531tUcvj+WYOq4YBvTKkGR11wOsYPGuxdXwt5qlES3S5psneNYsmLcmFmZwWPo
	KlVZckbXLJvYTnubm1j/DyNizllwuzKcQ91bB5ElYc+HSOqC30mdkrzpT/PtSxvN
	PNoipagjgNS6/pRe9VJySXUxaarnIZCKrD4BuDRGpx4P48SB6v3w5axadqezEIdF
	8L8jahbliaC9gbgqjTOIq2khPkfOLpOetM3HEyv5y8b1jlHgNf4mj3MZ/hAelF52
	RS9P83zmL6+/05O+iHOwa5XiBmhpSUwH4TlzHjqG2vbofB7Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771102201; x=1771188601; bh=pKwjzk5ROdZFJ/2HCHGr/+Szce4gix2P0qi
	a+lbp6L8=; b=XThCVS1STJlX0C6z+uXHMDAticoAGD7HMfujPUMG9fpZEfqPZIB
	ZtluYh5XO9wAw5WYJpt3Gmx88VQPmwwLq0LsuGy3AxdAaCuoWdH9lhcrpKqu8UhW
	fFMrMf24uujz4DsY8Gw8C3BjEAHu9y2bki5neweX2+80Vx/TQJWo3gpmEwVQVR48
	CXQBI0VHBb6K4yAl/atEZ9P2WqZFQu+Msq7/bj5QefAe+hsHkK1GOzwNWKYQ3IHa
	yoD4YbDAEBRm5aDKSyzuM3YYM+xtFiR+pRz9rlQoSoClsCCjNd0ybLpP+fHBbl5Z
	7KiHa2VoGOBvmVyVUbriFLXz0u5CwVYTUdg==
X-ME-Sender: <xms:-d-QaXpLluLzxRs-a-lX1yX1cdVxmWKbZZrDhex8cPaCEOIz9dKpZw>
    <xme:-d-QaeOlEVpYvzH3GG0B5iyv2jG3ueMBaDxkW7j3KcWX5crmRu6HCYfDRl1JRuWKj
    gfi1SaQa2cw5LyNKcMo4r3Hf8nEkCJB83a-Ea34qfnqNfIs1hMZRzY>
X-ME-Received: <xmr:-d-QaYrMd2_26M5zaTcJXD9d09x-3sVjVbopohbo9Nr5CZqg4tlWSE4rlYQ28lF6DZeRiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughu
    mhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepnhhikhholhgrhiesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhirg
    hlihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehjsghohhgrtgesshhushgvrdgtii
X-ME-Proxy: <xmx:-d-QaRsUc4Nx_Mnn50WzkhvbQqcfa64s4V3bCfAmHWox_RmYB4F5SA>
    <xmx:-d-QaX2pEatyuxC_HWXYpkPmLYyjcwW9lHblnRkDn2oQn4hIZxkk9Q>
    <xmx:-d-QacHvCTO0oSdC6OgIICFH9DWr2wNkbvU8cHrTnSZtYhryopS9Jg>
    <xmx:-d-QaSvkTqDp9BW_wNwhGQTUfDOMqYRdzIMuOgYTUd9maEgBdi64Wg>
    <xmx:-d-QaZRA5-Bc2zUMnIRAvWe3tf_k1KjpInGppZdnONc_M-pFhufhX_Ri>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 15:50:00 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id CDE759FCB0; Sat, 14 Feb 2026 12:49:59 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CAC889FC40;
	Sat, 14 Feb 2026 12:49:59 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
    Liang Li <liali@redhat.com>,
    Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
In-reply-to: <20260214091541.89659-1-liuhangbin@gmail.com>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Sat, 14 Feb 2026 09:15:41 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <450034.1771102199.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Feb 2026 12:49:59 -0800
Message-ID: <450035.1771102199@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,messagingengine.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C8C9513D2FB
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The ALB RX path may access rx_hashtbl concurrently with bond
>teardown. During rapid bond up/down cycles, rlb_deinitialize()
>frees rx_hashtbl while RX handlers are still running, leading
>to a use-after-free detected by KASAN.
>
>[  214.174138] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc000000001d: 0000 [#1] SMP KASAN PTI
>[  214.186478] KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000=
000000000ef]
>[  214.194933] CPU: 30 UID: 0 PID: 2375 Comm: ping Kdump: loaded Not tain=
ted 6.19.0-rc8+ #2 PREEMPT(voluntary)
>[  214.205907] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.14.=
0 01/14/2022
>[  214.214357] RIP: 0010:rlb_arp_recv+0x505/0xab0 [bonding]
>[  214.220320] Code: 0f 85 2b 05 00 00 48 b8 00 00 00 00 00 fc ff df 40 0=
f b6 ed 48 c1 e5 06 49 03 ad 78 01 00 00 48 8d 7d 28 48 89 fa 48 c1 ea 03 =
<0f> b6
> 04 02 84 c0 74 06 0f 8e 12 05 00 00 80 7d 28 00 0f 84 8c 00
>[  214.241280] RSP: 0018:ffffc900073d8870 EFLAGS: 00010206
>[  214.247116] RAX: dffffc0000000000 RBX: ffff888168556822 RCX: ffff88816=
855681e
>[  214.255082] RDX: 000000000000001d RSI: dffffc0000000000 RDI: 000000000=
00000e8
>[  214.263048] RBP: 00000000000000c0 R08: 0000000000000002 R09: ffffed111=
92021c8
>[  214.271013] R10: ffff8888c9010e43 R11: 0000000000000001 R12: 1ffff9200=
0e7b119
>[  214.278978] R13: ffff8888c9010e00 R14: ffff888168556822 R15: ffff88816=
8556810
>[  214.286943] FS:  00007f85d2d9cb80(0000) GS:ffff88886ccb3000(0000) knlG=
S:0000000000000000
>[  214.295966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[  214.302380] CR2: 00007f0d047b5e34 CR3: 00000008a1c2e002 CR4: 000000000=
01726f0
>[  214.310347] Call Trace:
>[  214.313070]  <IRQ>
>[  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]                 =
                                                                          =
       [  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
>[  214.326537]  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
>[  214.332680]  __netif_receive_skb_core.constprop.0+0x576/0x2710
>[  214.339199]  ? __pfx_arp_process+0x10/0x10
>[  214.343775]  ? sched_balance_find_src_group+0x98/0x630
>[  214.349513]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
>[  214.356513]  ? arp_rcv+0x307/0x690
>[  214.360311]  ? __pfx_arp_rcv+0x10/0x10
>[  214.364499]  ? __lock_acquire+0x58c/0xbd0
>[  214.368975]  __netif_receive_skb_one_core+0xae/0x1b0
>[  214.374518]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
>[  214.380743]  ? lock_acquire+0x10b/0x140
>[  214.385026]  process_backlog+0x3f1/0x13a0
>[  214.389502]  ? process_backlog+0x3aa/0x13a0
>[  214.394174]  __napi_poll.constprop.0+0x9f/0x370
>[  214.399233]  net_rx_action+0x8c1/0xe60
>[  214.403423]  ? __pfx_net_rx_action+0x10/0x10
>[  214.408193]  ? lock_acquire.part.0+0xbd/0x260
>[  214.413058]  ? sched_clock_cpu+0x6c/0x540
>[  214.417540]  ? mark_held_locks+0x40/0x70
>[  214.421920]  handle_softirqs+0x1fd/0x860
>[  214.426302]  ? __pfx_handle_softirqs+0x10/0x10
>[  214.431264]  ? __neigh_event_send+0x2d6/0xf50
>[  214.436131]  do_softirq+0xb1/0xf0
>[  214.439830]  </IRQ>
>
>The issue is reproducible by looping ip link set bond0 up/down,
>where rlb_arp_recv() can race with rlb_deinitialize() and dereference
>a freed rx_hashtbl entry.
>
>Fix this by setting recv_probe to NULL, and then calling synchronize_net(=
)
>to wait for any concurrent RX processing to finish. This ensures that no
>RX handler can access rx_hashtbl after it is freed in
>bond_alb_deinitialize().

	This is much clearer, thanks.

>Reported-by: Liang Li <liali@redhat.com>
>Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb =
hash table")
>Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
>
>v2: make the description more clear (Suggested by Jay)
>
>---
> drivers/net/bonding/bond_main.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 47f13d86cb7e..8e1057a2a061 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4314,9 +4314,13 @@ static int bond_close(struct net_device *bond_dev)
> =

> 	bond_work_cancel_all(bond);
> 	bond->send_peer_notif =3D 0;
>+	bond->recv_probe =3D NULL;
>+
>+	/* Wait for any in-flight RX handlers */
>+	synchronize_net();
>+
> 	if (bond_is_lb(bond))
> 		bond_alb_deinitialize(bond);
>-	bond->recv_probe =3D NULL;
> =

> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD &&
> 	    bond->params.broadcast_neighbor)
>-- =

>2.50.1
>

