Return-Path: <netdev+bounces-203004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBEAF0106
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544741663DD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205C27F727;
	Tue,  1 Jul 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmNrt4MU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042F27E7DB;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389089; cv=none; b=SjSSXJDnUG5w/AgbnShTVpN8Bk72rQWBemFmI8acbJ1+TJeR1SVD3Tfkf6SVQ2tuFjyPNqScnCKq8Id6zUB2gs12oN63TVNiZn7PxT2WK1DuZ2LuTmj4W5ePonTbHJ6ameyCDLJkNmuGvluoGRYuCNpNAnocdZk2RsGiDatJRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389089; c=relaxed/simple;
	bh=I/bJFFYuJYTgGBIDN+smaPh81pdclQ4NTY0/0vTHG0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUHA8xQN/io/hx6p9jK2PRdEOi6U4UGOv7waEHqAA2QSVK4CiakWPpFpC8ZfWoTtoE7Y8SIWJBBAS6gnwXCTeYGncI0Ao3ZGxzhtmXktcZU7Me0JjCn9hb838l065Y5iOSk5jl/+3hukzgss0xaAHnE6ny9bFQ0K791Wuqew4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmNrt4MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53288C4CEF8;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389088;
	bh=I/bJFFYuJYTgGBIDN+smaPh81pdclQ4NTY0/0vTHG0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmNrt4MUMKTDeLpB9MdnSdSE18qRibwY8Nbtz/Isya33gvsd8q4Pkzx8o2FY7QY23
	 SF70tJKMuR70mbxPbgxJ+OB2jTM4ieHcxzYC89iAxmEd5LYUVdoVYQ4pz1Ig512DPh
	 GvGRXMHs154G81LOE2/Fdng7K4HVDTb+e/ZT2JBluFArZ00QQck7u5rxkcSc/1eTlz
	 f1bC6E2NJZm7uSCtKL1Z2heRMhw6DHwT21YnOVz74U8AIdaq6I4WjYpN6AiUZdlxo7
	 2mhy1zKf2y3EAzRZcNbtZvjA49GA6fwiTFEwQ4WGCuUQAgzBxGDLgt1im6e/n/1QMC
	 Xe79bZgFiuqOw==
Received: by wens.tw (Postfix, from userid 1000)
	id E2E595FF71; Wed,  2 Jul 2025 00:58:05 +0800 (CST)
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
Subject: [PATCH RFT net-next 04/10] soc: sunxi: sram: register regmap as syscon
Date: Wed,  2 Jul 2025 00:57:50 +0800
Message-Id: <20250701165756.258356-5-wens@kernel.org>
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

Until now, if the system controller had a ethernet controller glue layer
control register, a limited access regmap would be registered and tied
to the system controller struct device for the ethernet driver to use.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/soc/sunxi/sunxi_sram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4f8d510b7e1e..63c23bdffa78 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -12,6 +12,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -377,6 +378,7 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	const struct sunxi_sramc_variant *variant;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
+	int ret;
 
 	sram_dev = &pdev->dev;
 
@@ -394,6 +396,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 		regmap = devm_regmap_init_mmio(dev, base, &sunxi_sram_regmap_config);
 		if (IS_ERR(regmap))
 			return PTR_ERR(regmap);
+
+		ret = of_syscon_register_regmap(dev->of_node, regmap);
+		if (IS_ERR(ret))
+			return ret;
 	}
 
 	of_platform_populate(dev->of_node, NULL, NULL, dev);
-- 
2.39.5


