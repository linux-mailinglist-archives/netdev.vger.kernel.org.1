Return-Path: <netdev+bounces-174676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F1EA5FC74
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670BF16CFB6
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2726AA9B;
	Thu, 13 Mar 2025 16:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03426A1C2
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884334; cv=none; b=Mis1RVEtJspM4PN+v5KTy5GPqJ9tXEJkAuYH2Zzqu1NgtiAdOGL99XuNiIQUCSTeqRxdvC4viVvVpmwWGxAK/cBRC1hoyNaQYnRAfr1igZwPRjYSOizJ0XGUMSLsFIKCk2nIMk20UNPx6qFCvRHXzOF57ysAc/bq/P5xH7lIrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884334; c=relaxed/simple;
	bh=IFyCpVSyt8y1o69J6GqZotI2nOXnlB5NZfi2hJq2YQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxJuAeS5Xxe81ObCNW99Qa6hMEkUNpePt+JeVMzupxpEsCYfkvUAzHq6VFfEP/ccw2lyrr5P8yo4GbFK8Wi6c/kmG/XLBVvgPkyQ7ezYstQSx74r79UcJY0eOvruCLXPmDL2R/en8Ik2BWLYdjevC3m5HgJwqp+xGKmyQXk7D7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 51E68FA44C;
	Thu, 13 Mar 2025 17:45:31 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 10/10] batman-adv: add missing newlines for log macros
Date: Thu, 13 Mar 2025 17:45:19 +0100
Message-Id: <20250313164519.72808-11-sw@simonwunderlich.de>
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

Missing trailing newlines can lead to incomplete log lines that do not
appear properly in dmesg or in console output.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 13935570fae1..e7c8f9f2bb1f 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1567,7 +1567,7 @@ void __init batadv_netlink_register(void)
 
 	ret = genl_register_family(&batadv_netlink_family);
 	if (ret)
-		pr_warn("unable to register netlink family");
+		pr_warn("unable to register netlink family\n");
 }
 
 /**
-- 
2.39.5


