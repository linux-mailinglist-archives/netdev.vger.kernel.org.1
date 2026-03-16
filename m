Return-Path: <netdev+bounces-268058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBTYCZ3Nt2mDVgEAu9opvQ
	(envelope-from <netdev+bounces-268058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8B297031
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC7E300A118
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A755221540;
	Mon, 16 Mar 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="yPWAF7P5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F3876DB
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653301; cv=none; b=kqQwWsj+7Y5ZrO09x8p16Fu2mwFO/YRIf/WER0FRt7FYtFRz9Oxytiqk+im0KIH24PFMV9M+cttO8Oy+EiEwDFIYHi44VH/CI2lFiJsNOqJ1NWuWCmqEHITC0PzXE/7RMZP+mxb4fmjkZmJQKjZyPRs0JOxKdkeRERSillQ/1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653301; c=relaxed/simple;
	bh=QPXKx+Q8rLfqOb5EQuNGVDgs8ztG0qHI87+BHtNhkFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPdgQzwIxc/7orZZsZs0nyFZIWjOZaPIXoj8s+tRJ9WNvOs4NNGWX+WfyxdD4+EDtX++QHFcDeQdxOLInHMyoglmVyaRAE5wrsR8pEIiAs+A3opNfLnhq+GC1b3bunNdnpmxggoT8A4NaCETVR7HshfVznotqJO0Ep6JWgWJUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=yPWAF7P5; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BBD3A574F;
	Mon, 16 Mar 2026 10:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773653293; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pAHHfqIl+64Sx8Dh+IHfjWcT7XYg3APsFIzEKcZDopg=;
	b=yPWAF7P5fQW3qPWdJiuOjo4xfk9U5rl/xWLfDETDCFYWHWUkip0NLcVx2pqcJjLiS53KYw
	/ObKGk0xoP91gFiNkMc3YBZ7boJxIPL8GbyC/GtLwpfSXK5I67ZuY02FA6VmwTawnjOvUS
	SLxkqfEAlhPeGGX/OfBZ8IFRVXE1pzNucYdOENlzv4ednHG9kSkmCTyVB0sdIfh6L6sd5H
	Lji25fKFK1BGpjaio6RiTcZKpYDTXpihhcEgDeUepdk4d7KVvcG09qJF3u73GiDj0GADXr
	3CuyQ2KGcs/SVLw48f/2Wbb0pY8tn/9Mq7RiehA/zideYC1+Q09vOJsytb6uhg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next] net: macb: allow MTU changes while the interface is running
Date: Mon, 16 Mar 2026 10:27:20 +0100
Message-ID: <20260316092720.39198-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-268058-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 92D8B297031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

macb_change_mtu() currently returns -EBUSY if the interface is running,
requiring users to bring the interface down before changing the MTU. This
is unnecessarily restrictive.

Instead, close and reopen the interface around the MTU change so that RX
DMA buffers are reallocated for the new MTU. This is the same approach
used by many other network drivers (e.g. igb, tg3, stmmac).

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5e27e0e87a55..8dd01031250d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
 
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
-	if (netif_running(dev))
-		return -EBUSY;
+	bool was_running = netif_running(dev);
+
+	if (was_running)
+		macb_close(dev);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
 
+	if (was_running)
+		return macb_open(dev);
+
 	return 0;
 }
 
-- 
2.51.0


