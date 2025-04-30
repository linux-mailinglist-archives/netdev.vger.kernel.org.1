Return-Path: <netdev+bounces-186946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE331AA426E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A331C01005
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530A1E1A32;
	Wed, 30 Apr 2025 05:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA01E0DF5;
	Wed, 30 Apr 2025 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991179; cv=none; b=KA4uSWRXW0m5YO+/L7oRsZBIKynHMF262qUZw4pGkYg9hdnWiMOtiMbagawAAf08nQjxKQDdkULqtLmiPuGYqdvoikSzSMdBZd8cTgePyMOWKaJZExd9F2DSFrQIpAx3ewofZ12SuPa7QSPNcOLCcoqM/jE/rt/cE4vtbgEP1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991179; c=relaxed/simple;
	bh=CPzf3L1maEHhRUPeCLRLGmqGZlZyME7KCDHk90hRYuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f590+SL0xvSKbHSVpt8EWwBJ9sQXhhegB3EQ0yb2jBbi2xmhkaajhcg44bcSbNyoCOBNn8OBJKrliJzFLVJiw88fVUmqT/S4udAt6BAurybNjZM9dydkulnMPDByYHN6zDEW/FAtQjYJEMhXW6xItkpqQDAxII8KTC3mIF8jFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E9CED342FEF;
	Wed, 30 Apr 2025 05:32:50 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 30 Apr 2025 13:32:04 +0800
Subject: [PATCH v3 2/5] dt-bindings: net: sun8i-emac: Add A523 EMAC0
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-01-sun55i-emac0-v3-2-6fc000bbccbd@gentoo.org>
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
 Yixun Lan <dlan@gentoo.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=CPzf3L1maEHhRUPeCLRLGmqGZlZyME7KCDHk90hRYuc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXnm8j17q1Yhro6i5iwTkR8e+i4yNgzH3agD
 hpv6s3fcFaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG1518UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277WxdD/0Z515FxE2Dy78AXT
 6LRWQ6gJdVM0xmzzUHcAgaqUxcdWQfdI/bMBQ5kn9brdEaU01JtyK3CQmH7QkdKoEXejfwDvd+e
 zTkBqmyNKMh4BHKXaejhgnQj+Tt77+JHqIK4+mvFXCfJb2YfW6BCkVgBL2D6Rwd5KqgwZA+TgRR
 Wn3FJ73G0hJOimgPIBchNlkK3PqwDqzLgL2ZfITkYtPjfp22Ea0eQIcVzQlXucs/9iH+YbgrAFd
 vOyGqCN89/0RL3vELFh1RarYDP1EUlLtjXv2qvcKMLlo6I3Z2PpOeTAK4a2Tv95MJV/QrmnfEZO
 pYV6wiSNGLKzLHnxbcQf1rteK3f4THkbBniV99tRpuppuJcRAGqQlBseBiSbnxuilYKDJOuE6Op
 Akk/CqFQUFlCdgXrnzCcOL9Z/ajhc6lFQXSqiSBJqmOsLgR/jgLeIlunV+wxWupvPmw6raO1GlO
 /GyhOLXt21v39iNNk6s5YWDHk13rShWiUT5aBBxpQXqpDvMPPYYX16crjl1Sty6ExX0qsVE/f3L
 j6QapTHXTXqlnm+srvHquZjU7VECU6y4ce71ppC+Fo4AwR6X5Izn92tAKM/ohSk3vgi6iR8xqM8
 da/ZzTAoLwPu7cFW4HrW9SON/onhLfqTWtqrkP3aOeQZ59ERAWqExASipyaCqlcgPVLQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
MAC compatible to the A64 version.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 7fe0352dff0f8d74a08f3f6aac5450ad685e6a08..7b6a2fde8175353621367c8d8f7a956e4aac7177 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -23,6 +23,7 @@ properties:
               - allwinner,sun20i-d1-emac
               - allwinner,sun50i-h6-emac
               - allwinner,sun50i-h616-emac0
+              - allwinner,sun55i-a523-emac0
           - const: allwinner,sun50i-a64-emac
 
   reg:

-- 
2.49.0


