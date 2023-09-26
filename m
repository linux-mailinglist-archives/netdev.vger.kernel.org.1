Return-Path: <netdev+bounces-36260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB77AEB13
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B85D71C20829
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F211266BF;
	Tue, 26 Sep 2023 11:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28735381;
	Tue, 26 Sep 2023 11:10:38 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39852E5;
	Tue, 26 Sep 2023 04:10:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c571029a36so9430295ad.1;
        Tue, 26 Sep 2023 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695726637; x=1696331437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lw4LOW9v/3DFm9VyRP52ODXPQwHjn/OUSwNkQdFfjXk=;
        b=YpE7J6YhxDp7p3+dbKKk+mECu/1WTZ+gQpFRLA1KIoiuPOuRnrHX5fp3Sy/thLL4gp
         dtHxt+BQsxJi9PtONk704MUs8KcWQm9FdcXJvgLhvJ4P7D5xoqiunKWDCHhxBGUIguFX
         By29mCzMHD+4a32iqjZDrct6LdjY3dbmadxKJy/i89QBCRf7sgBANyRYl06GC1PKUGW6
         7bbfv5wW8VuM5Exe5KJgGXu3hoF5GT3SZ6M16QZrQs5pnnwV+amS+hbJO7EZrcRSfoeB
         fZRCWKP6mvbyeXJo3Hhvidefe2yvSt3qkjTg5a1+ztO1SQHfJUTdBMG+b4I7Fxzqhilc
         2H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726637; x=1696331437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lw4LOW9v/3DFm9VyRP52ODXPQwHjn/OUSwNkQdFfjXk=;
        b=nuf4N76bJjbKRpNJaWrh0zo0++Dz2EQbspxh15Dj4wDWbs+BsEGDbbAaba4LZxeGW7
         474TGVtiW7gxQ4XU0AEBFxwpzKHLeDvCWPJpZGQu/bYfswOTU+oNUv0OEgTNTenhNTSg
         O7i5iwsmOPLLkgSeTqb2P0br+w+P0SsyraXWU44akwRbXHKFweg+R+9eFns+k7VGS1rS
         F7GWIzUBEFl3R8B+y31WLCqSgRGv2MEAJG761GbuvE6Dd2sh3isLL4slqVke+Hde5GHc
         pSpJmdHpsjVODF5tCezkb3oexEueD9u+mjj30FOahlLrP7JSVj/0O2+jZ64y7e+bfD3n
         MYQg==
X-Gm-Message-State: AOJu0Yxo1Kanke/v5rczBoZtgTmdfMPWWPPDjUxDJll4GC3ce/Hg5LXL
	cls7uO68Hl2ozF2jMc/w9Tc=
X-Google-Smtp-Source: AGHT+IGOAAXOyVjv/e8Cm+Y5b01Cz9RxiLJ3YUtO8aGN9PmwqbVaYwOGZ3EHuPY7/KX2pncQs5U6Hg==
X-Received: by 2002:a17:903:2acf:b0:1c6:9312:187 with SMTP id lw15-20020a1709032acf00b001c693120187mr435027plb.3.1695726636512;
        Tue, 26 Sep 2023 04:10:36 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:87f:ba12:de84:998e])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902740b00b001bafd5cf769sm10675422pll.2.2023.09.26.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:10:36 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kuba@kernel.org
Cc: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	linux-imx@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 net-next] dt-bindings: net: fec: Add imx8dxl description
Date: Tue, 26 Sep 2023 08:10:17 -0300
Message-Id: <20230926111017.320409-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Fabio Estevam <festevam@denx.de>

The imx8dl FEC has the same programming model as the one on the imx8qxp.

Add the imx8dl compatible string.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- Sent as a standalone patch to netdev folks.
- Collected Conor's ack.

 Documentation/devicetree/bindings/net/fsl,fec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index b494e009326e..8948a11c994e 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -59,6 +59,7 @@ properties:
           - const: fsl,imx6sx-fec
       - items:
           - enum:
+              - fsl,imx8dxl-fec
               - fsl,imx8qxp-fec
           - const: fsl,imx8qm-fec
           - const: fsl,imx6sx-fec
-- 
2.34.1


