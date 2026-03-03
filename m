Return-Path: <netdev+bounces-263356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMDZFRYmp2k3fAAAu9opvQ
	(envelope-from <netdev+bounces-263356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD51F5292
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD8E30ABBA8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA50346FD2;
	Tue,  3 Mar 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+pB0rAR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C828314E;
	Tue,  3 Mar 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561750; cv=none; b=ine3I1oixqZTIlO1G7n1VCIgOE7BNyQgND/nAFTf32AqKkOPJRSy0WxKxY8smehfG8TeUhwRXeZChVScRgt4/uA2W93BS7J/uaUPHfDScHZ2Iq5ZDJBaa4fSUH2uS3BOdSw55BYA6x/9iJNi5hBuCAVPO/rKSdtg7lY3bNIu6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561750; c=relaxed/simple;
	bh=8vdI1F6+AEYct1WtP6LjxtoTORydqwvmamGsdLjOBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWJs02j8DHiDdbahb0t6vzg3ULPYKa7gW8da4RqsWgcVNOLQqfM3w3PybO1sl9EzwbB1sFHzpade9SOZuDx1Puns202DfgelWM1qnQxK4PJVmOkSdhhJsImIvWJF419he2mfgT9XXWdhNp/dNQP7RhDY5B6VLFDg1Tly+2JGV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+pB0rAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794FDC19425;
	Tue,  3 Mar 2026 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561750;
	bh=8vdI1F6+AEYct1WtP6LjxtoTORydqwvmamGsdLjOBLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+pB0rARCe+SA7fiV4K2qPDSPoMFq56w3iZ0WsumUWcrntw0m6WUoGeHSkEw6TWAp
	 cilZKRqC8fjMZBM7SqHRETKmMwvLONWBn8RsqiDZWmCVmAgEmEw2jdSHZcjCU58uGI
	 6EMuBMMF6ljsRst0rAuKuhhxaFVkmzmDRtP6UUzKXKKl7vmVF8XyxXOFVmRSh9fhce
	 TRd+ks0E0lJUgfTj9V9dgg8aN926FShFnjz4kn1FvYfkarbkKTINvdDZrPx72zr/Xt
	 /1hHATTYvdyk9n6yX9bc3uZqJ9syoc9QCjk70seK1jubdPYhIHdIWJPtDYt14ACfht
	 pGHAz76hcPtvQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/5] ethtool: Add RSS indirection table resize helpers
Date: Tue,  3 Mar 2026 19:15:29 +0100
Message-ID: <20260303181535.2671734-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7FD51F5292
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263356-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The core locks ctx->indir_size when an RSS context is created. Some
NICs (e.g. bnxt) change their indirection table size based on the
channel count, because the hardware table is a shared resource. This
forces drivers to reject channel changes when RSS contexts exist.

Add helpers to resize indirection tables:

ethtool_rxfh_indir_can_resize() checks whether a table can be resized
without modifying it.

ethtool_rxfh_indir_resize() resizes a raw u32 table in place. Folding
(shrink) requires the table to be periodic at the new size;
non-periodic tables are rejected. Unfolding (grow) replicates the
existing pattern. Sizes must be multiples of each other.

ethtool_rxfh_contexts_resize_all() resizes all non-default RSS
contexts. Validates every context before modifying any, so either all
succeed or none are changed. Sends ETHTOOL_MSG_RSS_NTF per resized
context after releasing rss_lock.

No reallocation is needed because ethtool_rxfh_ctx_alloc() reserves
space for rxfh_indir_space entries, and key_off is based on that
maximum.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |   3 +
 net/ethtool/common.c    | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 798abec67a1b..add7d16ca398 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -214,6 +214,9 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 }
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+int ethtool_rxfh_indir_can_resize(const u32 *tbl, u32 old_size, u32 new_size);
+int ethtool_rxfh_indir_resize(u32 *tbl, u32 old_size, u32 new_size);
+int ethtool_rxfh_contexts_resize_all(struct net_device *dev, u32 new_indir_size);
 
 struct link_mode_info {
 	int	speed;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..8df84ff9efa4 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1204,6 +1204,132 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
 }
 EXPORT_SYMBOL(ethtool_rxfh_context_lost);
 
