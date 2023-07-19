Return-Path: <netdev+bounces-18891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8D758FC4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233261C20C8C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FCD305;
	Wed, 19 Jul 2023 07:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BEC2EF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:59:17 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727BBE
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:59:11 -0700 (PDT)
X-QQ-mid:Yeas5t1689753451t029t02820
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 865973920268242761
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: "'Simon Horman'" <simon.horman@corigine.com>,
	<kabel@kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk> <043501d9b580$31798870$946c9950$@trustnetic.com> <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com> <ZLUymspsQlJL1k8n@shell.armlinux.org.uk> <013701d9b957$fc66f740$f534e5c0$@trustnetic.com> <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk> <013e01d9b95e$66c10350$344309f0$@trustnetic.com> <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk> <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com> <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk>
In-Reply-To: <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 19 Jul 2023 15:57:30 +0800
Message-ID: <01b401d9ba16$aacf75f0$006e61d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLXGYu6qrXURLC8+LIde3RBnYs88gIZTAmQAUw6K5UBY4WKqgKZAtVvAhlEpQQBv9f63QMJAHOFAhxWLLkCdPwazQGH0Mk4rSMO1hA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 19, 2023 2:51 PM, Russell King (Oracle) wrote:
> On Wed, Jul 19, 2023 at 10:29:38AM +0800, Jiawen Wu wrote:
> > [59697.591809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=6, val=c000
> > [59697.592811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=5, val=9a
> > [59697.593814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=2, val=2b
> > [59697.594817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=3, val=9ab
> > [59697.595811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=2, val=2b
> > [59697.596811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=3, val=9ab
> > [59697.597811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=2, val=141
> > [59697.598809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=3, val=dab
> > [59697.599809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=2, val=2b
> > [59697.600810] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3, val=9ab
> > [59697.601815] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1e, regnum=8, val=0
> > [59697.602930] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=8, val=fffe
> > [59697.608811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=d00d, val=680b
> > [59697.609823] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c050, val=7e
> > [59697.610814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c011, val=2
> > [59697.611817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c012, val=200
> > [59697.611820] mv88x3310 txgbe-400:00: Firmware version 0.2.2.0
> > [59697.612817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
> 
> So here we can see the PHY is already in low-power mode, so presumably
> it's configured to do that from power-up?
> 
> > [59697.612820] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08c, val=9600
> > [59697.613819] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f08a, val=cd9a
> > [59697.613822] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08a, val=d9a
> > [59697.614818] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=1, val=9ab
> > [59697.615816] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=8, val=9701
> > [59697.616817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=b, val=1a4
> > [59697.617814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=14, val=e
> > [59697.618809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=15, val=3
> > [59697.619811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3c, val=0
> > [59697.619831] mv88x3310 txgbe-400:00: attached PHY driver (mii_bus:phy_addr=txgbe-400:00, irq=POLL)
> 
> The following is where we attempt to power up the PHY:
> 
> > [59697.830169] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
> > [59697.830179] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f001, val=3
> 
> The above is our attempt to clear the low power bit.
> 
> > [59697.830926] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
> 
> According to this read though (which is in get_mactype), the write
> didn't take effect.
> 
> If you place a delay of 1ms after phy_clear_bits_mmd() in
> mv3310_power_up(), does it then work?

Yes, I just experimented, it works well.



