Return-Path: <netdev+bounces-35598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80AF7A9EF1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FAF281F6D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98E18B08;
	Thu, 21 Sep 2023 20:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCE168D8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:15:22 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C967FF83A;
	Thu, 21 Sep 2023 13:14:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5dd017b30so6435785ad.0;
        Thu, 21 Sep 2023 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695327290; x=1695932090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyEngoB20EiGdQxWeRrp1wv5Ks/o+AuWbIIGFDAcGkc=;
        b=Cq82qJPLnBw0PQroS1GAaxWyadVPIxbTqUWPZtPXMjo4x+eRMAFLeX6irGvBLxgJ0D
         EXiC+oVpJYn5MmU+pbrgl2BzyAbd9ss6c/qrWuqBgqcJ6J6wC498WvZtp56l3u+/gox0
         Q5/jWAbPN69pQGbb4al5xyPeBD4xWWq08Yh/hxCWPacQeJ/m49wkuQtluhSO9G2u+pNv
         3Mun4YawjX7t6Re9obCUdT5l2AhXjYLym2aGRRuln4iEBJJtFfBLJpSQiAJQU1vCK4Yh
         0QcJn7heAQ2YiVY6MU9CDqLK8JgJczxMugvEk5XCr5XTmAjf1B8RtnqQXnBlne3IG4dC
         SD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695327290; x=1695932090;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyEngoB20EiGdQxWeRrp1wv5Ks/o+AuWbIIGFDAcGkc=;
        b=BmR7mDY1JWMwFtz7vSwPV+4Wiy6EknfYlSso7BHD8jsc85F+llY4PkIRP8vymtoSTJ
         t0wh5MHjarPzC6HUu3pVK0zizfcTdPmIvnyRsRbZYcqwbGM48KAsTfmffguztuoEifOp
         19dXgqGfbbIjydAKHECudUwLc67S/3j/ED4Dk9hBxAqLiUDalUUWe3dtUzLuQsWz3a6h
         W/jMYRqDOGl/jidQiBan7Ef58N+F87UrEMjpUUoJkxTrWf4JI6valmga7aJ/g0vATmia
         ay7lLbOZJtIzNE88XXRI7OAELN6/FVFY5snSvX6a3YZIFNQIPNb8Wtp25exQnevPyvGD
         CUVg==
X-Gm-Message-State: AOJu0Yz8QTIaYkLjT82Qm2JxBAiX8xKlkiA72ouydGb0IsdIl0szTPyy
	+Nb2BEZ+0H5Pm1OUy/64luQ=
X-Google-Smtp-Source: AGHT+IEXFS/tfXu/U8U2r/q8qDaqvI0FMUVqjfM/+vJynfUb+k1UGCrLSXvalSGl0pBWUjWMwDE6Cg==
X-Received: by 2002:a17:902:ab48:b0:1b7:ca9c:4f5c with SMTP id ij8-20020a170902ab4800b001b7ca9c4f5cmr725279plb.28.1695327289856;
        Thu, 21 Sep 2023 13:14:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b8a00d4f7asm1940872plg.9.2023.09.21.13.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 13:14:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b28abd34-a7ef-661a-aafa-3e6c8e963726@roeck-us.net>
Date: Thu, 21 Sep 2023 13:14:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jisheng Zhang <jszhang@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <11fce633-4699-470f-a2f3-94b99b3e6da6@roeck-us.net>
 <20230921195608.dlol2f6fifx6ahd6@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: use per-queue 64 bit
 statistics where necessary
