Return-Path: <netdev+bounces-97863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882F8CD910
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98CB1C214F9
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40CF208C3;
	Thu, 23 May 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToN4s1dW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C27E579;
	Thu, 23 May 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484667; cv=none; b=fvVo+A+fhEYtFr6UjTj24P/qASsw7vpEKG5uN3ExQzqXjcleZbqNgANbIZKU5CVrgl8aIbXsCrlu2HLvyITMUKwJd1qn/p9V4eweGmWNVXEmGVg30CgVuB83Vd3QlUxdrSpABz0uKzcQ8AFq7jp5mCD72Vm4qPqrjA0f3cQFDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484667; c=relaxed/simple;
	bh=2HCxjEfldLUhKTCVa67RtcypiPf5ZVNtuVIDEzk7ZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BP+G/xcdwLAemkIyM85umt7uu6Ii9FTpqIfG/nx5eN/8Z9+iBUzA4Cnja2TMIYt04xav9Q52vfiBSSFm6u+mHP5gShQOVFAl8FscwZfJUmIrfnnqmVmahvA3GBFt/A4ZJakiLazPukD0KF9XumjxxVYS/4HywmSljoAc92yOcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToN4s1dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF10AC2BD10;
	Thu, 23 May 2024 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716484667;
	bh=2HCxjEfldLUhKTCVa67RtcypiPf5ZVNtuVIDEzk7ZJM=;
	h=From:To:Cc:Subject:Date:From;
	b=ToN4s1dW17A1R/FOeMiPG3gtXzGDWScO8+WWrKORoXh4XD1NpYWWfL00eRxje2XfA
	 eNzR6UYkXkj+mEjNSi4jCXFzNO5cidrG/syJ7yTTedwTKV+pqL6t1UtFJuxEKFizHb
	 n887EgQqvw8uz8SghSSP9LpuIdED2gPvTS04xH2J0JHEYqOyk7+QaZEo3jNjTgiZQc
	 vAGgS3/jfw7LfpVqMmqCi5fyEbXEVIkmosAI6NFobB8zqPLavV/ZduWH6kArSHEmqz
	 zPBNonxVP/HyRXVe9741e/j3ywKqy8QgdmZEAMmAHzCOMBmjyCbm7+JDPN8fr3uMik
	 xeiRZiuMj+ZTw==
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
Subject: [PATCH net] dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing "additionalProperties" constraints
Date: Thu, 23 May 2024 12:17:31 -0500
Message-ID: <20240523171732.2836880-1-robh@kernel.org>
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
constraints, and fix the fallout of wrong manager node regex and
missing properties.

Fixes: 9c1de033afad ("dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index 828439398fdf..fd4244fceced 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -24,6 +24,7 @@ properties:
 
   managers:
     type: object
+    additionalProperties: false
     description:
       List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
       have 4 or 8 physical ports according to the chip version. No need to
@@ -47,8 +48,9 @@ properties:
       - "#size-cells"
 
     patternProperties:
-      "^manager@0[0-9a-b]$":
+      "^manager@[0-9a-b]$":
         type: object
+        additionalProperties: false
         description:
           PD69208T4/PD69204T4/PD69208M PSE manager exposing 4 or 8 physical
           ports.
@@ -69,9 +71,14 @@ properties:
         patternProperties:
           '^port@[0-7]$':
             type: object
+            additionalProperties: false
+
+            properties:
+              reg:
+                maxItems: 1
+
             required:
               - reg
-            additionalProperties: false
 
         required:
           - reg
-- 
2.43.0


