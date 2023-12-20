Return-Path: <netdev+bounces-59210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A14819DFD
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6494289BC4
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D2208BC;
	Wed, 20 Dec 2023 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="O5wKBere"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EF21357
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso2851824f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703071666; x=1703676466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIel7XFTmiBrpLn0+7pYKEdYfk2zO/p/x9Mr4kZugQg=;
        b=O5wKBere0TfY/r25sJsVgw8OqORSlVBj8VdSJqyWT+Oy7wxT/+4sLBhi4Ga888eqDA
         Kui5nwsiSWDeeVVp+9Ubtsq1AsM7L2UdNanRHUK93023aJMSM2KzhJqDGXL7AlFNoUuR
         KF3Lh76reGCH7knaJ90t4jNcAae8nJyPUdBkekqszTLhBVrNqqeYB7wxjXJTJwE9CdRF
         9itqMXlc0oBKAQiHvuLOpdU7amsybcKmsLS1twhV3dgplV/IOce8EoDRuiPivVHwSoNI
         lKO7dIpu3CyHNj/Bjp+tukiInMajbrxuX1VtNSsx8ALC4dSoC5uFETYs9gpGmisutqFm
         V5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071666; x=1703676466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIel7XFTmiBrpLn0+7pYKEdYfk2zO/p/x9Mr4kZugQg=;
        b=s5FoEP+PysINn5cgIWk/b/YFNy18H1uqhwPkRVivw12FTjoR87196OWgcyxE7Ryf4x
         3nPWE0SYnQFKpqFXwe73OXbKhCCMujD08NdOs0aSgii/YSpA02RqXCbk0BLRtbmnPLvv
         mi509urj+EJLW3S9K75QnazkFRDFSIil5qMpQvnlwPxQVrRqqr652hiF3skBw7D4FTzb
         hwY0yRGWmM7cKtIcJ4vAp9nekML3IOGjY5i45r6XHYiP2zVNbMKtPGzclA15FQjuEukm
         YrxpWK07sgQqjQVDytTLFcZQ4+XehTpG/Y/PZkUwEnAQsJIfGkU5+AwjRLWQvkamIQOZ
         Ir7A==
X-Gm-Message-State: AOJu0YzxX7KkBPazhMfvs+OYgahD+E6uM6Oatj4Yz4NN5o1LlYVXwK0T
	ebqiVA9cVVpvmKUicp6DgPcv1g==
X-Google-Smtp-Source: AGHT+IHR8g8RtJyeCfjQMjEGwJURvM0JKUzavHP1V0nZXPmBQpWvLglrlOcFYYjNJdKS1+in0fcCtw==
X-Received: by 2002:adf:ce08:0:b0:336:5d20:db7a with SMTP id p8-20020adfce08000000b003365d20db7amr1904063wrn.219.1703071666158;
        Wed, 20 Dec 2023 03:27:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id o15-20020a056000010f00b0033671cdf33fsm4205690wrx.94.2023.12.20.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:27:45 -0800 (PST)
Message-ID: <a617f464-e61e-44a7-8483-8890d4b2142f@tuxon.dev>
Date: Wed, 20 Dec 2023 13:27:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ravb: Wait for operation mode to be applied
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
 wsa+renesas@sang-engineering.com, niklas.soderlund+renesas@ragnatech.se,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-2-claudiu.beznea.uj@bp.renesas.com>
 <d08dbbd4-2e63-c436-6935-df68c291bf75@omp.ru>
 <0b807496-f387-4aef-8650-a43a9249468f@tuxon.dev>
 <2e70a095-8079-84f1-f842-eb90059610ed@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <2e70a095-8079-84f1-f842-eb90059610ed@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.12.2023 18:49, Sergey Shtylyov wrote:
> On 12/15/23 1:04 PM, claudiu beznea wrote:
> [...]
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> CSR.OPS bits specify the current operating mode and (according to
>>>> documentation) they are updated when the operating mode change request
>>>> is processed. Thus, check CSR.OPS before proceeding.
>>>
>>>    The manuals I have indeed say we need to check CSR.OPS... But we only
>>> need to wait iff we transfer from the operation mode to the config mode...
>>
>> RZ/G3S manual say about CSR.OPS "These bits are updated when an operating
> 
>    I was unable to find the RZ/G3 manuals on ther Renesas' website... :-(
> 
>> mode changes is processed". From this I get we need to check it for any mode.
> 
>   I don't argue with the (safety) checking of CSR.OPS, I was just pointing
> out that the R-Car gen3 manual says that only transfer from operation to
> the config mode happens after a considerable amount of time, other transfers
> do happen immediately after updating CCC.OPC.
> 
>> Also, on configuration procedure (of RZ/G3S) it say CSR.OPS need to be
>> checked when switching from reset -> config.
> 
>    Just checked or waited on?

Manual say to check that the read value of CSR.OPS=2

>    The R-car does have a specific algorithm for transferring from the operation
> to the reset mode (you need to set CC.DTSR first and then wait for CSR.DTS to
> clear before updating CCC.OPC)...

In the stop procedure chapter of RZ/G3S manual, as the setup of DMAC.CCC=0
is the last operation that needs to be done, it doesn't specify either that
CSR needs to be checked.

> 
> [...]
> 
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>  drivers/net/ethernet/renesas/ravb_main.c | 47 ++++++++++++++++++++----
>>>>  1 file changed, 39 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 9178f6d60e74..ce95eb5af354 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>>>> @@ -1744,6 +1747,18 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>>>>  	return error;
>>>>  }
>>>>  
>>>> +static int ravb_set_reset_mode(struct net_device *ndev)
>>>> +{
>>>> +	int error;
>>>> +
>>>> +	ravb_write(ndev, CCC_OPC_RESET, CCC);
>>>> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_RESET);
>>>> +	if (error)
>>>> +		netdev_err(ndev, "failed to switch device to reset mode\n");
>>>> +
>>>> +	return error;
>>>> +}
>>>> +
>>>
>>>    Again, ravb_wait() call doesn't seem necessary here...
>>
>> Ok. I followed the guideline from the description of CSR.OPS. Let me know
>> if you want to keep it or not. I think I haven't saw any issues w/o this.
> 
>   Yes, please remove the waiting.
> 
> [...]
> 
> MBR, Sergey

