Return-Path: <netdev+bounces-184106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEAA935A7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88188A6DC5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4FE26FD86;
	Fri, 18 Apr 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QWT88Hbv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com [220.197.31.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962026FA5A;
	Fri, 18 Apr 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970195; cv=none; b=daYpd9CrEx9eE/HstpZcYjCDQSsToemF5S92NPTERA2JrO9LZ1uPa7VWptdqeRFbxvatJCwMB07nA2B56oV5LZap+3Ll30QOkd7466ItT14RSe2P783uYeiWUFA6juJYT9bw22DfOdVASvSMtx///SGUaXB+6s6vEpqeYQToW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970195; c=relaxed/simple;
	bh=D4pUJoAC83w3hP6IO7jcxTh2sIPQedcy5b/8ool7+og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0M/FP0V6oX4AS+FRGbVhJZNtO/wyunBaFERC9U1IcHv4Pt0WxfoKJENkbtSBJEpG3Sh/gRzcQzJ3NdzfLlNHBeWoGWO1M2j7K8bxg4721yKQ+b3ffzDy+UuSQ46yT0A3Vioqp1qS81HJNFLSq4Ea/KEE6E7OTNrH9OCG3gcfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QWT88Hbv; arc=none smtp.client-ip=220.197.31.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 125a9718a;
	Fri, 18 Apr 2025 17:51:16 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jose Abreu <joabreu@synopsys.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Wu <david.wu@rock-chips.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: net: Add support for rk3562 dwmac
Date: Fri, 18 Apr 2025 17:51:12 +0800
Message-Id: <20250418095114.271562-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpKSVZDT00ZSUsfTBpDQkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96484f455003afkunm125a9718a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6GTo4DDIMAgouIk4UI0lO
	PzcwCjNVSlVKTE9PQk1CQ0xDTUhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUNLNwY+
DKIM-Signature:a=rsa-sha256;
	b=QWT88HbvamFv90XR9yBLMFnQCm6eCs3/nVDkf5NLLpqNUvkbt1AIkBqXuAaCQDsRrcdrxFk3ooh0W8cI/yLSCihrnL+6gPNC59XfMc8GygwNI6zOfG+hNkmYwnUuKyXDaKEnBAqMGyIAsvvyANtXWZ2Pe0Bis8nHGBiLrzj+wPA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+3Zq6GxI1QoLvi6Yw419evhTpUoxkex9H7YRQ3ne+wo=;
	h=date:mime-version:subject:message-id:from;

Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
devices on the rk3562.
rk3562 only has 4 clocks available for gmac module.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v3:
- Collect ack tag
- rebase to v6.15-rc1

Changes in v2:
- Fix schema entry and add clocks minItem change

 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 0ac7c4b47d6b..a0814e807bd5 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -25,6 +25,7 @@ select:
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
           - rockchip,rk3528-gmac
+          - rockchip,rk3562-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
@@ -51,6 +52,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3528-gmac
+              - rockchip,rk3562-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
@@ -149,6 +151,7 @@ allOf:
             contains:
               enum:
                 - rockchip,rk3528-gmac
+                - rockchip,rk3562-gmac
     then:
       properties:
         clocks:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 78b3030dc56d..7498bcad895a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -83,6 +83,7 @@ properties:
         - rockchip,rk3328-gmac
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
+        - rockchip,rk3562-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
         - rockchip,rk3399-gmac
-- 
2.25.1


