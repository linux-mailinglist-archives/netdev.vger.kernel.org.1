Return-Path: <netdev+bounces-297291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXojHlCEKGqwFgMAu9opvQ
	(envelope-from <netdev+bounces-297291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2306643B2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:23:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=rf14UBJq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297291-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFE6300EF99
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F33E44E6;
	Tue,  9 Jun 2026 21:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4F3EB0E2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040168; cv=none; b=ljpASldUbhyj/F6HmCBb3kRzmTAj8msrQ550hBAp5C60rRGojTjPj6JZZH76dYAOCoK8DvXiZVW0WFzk1RtKnOHidU8KvhhCWOug1nY6WyPiQMXxZJiEEV1n/nkuhz9x3klM17rjYx83Q32nry546eTaPl0VciNStiosJ8+hPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040168; c=relaxed/simple;
	bh=LUeggJ/64MehnHBA7jK2BI89+qkyaD0W0waQ46EtdPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BE+D6kVgdSvaMKgbygaqkRJw8KYw5n/SKn72M2PzlE+M1vY+AX4be+pIrw7OAzKUmAE0mxnqlrHVJ9TIT2hNvifGRPeWJuDeU4HUNEPKsQ1IvItg7xR8OoMUMQisi1SydDL1Wn5jtrspcqIMNnQdP+FwB5ns0YyAvXhF1uJi0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rf14UBJq; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LzLR/RUWxLXZoToYOAt3UPEo11neY3a1htFl6RLjEBg=; b=rf14UBJq140CEv+99ALY84XIzd
	P0IFC707Okzs/enJ/DYFaNWQ4rzffMNdC+KBHRYeDSytcd7u0ZeJaaInMfkA5ahOJv3gqJuWF+3tC
	wN21O80x5dgo6kxwhelhKXuewZWTklbxHiCJs4obuumI9BHCpIJ7FSMQ4lW2s4f9iBgQpnPKp9wlw
	0brGWA8ctbl4XP/zcQd5oTtX3suTpZT2UYtAsKyHOkXyFJyf9c9DdZT1lCGS6ontGR5slwaQhbf3x
	WES+1LJh/Zr9YijTbldcivFul0KOz8v9k+epRzdHHV9bPeMUUmc8qaeN4rOREV7OHQlVvVR0YPbYE
	U/SiDvYQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wX3uD-000Ldc-23;
	Tue, 09 Jun 2026 23:22:41 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	ahmedabdelmoumen05@gmail.com,
	netdev@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next] net: Stop leased rxq before uninstalling its memory provider
Date: Tue,  9 Jun 2026 23:22:40 +0200
Message-ID: <20260609212240.677889-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28026/Tue Jun  9 08:25:31 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297291-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:ahmedabdelmoumen05@gmail.com,m:netdev@vger.kernel.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[blackwall.org,gmail.com,vger.kernel.org,meta.com,davidwei.uk];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime,davidwei.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB2306643B2

netif_rxq_cleanup_unlease() tears down the memory provider that was
installed on a physical RX queue through a netkit queue lease. It
currently revokes the provider's DMA mappings before stopping the
physical queue:

  __netif_mp_uninstall_rxq(virt_rxq, p);            /* DMA unmap */
  __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);  /* queue stop */

This inverts the ordering used by the regular teardown paths (normal
device unregister and the io_uring zcrx close path), which stop the
queue before revoking the provider's mappings.

With the physical queue still live, its NAPI can keep consuming
net_iov entries from the page_pool alloc cache after the
__netif_mp_uninstall_rxq() has already cleared their dma_addr,
opening a window for the device to DMA to a stale or zero address.

Fix it by swapping the two calls so the queue is stopped (and its
NAPI quiesced) before the provider is uninstalled. No functional
regression was observed across repeated runs of the nk_qlease.py
HW selftest, which exercises the lease teardown path; this was
tested against fbnic QEMU emulation.

Fixes: 5602ad61ebee ("net: Proxy netif_mp_{open,close}_rxq for leased queues")
Reported-by: Ahmed Abdelmoemen <ahmedabdelmoumen05@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: David Wei <dw@davidwei.uk>
---
 net/core/netdev_rx_queue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index de4dac4c88b3..00a7011eb4d5 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -338,12 +338,12 @@ void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
 void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
 			       struct netdev_rx_queue *virt_rxq)
 {
-	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
 	unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
+	struct pp_memory_provider_params p = phys_rxq->mp_params;
 
-	if (!p->mp_ops)
+	if (!p.mp_ops)
 		return;
 
-	__netif_mp_uninstall_rxq(virt_rxq, p);
-	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
+	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
+	__netif_mp_uninstall_rxq(virt_rxq, &p);
 }
-- 
2.43.0


