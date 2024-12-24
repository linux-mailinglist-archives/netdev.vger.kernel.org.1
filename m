Return-Path: <netdev+bounces-154156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9229FBB6D
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 10:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AC87A1198
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36471AF0A4;
	Tue, 24 Dec 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XY/0N3M5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com [45.254.49.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18221917F0;
	Tue, 24 Dec 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033299; cv=none; b=WJ8IjXUN5st/Fo3B+XaLXzYz67AGMb/JidEmFNDmPHC2ynkiHl7t8o9/L6FTCL+Z5y/ctuUQwvJD9QdScaRP0RwyySG4/nbZ0xrNudbx4nkew88XzOdiAreoZP6pPAYOFSf49AfXudvxAnhSepDqBb6dSH/AXWvWz+FjKkMyJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033299; c=relaxed/simple;
	bh=+Yq5IWFfcXYSmZOel3A4sTWDzb6poyihGZ2Ua4UH/ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6XasbJMz0uaiZ7xE1uSbluytkKhdyDQqkR8+0m0rOzTKFxEsHyKxf2jS9be23c2SgM2UaxwBy1J6/AGbj49ujGmCjjUYVvz4VLQWaqScKJ9KP6DWeNKQtOPLlT6cHF7/ifoKo87YRW0hPIFEmqZikaJKsiD8o30tAY61NOFGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XY/0N3M5; arc=none smtp.client-ip=45.254.49.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aaa2b8d;
	Tue, 24 Dec 2024 17:41:26 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Wu <david.wu@rock-chips.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 1/3] dt-bindings: net: Add support for rk3562 dwmac
Date: Tue, 24 Dec 2024 17:41:22 +0800
Message-Id: <20241224094124.3816698-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhNGVZOS0JMQhgZShlOS0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f80af00403afkunm6aaa2b8d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Vio5CjIUHEpCSzEwNyoT
	PDMaCgtVSlVKTEhOS0hISUNDSElCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT09JNwY+
DKIM-Signature:a=rsa-sha256;
	b=XY/0N3M5A6L7642T0X1zwP6OTOLoD6VvWemimNXCabm7r4P44RY7mOp0LvHRdplIG9giWyaP95yNkvkJcgKLd04CD0e5/ueCTZsVS5J5MUspKt9LE+gAlEGfXdtfyc4tlYrXy/ZT1/YDS22uzpuB6kxcDTxOl69V4QnTECVmjFE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=q6BdkQMdj09o03ihlV4EVZ1rDVGa/oO7ynJUc37C9ZI=;
	h=date:mime-version:subject:message-id:from;

Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
devices on the rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..02b7d9e78c40 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -24,6 +24,7 @@ select:
           - rockchip,rk3366-gmac
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
+          - rockchip,rk3562-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
@@ -49,9 +50,11 @@ properties:
               - rockchip,rk3366-gmac
               - rockchip,rk3368-gmac
               - rockchip,rk3399-gmac
+              - rockchip,rk3562-gmac
               - rockchip,rv1108-gmac
       - items:
           - enum:
+              - rockchip,rk3562-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
@@ -59,7 +62,7 @@ properties:
           - const: snps,dwmac-4.20a
 
   clocks:
-    minItems: 5
+    minItems: 4
     maxItems: 8
 
   clock-names:
-- 
2.25.1


