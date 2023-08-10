Return-Path: <netdev+bounces-26259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FE7775AE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D975C1C2148E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1651ED53;
	Thu, 10 Aug 2023 10:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074E1E51F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:23:21 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBA9F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:23:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-997c4107d62so109891466b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1691662993; x=1692267793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVAzrUIqQ9diO6f2u0NWNjX2u+ZjP5K7qMievd2A660=;
        b=hJ45zfRpOYvB9JblZi3cj58/X8ZpBpVh7B5ZNIUJLwMWrxMgUhexUXk8G9/iomD9XD
         8X0RSYzDaBRvBQH3YEH9mU0ad/A5UGXjKKBvS1djZUooBG3n2nx0QWSjbnRO4H/ypgW8
         5YBExlR+q+b3vOBGS9HXi8VvPvWWCVASfFCFhpZPAD90NPCmRlg6cwXzzM859iQe2S91
         BY6noSIw1HxBCLTtOlSVUvd0TUERPCD9TlFfqsIPcXne9k/9SNnAhTI/k9MUq2CvQtnh
         XGLXdnWbB4WHUTqp6ULnOa++GiuUhY1ojHI/4reJS8HCrg92gOlz/7IA6iZS03VH2gCC
         PymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662993; x=1692267793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVAzrUIqQ9diO6f2u0NWNjX2u+ZjP5K7qMievd2A660=;
        b=JR4bHkyvi48l/bvOC5oex3uRoHTXnAiwnnfUoLPUvOXeKpXUggmJFWZyeY0Ce98ntk
         6ZCFd76LD0DdNOmARuH/r37NP7ORofY8UQ4qk4trkiOAmv0gtrVqodrFtXjZZFy1kQa1
         8ZzjD0raJDX8lTYDOCwG8Am/aRfoCQilEOJ6dYYAEr5QHuhawt1aQG0GwbTbT1a2gbV5
         C7SUexpKfEHjKv7KzLrnoY8QyMZLp+565+Ebl/999Z+W5sd6dXMHYuxKDGd1KbUvBsnG
         PIksXtpuUR0GQjgamQf1Wp3kD3deuHUC8GgyKajJ1vLtC5XAtY7w4bFY0/4t/E4f3Jri
         EK1w==
X-Gm-Message-State: AOJu0YzKhBrci69SB4f0jjPK+SrrPGz2TSmWoOKIVE5N3ZH0KLKGNMMC
	OhkPfX1DB9o6DXlrBTUWSlKE9Q==
X-Google-Smtp-Source: AGHT+IFyi6cbqtnFnA3nh4AJCySW1uhnlMRdbKrfO/9YtVfcIBaN4XouGmQ3czoWZJeiFDcmv0wxyg==
X-Received: by 2002:a17:906:14d:b0:99b:f392:10b2 with SMTP id 13-20020a170906014d00b0099bf39210b2mr2066808ejh.39.1691662993360;
        Thu, 10 Aug 2023 03:23:13 -0700 (PDT)
Received: from fedora.. ([88.207.97.255])
        by smtp.googlemail.com with ESMTPSA id kg23-20020a17090776f700b0099cfd0b2437sm734576ejc.99.2023.08.10.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:23:12 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add PSGMII mode
Date: Thu, 10 Aug 2023 12:22:54 +0200
Message-ID: <20230810102309.223183-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new PSGMII mode which is similar to QSGMII with the difference being
that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.

It is commonly used by Qualcomm on their QCA807x PHY series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 6b0d359367da..9f6a5ccbcefe 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -66,6 +66,7 @@ properties:
       - mii
       - gmii
       - sgmii
+      - psgmii
       - qsgmii
       - qusgmii
       - tbi
-- 
2.41.0


