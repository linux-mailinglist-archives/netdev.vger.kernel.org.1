Return-Path: <netdev+bounces-114002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E54940A2B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59252844A6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEC18D4DC;
	Tue, 30 Jul 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXKCgQVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C2150994;
	Tue, 30 Jul 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325603; cv=none; b=joqulQJzh9rGWNxUrzVvdW04JsuMrL58CIfhjaWBsstv7rA+bP6NuqjsjKhRYbYaLUyDrgMdoGzcmYv03Mz3eeOoAk9x1noYiC62tag36s8dXTSkPuLeVdMZZzAkQt9yfMB5HkvgvSf5ExEjRyjEt4YgS1Nu6odUGhvin5k66nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325603; c=relaxed/simple;
	bh=/1UyRDxDBbUGDXPzIHV51t98DfSsIxNOuwNCDXhMy8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrKWAbmL1EITQE6YfjMUrIPeH8rlZGTbmcfAL4sMLCxlwu04k4HQeA/VV8wSF+HOtQCLpiyqnwaik2C3A3SWJde7BgYsOW5q0JKmfbiyT40LE8yVn4TT3eGNq7JAqCQj6bFJqqWRgkAQZtRcEQXpXwDg7cQx8EvWea28U/LsfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXKCgQVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10014C32782;
	Tue, 30 Jul 2024 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722325603;
	bh=/1UyRDxDBbUGDXPzIHV51t98DfSsIxNOuwNCDXhMy8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXKCgQVUgiMD5DnjrQb/DEV0shSrPRhqhFWAtn5UXtlH2T3H/uPDfIdnLZRJUf7wl
	 bahgfr4dJTU7ghCKtPujgbllaURpJgo2MW4pewmQhrEf6MnuKRPe4NSBVAfYxiCjCr
	 apLGIfQ9+9AWyM4TCg2LysicG+oulsMtA4JQwhNvAnBTrM56J9SvY3vWwOBnl2S3g1
	 WtEnebNB2r6NvFfgHwWV95wagZfho/z4Zzdo9G42QQYF5NBbR5MYJ6RBDR+zOBberx
	 1qBH2UbgDoxBqc0yLxyvTs6JX7gpcdqru2ZmwlMrx/X90dkfw7H33Hs1lb/vcEyzsB
	 TSMVt7IQVl5uw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: Add airoha,en7581-switch
Date: Tue, 30 Jul 2024 09:46:32 +0200
Message-ID: <63f5d56a0d8c81d70f720c9ad2ca3861c7ce85e8.1722325265.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722325265.git.lorenzo@kernel.org>
References: <cover.1722325265.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the built-in switch which can be found in the
Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 7e405ad96eb2..aa89bc89eb45 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -92,6 +92,10 @@ properties:
           Built-in switch of the MT7988 SoC
         const: mediatek,mt7988-switch
 
+      - description:
+          Built-in switch of the Airoha EN7581 SoC
+        const: airoha,en7581-switch
+
   reg:
     maxItems: 1
 
@@ -284,7 +288,10 @@ allOf:
   - if:
       properties:
         compatible:
-          const: mediatek,mt7988-switch
+          contains:
+            enum:
+              - mediatek,mt7988-switch
+              - airoha,en7581-switch
     then:
       $ref: "#/$defs/mt7530-dsa-port"
       properties:
-- 
2.45.2


