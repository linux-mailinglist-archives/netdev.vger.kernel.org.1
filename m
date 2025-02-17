Return-Path: <netdev+bounces-166976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A575AA383CB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E321896EC8
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1D21CA0B;
	Mon, 17 Feb 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwCy3GfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5F21C9F9;
	Mon, 17 Feb 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797306; cv=none; b=QxIwTtpVjzWWTO1HuXJMdI9TAOLEZMGGLenqfiD/uIvJePutywUYhkbUyoqLYvwWWYLILK2ZaixsI4x/MGVQbRLJ4h1x/P0YlZhkv7ADqR1lblS+NmA5Euq7HK41CsghtxeeA4CFQfI83clTScfOdiaJxwop1PHYSdzYh8ETNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797306; c=relaxed/simple;
	bh=IpkbnQD0aqV4zTrDQLNPfko65wJI87nBEI5JGdjdZk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zhx/yedIK3NgQspaFU2ZCzvmCD/wUfuySOtG/OhxD/iSlpw3ddV0In32X0Nv3py0FetgVJffHFyHo3rzaoR85AvGbYZ9MyL5zw9D/qeFtC8ekk4oMIiRJvy+oOCQt2eH3PCRzMC32exCABRfC2Uvn77OPzGir7Q6OqcHMOBF0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwCy3GfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C3C4CEE4;
	Mon, 17 Feb 2025 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797305;
	bh=IpkbnQD0aqV4zTrDQLNPfko65wJI87nBEI5JGdjdZk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FwCy3GfYhbYBbz1+gfPbQ+q8e0WaGzbnSglaJFJLb3pudO/gWQBpRb+IlFjV55O1F
	 d3brIYtIR/4jUZefe04iaR3akW1Fx+ELc3CE7MufKyiVXOtGKLN94rQB0D2yTwNEy4
	 51Le+b+yU/WD1S82jTThI08qqUJY0AfL0tPMRgOeqo0FHlJzaRbdi5xk0VsMvwR7pm
	 dj4mHc845NjKLu+8JQFgNJ/sOIHlx9jRCoRCCA398U2l7hv44ZVD5HspmvS0kgtNsA
	 1lHSOmPfAYiXDxpa6kOdXJb91paaBN+co7CYj1REDeQ/twd07vO4zHyJ370RbvOABN
	 tjEAWDhtIIX6g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Feb 2025 14:01:05 +0100
Subject: [PATCH net-next v5 01/15] net: airoha: Move airoha_eth driver in a
 dedicated folder
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-airoha-en7581-flowtable-offload-v5-1-28be901cb735@kernel.org>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
In-Reply-To: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

The airoha_eth driver has no codebase shared with mtk_eth_soc one.
Moreover, the upcoming features (flowtable hw offloading, PCS, ..) will
not reuse any code from MediaTek driver. Move the Airoha driver in a
dedicated folder.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/Kconfig                           |  2 ++
 drivers/net/ethernet/Makefile                          |  1 +
 drivers/net/ethernet/airoha/Kconfig                    | 18 ++++++++++++++++++
 drivers/net/ethernet/airoha/Makefile                   |  6 ++++++
 drivers/net/ethernet/{mediatek => airoha}/airoha_eth.c |  0
 drivers/net/ethernet/mediatek/Kconfig                  |  8 --------
 drivers/net/ethernet/mediatek/Makefile                 |  1 -
 7 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 977b42bc1e8c1e8804eb7fafa9ed85252d956cad..7941983d21e9e84cbd78241d5c1d48c95e50a8e4 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -20,6 +20,8 @@ source "drivers/net/ethernet/actions/Kconfig"
 source "drivers/net/ethernet/adaptec/Kconfig"
 source "drivers/net/ethernet/aeroflex/Kconfig"
 source "drivers/net/ethernet/agere/Kconfig"
+source "drivers/net/ethernet/airoha/Kconfig"
+source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/alacritech/Kconfig"
 source "drivers/net/ethernet/allwinner/Kconfig"
 source "drivers/net/ethernet/alteon/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 99fa180dedb80555e64b0fbcd7767044262cf432..67182339469a0d8337cc4e92aa51e498c615156d 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_NET_VENDOR_ADAPTEC) += adaptec/
 obj-$(CONFIG_GRETH) += aeroflex/
 obj-$(CONFIG_NET_VENDOR_ADI) += adi/
 obj-$(CONFIG_NET_VENDOR_AGERE) += agere/
+obj-$(CONFIG_NET_VENDOR_AIROHA) += airoha/
 obj-$(CONFIG_NET_VENDOR_ALACRITECH) += alacritech/
 obj-$(CONFIG_NET_VENDOR_ALLWINNER) += allwinner/
 obj-$(CONFIG_NET_VENDOR_ALTEON) += alteon/
diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..b6a131845f13b23a12464cfc281e3abe5699389f
--- /dev/null
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_VENDOR_AIROHA
+	bool "Airoha devices"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	help
+	  If you have a Airoha SoC with ethernet, say Y.
+
+if NET_VENDOR_AIROHA
+
+config NET_AIROHA
+	tristate "Airoha SoC Gigabit Ethernet support"
+	depends on NET_DSA || !NET_DSA
+	select PAGE_POOL
+	help
+	  This driver supports the gigabit ethernet MACs in the
+	  Airoha SoC family.
+
+endif #NET_VENDOR_AIROHA
diff --git a/drivers/net/ethernet/airoha/Makefile b/drivers/net/ethernet/airoha/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..73a6f3680a4c4ce92ee785d83b905d76a63421df
--- /dev/null
+++ b/drivers/net/ethernet/airoha/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Airoha for the Mediatek SoCs built-in ethernet macs
+#
+
+obj-$(CONFIG_NET_AIROHA) += airoha_eth.o
diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
similarity index 100%
rename from drivers/net/ethernet/mediatek/airoha_eth.c
rename to drivers/net/ethernet/airoha/airoha_eth.c
diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index 95c4405b7d7bee53b964243480a0c173b555da56..7bfd3f230ff50739b3fc6103cd5d0e57ab8f70e1 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -7,14 +7,6 @@ config NET_VENDOR_MEDIATEK
 
 if NET_VENDOR_MEDIATEK
 
-config NET_AIROHA
-	tristate "Airoha SoC Gigabit Ethernet support"
-	depends on NET_DSA || !NET_DSA
-	select PAGE_POOL
-	help
-	  This driver supports the gigabit ethernet MACs in the
-	  Airoha SoC family.
-
 config NET_MEDIATEK_SOC_WED
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	def_bool NET_MEDIATEK_SOC != n
diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index ddbb7f4a516caccf5eef7140de1872e9b35e3471..03e008fbc859b35067682f8640dab05ccce6caf7 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -11,4 +11,3 @@ mtk_eth-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_debugfs.o
 endif
 obj-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_ops.o
 obj-$(CONFIG_NET_MEDIATEK_STAR_EMAC) += mtk_star_emac.o
-obj-$(CONFIG_NET_AIROHA) += airoha_eth.o

-- 
2.48.1


