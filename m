Return-Path: <netdev+bounces-43355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 821267D2B0A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8136DB20D0F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F8101EC;
	Mon, 23 Oct 2023 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyTtfBu4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62016D51F
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:19:12 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2692D68
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:19:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507ad511315so4346990e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698045549; x=1698650349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+/3Yi7bH7Hi+uUsTmtck0vYZ+i95ClqTO7Rae7/KWY=;
        b=OyTtfBu4qKkr7k8OMwSW7yFdNYZpNNezjHtWYTgCAEWaj7GmJzCAUt0Tm+heziy38Z
         DqqdTCHLvMstMVJeGSLEWBqfoxAfp3nbr7/DN3Xd3tqPPxbkDXqwAq3JvAQxGns4oyZ/
         9nh01ivG9ufEDchE+dnfQjumzjFFcOWoKpuoOL5pnjubukbCywo0UYvXo+BDuCMiwL/7
         gs5O1MSkVZ4tL/TFO8DixKeM0oTZzkCMRGlvpji1Fp/oBB6yTG4zpbQBY7x0WUZ8lEHn
         g26VBTofwFQTy3nF9fqVa90oYYW8lugkRCoHx4qp3fOjaJqHR/O+MCriqGbELEHUIf+3
         fWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045549; x=1698650349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+/3Yi7bH7Hi+uUsTmtck0vYZ+i95ClqTO7Rae7/KWY=;
        b=xDmQ4tTQ+ZVlaVJqiGyRey8CCpi5Kz0Zpsl7xXh3ggpd2la0C1K79KdyArxcEReTHq
         UJUR45yGVxy2DX0BpuDLAtlGGcm3mWFZ6QUMfDdG+rDpZnltxOf30nNLlh30E/UDUgcm
         JTwzaWjvggKmXhtZOGPJI4bfyDzvT/V5Bs1vFSlwPRx2MLYioMWMh3VRIvD0TLGlbwU0
         1hsy52z7IXZRZpMVdTSjVSV037CjWXKBreo+3JRwYg/VbDkSVlRQCL+yB+FRe23lyplR
         fVoQWNuds3FFdRkdwUo447/BdSAXLJWySxnwM9zVRYr03uBZvfLlg5zUBZ4bVi7TKX7/
         oFWA==
X-Gm-Message-State: AOJu0YzHK21nxJfUdcX36tePPdzszNY1FE00/IGJQZ3CG5m84HRXgmnd
	3lQXJmbzHC49zADtCGCgUATHsg==
X-Google-Smtp-Source: AGHT+IG5r+tT4MejIfpg3DlgLPXtjo3f9TOqwvkBhhFtIokEWdfdK6p9carAyQ3rI/AH8+g7bjeVXQ==
X-Received: by 2002:ac2:5bcd:0:b0:500:b553:c09e with SMTP id u13-20020ac25bcd000000b00500b553c09emr5167474lfn.32.1698045548975;
        Mon, 23 Oct 2023 00:19:08 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651204cf00b00507a682c049sm1578727lfq.215.2023.10.23.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:19:08 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Oct 2023 09:18:53 +0200
Subject: [PATCH net-next v5 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-marvell-88e6152-wan-led-v5-2-0e82952015a7@linaro.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.12.4

When adding a proper schema for the Marvell mx88e6xxx switch,
the scripts start complaining about this embedded example:

  dtschema/dtc warnings/errors:
  net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
  net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Fix this up by extending the example with those properties in
the ports node.

While we are at it, rename "ports" to "ethernet-ports" and rename
"switch" to "ethernet-switch" as this is recommended practice.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
index 3a3325168048..ab838c1ffeed 100644
--- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
@@ -50,11 +50,14 @@ examples:
                     #address-cells = <1>;
                     #size-cells = <0>;
 
-                    switch@0 {
+                    ethernet-switch@0 {
                             compatible = "marvell,mv88e6190";
                             reg = <0x0>;
 
-                            ports {
+                            ethernet-ports {
+                                    #address-cells = <1>;
+                                    #size-cells = <0>;
+
                                     /* Port definitions */
                             };
 

-- 
2.34.1


