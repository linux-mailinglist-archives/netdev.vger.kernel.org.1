Return-Path: <netdev+bounces-43324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0ED7D25F0
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ABE2813D0
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A99111AA;
	Sun, 22 Oct 2023 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IQjrwPxl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED8125BB
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:53:30 +0000 (UTC)
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198CC124
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=41fdQH/ffNpQD3j/yF5QWKflpbrtFGENdcb0zJGbhv4=; b=IQjrwP
	xl/KOxykwnqkWARL6MND8U7bCdgGBsCyKCkRgGZHx0VWhLwGlf0v/pb7kmscVe9O
	01HTguZd2+7q9yCXVW4U0N41/4ug2BRd+1MMbULxBFHUCAuv66UezwOBYFdm8zDp
	vEI70NwLssB60bUXdxySpHpZKmK0ssoybOEd2KT2ECqoJKZQZ4G4YjBfR7IevLTh
	Xlfbt++S6zsNF1ZTkOXMOl0iNQs08avyr3iM0Qc4CR672TwZ5Qys8Ge3vFTICJx1
	8BLJwEvasxmFpR5dVHvf/LJaeIZQAjSzT+J9ylOcqRDKNK1i/1HbMGSikA76GpIe
	SyJYJ67ZrkMsFMeg==
Received: (qmail 1741731 invoked from network); 22 Oct 2023 22:53:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:25 +0200
X-UD-Smtp-Session: l3s3148p1@HGP/S1QIrscujnvq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ethernet: renesas: drop SoC names in Kconfig
Date: Sun, 22 Oct 2023 22:53:16 +0200
Message-Id: <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mentioning SoCs in Kconfig descriptions tends to get stale (e.g. RAVB is
missing RZV2M) or imprecise (e.g. SH_ETH is not available on all
R8A779x). Drop them instead of providing vague information. Improve the
file description a tad while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/renesas/Kconfig | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 3ceb57408ed0..8ef5b0241e64 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Renesas device configuration
+# Renesas network device configuration
 #
 
 config NET_VENDOR_RENESAS
@@ -25,9 +25,6 @@ config SH_ETH
 	select PHYLIB
 	help
 	  Renesas SuperH Ethernet device driver.
-	  This driver supporting CPUs are:
-		- SH7619, SH7710, SH7712, SH7724, SH7734, SH7763, SH7757,
-		  R8A7740, R8A774x, R8A777x and R8A779x.
 
 config RAVB
 	tristate "Renesas Ethernet AVB support"
@@ -39,8 +36,6 @@ config RAVB
 	select PHYLIB
 	help
 	  Renesas Ethernet AVB device driver.
-	  This driver supports the following SoCs:
-		- R8A779x.
 
 config RENESAS_ETHER_SWITCH
 	tristate "Renesas Ethernet Switch support"
@@ -51,7 +46,5 @@ config RENESAS_ETHER_SWITCH
 	select PHYLINK
 	help
 	  Renesas Ethernet Switch device driver.
-	  This driver supports the following SoCs:
-		- R8A779Fx.
 
 endif # NET_VENDOR_RENESAS
-- 
2.35.1


