Return-Path: <netdev+bounces-58510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE0816AF0
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EFE1F213D7
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945E13AEE;
	Mon, 18 Dec 2023 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pLLVKIdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16214AAB
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d12ade25dso13577485e9.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895101; x=1703499901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h93OzPRkUcmlf3am5IalhLc0+8pp7MWahdAUi9UR6fQ=;
        b=pLLVKIdYeSlcH4lT7H/reIbKaSwuTBabUYvCSnbQwBYHbVBuoPK8s/0BEGMJPFQZs7
         18Ke9/vF5i0K+M0VSwWa9kIkqEX0HEnpui+MPCSVV3ZWwnevIFduzmBnFG3IoyX0blto
         Odh7+sWw2wm4DisONolko98WuG+8LR/8QrRnpNn2fAGvr8hEgHpHdJlvxDD0S7wfxbUe
         3vTuFWIdV6xP7/ZXI8CX4mUNr6b3r3doAjPzpwRNJfBCRvejUoYXJ/MOSQuCXuhtNNmY
         UxWCnxfRGO9TSBLrBjqt6OAgP15zf+w+hmiluXtpPgvUZrjaK2kocgOTK88nrQ881Xld
         b9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895101; x=1703499901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h93OzPRkUcmlf3am5IalhLc0+8pp7MWahdAUi9UR6fQ=;
        b=GlzLleAIwd3JGCtTSLtEGbczPdi1DdnYHgjXMq9Arxfko1v1bwPx90lZoublJc+vR3
         1btsJFiDSUC8yMQi198vil3VoJD3eBbsIOhhX3M8LqRk9Uq1wNDx33nUhS63AOvnPPUo
         Kc063XcYMFfLg+7NhXYwQDboUBOuod7h87p35rOWEX//PYwEq/hpMAvKmfCV3My55068
         jV42xIbnJRwJkJfyPoXvVKPHiWw+K9qJe3Oi+XXtlyPPbrYbqO5m6JXhfZIo1U3ULdhg
         8bP0/aZ4RrHcsJLRPfzd7UqRtD3mBUnEGm7CD0Tr50pT1QgMoP1HhJtDChqFL1SJTyVd
         Xs5Q==
X-Gm-Message-State: AOJu0Yy+GFVumlAEL/QpRsps/80ApimMjPNzfN/a3oVS93/6foKrzfD/
	T+VhfJtWvaUi6U+iJ2PVYM8hXA==
X-Google-Smtp-Source: AGHT+IHrOrd2g+g3JS50mJL+q4OWq0mkCy7Z59nshTserUX0d4Hdx1AZgw/tu5LuWwuTG8QutiYqjQ==
X-Received: by 2002:a7b:c857:0:b0:40b:5e21:ec22 with SMTP id c23-20020a7bc857000000b0040b5e21ec22mr7930474wml.84.1702895101519;
        Mon, 18 Dec 2023 02:25:01 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:00 -0800 (PST)
Message-ID: <90965963-4d0c-439a-b0de-77ed3ae1ea11@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] rtnetlink: bridge: Enable MDB bulk deletion
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Now that both the common code as well as individual drivers support MDB
> bulk deletion, allow user space to make such requests.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 349255151ad0..33f1e8d8e842 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6747,5 +6747,6 @@ void __init rtnetlink_init(void)
>   
>   	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
>   	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
> -	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
> +	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL,
> +		      RTNL_FLAG_BULK_DEL_SUPPORTED);
>   }

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


