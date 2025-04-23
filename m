Return-Path: <netdev+bounces-185164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A99A98C50
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD121893471
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BE27979F;
	Wed, 23 Apr 2025 14:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1E279792;
	Wed, 23 Apr 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417058; cv=none; b=CeQfhpvams37cQ5Rpoye1rH/1i+IUKPnZUiMLX1x3GJSlVsIUHaOJIfDwWkcrDL2nN+Btk0nmiihSJwWZZgx+5liPNYajY0t/gnoXQODlNyDegPA0kMNuyaTo+JriZ06JbQeUUGcss5EsIFyAlRxghQW2nTZJ/8hgBDRZMgm7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417058; c=relaxed/simple;
	bh=lKyymF7Hpjd26M8XcjHpoVGsP92kwq3xGudaxC8q40M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGUZ9aQHONWv6yY2Gf40OQ/UnPd7SUM8lA58WyOB/NG3PVrcnO6r9njKa4mJLYQVRxZO9BGMuH1Rw+w/rbjjJm93sdTFZOwsDsUptXrQWET/XmXaUOCZNWIozaVcywp2XkhD3iATjCrS/1/+bnGklmXmqfnFlDegItjRFTGLr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4D5DC3430AC;
	Wed, 23 Apr 2025 14:04:10 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 23 Apr 2025 22:03:23 +0800
Subject: [PATCH 2/5] dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-01-sun55i-emac0-v1-2-46ee4c855e0a@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=lKyymF7Hpjd26M8XcjHpoVGsP92kwq3xGudaxC8q40M=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPM/BF4N7i/TYB6b3RNTlrp4EIT9sg8KqYeMb
 gv6OH1IHvOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzP18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277XUmEACZ800KPPzNvd5qzG
 dq77Xn4pkeobCVGqmHVzjTxaG8jl6AqbrT+hPCyYVIysejlUeys+viVgGx6RvEZaUJM2BdhsmoQ
 hQ4u7z2XMeqFaUntVWbRDUsQnZNCITcWMAm9BaG68IYCfRCKteFo6xJ2+VOymprkW4HvTDOKXnV
 wZcpRU1q3q8I/OtkgcIhbZLP9xbZA1drlyOJ+CLwQ/kjXJn6UZQhDzSx4I8d8iveb6/67WmCUlC
 g9lNCSDGfrDvs9lmW4yff8cFC0twTdBx2JyvJ61nu+fEwAUgrpc9y58QAPSZN6mglDsdye8E5wH
 diV08zakE9J/fL63Sq01dzetXf2EeAVj/5qvHCkMMriTKNAg2dyKRyfBHCLAoI/2Sszo+sFoR0I
 s70uY4X8Xw9w7jpQM6Z1EwZjni5NoUisdb6U1RW282qfvTnxbYmcKIAqns3paow0Qs1ZS11Qha0
 JgNR7VkgsH4DyxPRR0mO2/SjSfT69hLdqTjtBC5YyygX5TSU1s5zMc+zDVZdKakWInM7CCvqN+r
 Nbj/WmuG+cxzTJ9EZ3Y4qeomWqagv2v35dp6PsF2Qq1jaFMVjb2r03J9Xtg1s4OKN1d3KdBSdsC
 mceosQP+8eVz4Nd8jeSMC70lknR5kQUeVEq6udQ1dP0HeefUDlqxJhFa+2Pbt6fAEaQQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
MAC compatible to the A64 version.

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


