Return-Path: <netdev+bounces-271113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KxqLhimwmmsiwQAu9opvQ
	(envelope-from <netdev+bounces-271113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:56:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A630A8F4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D183180C1C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D74014B0;
	Tue, 24 Mar 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7iAhT65"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D63FFAB2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363627; cv=none; b=Mx7f+v4hyR0MCEV2hjiKQaUNQls30giklQ1fGWbNG9Z56+rtNwRLVuq1AaU19A9b3AwHJRYpnGYdrdRxHu9ev0m7ubEOCmKSY3HkHklwqwvO6f9sfC5pkGiguiRSECEAm7knr0BD6g781PlK7ZpunyjJaeA0h7fLGpX0NPLgUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363627; c=relaxed/simple;
	bh=RHr+p+NJnyXnFaXgOkYd6TPAzRp0iVa/ExZnygRFp5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm7n2vqLftdaxsX20h7qB3rJCgZR5b/SLuPEsjCFW8Emkj0HA7QYokBwVrR+0wAFkn1kx0O7jrHjWbvTV0tV2Y6UYePS5hrN2bgPPENfmmzM1Y2stIlKiG3vljA99u1PTmFXwTeTfdJ1xX3YKLfWtcZWa4turjD4OuB4c8G+HNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7iAhT65; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8z0UgAXupqavXsuuN5PnUogUWGbsdMwKt2VfNlKKxU=;
	b=w7iAhT651RgNSlqI5hq0vDx5D+7cLrgs3dbFqu31rlh1+6Ir7V2GHWLMFwK7tnBWV+3VE2
	gHvYJPIdGhb5O7xbxJv5Rer6mcR/qcGI/q1NJqAtKWpNRGH84cbDcbxRXO48Q9jUylHFOe
	9+DkxAC6WqpwayW+/DKdYLP1rroYh/I=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 6/7] net: hsr: add missing blank lines after function declarations
Date: Tue, 24 Mar 2026 15:46:29 +0100
Message-ID: <20260324144630.189094-7-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-271113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 070A630A8F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Add missing blank lines after the inline function declarations to
comply with the kernel coding style guidelines.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_main.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 134e4f3fff60..202dc90bd2ab 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -143,6 +143,7 @@ static inline void set_prp_lan_id(struct prp_rct *rct, u16 lan_id)
 	rct->lan_id_and_LSDU_size = htons((ntohs(rct->lan_id_and_LSDU_size) &
 					  0x0FFF) | (lan_id << 12));
 }
+
 static inline void set_prp_LSDU_size(struct prp_rct *rct, u16 LSDU_size)
 {
 	rct->lan_id_and_LSDU_size = htons((ntohs(rct->lan_id_and_LSDU_size) &
@@ -277,24 +278,36 @@ static inline bool prp_check_lsdu_size(struct sk_buff *skb,
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
+
 void hsr_debugfs_rename(struct net_device *dev);
 void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev);
 void hsr_debugfs_term(struct hsr_priv *priv);
 void hsr_debugfs_create_root(void);
 void hsr_debugfs_remove_root(void);
+
 #else
+
 static inline void hsr_debugfs_rename(struct net_device *dev)
 {
 }
+
 static inline void hsr_debugfs_init(struct hsr_priv *priv,
 				    struct net_device *hsr_dev)
-{}
+{
+}
+
 static inline void hsr_debugfs_term(struct hsr_priv *priv)
-{}
+{
+}
+
 static inline void hsr_debugfs_create_root(void)
-{}
+{
+}
+
 static inline void hsr_debugfs_remove_root(void)
-{}
+{
+}
+
 #endif
 
 #endif /*  __HSR_PRIVATE_H */
-- 
2.53.0


