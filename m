Return-Path: <netdev+bounces-17694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FF752B91
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA51C21454
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F020F8A;
	Thu, 13 Jul 2023 20:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA398200D8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:21:32 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01D2D5D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:21:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so10609295e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689279688; x=1691871688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu/GDhcwUxsvL43jGqclDZQDypGt+f942j4Xw/QXrGg=;
        b=YkD+Q83ltv+kU8HU1a1in/Vn+A/+Xwen6hJBVY+vo3OV5uUfwbiU2zsuoRGcRr6NXR
         QKCBiPjoCJNEBsjd9EFvtNFI+wumxisFxgWc3yqfLfLTeL/CyOeSwCifte3tAXiu8WGn
         XuXtW5w9SXyZEzJcQ/R9i7dj8YGVrFHwxR/pxPvTLTol/tZPHLKNqbjPiZmzf7rFDx6E
         Rh0URafWo0vEiE2KSlyLKp/e9pmgUtMv27OxKaNiIBVOzaumAiv09OiMbpQXw/IE81dv
         O14sgmFFcX3k9cC4fp1hgWZgjMzKx8Rx/H9XFSiAKOudZWz7G/z3nhjSvU4HoDw1y5Oz
         dNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279688; x=1691871688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu/GDhcwUxsvL43jGqclDZQDypGt+f942j4Xw/QXrGg=;
        b=Yg1qTtBG3yNPn2X1/lCP55Sxa+7KmkK1Gai8SqDDWgSceKJEYvpMb9wIDo24sxVg3g
         6/JKxKOAgLCaF0BTy+vymRnm0ULbifKPmJlLzlUrT0s6uxJLoaYrXWFH2T4qMJ1Up8sq
         A+mbLX2FwWDO0lvjt4yutMKcu24X2yo7Ife8HAK+lccksq8kq1+JCzCuK4Uas6tOnxby
         VTAq0SGn5uC0hVjr95+dOV+Kbq0RW8sGw0+ZT0NqZmtQFKatiVlvQUYWcm8gyVtOJUHN
         /+/FbcVEWecII24P8A963Z8ghSj7gHPXmoMWPWBMmKN0dPub7xTeK+btTNo418k8SBv3
         haKA==
X-Gm-Message-State: ABy/qLbg3OrHHEx6cu0c14Gss6Xxb68ZwZz/lxcOCCN66nTc3XJT6+mC
	Dh9K+aIbQDbBiF4rytDpzpTqvRHDxvCJRaA/VZjvvA==
X-Google-Smtp-Source: APBJJlHBykbtYqkHA08c+4gz/CRYPt9l0egxhftE4bkM/EwH/3Exd9LU6Vp1eWCc+sTTmMpXsjpQlg==
X-Received: by 2002:a7b:c40d:0:b0:3fc:1a6:7764 with SMTP id k13-20020a7bc40d000000b003fc01a67764mr2241997wmi.16.1689279688330;
        Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.168])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0031590317c26sm8880170wrv.61.2023.07.13.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	olteanv@gmail.com,
	alex@shruggie.ro,
	marius.muresan@mxt.ro
Subject: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document 'vsc8531,clkout-freq-mhz' property
Date: Thu, 13 Jul 2023 23:21:23 +0300
Message-ID: <20230713202123.231445-2-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713202123.231445-1-alex@shruggie.ro>
References: <20230713202123.231445-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For VSC8351 and similar PHYs, a new property was added to generate a clock
signal on the CLKOUT pin.
This change documents the change in the device-tree bindings doc.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Changelog v1 -> v2:
* https://lore.kernel.org/netdev/20230706081554.1616839-2-alex@shruggie.ro/
* changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-mhz'
  as requested by Rob
* added 'net-next' tag as requested by Andrew

 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 0a3647fe331b..085d0e8a834e 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -31,6 +31,10 @@ Optional properties:
 			  VSC8531_LINK_100_ACTIVITY (2),
 			  VSC8531_LINK_ACTIVITY (0) and
 			  VSC8531_DUPLEX_COLLISION (8).
+- mscc,clkout-freq-mhz	: For VSC8531 and similar PHYs, this will output
+			  a clock signal on the CLKOUT pin of the chip.
+			  The supported values are 25, 50 & 125 Mhz.
+			  Default value is no clock signal on the CLKOUT pin.
 - load-save-gpios	: GPIO used for the load/save operation of the PTP
 			  hardware clock (PHC).
 
@@ -69,5 +73,6 @@ Example:
                 vsc8531,edge-slowdown	= <7>;
                 vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
                 vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
+                mscc,clkout-freq-mhz	= <50>;
 		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
         };
-- 
2.41.0


