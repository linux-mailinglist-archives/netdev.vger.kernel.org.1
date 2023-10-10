Return-Path: <netdev+bounces-39502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23B7BF8FF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882941C20B35
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE28DF57;
	Tue, 10 Oct 2023 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9r+6OdU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B11FBED
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:50:12 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDBB0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:50:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so3578378f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696935008; x=1697539808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8TmdC+t8qYrJF6bfPCx2Y6d8qhk7gCpEvdVoAqs8o=;
        b=L9r+6OdUAhXaaOTKk1vHoyDeyaAu2xRR1lQg4M0qr3H/E4MZ9HSmNXYGmYDC31E4W4
         F7+mem7TTixYIO3XGEM1MAte8Tgao+Q4mUcixn5c1/uBpoOYHyugIAsLDJEzZP1AoHGW
         76NmnCwIbG3RdzGpDJ4FSZX9kHgqOUX3xTexgCnv2GcjR9HA22JSyFmW2po6/X0hGD5N
         BxZtEJed4rcA9rcZ1fsjch30pNI69S74GLTuYDhorIw6/fMWJkF8okVL5o80wK5C7OKX
         2Qhxqw21556w7UsV3TBnj0CBO218RNlHbKuP7B5e3ZjDUhF3CMWfdKzcJyNiq2xezGTc
         IOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696935008; x=1697539808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8TmdC+t8qYrJF6bfPCx2Y6d8qhk7gCpEvdVoAqs8o=;
        b=JVXGIev6tgQQ3QZ4BTz2e8k/aFyWOt1y7WwyKLPbMBxIXp7XetybKwrjFeuzIvicNk
         C5LCUKTCLX9/74KNUi+Wvh/Dmr3s6lcleowxyelJhtmJNvMw+FIbcsC6po2LAS6JnRHk
         t6IG+INRb82WvNDjIspN52Zw9KAJ4B0fWsZFVpH4hvhP7We/qQgyVIV8r8N1VzFnkjAd
         GYjsXRjG1NpK9FYjPdAAE3P2jbkxeNTp6Wh/2Xi7VmQtWdeg576sFn23oS+TDGGtSiUe
         KXkbAdaUlqjN2I406jpZJL5PT/TBPftB+rTv5Xns4IHWBGbxeH+/HQ8VT6uw8RXOF4oE
         sI+Q==
X-Gm-Message-State: AOJu0YyrY7o9JD+Lt9A206zK776k0CzJDG/iyJ+hw7ECccUlL7+iLJkO
	DbvKU7ACaGMajSzKei51pev5Kd1szsc6aw==
X-Google-Smtp-Source: AGHT+IEalceIbmQVEeieiFGxt8Wqgt0WIumolyhvKBgKR8gejElo62YqEoNxA0BPupCc3bSyitd1Bw==
X-Received: by 2002:a5d:504e:0:b0:320:bbb:5ab1 with SMTP id h14-20020a5d504e000000b003200bbb5ab1mr15536004wrt.14.1696935007556;
        Tue, 10 Oct 2023 03:50:07 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id f19-20020a7bc8d3000000b00405959469afsm13848772wml.3.2023.10.10.03.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 03:50:07 -0700 (PDT)
Message-ID: <d9eea2bd-2f82-42b5-995e-931ef3edd0b8@gmail.com>
Date: Tue, 10 Oct 2023 13:50:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: Again mutually exclude RX-FCS and
 RX-port-timestamp
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Will Mortensen <will@extrahop.com>,
 netdev@vger.kernel.org
Cc: Charlotte Tan <charlotte@extrahop.com>, Adham Faris <afaris@nvidia.com>,
 Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
References: <20231006053706.514618-1-will@extrahop.com>
 <59bdf96f-0ff4-40da-a2ac-7d12aedeb98a@gmail.com>
 <c1ef9288a88a6354292fa04dc713a5d5cd2d6936.camel@redhat.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <c1ef9288a88a6354292fa04dc713a5d5cd2d6936.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/2023 11:52, Paolo Abeni wrote:
> On Tue, 2023-10-10 at 09:31 +0300, Tariq Toukan wrote:
>>
>> On 06/10/2023 8:37, Will Mortensen wrote:
>>> Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs
>>> flag change") seems to have accidentally inverted the logic added in
>>> commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
>>> RX-port-timestamp").
>>>
>>> The impact of this is a little unclear since it seems the FCS scattered
>>> with RX-FCS is (usually?) correct regardless.
>>>
>>
>> Thanks for your patch.
>>
>>> Fixes: 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs flag change")
>>> Tested-by: Charlotte Tan <charlotte@extrahop.com>
>>> Reviewed-by: Charlotte Tan <charlotte@extrahop.com>
>>> Cc: Adham Faris <afaris@nvidia.com>
>>> Cc: Aya Levin <ayal@nvidia.com>
>>> Cc: Tariq Toukan <tariqt@nvidia.com>
>>> Cc: Moshe Shemesh <moshe@nvidia.com>
>>> Cc: Saeed Mahameed <saeedm@nvidia.com>
>>> Signed-off-by: Will Mortensen <will@extrahop.com>
>>> ---
>>> For what it's worth, regardless of this change the PCMR register behaves
>>> unexpectedly in our testing on NICs where rx_ts_over_crc_cap is 1 (i.e.
>>> where rx_ts_over_crc is supported), such as ConnectX-7 running firmware
>>> 28.37.1014. For example, fcs_chk is always 0, and rx_ts_over_crc can
>>> never be set to 1 after being set to 0. On ConnectX-5, where
>>> rx_ts_over_crc_cap is 0, fcs_chk behaves as expected.
>>>
>>> We'll probably be opening a support case about that after we test more,
>>> but I mention it here because it makes FCS-related testing confusing.
>>>
>>
>> Please open the case and we'll analyze.
>>
>>>    drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index a2ae791538ed..acb40770cf0c 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> @@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
>>>    	struct mlx5e_channels *chs = &priv->channels;
>>>    	struct mlx5e_params new_params;
>>>    	int err;
>>> +	bool rx_ts_over_crc = !enable;
>>
>> nit:  Please maintain the reserved Christmas tree.
>>
>>>    
>>>    	mutex_lock(&priv->state_lock);
>>>    
>>>    	new_params = chs->params;
>>>    	new_params.scatter_fcs_en = enable;
>>>    	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
>>> -				       &new_params.scatter_fcs_en, true);
>>> +				       &rx_ts_over_crc, true);
>>>    	mutex_unlock(&priv->state_lock);
>>>    	return err;
>>>    }
>>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> 
> @Tariq: do you prefer we will take this patch directly, or do you
> prefer send it with a later PR?
> 
> Thanks,
> 
> Paolo
> 

Please take it.

Thanks,
Tariq

