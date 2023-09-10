Return-Path: <netdev+bounces-32725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90A799DC1
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04D328125A
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C32586;
	Sun, 10 Sep 2023 10:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79620F1
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 10:55:55 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA34CD5
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 03:55:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a21b6d105cso439771666b.3
        for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694343352; x=1694948152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeB+N3WcU8ZB3iIjHrTen1Ywk3DzscLepUtpPK7KYFU=;
        b=eK/bA1G4SHuERl8nEor0tUdtKM/jLqtVrLBzdl/+4+1nldkN1u/5eRh2IJ/h/xCntj
         x9GFk8vLLiy6nYsIjqWNIiNa+8raziTeaXBhshWg+k2NALAOQon5uvtBkF+7jIR94+ge
         KcBLNnbZUg/oMuWfycnI4lgzv04h7uGhVCybfgFRMGSA07qozXy1l/pUUbFPPku7atOl
         7TDf4JQ7GyoAYaX0GF/aVMrzsebsnxgr5erOaEMutaS/EESZ+36RoE88mtP2SHufpstE
         tjcD8IPu95+kp08PHWSOgtwPZz2GWrQLJni6Pf9fPv0QJ+YKMolvlvUxy1Igh+rTSRxf
         ISpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694343352; x=1694948152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeB+N3WcU8ZB3iIjHrTen1Ywk3DzscLepUtpPK7KYFU=;
        b=Q0AxH5tL5/OpAMmsxnD5zokuCCd7JUgeY2kbFFK8NuhRY+Dacq+ipt4qpRfCUnShmM
         ClWKnth+MrO0bTBM58uRGaCgJJkkIdiXT65F79InZ8IlpQaKp15RMB8shpYDEiNGdWBz
         XY22ShRobq7tWqYkWxXx9uWCyUFJl2Ze3qSSdaPbp/keVwibYMFM8dTS0h5xbycFfmen
         V4AOrsBzfXEMMm4Jn6c2Lw8beofZpn2sXGHC0g0bED4UncDesI3Qz5DX90anzAVYGFWF
         qlNYvaxy1DR+MUuRtdPYaopNrNFFOCf1Xysa+64Cah18i5W/SGkkwaS9CLJIAYYmwfOh
         Dsrg==
X-Gm-Message-State: AOJu0YxMhKclawyZ+Q1w8CfV3nL7UdV2/2U8ksRGIbvBpullH3uOqsx7
	/Kxvj3fP4NMTTbVMwFzajhgoQAyHeX47usShrKs=
X-Google-Smtp-Source: AGHT+IEtlK6pD6SAm1xa6VHOQmOUl0ygy8p84MgTWmEPdv60Cc5CbO6und2cQ+jM2C8A71j2VvjCZQ==
X-Received: by 2002:a17:906:7393:b0:9aa:1e32:46da with SMTP id f19-20020a170906739300b009aa1e3246damr1818685ejl.37.1694343351858;
        Sun, 10 Sep 2023 03:55:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090694d000b00982be08a9besm3692965ejy.172.2023.09.10.03.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 03:55:51 -0700 (PDT)
Message-ID: <eef69aa5-73c2-9789-9f6d-c3300553c44d@linaro.org>
Date: Sun, 10 Sep 2023 12:55:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Content-Language: en-US
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, steen.hegelund@microchip.com,
 rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
 andrew@lunn.ch
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
 Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/09/2023 16:29, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
> - Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x.c.

And why is this RFC? Do you mean by that it is buggy and not finished,
so we should not review?

Best regards,
Krzysztof


