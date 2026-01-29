Return-Path: <netdev+bounces-254927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IJzKYnfe2kdJAIAu9opvQ
	(envelope-from <netdev+bounces-254927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E29B5520
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C168730440B2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0136BCEA;
	Thu, 29 Jan 2026 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i2ajgoHa"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACF36B05C;
	Thu, 29 Jan 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725737; cv=none; b=SZAz4RSk96RGLRHedWNv0PO3fPvJ349RsqL3Tjfvc24f0MPl1y21q6u7m1w5Akmq2OrGDGBbUGpvndvAHHx7pNvwJHNIBisCbF/KbDQztimE7vk/1ItTPaj1iBk8BgI1n8A2VYJMdyuc3ibQHbguNjpxHL26PiBfGQ/4Q2fqqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725737; c=relaxed/simple;
	bh=t6NYn+S97WCtLc8vlHdtfUuazYfhdxpU01+2dzzzK6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2ETyikdlV/vR6FNDjkLuMCnJWdCm2mbBMNXb4lzh6cHhPxtNMU3ADNGRmP73Vg3aWuRtDcgORRh38Ef47YzxmSEQWoix/bo5Wj5j8TF4mGrybUcguGe0O3P7c8bosXF4x8BKnD1w72KOOcr5a8cm+fJEXNNtvInvo0izc4yqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=i2ajgoHa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fYxF4T/Lyd5+KPn10oIBcA6EjBk3q1jO3e9a8BBGTXM=; b=i2ajgoHaH+K3mXiYjeRdjv35du
	8ej/uyUeuXpQ1wmmCgK5BKXofuUbpl6dvqV7b24X2Q5HYXmidPYmLVDmzdMFJbls5/pEjg1N8DFo4
	czmaLwZ4F0pD1ijBbG/1StcjeqIzBqrTd0kXusyqZ79AeDvSmIOKC50AJlX1eQmZadZPXVqQsZHaj
	9vw4KC0LGmwrPjJq13CV4tafzLerwjnKE88AIwhYF0hlbuaUcuyAGGEfSEgAL66oasQYK+LhGc3m/
	C+MF/JpfWFmKsN6vjnG2elMUQBZx75E+tveUUVY34t3dyKNPRfGeGiTvUUT+bG7KxmBMDTxmTGiao
	7UqZw5aA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVE-0008p8-0F;
	Thu, 29 Jan 2026 23:28:40 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v8 07/16] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Thu, 29 Jan 2026 23:28:21 +0100
Message-ID: <20260129222830.439687-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254927-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid,fomichev.me:email,davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email]
X-Rspamd-Queue-Id: 53E29B5520
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

Extend netdev_queue_get_dma_dev to return the physical device of the
real rxq for DMA in case the queue was leased. This allows memory
providers like io_uring zero-copy or devmem to bind to the physically
leased rxq via virtual devices such as netkit.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/netdev_queues.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index fae92ee090c4..97acf6440829 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -9,16 +9,29 @@
  * @dev:	net_device
  * @idx:	queue index
  *
- * Get dma device for zero-copy operations to be used for this queue.
+ * Get dma device for zero-copy operations to be used for this queue. If the
+ * queue is leased to a physical queue, we retrieve the latter's dma device.
  * When such device is not available or valid, the function will return NULL.
  *
  * Return: Device or NULL on error
  */
 struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
 {
-	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	const struct netdev_queue_mgmt_ops *queue_ops;
 	struct device *dma_dev;
 
+	if (idx < dev->real_num_rx_queues) {
+		struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
+
+		if (rxq->lease) {
+			rxq = rxq->lease;
+			dev = rxq->dev;
+			idx = get_netdev_rx_queue_index(rxq);
+		}
+	}
+
+	queue_ops = dev->queue_mgmt_ops;
+
 	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
 		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
 	else
-- 
2.43.0


