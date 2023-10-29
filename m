Return-Path: <netdev+bounces-45044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB767DAACA
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411772817A8
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E97186C;
	Sun, 29 Oct 2023 04:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D5SzQHKM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C26AD9;
	Sun, 29 Oct 2023 04:27:52 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2CD54;
	Sat, 28 Oct 2023 21:27:45 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E02A8660738A;
	Sun, 29 Oct 2023 04:27:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698553663;
	bh=xvv/tFFVtJp+rbBYtKgTLulVc7HdAalSk1KKPFjFju0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5SzQHKMiq3FRLM4nvNNRyGURYA4qwkqxN8c1LO85/vBDaS5eKZEaYgpC85M8rdsF
	 BiP7aAnwvRU+Hdd9LkVsID0hco3/F7Ub/R7TGvAiW8jxFeviRk0xsMqgvIeKjTdIxf
	 b15Pjhm8JHpsZe2xV0oLnhIEV6lxUJxzl5gTzyt9Mx4nD+J04epuaQ/6tg+20yRcd/
	 qHrjt1Rldo9Q+S31pa3H4FHLrviNVlJr0asKrsRHkU+MAmdj5jS4TWDR1JjQYnnFKi
	 nPgn6c1IrSE23vp/S/A7lEN01u3A0aXWS364hzBX6UKky7Ca2lMdHTXnmeFlhdF46e
	 JnCP10NVUj6TA==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA memory on JH7100 boards
Date: Sun, 29 Oct 2023 06:27:08 +0200
Message-ID: <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
expect to be able to allocate coherent memory for DMA descriptors and
such. However on the JH7100 DDR memory appears twice in the physical
memory map, once cached and once uncached:

  0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
  0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached

To use this uncached region we create a global DMA memory pool there and
reserve the corresponding area in the cached region.

However the uncached region is fully above the 32bit address limit, so add
a dma-ranges map so the DMA address used for peripherals is still in the
regular cached region below the limit.

Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index b93ce351a90f..504c73f01f14 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -39,6 +39,30 @@ led-ack {
 			label = "ack";
 		};
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dma-reserved {
+			reg = <0x0 0xfa000000 0x0 0x1000000>;
+			no-map;
+		};
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			reg = <0x10 0x7a000000 0x0 0x1000000>;
+			no-map;
+			linux,dma-default;
+		};
+	};
+
+	soc {
+		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
+			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
+			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
+	};
 };
 
 &gpio {
-- 
2.42.0


