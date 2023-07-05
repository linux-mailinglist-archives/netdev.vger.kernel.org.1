Return-Path: <netdev+bounces-15577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39987489D4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0CF1C20B8B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C43125AE;
	Wed,  5 Jul 2023 17:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5A46AB
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:06:24 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA01713
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 10:06:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39e86b3da52so616692b6e.0
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688576782; x=1691168782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbtfJcZEFusNLF7mMa6rCHnr1a1vlN3i4OZ4C1dAjcc=;
        b=u0lw717t3r1tyN1+xqo+Ux/UMIEx6mbnuhfVqcIGzC/HkChlt1SdtHuKM1skQJDEAV
         FDzmzeKOzYfDsPqpPafd5ZqAgkCkWRSh7lf88prYO+1hltSFm5bh0kfyOuL3wz725kn4
         TRCXjbdacEL5Vo86p2+wBr1NUfXO1wr9S5fbGNLyFfIdUDdkD5con7+zME+IPIe35wdQ
         4NFPm6XoTIpjpDBhFUnkUgj1s4carYA14lyTIYa5pBzevytgHbFMe3NuIsvqUoOvpJTY
         59gCLobWJivtGyxtyEF2nqgkRtVRyH43cPyEZt+K8rzUYF+NLBalIRt7PDIiH2cr08Xq
         61tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576782; x=1691168782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbtfJcZEFusNLF7mMa6rCHnr1a1vlN3i4OZ4C1dAjcc=;
        b=hlekRX/es13QbLZ1Mx4HY6Tg9uQBufslcD5xmwrqCRPysbvaN1QsLZUoKzHngt5J0E
         ppTEzErTaujwHL32zWV9zUUx20gIuDP1iG82AoLfAk47PXEGEhePx2359P3eLPJ2aZTM
         9m7AorsbRgmohcxsPxmy60/V+ZqSQOYgbNpV41wz9992bhiAOACT9VaObSE5FA6aglp3
         B0zUAn+bCNQoZTO7sEMQ8B5LzVUwd9SeIBTp1c96W6lMUBgXXLrjPNOMUkrjAjVbR4fs
         uyrW7Gj6/0F5heYnxmFcc/+jzZWaOXD48wbYsIdL6bT7bYfjHLaYcWc0U9+p9CRUZ9ak
         RHaQ==
X-Gm-Message-State: ABy/qLY6/D4CDHWHKGGAq913fBabZdY1MNdihR8V5AHbwgmiZCcPILVk
	Q92m9QzxMdj8TL5O/R5IN4IltQ==
X-Google-Smtp-Source: APBJJlFZHq8ge87DmHDAwF0jvyl6JH+m6WYSi25c8+TJre/ue+dh2ghZqEuGwnERcCLbDXuphWUNFA==
X-Received: by 2002:a05:6808:f0e:b0:39e:b7d8:e3f5 with SMTP id m14-20020a0568080f0e00b0039eb7d8e3f5mr1572594oiw.5.1688576782558;
        Wed, 05 Jul 2023 10:06:22 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:6862:5918:e469:cb66? ([2804:14d:5c5e:44fb:6862:5918:e469:cb66])
        by smtp.gmail.com with ESMTPSA id k4-20020a0568080e8400b003a38eba0bcdsm5020582oil.0.2023.07.05.10.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:06:22 -0700 (PDT)
Message-ID: <4abd2ef2-582d-d8a1-dd2a-8274ecc4e54a@mojatatu.com>
Date: Wed, 5 Jul 2023 14:06:16 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] net/sched: cls_fw: Fix improper refcount update leads
 to use-after-free
Content-Language: en-US
To: jhs@mojatatu.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 ramdhan@starlabs.sg
References: <20230705161530.52003-1-ramdhan@starlabs.sg>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230705161530.52003-1-ramdhan@starlabs.sg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/07/2023 13:15, jhs@mojatatu.com wrote:
> From: M A Ramdhan <ramdhan@starlabs.sg>
> 
> In the event of a failure in tcf_change_indev(), fw_set_parms() will
> immediately return an error after incrementing or decrementing
> reference counter in tcf_bind_filter().  If attacker can control
> reference counter to zero and make reference freed, leading to
> use after free.
> 
> In order to prevent this, move the point of possible failure above the
> point where the TC_FW_CLASSID is handled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

LGTM,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/cls_fw.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index ae9439a6c56c..8641f8059317 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -212,11 +212,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
>   	if (err < 0)
>   		return err;
>   
> -	if (tb[TCA_FW_CLASSID]) {
> -		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
> -		tcf_bind_filter(tp, &f->res, base);
> -	}
> -
>   	if (tb[TCA_FW_INDEV]) {
>   		int ret;
>   		ret = tcf_change_indev(net, tb[TCA_FW_INDEV], extack);
> @@ -233,6 +228,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
>   	} else if (head->mask != 0xFFFFFFFF)
>   		return err;
>   
> +	if (tb[TCA_FW_CLASSID]) {
> +		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
> +		tcf_bind_filter(tp, &f->res, base);
> +	}
> +
>   	return 0;
>   }
>   


