Return-Path: <netdev+bounces-47319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D397E99A7
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D1EB20817
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AC1A5B3;
	Mon, 13 Nov 2023 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XJxDxySk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF281BDF6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:01:44 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53813D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:01:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so602508966b.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699869700; x=1700474500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6xB4vhtPAZqP+JeixL6kiHGr5yUKhM+UjOBqa5CIdA=;
        b=XJxDxySkTN4HyZJeEaE6+YQk7pQqjhEmdI6YC106IJxIBOkMmV5r8rQ0Qz8RFqhQnW
         k250rDNRUR/PivOrjwx1paAp6gT2YVbEZBrvx6bQU6zpWtcJyoDGo/UG5vDmouCc8bwO
         KPpOrFNH+kbh2sAdaJA3pibY7Cn/WRXiqAmFyOxmBDLfau3wC4hKMVjO/FCzlwW6R0Ib
         pfKubDwqnO/1yoQWYYkZycosWG8MiHRr2MYzLZrO/lqd1Is4bLYcc5Z2Nxzk44h4JuoD
         3ILmRtEfRsRN2X7uyfOkqPkmnoSqCp6Qxzcxj0fr/BcTxv1qUcUG0fpIgON1haIAXb5y
         zBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869700; x=1700474500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6xB4vhtPAZqP+JeixL6kiHGr5yUKhM+UjOBqa5CIdA=;
        b=Gk9mmhXMS0wQ2e8/NN1gQ+ZVUiuVB2dUia/vlsVlvT5nOO/bq9fW/yY6fYIXFsL3yt
         pz0veY283sHkWv2xNv2U/te65BmweBKZK6ymBl6xAb1ZkhZ9zAJCUrf4DxB04hY371Ka
         CkbrJ7ybAR7ODzmQ/2uukv5MA2BHPLRyC7oTVru3xHqQEFq4chaozFGpWaXPMLPDVPdQ
         9g1tr0V+KxrtfxYsIh1DfIXSwFvMxfvHkik1i/42Ezdg4DfqNbR5FkMo5qauH0svQOlU
         noXWpJVmcBhScdM9NBl+ZGG0RowDYpaisbB6Wo/JTSf0zUFGopqkWwsSAhNwvu33wmjc
         6IpA==
X-Gm-Message-State: AOJu0Yyb5bk5BWI9wK6Kn/yInlfYvlzGDNavKn2CdTMn4eiQ7pAGRBOw
	SuAQGLWsBZ+FJtM/eBKBBhmUQg==
X-Google-Smtp-Source: AGHT+IFnEFVKxPTxdphu13WNv1seF330bzZSnrMGUzYOFoy8+v7X2DF4He9ma8nNU6zC1GPfMRyD6w==
X-Received: by 2002:a17:906:480b:b0:9e7:2d0b:8c46 with SMTP id w11-20020a170906480b00b009e72d0b8c46mr5381702ejq.50.1699869700535;
        Mon, 13 Nov 2023 02:01:40 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b0098884f86e41sm3767957ejb.123.2023.11.13.02.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:01:40 -0800 (PST)
Message-ID: <8c97d913-5e8f-d06a-ba7c-99c143e19f2c@blackwall.org>
Date: Mon, 13 Nov 2023 12:01:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 10/10] docs: bridge: add small features
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
 <20231110101548.1900519-11-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-11-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add some small features in the "Others" part of bridge document.

Please use "other" instead of "small". People can get offended. These
are not small features, just other. Same for patch subject.

> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index 7f63d21c9f46..8adf99774d59 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -273,6 +273,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
>   ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
>   traffic. For pure link layer filtering, this module isn't needed.
>   
> +Other Features
> +==============
> +
> +The Linux bridge also supports `IEEE 802.11 Proxy ARP
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=958501163ddd6ea22a98f94fa0e7ce6d4734e5c4>`_,
> +`Media Redundancy Protocol (MRP)
> +<https://lore.kernel.org/netdev/20200426132208.3232-1-horatiu.vultur@microchip.com/>`_,
> +`Media Redundancy Protocol (MRP) LC mode
> +<https://lore.kernel.org/r/20201124082525.273820-1-horatiu.vultur@microchip.com>`_,
> +`IEEE 802.1X port authentication
> +<https://lore.kernel.org/netdev/20220218155148.2329797-1-schultz.hans+netdev@gmail.com/>`_,
> +and `MAC Authentication Bypass (MAB)
> +<https://lore.kernel.org/netdev/20221101193922.2125323-2-idosch@nvidia.com/>`_.
> +
>   FAQ
>   ===
>   


