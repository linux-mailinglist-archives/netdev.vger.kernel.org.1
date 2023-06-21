Return-Path: <netdev+bounces-12519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27918737F00
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590DE1C20E25
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B2D52B;
	Wed, 21 Jun 2023 09:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE0D51E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:12 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFC1997
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f766777605so7522136e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339869; x=1689931869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUVZalfP6V27NAYz5kQTxrxcxQh7F8OqnR+1IuXKgno=;
        b=1NSCmre2p7CtkNBkBJvdszJkRwwGaioXWZdO9EoPmJnoKNEGXXEu6EFvU6OgprI5xc
         tNLkv1dB9ERCHrEUpnTmLZDBzjMzhSVv4UdIs49WCyTKl8Kh/tuD9bFDYntp0pq77pkh
         rAo12jFi/yvwkjV6rGqstr6iqTzJgJ65dZl8q2XnC53Duoonqw3IhHvngOffXYqqEG3N
         Xm0SbOk8kbFQCK3y7GZwC8TlYnRblyaNUE2ptaLDzkOoXlopaD4qC8VTiVYh/iUbrdSJ
         Fp3M3vuvPtPIWQV/Hz+KWNLxB8jMJSZf0+6FxPzEv16pO8LfN7RRV2bpfV9JQl2eBTws
         2q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339869; x=1689931869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUVZalfP6V27NAYz5kQTxrxcxQh7F8OqnR+1IuXKgno=;
        b=Hr9T0XCv0WuSRFso2T3JYCdLTSHq9n4CUtBDTqFVvb5v8sfmi3TuBDIuSqyUHQ686D
         ELR63qWjkPTtIpiJPJv0SU8sjEgvyshHZMrvqSAtrHO/27226+OhLgbVl+cJ+X72fXRx
         bc2MSGSKw9F6NftcTI1gEkUfu47QwY5iEe+uJd4rK8Xx0/aj07RkHdeikk5u9tSXdPjp
         DDCbVJz7KReGPRZUYYcPgX1G+qrdzMapJW6+hFTWcZUF/kRemV+Bc1vL+lgwCm6XJRSY
         itRg1VX/xj/R1++X+Bhm+v1oRktqLn+7L+8oNK24Mks+xA4oHRBE/nurYc0aC7HKudIw
         Sr6g==
X-Gm-Message-State: AC+VfDxUUdMdi2mTPUT5OPneW+pbHSEUgytLZVSwnGFvtsUNy3vSxKgc
	+fZZ5OOKoOFvht9JQuDDzHppuw==
X-Google-Smtp-Source: ACHHUZ5niONPbfuy2pOl3UdRueK/q4eJCqkzPPKmPZ8iuLpRxdjpzGVdHt5BRKAlNXSVVVJQYSq+HQ==
X-Received: by 2002:a19:5053:0:b0:4f9:5519:78b8 with SMTP id z19-20020a195053000000b004f9551978b8mr2520136lfj.63.1687339869403;
        Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
Date: Wed, 21 Jun 2023 11:30:58 +0200
Message-Id: <20230621093103.3134655-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These two new chips do not have state or wake pins.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index e3501bfa22e9..170e23f0610d 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
 This file provides device node information for the TCAN4x5x interface contains.
 
 Required properties:
-	- compatible: "ti,tcan4x5x"
+	- compatible:
+		"ti,tcan4552", "ti,tcan4x5x"
+		"ti,tcan4553", "ti,tcan4x5x" or
+		"ti,tcan4x5x"
 	- reg: 0
 	- #address-cells: 1
 	- #size-cells: 0
@@ -21,8 +24,10 @@ Optional properties:
 	- reset-gpios: Hardwired output GPIO. If not defined then software
 		       reset.
 	- device-state-gpios: Input GPIO that indicates if the device is in
-			      a sleep state or if the device is active.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+			      a sleep state or if the device is active. Not
+			      available with tcan4552/4553.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
+			     available with tcan4552/4553.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
-- 
2.40.1