+static bool ethtool_rxfh_indir_is_periodic(const u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	for (i = new_size; i < old_size; i++)
+		if (tbl[i] != tbl[i % new_size])
+			return false;
+	return true;
+}
+
+/**
+ * ethtool_rxfh_indir_can_resize - Check if an indirection table can be resized
+ * @tbl: indirection table
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ *
+ * Validate that @tbl can be resized from @old_size to @new_size without
+ * data loss. Read-only; does not modify the table.
+ *
+ * Return: 0 if resize is possible, -%EINVAL otherwise.
+ */
+int ethtool_rxfh_indir_can_resize(const u32 *tbl, u32 old_size, u32 new_size)
+{
+	if (old_size == 0 || new_size == 0)
+		return -EINVAL;
+	if (new_size == old_size)
+		return 0;
+
+	if (new_size < old_size) {
+		if (old_size % new_size != 0)
+			return -EINVAL;
+		if (!ethtool_rxfh_indir_is_periodic(tbl, old_size, new_size))
+			return -EINVAL;
+		return 0;
+	}
+
+	if (new_size % old_size != 0)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(ethtool_rxfh_indir_can_resize);
+
+/* Resize without validation; caller must have called can_resize first */
+static void __ethtool_rxfh_indir_resize(u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	/* Unfold (grow): replicate existing pattern; fold is a no-op on the data */
+	for (i = old_size; i < new_size; i++)
+		tbl[i] = tbl[i % old_size];
+}
+
+/**
+ * ethtool_rxfh_indir_resize - Fold or unfold an indirection table
+ * @tbl: indirection table (must have room for max(old_size, new_size) entries)
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ *
+ * Resize an RSS indirection table in place. When folding (shrinking),
+ * the table must be periodic with period @new_size; otherwise the
+ * operation is rejected. When unfolding (growing), the existing
+ * pattern is replicated. Both directions require the sizes to be
+ * multiples of each other.
+ *
+ * Return: 0 on success, -%EINVAL on failure (no mutation on failure).
+ */
+int ethtool_rxfh_indir_resize(u32 *tbl, u32 old_size, u32 new_size)
+{
+	int ret;
+
+	ret = ethtool_rxfh_indir_can_resize(tbl, old_size, new_size);
+	if (ret)
+		return ret;
+
+	__ethtool_rxfh_indir_resize(tbl, old_size, new_size);
+	return 0;
+}
+EXPORT_SYMBOL(ethtool_rxfh_indir_resize);
+
+/**
+ * ethtool_rxfh_contexts_resize_all - Resize all RSS context indirection tables
+ * @dev: network device
+ * @new_indir_size: new indirection table size
+ *
+ * Resize the indirection table of every non-default RSS context to
+ * @new_indir_size. Intended to be called from drivers when the
+ * device's indirection table size changes (e.g. on channel count
+ * change). An %ETHTOOL_MSG_RSS_NTF is sent for each resized context.
+ *
+ * All contexts are validated before any are modified, so either all
+ * contexts are resized or none are.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int ethtool_rxfh_contexts_resize_all(struct net_device *dev, u32 new_indir_size)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int ret;
+
+	if (dev->ethtool_ops->rxfh_indir_space == 0 ||
+	    new_indir_size > dev->ethtool_ops->rxfh_indir_space)
+		return -EINVAL;
+
+	scoped_guard(mutex, &dev->ethtool->rss_lock) {
+		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+			ret = ethtool_rxfh_indir_can_resize(ethtool_rxfh_context_indir(ctx),
+							    ctx->indir_size, new_indir_size);
+			if (ret)
+				return ret;
+		}
+
+		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+			__ethtool_rxfh_indir_resize(ethtool_rxfh_context_indir(ctx),
+						    ctx->indir_size, new_indir_size);
+			ctx->indir_size = new_indir_size;
+		}
+	}
+
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
+		ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);
+
+	return 0;
+}
+EXPORT_SYMBOL(ethtool_rxfh_contexts_resize_all);
+
 enum ethtool_link_medium ethtool_str_to_medium(const char *str)
 {
 	int i;
-- 
2.53.0


