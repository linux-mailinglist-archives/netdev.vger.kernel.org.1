Return-Path: <netdev+bounces-205288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D412EAFE0F4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5153754238F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA8271456;
	Wed,  9 Jul 2025 07:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE32701C5;
	Wed,  9 Jul 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044906; cv=none; b=KJZqVMHO9vfH7+z3K0wXea6JQ6D7EgfSg+ksjbB7OixOV25/UhII3hqphiIU4LVK0wXgNpvFYbZH5E2cjIHMtM91+q8A29zJF2mfpCAGH8bFsL6b6ROt9erU35n0moNFGl4sVyKXK4ylOr4WMObWGZ/3rpfl9njnaDHA+VLs7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044906; c=relaxed/simple;
	bh=YQhsnLUMAU7ZH3pjjQGAg2eqdpC5eflBNrsKckB38kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T29rRBNK8IGejsDxzbrhqPhfO/4i/c+F/Tn8SJz2EG1KA8BJNqZYRR/h0Hw9s65B/e3Y/wiWEAZR+NNFQiluRXwZXOD/XK+zrxTVw+8wp0viPjW2NiPfxoWZG48drvFGcysv7m24o9Hx+8XTyXGWtIEUjt97kCHAJm5omsMZWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 15:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 15:08:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [net-next v4 2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
Date: Wed, 9 Jul 2025 15:08:07 +0800
Message-ID: <20250709070809.2560688-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
the ast2600-clock binding header. These are required for proper
reset control of the MAC1 and MAC2 ethernet controllers on the
AST2600 SoC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/clock/ast2600-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 7ae96c7bd72f..f60fff261130 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -122,6 +122,8 @@
 #define ASPEED_RESET_PCIE_DEV_OEN	20
 #define ASPEED_RESET_PCIE_RC_O		19
 #define ASPEED_RESET_PCIE_RC_OEN	18
+#define ASPEED_RESET_MAC2		12
+#define ASPEED_RESET_MAC1		11
 #define ASPEED_RESET_PCI_DP		5
 #define ASPEED_RESET_HACE		4
 #define ASPEED_RESET_AHB		1
-- 
2.34.1


