Return-Path: <netdev+bounces-23528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F976C5F3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81861281CA9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB961C32;
	Wed,  2 Aug 2023 06:56:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407191C11
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:56:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADEE71
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:56:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so8437997a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959393; x=1691564193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WekZWN6r3kEo9Z2SWEpwzpGIFVoo4aO3LnnSXjlvYM=;
        b=Ulwg9GG6JZoIzsSN6MyESOEZvt7zeBaPnm0vWVAkD7xUt3M5nLIKAgIvWxVvycxZxG
         +Abs6pUOl2DfcjnX4E4uNwCvSnr1EpvHksoBD+jjf7p/MBXgXMVbKGzr4FGhPFGQJ4SE
         vAQLwenEbU4EI/5xs4y80vz6dYaD+U0Qjb5pt3WI6GUCx9pAQcr/YxE/Znsbvym4yamo
         Qeh8z0us0LpQm0CcC19yIfoWL9FelZuRyYXvcNBDtMxbmbhfgW7ovUO8F7uFdJVLRwbW
         bMMEv56OMx8aMaO9IvdzHZ0TN5d8hibLudNMmUD6V8x6JXF0jnm24gOn4zpxO7pToaT+
         xqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959393; x=1691564193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WekZWN6r3kEo9Z2SWEpwzpGIFVoo4aO3LnnSXjlvYM=;
        b=Ps9u/x/tVu2eQJ0DDrJQ5hH5W3bazO1l+dlPL0X6CCgQtCNdPu2ONe24UCVnLSiwfU
         nv+SDtT2jQONHciTbOViEh+1Mr3/6fhH331VxK3MN41Vis5SkQ78Hwn65tMPPc5rtaBs
         fNAk80nhIBL6cbb1cDM9RVSci8NzgYgtBXO2DEtbOXZikN/R/objf0veGFtmm+OC0+6D
         68QTBCrC/33eQBxrp4Rq70noFIObS4qcbMBQiMRqgSKhPC/WGQRmeX2PzuPak406cOHC
         xKpabb7KWcthNN+6MyFfpLf5IkmfQ6nJVQs6s3iiy0uuMmHSM1TF+cgNp7mhLCeqCnG1
         TS2w==
X-Gm-Message-State: ABy/qLbql0d/BMZdLF+nJtcsIysmYkzTPv/9nJv0Xr+ri39x9ji2Z+BL
	tf7wAvS2Aymh7O8GW7ZZSXUfQA==
X-Google-Smtp-Source: APBJJlFGxq+aMT3PqHDgik/2AOf8hLDUHBWjDVKJBcTpdIfewNezftcZ0MjSF0LXzcYzfzYmQ/xYmw==
X-Received: by 2002:a17:907:7631:b0:993:f9b2:93c1 with SMTP id jy17-20020a170907763100b00993f9b293c1mr4129777ejc.9.1690959392217;
        Tue, 01 Aug 2023 23:56:32 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 02 Aug 2023 08:56:28 +0200
Subject: [PATCH v3 1/2] dt-bindings: net: qualcomm: Add WCN3988
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-fp4-bluetooth-v3-1-7c9e7a6e624b@fairphone.com>
References: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
In-Reply-To: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the compatible for the Bluetooth part of the Qualcomm WCN3988
chipset.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 56cbb42b5aea..2735c6a4f336 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
       - qcom,qca9377-bt
+      - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
@@ -111,6 +112,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,wcn3988-bt
               - qcom,wcn3990-bt
               - qcom,wcn3991-bt
               - qcom,wcn3998-bt

-- 
2.41.0


