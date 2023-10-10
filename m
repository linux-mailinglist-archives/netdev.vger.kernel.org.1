Return-Path: <netdev+bounces-39434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102797BF318
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EF281953
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24147A31;
	Tue, 10 Oct 2023 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzmM6Ipd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395209449
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:31:49 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EDB7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 23:31:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso4216673a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696919506; x=1697524306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Lm6xwFXvXkw+ZkYlaBjSNRCXXQCylJxZWtff4PTZuQ=;
        b=JzmM6IpdJBLNwO8DiuDRn9vT9U2b+vBD+iCdBp3N8em0Bh1Gr1lRSod2N3LtEjfaCm
         g4WenTvW98nF+DB+kWKuDp9JVLY5AcJEH/bCJ5ORAoKCQxW5TM1rDeLs9ija4IFGjsnI
         85k+dZDBv1gnYiycCmYo1A3pYqUTZDgeMCtwUMEoUZgAlnLlbpBc/D0wF/GrMet1SeYI
         rSpZ14mHz8DJzRIql2UeljW0tdMn7BQjkQZ1zQX9lGivooGAmB7wFdQ5mgAdXrPr4wC6
         n02ca3IrZ0ILUBtFWc7xVd0AoAq7zmYasK2cjwdDELhPCPPTDG1pB5yANBSlO0EvQYFx
         XBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919506; x=1697524306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lm6xwFXvXkw+ZkYlaBjSNRCXXQCylJxZWtff4PTZuQ=;
        b=RAAVfl6/agvmoiDXZSEbrYE8e5lRwIcD8/nxqZVCGCRVv2ipJlyiBVi9O5/Dn61Sry
         dp/gFlL0OhpbUBAuf8RYOlXo+ZrxgiGRBqisgNxRWj70DsCLd9pWzEDeDo59AVHfOqzL
         /mNKYvoVVW2oslsgTorLtbOgjr5YXNElbqNfFuSWaLZlyqMB2ChDY/mSMaT4hq4E3X0U
         QKtlUzyt5e1SZA1N9Z2jLgFnJiMGWQHeu8uCruChPFyrkv7MX0WXYvyL8GLp/UMR5JHE
         BKfOAIEuCksbU6KJYt8ozA+1fcHSIoJpue43cQMWDRIdpwRvx+DneLuuJsz8/Hs4CJlR
         X9Qw==
X-Gm-Message-State: AOJu0YxAdHCKFIPNPHdDIKVPshH/8tpQ9QSOu0NvSovrUCY3hYAT/18p
	QpIU34zbJkhEDMkq2CRPj3g=
X-Google-Smtp-Source: AGHT+IF1VrgybPQ2EirqQ1L2V1WIqLgFz8Gg9WUBCv28ct/Pi2D8CtShMUggzUDuIjVJvOHrHxV1gg==
X-Received: by 2002:a17:907:75d9:b0:9ba:7f5:35df with SMTP id jl25-20020a17090775d900b009ba07f535dfmr7261534ejc.29.1696919505473;
        Mon, 09 Oct 2023 23:31:45 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id ko18-20020a170907987200b0099275c59bc9sm7970254ejc.33.2023.10.09.23.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 23:31:45 -0700 (PDT)
Message-ID: <59bdf96f-0ff4-40da-a2ac-7d12aedeb98a@gmail.com>
Date: Tue, 10 Oct 2023 09:31:42 +0300
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
To: Will Mortensen <will@extrahop.com>, netdev@vger.kernel.org
Cc: Charlotte Tan <charlotte@extrahop.com>, Adham Faris <afaris@nvidia.com>,
 Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
References: <20231006053706.514618-1-will@extrahop.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231006053706.514618-1-will@extrahop.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 06/10/2023 8:37, Will Mortensen wrote:
> Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs
> flag change") seems to have accidentally inverted the logic added in
> commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
> RX-port-timestamp").
> 
> The impact of this is a little unclear since it seems the FCS scattered
> with RX-FCS is (usually?) correct regardless.
> 

Thanks for your patch.

> Fixes: 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs flag change")
> Tested-by: Charlotte Tan <charlotte@extrahop.com>
> Reviewed-by: Charlotte Tan <charlotte@extrahop.com>
> Cc: Adham Faris <afaris@nvidia.com>
> Cc: Aya Levin <ayal@nvidia.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Moshe Shemesh <moshe@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Will Mortensen <will@extrahop.com>
> ---
> For what it's worth, regardless of this change the PCMR register behaves
> unexpectedly in our testing on NICs where rx_ts_over_crc_cap is 1 (i.e.
> where rx_ts_over_crc is supported), such as ConnectX-7 running firmware
> 28.37.1014. For example, fcs_chk is always 0, and rx_ts_over_crc can
> never be set to 1 after being set to 0. On ConnectX-5, where
> rx_ts_over_crc_cap is 0, fcs_chk behaves as expected.
> 
> We'll probably be opening a support case about that after we test more,
> but I mention it here because it makes FCS-related testing confusing.
> 

Please open the case and we'll analyze.

>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index a2ae791538ed..acb40770cf0c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
>   	struct mlx5e_channels *chs = &priv->channels;
>   	struct mlx5e_params new_params;
>   	int err;
> +	bool rx_ts_over_crc = !enable;

nit:  Please maintain the reserved Christmas tree.

>   
>   	mutex_lock(&priv->state_lock);
>   
>   	new_params = chs->params;
>   	new_params.scatter_fcs_en = enable;
>   	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
> -				       &new_params.scatter_fcs_en, true);
> +				       &rx_ts_over_crc, true);
>   	mutex_unlock(&priv->state_lock);
>   	return err;
>   }

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Regards,
Tariq

