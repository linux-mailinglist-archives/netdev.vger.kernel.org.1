Return-Path: <netdev+bounces-202120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E68AEC53A
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DBE1C22F22
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42E21D3FD;
	Sat, 28 Jun 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn1IiSQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60621C185;
	Sat, 28 Jun 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751089487; cv=none; b=luYs3D/uKttOCSXAc1fXeRw3KHjEiTtg1gJKYhu8YC58NP+KSUKfAdrj4b2LlJiur5LBlpjp5zkE3Od1pk5eXDxqYBYY7Sgj01ejUjqW3h39fbKSQpiqcvyl2kn2WCH/wIZ9zrC6PA3pfecCDPkwcFjyDkAod4MY53+KNXJIauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751089487; c=relaxed/simple;
	bh=mYZq/vP+pCKa5Srrcf2wrhmjIPn3LNdwFBkoYlVxsJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT+MjShp0HKsDB7OAFL5zFxwIPutoUNQtH2UHve7hYxb9HW237K0KfPOmGk1k5E9Vf5a1w77gZelMAxafD1gLAJMpYMw7pD8UJzOnFNMWEElr/ZsqsPpxyz+sXlGA1NvMDc76vlcs901hqPhy6ug/+kmyZ62HlcKyXnENnoO7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn1IiSQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC7DC4CEEA;
	Sat, 28 Jun 2025 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751089486;
	bh=mYZq/vP+pCKa5Srrcf2wrhmjIPn3LNdwFBkoYlVxsJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vn1IiSQbeMP6wuA2F27dtSqdbp2ArbL00yPePouVZSblzDKNG8yXiOgK+nnkNuJaU
	 RnLf+f1S3+2cm5EFSVwrYLxHVkJUnAHPMHb95uceI3iP8OsmV0CPFEWP0vKpb94jtY
	 MM9eU+jbuPpIDvleBvdNxN6GQLh5Fq5mdutZKuXAdNnLyXAiR9tv4K+1MzQatOHG1R
	 NANJ+P5LgkglaGAmnQKcbSIdkd0REHSyfETz6YqgPpmhciSz8BrFG+9HkmWeNAomdV
	 2xHC+zSqtOic8OqyBGAv0nwayAAKBADruI0Ots7SIlBd3y1OSV8/Oj5ZPrQSiGwh8E
	 aNO7paZO7eUSQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 469805FA91; Sat, 28 Jun 2025 13:44:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH net 1/2] dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0
Date: Sat, 28 Jun 2025 13:44:37 +0800
Message-Id: <20250628054438.2864220-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628054438.2864220-1-wens@kernel.org>
References: <20250628054438.2864220-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The datasheets refer to the first Ethernet controller as GMAC0, not
EMAC0.

Rename the compatible string to align with the datasheets. A fix for
the device trees will be sent separately.

Fixes: 0454b9057e98 ("dt-bindings: net: sun8i-emac: Add A523 EMAC0 compatible")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 7b6a2fde8175..19934d5c24e5 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -23,7 +23,7 @@ properties:
               - allwinner,sun20i-d1-emac
               - allwinner,sun50i-h6-emac
               - allwinner,sun50i-h616-emac0
-              - allwinner,sun55i-a523-emac0
+              - allwinner,sun55i-a523-gmac0
           - const: allwinner,sun50i-a64-emac
 
   reg:
-- 
2.39.5


