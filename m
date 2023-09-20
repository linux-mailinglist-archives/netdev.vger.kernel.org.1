Return-Path: <netdev+bounces-35204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47D7A7987
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E29281657
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABA15ACF;
	Wed, 20 Sep 2023 10:44:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D6156CF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:44:22 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569BC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:44:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adca291f99so670984466b.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206658; x=1695811458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O7mWyhJga1IYEYoLQcrmnzYFbmyVRQyHT7Q+TKsjdE=;
        b=E2hk2cM20Acvnfd3/3r7bxco2Xyc0iWlKaxvEDn66gMvg4j+yLaCjLxSS/1XLzeztT
         0GcjIrAB0g+8dMRdvSv7aWe5QgdE6XIrv2MCva65kYwn7SKMr2RiOOM325asIkrK3rNW
         mHnSubkPq1b1fmG0LeLgvEeUvm4V26zsB5rCSkGRAY8nId+FCUl13RTZasWpJkx3AfWR
         v3+IQz9WtWFjdzvBYZ5k0Epw1IqS3o13qrHRlXsvSKBJ94uhop8fRmAeKiW38UrvmI+9
         leITM0vDHseACWXK2MYiHb5qOYCOFS9m/0hrG+umiugsv3ZtC1xmAtm7JaGW85q2k907
         14og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206658; x=1695811458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O7mWyhJga1IYEYoLQcrmnzYFbmyVRQyHT7Q+TKsjdE=;
        b=IVyfv0anOK0j59bZPMQNW9q21rOknA3kE1gA4rgplcoiOV5squ25ikGxAig5sEBGSY
         h2JM7q3qJ9u3Ex4Gpb7tO2KhjAhqsGpBcyke+fC4C25/BLM9LEjtvMLrHNLL7Tj0ZunO
         JTEbRGJHfEdwBoGQ5+1MdzP8BqJIjeBM0RanxBPryu4U9oVr3yj/+ctE2oAp8vULdbSu
         AVsu9LrsAxgvijORfxAiSQ6W5Qr60etFm+GIkGudPpgEW34YBfM/S40JjwdU2DTjVtF0
         qujVI+ZZhFe0GpIgzRSMBn1KL8SGuACLiUsm5YsFkVMfwN6vkh9kd6ivLTaU6hRtjUam
         EPfQ==
X-Gm-Message-State: AOJu0YzdCXXarhiBt1GqwSlwJ80+elQdGiTxyV6kPtX4ffsxIHUUji9Z
	vWzchKLiIIeInaNBU5hZWwCQow==
X-Google-Smtp-Source: AGHT+IGO3lncIOMxzIVaRUoIoQXNjIcQ22mCx46sIDTt+vAiLFg+skIRbs2SUmaSDzWxxnF2blZYPA==
X-Received: by 2002:a17:907:75c2:b0:9aa:25f5:8d95 with SMTP id jl2-20020a17090775c200b009aa25f58d95mr1711323ejc.59.1695206658146;
        Wed, 20 Sep 2023 03:44:18 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b00992afee724bsm8979517eja.76.2023.09.20.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:44:17 -0700 (PDT)
Message-ID: <a2a5ede9-c93e-915d-61be-c2c2fab18479@blackwall.org>
Date: Wed, 20 Sep 2023 13:44:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 1/6] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
Content-Language: en-US
To: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 11:12, Johannes Nixdorf wrote:
> In preparation of the following fdb limit for dynamically learned entries,
> allow fdb_create to detect that the entry was added by the user. This
> way it can skip applying the limit in this case.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_fdb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e69a872bfc1d..f517ea92132c 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   		if (!(flags & NLM_F_CREATE))
>   			return -ENOENT;
>   
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid,
> +				 BIT(BR_FDB_ADDED_BY_USER));
>   		if (!fdb)
>   			return -ENOMEM;
>   
> @@ -1069,6 +1070,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   			WRITE_ONCE(fdb->dst, source);
>   			modified = true;
>   		}
> +
> +		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>   	}
>   
>   	if (fdb_to_nud(br, fdb) != state) {
> @@ -1100,8 +1103,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   	if (fdb_handle_notify(fdb, notify))
>   		modified = true;
>   
> -	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> -
>   	fdb->used = jiffies;
>   	if (modified) {
>   		if (refresh)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


