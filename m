Return-Path: <netdev+bounces-20141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C475DCF8
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E229E281A01
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F71DDEE;
	Sat, 22 Jul 2023 14:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD81D2F9
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 14:43:16 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B22D50;
	Sat, 22 Jul 2023 07:43:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7653bd3ff2fso299201385a.3;
        Sat, 22 Jul 2023 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690036991; x=1690641791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hFJZ+xcFRusdcBFL2o/UHDUh4F9uxkaCVbwwDZqam4=;
        b=FAdvLwHK509EjVxsYIasoitACHxGlVbzBJSE/3cAsbuj2xXZ3E47zZ9pBoc5V/26U/
         La+Xq6zLWGRRfoSOpIFMgd6d2eD1A5p0Xt4YPceYI81UUKjbxyCaIauOtGPq2JFzPtRN
         KkwwmKTejhzfnb2A/l+009rqmXe5ub/S987a3RLvuoBs/LqlWHUPOIGDqBtwYKRPvXqw
         oUnIN+3LGIvv4v6SplH65XffptrYPffIENmj4lGx/sYmm3LSoBRSA3mLGIrJkLWh+uO6
         LCw9b6tmLm3zDWNiehIE4D1ZKmkW9dQnK4dZg8oSr8NFiiteRszz60JAseEHhSm3iI7z
         3HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690036991; x=1690641791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hFJZ+xcFRusdcBFL2o/UHDUh4F9uxkaCVbwwDZqam4=;
        b=Ol3yUvsbbTm5BFgEu5kgCNiEpzn/n/6BLnQgR2Pl5MAvReMjd2Zl7fEuBXSqBUMD2R
         b0WN5g5cpfPQB3Q2w29EptoXxg/vn2Cm9F4Cf+++OJAWRFsO7GRw6xay8WMTtjsqDv/+
         6djof+pUtSOe9eV2GvPnFe68ocRvDk7zn3lZfVHNhIup7lze6R4MjZc7AY7HmxsJIHtU
         uCTB76lAlCFO+GyQ7n/bzcxchR0VcHcSQFBY5uj1+e29DGctwJDaYKoHdgogKOMuR5lM
         JkJX7cpmWhogeGQsUI+scXyktZNMcZ/TOgRKJCDeViDhw1nTybN/QsBePmp+tOCHGkxZ
         /xyg==
X-Gm-Message-State: ABy/qLanfApKQiXlATCUwGCuDF4IqZFgvzlw7W04WJq6Iw83xmeIDpWo
	570jpRuuJuDIhYChkz2I87Q=
X-Google-Smtp-Source: APBJJlErgdgGooW2F/w/K1435mQEMyBu8QIGD0C2jIC1/H5Ux6+4RGuy7x7LfsRXlNq8juYLRI4ZhQ==
X-Received: by 2002:ad4:4088:0:b0:628:335a:174d with SMTP id l8-20020ad44088000000b00628335a174dmr2704171qvp.36.1690036991000;
        Sat, 22 Jul 2023 07:43:11 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o11-20020a0cf4cb000000b00635fc10afd6sm2112257qvm.70.2023.07.22.07.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 07:43:10 -0700 (PDT)
Message-ID: <1e6f6aa2-2fb5-2bf6-0ff8-52bbdcc1eaa5@gmail.com>
Date: Sat, 22 Jul 2023 07:43:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 4/6] net: dsa: microchip: ksz9477: add Wake on
 PHY event support
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-5-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230721135501.1464455-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/2023 6:54 AM, Oleksij Rempel wrote:
> KSZ9477 family of switches supports multiple PHY events:
> - wake on Link Up
> - wake on Energy Detect.
> Since current UAPI can't differentiate between this PHY events, map all of them
> to WAKE_PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

