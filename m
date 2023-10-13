Return-Path: <netdev+bounces-40634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B537B7C8145
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C30F1C20AA9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372421095A;
	Fri, 13 Oct 2023 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="KGO0qToN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20A63A9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:00:32 +0000 (UTC)
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 02:00:29 PDT
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 571881712
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:00:28 -0700 (PDT)
Received: from [IPV6:2a02:8010:6359:1:4d3:e723:472d:b106] (unknown [IPv6:2a02:8010:6359:1:4d3:e723:472d:b106])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 4EFDA7D8DC;
	Fri, 13 Oct 2023 09:50:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1697187050; bh=uCzz5lm5PxLtEU5N9Y+so6PfL0yDpuDNKg/sgyp1WUw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<18b72fdb-d24a-a416-ffab-3a15b281a6e0@katalix.com>|
	 Date:=20Fri,=2013=20Oct=202023=2009:50:49=20+0100|MIME-Version:=20
	 1.0|To:=20Miquel=20Raynal=20<miquel.raynal@bootlin.com>,=20Wei=20F
	 ang=20<wei.fang@nxp.com>,=0D=0A=20Shenwei=20Wang=20<shenwei.wang@n
	 xp.com>,=20Clark=20Wang=20<xiaoning.wang@nxp.com>,=0D=0A=20Russell
	 =20King=20<linux@armlinux.org.uk>|Cc:=20davem@davemloft.net,=20edu
	 mazet@google.com,=20kuba@kernel.org,=0D=0A=20pabeni@redhat.com,=20
	 linux-imx@nxp.com,=20netdev@vger.kernel.org,=0D=0A=20Thomas=20Peta
	 zzoni=20<thomas.petazzoni@bootlin.com>,=0D=0A=20Alexandre=20Bellon
	 i=20<alexandre.belloni@bootlin.com>,=0D=0A=20Maxime=20Chevallier=2
	 0<maxime.chevallier@bootlin.com>|References:=20<20231012193410.3d1
	 812cf@xps-13>|From:=20James=20Chapman=20<jchapman@katalix.com>|Sub
	 ject:=20Re:=20Ethernet=20issue=20on=20imx6|In-Reply-To:=20<2023101
	 2193410.3d1812cf@xps-13>;
	b=KGO0qToNwX042VCRmgrtX63cdr6uMGZh32CFx5QkImyYYFAhTcozdi43Se9u0lO58
	 DdtciduQsA/Dx6DnRprVYo86K3azGq2JzUW5vnYrHf7Yd7m1q3L1LyH+nQu4IbXRuF
	 8N+KX1Fnqnc3eXPK8Xv0bvOwO3mR6Xhyc5tkM6fp6t2ZH5mPu757vhHeot5FzmSLzT
	 4U5EN+DX/l55TDVW2jSygBg/9CCrvJ95JxB767mboVhnU+b0uyNdmUnomq9BMqZQTR
	 JdDMeXi+qdujORNnZLapw46XPeC77q8TbBJETpwzcySN3RSsqJ+kaVBQ2lHWV7EWFG
	 AuSzExrpTYr2Q==
