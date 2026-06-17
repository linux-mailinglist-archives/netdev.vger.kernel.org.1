Return-Path: <netdev+bounces-300096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcTtNxFqMmqmzgUAu9opvQ
	(envelope-from <netdev+bounces-300096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FDB697F98
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:34:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=GDzTPIFV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300096-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300096-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACBD7300A8ED
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A943A05E5;
	Wed, 17 Jun 2026 09:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E032EEE68
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688586; cv=none; b=cQH0HJ8IfOachNtbNjLIh8JP7aYQMrrrougZQxIv2OrAkMkLrmdrNBvUOFw6vNLc5K2dVJUy1AtKbMuFKYz6Zqa9pt/kZ7x8T5rpMKGdQjQfBvx4hny0ZWLBmahw9pd4p8t9rl7c4P8U08XgLPimFQ/Rz1TuWGxiUg3BMjtAcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688586; c=relaxed/simple;
	bh=pyATliTpfWaaQh4bFAVc4oEZRXJXSOrus89wZGXBaZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKCd2xydMqG4uZQ7c5uxRToxKOvXGx1Ld+EN+aGoVgX7JNzl9T1LfP0HquVfZsZLwaRMe1cYlHaz4RxaSy4bDLXsamKWj7FyWIfSPFvPhQgaNH8WCFqSeTMsbBbZMPfsViVQvGdSs8PeLPUXXsaIPtP82S+Wjrl6fmuYXXJRFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GDzTPIFV; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eA
	WVcnDMx2NvAqoSFZhUA4bzZvn048SySCNTWfBrv58=; b=GDzTPIFVMiKDz3t9Af
	IAPEt1/Rf/SWcLDZ68awEcyzCc78SVXqLpux6xJCkWVdeO+z1lKGFg+tpHMCmGm4
	LEjMdhr989mOKXGz8WauuSMYK6LB64mLr1ZcVKi4Yf71yPFQ8llr3KsxAotvbmwL
	2dvIxcWr05BaVeoNh1EXkaJxk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXPKrYaDJq95miDw--.47510S2;
	Wed, 17 Jun 2026 17:28:57 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net-next v1] net: wangxun: don't advertise IFF_SUPP_NOFCS
Date: Wed, 17 Jun 2026 17:28:54 +0800
Message-Id: <20260617092854.133992-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXPKrYaDJq95miDw--.47510S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rAr18uw47Aw18ur1fCrg_yoW8Aw18pa
	n5AFyfZ3W8Jr17XayxJwsYvFWSqay2qry8CrW2yw4rZr15ArZ8CFWUWFWUWr98G3yUZF1S
	yF1jyFZrA3Z8X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBBTrUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hl34moyaNmktAAA3L
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300096-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33FDB697F98

From: Rongguang Wei <weirongguang@kylinos.cn>

Like commit a24162f18825("i40e: don't advertise IFF_SUPP_NOFCS"),
ngbe and txgbe also advertises IFF_SUPP_NOFCS and allowing users
to use the SO_NOFCS socket option. But the driver does not check
skb->no_fcs, so this option is silently ignored.

With this change, send() fails with -EPROTONOSUPPORT when AF_PACKET
socket is set SO_NOFCS option.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index d8e3827a8b1f..1e4ebac8e495 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -713,7 +713,6 @@ static int ngbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_GRO;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8b7c3753bb6a..db9262b00a66 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -801,7 +801,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_RX_UDP_TUNNEL_PORT;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
-- 
2.25.1


