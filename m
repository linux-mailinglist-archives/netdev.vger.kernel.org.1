Return-Path: <netdev+bounces-34803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D97A54C7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276421C21159
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98728DA5;
	Mon, 18 Sep 2023 20:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00628DBB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:51:57 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876210D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:51:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578a91ac815so385956a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070315; x=1695675115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=Dc29C86LJFlimtacKZridQERFCJwslW0KOQ6uGgYwG+Dl+FV8e+EuWsRm8JdWWJ4Dh
         ziLCxSkIsvBIgbHAIXkw9o7rOon0gknqKc3lC+n+9v3nYYtSVi0yBD9+3agkchJ4QkvZ
         Fl884ow/t6nKphEOHxFkOlSK07bG/BFlaGNVP/xeL/nD1zZb+raQDYFJh/761T46rr0P
         dr2NDvZdP+Ddw8shjwQRAUfz777e8zeRVzwqw1Jt/tg8NmFq6M2nYj4hxP8w+GQVbPTl
         Rwy3GKfohJBlRbzCnWXA0GfM29r6+G+JckzuFuldNJCq7t3v9X8zTbP/GNkqzuRI6dvh
         d9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070315; x=1695675115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=EViULYejXwryQc3Pc3C8o5uZO0Lnt1Ms21MToCI85b/HB14vCTjNPzItQAAMiOuAhP
         2P1H3a9G3Cq9ZLpfMcmaI1u0xiUWL0R/ZQoANDHC7ZFoifM3Dvii7rk5oXiHqDfatJRS
         GGJ0+Hu6rYiYCoi3TcK2X47RB8TKB7WzGe78K2wDNx1jEISAHafRYB9cHZE1biJ+Wdan
         8xTLt9trFCEdOnGAlkSThFfmF69W01YWkwdhoRWdQdxVIof6RaCAIhLQhwWN/X3sGU4B
         BccJU4eppunurAy5qnNsUY8VorE8Jre5m5M67HgeinAfVyMuqz4kqwOs3y3S8qC+FDED
         e/+g==
X-Gm-Message-State: AOJu0YwclvIUQh9lNZ6MCRhXLrSdIFmtITDIsvAPF0Yv4G2bxgu8snRK
	q6tRHMsJYTzZ+ZJSUXCyG6eG79UVGkM9OA==
X-Google-Smtp-Source: AGHT+IHDdAuzEVSVJV0XPpevgPfSaoda/4KdRSKJsqGpEOytl4Dv8j/SbNHaz40Xj9+Ch/ZEFchc3Q==
X-Received: by 2002:a17:90a:6fa6:b0:263:72c5:9ac6 with SMTP id e35-20020a17090a6fa600b0026372c59ac6mr7749091pjk.11.1695070315179;
        Mon, 18 Sep 2023 13:51:55 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p14-20020a17090b010e00b00262fc3d911esm1506846pjz.28.2023.09.18.13.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:51:54 -0700 (PDT)
Message-ID: <e30f3643-be10-31eb-1507-0586b793122c@gmail.com>
Date: Mon, 18 Sep 2023 13:51:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/9] net: dsa: lantiq_gswip: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-5-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


