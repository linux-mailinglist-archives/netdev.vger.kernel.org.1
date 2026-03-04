Return-Path: <netdev+bounces-263816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MXyA0kzqGl2pwAAu9opvQ
	(envelope-from <netdev+bounces-263816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:27:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE4200674
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D8A307F0B1
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79853303A26;
	Wed,  4 Mar 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="ApHAy2fd";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="mAvKWwwq"
X-Original-To: netdev@vger.kernel.org
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4E1A00F0;
	Wed,  4 Mar 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630608; cv=none; b=fR5DMrBd0V67ghh3iRmRenCBHyijZO3C2SRD43Tx1bEav95JRffOYtdMF2UZGe9Iqa/SuuSPmTbOOnPZCTi1b8mU+2l2kCul4IGR6sfbjfZvSy1pJmpNqcFiTDNnayYI9buVUEHu6IGAZbwmsc1l20Nrvc0ZF+xH1nz9ZFiLJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630608; c=relaxed/simple;
	bh=+tFYhEAvXk9kMk9jXbCju1yKoTyIcMyFbmV3K8OXvN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcfCSgRHC+FhbBHYPOezCIvgf3Mm4EKsBBC7KNsroRigJLJJzXyNBEBx0Vk1/PkhqqRaXmQgTUaYq9BOLCWkCeyLSj9Y6R/DfOB5taIxE35ZVPKQxJGbU5LqUcZR1ZlrfJTdTFiU8xtVKa459cTYHmBHSvp4tLLy5rWeGR9zOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=ApHAy2fd; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=mAvKWwwq; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1772630073;
	bh=pWqNE5JfL+eGFQBgDauB8plhBy67CVQTUEL9xMK1N2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ApHAy2fdY7hw64WcefWLTaEUFb3j/tUOkcqh7ab/xXa3zeUvQuxnU3spguKS9rwX8
	 zdPrbG0bD3Ha7I164/v2BmmzNCsluhQeaQ9VRHzPNte36il8b2TsuUA1MXZlY25Ore
	 get+WUn5F7DhIGLLWvPOntE/6QutIBmu46NSuUkvXlfUupidgtq5MHDsN5TbXKD64g
	 Vpnv/QPxSXcgH6ZlMrlO7q70u3geVm0iEgozhj1UwBUZ/Ycz4y+l3RyWXDlPddw5eW
	 zq5PcztdTQxtwCXF4onAARf2k3maf2yNCaXWXppfZ4NSkA6o1Gtdi+It4phkM4ubYV
	 E2/kZBY+mA2WQ==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 13156E843A8;
	Wed,  4 Mar 2026 16:14:33 +0300 (MSK)
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx9.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id DA0DDE83F6C;
	Wed,  4 Mar 2026 16:14:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1772630065;
	bh=pWqNE5JfL+eGFQBgDauB8plhBy67CVQTUEL9xMK1N2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mAvKWwwq4rh+E8DF6d3HuYLZ+Vu2JJtKerXP+h2bUfg0RXJo9IB4osA0X2fFa02oQ
	 7x3ca3jeoHZArZd/b41K/SMGt3yt4988pU2Z/IMzfg6b45bbTtJkRLhoNzOtV2lBFr
	 BKGps/MiBMltEaQvQbdtuJ1/BnHOxhCDQJvSFZsmTltgXAX/dAGeGUmbiRcsp2VZ2U
	 NbYMFk90ymY1nS2ce4m4cF2l9SebWpjdhZ84M5r0/CYEHXpFCBm4FlSXicNYQh4hhJ
	 iu11gWyKNb0vB2T5DwwJ5tDpC9/3sCh8u81V3eqXc3uONpU3bCrqQB9Nu46HxfcS6m
	 s8w4w8oEtBfDw==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id 05CF78A090C;
	Wed,  4 Mar 2026 16:14:25 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 6DE8E8A082B;
	Wed,  4 Mar 2026 16:14:24 +0300 (MSK)
Received: from Votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 4 Mar
 2026 16:14:23 +0300
From: Votokina Victoria <Victoria.Votokina@kaspersky.com>
To: Roopa Prabhu <roopa@nvidia.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Nikolay Aleksandrov
	<nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, <bridge@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+263426984509be19c9a0@syzkaller.appspotmail.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
Subject: [PATCH 5.10] net: bridge: mcast: wait for previous gc cycles when removing port
Date: Wed, 4 Mar 2026 16:14:06 +0300
Message-ID: <20260304131408.2196541-1-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/04/2026 12:54:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 201061 [Mar 04 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: Victoria.Votokina@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 88 0.3.88
 cf79c71dc438a5d750ce7f66bc9a19dbc08dac54
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: syzkaller.appspot.com:7.1.1,5.0.1;kaspersky.com:7.1.1,5.0.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/04/2026 12:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/4/2026 10:24:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/03/04 11:42:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/03/04 04:51:00 #28247321
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/03/04 12:55:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Rspamd-Queue-Id: 66FE4200674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Victoria.Votokina@kaspersky.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263816-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,msgid.link:url,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kaspersky.com:dkim,kaspersky.com:email,kaspersky.com:mid];
	TAGGED_RCPT(0.00)[netdev,263426984509be19c9a0];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Victoria Votokina <Victoria.Votokina@kaspersky.com>

From: Nikolay Aleksandrov <razor@blackwall.org>

commit 92c4ee25208d0f35dafc3213cdf355fbe449e078 upstream.

syzbot hit a use-after-free[1] which is caused because the bridge doesn't
make sure that all previous garbage has been collected when removing a
port. What happens is:
      CPU 1                   CPU 2
 start gc cycle           remove port
                         acquire gc lock first
 wait for lock
                         call br_multicasg_gc() directly
 acquire lock now but    free port
 the port can be freed
 while grp timers still
 running

Make sure all previous gc cycles have finished by using flush_work before
freeing the port.

[1]
  BUG: KASAN: slab-use-after-free in br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
  Read of size 8 at addr ffff888071d6d000 by task syz.5.1232/9699

  CPU: 1 PID: 9699 Comm: syz.5.1232 Not tainted 6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
   print_address_description mm/kasan/report.c:377 [inline]
   print_report+0xc3/0x620 mm/kasan/report.c:488
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
   call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1843 [inline]
   __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
   __run_timer_base kernel/time/timer.c:2428 [inline]
   __run_timer_base kernel/time/timer.c:2421 [inline]
   run_timer_base+0x111/0x190 kernel/time/timer.c:2437

Reported-by: syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=263426984509be19c9a0
Fixes: e12cec65b554 ("net: bridge: mcast: destroy all entries via gc")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20240802080730.3206303-1-razor@blackwall.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Victoria Votokina <Victoria.Votokina@kaspersky.com>
---
Backport fix for CVE-2024-44934
 net/bridge/br_multicast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e5328a2777ec..226183dedcbe 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1618,16 +1618,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
-	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
-	br_multicast_gc(&deleted_head);
+	flush_work(&br->mcast_gc_work);
 	del_timer_sync(&port->multicast_router_timer);
 	free_percpu(port->mcast_stats);
 }
-- 
2.43.0


