Return-Path: <netdev+bounces-231171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE74BF5F9A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA7CA4EDF90
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495823AB8E;
	Tue, 21 Oct 2025 11:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592672475CE;
	Tue, 21 Oct 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045402; cv=none; b=YuSHGhvEpylubr5c10pOziWgdl9rFeGFqXrIvNo339rTrb2RKBjoUYdQWAVWBD8pxDot2c7VLMF4qi74Gq7B0oArKic9IJZ8zl1LUKwmSmV1RwcA2qq6SMVclfp09eQgdVWd6258XolGMCes3/ZDLr2jRC2P4vDkn6XG8Dl6y5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045402; c=relaxed/simple;
	bh=8BuiH/dUBddAP6vUVj5UxxarWrOtB+mN9j/SPcZvAOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6sZZmAUAIV5/vM22C42X0peCKFZCkkInvr04NAswv5w+euKBCT+RBBNuxI2vLiomxW1RCU0iACmCU+2sQW1f9F1GGWSAofeMEphmrgXmrw0UO6ttYxqsTjRJdGCvL6q6EZ9zKVA8meKSONJFTADcT9vkh4LNHZoXrR1LBcCKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vBALx-0000000017Y-15ED;
	Tue, 21 Oct 2025 11:16:33 +0000
Date: Tue, 21 Oct 2025 12:16:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v5 1/7] net: dsa: lantiq_gswip: clarify GSWIP 2.2
 VLAN mode in comment
Message-ID: <018056a575503d9797f3222f71a988e825316be0.1761045000.git.daniel@makrotopia.org>
References: <cover.1761045000.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761045000.git.daniel@makrotopia.org>

The comment above writing the default PVID incorrectly states that
"GSWIP 2.2 (GRX300) and later program here the VID directly."
The truth is that even GSWIP 2.2 and newer maintain the behavior of
GSWIP 2.1 unless the VLANMD bit in PCE Global Control Register 1 is
set ("GSWIP2.2 VLAN Mode").
Fix the misleading comment accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 25f6b46957a0..86b410a40d32 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -588,7 +588,11 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
 			  GSWIP_PCE_VCTRL(port));
 
-	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
+	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
+	 * directly instead of referencing the index in the Active VLAN Tablet.
+	 * However, without the VLANMD bit (9) in PCE_GCTRL_1 (0x457) even
+	 * GSWIP 2.2 and newer hardware maintain the GSWIP 2.1 behavior.
+	 */
 	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
 }
 
-- 
2.51.1

