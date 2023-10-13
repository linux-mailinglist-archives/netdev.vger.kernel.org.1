Return-Path: <netdev+bounces-40678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFD7C8517
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C9C1C20B10
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7DF13FFF;
	Fri, 13 Oct 2023 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="exXwV//R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAF13FF7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:54:55 +0000 (UTC)
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FB90BF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:54:54 -0700 (PDT)
Received: from [IPV6:2a02:8010:6359:1:4d3:e723:472d:b106] (unknown [IPv6:2a02:8010:6359:1:4d3:e723:472d:b106])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 8BE8D7D8CD;
	Fri, 13 Oct 2023 12:54:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1697198093; bh=E45tIzyEVimPUf6d5cAV3f+tkxO9+FzETlHo9AW1Ukg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<6882ade2-876b-01d6-c6cb-e7fab329b081@katalix.com>|
	 Date:=20Fri,=2013=20Oct=202023=2012:54:53=20+0100|MIME-Version:=20
	 1.0|To:=20Miquel=20Raynal=20<miquel.raynal@bootlin.com>|Cc:=20Wei=
	 20Fang=20<wei.fang@nxp.com>,=20Shenwei=20Wang=20<shenwei.wang@nxp.
	 com>,=0D=0A=20Clark=20Wang=20<xiaoning.wang@nxp.com>,=20Russell=20
	 King=20<linux@armlinux.org.uk>,=0D=0A=20davem@davemloft.net,=20edu
	 mazet@google.com,=20kuba@kernel.org,=0D=0A=20pabeni@redhat.com,=20
	 linux-imx@nxp.com,=20netdev@vger.kernel.org,=0D=0A=20Thomas=20Peta
	 zzoni=20<thomas.petazzoni@bootlin.com>,=0D=0A=20Alexandre=20Bellon
	 i=20<alexandre.belloni@bootlin.com>,=0D=0A=20Maxime=20Chevallier=2
	 0<maxime.chevallier@bootlin.com>|References:=20<20231012193410.3d1
	 812cf@xps-13>=0D=0A=20<18b72fdb-d24a-a416-ffab-3a15b281a6e0@katali
	 x.com>=0D=0A=20<20231013123748.6b200f79@xps-13>|From:=20James=20Ch
	 apman=20<jchapman@katalix.com>|Subject:=20Re:=20Ethernet=20issue=2
	 0on=20imx6|In-Reply-To:=20<20231013123748.6b200f79@xps-13>;
	b=exXwV//RfGFsVbP5ZeA1GlLZzOH/AfICIT+kQpWRDZ9D0AV4e13kisxn50UFvQ/Vx
	 mylpyZI7N+XLy0ylgJ3ZIjHtwOa4xqu83JsLHB5Vdr7ckjqnC7UXGD1c5PzdMdjpG+
	 tRnx45gRdLaPZMxfPsGvty1yDE3Mtp+cYELJEaBuW+EZUOifbgpQfgJYZr1MP9NS1c
	 M66GJwbrKXS9FmddOuowhvpnVybFF1Y1mzm7qu4j3pcU3YuP0A0eWgMvgOCzRsXn9k
	 gtwTApjoYCyJ/XfJF8oOYRd78/EiYsJgxYKhzPdO+Gi2Mi0xyetkqbyR7dhsUcfN6M
	 3sVbYA02l+B+Q==
Message-ID: <6882ade2-876b-01d6-c6cb-e7fab329b081@katalix.com>
Date: Fri, 13 Oct 2023 12:54:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231012193410.3d1812cf@xps-13>
 <18b72fdb-d24a-a416-ffab-3a15b281a6e0@katalix.com>
 <20231013123748.6b200f79@xps-13>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: Ethernet issue on imx6
