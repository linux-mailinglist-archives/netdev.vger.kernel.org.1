Return-Path: <netdev+bounces-20266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4A75ED30
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB1D1C20997
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CF1C10;
	Mon, 24 Jul 2023 08:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015D1C03
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:16:06 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1164E76;
	Mon, 24 Jul 2023 01:16:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314172bac25so2808526f8f.3;
        Mon, 24 Jul 2023 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690186563; x=1690791363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4WIMda6DjAYPfCgVET+ub2gNWJR3rd4zT6T/0bE7Ws=;
        b=na5qkmiU7urWsohFq3EM8SSxIvc4g8lxNf6cZxcLpXhwlW94JbahC/p28BNrC/xrBK
         obod23bOB+l7//cn9pxt0a6nrih6396FMdzZPvmwMnNhqqhbjy9YyWvKypS0idjlr4XY
         D3NivbC7K/+waagtA8ZTSuVtqGmaWkrSwY8upeRN7Tf9lfAvgah5LAf5PHT2Y84PygUt
         /GeQJyvIHCZuIJIJUTJcLzb3O3RHhEoDuwIZjhl47FD8gJWzfDEFa69MWK6Cpm1+DPWl
         EeBm7HKUa1yB71Ai01fP9lwekLKvcuxe6yGiHSrbg7meABBB0GurVFQJRsAOquySk0KM
         iSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186563; x=1690791363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4WIMda6DjAYPfCgVET+ub2gNWJR3rd4zT6T/0bE7Ws=;
        b=idQOpG0PfFyWYhzTPj4BegpJtUK5JDdAI6REA2fBvLa93RBsCtWDHZblJXaGQkJk8O
         CDw0Z6F7lZ//I0I9wLbWs8R52zDp2jVUbh/pdr1GGL3BIBGA2XfdWm8bSc3cABTzpT65
         Ozp8ZWPSJwcXSGnkSjeR53YGkIeXaftXr8ORTZTtV29nnMlZv9M/pVQHQW5Q248Ei9A5
         QNTr7L1NzUKCjjpgJzQ8UHz5uiW3LVqWpE7dl+v0Jtr7hpH9ZERdksuyJWHpHd24zW/O
         u328d0k79rwwCCZ7Q2lNmcLstsTj+p7Li5vBvhOOC05aE/lS7CrBYfpfLQvWVxAB8pqd
         KPjg==
X-Gm-Message-State: ABy/qLar/Tyev2RJ47v4O/8TCGRLEgX62CKECsujrq9V/ewVgCKrzGSE
	7SzUqHtoPOlzXjckUk/qoNc=
X-Google-Smtp-Source: APBJJlEpRe7gSVcv+UIVj04e8kyYqEXEFE7HbacBj/OE1RSMS72CXBhwCjMMEHJjl1Sk+4vT8gWOrg==
X-Received: by 2002:a5d:6405:0:b0:313:e57b:e96d with SMTP id z5-20020a5d6405000000b00313e57be96dmr6307936wru.36.1690186563288;
        Mon, 24 Jul 2023 01:16:03 -0700 (PDT)
Received: from [10.80.22.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t2-20020adfeb82000000b0031759e6b43fsm4164480wrn.39.2023.07.24.01.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:16:02 -0700 (PDT)
Message-ID: <06acb2c3-4dbc-e86c-6db1-40d2cdc8d188@gmail.com>
Date: Mon, 24 Jul 2023 11:15:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v4] bonding: Fix error checking for
 debugfs_create_dir()
Content-Language: en-US
To: =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Taku Izumi <izumi.taku@jp.fujitsu.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "opensource.kernel" <opensource.kernel@vivo.com>,
 "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>
References: <20230719020822.541-1-machel@vivo.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230719020822.541-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 19/07/2023 5:10, 王明-软件底层技术部 wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bond_create_debugfs() was forgotten.
> 
> Fixes: f073c7ca29a4 ("bonding: add the debugfs facility to the bonding driver")
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

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

