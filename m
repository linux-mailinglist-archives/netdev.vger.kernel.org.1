Return-Path: <netdev+bounces-47479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB17EA62E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CF9280F2A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2E2D631;
	Mon, 13 Nov 2023 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8qbKL6s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38029CFC;
	Mon, 13 Nov 2023 22:55:47 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469211A6;
	Mon, 13 Nov 2023 14:55:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f64817809so459013a12.1;
        Mon, 13 Nov 2023 14:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699916146; x=1700520946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sADKqi6TS9h2XUEG4qZ//atRRj1u4Ar2HnA17iTh5M=;
        b=c8qbKL6sxyBE6KTwKEqniasmdZRQ8zFOb+mDPC5AvNWGhAEF9UB0BjDV5etJ+13koz
         uNUh6F8RLSuErF59x1n7BVaj8O4Vl+XMI0oDjZh/cIjWVpZGlUyg6yuiCjxpOZOt7Ife
         16UsDQR5TZNAPihSlppRPDijcgDDAH6lkOb7J8L9K21Zlm4N2XHZW+MzJe0SFT1ECSXV
         70EItu2l0yDIlf650cMMEiKuV8UXXOwybZyWouF66lOzzdRVn4Wxyc/953dJSngLMUw3
         X3WaGD6uZhF41lFGpnZGDH5jurXPdUBbgXd6FJX6fVa9vv/814eyAIGwzyW0Tft6qmkw
         h21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699916146; x=1700520946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sADKqi6TS9h2XUEG4qZ//atRRj1u4Ar2HnA17iTh5M=;
        b=FUIxnjD7aOC/iHXgOsLbzKtn8QAp9hf8SNtKzbmLdTadq2X/URYb3O0Arvf0NCzt6S
         VByfZi6K8tGoFGFXzIdiaNN+J+B712fQnKQ9dkvBvp3izD8Q+LQce60Jgwh4czRzoA9l
         q9zIZe90xTeNgUY5tDr6OQG0f03kIFhW71fVC7DmSHYOwXNYu1H7+fED63Oxzka4MTEW
         Qecm4r8Tm26cZJffTRYKJOiBoI3P5SOxh+HpCuEo0L8yr6qoGlAd+nfwGWWW6UwcLUT1
         /TumckS+YQP8WDbYMmCWvPcpVgXLhaFJFIo8zK/pE2u0kzkgw1PPyXvO7OoayPLPXYOD
         Kk7A==
X-Gm-Message-State: AOJu0YxmNCjUQkSsu/PHr89WOu+AQdqdp16xhNbrvgOrxYfkIQM+H3QC
	gnF8t70e2M9Wg7hVJq+YUMHshQQ+w2bGfl/gbn4=
X-Google-Smtp-Source: AGHT+IHwAyHga+EXXWaAkl1JU0LoLTNtXx0DCTrfZ6Vp6a7avP7SNR6vxnDLAPtnceVOMmfFn51nx90TwtEYw71m0TY=
X-Received: by 2002:a05:6a20:8412:b0:183:e7bb:591b with SMTP id
 c18-20020a056a20841200b00183e7bb591bmr902415pzd.3.1699916145712; Mon, 13 Nov
 2023 14:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113204052.43688-1-festevam@gmail.com> <43d176e2-d95f-40dd-8e42-8d7d5ed6492c@lunn.ch>
 <3acda2a2-3c99-4a14-ab68-ab166ce08194@gmail.com> <22d3ed94-2c8b-4d7d-9c19-1ab13ee2c4a4@lunn.ch>
In-Reply-To: <22d3ed94-2c8b-4d7d-9c19-1ab13ee2c4a4@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 13 Nov 2023 19:55:32 -0300
Message-ID: <CAOMZO5DPf7vf84XmWPAxDTyGsDqZECYN-twtzG+Rw_ZYoU=YLA@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Do not make
 'phy-mode' required
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Florian,

On Mon, Nov 13, 2023 at 7:23=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Using phy-mode would be more consistent, since its used > 10x more
> than phy-connection-type.

Thanks for the suggestion. I will change the dts to use phy-mode then.

Thanks