In-Reply-To: <20231013123748.6b200f79@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/10/2023 11:37, Miquel Raynal wrote:
> Hi James,
>
> jchapman@katalix.com wrote on Fri, 13 Oct 2023 09:50:49 +0100:
>
>> On 12/10/2023 18:34, Miquel Raynal wrote:
>>> Hello,
>>>
>>> I've been scratching my foreheads for weeks on a strange imx6
>>> network issue, I need help to go further, as I feel a bit clueless now.
>>>
>>> Here is my setup :
>>> - Custom imx6q board
>>> - Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
>>> - Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavior
>>> - The MAC (fec driver) is connected to a Micrel 9031 PHY
>>> - The PHY is connected to the link partner through an industrial cable
>>> - Testing 100BASE-T (link is stable)
>>>
>>> The RGMII-ID timings are probably not totally optimal but offer rather
>>> good performance. In UDP with iperf3:
>>> * Downlink (host to the board) runs at full speed with 0% drop
>>> * Uplink (board to host) runs at full speed with <1% drop
>>>
>>> However, if I ever try to limit the bandwidth in uplink (only), the drop
>>> rate rises significantly, up to 30%:
>>>
>>> //192.168.1.1 is my host, so the below lines are from the board:
>>> # iperf3 -c 192.168.1.1 -u -b100M
>>> [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/82603 (0.57%)  receiver
>>> # iperf3 -c 192.168.1.1 -u -b90M
>>> [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163/77688 (16%)  receiver
>>> # iperf3 -c 192.168.1.1 -u -b80M
>>> [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937/69055 (30%)  receiver
>>>
>>> One direct consequence, I believe, is that tcp transfers quickly stall
>>> or run at an insanely low speed (~40kiB/s).
>>>
>>> I've tried to disable all the hardware offloading reported by ethtool
>>> with no additional success.
>>>
>>> Last but not least, I observe another very strange behavior: when I
>>> perform an uplink transfer at a "reduced" speed (80Mbps or below), as
>>> said above, I observe a ~30% drop rate. But if I run a full speed UDP
>>> transfer in downlink at the same time, the drop rate lowers to ~3-4%.
>>> See below, this is an iperf server on my host receiving UDP traffic from
>>> my board. After 5 seconds I start a full speed UDP transfer from the
>>> host to the board:
>>>
>>> [  5] local 192.168.1.1 port 5201 connected to 192.168.1.2 port 57216
>>> [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
>>> [  5]   0.00-1.00   sec  6.29 MBytes  52.7 Mbits/sec  0.152 ms  2065/6617 (31%)
>>> [  5]   1.00-2.00   sec  6.50 MBytes  54.6 Mbits/sec  0.118 ms  2199/6908 (32%)
>>> [  5]   2.00-3.00   sec  6.64 MBytes  55.7 Mbits/sec  0.123 ms  2099/6904 (30%)
>>> [  5]   3.00-4.00   sec  6.58 MBytes  55.2 Mbits/sec  0.091 ms  2141/6905 (31%)
>>> [  5]   4.00-5.00   sec  6.59 MBytes  55.3 Mbits/sec  0.092 ms  2134/6907 (31%)
>>> [  5]   5.00-6.00   sec  8.36 MBytes  70.1 Mbits/sec  0.088 ms  853/6904 (12%)
>>> [  5]   6.00-7.00   sec  9.14 MBytes  76.7 Mbits/sec  0.085 ms  281/6901 (4.1%)
>>> [  5]   7.00-8.00   sec  9.19 MBytes  77.1 Mbits/sec  0.147 ms  255/6911 (3.7%)
>>> [  5]   8.00-9.00   sec  9.22 MBytes  77.3 Mbits/sec  0.160 ms  233/6907 (3.4%)
>>> [  5]   9.00-10.00  sec  9.25 MBytes  77.6 Mbits/sec  0.129 ms  211/6906 (3.1%)
>>> [  5]  10.00-10.04  sec   392 KBytes  76.9 Mbits/sec  0.113 ms  11/288 (3.8%)
>>>
>>> If the downlink transfer is not at full speed, I don't observe any
>>> difference.
>>>
>>> I've commented out the runtime_pm callbacks in the fec driver, but
>>> nothing changed.
>>>
>>> Any hint or idea will be highly appreciated!
>>>
>>> Thanks a lot,
>>> Miquèl
>>>   
>> Check your board's interrupt configuration. At high data rates, NAPI may mask interrupt delivery/routing issues since NAPI keeps interrupts disabled longer. Also, if the CPU has hardware interrupt coalescing features enabled, these may not play well with NAPI.
>>
>> Low level irq configuration is quite complex (and flexible) in devices like iMX. It may be further complicated by some of it being done by the bootloader. So perhaps experiment with the fec driver's NAPI weight and debug the irq handler first to test whether interrupt handling is working as expected on your board before digging in the low level, board-specific irq setup code.
> Thanks a lot for looking into this. I've tried to play a little bit
> with the NAPI budget but saw no difference at all in the results. With
> this new information in mind, do you think I should look deeper?
>
> Thanks,
> Miquèl

I think so. I was just suggesting tweaking variables in your setup which 
might change interrupt characteristics while monitoring interrupt 
handlers in order that you can be sure your device interrupts work as 
expected. Some instrumentation in the driver's interrupt and NAPI 
handlers may help. Perhaps plotting various counts (rx/tx interrupts, 
rx/tx interrupt on/off changes, NAPI schedules etc) at different packet 
rates might show where things start going wrong and could help to 
identify the root cause.

James



