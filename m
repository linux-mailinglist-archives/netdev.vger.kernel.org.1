Return-Path: <netdev+bounces-34802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2C7A54C6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013C3281E3D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE328DB9;
	Mon, 18 Sep 2023 20:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7B28DBB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:51:42 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFCF10F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:51:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2749c756bcaso2565300a91.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070301; x=1695675101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=Wc3HpqE73gQZEYmDzlA5xfLbUuU8UFkV0TC2UyuMKpxjp6UIzqE+X2i0p/uZYx3/Nm
         L5Deg2H65t+PydhpiVp0dMxELfshvOELtS0ZYUF7jwcl31t9EvoVL1t9DVCuFsnyMNW7
         X3h+ncoPYw/cmdCAetNLXaYTjSSm2EaAtDWEr/+O/c5yzlyO7IwU0uNWK1AWoBUnW2F7
         9I/v22yFvB8aQYDARUpusgVudku6v9ggOdH8VeXsd6DB/lyyXbmeBhV8eq6+jz51EwBD
         g4lQ1PiL934xQ38iic1UIJmTVyfOeFSkUqErkW/sGH1xQnbY++kuirXZLOllfshe4aHo
         52gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070301; x=1695675101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=UtU+GIap6mMug/NwYOFkjU3fY4RWfsLVM5cvHn6OdshhejxtL2aJloQonAMv+aJPWj
         gM0671zUfg7/pPWRk943meXR02DXlRuNrmLids/eUIb60Lzp8MYBx0NP/2d3XS2hsWC7
         Q4ufwhGF1lVHvw2WBmPjW10cVVkUGcUHeME3L5E/kXLSBPqh7MrEX5jACxj6NgHahefC
         bec074qepY0GtDyUhABsGHvEwsk4dXH7amBd2IpyrGs/M/SPs84o02oThDT11V1om2OP
         /SbrKxMduRZ0vPkhTfbaKBuAgOodBYU8Q4yMH+WaYcf1Apkrc8lJhZGy8JYn+pzwMbZF
         ArLg==
X-Gm-Message-State: AOJu0YzXSp0AUiWXGmnjlANDnUTJavQB9RB5EWa4pX7Mz0kl3bN9cZHc
	L+ZUl2V2IjbXboF/9kJZReI=
X-Google-Smtp-Source: AGHT+IHfyUe6D6kG0viN4MK9GCz4mcQP6W89pC8lPeKFBU7p+NY7SYaQvWhO6oGOmK2b4QSfwXKZrw==
X-Received: by 2002:a17:90a:6fa5:b0:274:729c:e4f with SMTP id e34-20020a17090a6fa500b00274729c0e4fmr9047572pjk.15.1695070300867;
        Mon, 18 Sep 2023 13:51:40 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 12-20020a17090a1a0c00b0026b0b4ed7b1sm10128595pjk.15.2023.09.18.13.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:51:40 -0700 (PDT)
Message-ID: <a4a0e811-ac02-0523-4adb-1ec75af05571@gmail.com>
Date: Mon, 18 Sep 2023 13:51:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/9] net: dsa: hirschmann: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-4-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-4-u.kleine-koenig@pengutronix.de>
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


