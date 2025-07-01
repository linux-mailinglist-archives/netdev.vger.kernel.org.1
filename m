Return-Path: <netdev+bounces-203008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D70AF0111
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8610E16A970
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41583283C97;
	Tue,  1 Jul 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOHIx/Z9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE528312F;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389091; cv=none; b=qViCnpJwmEYxO3iYBiRCOgDMnSkMZytoEq6DZGUFjL5rQrBZHqlS30t9xVGmksuo1EplnjnmlIiPf4hP0//1k+U2OP/3YtCFvkyuG5YGGOrjZKAWn3//3ZkpUrAHFNx3+k0rz7A71viyl9FTGz01Ft7IK9PQdlOoHyN93ufS1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389091; c=relaxed/simple;
	bh=nAHJWVBqBIFgDdvlPNmXu9yu+XCBTnN7iRiEX4QfvyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G14SkEs2ZBkhD8mkZQD6O7dAfGmQ2V/KUmgCkFW9tXUnvUCNr1rF1vYkkbcHPnyxrTLdBDooFQ36ElO5Oo9y3KV3RRd5vv39oATm/17yPpRDGv8EcqFNmmhdp1/6Iey4MOPAgNdpJrQgzERQsvKYwIK5tASyjvM1QSdJvTdcNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOHIx/Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EABBC4CEF1;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389090;
	bh=nAHJWVBqBIFgDdvlPNmXu9yu+XCBTnN7iRiEX4QfvyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOHIx/Z9SgqL7SqpGSUO7dGaLCALAHGW31NBjZxyaYZYoZ4CsOoEPiCpHlgzsPjQT
	 HmUNHMR7pb/agQnxGX+QPaEQZ5Zm8om+tDxoPZ3Eklvro//MoKclPZOWLrk51yBCgT
	 CSvjUkSQ/CYqC1lwazTAFqQvRcdrOXKY80i/KWM6Mga4G8UPqgtnWBhIAAsbxH4QUd
	 GF+G4sNNQcftc6FRmjUnn7DoEcFwcnq2WJoAqb21iWTSrto0TkK2BthlrjJ2oVLdWd
	 7I0WreVfstImBI+etS9GY77zTv0SlEE3aYLrxOpIPk6q6Y8Kf3TPVI/HH4/xIkUgnq
	 KmDF+C/mYpG7Q==
Received: by wens.tw (Postfix, from userid 1000)
	id 13D555FF19; Wed,  2 Jul 2025 00:58:06 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH RFT net-next 08/10] arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
Date: Wed,  2 Jul 2025 00:57:54 +0800
Message-Id: <20250701165756.258356-9-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The external Ethernet PHY has a reset pin that is connected to the SoC.
It is missing from the original submission.

Add it to complete the description.

Fixes: c6800f15998b ("arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 142177c1f737..9a2f29201d3c 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -80,6 +80,9 @@ &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
 	};
 };
 
-- 
2.39.5


