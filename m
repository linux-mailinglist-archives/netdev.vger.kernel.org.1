Return-Path: <netdev+bounces-159264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2FA14F46
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35531188ACD8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD01FF1D8;
	Fri, 17 Jan 2025 12:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962A1FF1C1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117575; cv=none; b=ciGi6/AjxTpOFqAst2DcNd6POM7k2w2oXjDXVxeCRyFJ7eZja9Jmb2Pn7GfszJTPDf9lxdost7fwxSbjeLvfAuH4V2S6c9jmDPre1fPALBFMdngSYdzPfWqEtOcYjdWuc/RBFnadNTLQqG9BfYbd3kofAjOsvDf0pYtyAK4zK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117575; c=relaxed/simple;
	bh=lVzlYqo0AAiRB8Y7iHYECcZgZjk4c05E3QpFk19PthY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=simS/2eYC+6xOCACWgB0TbrVuSAhd+zUlA7h3cjelc7cpsVuq7oEWUVJ/r2145dL4MBbfmoQeSN4j4EirRnAb7PdL6XmGa5WiK+/9GaxKBOWPUZ1EsXto8uccq2ymj0C9ctqCYvqTc4XlqittlegXWaHq1JxcMBxcGaA/w0WypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5973c90d8a96Dd71A2E03F697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 443D5FA197;
	Fri, 17 Jan 2025 13:39:31 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 02/10] batman-adv: Reorder includes for distributed-arp-table.c
Date: Fri, 17 Jan 2025 13:39:02 +0100
Message-Id: <20250117123910.219278-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
changed the include without adjusting the order (to match the rest of the
file).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 801eff8a40e5..48b72c2be098 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -7,7 +7,6 @@
 #include "distributed-arp-table.h"
 #include "main.h"
 
-#include <linux/unaligned.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
@@ -32,6 +31,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/udp.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
-- 
2.39.5


