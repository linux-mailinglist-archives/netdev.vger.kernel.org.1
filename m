Return-Path: <netdev+bounces-213377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CEAB24CAA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07773AF4D6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E62FFDEE;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F78sv2/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3702FFDCD;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096950; cv=none; b=I387pioNFmqovzBOhyKOoGi7C5qkt7aU6vhSGirNmRh6GFM2gyq5iC0SxE7dWZIB8rUbcf/gUS7oHwxJbSKfLAfztLDuaiglAOKR6T8vigUIRfj8T1ZYed81+IXDzyWTfUiC9evySV/MmeqdQiVopCfKy1iIkwmAKXPG5hMPJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096950; c=relaxed/simple;
	bh=/usWm/vrAulCsp4Fo0dvH/GWf7HQ6Sc8o/o3f/vf8hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LD9AqTHnjoFbDi4LUjJhLAoJgvWX+xTLOLk5r+29+Z3aDilwOCNL4E0nt9NJ2M49hLl6X1lWq734ydkpJfjNnYxCNbwJaOUj73vf1LRCqOuWqawIyccfNqFSKPJi7vAEMiPl2XwXGIT1dYpbkfyBNUatDEcPN0zl4ZwdNZZg9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F78sv2/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC3C4CEF1;
	Wed, 13 Aug 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096950;
	bh=/usWm/vrAulCsp4Fo0dvH/GWf7HQ6Sc8o/o3f/vf8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F78sv2/7X2r8RCxweQ91Vm2r+O/C8tEOxDFBrupkW8VJNsfb9n9TDBF7i0rmY/fvb
	 tH3pvYlakWjVDCdjH/1LMnpZcreHnm0smJuVA2tFwp8sycBBDKg91IPV8gM4TuSlmJ
	 1nmafLuTvPmvzDlfs71e2XeRHbe91fDeb9L9HXtNjcd7oyEuHctzCeZ4DyFlTBfPKs
	 MOLJry39YvbVDDxNKoYt4VGNZu4n4+MBDAlbes5cXHmMEAoq1sXHOimGhjkhKLDTXg
	 5EzukLsGzN8tfgBXrMmJfPaqk2m5UVEyz+0PCOlFZTaouEn7oKHZ7KzVW0J9yoxC9d
	 O0tFX1ePl/ixw==
Received: by wens.tw (Postfix, from userid 1000)
	id 42B565FF03; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
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
Subject: [PATCH net-next v2 08/10] arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
Date: Wed, 13 Aug 2025 22:55:38 +0800
Message-Id: <20250813145540.2577789-9-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
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


