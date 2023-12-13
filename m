Return-Path: <netdev+bounces-57121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16C8122C9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9CB20763
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951EF77B2F;
	Wed, 13 Dec 2023 23:25:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC094EA;
	Wed, 13 Dec 2023 15:25:18 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5910b21896eso2343275eaf.0;
        Wed, 13 Dec 2023 15:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509918; x=1703114718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+ujX2KdbWl+FCDRkPG1EwpBH+yzRnhRj9laF4akgZg=;
        b=J8AuLG1oFZynBjB+2IRB6TgTuHbv4IxN4N6LHeUVSeyMy+86xMUaJLEfqqrNvR3urT
         Bovv2Q16Bgu4QtjKCcFlJMRV/utKHS728bgpvLJ1dlyX9kg0WkTdjzaE57SEd8MO/8Jo
         9/+uZJFTuLe2GmnZsSukM9H4OxWOCP2mZnz5mdwQS26yrEqnlipKfDXW11ITQj58uo/v
         qKFPbAhaHs7OkkPDzcgkwGf7b0kUQaMU3EH7arpDgD0aKjyyXefQbNWC+qoZ2FrlF6Ta
         HJIuTTnYDCfurGeC0/C1QQXH4YmVwXdzgHW/27fZWujrPIgLpPhPr6RdmsI0V6TOTH54
         zsCw==
X-Gm-Message-State: AOJu0Yw2BrD8qLg+ccSaEdcFGWdqJGGMn3DFVl1PQShW/IsfE2g3zzdH
	lfUyz3Jl4UbRaXq9Es7AGVwK/xjytg==
X-Google-Smtp-Source: AGHT+IGghdFnEQBv2Q1gGQFkdtduPobZx6ZkqkdA1mh/zFQx4tpk5DqrUHn56S1Ix93YoI+J2tsdhQ==
X-Received: by 2002:a4a:55ca:0:b0:590:67db:1dcb with SMTP id e193-20020a4a55ca000000b0059067db1dcbmr5555100oob.4.1702509918208;
        Wed, 13 Dec 2023 15:25:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r124-20020a4a4e82000000b0058cbbf9b4e4sm3251624ooa.48.2023.12.13.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:25:17 -0800 (PST)
Received: (nullmailer pid 2248461 invoked by uid 1000);
	Wed, 13 Dec 2023 23:25:16 -0000
From: Rob Herring <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg" sizes schema
Date: Wed, 13 Dec 2023 17:24:55 -0600
Message-ID: <20231213232455.2248056-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining the size of register regions is not really in scope of what
bindings need to cover. The schema for this is also not completely correct
as a reg entry can be variable number of cells for the address and size,
but the schema assumes 1 cell.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/marvell,orion-mdio.yaml      | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
index e35da8b01dc2..73429855d584 100644
--- a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
@@ -39,28 +39,6 @@ required:
 allOf:
   - $ref: mdio.yaml#
 
-  - if:
-      required:
-        - interrupts
-
-    then:
-      properties:
-        reg:
-          items:
-            - items:
-                - $ref: /schemas/types.yaml#/definitions/cell
-                - const: 0x84
-
-    else:
-      properties:
-        reg:
-          items:
-            - items:
-                - $ref: /schemas/types.yaml#/definitions/cell
-                - enum:
-                    - 0x4
-                    - 0x10
-
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


