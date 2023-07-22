Return-Path: <netdev+bounces-20140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5775DCF5
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A422820DD
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34691D31A;
	Sat, 22 Jul 2023 14:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79472908
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 14:42:42 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41529273F;
	Sat, 22 Jul 2023 07:42:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40544d92632so11940541cf.0;
        Sat, 22 Jul 2023 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690036956; x=1690641756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qLcXEb0VR5Cf6WykyJG4ie9G8Uz09DI+cVbvLRerB0=;
        b=iXISGori3ccYDXsNBPxeHXIbW9MjxhteIXEYPhuGRENcuCeTPefXTwkxI3Q6VdAnjW
         7iZ650JHYglnkaUVIWv7NNwyj4gs+bVzh+VOCZ11ZVsOnP2QLOBeduCt29LOVRjQ7gUs
         wAFyyT027o70JPF70ZGVzw6NHvebh2LF4EhL3VWsx5wSB7PPnkUgqIHHEij/qjCIRHI2
         f+waH5ZUpW0IBlMsB0IxFzdhC+bCex7VKIuYTx32eT9D1OJ7si3wwKHI7yTzYSWEHoQj
         bMCHYq8p4FMU5ma6wIF0fbGsWE2n+n2gcPUvqyQJm4oL/QCYawkZkq16VzcvndnLt9xZ
         Lmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690036956; x=1690641756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qLcXEb0VR5Cf6WykyJG4ie9G8Uz09DI+cVbvLRerB0=;
        b=h4bycTvjju5cxCz4WwV37eMUZfr/8a9rWUtBHq54X0GdvSEeIyHONuJtQKDg6LjwfF
         TwAViMWcPuOsIlxO0dZ69ow8ru5ogaPoprcblhLBfftWpmXhx2blqaeEjeE6Tx1XWmof
         2kwT8LDF5l2jyewSTcBfjPiE/KC6N+LDSQ224xxX1l268pMA+vcmV7fML9Tnb4WUDSWa
         KVpBJCbTOo/prQowjDWaEldoQtVceMEjTS+XynJGLV30T9L111LY+Z7jCduPwsmW7kxX
         Qgs/MJr20nfZHb4XXhwgivZr9bgM2m4Op+aG+SqjPWxkpMWbVci114nYByi8bX3OPwvm
         eJTw==
X-Gm-Message-State: ABy/qLbAIQp0G57qXC4aPrMAVsJ+I6E66lQGyldK9HkHFtxpYTcplhRX
	jtulF61fr24RwsmhIIn62aQ=
X-Google-Smtp-Source: APBJJlFGwQsJ/25EUB+Y4ou3Yrl88gbbUqcchQcIXMYHldG/Kdx3vsJ7tgr26EhCLlyO2XtVllGhuA==
X-Received: by 2002:ac8:7dc7:0:b0:405:379e:c460 with SMTP id c7-20020ac87dc7000000b00405379ec460mr3577351qte.6.1690036956187;
        Sat, 22 Jul 2023 07:42:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v13-20020ac8748d000000b004053bcffe49sm2045429qtq.9.2023.07.22.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 07:42:35 -0700 (PDT)
Message-ID: <638af3f5-62a3-33c4-3c3f-7631c7c89425@gmail.com>
Date: Sat, 22 Jul 2023 07:42:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 3/6] net: dsa: microchip: ksz9477: add Wake on
 LAN support
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
 <20230721135501.1464455-4-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230721135501.1464455-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/2023 6:54 AM, Oleksij Rempel wrote:
> Add WoL support for KSZ9477 family of switches. This code was tested on
> KSZ8563 chip and supports only wake on Magic Packet for now.
> Other parts needed for fully operational WoL support are in the followup
> patches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

