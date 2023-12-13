Return-Path: <netdev+bounces-55443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF1F80AE06
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E9D1C20BF7
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC453986E;
	Fri,  8 Dec 2023 20:37:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A91700;
	Fri,  8 Dec 2023 12:37:05 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-590a2a963baso231674eaf.2;
        Fri, 08 Dec 2023 12:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067825; x=1702672625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtLCjRr60799H2MKwM/QzmmaJzcd7IJTQn1+Afg4EXM=;
        b=UC7Ngmp/efhZqTJKByfX8S9EBwQf9lMln2azKAWNMz08GWTl/cA+IhoFsNjIU9uxU2
         fqJPVU5f0Au0VLgIzgmYMGq/mA6F4LF485cLyVYQp0i2uTprY6L/gjyGAO/yVQqdillD
         3Ob/S0APmBKTSZAcNfHGwsoGuTxlfodrH81pyyntMTgKLYxAaW1pT6WmzHxAlWIyi3qH
         JgiafG8b1Qctt+GFPty3fHCoPn4Vkoh2Biea05pIldySD3a6HUUbXU0WFQPGX3Xs4ps2
         bEgQ8qWy/4MQFicwkDtOCzqQson8wpFcpPGsH/2qG0f47wq/uK/7nIRvnDZtkxcsDT0z
         /9GA==
X-Gm-Message-State: AOJu0Yy0V28QNLgklgTbse/zWbnat4oAHgGneKWF3s1P/kqh65ihenqf
	/Rr2wL3XmCeqRSdrnW+UyQ==
X-Google-Smtp-Source: AGHT+IF6nHBrpdI9PdRJ4tPrY8/hF9C+fJyV7AZgkGumgP+nDJ+h9st1ng57n985M8whf2xhzvAPCg==
X-Received: by 2002:a05:6820:556:b0:58d:d525:6b68 with SMTP id n22-20020a056820055600b0058dd5256b68mr1039807ooj.7.1702067824630;
        Fri, 08 Dec 2023 12:37:04 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n27-20020a4a345b000000b0057e88d4f8aesm440586oof.27.2023.12.08.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:37:03 -0800 (PST)
Received: (nullmailer pid 2661606 invoked by uid 1000);
	Fri, 08 Dec 2023 20:37:02 -0000
Date: Fri, 8 Dec 2023 14:37:02 -0600
From: Rob Herring <robh@kernel.org>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vinod Koul <vkoul@kernel.org>, kernel@quicinc.com, linux-stm32@st-md-mailman.stormreply.com, Bhupesh Sharma <bhupesh.sharma@linaro.org>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, Bjorn Andersson <andersson@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
Message-ID: <170206782161.2661547.16311911491075108498.robh@kernel.org>
References: <cover.1701939695.git.quic_jsuraj@quicinc.com>
 <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>


On Thu, 07 Dec 2023 14:51:25 +0530, Suraj Jaiswal wrote:
> Add binding doc for safety IRQ. The safety IRQ will be
> triggered for ECC, DPP, FSM error.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


