Return-Path: <netdev+bounces-33481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35079E202
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECDC1C20BB0
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07761DA4E;
	Wed, 13 Sep 2023 08:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0517758
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:26:15 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262B1996
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:26:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d20548adso6618077f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593573; x=1695198373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoiLF9qWHetvzCqeRRmjqsm+XzU44/Y+Q1HjHiijaVk=;
        b=EdhhLngt5a0eQi59anhz1MT+BwGrYGcNs0gH+KUr58WJVAcf5FIwOtAn1lvEbgJGgO
         dl9/8PIxRHSvpwNBZNYLNCxC8K9NrqDEujmFbJefX2t8mrbu8SdObvMTPn+lfMH7WUCi
         JgKDWKK03xqGLCwN5bI0GOMKH2C/MqDSTUXHyU22Ogd3Cz7gAaY4BrLSscz2tLmDFp1L
         pg5h+R9vpw6FVStKsv8XqLfcNrxYlTYaxv+Qy52oCrev2xhWDnVV06kiBDrL4UhAwvZO
         Lf/RapebciMKoEJ8s00OEtVsUcTJ3VMN9f6D1HgCUXfCD6AByqPR27PoVc5/MoqNED3t
         d93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593573; x=1695198373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoiLF9qWHetvzCqeRRmjqsm+XzU44/Y+Q1HjHiijaVk=;
        b=JdKCLxb2pw/j3gYpP68obSip6ah1ZLBajBIlmJ74AuVPvm1ulr5zWNQKvJgU0IOb4P
         bbh84XmcfmS39Ok9iFPSCsJ81BwbLEq4fXkJvPOIUttE6XyVOp7dTrbyXCnaSMjMvrDK
         NIeF1wdRpt3ss4OndhVtYYhgToj51ZuxqK6ZE2alnEvcVALT4L5eLGtYDnDeJmDrVJoh
         11N98Js1sxuZtyFhduO1OwQMtzU7BjWagMMd7iNsdNzwEANUka30+qKLnfD7ySgYwEil
         lTDSJQa8wHIggofoM0msMIb+TGb2A1rEYyqjn0eB3o+naZt/N2VDPJtoMXu+27ZuztXj
         gHRQ==
X-Gm-Message-State: AOJu0YxAM7GblJzlwSPgVaGRO24OgqpKX8OKAm+TnDTDmSTJmEARgUa4
	sVNY9Q6hFMP3kyz8WR3bFzRp1Q==
X-Google-Smtp-Source: AGHT+IFanqHvpz/OBQqvTsB3/lwBZqctCXSf2n5vpeLr5J1YVLJWmkIRLIDCy8G5mDDR4cSEzLpOzw==
X-Received: by 2002:adf:ea43:0:b0:317:5c36:913b with SMTP id j3-20020adfea43000000b003175c36913bmr1316763wrn.48.1694593573133;
        Wed, 13 Sep 2023 01:26:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y18-20020adfd092000000b003179d5aee67sm14921713wrh.94.2023.09.13.01.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:26:12 -0700 (PDT)
Message-ID: <daed3270-847e-f4c6-17ad-4d1962ae7d49@linaro.org>
Date: Wed, 13 Sep 2023 10:26:09 +0200
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
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2023 10:23, Geert Uytterhoeven wrote:
>>
>>> +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
>>> +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
>>> +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
>>> +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
>>> +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
>>> +                                     "uniphy2_nss_tx_clk", "xo_board_clk";
>>
>> You are using clock indices. Please drop clock-names.
> 
> What do you mean by "using clock indices"?
> Note that the "clock-names" property is required according to the DT bindings.

Indeed, thanks for pointing this out. Probably bindings should be changed.

Best regards,
Krzysztof


