Return-Path: <netdev+bounces-63339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D782C58C
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB581C22674
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60461548E;
	Fri, 12 Jan 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="N8zDztlp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54415AC9
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da9c834646so5724013b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705084723; x=1705689523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTNdMrIh2e+f0AHVj8Xvr+K1avBkltglLDidS0sWJtM=;
        b=N8zDztlpEhNXxR79jBxcsZLJlNSbSVMB/J6ySIWk0ymotmPMynliP7CjI5KeL4Lct2
         7nKqLIGqayF7En6qdoiZcc8gZP0dnBGz2ziBN4nu4ColFG6q8tW9KHv/VOwuspAjmsDy
         bwk+fVMtu6MyE7UMrqycqeTlh6fmrgZOYL4qMflKIykq+Qc6uBgRHi/jVk8jiriCH3YL
         IxYOA7PYmAFUMX8AlonGeZ5sEr10D1yZvBUYyvKw5GbV9sVXwDlxyWAVNTRPACjKOCsm
         eSp/0ridwsjBc5hoTCGWQ36iAxnmB6smFsPSQV5g6ZdG5Iu+TVW4RLekZDWDMNru3ATH
         eBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084723; x=1705689523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTNdMrIh2e+f0AHVj8Xvr+K1avBkltglLDidS0sWJtM=;
        b=f0JM1eLclJspSh7oWiYKeoN8nq40EySGPlwswWQZ4rSjDKkDVp5UoS9U7jB7qWV2vC
         eu/FAQHlLFrJFlCvUIE91b7K55XLfFx5FHjI8fdMke2yQr8qXEuRtjn/yVEVI1hKKt0N
         alsvunQeIKd6XHOPmbWmNAgo4tC4Wo3o5fviGrAogNSzM6DQQGAU4iYHnYUEx6Qx3MUe
         pT3y4mfNdYPtOX5GXiElCrKO9vl40k7QqpnIJVXk2nkVepz/8dfjcLkl/Sa+wTwYPPO5
         YqZSHEwiQWteif9HBUQ8MKPwi2A58ihpc1h4bUPwIVQpwhakwU8iy1LfbaDpj6zLSG+u
         nDkg==
X-Gm-Message-State: AOJu0Yw1WNktZFPOZ4axuyK2pXx6kH4N2k+qmSKCy4k3iPt9qT4tWxte
	rlIURtN3Y8VXJcIdYcsflyHomeG6folf
X-Google-Smtp-Source: AGHT+IGYxf5ffPVISlwaQss8+r8rt9q5Vh4pegBqPGznQXzkKBuZOEftEHIe9ydgcPiTVPIbMp5Rsw==
X-Received: by 2002:a05:6a00:1495:b0:6db:337f:2595 with SMTP id v21-20020a056a00149500b006db337f2595mr1711226pfu.0.1705084723008;
        Fri, 12 Jan 2024 10:38:43 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id t127-20020a628185000000b006d9e76be7cesm3587322pfd.73.2024.01.12.10.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 10:38:42 -0800 (PST)
Message-ID: <d570871f-1b59-4d75-a473-b3b0a21fe6c2@mojatatu.com>
Date: Fri, 12 Jan 2024 15:38:34 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] net/sched: Add helper macros with module names
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Petr Pavlu <ppavlu@suse.cz>,
 Michal Kubecek <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
References: <20240112180646.13232-1-mkoutny@suse.com>
 <20240112180646.13232-2-mkoutny@suse.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20240112180646.13232-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/01/2024 15:06, Michal Koutný wrote:
> The macros are preparation for adding module aliases en mass in a
> separate commit.
> Although it would be tempting to create aliases like cls-foo for name
> cls_foo, this could not be used because modprobe utilities treat '-' and
> '_' interchangeably.
> In the end, the naming follows pattern of proto modules in linux/net.h.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   include/net/act_api.h   | 1 +
>   include/net/pkt_cls.h   | 1 +
>   include/net/pkt_sched.h | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 4ae0580b63ca..ade63a9157f2 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -200,6 +200,7 @@ int tcf_idr_release(struct tc_action *a, bool bind);
>   int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
>   int tcf_unregister_action(struct tc_action_ops *a,
>   			  struct pernet_operations *ops);
> +#define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS("net-act-" __stringify(kind))
>   int tcf_action_destroy(struct tc_action *actions[], int bind);
>   int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
>   		    int nr_actions, struct tcf_result *res);
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..906ccfea81f2 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -24,6 +24,7 @@ struct tcf_walker {
>   
>   int register_tcf_proto_ops(struct tcf_proto_ops *ops);
>   void unregister_tcf_proto_ops(struct tcf_proto_ops *ops); > +#define MODULE_ALIAS_NET_CLS(kind)	MODULE_ALIAS("net-cls-" 
__stringify(kind))

I believe something like (untested):

#define TC_CLS_ALIAS_PREFIX "tc-cls-"
#define MODULE_ALIAS_TC_CLS(kind) MODULE_ALIAS(TC_CLS_ALIAS_PREFIX 
__stringify(kind))

And then reuse the macro:

request_module(TC_CLS_ALIAS_PREFIX "%s", cls_name);

Would look better. In any case, net-next is currently closed. You will 
need to repost once it reopens.

It seems you are also missing a rebase. We recently removed act_ipt :).

>   
>   struct tcf_block_ext_info {
>   	enum flow_block_binder_type binder_type;
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 9fa1d0794dfa..88ab6d0ab08b 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -100,6 +100,7 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
>   
>   int register_qdisc(struct Qdisc_ops *qops);
>   void unregister_qdisc(struct Qdisc_ops *qops);
> +#define MODULE_ALIAS_NET_SCH(id)	MODULE_ALIAS("net-sch-" __stringify(id))
>   void qdisc_get_default(char *id, size_t len);
>   int qdisc_set_default(const char *id);
>   


