Return-Path: <netdev+bounces-275158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNmUDkf+z2kr2QYAu9opvQ
	(envelope-from <netdev+bounces-275158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332153972AF
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC46308853F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F03D34A9;
	Fri,  3 Apr 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Cx21TSn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgQ4FC4D"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA723A9D85
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238612; cv=none; b=g732HSW9cV/z+LVTCtduw3/8u1Yrtkr8sqmGiVwhWzYglAijBr+18yPAllb7oNWq4eoF2jniujyIEv6czKUHjuLPAMplkjXN96js2TLdjpTQnaEglZOTaixwUYI5Y3pdwef7q69pNLn0JCPQXpFKuPOpwBXLYZBBq+an42ynuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238612; c=relaxed/simple;
	bh=AsnCHbWUF7HKHjz4azgtfqv+O8MqtxyOyazCBNIvOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjfFj9JmLYENaWw83+g2GigAzJ/ejpjIoqRZGVGOa6d2gmnD/4XWxKwUED2t1zYounB2hOPMXy109Z0+G67bL+4CP8aJ4yVlPvRHrOoeqNpliQNd/Y3Nv+NfFlwFNLA4ioHTOPi87sG0Hk0YxyGN0CtpsZgvfn9U7qH4zlgIlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Cx21TSn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgQ4FC4D; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39AA77A01E1;
	Fri,  3 Apr 2026 13:50:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 13:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1775238608; x=1775325008; bh=ozRnCihEa8oWt/rTa2glc
	YJ93V/2Yec+2w/1wOET/Sg=; b=Cx21TSn/kLFgdQw9AuyFDUwYe56P13tzOtIEa
	GT1ROybl+7rzz5GPwzoyKd0B/ZM0nltdaHaqERGEUdJXLeObkFtnJKdefThAoYL1
	SNi6fNGVETWPryZuTaocg5F8ut3rq1CDJsazXLmIFpSGBYQMjL/IyBY+TSdhsyDP
	+VMfxEhzXG2dT1dYlZ/KDMEnwZMutsyMmE24/MaRzZvWErCHpj9n4jiCmIP1RHOv
	GWuwVQ226QesfB8bq7no7k3LroA77kz0Ds4dKWIALJmbxjSnBEsx/IADW3LEUTmU
	uyN0x2cabmFSDbpx0Fyy3QkIwzgrAR9Xu1OB0lO0ZzGQMjRAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775238608; x=1775325008; bh=ozRnCihEa8oWt/rTa2glcYJ93V/2Yec+2w/
	1wOET/Sg=; b=PgQ4FC4D3Gqt2aI4c959hTjLtn2Ah8nUtO52dWrIuKmSQcfqMmk
	8YjvN8kQbQYEu8gVO+g+AIqtQdXIv/rfjrJMNHPTpfNncMCmxZTg4HPJCqE0SDBX
	o3JQL1WqupJq8DcxxfZtV5YtJgbxt5mkI5P9yxEkL68F2FjyDUrsujy3mmCF0sha
	QflQ75hCxPCJJKlNO5zf8GFxDQ+WJlXNht49PMhbSCLu/vPHONE9Mvhd3vLoj3qJ
	vAahUxL5mGhI+yOkEzzj7UvkMqnOipEniOzicZzvBVAYR+whl7wqgHwDBG2MhwPD
	MQMF3i5yxb8eO+1sgKjDkHIuyUslP0RU0nw==
X-ME-Sender: <xms:z_3Pafc9Tb06E1OZn8EHSHmtI9ACzrsRsXmjydwX2QilQLBiLH_k9A>
    <xme:z_3PaaIB0F7JecatV14Li4OHN3PqTUDsJ4MiB0mINupc9nj5pAkAhx8V1N7qw3szN
    ZRFm-OEd9vfbod3ULQU1uXSA-9D4svXvAiAeFIeu5eqC4glJhmzB4Cf>
X-ME-Received: <xmr:z_3Pacxt4L6A4E9EojNdKTDBvywNXO838EGaTq615E5nlUxePHoFjrXitZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhikhhi
    thihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimheqne
    cuggftrfgrthhtvghrnhepheduiedvieefffduueelgeehuefhleekuefffeeiheeuhfet
    jedtvefffefgfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvrdhkvghrnhgv
    lhesfhgrshhtmhgrihhlrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgthh
    grphhmrghnsehkrghtrghlihigrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvgesihhsohhvrghlvghnth
    drtghomhdprhgtphhtthhopehshiiisghothdotghifegvuggvrgeitdgrgeegvddvhegu
    vggtsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:z_3PaQu-5RnAKlZskY38VCx9A-HM3jkPtCvRsq7nGa8RCKB0egVExw>
    <xmx:z_3PafDIuvSx6LlIJqbX59H0SUZYSaRyoiltcgclnd4jhj2tfaGh9Q>
    <xmx:z_3PaSEVG9miGN_NsKn2_ERDDAw4xuKSsSUNg_29Jw2Jya7ywAjmkQ>
    <xmx:z_3PafDdlVH5oXjn64x2wd8DL8PzD0e-J7pvlK55i7tqb5-H9gxCiQ>
    <xmx:0P3PaVqLGkFlH-rzkQO0b1Amp7DiFhlqAqEdaBDdUwZ-7kd0nwOl2Ryb>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 13:50:04 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
Subject: [PATCH net-next] l2tp: Drop large packets with UDP encap
Date: Fri,  3 Apr 2026 20:49:49 +0300
Message-ID: <20260403174949.843941-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,ci3edea60a44225dec];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Queue-Id: 332153972AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

