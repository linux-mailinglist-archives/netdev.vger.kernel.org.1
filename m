Return-Path: <netdev+bounces-22765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02C76917F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BB1C2094A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E617740;
	Mon, 31 Jul 2023 09:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32728111D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:18:59 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD402D77
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:18:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so827187e87.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795099; x=1691399899;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+12FXMvr9ESJo689bLamp4E/dWbT1DX8iIWUzUEY94=;
        b=Zr2w4Hhljr8LguATEiPtuaD7DaWFkoVMIE5v+jCbEI2GAdBZ+TU4wuBzoTYf4gZYH0
         NMBPTsAQwHME1VcqEvbCCz46yCo7KYI9298u2Dyt8R2R2JRstMe3tgogrCYfXpb3ov4E
         +jYwpoh7cjXt645E6KBNAhsuVvQtY5gKvzGXhePnUT5eZqL7wwFI3V9L0c3Om8mX0A0o
         WO8e6oVwPpkKb6Epv1rdsQmQRRHU665MR2yV5OjqLVNR/VcMTIpIl63FcluGwEP6Qiqk
         VcoiRBm7JfL+ELFCbFpxbJRppGkLOwx5Y8ZLrGUvKPFbBmqAMfFnmLbyJQ5WozcXD17N
         Na0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795099; x=1691399899;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+12FXMvr9ESJo689bLamp4E/dWbT1DX8iIWUzUEY94=;
        b=YE4a2v5Z7ivs5o3b1VB9wHvaiGvKqtggED6zZzT5MOzLKJymSKBkrC3rHrQcwB7hxE
         nVzuj1XcvfnZ9uFQB0kmHbAi3Tg82MdW+UJjxYXVOXGgcXkDO5LyI3yQtMRbEB2qSAha
         8XNKFfEVTAt1e64B+dcukRcSymMJFOo6TAKBH3DlhKx94KU0sMFqTYR898WBWflq3Ylm
         trt8keyzo7gzX8GgGIcD8UZZSiJKQdFkpg+b3XFKah/Gm3TfJnIC0K8KAh8YciH5vtnT
         oG6IikrGbbqlqt0D9bDkROkIoWhym7z3FQTQhnLCVsj0ep7aVr9H5+tBtTw/92WKRPS1
         RWrg==
X-Gm-Message-State: ABy/qLb2gVklicn/OQRwBoqHOuaWtosBypNOiR/pf7GQZafavai0b16R
	/Dh9eMRHe2O7rZDsiCG5d7zuUw==
X-Google-Smtp-Source: APBJJlHp0uEk5QeTIS0JLVRxJ9SPwseAAkLAO8wGjA6IYWrdeKTLShhJh2CQzrlnwtja2nd327DCjw==
X-Received: by 2002:a05:6512:ba5:b0:4f8:5885:61e with SMTP id b37-20020a0565120ba500b004f85885061emr6210929lfv.40.1690795099597;
        Mon, 31 Jul 2023 02:18:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm13610289wmc.0.2023.07.31.02.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:18:18 -0700 (PDT)
Message-ID: <a139cc8c-1106-d478-ed3b-40fea800707e@linaro.org>
Date: Mon, 31 Jul 2023 11:18:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/5] bluetooth: qca: enable WCN7850 support
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>,
 Rocky Liao <rjliao@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 27/06/2023 10:15, Neil Armstrong wrote:
> This serie enables WCN7850 on the Qualcomm SM8550 QRD
> reference platform.
> 
> The WCN7850 is close to the WCN6855 but uses different
> firmware names.

Gentle ping,

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
> - Add bindings reviewed-by
> - Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org
> 
> ---
> Neil Armstrong (5):
>        dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
>        bluetooth: qca: use switch case for soc type behavior
>        bluetooth: qca: add support for WCN7850
>        arm64: dts: qcom: sm8550: add UART14 nodes
>        arm64: dts: qcom: sm8550-qrd: add bluetooth support
> 
>   .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  23 ++
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |  43 ++++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi               |  30 +++
>   drivers/bluetooth/btqca.c                          |  82 +++++--
>   drivers/bluetooth/btqca.h                          |  30 +--
>   drivers/bluetooth/hci_qca.c                        | 250 ++++++++++++++++-----
>   6 files changed, 350 insertions(+), 108 deletions(-)
> ---
> base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
> change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14
> 
> Best regards,


