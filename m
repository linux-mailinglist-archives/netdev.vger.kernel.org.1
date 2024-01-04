Return-Path: <netdev+bounces-61658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C558247F3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238CB1F22A9C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4118286AF;
	Thu,  4 Jan 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji6t79NQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5F28DB8
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso8215647b3.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 10:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704391569; x=1704996369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOQ5bit6S5Its6ubZdwzs79UeDEklYdQSeWB61nF9ow=;
        b=ji6t79NQgxxwhPCAlBzvx56nni+TsS+0oBKmdv9IbwlYYiK2W3aZdQaYZ041sr/m/l
         JpcYM+m1ZBD+4C/eK4F6o6WUYWXX6tOyBiWYsbvNt7PNg3pYt7I7zoX7AT/sP4o+lDn5
         Gpgj1GQPhXf1ELg2pyNduVvgOdnWf4l6ueRhbFUh4UlFhtp4W6f4hZIafmsogJCYJLcV
         dBavpOJfJWjj7rcH3DRE9WLUX8M9eiTMDa3E0cRPOalI5RXjtZ4ssUCvAXdZFRfcSrt6
         b1YbH9EwLngoVU5JjlhGeksc7FHQIHBcCgcP3fidz9FBX628ca/TFph8kt2v90BIgaOa
         e42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391569; x=1704996369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOQ5bit6S5Its6ubZdwzs79UeDEklYdQSeWB61nF9ow=;
        b=MSYp2klpGF5vAMI7IdFL2oINLixWgmxJYjIXyVUhqyKoQ7B52X7yM+m0gHQ2kEHIm2
         dD+YreorHDa9Q4YKT9Duwy/mDNYHCeSQPFCjquaQ7iz8n9Do4cr9kNIsC6iHpNtYEZHs
         TOefND4FUXeKDh5LoVANFWSff1caui44r9DgzUDnIdZ2PKAf5Feng6kWBOSTsTEEJGTJ
         mx5HxtzOsVWKi1moQ3BsnZbPyIzt4d/EUyvgbc5qlgaowrzIdTjRgjHJWy++o5AECav4
         QJBfoTmhpJjhGl61C8HU1szX0D5lz8Td75fERKZF06fj9lbm/js5Bf3GX3ui22HY5owU
         CvbQ==
X-Gm-Message-State: AOJu0Yz+GzxUXb35/YmP8R8ZRH807XGDG32vbUC1Hlx1Ymokhtdt0EgY
	yjwsXfTtSievByRIjNNLpkI=
X-Google-Smtp-Source: AGHT+IGh9aD03VKUBV2VY6DjkMRPXcM+IUq507JG+ceAlutpppj+fjM/581H/EWiz1ECn6eL2V125A==
X-Received: by 2002:a81:7305:0:b0:5f4:dc1f:68b7 with SMTP id o5-20020a817305000000b005f4dc1f68b7mr971691ywc.66.1704391568927;
        Thu, 04 Jan 2024 10:06:08 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3f:8a99:d840:9c38? ([2600:1700:6cf8:1240:bc3f:8a99:d840:9c38])
        by smtp.gmail.com with ESMTPSA id n1-20020a81bd41000000b005ee3378d63csm8335278ywk.13.2024.01.04.10.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:06:08 -0800 (PST)
Message-ID: <eb4261f0-a5b7-4438-87f2-21207d86185d@gmail.com>
Date: Thu, 4 Jan 2024 10:06:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add appropriate
 qdiscs blocks to ports' xarray
Content-Language: en-US
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com,
 paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
 syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
 syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
References: <20231231172320.245375-1-victor@mojatatu.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231231172320.245375-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/31/23 09:23, Victor Nogueira wrote:
> We should only add qdiscs to the blocks ports' xarray in ingress that
> support ingress_block_set/get or in egress that support
> egress_block_set/get.
> 
> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> Tested-by: Ido Schimmel <idosch@nvidia.com>
> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
> ---
> v1 -> v2:
> 
> - Remove newline between fixes tag and Signed-off-by tag
> - Add Ido's Reported-by and Tested-by tags
> - Add syzbot's Reported-and-tested-by tags
> 
>   net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 299086bb6205..426be81276f1 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>   	struct tcf_block *block;
>   	int err;
>   
> -	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> -	if (block) {
> -		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
> -		if (err) {
> -			NL_SET_ERR_MSG(extack,
> -				       "ingress block dev insert failed");
> -			return err;
> +	if (sch->ops->ingress_block_get) {
> +		block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> +		if (block) {
> +			err = xa_insert(&block->ports, dev->ifindex, dev,
> +					GFP_KERNEL);
> +			if (err) {
> +				NL_SET_ERR_MSG(extack,
> +					       "ingress block dev insert failed");
> +				return err;
> +			}
>   		}
>   	}
>   
> -	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> -	if (block) {
> -		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
> -		if (err) {
> -			NL_SET_ERR_MSG(extack,
> -				       "Egress block dev insert failed");
> -			goto err_out;
> +	if (sch->ops->egress_block_get) {
> +		block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> +		if (block) {
> +			err = xa_insert(&block->ports, dev->ifindex, dev,
> +					GFP_KERNEL);
> +			if (err) {
> +				NL_SET_ERR_MSG(extack,
> +					       "Egress block dev insert failed");
> +				goto err_out;
> +			}
>   		}
>   	}
>   

Hi Vector,

Thank you for fixing this issue!
Could you also add a test case to avoid regression in future?
We have BPF test cases that fails for this issue. However,
not everyone run BPF selftest for netdev changes.
It would be better to have a test case for net as well.


