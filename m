Return-Path: <netdev+bounces-47304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6877E989E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EBA1C2042A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBC18625;
	Mon, 13 Nov 2023 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Otv8pwbR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29218623
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:14:09 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E0D4A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:14:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso6336610a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699866847; x=1700471647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13rsGuuJU60EhfW1VO2ckVQkBnDzMXc0cteRxFOUMwI=;
        b=Otv8pwbRhbUBfjS31PSVc+OrTNqAkiuodbHKFtW2r1BoolcyAcjbdeJGNsqyrXVfWr
         6mdRPF4PL2upSONoiLmxXpNXy3H25iVdK3mU9oZv4NuLzYeNK6HUya+wMYz2bJGGE5vd
         2y9WlstklGfYGeJDnaPgQxYSQH+fx5kAR9GwwCGKa7uhtzGqLwwpd+0QKrIrny+XeR4T
         WeirpyZBE6bOBngiLVic60Jds1KRcGUWmwc5ZLd34wFYreNp5dhCETwHxphLtwhW7t0I
         FooZ6vo/4vsI1pj8gejjMht/rLLlHU5wQ6tAR/0qjk8AFAN3JU0w9eLCyYU0ovAtCmIQ
         Hsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699866847; x=1700471647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13rsGuuJU60EhfW1VO2ckVQkBnDzMXc0cteRxFOUMwI=;
        b=mlIv2Jq7AkkHBNfTmCZCCzFH2naEj3vVcXYWztwWrttZa/n22n9lG5WKATgs9OWqbz
         m0mYp8Hi0NbWH3RRMMFvmY4P5bLV20zMj8E1UtRxRgbtf2jTUDZ6/PIVlKRZDfEKLlNy
         EKV12r2FdbeNOqfA2/ODRoWk2XP98abBcyca/3BwnlYIYGAFXe7VqJ4wGRzC8VTkZXpp
         i1Qs1miYkyDz5LcQKf8FYA71X5ZgU8UjIX4/ddQZgNjXWECrvoAddD7KqNFRtps2bt7f
         7dR1K5JrOfZBbKvBseuUbjGgrjUI6GFIpxX7xjIYNtJUBFx6UhfBE0pACtFbYytrt/Y0
         5YbA==
X-Gm-Message-State: AOJu0YxbGXriQjkfpDV8r/IiZFEg1jAF0rsaQ0G4/EIlQ5ahRboCf7Sl
	9R63VqGMwUaduvvKw6oBtoLhtQ==
X-Google-Smtp-Source: AGHT+IFACB96utG8a1adhZBfZTkgoWgQXD6F7Io07/56yZoEZV3fQ75ym6PtHKnVwRMcjp3CL0qSFw==
X-Received: by 2002:a17:906:1cd4:b0:9e3:ef19:7205 with SMTP id i20-20020a1709061cd400b009e3ef197205mr4105198ejh.3.1699866846688;
        Mon, 13 Nov 2023 01:14:06 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b009ada9f7217asm3639457ejz.88.2023.11.13.01.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:14:06 -0800 (PST)
Message-ID: <4007f5af-3bcf-6e8b-3229-c6d81d68b994@blackwall.org>
Date: Mon, 13 Nov 2023 11:14:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 01/10] net: bridge: add document for
 IFLA_BR enum
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-2-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add document for IFLA_BR enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 270 +++++++++++++++++++++++++++++++++++
>   1 file changed, 270 insertions(+)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 29ff80da2775..32d6980b78d1 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -461,6 +461,276 @@ enum in6_addr_gen_mode {
>   
>   /* Bridge section */
>   
> +/**
> + * DOC: The bridge enum defination

s/defination/definition/

> + *
> + * please *note* that all the timer in the following section is in clock_t
> + * type, which is seconds multiplied by user_hz (generally defined as 100).

"please *note* that the timer values in the following section are 
expected in clock_t format, which is..."

user_hz is a constant, use USER_HZ

> + *
> + * @IFLA_BR_FORWARD_DELAY
> + *   The bridge forwarding delay is the time spent in LISTENING state
> + *   (before moving to LEARNING) and in LEARNING state (before moving
> + *   to FORWARDING). Only relevant if STP is enabled.
> + *
> + *   The valid values are between (2 * USER_HZ) and (30 * USER_HZ).
> + *   The default value is (15 * USER_HZ).
> + *

rest looks good


