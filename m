Return-Path: <netdev+bounces-40459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A117C7713
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CD71C20B41
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8113B2A2;
	Thu, 12 Oct 2023 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U4CTSiQL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400313AC13
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:39:28 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A5C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nbDWSCWMQDBM8YEqEpV7yx+D9vi8yZKb7eWwa6Zt9dc=; b=U4CTSiQLpxfcpny2znkrH/PGma
	MFZ2OrKuIREzozJY+UQWeGDWPkZC+/9IrHdrh/S6tj9xsSkjqxRRyi6rW/CMXH5MSZWX7ELlyIlLD
	aBXnuqx8IzJlkwtx80f9BVxTDo3R82YOejD8qQ0V7W/af6PykkpHT0b2Tdk/MCr3H4auuiu5Fv3TJ
	EwkXOxnvuR/n0WmvbROc49JLtRFSY7qg07O/LP8wfOb41rDeUtagkyqD0VD3e0sYGfvISGqrkmtJr
	DogwiOn2JI9mIj0zsQZKgls/cYv3hU3Qqqa1t2Fgkz+gOpi3gRQXBVGBkV2Wov5XvzPn5JzA4Bmvq
	e1udMcEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qr1Wb-0005QV-1f;
	Thu, 12 Oct 2023 20:39:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qr1WZ-0001dF-IF; Thu, 12 Oct 2023 20:39:11 +0100
Date: Thu, 12 Oct 2023 20:39:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
References: <20231012193410.3d1812cf@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012193410.3d1812cf@xps-13>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 07:34:10PM +0200, Miquel Raynal wrote:
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

"industrial cable" ?

> - Testing 100BASE-T (link is stable)

Would that be full or half duplex?

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

My setup:

i.MX6DL silicon rev 1.3
Atheros AR8035 PHY
6.3.0+ (no significant changes to fec_main.c)
Link, being BASE-T, is standard RJ45.

Connectivity is via a bridge device (sorry, can't change that as it would
be too disruptive, as this is my Internet router!)

Running at 1000BASE-T (FD):
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.01  sec   114 MBytes  95.4 Mbits/sec  0.030 ms  0/82363 (0%)  receiver
[  5]   0.00-10.00  sec   107 MBytes  90.0 Mbits/sec  0.103 ms  0/77691 (0%)  receiver
[  5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.101 ms  0/69060 (0%)  receiver

Running at 100BASE-Tx (FD):
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.01  sec   114 MBytes  95.4 Mbits/sec  0.008 ms  0/82436 (0%)  receiver
[  5]   0.00-10.00  sec   107 MBytes  90.0 Mbits/sec  0.088 ms  0/77692 (0%)  receiver
[  5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.108 ms  0/69058 (0%)  receiver

Running at 100bASE-Tx (HD):
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.01  sec   114 MBytes  95.3 Mbits/sec  0.056 ms  0/82304 (0%)  receiver
[  5]   0.00-10.00  sec   107 MBytes  90.0 Mbits/sec  0.101 ms  1/77691 (0.0013%)  receiver
[  5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.105 ms  0/69058 (0%)  receiver

So I'm afraid I don't see your issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

