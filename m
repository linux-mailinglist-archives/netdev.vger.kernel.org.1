Return-Path: <netdev+bounces-48149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D77ECA36
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FAC1C20B71
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D73DBBD;
	Wed, 15 Nov 2023 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4DD4F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:27 -0800 (PST)
Received: from kero.packetmixer.de (p200300FA2706340047Bd8A14B9c54dBb.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0AC86FB5F9;
	Wed, 15 Nov 2023 18:59:42 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/6] batman-adv: Start new development cycle
Date: Wed, 15 Nov 2023 18:59:27 +0100
Message-Id: <20231115175932.127605-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115175932.127605-1-sw@simonwunderlich.de>
References: <20231115175932.127605-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version will contain all the (major or even only minor) changes for
Linux 6.8.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 10007c5894a1..870dcd7f1786 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2023.3"
+#define BATADV_SOURCE_VERSION "2024.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2


