Return-Path: <netdev+bounces-19822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22D75C847
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B61C216AE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B361E522;
	Fri, 21 Jul 2023 13:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC61E521
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:50:18 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F12D47
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso16724805e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947414; x=1690552214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KudsjLXhwuLL2d8mNXrF7qeXjTkj4g+r6rSckABUYoI=;
        b=2NRn1us4t8D9/KGOVraAzRc2weO/CjZXoBzsExFWUhmyPHDl72UmZxVzGMFDc3H1Vh
         thh0QV6x1cXr1SbNkzzAfb1RiM8sIjv7A6OSI6ptrghyhASXcEsRB1q7STOT++4a/EL4
         C4peKQRi7m1KnP+lQcvkRfV0oyM20vFfuFbk6lJA14fEAKeKbXTF5HBd+zIrFqivY+Dr
         hMOKoYYM/9C9Yn8Q6ll9glrDw78EQXHPerif78lw+U07UwaY9Wq9FqtW0HuOfUM5IJB0
         Imz7CrkCci7JRzryeG11fmu5o24rWNGEF1TYkNukynVEbizabHeXhkLYim/OPbdKAid2
         M9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947414; x=1690552214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KudsjLXhwuLL2d8mNXrF7qeXjTkj4g+r6rSckABUYoI=;
        b=ToyBmeDumn4pe1T3i+81KwHX17F4BUw9TXHYqKvpP0u1tQ9YTen7slJNN6ERNxy8Nf
         EFJ1M8eSTiZCzQq22ST6CcIsuk0yTnbLjSBSjP5xIj5f3KgTEAXXAdmEtxDWmVkEDLYh
         whRcVBYcm8J8nQiCoEUKxL7FBEWo+MoZtWlrNOrPMLGer/OIreRTb3RQYcdlQrJsn1Va
         H6nh8h4ZDfWZ/Te+o6OYrQImcHue4T/CVBBVS9xNOthR2lnXx6sV6TTqQAzDLnlxBAsr
         94AEdAHKhlMvXhnNFbvBkqCxy913UNJx7YDBxa1N62LFjHvWQl0qb3PxUJgxehPF4pbl
         RYoA==
X-Gm-Message-State: ABy/qLbLGD1XafU7cB+aO/iOiD3HWVZXuilzlhzT8sLhgZhGzzxWCrhm
	FKmgsSpDyE8rXgYptjj+LNrksg==
X-Google-Smtp-Source: APBJJlGy8l6nTjn/bwx4Y+p2EQ3hAmXUAqfqxoruusVPi9jJd3zuTXBD4Lq+gisE6u+oGQ6dQMus0A==
X-Received: by 2002:a05:600c:2802:b0:3fb:c462:1833 with SMTP id m2-20020a05600c280200b003fbc4621833mr1493076wmb.30.1689947413829;
        Fri, 21 Jul 2023 06:50:13 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:13 -0700 (PDT)
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
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
Date: Fri, 21 Jul 2023 15:50:04 +0200
Message-Id: <20230721135009.1120562-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These two new chips do not have state or wake pins.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


