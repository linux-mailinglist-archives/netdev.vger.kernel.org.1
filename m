Return-Path: <netdev+bounces-186944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AEAA4266
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CF04A1E25
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1841DED66;
	Wed, 30 Apr 2025 05:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836B1D9663;
	Wed, 30 Apr 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991166; cv=none; b=KYL7lE2pHXKmaaAjxM2bScu8S1S0BwFPwb4DVCUcDf6DSU+YdXINR/Sm5ttXv6kAhmCfAJp4tgWKC7JU6RD1iafv/TNYVXmaFSnjA/v3Y4OVFci5bO/7pDTe8jWJlnNMDSzpJOVDhiE4IW34L1tVSGDO+uQslFUGM2fyIcGPcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991166; c=relaxed/simple;
	bh=3wAx5EeU7nOBuaCjATrMwZ8fnjoWWozoQiVr7g+qGjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lrAYFk8jF5V8koHHXMHJ1oqk2OU9UPJsT3XFbBoyv1q9xdlg2vRZPish6qfNublR3t1I1z88/gtUVgqToc8r+Dd8EDn3W9fC5FT7DT/LpWm1ibt16zlE0o+qMiZJf/lAVJv+dW+pXR8TSlkc4OLsaZ7zc+6q9RoslC7etUx6I4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 18B17342FEF;
	Wed, 30 Apr 2025 05:32:36 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 0/5] allwinner: Add EMAC0 support to A523 variant SoC
Date: Wed, 30 Apr 2025 13:32:02 +0800
Message-Id: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANK1EWgC/3XNTQrCMBCG4auUrB2Z/JXqynuIi5hO2ixMJKlBK
 b27aVeKuHw/mGdmlil5yuzYzCxR8dnHUEPuGmZHEwYC39dmAoVGJSQgh/wIWnugm7EImuRBmw5
 de3WsXt0TOf/cxPOl9ujzFNNre1D4uv63CgcE1RIp22lNaE4DhSnGfUwDW7EiPgH1C4gKdFI6V
 L2QxPsvYFmWN3W06e3wAAAA
X-Change-ID: 20250423-01-sun55i-emac0-5e395a80f6bf
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
 Yixun Lan <dlan@gentoo.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=3wAx5EeU7nOBuaCjATrMwZ8fnjoWWozoQiVr7g+qGjc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXgMAZe5RsVVOEfV453pwn+DCn61EB/ahujk
 TAJ0movAeaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG14F8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277bhGD/0eQyU6ElyjXOhRvu
 2KUKWEums5dVrS3J1TE61ryswgT0B6wqDnyaBzrIWfkhlkCF/TQcnY0m6GhJ0oT3mi0IQRuX6ib
 VIB826pQoS4EH6DJMOENAt6PQ1RJTQD4Dzc24+7439PK/mk1OZcoqZByNfga5LLMG1Zny8m0jhn
 grAMRzbbWIpURKUqZ+bPIUbaH/Jdtg+lw2JkXEGfJN2mPdJJHNMyHK0uOlRLV1O3x5lWT6DJuCS
 +BwCJMOoOQ+c6kEgDztgbmO1a1PCEZ8VFGVeob28mK6KIgFeb9wJ+Wjah3PP/O0Y3VVSLgARasc
 qkgHeIQcb0A8oDtIboDJAAAbYYXkQom8yR6PCCL+GgAH5GtXb76ueia3fWu4xsopsmZBaBs3Mvw
 j6845YhpwA25bAR+PEhU3aGbDpZy+uKpRtw9P7FtJQ0TAoELOqOMcflcjkJrga8XBkQvtu6UE62
 XH76nvDwDQx+ZkycLp12Wp/e6pcS5zioe4mXDfR4P5kc3Adx8uaK6MqYn6husvJ9E/Jtf8x5vPi
 prurA0YJme7acHGO84/vyAJ5n0PdEq2w8JcY2fJ9kXFp+MiPtAp4+nmk5NYIxwDQgqzW8jV5qiA
 HyzlpLdMeJnYjyhgF4ZmmAk9qakVdASTEhQcyfYgpgiCe2ncnDwCCq0nNqEAmwTAkBtg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

This patch series is trying to add EMAC0 ethernet MAC support
to the A523 variant SoCs, including A523, A527/T527 chips.

This MAC0 is compatible to previous A64 SoC, so introduce a new DT
compatible but make it as a fallback to A64's compatible.

In this version, the PHYRSTB pin which routed to external phy
has not been populated in DT. It's kind of optional for now,
but we probably should handle it well later.

I've tested only on Radxa A5E board.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v3:
- collect tags
- update commit prefix
- add bias-disable to pins
- Link to v2: https://lore.kernel.org/r/20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org

Changes in v2:
- add ethernet alias node
- add phy-supply
- change to rgmii-id
- drop PH13, rename pin name
- drop bias-pull-up
- collect Review tags
- improve commit log
- Link to v1: https://lore.kernel.org/r/20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org

---
Yixun Lan (5):
      dt-bindings: sram: sunxi-sram: Add A523 compatible
      dt-bindings: net: sun8i-emac: Add A523 EMAC0 compatible
      arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
      arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
      arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  1 +
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  1 +
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 41 ++++++++++++++++++++++
 .../boot/dts/allwinner/sun55i-a527-radxa-a5e.dts   | 19 ++++++++++
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 19 ++++++++++
 5 files changed, 81 insertions(+)
---
base-commit: 69714722df19a7d9e81b7e8f208ca8f325af4502
change-id: 20250423-01-sun55i-emac0-5e395a80f6bf

Best regards,
-- 
Yixun Lan


