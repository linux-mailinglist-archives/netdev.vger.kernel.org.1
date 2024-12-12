Return-Path: <netdev+bounces-151321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1280A9EE1A7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77924165DE8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77820E014;
	Thu, 12 Dec 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcwzrMhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016420DD48;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993057; cv=none; b=LpzJ9FkHOmc8Di0TiopcJ7t/+wrSRHMZoD/434RKqS4JlprVhTQ7G+PbH7wxX+H3KpPK++f8AEi8WlfYN2aUGzJ1x6LU+mW+ekhYBTkBSwrjAeRx4ZrpUViQNjzFIfbbkiwsDJBggQ3yj43aCieGcPRW3RPUjDQBRs5iBT/5HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993057; c=relaxed/simple;
	bh=mzxUkpl/VW8zg/qcxT23Jk37zVt32M5rjm1tUX0zNjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/t4kjWqDGfugGDrJATryeLZWGW9VWV/nA0RRlvPz2Cj8jCge94F9NoWSWFcor28Y8boW4qe0M2AH+AUwPDgWdBXq9d1Hz6dkL+9JtGJcseUgdJg05GeofNgg6u+/sw0Kz8VV5q5ddC/7ZXNDTzBDw5KiiOZwIsWqMpGEvwoh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcwzrMhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDD91C4CED3;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993056;
	bh=mzxUkpl/VW8zg/qcxT23Jk37zVt32M5rjm1tUX0zNjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WcwzrMhVpwxVqdhTN46+bnd+8lwcXJZU/BsmclenF7xY80us7X4ohLdT3bgiJkCM1
	 TUVhayXLwbdo3X9BzavvGkh2hdQJsdC6E9BDk4tZwhG8isKvKM/Ht1Ams8wWSm5RSi
	 LO/mN4zV7vZIT20K2CN93USfE2iLgxZfNX3YheXHU45K9eU4HmwEJSI7DZPRM+rQBF
	 5y3s2qEMiakDHRYLGLmmuZ4ftZmvRowLNz9n8l8HAMWaMu+vNk70hWmYJVXx2WYfBH
	 byIxlcmyRc51dfeuOB+teT16bQ6fp4DSfEsO6j1ZQyPvmMy1ssDjLTYB6ZjDvnUodq
	 RSXeJSEy4Il3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7494E77182;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 12 Dec 2024 09:44:06 +0100
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dp83822: Add support for
 GPIO2 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dp83822-gpio2-clk-out-v3-1-e4af23490f44@liebherr.com>
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733993055; l=1961;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=oEDI75kHA2vxmaYUN5E6SgqscD6FI8Q9e8nx/xXgh34=;
 b=n8XOiO/Ng/08odC8bibzCb9PWP/hxxT+MhDB/24CxH2F0ml4yUwf2kM8V0Ti3L/ixt+OfqtVa
 rMZxq77zOA3Dth/DIULnOVnDtycq69eSwOMNL8VD/PXkBxFexZ9/kwP
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The GPIO2 pin on the DP83822 can be configured as clock output. Add
binding to support this feature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/net/ti,dp83822.yaml        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 784866ea392b2083e93d8dc9aaea93b70dc80934..50c24248df266f1950371b950cd9c4d417835f97 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -96,6 +96,32 @@ properties:
       - master
       - slave
 
+  ti,gpio2-clk-out:
+    description: |
+       DP83822 PHY only.
+       The GPIO2 pin on the DP83822 can be configured as clock output. When
+       omitted, the PHY's default will be left as is.
+
+       - 'mac-if': In MII mode the clock frequency is 25-MHz, in RMII Mode the
+         clock frequency is 50-MHz and in RGMII Mode the clock frequency is
+         25-MHz.
+       - 'xi': XI clock(pass-through clock from XI pin).
+       - 'int-ref': Internal reference clock 25-MHz.
+       - 'rmii-master-mode-ref': RMII master mode reference clock 50-MHz. RMII
+         master mode reference clock is identical to MAC IF clock in RMII master
+         mode.
+       - 'free-running': Free running clock 125-MHz.
+       - 'recovered': Recovered clock is a 125-MHz recovered clock from a
+         connected link partner.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - mac-if
+      - xi
+      - int-ref
+      - rmii-master-mode-ref
+      - free-running
+      - recovered
+
 required:
   - reg
 
@@ -110,6 +136,7 @@ examples:
         reg = <0>;
         rx-internal-delay-ps = <1>;
         tx-internal-delay-ps = <1>;
+        ti,gpio2-clk-out = "xi";
       };
     };
 

-- 
2.39.5



