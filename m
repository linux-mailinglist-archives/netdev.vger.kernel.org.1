Return-Path: <netdev+bounces-34805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD27A54CB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1235C1C210D8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72928E15;
	Mon, 18 Sep 2023 20:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB228E05
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:53:26 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20790
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c09f1f4610so2849145a34.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070404; x=1695675204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nw5To0v4XYeWFXakcox7GRmig0KvKDWMkjFgw2+3Bw=;
        b=h3pyRjOLYriFZAsLu/2mW9JefoOLvDN0deBBfSB9q1EfYkQqD4qwMJ40VykmSRO9Qf
         V1R/g5DtNC1+BWw4S0/nOIMQjB+wSWx1HapOyinF8Nms70EC2Abag0QbFogA2glSdbL5
         YS5VHhBusl478lushTo2Gr12Nl/N6ta1MB7Kj7HtqCDoIHjTlHzXxjmuHTlaYregUeXR
         FbVqebxZn61DMwzKVNsg58v1dB9r45r2pBvXrSqmSykILHxrNBUS3F4AR5k9SpgOle/e
         YsnSenb751OaYgjkSw+KVqDSJLD2zFAdO+jC+4SeZjMyllKo8IDqfZcvspMiY/QSwnx0
         tsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070404; x=1695675204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nw5To0v4XYeWFXakcox7GRmig0KvKDWMkjFgw2+3Bw=;
        b=VuzPIt9+gsE1U14O1Ve06NJroTnjUrcqXQBjyDF210vkuf+lgyLakfjT8QgcHJCnZO
         jHn142UNVa9WdVuHNd4beL4mHrRLlDfJf6ovUDJT98cdCAHZwovVUxWHgE1ZFIs4e/1d
         OKeHc0Crs2zxofoNRTnykR7xcggUBA9eBa5+EAnWLgBWGtgi/EMM1o9hcSW4h70T/2Yj
         ZAOfXmChnuVoQiIUWyIlCO9VwG5QsHhs80QpYBVaG6NyW6N98bNIyCOX1I2BdJrFKzPt
         9m6TLcWEPTEgOelaekoDPXfjeKTe34gMpJMrIF4FS2zFP4/OmBVcnkmf2kRgEObqPAW5
         23qg==
X-Gm-Message-State: AOJu0YxPvBvK4g21ipF4k+TyMHd5OfqvzXMmRN+XeVNCduUElheKw0zH
	XAZ9ajtrn3ueylpTBs0n/mQ=
X-Google-Smtp-Source: AGHT+IGEMSJf2n9RuHIblMOpmLQsOoxMHSthYGVL1MFM6JzlsPOrEXdpS4zZsK2ioJ1RybubXtglGA==
X-Received: by 2002:a05:6830:2059:b0:6b9:c41f:ede9 with SMTP id f25-20020a056830205900b006b9c41fede9mr9478847otp.16.1695070403883;
        Mon, 18 Sep 2023 13:53:23 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t20-20020a63b254000000b0057401997c22sm7069496pgo.11.2023.09.18.13.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:53:23 -0700 (PDT)
Message-ID: <e46b134c-f000-b96c-99e1-7f6b5ad1d744@gmail.com>
Date: Mon, 18 Sep 2023 13:53:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 6/9] net: dsa: ocelot: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Colin Foster <colin.foster@in-advantage.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-7-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-7-u.kleine-koenig@pengutronix.de>
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
> Trivially convert these drivers from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