Message-ID: <18b72fdb-d24a-a416-ffab-3a15b281a6e0@katalix.com>
Date: Fri, 13 Oct 2023 09:50:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King <linux@armlinux.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231012193410.3d1812cf@xps-13>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: Ethernet issue on imx6
In-Reply-To: <20231012193410.3d1812cf@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 18:34, Miquel Raynal wrote:
> Hello,
>
> I've been scratching my foreheads for weeks on a strange imx6
> network issue, I need help to go further, as I feel a bit clueless now.
>
> Here is my setup :
> - Custom imx6q board
> - Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
> - Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavior
> - The MAC (fec driver) is connected to a Micrel 9031 PHY
> - The PHY is connected to the link partner through an industrial cable
> - Testing 100BASE-T (link is stable)
>
> The RGMII-ID timings are probably not totally optimal but offer rather
> good performance. In UDP with iperf3:
> * Downlink (host to the board) runs at full speed with 0% drop
> * Uplink (board to host) runs at full speed with <1% drop
>
> However, if I ever try to limit the bandwidth in uplink (only), the drop
> rate rises significantly, up to 30%:
>
> //192.168.1.1 is my host, so the below lines are from the board:
> # iperf3 -c 192.168.1.1 -u -b100M
> [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/82603 (0.57%)  receiver
> # iperf3 -c 192.168.1.1 -u -b90M
> [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163/77688 (16%)  receiver
> # iperf3 -c 192.168.1.1 -u -b80M
> [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937/69055 (30%)  receiver
>
> One direct consequence, I believe, is that tcp transfers quickly stall
> or run at an insanely low speed (~40kiB/s).
>
> I've tried to disable all the hardware offloading reported by ethtool
> with no additional success.
>
> Last but not least, I observe another very strange behavior: when I
> perform an uplink transfer at a "reduced" speed (80Mbps or below), as
> said above, I observe a ~30% drop rate. But if I run a full speed UDP
> transfer in downlink at the same time, the drop rate lowers to ~3-4%.
> See below, this is an iperf server on my host receiving UDP traffic from
> my board. After 5 seconds I start a full speed UDP transfer from the
> host to the board:
>
> [  5] local 192.168.1.1 port 5201 connected to 192.168.1.2 port 57216
> [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> [  5]   0.00-1.00   sec  6.29 MBytes  52.7 Mbits/sec  0.152 ms  2065/6617 (31%)
> [  5]   1.00-2.00   sec  6.50 MBytes  54.6 Mbits/sec  0.118 ms  2199/6908 (32%)
> [  5]   2.00-3.00   sec  6.64 MBytes  55.7 Mbits/sec  0.123 ms  2099/6904 (30%)
> [  5]   3.00-4.00   sec  6.58 MBytes  55.2 Mbits/sec  0.091 ms  2141/6905 (31%)
> [  5]   4.00-5.00   sec  6.59 MBytes  55.3 Mbits/sec  0.092 ms  2134/6907 (31%)
> [  5]   5.00-6.00   sec  8.36 MBytes  70.1 Mbits/sec  0.088 ms  853/6904 (12%)
> [  5]   6.00-7.00   sec  9.14 MBytes  76.7 Mbits/sec  0.085 ms  281/6901 (4.1%)
> [  5]   7.00-8.00   sec  9.19 MBytes  77.1 Mbits/sec  0.147 ms  255/6911 (3.7%)
> [  5]   8.00-9.00   sec  9.22 MBytes  77.3 Mbits/sec  0.160 ms  233/6907 (3.4%)
> [  5]   9.00-10.00  sec  9.25 MBytes  77.6 Mbits/sec  0.129 ms  211/6906 (3.1%)
> [  5]  10.00-10.04  sec   392 KBytes  76.9 Mbits/sec  0.113 ms  11/288 (3.8%)
>
> If the downlink transfer is not at full speed, I don't observe any
> difference.
>
> I've commented out the runtime_pm callbacks in the fec driver, but
> nothing changed.
>
> Any hint or idea will be highly appreciated!
>
> Thanks a lot,
> Miquèl
>
Check your board's interrupt configuration. At high data rates, NAPI may 
mask interrupt delivery/routing issues since NAPI keeps interrupts 
disabled longer. Also, if the CPU has hardware interrupt coalescing 
features enabled, these may not play well with NAPI.

Low level irq configuration is quite complex (and flexible) in devices 
like iMX. It may be further complicated by some of it being done by the 
bootloader. So perhaps experiment with the fec driver's NAPI weight and 
debug the irq handler first to test whether interrupt handling is 
working as expected on your board before digging in the low level, 
board-specific irq setup code.

James



