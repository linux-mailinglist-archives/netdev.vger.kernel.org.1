Return-Path: <netdev+bounces-14944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCF74480C
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC7D1C20CD3
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B83D86;
	Sat,  1 Jul 2023 08:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D52F45
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 08:34:06 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4611128
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 01:34:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso134982566b.3
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688200442; x=1690792442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ln71CslK+wNkG4luuwS7YiYZydBZMEVnpr27Fg4FgP0=;
        b=Q2NkimT1scuu/IiVNGHS7pfdg2HjllvWeMMG8MZCygBWNeAyBQ4YZlE8VlWTun+qm+
         qAbWN2xzkTCjjrRMRq4i/pkcFfBg+mP6KaYVMrm+rGQW/5BLU29xi6PRhNSTh4G5aqrd
         3+OuNyObya/Nb6RQWikgKOie/dcsMauAim2cQxxYHcBAjUokVadSDDKl3HnHHeOfUaCX
         OQgjXn6Hu5AgIDFGXiBgTt4h1H26pwj4DbfK4eeTE9f52jY3HuljAk97JnPocjfJpSRA
         cUJ68KOn2nq3XIGz6rhz/YEBKQaS8xAi9gUoebuRWndad1Mrh8JEs5PQ8Qtq37iI3FmB
         IFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200442; x=1690792442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln71CslK+wNkG4luuwS7YiYZydBZMEVnpr27Fg4FgP0=;
        b=Bk6ULL3gaUoMd4/1UXRc0hGpnzDBBSCKVaLwBUjTRN76plV+R01sQ8xxiuUI15d2sj
         ZRZbH5tFzqr2A5/VbIa140lPQW57JS09c7wuAvAhme1t9fMYfmrWy3SBT0bay6fBLnex
         HsOH7wXO1yGnuisI6ySEc6MckdyJudN9Ci7DqWyqWDF+jSCb2olCGJXP08g29zEhTHi5
         h4YicNS1fipv0l5GQVOBCVXDMtpy2MXqkqaEjP2gL5KWu716epahOnhmnwJ5IH+9/UuJ
         EgU35wZsq615cEkyn5nIbiJ023tt8FvI9PHPAC8jhidHUwUXTO4z8EmEVHdXw7mnNfoG
         GpNw==
X-Gm-Message-State: ABy/qLYmVuuKLxZA0J8ypgvijSX+drzwaDbe1SAukSzZLoUYPahkCd9J
	xw/VJL1G0S+2TAEGIiiEOtBxKg==
X-Google-Smtp-Source: APBJJlHxmuqetckhUv6v1CC+aVS7a9zdw4R4oa+2xmoDW0Qz3S/5/qPZdv0AD3U+alxjTqLMoko7jw==
X-Received: by 2002:a17:906:854c:b0:98c:cc3c:194e with SMTP id h12-20020a170906854c00b0098ccc3c194emr3250372ejy.52.1688200442264;
        Sat, 01 Jul 2023 01:34:02 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090633c600b0098748422178sm8908124eja.56.2023.07.01.01.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:34:01 -0700 (PDT)
Message-ID: <e5bd4f01-0b00-4d70-c642-4fdfc0a139fc@linaro.org>
Date: Sat, 1 Jul 2023 10:34:00 +0200
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
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Vivek Yadav
 <vivek.2311@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
 <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
 <20230627142300.heju4qccian5hsjk@blmsp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627142300.heju4qccian5hsjk@blmsp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/06/2023 16:23, Markus Schneider-Pargmann wrote:

>>> The version information is always readable for that chip, regardless of
>>> state and wake GPIOs as far as I know. So yes it is possible to setup
>>> the GPIOs based on the content of the ID register.
>>>
>>> I personally would prefer separate compatibles. The binding
>>> documentation needs to address that wake and state GPIOs are not
>>> available for tcan4552/4553. I think having compatibles that are for
>>> these chips would make sense then. However this is my opinion, you are
>>> the maintainer.
>>
>> We do not talk about compatibles in the bindings here. This is
>> discussion about your driver. The entire logic of validating DTB is
>> flawed and not needed. Detect the variant and act based on this.
> 
> I thought it was about the bindings, sorry.
> 
> So to summarize the compatibles ti,tcan4552 and ti,tcan4553 are fine.
> But the driver should use the ID register for detection and not compare
> the detected variant with the given compatible?
> 
> In my opinion it is useful to have an error messages that says there is
> something wrong with the devicetree as this can be very helpful for the
> developers who bringup new devices. This helps to quickly find issues
> with the devicetree.

That's not a current policy for other drivers, so this shouldn't be
really special. Kernel is poor in validating DTS. It's not its job. It's
the job of the DT schema.

Best regards,
Krzysztof