syzbot reported a WARN on my patch series [1]. The actual issue is an
overflow of 16-bit UDP length field, and it exists in the upstream code.
My series added a debug WARN with an overflow check that exposed the
issue, that's why syzbot tripped on my patches, rather than on upstream
code.

syzbot's repro:

# {"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false,"callcomments":true}
r0 = socket$pppl2tp(0x18, 0x1, 0x1)
r1 = socket$inet6_udp(0xa, 0x2, 0x0)
connect$inet6(r1, &(0x7f00000000c0)={0xa, 0x0, 0x0, @loopback, 0xfffffffc}, 0x1c)
connect$pppl2tp(r0, &(0x7f0000000240)=@pppol2tpin6={0x18, 0x1, {0x0, r1, 0x4, 0x0, 0x0, 0x0, {0xa, 0x4e22, 0xffff, @ipv4={'\x00', '\xff\xff', @empty}}}}, 0x32)
writev(r0, &(0x7f0000000080)=[{&(0x7f0000000000)="ee", 0x34000}], 0x1)

It basically sends an oversized (0x34000 bytes) PPPoL2TP packet with UDP
encapsulation, and l2tp_xmit_core doesn't check for overflows when it
assigns the UDP length field. The value gets trimmed to 16 bites.

Add an overflow check that drops oversized packets and avoids sending
packets with trimmed UDP length to the wire.

syzbot's stack trace (with my patch applied):

len >= 65536u
WARNING: ./include/linux/udp.h:38 at udp_set_len_short include/linux/udp.h:38 [inline], CPU#1: syz.0.17/5957
WARNING: ./include/linux/udp.h:38 at l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline], CPU#1: syz.0.17/5957
WARNING: ./include/linux/udp.h:38 at l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327, CPU#1: syz.0.17/5957
Modules linked in:
CPU: 1 UID: 0 PID: 5957 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:udp_set_len_short include/linux/udp.h:38 [inline]
RIP: 0010:l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline]
RIP: 0010:l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327
Code: 0f 0b 90 e9 21 f9 ff ff e8 e9 05 ec f6 90 0f 0b 90 e9 8d f9 ff ff e8 db 05 ec f6 90 0f 0b 90 e9 cc f9 ff ff e8 cd 05 ec f6 90 <0f> 0b 90 e9 de fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 4f
RSP: 0018:ffffc90003d67878 EFLAGS: 00010293
RAX: ffffffff8ad985e3 RBX: ffff8881a6400090 RCX: ffff8881697f0000
RDX: 0000000000000000 RSI: 0000000000034010 RDI: 000000000000ffff
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520007acf00 R12: ffff8881baf20900
R13: 0000000000034010 R14: ffff8881a640008e R15: ffff8881760f7000
FS:  000055557e81f500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000033000 CR3: 00000001612f4000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 pppol2tp_sendmsg+0x40a/0x5f0 net/l2tp/l2tp_ppp.c:302
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 sock_write_iter+0x503/0x550 net/socket.c:1195
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_writev+0x33c/0x990 fs/read_write.c:1059
 do_writev+0x154/0x2e0 fs/read_write.c:1105
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f636479c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffd4241c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f6364a15fa0 RCX: 00007f636479c629
RDX: 0000000000000001 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f6364832b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6364a15fac R14: 00007f6364a15fa0 R15: 00007f6364a15fa0
 </TASK>

[1]: https://lore.kernel.org/all/20260226201600.222044-1-alice.kernel@fastmail.im/

Reported-by: syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/l2tp/l2tp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c89ae52764b8..157fc23ce4e1 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,6 +1290,11 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
 		udp_len = uhlen + session->hdr_len + data_len;
+		if (udp_len > U16_MAX) {
+			kfree_skb(skb);
+			ret = NET_XMIT_DROP;
+			goto out_unlock;
+		}
 		uh->len = htons(udp_len);
 
 		/* Calculate UDP checksum if configured to do so */
-- 
2.53.0


