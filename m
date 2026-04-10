Return-Path: <netdev+bounces-277420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNvNBHr22GlJkAgAu9opvQ
	(envelope-from <netdev+bounces-277420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687603D7E96
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E436300574D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509927FB37;
	Fri, 10 Apr 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rCbtdt0G"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966E3115A2
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826369; cv=none; b=Bgwd3Wpy3uf3SxifvYv4aSw4TjEQEsZ6tP8nOd8fB2FK0CK5BM8lkS0OTNxAEDabvvrxaej4t7zEIl5mklA6IraBZmoKAHL9gpGeckq94KgmBw+c7nu+nsPKkgeiBYkUHbkNbPREPfbqIZIlnFdQEUvvJf/ahuYQBG2SK+LHI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826369; c=relaxed/simple;
	bh=ORYuM3h/lTxAJpa+NCrpPCJdaO8ZvwJKIE4ywLIUnq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTQgyRSYSZs7L2eDvNUynBzaIIZegS2AkRky09ag6qXLBKBAIiH1OB6Alg/0epptS3AGwFmghqU2H5Gd504xG3JDJYV9rLt0/+go6mY7u4ICY7G/tH/Kc17VBDzEnjDqDqAGLtliP6oHIvrWjglIdEOzSmrKSINRqXtmVygWezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rCbtdt0G; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=o/SVNpg+b2iJmtBYLO11feFj8XDNEEYRQtXhbTDBq/c=; b=rCbtdt0GMrfFvTyuXsotVbKqV1
	1Ge4ccyy6eXUeD+ByKohZsfGUie2WVatPhzB5QGdobpyi40Qs1g6hewWcjfR1naH8Kx7NXysoTP9k
	8BD3i0l8PjXE0eQ26UrDMeRgSdSkVemYCPMumuX/KQISSt2QDQlTQQ8iprbJT8WKyM8ntNLVp7wd2
	Ha3RLqw2Xordb3wxvW0NijRdHIenef/A2yUwUVFmsdowRXD1ofVb8ecQdW5G48N/ibYWfEgn35vD7
	xgXgjLrX/HMB+IzBXKwbpgQMRh/7ZKvPrKr+cMrtfXnkWWQLVqlX0n1UFwSfI75E02Zjk51G5pQBf
	3SSj1FtA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wBBYh-000FQA-0o;
	Fri, 10 Apr 2026 15:06:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next] net: Rename ifq_idx to rxq_idx in netif_mp_* helpers
Date: Fri, 10 Apr 2026 15:06:02 +0200
Message-ID: <20260410130602.552600-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27967/Fri Apr 10 08:24:45 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277420-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 687603D7E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the leftover ifq_idx parameter naming to rxq_idx to be
consistent with the rest of the file and the header declaration.
Back then this was taken out of the queue leasing series given
the cleanup is independent. No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/20260131160237.07789674@kernel.org
---
 net/core/netdev_rx_queue.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 8771e06a0afe..de4dac4c88b3 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -275,14 +275,14 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+static void __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 				 const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int err;
 
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
 
 	/* Callers holding a netdev ref may get here after we already
 	 * went thru shutdown via dev_memory_provider_uninstall().
@@ -295,28 +295,28 @@ static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
+	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
 	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
-	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
+	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
 
-	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
+	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
 		return;
-	if (!netif_rxq_is_leased(dev, ifq_idx))
-		return __netif_mp_close_rxq(dev, ifq_idx, old_p);
+	if (!netif_rxq_is_leased(dev, rxq_idx))
+		return __netif_mp_close_rxq(dev, rxq_idx, old_p);
 
-	if (!__netif_get_rx_queue_lease(&dev, &ifq_idx, NETIF_VIRT_TO_PHYS)) {
+	if (!__netif_get_rx_queue_lease(&dev, &rxq_idx, NETIF_VIRT_TO_PHYS)) {
 		WARN_ON_ONCE(1);
 		return;
 	}
 	netdev_lock(dev);
-	__netif_mp_close_rxq(dev, ifq_idx, old_p);
+	__netif_mp_close_rxq(dev, rxq_idx, old_p);
 	netdev_unlock(dev);
 }
 
@@ -339,11 +339,11 @@ void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
 			       struct netdev_rx_queue *virt_rxq)
 {
 	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
-	unsigned int ifq_idx = get_netdev_rx_queue_index(phys_rxq);
+	unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
 
 	if (!p->mp_ops)
 		return;
 
 	__netif_mp_uninstall_rxq(virt_rxq, p);
-	__netif_mp_close_rxq(phys_rxq->dev, ifq_idx, p);
+	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
 }
-- 
2.43.0


