Return-Path: <netdev+bounces-185478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8210EA9A98A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0355A1E3A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C1221725;
	Thu, 24 Apr 2025 10:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6B220680;
	Thu, 24 Apr 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489368; cv=none; b=R4RpYKFk7OLePRaZhtI8BiWXoiq9B9at6EfkGWPV4JsJoNP6VfKIEYrZgtcpN60u2c+PpuKWeicHrA2gnf3zf/1Nvl9b3Cj+ja+o+kqw/YW8c/yKfC8mthW1oWt0flIFv4fPPFxjOdbUK1jYgZzQ1J1nrUJGj697TDCIrnN8+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489368; c=relaxed/simple;
	bh=SZdtmllnLkE/VhdsaTzS9ljZiaw8YmMflpw3nLGy6P4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z54CeqDS1+MO9K5IZtkq/XSSawzDEpZTxul1VIOUJDL5upSN/4EsmgGLwKoecsa2sIdS/i53Jz+0vxbQlHX2S7CY4e1cQfyGY92c779gUpjpRdjDByls1RKL7l+WpLCFBqzy/R2aLd+uGuoKWSUVeKnqAKrbhdEIiKd8h8kisZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4E723343024;
	Thu, 24 Apr 2025 10:09:20 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 18:08:39 +0800
Subject: [PATCH v2 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-01-sun55i-emac0-v2-1-833f04d23e1d@gentoo.org>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
In-Reply-To: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=SZdtmllnLkE/VhdsaTzS9ljZiaw8YmMflpw3nLGy6P4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg25Dfr5AniqH6ubA2NLvTbfb63kRxV604lla
 0zli1tpok2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNuV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fj9D/9s1kg601z7xkamgA
 M9vOaomlxHDjhAqLtTFqF1sRu5+APkyrC/BBZyzgzz1KvxgM4Amm515sp9m669vA5BX8ea9ggZF
 X7eDxzgrsYriVEyRZ4GxImqmkC2A87CnleaVUUj/CqY2oUq3m1ME7sKe0j1k5k8ekM5E2x3zemr
 XR7De57g6ermiWmJT75lPfxAEKPVCf5vjWNxVc2uyQDkjdmBwRgaYpbaUnsirezD0fzQkg5ArKE
 T7OzWcIv/HOfgvgwUapLgjabog+kQ+erHEVC2vxN/o6XsbyklNWNbBbo+Mz2u7hGtQrPX9FyHDy
 dPq6ZOLpSDx26tLB54kJOYHSgMxy8S3kHMWKYmQVGDSwB9VGYV1U8+VhfcT+IwQVDFRXEn4i4WN
 Ratatjad3iWajGpuv0ZyV5wO6ltI8q1c5AupYsBG6WgyRyV+v0Yduqdcln/E57XU0s3TgKwsBFw
 sAp9BCclQaMWkYdGutMFt2NqhbrqbKavMYA14YeXiCDpFJWdXNcr6S4BS2/Yuihu5byqyRE2H51
 s+QHIooZdgOGWj5VSs93v54RYeJ2Ip3HXlF57eNMnsjf/VEfe6hQDOVAlK9f2uQ010bk/F07fwb
 /nJUb8wmNDsnVVGLpC4utsUGuD15YZC7tdS5BMcMmcqfmdOaJ/omYJmTohdidOYUa8Cw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The Allwinner A523 family of SoCs have their "system control" registers
compatible to the A64 SoC, so add the new SoC specific compatible string.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
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


