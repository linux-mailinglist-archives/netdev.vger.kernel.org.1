Return-Path: <netdev+bounces-174669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA719A5FC6B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96281779E1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6B26A0B7;
	Thu, 13 Mar 2025 16:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A33153598
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884328; cv=none; b=OTmLDM+Qv+PwmunZB//b8nVqBD71456FOC+vmro4ZUcAzRBXjsCXkc3cvtjbEUEosFP0bIyHMNk18eklZX8mA6+VR1qYSIrJyVRqfWzuVevfaWL3o9WdtHBld7snkvyhp1su8WESGDSE5JwaT4+xRVRUL2LeRkTjSQ6z4L+RIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884328; c=relaxed/simple;
	bh=6VPIgSjfCqMg6C7IyBxT40xIEgEx+yLtfonjspTmxV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dM8HQf0jAhRTEN8Hsz5mDlfihZTA2dPm3KrNoRfDmf1GY0i1Qy+pPiPgqsnVG2wHx/lqUt57Gy8Ad0k+xl06sJl/4FXc26GYJNaj7Mrul5IiD9Kov/rJ9mbtGZO74Y3qWTzN2zzjMq8R7GcJbMiCz408LHJIfN5M+RtR+QYvkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2F53FFA14B;
	Thu, 13 Mar 2025 17:45:24 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 02/10] batman-adv: Drop batadv_priv_debug_log struct
Date: Thu, 13 Mar 2025 17:45:11 +0100
Message-Id: <20250313164519.72808-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The support for the batman-adv ring buffer for debug logs was dropped with
the removal of the debugfs filesystem. The structure storing this ring
buffer is therefore no longer needed since commit aff6f5a68b92
("batman-adv: Drop deprecated debugfs support")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe89f08533fe..64a0cf4257ed 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1137,29 +1137,6 @@ struct batadv_priv_bla {
 };
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-
-/**
- * struct batadv_priv_debug_log - debug logging data
- */
-struct batadv_priv_debug_log {
-	/** @log_buff: buffer holding the logs (ring buffer) */
-	char log_buff[BATADV_LOG_BUF_LEN];
-
-	/** @log_start: index of next character to read */
-	unsigned long log_start;
-
-	/** @log_end: index of next character to write */
-	unsigned long log_end;
-
-	/** @lock: lock protecting log_buff, log_start & log_end */
-	spinlock_t lock;
-
-	/** @queue_wait: log reader's wait queue */
-	wait_queue_head_t queue_wait;
-};
-#endif
-
 /**
  * struct batadv_priv_gw - per mesh interface gateway data
  */
@@ -1773,11 +1750,6 @@ struct batadv_priv {
 	struct batadv_priv_bla bla;
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-	/** @debug_log: holding debug logging relevant data */
-	struct batadv_priv_debug_log *debug_log;
-#endif
-
 	/** @gw: gateway data */
 	struct batadv_priv_gw gw;
 
-- 
2.39.5


