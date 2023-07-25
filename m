Return-Path: <netdev+bounces-20694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F1760AB4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276A728183B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA4748F;
	Tue, 25 Jul 2023 06:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD438F4D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:44:47 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBAF116
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:44:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso51651785e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690267484; x=1690872284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2sJvaOqA1wufNCy1EViFx1U0iK92J2+1LLg1ANsOjU=;
        b=jXjtNqZ3UIIqIBnb/hXfySuKUygXmtuKlU91te3B0oUQxlxtvZ1a6iNpJyOya27J0m
         AzR6cnDRNzBJ1wIYs4pzSJ5GQpcY6jG1ibjw6nJwudhX9OP+yjkiy9RlWUNk44Rdyoek
         +IvmDCVCWxZc81zd+BXq4Iwj09SyLqJVOJpU/BqQwld/oUK+evJcFUnBTLb+nZiK6L9k
         E9Ia7NPS4PogB0y3BkWbDOAoqI4Zj6ykwU6+vH6jUUX5E4B64lJ4WI0G079hs9UaD/TH
         +dI4fWgDibfSXIGfI47ROA4HmcHyUvIFN35oHvjuAEOwtJaFUDT8Jx20v0Y1Fe3HvOsU
         cXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690267484; x=1690872284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2sJvaOqA1wufNCy1EViFx1U0iK92J2+1LLg1ANsOjU=;
        b=QIAnJdCNrl5KabVNEIvKtrCpLQlHTYmAzlPbIWQdHKLo1z9Jf9dDWAEoQlIFXpYRnx
         zsUXFTF8GLCGUq21a4lpBhc5E8XmNG6JP3mNoP2o2o11cSunTmaDDaNa2geC780cAvBn
         u75YwGZEMpzEaZoJX/WI32+bHFy2Dp0CWwBgYRcqRAYKzeYKTKZ+cGOTk47Gzx0PPwGu
         Ym/lhXb3b4UJwtsnT5dVdgkkmNdD/Tc0Mn4KUBCvtc4Ed6NsLQjktHTqV7Dw4+mQziHo
         cc54Q8hl0ZUgR1tgeBEALUU85oqMEwb3lzF+DyAP0BNcbMfs/xgZM1USaL4W0+a/W38F
         c+KA==
X-Gm-Message-State: ABy/qLbsXVXSeIT52s9w4UcJYdb2uzIhONe0sdA/K/tE3uKn1PU2Gn/Y
	RwBERSFGUmG+PUOZIkF9tno=
X-Google-Smtp-Source: APBJJlGqK518VNFpbqMZGdZzPgglgojV6+mScuTCJyonA3PR006j4LUXxfGQAECvjl4dD3BEukB1wA==
X-Received: by 2002:a1c:7403:0:b0:3f6:2ae:230e with SMTP id p3-20020a1c7403000000b003f602ae230emr9398994wmc.3.1690267484217;
        Mon, 24 Jul 2023 23:44:44 -0700 (PDT)
Received: from tycho (p200300c1c70b7b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c70b:7b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc010000000b003fbe36a4ce6sm15178122wmb.10.2023.07.24.23.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 23:44:43 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 25 Jul 2023 08:44:42 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Simon Horman <simon.horman@corigine.com>, 
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: flower: fix stack-out-of-bounds in
 fl_set_key_cfm()
Message-ID: <sma534z36vpf4ijyalaemiefyze3miqdusp73ewfpegtuuwv6n@vlz6erzympst>
References: <20230724163254.106178-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724163254.106178-1-edumazet@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 04:32:54PM +0000, Eric Dumazet wrote:
> Typical misuse of
> 
> 	nla_parse_nested(array, XXX_MAX, ...);
> 
> array must be declared as
> 
> 	struct nlattr *array[XXX_MAX + 1];
> 
> Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/sched/cls_flower.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 8da9d039d964ea417700a2f59ad95a9ce52f5eab..3c7a272bf7c7cf7d4ae21b5370cbc428086d6979 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1709,7 +1709,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
>  			  struct fl_flow_key *mask,
>  			  struct netlink_ext_ack *extack)
>  {
> -	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
> +	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];

I think we need to redefine TCA_FLOWER_KEY_CFM_OPT_MAX like this as well:

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 7865f5a9885b..4f3932bb712d 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -710,9 +710,11 @@ enum {
        TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
        TCA_FLOWER_KEY_CFM_MD_LEVEL,
        TCA_FLOWER_KEY_CFM_OPCODE,
-       TCA_FLOWER_KEY_CFM_OPT_MAX,
+       __TCA_FLOWER_KEY_CFM_OPT_MAX,
 };
 
+#define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)

Thanks,
Zahari

>  	int err;
>  
>  	if (!tb[TCA_FLOWER_KEY_CFM])
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
> 

