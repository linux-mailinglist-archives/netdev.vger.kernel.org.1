Return-Path: <netdev+bounces-58501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C5816A90
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13081F218D0
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47F12B9B;
	Mon, 18 Dec 2023 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bfWPhOD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355712B90
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso47608f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894166; x=1703498966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkBeg4SFMd3zKgTAJBJhbgkME0fGFVwa3jyVxGZCBFc=;
        b=bfWPhOD7IVaegU3kUyXDNPqKzPbi0XvYvvSXQUFH2+rwxGO7cnn6S1I3VMjCnaNbu/
         nxqup4DUBIha1xbm+iHCWFXUfsV2bYy+XKXa3Hfj7jtfJ8ZhR3E4/B8eVGa0ptBUWM+m
         bG2qK5ZMDmbtcM8jxYeCwR19FeSqZj3lKzauFiAcApDowOZLSMJCO23RhaUTF/Kv3ZC5
         vM1jwtVbrDjkOWp3GkiPE1QJPz2qp74JHLtWngFYy8sEUj0V1Fai/D5mph7EnFGPOChn
         0A6iuIR55RD+ivfUWHLRzXF6qcCt3cIqBe9ZfeJrCAPF6v+7KvKJKJkSyBnnFDlYRY8n
         44TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894166; x=1703498966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkBeg4SFMd3zKgTAJBJhbgkME0fGFVwa3jyVxGZCBFc=;
        b=GXcLulBeTpFue+vYNOfHf3HAx6pNMqFkWbRBxa33IBhIOx2Plwq378SY1tuYD5N4e7
         1Zqfxv/W1NJazCqQKQwu7cAWK2xlOps4v/D1iyflcXOKOR8H40xP7f38BShiwvr0r+8L
         4ObfNm3VDi/0inI5CTR/mX42HXqmDnSYLiZPu9tmV0V9sfpjBFS19J8CE1mx2KhxbBx2
         xarLJ4Y57EH7yC+LyB2VMljA1+iqZhPBdVKXvKh89I+ZtCydDi/4RaAMV+RWYdCVmIhq
         Ipy7/pIV55yIruXYiMwIOWF4EzLMKwPnhRbdmGzXrCalNRY9Gf4Ft14qqleOW89ariME
         gdnw==
X-Gm-Message-State: AOJu0YyAKWVzz6H8TsirkORn2Fqbe3/aw4whAlh4vUV0QpgH+r/v5XH7
	pQciosPUMz6c0w7sZcdAcbExSA==
X-Google-Smtp-Source: AGHT+IG8RKtvGHhE2Dl+3x3GTo/6R/ZSuvZjlmQsWFozPBkaOqRCD3ltyiI3jR68Y+QLWYGwyd466w==
X-Received: by 2002:a05:600c:35d3:b0:40d:18e2:898 with SMTP id r19-20020a05600c35d300b0040d18e20898mr411248wmq.196.1702894165956;
        Mon, 18 Dec 2023 02:09:25 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:09:25 -0800 (PST)
Message-ID: <00305092-d095-4c8c-8971-a6eda9e7ee6d@blackwall.org>
Date: Mon, 18 Dec 2023 12:09:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] rtnetlink: bridge: Invoke MDB bulk deletion
 when needed
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Invoke the new MDB bulk deletion device operation when the 'NLM_F_BULK'
> flag is set in the netlink message header.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 30f030a672f2..349255151ad0 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6494,6 +6494,14 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>   		return -EINVAL;
>   	}
>   
> +	if (del_bulk) {
> +		if (!dev->netdev_ops->ndo_mdb_del_bulk) {
> +			NL_SET_ERR_MSG(extack, "Device does not support MDB bulk deletion");
> +			return -EOPNOTSUPP;
> +		}
> +		return dev->netdev_ops->ndo_mdb_del_bulk(dev, tb, extack);
> +	}
> +
>   	if (!dev->netdev_ops->ndo_mdb_del) {
>   		NL_SET_ERR_MSG(extack, "Device does not support MDB operations");
>   		return -EOPNOTSUPP;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


