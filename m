Return-Path: <netdev+bounces-24747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEDF771865
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 04:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961EC281160
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF238D;
	Mon,  7 Aug 2023 02:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E451642
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 02:39:01 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CC81711
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:38:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbc06f830aso26594445ad.0
        for <netdev@vger.kernel.org>; Sun, 06 Aug 2023 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691375939; x=1691980739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMd7KHyy4DawWsG7uTCYu0SOgQxnGwDPAHNwav8e56E=;
        b=MV1dhj+erLhZEP0HBiyKNoETrVVQYIhILXdMzqfbyp88HW50OIG7X/gbp2aWMJRzQ3
         JSpNtixSvJhYcrZ1Nd42TB7zx9ZVRP6Et3Mvmwv176xPwouJM77CBonrt70PQPSkWgsw
         k0P4w6IqvAnri9S480XZu6bU1JaiZOjzQ+WlYeYsESfJLrwPa2pD3jyCxYZ88KfYoJtQ
         /jnhpuKfN3NmiCwpSC9QC+W9kydfDkLxvwh8QzmAa81VcuiQhf7LkbEjU1j5CY9fEhn9
         Ey08t8ftQkFqCr1hIvh6iPIcsUnevzKmQaOpgSG6Rs/Yn2+uYOLLpbabrI4ZDz4QRh7K
         6lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691375939; x=1691980739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMd7KHyy4DawWsG7uTCYu0SOgQxnGwDPAHNwav8e56E=;
        b=Hwc8TLELiM6Lx5rxmdGywJ2nZEhaaEQ1h3FdzizZgF0a9AsIJCLv6VRvlCsR48lkZ/
         r9b9CvFbZskFBvpdvKvA/XBX2TGw7IGsSnGDx7JW/w5SmMs4aJBp02wSBr+4Fto94KLp
         ahL+qQkzpTVJk8sv4ZvshNomBsw4+rnP/YnFZE5blsJOkSpIUf9ze4KX61iBLBsgBeL9
         ROQwujrbURDmzGK+IpUgB7eKp4fgKMtnhJ+CaEG9zM+Eiw0srKvOyGw+eAfFHZArNERq
         VaQZoQSVFdL131gDnzzX5NJw0MN1q+CDbJSRCFbVef5L3Xf1EcAueeA5BjDAfcDPGEaQ
         w55g==
X-Gm-Message-State: AOJu0Yw3jmlFxvc+YVY45Gy/uqaniuaOB87L1xpPY3ooulK3pBbymYzj
	/dYiPSFa7/U4U9Qz3WoL28c=
X-Google-Smtp-Source: AGHT+IH1zYlwxrsuvBXHwK8q0ce8U22YjL8plEfzFjAYYT+j1ISOaPsoJSMA3EL93syuvGWzg/PY/w==
X-Received: by 2002:a17:902:d918:b0:1b6:b703:36f8 with SMTP id c24-20020a170902d91800b001b6b70336f8mr6206171plz.25.1691375938531;
        Sun, 06 Aug 2023 19:38:58 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027d8200b001bc39aa63ebsm5525656plm.121.2023.08.06.19.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:38:57 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:38:51 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] team: add __exit modifier to team_nl_fini()
Message-ID: <ZNBZO1Bu+Kb1tFyX@Laptop-X1>
References: <20230804113557.1699005-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804113557.1699005-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 07:35:57PM +0800, Zhengchao Shao wrote:
> team_nl_fini is only called when the module exits, so add the __exit
> modifier to it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/team/team.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index bc50fc3f6913..e4fe70a71b40 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2892,7 +2892,7 @@ static int __init team_nl_init(void)
>  	return genl_register_family(&team_nl_family);
>  }
>  
> -static void team_nl_fini(void)
> +static void __exit team_nl_fini(void)
>  {
>  	genl_unregister_family(&team_nl_family);
>  }
> -- 
> 2.34.1

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

