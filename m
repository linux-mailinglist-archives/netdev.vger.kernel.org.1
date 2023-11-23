Return-Path: <netdev+bounces-50464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602987F5E1F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C85281C70
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03AE23778;
	Thu, 23 Nov 2023 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9X1F/fV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B9101
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:44:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c871890c12so9805461fa.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700739881; x=1701344681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVW8XA5bzUo8eqk22K5VEvjyNNkbbnblzFQyRhQLgRc=;
        b=b9X1F/fVFdOJysikpPD54txxYYv92EGPU9Ssyuh8M3C2FGG6ZxWHZ0758+eaSVqkQi
         wnZKx54Xao062CVwfsKirh9M7Sza5plGE9V5xetdCDy/KdDSkVtNHzLvcWYAIAKmWTd1
         YMXr2agOgSh0i0yuwsR32Hclc/71YngKZvL9cW0NQgmT+SBLs+RDmYjnjKlLhwFHjGyG
         Rpm6Z+AAxHfble0IsMhx7YLvQvPzkYQtGl3GOnRl3coLvT084BF9uAitQ6IgtkDvl31f
         GZ+7SUOIiCPTXTk1m5S/1nCPAvlZClnXdyH0MmKwUCixfSqU/2/MBXvW0VyoETAKD2cG
         XfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739881; x=1701344681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVW8XA5bzUo8eqk22K5VEvjyNNkbbnblzFQyRhQLgRc=;
        b=kCcAcaDmrAhp+WyuOgjKds34hfy2SxM38sVVcg4EZxL4eOrE3UlzhPQXND4IlW4g9q
         qJz8azfEcbnPz5bXhhgeBSyGxKnLnAz0hiqKMdGdVU0bT2LIFAiPcuPQu460FYrMTSW0
         h3r8PPtu305b+ohTOLOcX/urrHAlnTLuQbUuvAkxau8+BW1CddF9+R+xtBRkypfPshLt
         SgJf9qdOTjznDsTUqSN94KJhSfnAzekFdI5agBGJ/M33PbRdA55MSM2i65ZbGW3uEZUo
         ORHsgcInCBO0tbg86Tbq7AkrApc8cgjUab0Riqdsbuduxuj/0W4XBUSuxQeaklL203WQ
         F74g==
X-Gm-Message-State: AOJu0Yy4+Rj1kWp3FZnIe0lMsrJsBoKA+5PlBJQddxFF0tQPxu0eIUGJ
	465ZYaZvFa89o3AfmWWKESdFZA==
X-Google-Smtp-Source: AGHT+IH0pakFkfqc+E3mM99GckC/gqD782WjMYSnP3CbEroBmmgrEWC9XGMB9xC1wTLYk8jGpNMxhg==
X-Received: by 2002:a05:651c:11cd:b0:2c8:33fd:ca8c with SMTP id z13-20020a05651c11cd00b002c833fdca8cmr3290024ljo.45.1700739881118;
        Thu, 23 Nov 2023 03:44:41 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002c884919bdfsm171902lji.10.2023.11.23.03.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:44:40 -0800 (PST)
Message-ID: <8c43228b-43bc-419b-8620-b8f8401fa59a@linaro.org>
Date: Thu, 23 Nov 2023 12:44:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for fault IRQ for sa8775p
Content-Language: en-US
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>
Cc: kernel@quicinc.com
References: <cover.1700737841.git.quic_jsuraj@quicinc.com>
 <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 11/23/23 12:38, Suraj Jaiswal wrote:
> Add binding doc for fault IRQ. The fault IRQ will be
> trigger for ECC,DPP,FSM error.
trigerred

spaces after commas

> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
You refer to the IRQ as "fault" in the commit messages, but call
it "safety" in dt.. Any reason to that?

Konrad

