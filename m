Return-Path: <netdev+bounces-47442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526E7EA4FC
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE5280EE3
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AEA22F18;
	Mon, 13 Nov 2023 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZLdYdHQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19D22F03;
	Mon, 13 Nov 2023 20:41:18 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B9D55;
	Mon, 13 Nov 2023 12:41:17 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e99ecda011so619145fac.1;
        Mon, 13 Nov 2023 12:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699908076; x=1700512876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjhVxR9xvk3uVFxU60gT4sdwmpoKVzcHYNMozCqBdSU=;
        b=ZZLdYdHQ6mTurKsJyO/bN4rwYcE1qC8kzyoc8tzZz+qkoWFib8b7G0Me6hzePCg4iA
         sF5zTxcAqD6z4fbcKe0XlYrSBEJE/6t8Jk3J4l8trG3PCDf1JYNR8WqELROb3ki7OF0e
         9bR8buDgH6i4FIbjV2kIa5t2hVm4YqTfguSkfskqJtb8Lu7W2KKqldOQUQmTh/TgOjTn
         q7I+zzzq6kkS4iMYs8/WpO/RHh3cViQ2yZFZ6lXywaA1l+YcaT8vzIR1YJTyDKckpZR2
         3s7HRFwK8FCWH5BmhdvD+NrZGlc2w1BB/RkwKNb71bmXVpBVEsw6efCs1iVV+YeV+4gl
         HruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908076; x=1700512876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjhVxR9xvk3uVFxU60gT4sdwmpoKVzcHYNMozCqBdSU=;
        b=xQE3HcTBoR3Dr5h5qavXj463eftnF0O3bB3opUifnLOgo3AwufY1AWGhwAcCrubfDE
         ZxebhENkEtOj87uWFDVvp8zE2COChKAcTCmdyfsmxrUIM1vXqOt+AxmjO6wOx9TPqU/x
         PVwDS6aoM55+8qVUegs61QEhEJBTHhUVxcICjENRBzyS2CPzyZ7nlUQk1dFX26/Yb5AP
         oU9WCiKjo/uuYLKeLWC3PlIAuj33zByM0r4lV+m0Gdr/+AjoiC331h1HSVRA99lHTGdX
         OScKltxCQuFeDejXHObXqK+KNAh/0nCHQ3bE/kwJaG4aN5uhsdYzj/QcQO54jTtj7ufv
         vQcw==
X-Gm-Message-State: AOJu0YxM7Wc++kaUiH/1Z9IAkiZnbR5D5pE2V2/clRT7+XKDQJ8ReRSe
	6A7GPPgq2fAKYK2lgB69EYE=
X-Google-Smtp-Source: AGHT+IElAnAF5X+WlnpEKAR8g6AlfIU0/KQVvCmZSnU5Zhfv80S62sJu+m5GnvcmvSfmvzGE3ltXmg==
X-Received: by 2002:a05:6870:9a29:b0:1f4:abd:9f5b with SMTP id fo41-20020a0568709a2900b001f40abd9f5bmr272207oab.0.1699908076484;
        Mon, 13 Nov 2023 12:41:16 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:221a:b999:fa92:3c9c])
        by smtp.gmail.com with ESMTPSA id dh3-20020a056a020b8300b005b93dee7fa4sm3829299pgb.50.2023.11.13.12.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:41:15 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH net-next] dt-bindings: net: snps,dwmac: Do not make 'phy-mode' required
Date: Mon, 13 Nov 2023 17:40:52 -0300
Message-Id: <20231113204052.43688-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The property 'phy-connection-type' can also be used to describe
the interface type between the Ethernet device and the Ethernet PHY
device.

Mark 'phy-mode' as a non required property.

This fixes the following schema warning:

imx8mp-debix-model-a.dtb: ethernet@30bf0000: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..6c0d9e694d76 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -505,6 +505,10 @@ properties:
     required:
       - compatible
 
+  phy-connection-type: true
+
+  phy-mode: true
+
   stmmac-axi-config:
     type: object
     unevaluatedProperties: false
@@ -564,7 +568,6 @@ required:
   - reg
   - interrupts
   - interrupt-names
-  - phy-mode
 
 dependencies:
   snps,reset-active-low: ["snps,reset-gpio"]
-- 
2.34.1


