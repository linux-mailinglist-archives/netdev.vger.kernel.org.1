Return-Path: <netdev+bounces-185161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63FA98C3E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAB03A7740
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8B27935D;
	Wed, 23 Apr 2025 14:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CE223DD8;
	Wed, 23 Apr 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417046; cv=none; b=DKVlln/vBFD3ZU0UUJmMsPNbdTA2xNk71ZKYtPUdtefU0djPYUq8z4GmDRnUJkJoaCGRgKesf+lQw3kqbt//J1f+LYhyVL8uoYiBoFtAVQ5y3CsZ5WhSfGe78sDfqoSQxRkbE71tUpUkmyYEURsZougOauKQm1RFjA1nXTRuU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417046; c=relaxed/simple;
	bh=hZqEM5nE7TvaLpWqvoc5l3TI9Oubf5G1nbiY8Pi5PH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pk2XcICtgLVHZFMn6u+tGupFZoihVczYOrejnTpy6NTlduAOWjb6EuKq/avIMbBqlJtBs17oDIgv72Wo7Bh72Sh0Y8fio5VVMdwQJ7EjmRVE3/m+tPIYCkWELmYO9/ggotIZ9PdpnkYMwMvBIP2AUz2siH/NCuCJ91NYUgfO9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id F323A343087;
	Wed, 23 Apr 2025 14:03:56 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 0/5] allwinner: Add EMAC0 support to A523 variant SoC
Date: Wed, 23 Apr 2025 22:03:21 +0800
Message-Id: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrzCGgC/x3MQQ5AMBBA0avIrE0yygiuIhbFlFkoaUMk4u4ay
 7f4/4EoQSVClz0Q5NKou08o8gym1fpFUOdkMGSYKlMiFRhPz6wom50IWcqWbUOuHh2k6gji9P6
 P/fC+HyFAyS5hAAAA
X-Change-ID: 20250423-01-sun55i-emac0-5e395a80f6bf
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=hZqEM5nE7TvaLpWqvoc5l3TI9Oubf5G1nbiY8Pi5PH4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPM4DKPuBzZRVqb50T8PXyF0UCKRr4fPVdY3s
 xmCwN+ZxpuJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzOF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SAQEACFJYjiSRxvE/mbb9
 F0SyhbAmPcpzsTcEoKbxHroJiSTxxoeWs+r/5TyOOnNbUwJnYoJ6+gjZHiAelGlImh7gSNnOQGy
 VEuHuUZGDpiGPB4fU1sTh1Fl/5ii8niwqIu+Ygx6ScocrgNNciHTC48Ge0/7r9zl+x+WhYwnY94
 JHQLC9hcrNUxzj/5JUtUJ/BIT+XmC2YJEOV0VZeA0rtcGBFhyuFufIrBTVq/cYpKhTCIM7I0fMX
 8fqENSCW9DT2ycGBbSFiBIgOk+Lb2irHyzr2HZDPhkW6OYMnSU9vkey+13JszErEZf6LV75+Df/
 LtFjXyGU7YziaK0JevsgLA0p7EJU7MXxizfGOVO+Qj6PNqxCLttlv607QizLCpWkcr13sl59xW+
 T2bHYmmll5s1VM0mQWuJqjit+gJWm9Rt+aE1/dRwKjjN+2fTJKKmC0IxYgttiDu84WRDHo4lo0t
 cXSoyWKB2FVwZ0dQDvqiSCalX3CQs0V2ZvFsE+GCBbBTWMbN/jlQ39sP13SHdZzuoiKabkf9dRr
 RyHSARPSW7QT/UBAaOfi/p3GPfllr6RY7CP73piRJy7sUNXyR2qNX4DUUt8yfdwKrJ3PzeXHJuo
 guSiGgJzjAsvw6CvPr8khtvtTDHP9pAM7UmN8vfAhwwCP/UTEeXalnYgzr0uTrKxgT7w==
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
Yixun Lan (5):
      dt-bindings: sram: sunxi-sram: Add A523 compatible
      dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
      arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
      arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
      arm64: dts: allwinner: t527: add EMAC0 to Avaoto-A1 board

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  1 +
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  1 +
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 42 ++++++++++++++++++++++
 .../boot/dts/allwinner/sun55i-a527-radxa-a5e.dts   | 17 +++++++++
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 17 +++++++++
 5 files changed, 78 insertions(+)
---
base-commit: 69714722df19a7d9e81b7e8f208ca8f325af4502
change-id: 20250423-01-sun55i-emac0-5e395a80f6bf

Best regards,
-- 
Yixun Lan


