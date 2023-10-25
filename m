Return-Path: <netdev+bounces-44242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B617D7403
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B02B20F3B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D930FB8;
	Wed, 25 Oct 2023 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="eUc2/3FF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032110FB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 19:12:20 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD818D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:12:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso70211f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698261135; x=1698865935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJE1oxlQfYqBKYgdY9os4N8F8vLdx7K54CDVTJraf3w=;
        b=eUc2/3FF7yx0VmmvhHMsoEFoS6ulqUbTwRr270/lx+Xsq5jjQJlnaHoquaafSt0WOO
         CenzJGVXHX/sSX6D5u27SJeC2k6a9zS9IUup9ZpY0Lb29pOyqjNiXn2ZfV7GhNr99Zvt
         ZBk6timVsYHtuTmRdID4yWHJItubs/B1ViVlhM4h0lZL4SmUV5LnWR61Ujhw5/3jsf5j
         NZzCUY93bx3YOP6dX+nQOcbOhIyr3c2wq89KcvSLPc++ZRI1QfxeeVhxihH7v5yaE/U1
         3CU0ITLH72xwA+JRAlrTRKnvSZAxOZvCETVOm44uoMN9/EcL4tshP/lsAL5x47fY0fQU
         xFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698261135; x=1698865935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJE1oxlQfYqBKYgdY9os4N8F8vLdx7K54CDVTJraf3w=;
        b=xGg8uait/PFbu0DfUtValAq7uN37VFz18q0Xdha78yZBsXju/9qRWScixfJPrVf/t5
         Vp4OGuszyCRnyBDuFtfWSx8B+4migy5+DUL7SnY/DeY/YPGfRNoqEgL1Pes/72Uh6b8M
         GKJGac/T5K7oS5s0PwEYCp7FWk5Q3wIWodR22VR/rGxtSl+FpdFlIL62zPa3dOmua15t
         k/lbVlxFr63wIHNv95OSY/hCXHkxfKvTdtWD9vYe23nKOQvgvJS+ecH7hzr010rAN+5J
         t/9Gk2DMM25ckkKkTfpvhJuhUObZN/FlmQtmXRUHwvOmNY/vR77ftEO+6FPim6Oz64Jz
         Z+Iw==
X-Gm-Message-State: AOJu0YwDuGWNve2lUmN5VHpIpSiQFBqp9mKaA8Se8xpvYrMicmSde9Ec
	NpH04hQX8AXCvkoER0DMrkInIw==
X-Google-Smtp-Source: AGHT+IFmQB+pB5vXHCUGxPLndR4N+esrM3X5ULS8AWxa265+wqOl+oIbPQk/vjEZoQVGxg1VO5gHxQ==
X-Received: by 2002:a5d:4e06:0:b0:32d:a3a0:e927 with SMTP id p6-20020a5d4e06000000b0032da3a0e927mr10823356wrt.58.1698261135536;
        Wed, 25 Oct 2023 12:12:15 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b003258934a4bcsm12673992wrt.42.2023.10.25.12.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 12:12:14 -0700 (PDT)
Message-ID: <1d484f6a-669b-e222-391b-43e3b4904097@blackwall.org>
Date: Wed, 25 Oct 2023 22:12:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, dsahern@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 vinicius.gomes@intel.com, johannes@sipsolutions.net, idosch@nvidia.com,
 linux-wireless@vger.kernel.org
References: <20231025162204.132528-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/23 19:22, Jakub Kicinski wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: dsahern@kernel.org
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: vinicius.gomes@intel.com
> CC: johannes@sipsolutions.net
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: linux-wireless@vger.kernel.org
> ---
>   drivers/net/bonding/bond_netlink.c | 2 +-
>   drivers/net/vxlan/vxlan_mdb.c      | 2 +-
>   include/net/netlink.h              | 4 ++--
>   net/ipv6/ioam6_iptunnel.c          | 2 +-
>   net/sched/sch_fq.c                 | 2 +-
>   net/sched/sch_fq_pie.c             | 2 +-
>   net/sched/sch_qfq.c                | 2 +-
>   net/sched/sch_taprio.c             | 2 +-
>   net/wireless/nl80211.c             | 2 +-
>   tools/net/ynl/ynl-gen-c.py         | 2 +-
>   10 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



