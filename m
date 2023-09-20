Return-Path: <netdev+bounces-35205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047B7A7997
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248021C20988
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF415AD6;
	Wed, 20 Sep 2023 10:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5C11733
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:46:07 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253FEE4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:46:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so919492266b.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206764; x=1695811564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1t+EHZZa+DoV/W1tEtqY5C53ytLGnx5U13L/26n+omc=;
        b=dihsdjvTnuQYMVrQxu4XvEe5UUGzkdkX1xMIDEIyoiJ5MUUGHoxrtS5OFHB+QGNLR8
         OZKCASHQ1EOpebv9O2YOnX9E2oPft2dRhZnuo7xLPfwndswi1cm/nAkWaIhzastVT5JR
         XMB2I+wSWXwwfCOkwQGmg6siCJMZGdapZ4GaXpBkpScOpKqf5hr4ZUhBWvQIJcOR24oP
         Wz/qlovKaRrEW4E8TcunpnmqowIv66sPyaYizBxKaDkI49Q3whEtdMBgyepmETQgkSoP
         IkZizwj3T32xwdDSH7uPq8pd3RLlmpsyC0o080c2F16HJ9gdpfszY13Ur2jI9GupJXTs
         KqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206764; x=1695811564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1t+EHZZa+DoV/W1tEtqY5C53ytLGnx5U13L/26n+omc=;
        b=CMK81NHnki+izZ7XM16voofj8a7rPmIQ+GeWU2S5yF9RKFM63V2HA+LDRJ6DesASP+
         WltfopXDqNDmVG68NO6pAwz7wztBTEdwJTntXeTqvHWLMu+qHlRjdrRVQI3v/cRkXlLN
         gEd8uMg9zmCqWqSagNJ5GvKeY5bwd9TmK2Iiy5Mh+HPMRy6dMIqxh14uhGNmo+oMnqh8
         zbA6aCbkOeqG/oVRogp61Vtt9fYXn5JwuLkWJ2pQR4jdKaVbUEmoqhyPxx7RjwOz3Owp
         f3WJcHqgfzjlBEAfyCnOpjlrF5fTNqXTin/uXw0FRF/Lgy4oE4lA7vRdizag1rneo2F1
         8ueA==
X-Gm-Message-State: AOJu0YxUAwL7RNnpf93fD/5H78iN7aFien9n4MFeeDHaFmjLEnFGUTxs
	sGakCfaH+Dh2QMo3h0DYH4s7Hg==
X-Google-Smtp-Source: AGHT+IEn9v5CmjikvnJiuR62Cfdh+Se8CP5j2IauqDOuNZIhLdU7Ki2o39Vo6T+KBU1ZVfagZsuX5g==
X-Received: by 2002:a17:907:77ca:b0:9a2:19ea:88f7 with SMTP id kz10-20020a17090777ca00b009a219ea88f7mr1801929ejc.64.1695206764525;
        Wed, 20 Sep 2023 03:46:04 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id qx9-20020a170906fcc900b0099d0a8ccb5fsm9183266ejb.152.2023.09.20.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:46:04 -0700 (PDT)
Message-ID: <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
Date: Wed, 20 Sep 2023 13:46:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
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
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 10f0d33d8ccf..505683ef9a26 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the 
patch and just use the new attribute name?
These are uapi, they won't change.

