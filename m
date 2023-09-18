Return-Path: <netdev+bounces-34806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611707A54CD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC4F281F6B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0128E26;
	Mon, 18 Sep 2023 20:53:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349628E07
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:53:37 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551490
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:37 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4510182fe69so1772226137.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070416; x=1695675216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=OAqT31Ys8gPda/J+bJXih+4I4Y/fS1/7GPIieqPf0QzJzEBzuboOo1aJszVRQepNrS
         6WL6vTiZUMB9k0+5bfei84vh9JlePdieGKCn1nezcZbzOiCSzqKc/1T6YeahcfRyhgFT
         5t23Kkk8o/cXJop3BU3D9WNeQfQgEIm29FD0BikL6pdxGP9pnJWTJnLkiN/P9GcVoH+g
         8RsHBePWUucGmrgahNv/MVal0iajBkr/3K/NjSDlw2MmHd1Up5GvzhBFxdGmqhHeaJV7
         D/GXt1qDe3srA3eQk7QmBpyoDGy/FEjHt9oOzB2mnggWegTr0x4MGx1Koy4iskqnR7pC
         5UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070416; x=1695675216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=BtM0fhvbQ7L7zWRZUYsmAXDf53hYhy0XhZOITBnOM2Zy4bdIxKFyco08eOIE6Xnoth
         9d8iXto8fjv35cOJzKslxTQO0/pI4F4g4Mi/62YCG7+RqkTA0vtE3KScOGu9K7DEpjqG
         Pqo88Eu7+25lSzwsq/F6fXdAeXDNFqMwA7zR5vF1+de1hQTDvilLDrorx6KQhtsk9g2H
         h81RkAaqRdeoYB3IoBBEiUlE9gqoNq5KwBFYSyEJfDiScmTU1/yxMGTGjMMsuMqZ1WtK
         zzDrLbi+gS7j7rBH1X3dnL5g3M1/w2Koj3Q3dYUF4CmWiTEpa5KtqDc53ARJwAdk9NZK
         VWJw==
X-Gm-Message-State: AOJu0YzdLd0dtyji6qTxPNN5BxASbR1l1Ps3Lr3wOsxVhqJTpPVxoeCz
	Gn75cIyMbP/2WQ+I0+1UfEg=
X-Google-Smtp-Source: AGHT+IFBK8K6xgJW/qIypGlnRI1IUpmzhjW4XAbuTaQt4IBTSrI0PxalkQGyykKtalbQUdbkAWV3PQ==
X-Received: by 2002:a05:6102:2245:b0:452:6ac0:ed19 with SMTP id e5-20020a056102224500b004526ac0ed19mr1835965vsb.31.1695070415896;
        Mon, 18 Sep 2023 13:53:35 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i10-20020a0cab4a000000b0064f45b8c02bsm3767904qvb.49.2023.09.18.13.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:53:34 -0700 (PDT)
Message-ID: <0e3fcf35-1c7e-df24-7105-e3d2a759b901@gmail.com>
Date: Mon, 18 Sep 2023 13:53:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 7/9] net: dsa: realtek: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-8-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-8-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 12:19, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


