Return-Path: <netdev+bounces-62778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7A82928C
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 03:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1B61F25E0B
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64017F0;
	Wed, 10 Jan 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVKb93zq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1523B1
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28ca63fd071so1918447a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 18:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704855367; x=1705460167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiT2qWgO98FYe9m34IiUV97Gff8HWu7d65HaL9kKcuU=;
        b=FVKb93zqlNEqNX3yDpAtO+KlQHLOVtaiCAvGo5WrHAtELAS3cqu5WfId94qDZAt5Fc
         aJTBrtATWLwVTPcQJRx/tZiAlvFfmyuAjXgW/yVgb/v0V+7yWcpHz7SNv6bO0JEYWLC6
         tqm6BbccOb1OayAZsV5Mbbal8CW6MKHp8WfDpscAe6RanfJMWjT0WXblYejGPNEH4YBc
         rgy9yHum/Q3QABKo44ekF6Vqb4hEKrnWJHWKaUAe87oACG6WNYS7W1WhMYKNkSGTS75q
         z8H18M0EtcHmO93dB41VLWhxKWmK9SiV3sm1JfVcIPmRLEygww6KqF4E8Mwr/p1BT32r
         LWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855367; x=1705460167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiT2qWgO98FYe9m34IiUV97Gff8HWu7d65HaL9kKcuU=;
        b=DCjo5HEIkfWm0d4euPR1pPbT/3j7vA7f0V7EndRuCQVxT73Iu0qaMDWN/n6e40NF4j
         U73s4I9c17+bRYf+KnzjuATftBFDd3EDzkYSDN3gAZ8ZACe8CMWIvqfTXfSdFYc3Iy+W
         29rzN+f5/SAvC7yUnvrScSsbiNAxw9en+lLjg+nPPB4jKRSzgDJL77DTSb8EfacuGlNa
         GbKGwuOqHUXg0+TQqJiAcQLcI6rKOi2O1Xjk23XxN/fQWuIB7+vGQbZ2mz+ZaTD5PfqZ
         vsC9Jw8Vly3AcqXPRa9rZu9z/6c2CL4PG+knE8QZ/KroXQId6UDUwCSpieA3MSj+hCUv
         DbuQ==
X-Gm-Message-State: AOJu0Yy8+dmLcWWLx69ukBZDGeMeOEY/lVRjWIevQk2IpWV16JeoIeHk
	RCReCOhaz+BJPQV4UzIP6VQ=
X-Google-Smtp-Source: AGHT+IGnwRd5v86P2s74EACD9wqXeA2PogI0IZbsfHBpxG0Y+qnObESVXMHnUQkeMUG+XzRr3dz5qA==
X-Received: by 2002:a17:90b:4b12:b0:28c:a2ff:9970 with SMTP id lx18-20020a17090b4b1200b0028ca2ff9970mr151778pjb.35.1704855366826;
        Tue, 09 Jan 2024 18:56:06 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id gl18-20020a17090b121200b0028cef021d45sm236691pjb.17.2024.01.09.18.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 18:56:06 -0800 (PST)
Message-ID: <53e0460b-3ae0-41b6-b50f-368462d2682d@gmail.com>
Date: Tue, 9 Jan 2024 18:56:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: fix netdev_priv() dereference before check
 on non-DSA netdevice events
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
References: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/2024 4:33 PM, Vladimir Oltean wrote:
> After the blamed commit, we started doing this dereference for every
> NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.
> 
> static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
> {
> 	struct dsa_user_priv *p = netdev_priv(dev);
> 
> 	return p->dp;
> }
> 
> Which is obviously bogus, because not all net_devices have a netdev_priv()
> of type struct dsa_user_priv. But struct dsa_user_priv is fairly small,
> and p->dp means dereferencing 8 bytes starting with offset 16. Most
> drivers allocate that much private memory anyway, making our access not
> fault, and we discard the bogus data quickly afterwards, so this wasn't
> caught.
> 
> But the dummy interface is somewhat special in that it calls
> alloc_netdev() with a priv size of 0. So every netdev_priv() dereference
> is invalid, and we get this when we emit a NETDEV_PRECHANGEUPPER event
> with a VLAN as its new upper:
> 
> $ ip link add dummy1 type dummy
> $ ip link add link dummy1 name dummy1.100 type vlan id 100
> [   43.309174] ==================================================================
> [   43.316456] BUG: KASAN: slab-out-of-bounds in dsa_user_prechangeupper+0x30/0xe8
> [   43.323835] Read of size 8 at addr ffff3f86481d2990 by task ip/374
> [   43.330058]
> [   43.342436] Call trace:
> [   43.366542]  dsa_user_prechangeupper+0x30/0xe8
> [   43.371024]  dsa_user_netdevice_event+0xb38/0xee8
> [   43.375768]  notifier_call_chain+0xa4/0x210
> [   43.379985]  raw_notifier_call_chain+0x24/0x38
> [   43.384464]  __netdev_upper_dev_link+0x3ec/0x5d8
> [   43.389120]  netdev_upper_dev_link+0x70/0xa8
> [   43.393424]  register_vlan_dev+0x1bc/0x310
> [   43.397554]  vlan_newlink+0x210/0x248
> [   43.401247]  rtnl_newlink+0x9fc/0xe30
> [   43.404942]  rtnetlink_rcv_msg+0x378/0x580
> 
> Avoid the kernel oops by dereferencing after the type check, as customary.
> 
> Fixes: 4c3f80d22b2e ("net: dsa: walk through all changeupper notifier functions")
> Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000001d4255060e87545c@google.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

