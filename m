Return-Path: <netdev+bounces-186949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FEAA4277
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C121C01238
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B81E1DF1;
	Wed, 30 Apr 2025 05:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BF1E2853;
	Wed, 30 Apr 2025 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991198; cv=none; b=ZZDTkwl8gLbzNcb0HYDgrdW/KnFAx8tAI3gEGoSwaVUkShBC07bDZFBpzHK1Zd18yTd7ut6qWdlu1JHg9dJBbeoFoArsU62+U/vIL0609B3sxRgzjwqsO1qcKup6K3BbQG9cudbECA5/9fbApqs0npUtBfHBV7wek9J4hV1OvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991198; c=relaxed/simple;
	bh=KQtVVkxqKgq++RrOtQPY3AP4zXz78fWySFRMQ+WV2cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYY6T/AjO6SSqB1ZQYw7CMDUw5JHVBqScC21/uictsg5qw4XDfMDS0d7sUrz3iF+5ndr2NSgOUFldM5Ks3EFSYHJ4wXQLwqzQbYIt1UJqK12xBUnvCKtCVNFPzEfadJnI2MpLscMphuTrUxPVf6IMIJVtaWWlupQZzp/cNbO15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D62F4342FF8;
	Wed, 30 Apr 2025 05:33:10 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 30 Apr 2025 13:32:07 +0800
Subject: [PATCH v3 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-01-sun55i-emac0-v3-5-6fc000bbccbd@gentoo.org>
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
In-Reply-To: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=KQtVVkxqKgq++RrOtQPY3AP4zXz78fWySFRMQ+WV2cw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXxaftpe1NJ9cfpRt022XLIsXHhvqeP/+lrN
 m3gmTKPy3uJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG18V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277dNvEACeKULnlu5Zk1MfpK
 yFz42975F08U5nXUWjXpJ+dsJ+loBIeJ/f2vkvtVqTj89Rm7vG3CLPPpjS7Oy7EEumMogyINsP5
 q9F8GateiqiLR7QU5FsoaB90gavEActY7+USEUqEE5UmFxuRX6AhhKG6aUy8VVkyiPokgkptcvB
 pz3pPsyg22fBo3Tz4TBVp7O9TyJLGvW+++BPewKoc0PFPUOlcarVraKMm+I+9uAwLsgGSjL0hz5
 Ka6uCcZVQf6VpkUMBfoVj+CqUfbrLAdrMs2SUgxUC2QwMLKRtthXF41CKYSSrVtw/isObSgBPPw
 932xGk//aOyGX4mEYRTttXm5mgFUnB84/y6N/s8FrVUK0/+y1fVSqi0MnX1NsGa/LOsQn4+CBWs
 NhThpLovc21IjaVakM3bgkL2QzGKfOmA6e/Qek4c3Iq78GGNJ8WccjktK1I/+uWer/4FUePaRQL
 +I0IPjaTSFiG4Qkgv/0NJUFcMSO5R9J3ddEwFLjyuEzOUk/3L3OkPBevxnUN8uTBrYa13Yq3QLu
 puGs9vF+R+41UZFqAOl3nAsQmUwHqY5XGusqKXaDukMAK6Uh3iFENHt7saULfWyY/J4MLu5oP82
 mITBKX8eCawg617cCed6gQvKRtTJWR5aXcV4d880ZlDm2eJIdFSZW2+Db43GwT+/CXJg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Avaota A1 board, the EMAC0 connect to an external RTL8211F-CG PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
I don't own this board, only compose this patch according to the
schematics. Let me know if it works.
---
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 85a546aecdbe149d6bad10327fca1fb7dafff6ad..4524a195e86d20089cc35610495424ed2dec7e95 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -12,6 +12,7 @@ / {
 	compatible = "yuzukihd,avaota-a1", "allwinner,sun55i-t527";
 
 	aliases {
+		ethernet0 = &emac0;
 		serial0 = &uart0;
 	};
 
@@ -64,6 +65,24 @@ &ehci1 {
 	status = "okay";
 };
 
+&emac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dcdc4>;
+
+	allwinner,tx-delay-ps = <100>;
+	allwinner,rx-delay-ps = <300>;
+
+	status = "okay";
+};
+
+&mdio0 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_DOWN)>; /* PF6 */

-- 
2.49.0


