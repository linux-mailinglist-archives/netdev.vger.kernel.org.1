Return-Path: <netdev+bounces-12885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28127394F1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 03:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AEC281769
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E917D5;
	Thu, 22 Jun 2023 01:54:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084417C9
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:54:05 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C61728;
	Wed, 21 Jun 2023 18:54:04 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3420b22365fso31378275ab.1;
        Wed, 21 Jun 2023 18:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398844; x=1689990844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31P9F/YC9zMm83CK7+sKmOqWlDM5cGl45VAeEo+lqb0=;
        b=Db1nv+zrn8ep00FCN7SI4j0FRElfuT40VN2u4MnKRFFfnJ9TV9Gnn1Ai09mgsv3sIw
         mAHhelKCbS2i/PUyBjr6K0wI8QvqrEr6k+rsgzwHT5F9n4IHoqfskVlpkbTjyV83qID2
         NPs89GZrprsYihU6S3Blk04u7sI8GLw+cF5asM8gyYraz/Zs0t0ZxWeq6OHSjNHnwsY1
         Xgrkux2wJ1H2DW0YYIYX2jtMkUMqs6WXP/Xf7IYJbFqsS+rKZmVHLiVrOJ3adSskzkW1
         E+hgnzrNyJCW2BIXV7W6a9MVCYZG4GSQrvj9yiKaCTWG+Y+8X0gB3Jf85KlG5pPsF095
         6yvg==
X-Gm-Message-State: AC+VfDyv9Hw6boTU6vCAHPCwdSz3MOejJSFxLP+NMNHswsFgOPMzRLDv
	pASfeYJ20UqmycYHZeUKtg==
X-Google-Smtp-Source: ACHHUZ5X5gkhCzH6ju9HDjxyC21KORxz/L86uLutOzaILz+YG61ViJsYJu97hkmoe7w4uNKpjiLz/Q==
X-Received: by 2002:a05:6e02:102:b0:340:8cb1:aaa8 with SMTP id t2-20020a056e02010200b003408cb1aaa8mr18420551ilm.21.1687398843862;
        Wed, 21 Jun 2023 18:54:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dp32-20020a0566381ca000b00420c29f7938sm1444878jab.100.2023.06.21.18.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:54:03 -0700 (PDT)
Received: (nullmailer pid 45668 invoked by uid 1000);
	Thu, 22 Jun 2023 01:54:00 -0000
Date: Wed, 21 Jun 2023 19:54:00 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: netdev@vger.kernel.org, Balakrishna Godavarthi <bgodavar@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, linux-bluetooth@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Rocky Liao <rjliao@codeaurora.org>, linux-arm-msm@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/4] dt-bindings: net: bluetooth: qualcomm: document
 WCN7850 chipset
Message-ID: <168739884042.45610.17624224573017618860.robh@kernel.org>
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
 <20230620-topic-sm8550-upstream-bt-v1-1-4728564f8872@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-1-4728564f8872@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Tue, 20 Jun 2023 17:19:36 +0200, Neil Armstrong wrote:
> Document the WCN7850 Bluetooth chipset.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


