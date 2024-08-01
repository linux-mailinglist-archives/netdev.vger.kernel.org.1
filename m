Return-Path: <netdev+bounces-114831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07594458E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599B51F223ED
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BEA16DC07;
	Thu,  1 Aug 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh5Ka41v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C916D9BD;
	Thu,  1 Aug 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497754; cv=none; b=Pf7yt5/0AbUXha9XMQBvrf3x2wa8k4DbOt/y3RVCJsSdu0pRTTyPpOJ2v2L6XFhv8aess0gynRILA4YruIpYv9LcGb7EK4yRZL/JNRW+P7GlwMNNLc38wSjkxQQChTAm+RJikWXPlszKhniM1gRCtwm/qBO8T5RTSy3KX3Q0bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497754; c=relaxed/simple;
	bh=0D2yOl3zvpdPmIbZ/Q8aSoiaOijPs/yLkfqLirVDDPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phf7Ub0n5Yp+EtrB9EHoryIdNmLnYNfQpMV4E+g9BVWN+23YYSj0U9D2L8MFRVM249kVgjvIi7i1ic2xwrUnVurKFLhCXHl05J1mXdKYDlC/bBS8/HU0uefk0rzbCa/3Z1OsGMXpJ/x04yXzDMHoMsg5YAZOP55JZO36wMjC6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh5Ka41v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052CEC4AF0A;
	Thu,  1 Aug 2024 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722497754;
	bh=0D2yOl3zvpdPmIbZ/Q8aSoiaOijPs/yLkfqLirVDDPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hh5Ka41vWtNQMjAnffTrHz+grZ8r1nlLTOVqmURjifeez+F0v/q044XHFQBkvULk0
	 2evzjRe+ULmYdxPNB5yAbV3EFa4MGOkyumRggcSH3XVNLRw+T8Mn1tboGYfbGOqTKz
	 CofnS9qEc7AeEGYwZnxmXxlt/WhbkmV25dYAkkyVq8YnVHWUPXJZoUh/fhmho3g45C
	 aedOWHDDs33wYsI+sRYLEDFhmft8dJUKeGHJIf+ONeJh9HFCXVigjPW+2OvTQP6dcY
	 rbLDGi0SAjr9oWTG4ypc7Cu+ifgKfLLXdtag/UnU2ShNkniO406bC/wEqfRjOq2GnH
	 1g/K08Ougqbxw==
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
Subject: [PATCH v2 net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: Add airoha,en7581-switch
Date: Thu,  1 Aug 2024 09:35:11 +0200
Message-ID: <f149c437e530da4f1848030ff9cec635d3f3c977.1722496682.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722496682.git.lorenzo@kernel.org>
References: <cover.1722496682.git.lorenzo@kernel.org>
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
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 7e405ad96eb2..ea979bcae1d6 100644
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
 
@@ -284,7 +288,9 @@ allOf:
   - if:
       properties:
         compatible:
-          const: mediatek,mt7988-switch
+          enum:
+            - mediatek,mt7988-switch
+            - airoha,en7581-switch
     then:
       $ref: "#/$defs/mt7530-dsa-port"
       properties:
-- 
2.45.2


