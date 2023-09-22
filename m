Return-Path: <netdev+bounces-35893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6F7AB800
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EC96C1C20A50
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463E436AB;
	Fri, 22 Sep 2023 17:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B31E502
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:44:35 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188B102
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:44:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2078449a12.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404673; x=1696009473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48hsxIR1caSWo+4fM2OdD7eFzU2ewvr2t3y6QnF5b0Q=;
        b=Y/XSzOnKqF9v4AVeDmaDMyObFoDIY0jXD44Ju97aTMQcbn7Teq/9Pc5jHRc4CXKAAb
         Y6nwjzlwM+jJQQj2Gwgs7BPJGFvPNi5cOs4O3/mOOgI1bAPog7Ra5YQ3LVY5T1FPezZv
         IABFlyT5gS+NWnfKBX6r5yHublCMU37FkXJLZu1BCKdkEYqbFi5gYuScvTm6qq2E5y1c
         iU2St1WAELyihkHTXrZy24ohVXuaUQ6Y8buQ6iGUV177Kp1RW60ePmzawhOR13B0ZLXm
         HZ8kmGh1a+7tPzeEU4eFZSSkFFfVV0s2YCyMpNFkFp0+Hmp8de5nmPszXimtXYTvH4cZ
         BoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404673; x=1696009473;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48hsxIR1caSWo+4fM2OdD7eFzU2ewvr2t3y6QnF5b0Q=;
        b=Zima6W5CgBMmSkVpAO9gXfXU3MGpuKRjIxlqMeWC5BoYeALfLiZxL+d2iogQ1R2Ul6
         5hyJlCqSyenj8H14RMqFzj/TJ+pHsD9edoWrtu52NksGjbWqy8Xn7iFEtdod0UZYvsne
         fzZ+fg85K6uHmRR+mgB7bZKlNk7bMKOxVp075MjEFaILAEdbUriV+OJRjHZzXDS529n+
         dvROhX/28aUU3eOga80S8zp0IYjLarAh/LmCKpp6nEsh9NFFLYB6nYKh2JO5osjV7Dk/
         bfvo77u6fUYuRgCR5Tt5MTBPEbeuhdsLl4IUu7WZYy0qDuojy5y75W60tcfsRLOpoGLI
         OqXw==
X-Gm-Message-State: AOJu0YzUej/j+qEvS+6/J2NOVMv8ZtJlbwmS5y1P+4aQVlj+bt4zwHvF
	r5mRCHTd6igPP46ws2cJ0Aw=
X-Google-Smtp-Source: AGHT+IFF84DnnzxMd28vSJJ1sKo3HAoy+dIB7ZhoY3e9WICGRbCny4A/H/6R5SInutYKc1omP/iBig==
X-Received: by 2002:a17:90a:9202:b0:26b:36a4:feeb with SMTP id m2-20020a17090a920200b0026b36a4feebmr4798659pjo.8.1695404672714;
        Fri, 22 Sep 2023 10:44:32 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0026971450601sm3509936pjb.7.2023.09.22.10.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 10:44:31 -0700 (PDT)
Message-ID: <64a2b71c-f3ee-4a95-a2d4-79d2258a70e8@gmail.com>
Date: Fri, 22 Sep 2023 10:44:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, davthompson@nvidia.com
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-2-asmaa@nvidia.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20230922173626.23790-2-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/2023 10:36 AM, Asmaa Mnebhi wrote:
> There is a race condition happening during shutdown due to pending napi transactions.
> Since mlxbf_gige_poll is still running, it tries to access a NULL pointer and as a
> result causes a kernel panic:
> 
> [  284.074822] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> ...
> [  284.322326] Call trace:
> [  284.324757]  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
> [  284.330924]  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
> [  284.335876]  __napi_poll+0x40/0x1c8
> [  284.339353]  net_rx_action+0x314/0x3a0
> [  284.343086]  __do_softirq+0x128/0x334
> [  284.346734]  run_ksoftirqd+0x54/0x6c
> [  284.350294]  smpboot_thread_fn+0x14c/0x190
> [  284.354375]  kthread+0x10c/0x110
> [  284.357588]  ret_from_fork+0x10/0x20
> [  284.361150] Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
> [  284.367227] ---[ end trace a18340bbb9ea2fa7 ]---
> 
> To fix this, invoke mlxbf_gige_remove to disable and dequeue napi during shutdown,
> and also return in the case where "priv" is NULL in the poll function.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
> v2->v3:
> - Add the logic to clean the port to the remove() function
> v1-v2:
> - make mlxbf_gige_shutdown() the same as the mlxbf_gige_remove()
> 
>   .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 21 ++++++++-----------
>   .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  3 +++
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> index 694de9513b9f..74185b02daa0 100644
> --- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> +++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> @@ -471,24 +471,21 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> -static int mlxbf_gige_remove(struct platform_device *pdev)
> +static void mlxbf_gige_remove(struct platform_device *pdev)
>   {
>   	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
>   
> +	if (!priv)
> +		return;
> +
> +	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
> +        mlxbf_gige_clean_port(priv);
>   	unregister_netdev(priv->netdev);
>   	phy_disconnect(priv->netdev->phydev);
>   	mlxbf_gige_mdio_remove(priv);
> -	platform_set_drvdata(pdev, NULL);
> -
> -	return 0;
> -}
> -
> -static void mlxbf_gige_shutdown(struct platform_device *pdev)
> -{
> -	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
> -
>   	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
>   	mlxbf_gige_clean_port(priv);
> +	platform_set_drvdata(pdev, NULL);
>   }
>   
>   static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
> @@ -499,8 +496,8 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
>   
>   static struct platform_driver mlxbf_gige_driver = {
>   	.probe = mlxbf_gige_probe,
> -	.remove = mlxbf_gige_remove,
> -	.shutdown = mlxbf_gige_shutdown,
> +	.remove_new = mlxbf_gige_remove,
> +	.shutdown = mlxbf_gige_remove,
>   	.driver = {
>   		.name = KBUILD_MODNAME,
>   		.acpi_match_table = ACPI_PTR(mlxbf_gige_acpi_match),
> diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> index 0d5a41a2ae01..cfb8fb957f0c 100644
> --- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> @@ -298,6 +298,9 @@ int mlxbf_gige_poll(struct napi_struct *napi, int budget)
>   
>   	priv = container_of(napi, struct mlxbf_gige, napi);
>   
> +	if (!priv)
> +		return 0;

Do you still need this test even after you unregistered the network 
device in your shutdown routine?
-- 
Florian

