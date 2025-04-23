Return-Path: <netdev+bounces-185163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CEA98C4B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EE189304C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9027B4E9;
	Wed, 23 Apr 2025 14:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D8279917;
	Wed, 23 Apr 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417051; cv=none; b=M1zIAft2d34YDd/Grv0vOJfqRZDW0SZ6Oc7PbM5J/nyC1GCDDBsbmPnZ8x07pmjkRqCKiG1BTrdwjZ9ukMdhOK5D2f5Fys987ghSXn4EH9iULklDfE8wcz+2T+HSO1s34GoyNr1pnoKENVvj4TVq5plN0oUKS6oRGy8IC0YiDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417051; c=relaxed/simple;
	bh=fNoJRpHuKT1mrda+dXosfcR63wOlI+o2Qg/r3AfmdGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swZapadK0RhW0QAQ8peZ1HMpgHuXed4WDEnWSH+JNlJR+YdZTfzlRq4OW9Zlshjsqu4hNL7EouYJQVQHi67fyrWdDafkyKqkCuwxz9V17TACMlRS3fofXkuz2b09TxgymyOxiOMylxfYGRClnRmRMOP+WOvv5Y7DS22vQ9umjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5F3523430F9;
	Wed, 23 Apr 2025 14:04:04 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 23 Apr 2025 22:03:22 +0800
Subject: [PATCH 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-01-sun55i-emac0-v1-1-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
In-Reply-To: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=fNoJRpHuKT1mrda+dXosfcR63wOlI+o2Qg/r3AfmdGQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPM8tzxyRwM5JaEizk2cNclzPvX++EJ0fWumI
 +ET5sc3sJyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzPF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SdDD/9ZZ0Hso/3o+n/pod
 4Vcz6ad9dd0AuydxpIuJZolPthCKCSHL3oPvWZW3S7D2fVAJ5B8dCw6dAAuv5D7FCEzfEHqUiKq
 c9CPebORx/66nLiB6PZrmdTWtUX/1BXaogZwJjr9sulTEBpRrWTJVoqt842wahV2GIij/JZ6XD+
 01GrOr2Xj+X/BK6C3RrhdqnRgJxOskoBOVhftQcnpFDfSKNSzHhvQaFXpnkwR308xiPhuZE4eLh
 Vl/KWdbEuNhZoyykq2p3x2rayeE16p0UYqz0aSNFvTOWSs/sUGdjF6Jo6fnaLPsewkye6Bi8l/t
 obiKMbLT07Bl2FlfwZuX1rhSZGPu7fCK3RPLcAXgNY2c/BGgYw+7Jj1ZeJCVr+vk7A/U3YYGOJP
 yOWuR7ywl633p5mTX1AWXag0kJWCySDR/OYeNkCtvKlV5wMCzIhILsuayDC9/mdYGo8vpZQvsTS
 qZjmgAYdNfFnkPXdueuwIHNnEvpOShtZHjjHqUANgzLN6mYtQTLfAQgnDX7PX2GVZBtc87tyKBg
 C7I6/cM/WeQCp1o5A2aK1qqYXbAy2AFB82ntCwY0sxf5JzEbEKyzWQgR3beTqVm/mDdfYZChdCm
 HG+FuA4VpsQ3iSIsKsxnBtAzFpU3KQMfyDXjRue9K/gQXz0atGdfd5mCC/JUKe4ZWTnQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add new compatible for A527/T527 chips which using same die
as the A523 SoC.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index a7236f7db4ec34d44c4e2268f76281ef8ed83189..e7f7cf72719ea884d48fff69620467ff2834913b 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -50,6 +50,7 @@ properties:
           - enum:
               - allwinner,sun50i-a100-system-control
               - allwinner,sun50i-h6-system-control
+              - allwinner,sun55i-a523-system-control
           - const: allwinner,sun50i-a64-system-control
 
   reg:

-- 
2.49.0


