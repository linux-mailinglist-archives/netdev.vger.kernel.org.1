Return-Path: <netdev+bounces-47315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28F7E9977
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA3D280B41
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF651A59A;
	Mon, 13 Nov 2023 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="llJ+MPGf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D901A590
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:54:43 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386510D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:54:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c41e95efcbso622224566b.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699869281; x=1700474081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DR1Dx3CLQweQ79TgGY3Jve1InkB2HgR3sS3Ti0K3XBw=;
        b=llJ+MPGfM2zmVHg0ZaRG0SbgvV3QOGAeubuhTWkojZVf7mPVK+cwSHbnI9bVVdrUCG
         QNDAtLlP+6SZIRUJUtnDFq+kIQF3B81/4j+c4IZFAf3AAWGJeVkzc1CO2tXtnj2ENsQU
         NLrtk11M3QzWu1V4++14sUZPzyUi3A1/LbDBu1uKXtKggnnYmEQ7gbahgTM3/rj/pAy+
         z1S1VG7MYaLvdU3+J/ao4erYHmhnWRJciNxlAWMJbDGTqqx5VHVYP9exQftFutrGGe3b
         YTCVSI4Ym05ovskrdKtWDH/Cn/oVvb39ganV3jnAYkbxWE0WYJV8cX3b1jIsw4RLWZN+
         lMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869281; x=1700474081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR1Dx3CLQweQ79TgGY3Jve1InkB2HgR3sS3Ti0K3XBw=;
        b=ezTN3ho3Pg1nBeht4HLgnDA8uAFwB6dmBSFLbmpjAfNwZDo4wNvWq/+bnjEGP7kn+D
         wh4JxIo9+FA4T3LWD7Q4yjCAxyTubFmLyva6vy3AjoZAffVme7yTRbe1m5Ct7pVj8HiZ
         ZyY0C3PL0pODYEGLVf7a9S/a3LEO0xPfGfNgQV29Ys5LAM9eZNFNFLxLsEni5K4opDqX
         T+RBxnAU2qa9GHystlRAyCy+3WVPJNsLrD5KhVLfYfKExQ6zhgSMLAHuR1Z15kRfGsD1
         ia02rKcC+61TAjuAyfSwrcBiN3SHhhIjv6/PLUHjGU4EhsL8BO1Ybe/xjUtgOCL8Syfm
         8Ybg==
X-Gm-Message-State: AOJu0YxiMhIVCfwSC5/QA+BgjM2/NCE0TgFx0GoF888VylI+becn88mA
	KH0jMUiTCHqVLWTN1vfS7HvD8w==
X-Google-Smtp-Source: AGHT+IFJomFghMSHhcOp8UKIisjPccoVDlgHKCIy8884JWXscR8qnYXoJVzJPG/TKJ+twSODBeu1gQ==
X-Received: by 2002:a17:907:36c5:b0:9e7:c1cd:a4dc with SMTP id bj5-20020a17090736c500b009e7c1cda4dcmr3800041ejc.6.1699869280599;
        Mon, 13 Nov 2023 01:54:40 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id ay18-20020a170906d29200b009ce03057c48sm3786682ejb.214.2023.11.13.01.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:54:40 -0800 (PST)
Message-ID: <794505c1-da3c-c52a-ece8-9629ab6f32db@blackwall.org>
Date: Mon, 13 Nov 2023 11:54:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
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
 <20231110101548.1900519-7-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-7-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add VLAN part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index e168f86ddd82..88dfc6eb0919 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -135,6 +135,35 @@ Proper configuration of STP parameters, such as the bridge priority, can
>   influence which bridge becomes the Root Bridge. Careful configuration can
>   optimize network performance and path selection.
>   
> +VLAN
> +====
> +
> +A LAN (Local Area Network) is a network that covers a small geographic area,
> +typically within a single building or a campus. LANs are used to connect
> +computers, servers, printers, and other networked devices within a localized
> +area. LANs can be wired (using Ethernet cables) or wireless (using Wi-Fi).
> +
> +A VLAN (Virtual Local Area Network) is a logical segmentation of a physical
> +network into multiple isolated broadcast domains. VLANs are used to divide
> +a single physical LAN into multiple virtual LANs, allowing different groups of
> +devices to communicate as if they were on separate physical networks.
> +
> +Typically there are two VLAN implementations, IEEE 802.1Q and IEEE 802.1ad
> +(also known as QinQ). IEEE 802.1Q is a standard for VLAN tagging in Ethernet
> +networks. It allows network administrators to create logical VLANs on a
> +physical network and tag Ethernet frames with VLAN information, which is
> +called *VLAN-tagged frames*. IEEE 802.1ad, commonly known as QinQ or Double
> +VLAN, is an extension of the IEEE 802.1Q standard. QinQ allows for the
> +stacking of multiple VLAN tags within a single Ethernet frame. The Linux
> +bridge supports both the IEEE 802.1Q and `802.1AD
> +<https://lore.kernel.org/netdev/1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp/>`_
> +protocol for VLAN tagging.
> +
> +The `VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_

drop "The", just VLAN filtering

> +on bridge is disabled by default. After enabling VLAN

on a bridge

> +filter on bridge, the bridge can handle VLAN-tagged frames and forward them

filtering on a bridge, it will

But here it sounds a bit misleading, as if vlan-tagged frames are not 
handled otherwise. They are, just vlan tags are not considered when
making forwarding decisions (e.g. FDB lookup).

> +to the appropriate destinations.
> +
>   FAQ
>   ===
>   


