Return-Path: <netdev+bounces-34804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1D7A54C8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EE31C21127
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258328DCC;
	Mon, 18 Sep 2023 20:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45728DD8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:52:13 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88231115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:52:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565e395e7a6so2842368a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070331; x=1695675131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=bf4vkqPnY6gpSttprTGTXzITdhmXVohb269TvyYVD0Ap4G6cXlL7kmIJTnEOSJdIjH
         cDxShKRGULBdHbZtlurqXSBU1X1P4+HpeCRcbZbgGyPlRSVl4VoeyfuUmf/e0onSthta
         DW2vgP6k5u/rEU6i1DrSsdD070DfcUdpDoD1RSZhaPui7cLZcoZ/THXOlP67Xyf+CMpS
         bx25pxb67UgEihu4hm2tVPkveuDeqfVqNgK/haLHq+EcY0COZ/WCUxn1JGHVQpMeZSoP
         RZj0IbHiq496FGPS6A04RRyseegIxFVKksGUgaEn8GNSKCfQjfHCBCD73LUyBwxJdkMe
         LAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070331; x=1695675131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=aHi9tnlQWDYlMyaoCUcbJoRxT1Bk4wvtrB/GysPYLfkkIjhy29ksuizL1HXQ92czma
         pK3IfESWikAUdGu74pnd095QfoNg94Tr/3mYRliBEnWpXucxiFUmtfZprVnwSQY9b0Fb
         rXiT93sU2M7H38f7Anxpv6pz6FauKMHQKKgSfbqVcFcJIbf4iowIWmKgW8zMQMnOOlVQ
         G5DM6yvEAe15TfJsCC0D+t7n6Yfx1OJ9fkGJTv1WMwb8L5hBO6iJ7s94qaM9KCZtUSm5
         UfRHhT1myZIYI7SmmqNLUA29H5IZM+qtKPjnS0efTq+GmGDl0S2cyGIav5mHxCFcHO0y
         sYmQ==
X-Gm-Message-State: AOJu0YwSpTd5n9I5aBrjoZE12LISb/H40VV9ulstCjPGOsSkWv2C1uMi
	GfM8838zXzTQKPVOUCzUGbQ=
X-Google-Smtp-Source: AGHT+IEo2yCf5AWI7d+G8dWQj5LP+lBu3onyLV5mFtDWvWdgvWG9iXl6vIXk0M1pcf6BZHzv8t7FyA==
X-Received: by 2002:a17:90a:648f:b0:274:b4ce:7049 with SMTP id h15-20020a17090a648f00b00274b4ce7049mr6036409pjj.34.1695070330675;
        Mon, 18 Sep 2023 13:52:10 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 8-20020a17090a1a4800b0026b45fb4443sm1775789pjl.4.2023.09.18.13.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:52:10 -0700 (PDT)
Message-ID: <351666ed-2095-cc67-07cc-3f0994368b7e@gmail.com>
Date: Mon, 18 Sep 2023 13:52:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/9] net: dsa: mt7530: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-6-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-6-u.kleine-koenig@pengutronix.de>
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


