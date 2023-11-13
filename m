Return-Path: <netdev+bounces-47317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B147E9996
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7884CB207E5
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A41A5B3;
	Mon, 13 Nov 2023 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0VCdwhdA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11521B267
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:00:09 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64010E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:00:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e1021dbd28so641391766b.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699869606; x=1700474406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSIzylncK6ffJfwKQJBznxJKIK5+QYXgoPc9kxI/nxY=;
        b=0VCdwhdA0f86lqliKajd9m10a1Lw3lqU6GuQWlsknw4hfps3FuRoWL2GJU19LSuHgO
         7bRlcW6Ei5tkymmyNoVYn8z3lmO6t00XBH0ZBTUXs4zCN2aYVSn6wYv+XloGx0sXnEmH
         qePJT7puEXiDO8nDWLycAumZIjD8nR/pbCceY2p1gWpK8qMwNuLIGMb3w2kg/IOJu1B6
         Cko0u58mTNnF4LbXhXAzh9o/PIBx3Do3hR/debkbefGwucplIlPw88T4Hr2mc0iwlBhQ
         pN7nhNGoZsq1iTQbbk0vV3VMeRPXBU4i5S7Cf62uvWXP8sDT6QBW6ym73gSKydKcG6SH
         N5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869606; x=1700474406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSIzylncK6ffJfwKQJBznxJKIK5+QYXgoPc9kxI/nxY=;
        b=mZhA2f1VZ6ETsaliARt3OKNS96puWiPVkL8OH1lPsBk4dJRwhgDd0B/LesG1HHbDlY
         wXrv3KTLW6xc8fEuEBte9Tj1fOokA6kwun49z/q5pce97ojP9UDyMZnStkGwwPSGIuEh
         PHTX0XlCA3COSCfIZaSg8afrVIhYuoRfefhpRRVrXjnP0EyJzJkXZbgQO/Qztkj4UUxI
         VrXiiCk+hk62JO1j6megeFiuGd58ieflM7wrV7gpvSPm9BOi4XCuBN49l6fNWbTMaypa
         qYfmV/woziBAW5wGC5183F5grbKpLjbqOGeLv14EDL2eEki1fc8ONWj41wr5eyo0vpPr
         f34g==
X-Gm-Message-State: AOJu0Yz7h31Y4cHk4z5DhRZirKGZdVxQphffgY4qcyzhR/JFIqrl5dBS
	CWyPhFDSFTzfy4/T7pHGAPqZ5g==
X-Google-Smtp-Source: AGHT+IE9IxxB61gt1DllLyfwfVmU6gWLJe7TJ1fiIbESInxp3mpIIzhQZg7JjgdgAalt4/RQlgdioA==
X-Received: by 2002:a17:906:404:b0:9e6:4156:af4f with SMTP id d4-20020a170906040400b009e64156af4fmr4459390eja.55.1699869606065;
        Mon, 13 Nov 2023 02:00:06 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906b20700b009ad89697c86sm3811683ejz.144.2023.11.13.02.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:00:05 -0800 (PST)
Message-ID: <8c92838a-4830-581d-c46d-08e399128f0f@blackwall.org>
Date: Mon, 13 Nov 2023 12:00:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 07/10] docs: bridge: add multicast doc
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
 <20231110101548.1900519-8-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-8-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add multicast part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index 88dfc6eb0919..1fe645c9543d 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -164,6 +164,61 @@ on bridge is disabled by default. After enabling VLAN
>   filter on bridge, the bridge can handle VLAN-tagged frames and forward them
>   to the appropriate destinations.
>   
> +Multicast
> +=========
> +
> +The Linux bridge driver has multicast support allowing it to process Internet
> +Group Management Protocol (IGMP) or Multicast Listener Discovery (MLD)
> +messages, and to efficiently forward multicast data packets. The bridge
> +driver support IGMPv2/IGMPv3 and MLDv1/MLDv2.
> +
> +Multicast snooping
> +------------------
> +
> +Multicast snooping is a networking technology that allows network switches
> +to intelligently manage multicast traffic within a local area network (LAN).
> +
> +The switch maintains a multicast group table, which records the association
> +between multicast group addresses and the ports where hosts have joined these
> +groups. The group table is dynamically updated based on the IGMP/MLD messages
> +received. With the multicast group information gathered through snooping, the
> +switch optimizes the forwarding of multicast traffic. Instead of blindly
> +broadcasting the multicast traffic to all ports, it sends the multicast
> +traffic based on the destination MAC address only to ports which have joined
> +the respective destination multicast group.
> +
> +When created, the Linux bridge devices have multicast snooping enabled by
> +default. It maintains a Multicast forwarding database (MDB) which keeps track
> +of port and group relationships.
> +
> +IGMPv3/MLDv2 ETH support

s/ETH/EHT/

Explicit Host Tracking is what we use in the bridge. I know
both are correct, but we should be consistent. You can change
it below as well.

> +------------------------
> +
> +The Linux bridge supports IGMPv3/MLDv2 ETH (Explicit Tracking of Hosts), which
> +was added by `474ddb37fa3a ("net: bridge: multicast: add EHT allow/block handling")
> +<https://lore.kernel.org/netdev/20210120145203.1109140-1-razor@blackwall.org/>`_
> +
> +The explicit tracking of hosts enables the device to keep track of each
> +individual host that is joined to a particular group or channel. The main
> +benefit of the explicit tracking of hosts in IGMP is to allow minimal leave
> +latencies when a host leaves a multicast group or channel.
> +
> +The length of time between a host wanting to leave and a device stopping
> +traffic forwarding is called the IGMP leave latency. A device configured
> +with IGMPv3 or MLDv2 and explicit tracking can immediately stop forwarding
> +traffic if the last host to request to receive traffic from the device
> +indicates that it no longer wants to receive traffic. The leave latency
> +is thus bound only by the packet transmission latencies in the multiaccess
> +network and the processing time in the device.
> +
> +Other multicast features
> +------------------------
> +The Linux bridge also supports `per-VLAN multicast snooping
> +<https://lore.kernel.org/netdev/20210719170637.435541-1-razor@blackwall.org/>`_,
> +which is disabled by default but can be enabled. And `Multicast Router Discovery
> +<https://lore.kernel.org/netdev/20190121062628.2710-1-linus.luessing@c0d3.blue/>`_,
> +which help identify the location of multicast routers.
> +
>   FAQ
>   ===
>   


