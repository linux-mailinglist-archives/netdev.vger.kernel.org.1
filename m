Return-Path: <netdev+bounces-32707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC027997ED
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC11C20C41
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B03D62;
	Sat,  9 Sep 2023 12:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016820E2
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 12:31:18 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A495CD6;
	Sat,  9 Sep 2023 05:31:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9cd6876bbso774154a34.1;
        Sat, 09 Sep 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694262675; x=1694867475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgY7HioxQJzvc3UWMLxwvEq1yQkuAsHwT0/8Xxg7rnM=;
        b=l88P+m5HXH46LBBai+IRthcKBKjsBHGvZp02JrvhqsdqNYIBxeVQc5L/64T8cpaqOO
         fMC+ke64BVSMkyylAQwHBBG/gYlGHrmm4Db5cUDm1DT2//Dl4RQJXj2+hR0CBnchZei7
         TBBWzpCpEiaKjPxMJz+qvR1HbIkkFUvSs6TRaaHfJUuesiZh3OQvD8spwBfrajs72NET
         OGncuOim+IAm+uTbyaoUJKA4s8ms0jb8LArlq8OF4GpA2ijKmD+cc6EVUJKRZQnNwOOX
         5VEvpP2FpIorVY8qBiFRZz35tnBGfP5QoIgSz03N/tjgb2722SJEkXFcaVnTnPfT9Dnk
         oGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694262675; x=1694867475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgY7HioxQJzvc3UWMLxwvEq1yQkuAsHwT0/8Xxg7rnM=;
        b=jeYl7O73TeKVQUF6jweKj0mpIvuQflon01JVngwwlq1/J70zIpuERKzPTcM/r/QTdj
         lJFUJihBu2v9+/BpvDkBqugU8nIcHqaeVgzJMBg1WvagOPbXvzoEHwLBWpwRNxM8WcXE
         on0/AHmrEDjgmKBzjdGc+D7/uhwP0JPME3cv6WvcIw5VFUzC0uJmFqO4vB24d9i74fED
         hUU1BlF2KKh2SvSVD6+WPp24bS4BXONhzfy4DByuRdVzSxmupZmPb7QEwrI1XLIer2gg
         0lQUFIODwTpuwgJIAt2qSrLgJCoPLLnojuzWH1a3UyiBP0nGprYW671+iNwa6kUKQSoe
         UWiQ==
X-Gm-Message-State: AOJu0Yxs1LHk5WRoWLfd+qDvH6JdfZ+ifGXi9vOPkZllC+4jhGmtYhdk
	1j99Ykb5MZgh1asqhLJmTPb2hhkUUxE=
X-Google-Smtp-Source: AGHT+IFGuprHEw5ms/f99s1uQi2ZQFoU2Kt0Dwwja5deMWOKTzHZnqBNFdEOfdU4YjkLNPQq/CV/XQ==
X-Received: by 2002:a05:6820:a0e:b0:56e:94ed:c098 with SMTP id ch14-20020a0568200a0e00b0056e94edc098mr4681126oob.0.1694262675621;
        Sat, 09 Sep 2023 05:31:15 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3785:ad26:cd88:709])
        by smtp.gmail.com with ESMTPSA id f83-20020a4a5856000000b00573320e1241sm1688320oob.14.2023.09.09.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:31:15 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Cc: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	kuba@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] dt-bindings: net: fec: Add imx8dxl description
Date: Sat,  9 Sep 2023 09:31:06 -0300
Message-Id: <20230909123107.1048998-1-festevam@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Fabio Estevam <festevam@denx.de>

The imx8dl FEC has the same programming model as the one on the imx8qxp.

Add the imx8dl compatible string.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
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


