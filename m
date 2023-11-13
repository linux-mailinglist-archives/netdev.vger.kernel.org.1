Return-Path: <netdev+bounces-47313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570657E9967
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CCDB207DF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DD1A590;
	Mon, 13 Nov 2023 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bIvb/Sr3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802241A587
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:49:35 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496010D0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:49:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso6289271a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699868972; x=1700473772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tkb0ITmt1AH/uBly4ebId/NO8BQ5cP2iIAYcJ95Dpxk=;
        b=bIvb/Sr3sdErq3izJLit0LRLe7c1w6zKX6YU7FJwqI2iuqn3+W+uxyuPAfSSJbKFFe
         dDH4j/UCZDCZ9+yZKnPXxDfb0hgsGxzX6xCLm1u0cD0Vu1MAQeEtFjLeVYQrSrzN+jF+
         57iLygzLIBBvf7RKY6CLNYZAWQkDCF2Gw0h0bf4rUQurb+PnEOs1yfhqyvtLXSJZeXza
         qYDqqHo5WMPmtAtuShqtYqN82xx6Pl10UgbkXCPHZ1rpUv+fpJi3DCAK/v1u19/sgKzy
         USzc28aU9Thrgexzhfp1Azts0STGRvuJTiknklskMbXo0R+LiRvqYM73F0Ny8nERK6F8
         yBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868972; x=1700473772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkb0ITmt1AH/uBly4ebId/NO8BQ5cP2iIAYcJ95Dpxk=;
        b=vy3pdFel9N2YHnmF4jP/iMnwdN8F05ssr1MX6QmxoZ7h0lsuMwxmK4BKEO7lsol+7p
         35TL5ky9vzgTpOtG5hq0nK4/LMtDjwWfdX75mDmWYztgljTAR2fKCtEG8Z5HAI3H12QH
         enAkmDaEUYLio4g+EAu+EwapSogin3izJmQzOp9R2A/B17on2+rRjYjQtw5SOTWgIkMG
         sTv3LOwUckZhHXPy+gKqa7yLSbdvrfyveDIYB7CssOFOAct/pwIHb6/YzTGiYLC+kPCw
         6mh39MG6FD72MmSWsKkwlIyDtKP0DfYf07iYh9bBSTzlrhploWLQmPBRCx+ZRivAwIJY
         H7Aw==
X-Gm-Message-State: AOJu0Yz3y5uFmnw/9DCHosQeohl/u9dXPNKkwSKiyzOsuVCUBz/TLzMA
	grKCGHzYnu8obF2S/zkXOg1OZqn6QCOJN+0AL2l/uQ==
X-Google-Smtp-Source: AGHT+IGaWyw6wIyVW++Fhr9tIu1LF5iG2VZTSg2v7eXBhKzIZ5rFWozWY2KOv7o66GZuwWeK1y+z6w==
X-Received: by 2002:a05:6402:285:b0:541:875:53d8 with SMTP id l5-20020a056402028500b00541087553d8mr4252696edv.23.1699868971799;
        Mon, 13 Nov 2023 01:49:31 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id d22-20020a50cd56000000b0054719a2a0cdsm3012550edj.16.2023.11.13.01.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:49:31 -0800 (PST)
Message-ID: <873cd494-dbab-96a6-c6cb-0ee3689f9010@blackwall.org>
Date: Mon, 13 Nov 2023 11:49:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
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
 <20231110101548.1900519-5-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-5-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> First add kAPI/uAPI and FAQ fields. These 2 fileds are only examples and
> more APIs need to be added in future.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 83 +++++++++++++++++++++++++----
>   1 file changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index c859f3c1636e..d06c51960f45 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -4,18 +4,81 @@
>   Ethernet Bridging
>   =================
>   
> -In order to use the Ethernet bridging functionality, you'll need the
> -userspace tools.
> +Introduction
> +============
>   
> -Documentation for Linux bridging is on:
> -   https://wiki.linuxfoundation.org/networking/bridge
> +A bridge is a way to connect multiple Ethernet segments together in a protocol
> +independent way. Packets are forwarded based on Layer 2 destination Ethernet
> +address, rather than IP address (like a router). Since forwarding is done
> +at Layer 2, all Layer 3 protocols can pass through a bridge transparently.
>   
> -The bridge-utilities are maintained at:
> -   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
> +Bridge kAPI
> +===========
>   
> -Additionally, the iproute2 utilities can be used to configure
> -bridge devices.
> +Here are some core structures of bridge code.
>   
> -If you still have questions, don't hesitate to post to the mailing list
> -(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
> +.. kernel-doc:: net/bridge/br_private.h
> +   :identifiers: net_bridge_vlan
>   
> +Bridge uAPI
> +===========
> +
> +Modern Linux bridge uAPI is accessed via Netlink interface. You can find
> +below files where the bridge and bridge port netlink attributes are defined.
> +
> +Bridge netlink attributes
> +-------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: The bridge enum defination
> +
> +Bridge port netlink attributes
> +------------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: The bridge port enum defination
> +
> +Bridge sysfs
> +------------
> +
> +All the sysfs parameters are also exported via the bridge netlink API.

drop "the" here, all sysfs parameters

> +Here you can find the explanation based on the correspond netlink attributes.

"Here you can find sysfs parameter explanation based on the
corresponding  netlink attributes."
But where is "Here"? Not sure what you mean.

> +
> +NOTE: the sysfs interface is deprecated and should not be extended if new
> +options are added.
> +
> +.. kernel-doc:: net/bridge/br_sysfs_br.c
> +   :doc: The sysfs bridge attrs

You use "sysfs parameters", here it is "sysfs attrs". Be consistent and
use one of them. Drop "the" here.

> +
> +FAQ
> +===
> +
> +What does a bridge do?
> +----------------------
> +
> +A bridge transparently forwards traffic between multiple network interfaces.
> +In plain English this means that a bridge connects two or more physical
> +Ethernet networks, to form one larger (logical) Ethernet network.
> +
> +Is it L3 protocol independent?
> +------------------------------
> +
> +Yes. The bridge sees all frames, but it *uses* only L2 headers/information.
> +As such, the bridging functionality is protocol independent, and there should
> +be no trouble forwarding IPX, NetBEUI, IP, IPv6, etc.
> +
> +Contact Info
> +============
> +
> +The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
> +Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
> +are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
> +bridge@lists.linux-foundation.org.
> +
> +The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
> +
> +External Links
> +==============
> +
> +The old Documentation for Linux bridging is on:
> +https://wiki.linuxfoundation.org/networking/bridge


