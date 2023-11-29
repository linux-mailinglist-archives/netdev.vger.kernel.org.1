Return-Path: <netdev+bounces-51998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB37FCDC4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8599CB21289
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DE63D6;
	Wed, 29 Nov 2023 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBsUPiJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C119A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:16:03 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c2b7ec93bbso2785776a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701231363; x=1701836163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3JSNM/m8WJzuixjxIDVGu1RRHcyIMMS7kTxx8uXggk=;
        b=hBsUPiJ78XbNSlsKMeoUsLzP9J1S9ylMQ6aoDdJZd5wgE6XDI7BrSNUWQC90YdVpYw
         V4D+MQ5TKTWJV1fuSSm3d1hJS8FsQU1HO8LIvbZRto1w6s3Pz8ONFxc2V0FKRGOcqUwX
         Ks1aLRqW3gSRA/yNw+USMS7zYg/8fmATSEJqh9Chxhvu5G6iSQ/teAqGYQ7sMK0AzzIL
         //v+DTdpWm96UgFjLoT+qQgOtHbHTvQkk4l5KvI9jnDDyQgvnpMd0Zg7krfRBY558wZH
         Dhb1mF60u6+LxArG2HB0Bab+DfE75s6iKGvpb9PmbLqG/p4CsobPJO801aCcGWlKokpd
         2F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231363; x=1701836163;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3JSNM/m8WJzuixjxIDVGu1RRHcyIMMS7kTxx8uXggk=;
        b=WVluQJEmLWuk4gdTTqyQIlV+rbAt5T+0czdui+4C8tMm5D3CfA3KhtAMrCPqkLidF3
         QEhIhfWrQowZws4LL/BkjQQ0aVEPoQWYQE+jUalDyM/1GEG+LLy55UUexutsjJxByGpe
         kywM+pjTm7dUwt0eJCRTFjqOg9nh/iaAh90tvm4T+irm3SmHLli/q/vCwj9g5ELFKb7t
         UoLsdpFszui+1B7M/Ir2e9a0Gx9gNU+hgQuAGh+SgUdBJ+xma8Wky9RwXoAL/Dod3k6j
         rV5jUjulPLoZRW/v7fDU6HWRTBrOLSEx/+2wPYqU5uw+OmV5XyjdenJSH7GEjDReYXiG
         He+A==
X-Gm-Message-State: AOJu0YyaXKQY3sLFZeTdIhSsC7fWZdvvkr+ETaWAJmiGRxvl2b/hNYGG
	3cYk/SW4+dnPsqVN6JxLYck=
X-Google-Smtp-Source: AGHT+IEJbAgWbkAs2y/8AsmkF3Z4gMnflhm6hJYd7GxSjcpllsStj4WjHRq4EmLiDamToezthT7MPw==
X-Received: by 2002:a05:6a20:8403:b0:18a:d7a8:5e5a with SMTP id c3-20020a056a20840300b0018ad7a85e5amr27830551pzd.58.1701231362790;
        Tue, 28 Nov 2023 20:16:02 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id ey25-20020a056a0038d900b006c06804cd39sm9756133pfb.153.2023.11.28.20.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:16:01 -0800 (PST)
Message-ID: <1a8e798d-3226-4a9b-b0e2-ddf5d863a649@gmail.com>
Date: Tue, 28 Nov 2023 20:15:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 07/10] docs: bridge: add multicast doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-8-liuhangbin@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231128084943.637091-8-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/2023 12:49 AM, Hangbin Liu wrote:
> Add multicast part for bridge document.
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index 764d44c93c65..956583d2a184 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -161,6 +161,61 @@ on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
>   it will start forwarding frames to appropriate destinations based on their
>   destination MAC address and VLAN tag (both must match).
>   
> +Multicast
> +=========
> +
> +The Linux bridge driver has multicast support allowing it to process Internet
> +Group Management Protocol (IGMP) or Multicast Listener Discovery (MLD)
> +messages, and to efficiently forward multicast data packets. The bridge
> +driver support IGMPv2/IGMPv3 and MLDv1/MLDv2.

nit: supports.

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

maybe s/joined/subscribed/g (throughout the whole document)? Other than 
that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

