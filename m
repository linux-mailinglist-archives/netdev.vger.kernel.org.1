Return-Path: <netdev+bounces-159271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D6A14F4E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CC16842C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6851FF1CB;
	Fri, 17 Jan 2025 12:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F81FF1C6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117590; cv=none; b=CTfHI6m91MI0AXA1f4r5hVECZoX38uDLd5j2VpGLvbaCXZTpdFbELWKLQO6H/26jW8Wu7OamEP6y8LdkITTPLW9MZCU/ZenTB0UiSelYuEkwu6RENWZ3ypL8hD361JHyj7G0xb8PErMxrle+eF9eBs3+IO61LiXiFKuA2PXLLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117590; c=relaxed/simple;
	bh=z9JsqR+YlqGDQQ43x2BQQRmy98JfOR9J1PTG+z4jFZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWguTaLjWr00Xc6ufEPNJDfFH4+WpUuiym0/BtDIldDOe9V/LCnLM6+txsDgGYxZhbHdGyNboP/2/cScfh89tmwQ9l4nmN53bRrkZxk9QqGiCB2CtKDm0Tu9JlskzpKFjQGZ29ZF/+t63DPCLmc82e44ibxhMBqGZd5O/ujgYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5973C90d8A96Dd71a2E03f697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1C319FA365;
	Fri, 17 Jan 2025 13:39:47 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 09/10] MAINTAINERS: mailmap: add entries for Antonio Quartulli
Date: Fri, 17 Jan 2025 13:39:09 +0100
Message-Id: <20250117123910.219278-10-sw@simonwunderlich.de>
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

From: Antonio Quartulli <antonio@mandelbit.com>

Update MAINTAINERS and link my various emails to
my company email address in .mailmap.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 .mailmap    | 7 +++++++
 MAINTAINERS | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 41aca254671d..d55b94d1fe0b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -83,6 +83,13 @@ Anirudh Ghayal <quic_aghayal@quicinc.com> <aghayal@codeaurora.org>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@meshcoding.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
+Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
 Anup Patel <anup@brainfault.org> <anup.patel@wdc.com>
 Archit Taneja <archit@ti.com>
 Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index c5e909a759e6..07206a6a1be5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3869,7 +3869,7 @@ F:	drivers/platform/x86/barco-p50-gpio.c
 BATMAN ADVANCED
 M:	Marek Lindner <marek.lindner@mailbox.org>
 M:	Simon Wunderlich <sw@simonwunderlich.de>
-M:	Antonio Quartulli <a@unstable.cc>
+M:	Antonio Quartulli <antonio@mandelbit.com>
 M:	Sven Eckelmann <sven@narfation.org>
 L:	b.a.t.m.a.n@lists.open-mesh.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.39.5


