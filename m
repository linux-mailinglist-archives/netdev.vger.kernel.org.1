Return-Path: <netdev+bounces-26305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B7A77776C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CDE282036
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E51F956;
	Thu, 10 Aug 2023 11:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518C1F947
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:43:09 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F2F5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:43:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d43930354bcso689444276.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667787; x=1692272587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=qRFkbYuqL7ggurMP+JBfz/Q97CexZe6yk/1Z2oUlieMSuXYSgWT0X6/WxxflEBXQKw
         7GqGyxVLN2cBVH1mV1HJoectovdstuhGkLbiVv5vbRu1RxQXyf4GcsggOxCQM6gPOZeY
         5463j1hhtGiYyz3rZ/KqBtk7VDLuQ4Ep/NUeOw3ONRxZExPzorr0qX9PDVn4uu2KlRsU
         t9MnGbSiM5aRrHm5gDem/mmbEMMITnqC7SrhxyWzHgnQhRcF3aG9pHC/F3G0U/xvfnoO
         gcEktFIu5kf62bYF535rxJjSYia54CEIGfFwFX0J19CEaFcwZ/GYv4svdmGwi4XHmGR7
         NzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667787; x=1692272587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=YCW1zk/TmQIrgcoZSQTvsxh+TMYdpjE9cduTBigPjvFl1AxY36Dor3ePPPxrr0EP91
         qXFVDgjEZ6yJGPES9NgiyC9TThXEFJfIsOeYR5tMemfsQQ1PwwPAuib+kvV2SFMQCNpy
         toqbzxORB4FEmGJB18g1C7S7NHBW5ZDwrYSkTg3Y0JYsrpAvUSYDY2UYc4/2kiYoI2iU
         g/Bmq9qpEzkJnkR44vzfrtiSHTpCkBAsVMdpl3pxqEJgiuLSC8venetyARjh1Bps559o
         9fk6bnJ/JMy3LObclIYJXYTDL48OWk1QcVCAgKJDcsVGi5yf06jbkJnICwbFCTT2DWVk
         iykw==
X-Gm-Message-State: AOJu0YxiA4oXaAXwxqC4IMBQUTuROjpGGpAao9iiRqNkneGjcQSsvX4S
	NZ8jMEICn9wfAK0PFK9ofiFYmUAy6uqcQZazhh5pNA==
X-Google-Smtp-Source: AGHT+IF33zszTEy6qxiqNv7L7RWHO25feaifS32PLUxt1xLMJx8ywh8Ip+nh/ZGptVv7/qgWjOvPSRff7nYWXVcaYAI=
X-Received: by 2002:a25:2402:0:b0:d0a:fa7f:2fbf with SMTP id
 k2-20020a252402000000b00d0afa7f2fbfmr2136189ybk.48.1691667787296; Thu, 10 Aug
 2023 04:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810081102.2981505-1-ruanjinjie@huawei.com> <20230810081102.2981505-2-ruanjinjie@huawei.com>
In-Reply-To: <20230810081102.2981505-2-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Aug 2023 13:42:56 +0200
Message-ID: <CACRpkdafBPVQ80A-qwYjF_ZOBM6vj-cqgZ49FEGB-bL7Z2-gqQ@mail.gmail.com>
Subject: Re: [patch net-next 1/5] net: dsa: realtek: Remove redundant of_match_ptr()
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, clement.leger@bootlin.com, ulli.kroll@googlemail.com, 
	kvalo@kernel.org, bhupesh.sharma@linaro.org, robh@kernel.org, 
	elder@linaro.org, wei.fang@nxp.com, nicolas.ferre@microchip.com, 
	simon.horman@corigine.com, romieu@fr.zoreil.com, dmitry.torokhov@gmail.com, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 10:12=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com=
> wrote:

> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

