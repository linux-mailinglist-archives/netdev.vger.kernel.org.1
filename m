Return-Path: <netdev+bounces-252812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMZIKP1Wc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:09:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73974D13
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A673007F5E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E7318B83;
	Fri, 23 Jan 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qyyc1cjV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HG5USzYg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8128727E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166385; cv=none; b=jM7xt30IbBOUj8YPjWXfgK9O7kgfYAUitkDcJZHqxK+Rvin0GcUN5JqqWDrHEUxhP3Ri863njt4Zu2slTr/B9NS9on3Q59ZJFkLLo211fvIPpMs6Oe2MgvwxYtw8x65BHr27nuHRVWsW/jUjTRR6w5thDvO5k0yIoEx++/NbGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166385; c=relaxed/simple;
	bh=MzlowSgIbuZ7K8xe7AVP/LyiAGNaHGqEVltu0g3cI70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPUjaBSf+qzwDAVMcBeIolGNpLE2+arL98oFUFqJWrBLJgQ+4Kt/o6OOkjRzgxz3mtJUKTzzj5RcAdDwnN1o7JUqBWVLa0d3/W3oaJdd4n1zssTD037J9TyYKvN9lo4qY/1k9K1QpEYL1xeUI0mQZM+JJhgfHxaDqkGRYf6Hbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qyyc1cjV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HG5USzYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769166382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A96933Wy8DSA55DiY4Dkr3JJfq/YWobO4t5EL5EgQDk=;
	b=qyyc1cjVtzWX2SWuC8PUqZvotLy7qdKBkvc3FTTXRxB4EmWdoSXEHkUNtsuIpuHr3faegQ
	M3zOHYOChGphv87os2fZnqxXUejjrZVBIz2A/vxxq3X9xzUqzNMawkhjzPuLwwM51FZ2B1
	GFfVQuHU/mM6wDd1kGOlICHnX3GU9/XtnkS162BItZRSBzfkt63pxf6+hj7CLHaBUJkY25
	hpu/eY70ypCs0P4EGSb5/xsIhwIc3f7GIsvAkX9ljkT+b2Oho3f9cfQL26Sl2HYaLml4S/
	KARwlYD8IEAIB1lm6Hmn5NBWudV+Vm9ZtbU6Z+tFSCil0DoELNT+VPvVwISNEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769166382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A96933Wy8DSA55DiY4Dkr3JJfq/YWobO4t5EL5EgQDk=;
	b=HG5USzYgBX6ZmqwdIh5PdOK30/1XiklUOIgJ1WKxYlPFg3kjNN6ENOUFdZ+rTHGkMCdSSK
	hvWTxOnwDol4mZAw==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] declance: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:06:16 +0100
Message-ID: <20260123110616.416384-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252812-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 0A73974D13
X-Rspamd-Action: no action

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT to irqflags.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

lance_dma_merr_int() does nothing but a printk() which means if it is a
level interrupt then once it fires it remains asserted and that printk()
takes over the machine.
I guess it never fires and is just left over debug.

 drivers/net/ethernet/amd/declance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd=
/declance.c
index 8d05a0c5f2d5d..e6d56fcdc1ddd 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -813,7 +813,7 @@ static int lance_open(struct net_device *dev)
 	if (lp->dma_irq >=3D 0) {
 		unsigned long flags;
=20
-		if (request_irq(lp->dma_irq, lance_dma_merr_int, IRQF_ONESHOT,
+		if (request_irq(lp->dma_irq, lance_dma_merr_int, 0,
 				"lance error", dev)) {
 			free_irq(dev->irq, dev);
 			printk("%s: Can't get DMA IRQ %d\n", dev->name,
--=20
2.51.0


