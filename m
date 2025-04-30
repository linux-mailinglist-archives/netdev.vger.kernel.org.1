Return-Path: <netdev+bounces-186945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE24AA4269
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47E14A385A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F11E3DD6;
	Wed, 30 Apr 2025 05:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2FE1DB15F;
	Wed, 30 Apr 2025 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991172; cv=none; b=ObxQJOxkXtj/m4gz55woLxJkrF4Hw6v2CAFs2owZKtBOlNdppNwdG3ocu/orlCawysEFfTe9yGd72PrRn418Yqj0sOZW0NN4L0rl4Y5aJ6mo0tVsMzN/PjN+WynpBe7koRkNSYUIj/vUmoe8IezlYxzA5BuUPQE34oQd1hGhQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991172; c=relaxed/simple;
	bh=SZdtmllnLkE/VhdsaTzS9ljZiaw8YmMflpw3nLGy6P4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDjQs+u/EXtpI28kKU/uTtGsuYlpV61ypEVuW9V9jJtuWVlnGINMTuw4cgDAPVaVju4REKXG24f4N69njUXmm+j2/XecRHr/mvMdplNm4KKqE5Al4OXL2k1+OWcZdmRhcxbT7r16EbF63/h7EfCpyj1bS/q3vQrIVww5jIrCVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 64F99343005;
	Wed, 30 Apr 2025 05:32:44 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 30 Apr 2025 13:32:03 +0800
Subject: [PATCH v3 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-01-sun55i-emac0-v3-1-6fc000bbccbd@gentoo.org>
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
In-Reply-To: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
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
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXkNVD9Mp4LV1v+vJyJ0q+aQ4GhBTLn9lVzG
 gImIcDUU7CJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG15F8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TUfEACZdQ6t0PyPoIomla
 iy4STRZrgBxH6CIEWOD1tOaHnACKjfSNKJ8pZ2M2mnEe12MqJoCWYEG1YLEznRmMUHEuiV01fOK
 yYS9HZHz0U/WroD+dtRq04RA9jDJxU+Ke27U4rZW4l3R17Iq3UZXWQxk802/FC4WBGLiyDVDsMU
 Xu/et2iAS5Rf0CuQSayzDSfrI3oFr6FESaVa+/B2V+Tm8jWCi1Lx33DQ+5KDzm5pUSp/ShiS4T2
 HxGSN82LSrJPuEUsTTUzLE1HAoZN1DK5zd4ERXYMEPec3p4TQ6DTOc2BBzpRTqyOfee75bzrA2T
 cM9DCeXz35wWv0TmQcKLekhosz9hJVdMZiF+4bmTKkqc1W42OA9v9l/kSikoI3Pdnes1A0GDepr
 U/vsvRPKIozviDN1GXD6TtQAJaLc6/Ky7ou1eMcAH49nV7/qrZwWxAmFPlmpu6OoeJpSiCIdhEf
 cxEwB5iFXAhEp4JYHu5oqTUE6JNCwLFIcuxMld5DEmVju2eFZygKrbkGjO2l281AM00xbr+gHtR
 C5vjftpFMsFxl3GVcZUTT2Bnj3UGrlTxEbS7+g7HtxCrC2XM8i/Pn4IOmg7rgT7oWiEpzpBDSJn
 8MuOUQ5AFAg6D8OeJthDjvj/hsGFYxMNE+Wp65tTC/bKgcNIQPqETKmPL3vmp5NJP3dQ==
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


