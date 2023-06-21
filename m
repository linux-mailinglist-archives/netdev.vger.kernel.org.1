Return-Path: <netdev+bounces-12599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45D0738442
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469171C20E3B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6A156FD;
	Wed, 21 Jun 2023 13:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3671FC5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:00:58 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBFE57
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:00:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31121494630so6781881f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687352455; x=1689944455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKfFOA2VQNsIqUQ1flZDf0bxDWmVBHZhAudfMdk56p0=;
        b=HWV31ax/NO65WpLHfIYRSaZG6yjRk9QNUXB+xA5HDAe9pfonOfYq5aly5BHQsGJ41N
         gLbbLh2iUJO63XfOji067mFyQSm0CabxHJW1fprMrXNo0ORUe19uirV+KHs9np78ztV4
         Rd3o4G8ZprBSE6j3jhLRwlLKb/gZvRezPqXtt0uWvbEvZeHdPPf1JIOIi7/EY6sdPc2b
         XNAng8v5xYnTgGQO07o78tLXBvxg3rZjs5PkAzuB2UdDCd+Sv0a5Sl/F9nx3fBnNMY5L
         7aXHvJyTtZswns6dUP1OiuyqRunxMqy+IGJuNiF+XSqcaK5cqvL1HR9lWxHFwEsRRfRj
         z2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352455; x=1689944455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKfFOA2VQNsIqUQ1flZDf0bxDWmVBHZhAudfMdk56p0=;
        b=FyNX4JZu4BkD/0zrQsDZMkEXn1G/wfv3OrwAaR6Dvb6UtCLM2ApVRSruFD5ol2p9g+
         IbIGV0ktos8nJXyRUxPUKvscOu23pC3rBi7ukAOT6JPQFfj45jf1meQ1RNVN6EAr0twp
         ALgXxHQ5RoADPWIkoAB6Q+Ok4LOLDOTtsum+uIN+rxj6t3AkXv0PbtHQNc3Si06SXo20
         3S5CAt62gj1+06Tg1e7gI3n60N2KkBczvElJU8IDu9lIClWHQzih7jWpQ8J4I907Nnax
         dokf+eIKbdTWEkxteEW2gwVx9utebwfGwZQoSH5RhTA2lxMuYCuMxVBfxw52avJcfiMK
         4nxw==
X-Gm-Message-State: AC+VfDxhzbcF0/CEcc/OaIgrVoCsGfJRtJxrNpoqgMEiV6NpiPVMDA7/
	vqgDRcvZB19R1Nu5cmtQhr1TTw==
X-Google-Smtp-Source: ACHHUZ6JKqWTaaZfAwNeGlMyFJwUZ4r0dshdn49b3nRktAmqVPae+sEM6nHr+tXoRT63f9YhRex0EA==
X-Received: by 2002:adf:e8c2:0:b0:30f:cf67:5658 with SMTP id k2-20020adfe8c2000000b0030fcf675658mr13179240wrn.9.1687352442778;
        Wed, 21 Jun 2023 06:00:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d65ca000000b002f28de9f73bsm4420499wrw.55.2023.06.21.06.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 06:00:42 -0700 (PDT)
Message-ID: <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
Date: Wed, 21 Jun 2023 15:00:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Vivek Yadav
 <vivek.2311@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621123158.fd3pd6i7aefawobf@blmsp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/06/2023 14:31, Markus Schneider-Pargmann wrote:
> Hi Krzysztof,
> 
> On Wed, Jun 21, 2023 at 12:28:34PM +0200, Krzysztof Kozlowski wrote:
>> On 21/06/2023 11:31, Markus Schneider-Pargmann wrote:
>>> tcan4552 and tcan4553 do not have wake or state pins, so they are
>>> currently not compatible with the generic driver. The generic driver
>>> uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
>>> are not defined. These functions use register bits that are not
>>> available in tcan4552/4553.
>>>
>>> This patch adds support by introducing version information to reflect if
>>> the chip has wake and state pins. Also the version is now checked.
>>>
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>>  drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
>>>  1 file changed, 104 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
>>> index fb9375fa20ec..756acd122075 100644
>>> --- a/drivers/net/can/m_can/tcan4x5x-core.c
>>> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
>>> @@ -7,6 +7,7 @@
>>>  #define TCAN4X5X_EXT_CLK_DEF 40000000
>>>  
>>>  #define TCAN4X5X_DEV_ID1 0x00
>>> +#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
>>>  #define TCAN4X5X_DEV_ID2 0x04
>>>  #define TCAN4X5X_REV 0x08
>>>  #define TCAN4X5X_STATUS 0x0C
>>> @@ -103,6 +104,13 @@
>>>  #define TCAN4X5X_WD_3_S_TIMER BIT(29)
>>>  #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
>>>  
>>> +struct tcan4x5x_version_info {
>>> +	u32 id2_register;
>>> +
>>> +	bool has_wake_pin;
>>> +	bool has_state_pin;
>>> +};
>>> +
>>>  static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
>>>  {
>>>  	return container_of(cdev, struct tcan4x5x_priv, cdev);
>>> @@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
>>>  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
>>>  }
>>>  
>>> -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
>>> +static const struct tcan4x5x_version_info tcan4x5x_generic;
>>> +static const struct of_device_id tcan4x5x_of_match[];
>>> +
>>> +static const struct tcan4x5x_version_info
>>> +*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
>>> +{
>>> +	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
>>> +		const struct tcan4x5x_version_info *vinfo =
>>> +			tcan4x5x_of_match[i].data;
>>> +		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
>>> +			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
>>> +				 tcan4x5x_of_match[i].compatible);
>>> +			return vinfo;
>>> +		}
>>> +	}
>>> +
>>> +	return &tcan4x5x_generic;
>>
>> I don't understand what do you want to achieve here. Kernel job is not
>> to validate DTB, so if DTB says you have 4552, there is no need to
>> double check. On the other hand, you have Id register so entire idea of
>> custom compatibles can be dropped and instead you should detect the
>> variant based on the ID.
> 
> I can read the ID register but tcan4552 and 4553 do not have two
> devicetree properties that tcan4550 has, namely state and wake gpios.

Does not matter, you don't use OF matching to then differentiate
handling of GPIOs to then read the register. You first read registers,
so everything is auto-detectable.

> See v1 discussion about that [1].

Yeah, but your code is different, although maybe we just misunderstood
each other. You wrote that you cannot use the GPIOs, so I assumed you
need to know the variant before using the GPIOs. Then you need
compatibles. It's not the case here. You can read the variant and based
on this skip entirely GPIOs as they are entirely missing.

> 
> In v1 Marc pointed out that mcp251xfd is using an autodetection and warn
> mechanism which I implemented here as well. [2]

But why? Just read the ID and detect the variant based on this. Your DT
still can have separate compatibles followed by fallback, that's not a
problem.


Best regards,
Krzysztof


