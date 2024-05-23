Return-Path: <netdev+bounces-97864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332478CD913
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20D1283614
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1721364;
	Thu, 23 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvTDjx95"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBA7F481;
	Thu, 23 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484677; cv=none; b=kkrXJCUV9Msan2Ta+zb4faRczctsAcDBdofWwLseKF/oWK3knJK65sLYlNny2ZHYjQg8n4Aq/x+evGDK8qR451OJwk6QJd1J7hi63Pqjz4LnuROMhfy/E1WJ1LcOMmxot8+lXZ43zJbjbKLSc6lFS2lb2gLj/DB4zdsc5YR9ZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484677; c=relaxed/simple;
	bh=4DkinzDiJDJS1Ql5eStXQ4vQlwTn1UEISiw2ImwQHFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjioluwag0CAff2Y7HHx9eOX4WHDwqTKdnw27WlUZAoYBJNQ6tgg2P8PDfpmjauqfD4tfycjW8SonMdMNuuFBvfu8pv0NrvUrRT7pl4SjqEofGgUWEGi/V19prTCUbgCvll5I3fZ2DiwS6rx2wiKv5EEzgggqKi5I8E6CmsbrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvTDjx95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8B4C2BD10;
	Thu, 23 May 2024 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716484677;
	bh=4DkinzDiJDJS1Ql5eStXQ4vQlwTn1UEISiw2ImwQHFw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZvTDjx958B8uTjExsNmhgPDCNuwcQG2OpDZhgQwVTM1/S+B4wrNGa4IXWZBbg+2wB
	 WWxl0zQOwIkFga4s0L1WTVEUdTylyEm4w/m27BH83Xjwxp2JssqzZrhQGnZWyAzaa1
	 tltXfTv8aetTMwKoO7FxrSbhA1wihnnPuh9PunAGV7T6hO4ryF16gxEgvtFGae6B6a
	 YFIvyJr01uNCKrzspmfeSls976LzXscHcRTsig1UTs3E3Hi39dgNFEGg2AIxw5YmLX
	 pwVTraf0ODLqmVM9ub28kdNccScbxQ8TeQdVcXQVz9RyqH51PDN0i4clbMQ7aYvLCb
	 jQbovYUr+yJFA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] dt-bindings: net: pse-pd: ti,tps23881: Fix missing "additionalProperties" constraints
Date: Thu, 23 May 2024 12:17:50 -0500
Message-ID: <20240523171750.2837331-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The child nodes are missing "additionalProperties" constraints which
means any undocumented properties or child nodes are allowed. Add the
constraints and all the undocumented properties exposed by the fix.

Fixes: f562202fedad ("dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/pse-pd/ti,tps23881.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index 4147adb11e10..6992d56832bf 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -29,13 +29,31 @@ properties:
       of the ports conversion matrix that establishes relationship between
       the logical ports and the physical channels.
     type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
 
     patternProperties:
       '^channel@[0-7]$':
         type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
         required:
           - reg
 
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
 unevaluatedProperties: false
 
 required:
-- 
2.43.0


