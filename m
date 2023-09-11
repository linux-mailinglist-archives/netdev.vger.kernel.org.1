Return-Path: <netdev+bounces-32806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09E79A76B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333328110B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068BC2D7;
	Mon, 11 Sep 2023 10:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501EBE6F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:47:21 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D927F1
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:47:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so542381166b.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694429237; x=1695034037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZtKfEYhqkPEDT7kYfKYKbjw5LAGLLC/AvM8pJEf11E=;
        b=xMOvJXilFyyddQuAECxFjaERWGdJHTWK6+fXZdjb2zp5PY05hk1qDFnpyQcfVExsMZ
         nwHnNIoFCl0YQhw4ZdZuQodkthi3vXGu50c1axLZmOWBEKbtzOE0FRDNINP+mdOL8FNl
         rw1f4UUV7caMl7WsK7x2DoL8FKIDx60FvJNd7vt+eboIF33WyU2OdxhZ31MtYOHa+u97
         lmOGwY3tyYvQmdeSBjX1gWIN+eaknKkYCwonfx0FXFQFxI6cGS/00xkBh0fLbDEde6F+
         kgcywLooTxy3XVXc3wcQYOCN45Rop8PW+Y9xeAWPt2iZakUymtDB2JBWPWtoAMluLN+V
         xb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694429237; x=1695034037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZtKfEYhqkPEDT7kYfKYKbjw5LAGLLC/AvM8pJEf11E=;
        b=WzSmOD6D3ycj3HaBEYYBzDQjlxyEGiBaY2dHOnho+Ym22M4EC84jeNun7WYidfw+GC
         8CMZZ7jEGcHod4jJ/q8/jt6yzvXZGxtf5PqQfAccEeTAjWVFonC4QNPaAelOWPCLk7bS
         lC2liv7gsyNTrdHnNIMB+msWGMV/4FKXDg8IBRsroyAUdUkXbQ1lgIXZZSHx4juUi6Fr
         DcJ0B6+DGzXegcIM8U6uBX6LQHtOdUmxe2mNMQuhQWVKBC14MzEasRsK6AtZ8/9c+dR0
         K8ITdXgq1v5ew0go9DazlHdoHjCmxLUHEuhRYzGnYFeVR93nsT7IMYTguOk6Q5OJJD30
         FRrA==
X-Gm-Message-State: AOJu0YybQEMElDBq5oR9pa1qZlkOf2GWc5GV5Ql9B2jNa9/ZR5Eq5gOz
	tFkzPPBFMtd5wLv9akh2zCYtTg==
X-Google-Smtp-Source: AGHT+IEhCVG0bDd8mw7oaQ/AnTyRP9aiXmQy/pIVwW3hSWYCQgiB8WukqJX3T6/6fJbc20K2QFegwQ==
X-Received: by 2002:a17:906:5db4:b0:9aa:e13:426a with SMTP id n20-20020a1709065db400b009aa0e13426amr4779637ejv.73.1694429237522;
        Mon, 11 Sep 2023 03:47:17 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr. [176.171.221.76])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009a1dbf55665sm5164198ejg.161.2023.09.11.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:47:16 -0700 (PDT)
Message-ID: <5afdb9b9-e335-a774-fccb-d64382e02d07@linaro.org>
Date: Mon, 11 Sep 2023 12:47:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Content-Language: en-US
To: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-3-keguang.zhang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830134241.506464-3-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/8/23 15:42, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 Ethernet controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> V3 -> V4: Add "|" to description part
>            Amend "phy-mode" property
> V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
>            and loongson,ls1c-emac.yaml (suggested by Serge Semin)
>            Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
>            Rename loongson,dwmac-syscon to loongson,ls1-syscon
>            Amend the title
>            Add description
>            Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not sure)
> V1 -> V2: Fix "clock-names" and "interrupt-names" property
>            Rename the syscon property to "loongson,dwmac-syscon"
>            Drop "phy-handle" and "phy-mode" requirement
>            Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
>            to snps,dwmac.yaml
> 
>   .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++++++++++
>   .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++++++++++
>   2 files changed, 227 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
>   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml

Squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index ff1f273b4f36..2519d06b5aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
  M:	Keguang Zhang <keguang.zhang@gmail.com>
  L:	linux-mips@vger.kernel.org
  S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
+F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml
  F:	arch/mips/include/asm/mach-loongson32/
  F:	arch/mips/loongson32/
  F:	drivers/*/*loongson1*
---

