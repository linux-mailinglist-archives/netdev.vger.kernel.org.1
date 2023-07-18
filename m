Return-Path: <netdev+bounces-18725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D085758617
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5FD1C20E23
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23636154B3;
	Tue, 18 Jul 2023 20:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02726D2F5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8393FC433C8;
	Tue, 18 Jul 2023 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689712353;
	bh=FLSmACyrVItJxGL2yS/j6SnE6NSUcX7aKrzHK7k9U3E=;
	h=From:To:Cc:Subject:Date:From;
	b=QyklfGbtk3VN1ylhAY7Qw8wPNB49l2zLLLb2XZTsD7k+TbHniEmA69uxamN67xBTd
	 AsZK/PkMW/bL0ZH7T1EaR899r0Q0GGqxkArQnuzKvPcyZDFx52gtzE7jnYRkQ6vSXz
	 IIy5u4GQY5SqlucvIQizDc3sCEYEldKGa+so2wBr9PpLEOGWaizlR3DMsttrZZorwH
	 mnzxFudb6Pr27N5Ol90+AEDir5xFUQ+eoeJVCrNmo+GXg9iM/chPilca1MdApzURS4
	 s+HHIE4BO/P/UDn+dfcqGajLjpcqM5SwGu11LJgbJFNqKSMfWrMSVOfEEz/YLmi4hp
	 Zm+x1fVwMUC/Q==
Received: (nullmailer pid 1761854 invoked by uid 1000);
	Tue, 18 Jul 2023 20:32:31 -0000
From: Rob Herring <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: dsa: Fix JSON pointer references
Date: Tue, 18 Jul 2023 14:32:03 -0600
Message-Id: <20230718203202.1761304-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A JSON pointer reference to the entire document must not have a trailing
"/" and should be just a "#". The existing jsonschema package allows
these, but changes in 4.18 make allowed "$ref" URIs stricter and throw
errors on these references.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 8d971813bab6..ec74a660beda 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -36,7 +36,7 @@ additionalProperties: true
 $defs:
   ethernet-ports:
     description: A DSA switch without any extra port properties
-    $ref: '#/'
+    $ref: '#'
 
     patternProperties:
       "^(ethernet-)?ports$":
-- 
2.40.1


