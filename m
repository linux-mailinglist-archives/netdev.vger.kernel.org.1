Return-Path: <netdev+bounces-25475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52A77438C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF031C20F46
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74A17FF1;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6A171BE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED9222C7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:35:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so864132866b.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691516136; x=1692120936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=MWZ27KURhaXF8ozv+jzsU4NTpcN4IJIB689Ok8IJ0AuIB5W6ZUCM4QcGiAftL2Uj8O
         BsLApaXUFRhwnZ2TCtpN07/sMx5cBcVvADsAzv/22XEscw8Gkhl0VmBU25alcdO+HRr0
         GzUOrCWm1Qnf0UyZMwjljeYE35neQq7TUzjep77l9U+7Th9KCiQmR0f9jMFPDkiSuL+T
         0yNDJRK5MEmWIvGOshbcbp1vkBro69qrfAHPYT/JaCSF5zXeMe+bQH9FRi+eWX6b7pBf
         vPrIhBax+9J2PR42WE2Sh2ZIZfCvdNEeqzI1WgMivPzivZApxIi02eaBGx6GXT0KJfp6
         PUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516136; x=1692120936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=g4jgVSZNo12eiak/iIGAnPZ4BbXx/adDhmRW+UXcWsZt//dceysMrO/m8oRQAf3tN4
         xnekgh6BZEGk0rlrAzgzMpgLubuX4S6ikzzWp4LDQz5iAToUT+iXlGXBbgOgWl6jweKA
         LHXFCU12nPrZeP34ldQTsbDl9xaax6wd/5sNyq1q9J/jFMyWS32gU9heHutcOHDwgyLv
         LjR2uMlOZpV8+3TLzfADcX1ZUEftKv/4g7/eueZO3d2VypSo07tStIvr3jLhgmAxcUHu
         QZNB3MwjNaXynyjE7JzeIRhYVJHvRD2jouvdkGq3GI/T8oUJjSYut3Ak7Tkl4z52XOHU
         y1Cw==
X-Gm-Message-State: AOJu0Yym9/OJ7+gwm/R9KQustm5mL2tuLSZtGzGbGFjQDc89iG0v5Tcp
	rMWRLPdQjGZMcaMs+I0iTWoIuszhOum03jMLFk5ohlGU
X-Google-Smtp-Source: AGHT+IGI3NvWLARIAIJ806WzFo1Gu4YYpyDDo+Y24Lhf1uUKTQCBoWPTHY8UkO7PvmeembXLpAFOxg==
X-Received: by 2002:a17:906:2081:b0:993:e752:1a70 with SMTP id 1-20020a170906208100b00993e7521a70mr11879972ejq.19.1691472062881;
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090666d200b00992f2befcbcsm6125952ejp.180.2023.08.07.22.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Message-ID: <745d818d-fbfe-da02-b98d-bd7b2c5059ed@tuxon.dev>
Date: Tue, 8 Aug 2023 08:21:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To: Jakub Kicinski <kuba@kernel.org>
Cc: nicolas.ferre@microchip.com, conor.dooley@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 maz@kernel.org, srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, sre@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <20230807122508.403c1972@kernel.org>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230807122508.403c1972@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 07.08.2023 22:25, Jakub Kicinski wrote:
> On Fri,  4 Aug 2023 08:00:07 +0300 Claudiu Beznea wrote:
>> Update MAINTAINERS entries with a valid email address as the Microchip
>> one is no longer valid.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Thanks for updating the email!
> 
> A bit of a cross-tree change. Is there anyone in particular that you'd
> expect to apply it?

No.

> If nobody speaks up we can pick it up in networking
> and send to Linus on Thu.

That would be good.

Thank you,
Claudiu Beznea

