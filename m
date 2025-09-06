Return-Path: <netdev+bounces-220560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82195B468E0
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1181C3A7144
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978526F2B1;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coau5L4V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4826E70C;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132024; cv=none; b=l8cPLyo8P1A59D5yNku2JDs1FZbgFLQrhNMvRGKj+fZRcKe+XVNXKaWvMRT/y64prDgGh9K4WlEtB/LnwuOfuRzUrVwqyPb2ohkg9XLVeIazOn/Nppz07nKXlgn669gttsO8fPP1i4/Mcq+EXTYoKI1I03j4RMtWvsoulNgZYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132024; c=relaxed/simple;
	bh=coKgeanaUZ3X4I0jziHLWfdNIN3UjLw9i/nP+qWcjHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgmz7OMMMVU7ILnyyiU02wBlVrdjvG1Lcfx8aJMrg5dQpIIXoSihZI/c6P9b0S8ameAHmyJT1c64m3KYYMlNbyvdXyDVOZX5mk0cd3Clsp3QM5+7eFiTzAhnHWz73tf4cQVg95mrUgsh0tF5QcAAxSxZe0Mjml+vFdZy9L3fwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coau5L4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09206C4CEF8;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757132024;
	bh=coKgeanaUZ3X4I0jziHLWfdNIN3UjLw9i/nP+qWcjHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coau5L4VcUBh0pb7ft7mpwoSZY/nZgwM8Umvnx01Nwbm1ZUwnwRH77dcw2XJN3rZD
	 RD7USlnj4bsrb+YF1AFycelE5v12xACcnlkDYSSJTAP4Iq/mglQZ7B9X70KTjaHAFv
	 ThofGXaZJH+gM6tDAliipZa1Y94iXBjLed94C2aNVyXwRSjnYV2ZPlcNBEfmdrVNP5
	 phiBVWBhO4wAJtlIZsNnvPbanxBywMqbUeaWhCERI+eJETInsXiDE5n+fWs2k9a6wg
	 IfngRvqzL0glUpW6RJmab9E727RyXFywaJLBvFb9jmyEcidrVdlkJ2k8vZxO+bSGb/
	 E84OJY7fVm2fg==
Received: by wens.tw (Postfix, from userid 1000)
	id F1BF75FF75; Sat, 06 Sep 2025 12:13:38 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net-next v3 08/10] arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
Date: Sat,  6 Sep 2025 12:13:31 +0800
Message-Id: <20250906041333.642483-9-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250906041333.642483-1-wens@kernel.org>
References: <20250906041333.642483-1-wens@kernel.org>
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index b9eeb6753e9e..e7713678208d 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -85,6 +85,9 @@ &mdio0 {
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


