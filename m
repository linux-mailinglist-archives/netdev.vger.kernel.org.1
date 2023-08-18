Return-Path: <netdev+bounces-28759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7178083B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4049F282327
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F117FFF;
	Fri, 18 Aug 2023 09:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E6168B7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:27:17 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AC358D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:27:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa4f4769fso529213e87.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692350834; x=1692955634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Z87GGNmltjqzIqop3zxYjONMRgy+B5FGC3FUHfgldc=;
        b=ZiSo256GEEWvCvqeRaLUi7wPkeCTYrpO5vZpQ5cB5mXkLBzzyuQijhBSCk878IbH1Y
         bjKO4EvazNihA8WFg9dk0cb20ZwztmGt/raZVzghmDySYEX9Ut8XNW26iPlv0GDOj1K+
         3Jkr+w2nFr+j07NVXSzPqRjKMmXGh+TXSuVKOR/pr5AZSjDv9kuOHsTcnBImK/3JehyG
         JlggT1XuZ/rZOpPuVWLaKdkSyA4S6haFPaD5ZzHJjwfZ9OXlxQt0DYSjDy/3J6wFGpvR
         NJLij0l3QzvukuFjPdB9kSIAnAZjoy2tTHADmjW6AgOShnNR0UfrvlhbSNWNw/GvfSC7
         tyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350834; x=1692955634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z87GGNmltjqzIqop3zxYjONMRgy+B5FGC3FUHfgldc=;
        b=ikpics7Y1MzO9/r46sbp5VFWtDzdlJHKaVPZdCo3GDsgqBb8sL+JNJfTRxD/K2xuvM
         KSccIM8Pa+2CNui9nBUXw/18sjk+AKYwPHf6oO4yCW5ZcjZveDjHCiDM18hUR11CTMdL
         Qs70PnQ1mm/KkUxQExY6p0+4twHcOR9Xk63TBOZucTqKY6RyMqfR+60/Y1S3pl1E8m9T
         z8SKVbFAfKv5bWE0pHMXQUrrqAZzOUA+Mj9sVaKXbN3Ika8iA8nt/XPOVaOvXiP2XhWs
         d+qQUbelAw9eKTKV29PS2sJTCJLX7zU+BTtaGRb/TcKI7t2Dcd2JAVGK9ZXWR6GQAEpB
         Xv6Q==
X-Gm-Message-State: AOJu0YzY40orl3/xZtM/fZNdTBqAxMdCSQQ+FrsMpVnVMg628wPqBOpY
	sBWn/DlImpD4sNKC4Q+6tMm+Rw==
X-Google-Smtp-Source: AGHT+IG0CT97L1dSo3YOtkbV8RuaYY6ec7OJaGEK/3YWxB0YJdX8qmnprfp2re3OtDgPIJ4dCVQBcw==
X-Received: by 2002:ac2:4a7c:0:b0:4fe:c53:1824 with SMTP id q28-20020ac24a7c000000b004fe0c531824mr1256242lfp.40.1692350834534;
        Fri, 18 Aug 2023 02:27:14 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00982be08a9besm966046ejr.172.2023.08.18.02.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:27:14 -0700 (PDT)
Message-ID: <baa64cff-885a-2ecb-8a0f-3b820e55e1b8@linaro.org>
Date: Fri, 18 Aug 2023 11:27:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Content-Language: en-US
To: Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 richardcochran@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
 linux-fsd@tesla.com, pankaj.dubey@samsung.com, swathi.ks@samsung.com,
 ravi.patel@samsung.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 'Chandrasekar R'
 <rcsekar@samsung.com>, 'Suresh Siddha' <ssiddha@tesla.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
 <20230814112539.70453-3-sriranjani.p@samsung.com>
 <b224ccaf-d70f-8f65-4b2f-6f4798841558@linaro.org>
 <001201d9d00c$5413a9a0$fc3afce0$@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <001201d9d00c$5413a9a0$fc3afce0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/08/2023 08:38, Sriranjani P wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 15 August 2023 01:21
