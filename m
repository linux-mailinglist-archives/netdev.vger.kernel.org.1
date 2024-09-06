Return-Path: <netdev+bounces-125810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2996EC16
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141CC286BEC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8014C592;
	Fri,  6 Sep 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS9wbFiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933214C5B5
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608185; cv=none; b=hEewyzRleGrRDunTr7tePMuLvyiXygb2gxn056xLogaDAAN+59aYyK2dV5DiYrhWfUQlrSZXEnl/U8mw59s95yRK3YWNLFCyFy3xT3kEtJamxMbWiwlKaWt8OT9husCv4gqdK7mqA+FlFUZr7XPpyBsk2IaoT6WTLadl87xnA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608185; c=relaxed/simple;
	bh=IVs3jg4xfvp3xC/+TS4BH1hBY45L8axLBPSWK8AyGlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kiIdAsXeGURpc1qPbGdxzhg1VKiEvo5Z/brgl/ioby0Rx+yGVMCWhY3zlU0y7HwNBhlnxX06H+iO/IKb4DUjWi7PWl8Y7tUxQtF+brT7ArLhFH5AgC8R1l5cviaL6fCLwn0g26EFaz35voaI7XQI1WH0sNy4+geYwh+HZc3cCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS9wbFiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A110C4CEC4;
	Fri,  6 Sep 2024 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725608183;
	bh=IVs3jg4xfvp3xC/+TS4BH1hBY45L8axLBPSWK8AyGlI=;
	h=From:Date:Subject:To:Cc:From;
	b=aS9wbFiIKtHmc/fkd0zZddWZgFNQmkesZVXsFJUH13P7mhVJNaXlkXYmiTcQqlhCo
	 F7YXtuWlvyUyWE6OdWj6seuCh1yceBPpCGpb7K9+RliOlcEBjlEe6xGxXIptAaHzVG
	 tXAMx33V2/wQ6QW1schnyyrPf/lFqtBVMyyORowbSv1NcspOhG4DWOvsd8mAfDJl6L
	 uc3kDQVvuaCOuPa637ZCgXMwCMdJKfStNVT59DzVOoL483qdMCOcKFXVf6haUD9Kn/
	 0Bv0sbHkTjIWNIAwmREDPqv8Ad5FBNItKlHE8GQuO81GQpllmZCSAudo385M0NkzC3
	 tw7cN9kSJX3GQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 06 Sep 2024 08:36:09 +0100
Subject: [PATCH net-next] net: ibm: emac: Use __iomem annotation for
 emac_[xg]aht_base
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-emac-iomem-v1-1-207cc4f3fed0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOiw2mYC/x3MQQqDMBBG4avIrB0YU5lQr1JcBP3bziJREimC5
 O6GLr/FexcVZEOhqbso42fFttQw9B0t35A+YFubyYkb5SnKiGFh2yIiaxAZHurUq6cW7BlvO/+
 zFyUcnHAeNNd6A/F9XKJmAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Rosen Penev <rosenp@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

dev->emacp contains an __iomem pointer and values derived
from it are used as __iomem pointers. So use this annotation
in the return type for helpers that derive pointers from dev->emacp.

Flagged by Sparse as:

.../core.c:444:36: warning: incorrect type in argument 1 (different address spaces)
.../core.c:444:36:    expected unsigned int volatile [noderef] [usertype] __iomem *addr
.../core.c:444:36:    got unsigned int [usertype] *
.../core.c: note: in included file:
.../core.h:416:25: warning: cast removes address space '__iomem' of expression

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/emac/core.c | 2 +-
 drivers/net/ethernet/ibm/emac/core.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index a19d098f2e2b..6ace55837172 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -418,8 +418,8 @@ static int emac_reset(struct emac_instance *dev)
 
 static void emac_hash_mc(struct emac_instance *dev)
 {
+	u32 __iomem *gaht_base = emac_gaht_base(dev);
 	const int regs = EMAC_XAHT_REGS(dev);
-	u32 *gaht_base = emac_gaht_base(dev);
 	u32 gaht_temp[EMAC_XAHT_MAX_REGS];
 	struct netdev_hw_addr *ha;
 	int i;
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 295516b07662..d8664bd65e1f 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -400,7 +400,7 @@ static inline int emac_has_feature(struct emac_instance *dev,
 	((u32)(1 << (EMAC_XAHT_WIDTH(dev) - 1)) >>	\
 	 ((slot) & (u32)(EMAC_XAHT_WIDTH(dev) - 1)))
 
-static inline u32 *emac_xaht_base(struct emac_instance *dev)
+static inline u32 __iomem *emac_xaht_base(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	int offset;
@@ -413,10 +413,10 @@ static inline u32 *emac_xaht_base(struct emac_instance *dev)
 	else
 		offset = offsetof(struct emac_regs, u0.emac4.iaht1);
 
-	return (u32 *)((ptrdiff_t)p + offset);
+	return (u32 __iomem *)((__force ptrdiff_t)p + offset);
 }
 
-static inline u32 *emac_gaht_base(struct emac_instance *dev)
+static inline u32 __iomem *emac_gaht_base(struct emac_instance *dev)
 {
 	/* GAHT registers always come after an identical number of
 	 * IAHT registers.