In-Reply-To: <20230921195608.dlol2f6fifx6ahd6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 12:56, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Thu, Sep 21, 2023 at 11:34:09AM -0700, Guenter Roeck wrote:
>> On Tue, Jul 18, 2023 at 12:06:30AM +0800, Jisheng Zhang wrote:
>>> Currently, there are two major issues with stmmac driver statistics
>>> First of all, statistics in stmmac_extra_stats, stmmac_rxq_stats
>>> and stmmac_txq_stats are 32 bit variables on 32 bit platforms. This
>>> can cause some stats to overflow after several minutes of
>>> high traffic, for example rx_pkt_n, tx_pkt_n and so on.
>>>
>>> Secondly, if HW supports multiqueues, there are frequent cacheline
>>> ping pongs on some driver statistic vars, for example, normal_irq_n,
>>> tx_pkt_n and so on. What's more, frequent cacheline ping pongs on
>>> normal_irq_n happens in ISR, this makes the situation worse.
>>>
>>> To improve the driver, we convert those statistics to 64 bit, implement
>>> ndo_get_stats64 and update .get_ethtool_stats implementation
>>> accordingly. We also use per-queue statistics where necessary to remove
>>> the cacheline ping pongs as much as possible to make multiqueue
>>> operations faster. Those statistics which are not possible to overflow
>>> and not frequently updated are kept as is.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>
>> Your patch results in lockdep splats. This is with the orangepi-pc
>> emulation in qemu.
>>
>> [   11.126950] dwmac-sun8i 1c30000.ethernet eth0: PHY [mdio_mux-0.1:01] driver [Generic PHY] (irq=POLL)
>> [   11.127912] dwmac-sun8i 1c30000.ethernet eth0: No Safety Features support found
>> [   11.128294] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
>> [   11.128511] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
>> [   11.138990] dwmac-sun8i 1c30000.ethernet eth0: configuring for phy/mii link mode
>> [   11.144387] INFO: trying to register non-static key.
>> [   11.144483] The code is fine but needs lockdep annotation, or maybe
>> [   11.144568] you didn't initialize this object before use?
>> [   11.144640] turning off the locking correctness validator.
>> [   11.144845] CPU: 2 PID: 688 Comm: ip Tainted: G                 N 6.6.0-rc2 #1
>> [   11.144956] Hardware name: Allwinner sun8i Family
>> [   11.145137]  unwind_backtrace from show_stack+0x10/0x14
>> [   11.145610]  show_stack from dump_stack_lvl+0x68/0x90
>> [   11.145692]  dump_stack_lvl from register_lock_class+0x99c/0x9b0
>> [   11.145779]  register_lock_class from __lock_acquire+0x6c/0x2244
>> [   11.145861]  __lock_acquire from lock_acquire+0x11c/0x368
>> [   11.145938]  lock_acquire from stmmac_get_stats64+0x350/0x374
>> [   11.146021]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
>> [   11.146101]  dev_get_stats from rtnl_fill_stats+0x30/0x118
>> [   11.146179]  rtnl_fill_stats from rtnl_fill_ifinfo.constprop.0+0x82c/0x1770
>> [   11.146273]  rtnl_fill_ifinfo.constprop.0 from rtmsg_ifinfo_build_skb+0xac/0x138
>> [   11.146370]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x44/0x7c
>> [   11.146452]  rtmsg_ifinfo from __dev_notify_flags+0xac/0xd8
>> [   11.146531]  __dev_notify_flags from dev_change_flags+0x48/0x54
>> [   11.146612]  dev_change_flags from do_setlink+0x244/0xe6c
>> [   11.146689]  do_setlink from rtnl_newlink+0x514/0x838
>> [   11.146761]  rtnl_newlink from rtnetlink_rcv_msg+0x170/0x5b0
>> [   11.146841]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x10c
>> [   11.146925]  netlink_rcv_skb from netlink_unicast+0x190/0x254
>> [   11.147006]  netlink_unicast from netlink_sendmsg+0x1dc/0x460
>> [   11.147086]  netlink_sendmsg from ____sys_sendmsg+0xa0/0x2a0
>> [   11.147168]  ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
>> [   11.147245]  ___sys_sendmsg from sys_sendmsg+0x4c/0x88
>> [   11.147329]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
>> [   11.147439] Exception stack(0xf23edfa8 to 0xf23edff0)
>> [   11.147558] dfa0:                   00000000 00000000 00000003 bef9a8d8 00000000 00000000
>> [   11.147668] dfc0: 00000000 00000000 ffffffff 00000128 00000001 00000002 bef9af4a bef9af4d
>> [   11.147769] dfe0: bef9a868 bef9a858 b6f9ddac b6f9d228
>> [   11.150020] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
>>
>> My apologies for the noise if this has already been reported.
> 
> This seems to be the issue I reported earlier. So you might want to test
> the patch that fixed it for me:
> https://lore.kernel.org/netdev/20230917165328.3403-1-jszhang@kernel.org/
> 

That just showed up in mainline and, yes, of course it fixes the problem.
As I said, sorry for the noise.

Guenter



