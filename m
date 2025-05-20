Return-Path: <netdev+bounces-191784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C8ABD379
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A691B66799
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82A2673BF;
	Tue, 20 May 2025 09:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECC26772A;
	Tue, 20 May 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733652; cv=none; b=f3+gvLTMkWZi+rnroXfVS0DgVSiTkmfqyVjxzUzgAApRV+CT4tdiXorhB0IqOmYfTQjx06XhKDZKFgREKTbJmtcV4GQJyuK5Yh+GG9HN6Nfn/Sb+4/2obS7NMk9MqiTLPUP8htk+YobUBfE94mkWFDD9JmEEHDOD88U+TBzPML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733652; c=relaxed/simple;
	bh=FRainAZFQhLZP/Xlr0ynX1tqGPAyLMHs5QuCWBRlW/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgXqNJ6CPUs5D03h9yKOeWPRPhDzHCs6+6WxjZTy8hwO/q5UPTmoZCemsP8qlkBgZz6HzhXVXrrAXa5EfihiBdci0dvbCprQbQtOaFQ61q1O0JsmfypVvu+WFplEbbHuc0jQeU6ViM2XcPPlytnXdb/Jmaf66d5MmKLdQKJ0CnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 17:28:49 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 17:28:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Date: Tue, 20 May 2025 17:28:45 +0800
Message-ID: <20250520092848.531070-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add optional resets property for Aspeed SoCs to reset the MAC and
RGMII/RMII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..f7af2cd432d3 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -35,6 +35,11 @@ properties:
       - description: MAC IP clock
       - description: RMII RCLK gate for AST2500/2600
 
+  resets:
+    maxItems: 1
+    description:
+      Optional reset control for the MAC controller (e.g. Aspeed SoCs)
+
   clock-names:
     minItems: 1
     items:
-- 
2.34.1


