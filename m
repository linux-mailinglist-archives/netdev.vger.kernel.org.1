Return-Path: <netdev+bounces-50255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE47F5146
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8479BB20CC4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB65D8FE;
	Wed, 22 Nov 2023 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ewvz7udj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46161B5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:09:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso137453e87.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683798; x=1701288598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oN/ChfT8e0nycA2Y45oH8F8aAL5FUndvODmKzayhWU=;
        b=Ewvz7udjv2xjoBcffDVT43fZVbbNIRZdQB9wfpXvCspkBa2d3lATT9kZw/OIb4dutO
         DllBaqmw8lCWEUxBvGRfqaSoXiGw4TgwDmbnZw6GJkmTxgdlnZztWtes9W6pv4wpcjtj
         rjW+j+5p0xQRYkjsZ1VFIDPkwSdH2SI/MXcnqW230Ltx4+cSyWirKVr17faN2Yjd0IMX
         SHhKuaec3PBwq7Vw1AGJbk5dOMw0pFBjmCExk+gXYJ5rH8klLwt03cHeY2HE6L8/c0tH
         NYzRvd5Ou+n/fOOfamIFbXxN53j17DheG5VTfz6pFMIZ4qN9X/HC4jzHRQ9R+O1Wr1Sk
         tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683798; x=1701288598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oN/ChfT8e0nycA2Y45oH8F8aAL5FUndvODmKzayhWU=;
        b=IKkO3lxROGrWNIknbcmHV8uScW144twcQIgRoA2TAQ+a/HU3qIeBbezsw0SYvYOe5X
         jPZLvlL1PpSLO9n84DwZ42SKJGr2TgVahTdDln9ElCrkDz6zshxO+UXZGTlfBz4Zg12B
         Wbuk6K11uEfxgo/PZaupupV8UZ6jLrssDyLkAXFzIGSPUE202vKGLjwgp6I5Wc7bJdwM
         4lhaA/Jc6lBSgv3yDH0tEg1qsyyclNfnzZsbPByuufKQeZ+U3jWkQADBMf6z4qvGEkKz
         hIPm6eZjjUtIvtQtWPjNFyTNv8/ESxWcV5dl3NRfU8aGaNYoc4u+AGo0YcMVDBD2Nqx5
         idZQ==
X-Gm-Message-State: AOJu0YyNZTUbxu+T42MFdQSE4h/G9BfmbQFr2Cv6xwu3eEQv1l5KMz0H
	nB07HIYAq3Ro/c5wK3qk4B8aWQ==
X-Google-Smtp-Source: AGHT+IE/Laar5BAe/Ut2eWzKinuOOq4h3ahqPOZfbrEwTg8LRJ8HKRRN3AqS36Kxn4ieIK8bY/3SVg==
X-Received: by 2002:a2e:828d:0:b0:2c6:eb1c:10d1 with SMTP id y13-20020a2e828d000000b002c6eb1c10d1mr2244801ljg.25.1700683798165;
        Wed, 22 Nov 2023 12:09:58 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q8-20020a2e9688000000b002bcdbfe36b9sm38083lji.111.2023.11.22.12.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:09:57 -0800 (PST)
Message-ID: <90885d90-2e25-404b-b3a3-13d134801146@linaro.org>
Date: Wed, 22 Nov 2023 21:09:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
Content-Language: en-US
To: Imran Shaik <quic_imrashai@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231117095558.3313877-1-quic_imrashai@quicinc.com>
 <20231117095558.3313877-3-quic_imrashai@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231117095558.3313877-3-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 11/17/23 10:55, Imran Shaik wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add the support for mem ops implementation to handle the sequence of
> enable/disable of the memories in ethernet PHY, prior to enable/disable
> of the respective clocks, which helps retain the respecive block's
> register contents.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>   drivers/clk/qcom/clk-branch.c | 39 +++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..61bdd2147bed 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/kernel.h>
> @@ -134,6 +135,44 @@ static void clk_branch2_disable(struct clk_hw *hw)
>   	clk_branch_toggle(hw, false, clk_branch2_check_halt);
>   }
>   
> +static int clk_branch2_mem_enable(struct clk_hw *hw)
> +{
> +	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
> +	struct clk_branch branch = mem_br->branch;
> +	const char *name = clk_hw_get_name(&branch.clkr.hw);
Bit of a microoptimization, but adding this implicitly in the WARN
would only execute clk_hw_get_name when necessary

> +	u32 val;
> +	int ret;
> +
> +	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +			mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
It's quite a nit from me, but it would be nice to have the next line aligned
with the opening brace (with a tab size of 8)

Konrad

