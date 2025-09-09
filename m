Return-Path: <netdev+bounces-221264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFFB4FF4A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2E87B829B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D734AB10;
	Tue,  9 Sep 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5Q6YIpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCD346A0D;
	Tue,  9 Sep 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427845; cv=none; b=Z9/dy8WDex94GztOk7CGDEyRXFKmZDVGqRIWMfVVGTG8DKOmxeeel9e0TnaxZZ9jd4QK7q2+BSWAk/URoT06fUGvRImpzi1T+SO7D6cMm3IpoXOciAgB55/lQIAJ2UILixZdW3uMQkGL4KFltvpPs67qvshUr+ZyL25JhYmwg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427845; c=relaxed/simple;
	bh=3Ghy67T7rreednlZpZASb0jQ54O5/AaKOvr8uv+5f1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmf0Te1u3Gd47lth3NXrS8uuokRxHP4Da2PIeESksOskVoActq2wJhQGHyni84lPZHqoDJ6vwNyUTBVBUU/7vx3/kZ4UqXLJBA8y+yP0h3MyLGssvlvXCna8ANBNAAs2OvyKweo5j2hEWBqDYosOsueC66/wybKhQodj6P6Cdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5Q6YIpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD501C4CEFB;
	Tue,  9 Sep 2025 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757427845;
	bh=3Ghy67T7rreednlZpZASb0jQ54O5/AaKOvr8uv+5f1M=;
	h=From:To:Cc:Subject:Date:From;
	b=k5Q6YIppaLP4l21CgQQhx7MpvPVxzegmVMocXQRCLlW0yxL0Wx4Mh9zzuhSfSig4n
	 Wyl8/IN+ipJ7IrKdPIuedZgvqcd9/oTXrrfNso7QqzGphxjVWMnlEMSL3DgTmtaoQM
	 SJP/rzI/8sWm010DwpHG6NCiXyHniHv8tQ6x4IOqUqrs1FnSd4XDkbgMqkF41JAiTW
	 eQdzFhrBycwILMPW1yus30XzwbhZ1yIlcBYI0XLehIyTM6piUUEsledwcl4iThugdi
	 pZR30BCsilm3c1cg8XrvKRwvcklpOHtc+9lHKnPc5MFnGlhR4BVy67G1WUBMiFFC8Z
	 tzSvnFMFlfHyQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: Drop duplicate brcm,bcm7445-switch-v4.0.txt
Date: Tue,  9 Sep 2025 09:23:38 -0500
Message-ID: <20250909142339.3219200-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The brcm,bcm7445-switch-v4.0.txt binding is already covered by
dsa/brcm,sf2.yaml. The listed deprecated properties aren't used anywhere
either.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/brcm,bcm7445-switch-v4.0.txt | 50 -------------------
 1 file changed, 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt

diff --git a/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt b/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
deleted file mode 100644
index 284cddb3118e..000000000000
--- a/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Broadcom Starfighter 2 integrated switch
-
-See dsa/brcm,bcm7445-switch-v4.0.yaml for the documentation.
-
-*Deprecated* binding required properties:
-
-- dsa,mii-bus: phandle to the MDIO bus controller, see dsa/dsa.txt
-- dsa,ethernet: phandle to the CPU network interface controller, see dsa/dsa.txt
-- #address-cells: must be 2, see dsa/dsa.txt
-
-Example using the old DSA DeviceTree binding:
-
-switch_top@f0b00000 {
-	compatible = "simple-bus";
-	#size-cells = <1>;
-	#address-cells = <1>;
-	ranges = <0 0xf0b00000 0x40804>;
-
-	ethernet_switch@0 {
-		compatible = "brcm,bcm7445-switch-v4.0";
-		#size-cells = <0>;
-		#address-cells = <2>;
-		reg = <0x0 0x40000
-			0x40000 0x110
-			0x40340 0x30
-			0x40380 0x30
-			0x40400 0x34
-			0x40600 0x208>;
-		interrupts = <0 0x18 0
-				0 0x19 0>;
-		brcm,num-gphy = <1>;
-		brcm,num-rgmii-ports = <2>;
-		brcm,fcb-pause-override;
-		brcm,acb-packets-inflight;
-
-		...
-		switch@0 {
-			reg = <0 0>;
-			#size-cells = <0>;
-			#address-cells = <1>;
-
-			port@0 {
-				label = "gphy";
-				reg = <0>;
-				brcm,use-bcm-hdr;
-			};
-			...
-		};
-	};
-};
-- 
2.51.0


