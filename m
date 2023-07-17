Return-Path: <netdev+bounces-18402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E083756C3D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875771C20841
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51721253BE;
	Mon, 17 Jul 2023 18:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF028FA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:37:15 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0CE55;
	Mon, 17 Jul 2023 11:37:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so6515169a12.1;
        Mon, 17 Jul 2023 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619023; x=1692211023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0ders07hbD+fLOIN4lwSi2Bg6Ivi/QgQpSiutzHFOw=;
        b=i1BhaG2CTB71FjSsHWDEAULm8zYwNtDHVsW5dVN16IlOeNLLVIM5LhkileG5GFZngJ
         OcPHvnfa1znLiPWRgG/DHHQDnDjTtjI+F4+t7iBokoUWqU+ljJpg0BI+5Rt3hhI8HNNo
         Rw4wsV2aBUT4WYR89eDCGiIUJ9QBchy3j68po/3f1HEmOLUSP5MLQtou5BjzhgYK4A+5
         ZmHT/oayhWO5w4hF2qeIgMWZrOv3vZl5JtsBGLkDwYqeVKOBnj9OGmOdS2/skk4rOfhV
         wx2rkaQbCMkADbruIUAbfNsQ+Ni9XdJe4VdAJhdYIu1ltH+fxxBVBTN3FwtKrFZL4Bxj
         BNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619023; x=1692211023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0ders07hbD+fLOIN4lwSi2Bg6Ivi/QgQpSiutzHFOw=;
        b=ZKUU7Z5vljTIxs4jdpjPCFW8X1duPpPWpAXz9+tjrBNsmJFjZZ27oGj+eT3Cdzn5Zg
         SM/GI4iSt+O2+1cCxtlXiCTjV06O1VGk5CzBb8UVYOQNhGZYGUOxW1X8jLh/zCr23iMC
         LmgS+34/zVSUykwrDnjtw/kBM6tBxPQazGAfy3BEJ2oJjNScU7UayT4/QdaRPdYh6g25
         tGyVHzLYw4K4juheV8U6rIuNAgtv43HLHaAkLblNm5kf6nJMf4xdDZEODpr0OEsdpkUn
         +jHvLjC1CwsckbLtMvR38nKE71qj32SiPEHVIeZX8aCNOryRL0P/O0wUz1Vgvxo6iVQ7
         gvaw==
X-Gm-Message-State: ABy/qLY3WDx81etOEpnhwcxR0/9lNZqoI6p3I0cmjFJq4bhWt9UvntL3
	0GllbDcZEw1QRwpeixRI0Vo=
X-Google-Smtp-Source: APBJJlFeXvQAtut+wH1PDxlZ70Hu6bIJhTKvKKQJ2NZGKrtxmOr5hCcJxiWy1VNsiXtM25QcEreB9g==
X-Received: by 2002:a50:fb97:0:b0:51e:3d13:4a12 with SMTP id e23-20020a50fb97000000b0051e3d134a12mr11098846edq.34.1689619022695;
        Mon, 17 Jul 2023 11:37:02 -0700 (PDT)
Received: from [192.168.0.110] ([77.124.20.250])
        by smtp.gmail.com with ESMTPSA id o4-20020a056402038400b0051dd1c10c13sm10361653edv.29.2023.07.17.11.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:37:02 -0700 (PDT)
Message-ID: <1051f5ae-82de-2e52-64f5-545fa2dedff9@gmail.com>
Date: Mon, 17 Jul 2023 21:36:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v3] net: bonding: Fix error checking for
 debugfs_create_dir()
Content-Language: en-US
To: Wang Ming <machel@vivo.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yufeng Mo <moyufeng@huawei.com>, Guangbin Huang <huangguangbin2@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, jay.vosburgh@canonical.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <20230717085313.17188-1-machel@vivo.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230717085313.17188-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 17/07/2023 11:53, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bond_create_debugfs() was forgotten.
> 
> Fixes: 52333512701b ("net: bonding: remove unnecessary braces")

It's not this commit to blame...
Issue was there in first place, starting in commit f073c7ca29a4 
("bonding: add the debugfs facility to the bonding driver").


> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>   drivers/net/bonding/bond_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
> index 594094526648..d4a82f276e87 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>   {
>   	bonding_debug_root = debugfs_create_dir("bonding", NULL);
>   
> -	if (!bonding_debug_root)
> +	if (IS_ERR(bonding_debug_root))
>   		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>   }
>   

