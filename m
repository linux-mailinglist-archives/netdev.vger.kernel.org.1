Return-Path: <netdev+bounces-41818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35C7CBF7A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D81C209B7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4833F4DC;
	Tue, 17 Oct 2023 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nxYSMDGO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB983F4DF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:32:06 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E610E3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:32:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4065f29e933so57993725e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535124; x=1698139924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kgbT4HUwVO3dRrS+UXwvsR6kcnDepF12o+Z+tvmQWQ=;
        b=nxYSMDGOG9w29F2QiHmTHFiVkSFhxzTaskRmdCtMRrx6+16AQGUg/9P4k2ltm4iCGN
         lfeFGx5l7OqyrmMDClilNNQ/4//TWTAJFw1JqrMtSmDR1pNvChrAMmgGIuAtMfcYLlnY
         3LaTB1d8q5tSmdRdB8y3londsOy8T/nqxOfFOWOxkjJJmOjEmaAOwM6LrzRR5oRfwlRt
         y4IRUtrGZqjE34l35jhL0Koeo1T+Ugud3B90ZqcCegN2h5MvfrQv936h1TRxq0xLblcS
         nU5qJBd8s3/MF7oh7EfrqhmvetYJVnRVFgBJWlTCn6yEygHz2RLYeTAqsXWScAaqRZo6
         tF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535124; x=1698139924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kgbT4HUwVO3dRrS+UXwvsR6kcnDepF12o+Z+tvmQWQ=;
        b=Vk7auNXaXYWxCR1p9tyJl3RaJtQXmpR9f8Ka+BzvDMTXtsjRuNjNVn7zopfqNZUQVn
         DBwBh/itLnFgQc+oi43b/wXEe69lXX+2hlxyzP7ML1yxlKZsCWgbX939wooVGDGALw1K
         ohiNi8Sjj5VweR+vPdXcZCj5nGRVUfKT5nhYPBzU12FyKxiRMyoo5XcvJnE0Dp2ZdwAU
         FezGWB1acS08wiYQ34x1WoXhjLDW5J6MGnzQOtiexhmK/ogWWhCOFdCScLTTalOG5mFb
         JwrIClHMjsh/glkagaOensJP8E4VmgawxtW1ozzDqA5xN2xqsVJbf+eHDOrdonAu9Kbq
         uDlg==
X-Gm-Message-State: AOJu0YzOh42WkWkdSI/Vp8qbtaVvA1Gx4nkuikoZgIxdffyow7Plihw+
	x/BxrPiwsDd8Bm7QYKEqCgolag==
X-Google-Smtp-Source: AGHT+IEFCAFLbJTRsa9Q+OR2Uc4qdYh8ECcQZKGv69/zvXpR+D7cI+ScKKATcZsdrGR677hHJRW8VA==
X-Received: by 2002:a05:600c:3595:b0:3ff:ca80:eda3 with SMTP id p21-20020a05600c359500b003ffca80eda3mr1240848wmq.10.1697535123998;
        Tue, 17 Oct 2023 02:32:03 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b0040652e8ca13sm9406919wmq.43.2023.10.17.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:32:03 -0700 (PDT)
Message-ID: <f4657a17-1b81-f8e3-a781-714f1dc5174f@blackwall.org>
Date: Tue, 17 Oct 2023 12:32:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v5 4/5] net: bridge: Set strict_start_type for
 br_policy
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
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:27, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 0c3cf6e6dea2..5ad4abfcb7ba 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_FDB_N_LEARNED },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


