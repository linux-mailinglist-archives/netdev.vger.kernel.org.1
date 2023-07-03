Return-Path: <netdev+bounces-15141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E84745E64
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD281C209CC
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18CF9F7;
	Mon,  3 Jul 2023 14:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595CFBE0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:21:28 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2BE54
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:21:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b7474b0501so3983633a34.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688394087; x=1690986087;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPdU1tYnCa/88ruX21nd923QYasXLrdZ2RWrrwTM0d8=;
        b=Ong+hTYabUD9aYfWl4dYmVAicDelKWRumAWpyahK/9yQQ3vQCS4WcqT8DXpf4OgO0D
         3oc4y99VzRtKNPKLUNd2qKK6EFSaVLXH69MC/+j5NhjeDNDX46ulzyoHN8zbG/BjRdVJ
         vvz4MlYepwIepICyF75zQoH/B4L9oauXQi+MZVMOiY+vRU6x79+SHvzKbPm+e/oug4H6
         ofzapRPqWk0gBRf6rNh8+L5BSbRVZUN2ou05UXvjsMM5IqT3dz51EdnCzfkonkCjSqAv
         eeCZU37x0xFKReOVuoEhy+VtcdQm1zOdB1YA9yZvTwTqprIXDaMEbArojS5T6s4BYvNu
         R9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688394087; x=1690986087;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPdU1tYnCa/88ruX21nd923QYasXLrdZ2RWrrwTM0d8=;
        b=jxRFlQDWnRE/ukwjvi9Q0jAVYQ2Yja1WxYoAhPopQBJ1s4cco5z+/iynHlDa5JZ/UR
         3wEsJxKRjLCblWyKsioBJjW4eHNXxvM5FlZ8htsRyGz+h4aLaNE2fFCQDXLANFPFH4AR
         heWWZS3o+poznKgxp7qwhmd87O/vjKK+vhOgvi4w5WhgYJyCEgbgIFNKtZ2x0tbbzxPw
         8VECbkfztagYJBQf03pZhp71idSs4Q9KXElYhPuMlEs0dlfTWRTSCDw8mwWczmTO1MSr
         h3Xx5EbRXngF9F9weOMFBveHQ4f/QdMLR1UuPUXpSE4PLAFcoKH2VFKAmiEy9h+aZ/fH
         mc3A==
X-Gm-Message-State: AC+VfDyzB0ML3v1vmBOK9hdBbBknPPocQfRbOLXAomXJI174zEz+po3y
	WCK/MqvAaittzpk6KL+rw+afJA==
X-Google-Smtp-Source: ACHHUZ5SP/cvL4B/gxBGSuLsHXQDy8izRYRXI9m7OmZ0wAu5fFZYX7aLmVaOdv3JEfwPgQJzub0pLg==
X-Received: by 2002:a05:6830:1054:b0:6a6:3e1b:6d97 with SMTP id b20-20020a056830105400b006a63e1b6d97mr9462773otp.6.1688394086789;
        Mon, 03 Jul 2023 07:21:26 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:7e4b:4854:9cb2:8ddc? ([2804:14d:5c5e:44fb:7e4b:4854:9cb2:8ddc])
        by smtp.gmail.com with ESMTPSA id c2-20020a9d6842000000b006b7494ba4fdsm7719769oto.6.2023.07.03.07.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:21:26 -0700 (PDT)
Message-ID: <4aaea1fa-94de-3342-c01e-f9b108c474f6@mojatatu.com>
Date: Mon, 3 Jul 2023 11:21:22 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] net/sched: act_pedit: Add size check for
 TCA_PEDIT_PARMS_EX
Content-Language: en-US
To: Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20230703110842.590282-1-linma@zju.edu.cn>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230703110842.590282-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/07/2023 08:08, Lin Ma wrote:
> The attribute TCA_PEDIT_PARMS_EX is not be included in pedit_policy and
> one malicious user could fake a TCA_PEDIT_PARMS_EX whose length is
> smaller than the intended sizeof(struct tc_pedit). Hence, the
> dereference in tcf_pedit_init() could access dirty heap data.
> 
> static int tcf_pedit_init(...)
> {
>    // ...
>    pattr = tb[TCA_PEDIT_PARMS]; // TCA_PEDIT_PARMS is included
>    if (!pattr)
>      pattr = tb[TCA_PEDIT_PARMS_EX]; // but this is not
> 
>    // ...
>    parm = nla_data(pattr);
> 
>    index = parm->index; // parm is able to be smaller than 4 bytes
>                         // and this dereference gets dirty skb_buff
>                         // data created in netlink_sendmsg
> }
> 
> This commit adds TCA_PEDIT_PARMS_EX length in pedit_policy which avoid
> the above case, just like the TCA_PEDIT_PARMS.
> 
> Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to the conventional network headers")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

LGTM,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/act_pedit.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index b562fc2bb5b1..1ef8fcfa9997 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -29,6 +29,7 @@ static struct tc_action_ops act_pedit_ops;
>   
>   static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
>   	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
> +	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
>   	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
>   };
>   