>> To: Sriranjani P <sriranjani.p@samsung.com>; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> conor+dt@kernel.org; richardcochran@gmail.com;
>> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
>> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
>> fsd@tesla.com; pankaj.dubey@samsung.com; swathi.ks@samsung.com;
>> ravi.patel@samsung.com
>> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Chandrasekar R <rcsekar@samsung.com>;
>> Suresh Siddha <ssiddha@tesla.com>
>> Subject: Re: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
>>
>> On 14/08/2023 13:25, Sriranjani P wrote:
>>> The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP
>> core.
>>> The binding that it uses is slightly different from existing ones
>>> because of the integration (clocks, resets).
>>>
>>> For FSD SoC, a mux switch is needed between internal and external clocks.
>>> By default after reset internal clock is used but for receiving
>>> packets properly, external clock is needed. Mux switch to external
>>> clock happens only when the external clock is present.
>>>
>>> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
>>> Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
>>> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
>>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>>> ---
>>
>>
>>> +static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int
>>> +ins_num) {
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	struct regmap *syscon;
>>> +	unsigned int reg;
>>> +
>>> +	if (np && of_property_read_bool(np, "fsd-rx-clock-skew")) {
>>> +		syscon = syscon_regmap_lookup_by_phandle_args(np,
>>> +							      "fsd-rx-clock-
>> skew",
>>> +							      1, &reg);
>>> +		if (IS_ERR(syscon)) {
>>> +			dev_err(&pdev->dev,
>>> +				"couldn't get the rx-clock-skew syscon!\n");
>>> +			return PTR_ERR(syscon);
>>> +		}
>>> +
>>> +		regmap_write(syscon, reg, rx_clock_skew_val[ins_num]);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int fsd_eqos_clk_init(struct fsd_eqos_plat_data *plat,
>>> +			     struct plat_stmmacenet_data *data) {
>>> +	int ret = 0, i;
>>> +
>>> +	const struct fsd_eqos_variant *fsd_eqos_v_data =
>>> +						plat->fsd_eqos_inst_var;
>>> +
>>> +	plat->clks = devm_kcalloc(plat->dev, fsd_eqos_v_data->num_clks,
>>> +				  sizeof(*plat->clks), GFP_KERNEL);
>>> +	if (!plat->clks)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < fsd_eqos_v_data->num_clks; i++)
>>> +		plat->clks[i].id = fsd_eqos_v_data->clk_list[i];
>>> +
>>> +	ret = devm_clk_bulk_get(plat->dev, fsd_eqos_v_data->num_clks,
>>> +				plat->clks);
>>
>> Instead of duplicating entire clock management with existing code, you
>> should extend/rework existing one.
>>
>> This code is unfortunately great example how not to stuff vendor code into
>> upstream project. :(
> 
> I will check again if I can extend existing one to support FSD platform specific requirement.
> 
>>
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int fsd_clks_endisable(void *priv, bool enabled) {
>>> +	int ret, num_clks;
>>> +	struct fsd_eqos_plat_data *plat = priv;
>>> +
>>> +	num_clks = plat->fsd_eqos_inst_var->num_clks;
>>> +
>>> +	if (enabled) {
>>> +		ret = clk_bulk_prepare_enable(num_clks, plat->clks);
>>> +		if (ret) {
>>> +			dev_err(plat->dev, "Clock enable failed, err = %d\n",
>> ret);
>>> +			return ret;
>>> +		}
>>> +	} else {
>>> +		clk_bulk_disable_unprepare(num_clks, plat->clks);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int fsd_eqos_probe(struct platform_device *pdev,
>>> +			  struct plat_stmmacenet_data *data,
>>> +			  struct stmmac_resources *res)
>>> +{
>>> +	struct fsd_eqos_plat_data *priv_plat;
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	int ret = 0;
>>> +
>>> +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat),
>> GFP_KERNEL);
>>> +	if (!priv_plat) {
>>> +		ret = -ENOMEM;
>>
>> return -ENOMEM
> 
> Will fix this in v4.
> 
>>
>>> +		goto error;
>>> +	}
>>> +
>>> +	priv_plat->dev = &pdev->dev;
>>> +	data->bus_id = of_alias_get_id(np, "eth");
>>
>> No, you cannot do like this. Aliases are board specific and are based on
>> labeling on the board.
> 
> So if I understood this correctly, I need to move alias in the board specific DTS file 

This part: yes

> and I can use this, because we have to handle rx-clock-skew differently for the two instances in the FSD platform.

Not really. Do you expect it to work correctly if given EQoS instance
receives different alias, e.g. 5?

> Another approach we took in v1, by specifying the value to be programmed in rx-clock-skew property itself, but it seems it is not a preferred approach. 
> I can see that in drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c +436 common code is already using this API and getting alias id, so I can probably use the same rather getting same again here, but I have to specify alias in DTS file.

Getting alias ID is okay in general. It is used to provide user-visible
ID of the devices (see mmc). Using such alias to configure hardware is
abuse of the alias, because of the reasons I said - how is it supposed
to work if alias is 5 (this is perfectly valid alias)?

I suspect that all this is to substitute missing abstractions, like
clocks, phys or resets...

Best regards,
Krzysztof


