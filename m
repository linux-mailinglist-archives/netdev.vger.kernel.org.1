Return-Path: <netdev+bounces-33489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF079E2B9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75B028199C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6991DA5D;
	Wed, 13 Sep 2023 08:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8D10F5
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:55:36 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B4199F
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:55:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso6644536f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694595334; x=1695200134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3s4XTmZuXvVvkm0V75pftgs9YXVxmixMmIhKraOPVhI=;
        b=UzS8VAEcinFpI6HSw2/LRpJNhK13qDFwkRBdbLq0CYo54n4xofFgWo+oF0gtkGzKR7
         QHv6Ogre5NkbuTHjCuE6BlIaqpWi3s3pdh0ArOabtC+EARy80CfPde99aszfTztAFLXN
         nMfd4pQ+nvJaL88vSRan6Z27A5zvz/XsDh/k3zm10aDRQfiKdHPB6GT59L/0tm+o1qT+
         jYB04l8Oe2xNIOlu+wwxR/4zP2DNboDwaIj8BgFYXyjC/OJ0vO9dI7d5iRAiffIxY/gf
         aAbl6OKonhhvKRwo++J2WKoRZuXztXLBd9PdrDoQFBNI+G1+J8YNtBcSazoLQBjUC5Ob
         lm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595334; x=1695200134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s4XTmZuXvVvkm0V75pftgs9YXVxmixMmIhKraOPVhI=;
        b=TOWA3Rl46ECGgt0GdK6jwjlBPEFG1LxKUUl5QIYtzBn+YAI0zHPlIp+Qlm9oqw9qVL
         DCYrjL/sblgvMJXnFeqo/tRUGYdRnQcmmjegk236tTVRLdifJ2vwK2l6H4zhKQmPo76Z
         haMYnDrCQ5DrsvJ/QWGsmwcX8tQ+m0xjI0g0v6HS1PTYH1CsfRvABjClv6MnodzEEXo5
         0YeVg+Pt1pMJBZgKCqk4hAJ6ZfQDwbTbRdu7oaOwQXaGzP1aDZKbqq9FojaS6ZZvu+M3
         Cp6KB5mBz0zYTDuCHpfT8lJFqSNNPfYhzhTLCWEPgXFHGqLwPQiN8IpsLhV+qZFLLD7n
         Qj2g==
X-Gm-Message-State: AOJu0YyoszqpxbOAYBl5XmsFcuoZoANP4GnJg5bbubWZ9QJFoVXXY1nO
	MhB+/Nq9bIMc9Y3K2OXA5w60ew==
X-Google-Smtp-Source: AGHT+IGN8q/6+xxALx9gUe9stgKotwY8iX0ZO8k2F0PDEZ1P0Uoeo9yl6chJOtzG1X7GSQJV67hvyg==
X-Received: by 2002:adf:f3cc:0:b0:31a:ea9f:1aa6 with SMTP id g12-20020adff3cc000000b0031aea9f1aa6mr1464200wrp.47.1694595334276;
        Wed, 13 Sep 2023 01:55:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b0031fba0a746bsm3925446wri.9.2023.09.13.01.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:55:33 -0700 (PDT)
Message-ID: <3a65082c-200c-ce59-a662-ecd623dc68b4@linaro.org>
Date: Wed, 13 Sep 2023 10:55:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc
 node
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
 agross@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
 geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
 peng.fan@nxp.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 quic_saahtoma@quicinc.com
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-7-quic_devipriy@quicinc.com>
 <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
 <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com>
 <daed3270-847e-f4c6-17ad-4d1962ae7d49@linaro.org>
 <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/09/2023 10:38, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Sep 13, 2023 at 10:26 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 13/09/2023 10:23, Geert Uytterhoeven wrote:
>>>>
>>>>> +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
>>>>> +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
>>>>> +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
>>>>> +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
>>>>> +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
>>>>> +                                     "uniphy2_nss_tx_clk", "xo_board_clk";
>>>>
>>>> You are using clock indices. Please drop clock-names.
>>>
>>> What do you mean by "using clock indices"?
>>> Note that the "clock-names" property is required according to the DT bindings.
>>
>> Indeed, thanks for pointing this out. Probably bindings should be changed.
> 
> But what's so great about not having "clock-names"?
> There are _14_ input clocks.

There is nothing particularly wrong. They are just not used by Linux
implementation and they confuse people into thinking items are not
strictly ordered. Thus agreement long time ago for Qualcomm clock
controllers was to drop the clock-names to avoid that confusion and make
it explicit.

Best regards,
Krzysztof


