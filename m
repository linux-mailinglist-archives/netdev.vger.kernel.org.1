Return-Path: <netdev+bounces-22662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21A7689AF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390F22815A4
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D82624;
	Mon, 31 Jul 2023 01:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F556362
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:50:03 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9917E57
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 18:50:00 -0700 (PDT)
X-QQ-mid:Yeas3t1690768061t101t62178
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.251.0])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11671592293063546353
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk> <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com> <be6b8423-0045-49bf-acfc-92ffa9028316@lunn.ch>
In-Reply-To: <be6b8423-0045-49bf-acfc-92ffa9028316@lunn.ch>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Mon, 31 Jul 2023 09:47:40 +0800
Message-ID: <059001d9c350$fd8a2770$f89e7650$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK8CRWbPqwHK0atUAh0aDJIDPJCjsQIjPZH8Aekq2cABnK8P4a5OoRQg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Friday, July 28, 2023 6:24 PM, : Andrew Lunn wrote:
> > There is a question about I2C MII read ops. I see that PHY in SFP-RJ45 module
> > is read by i2c_mii_read_default_c22(), but it limits the msgs[0].len=1.
> >
> > A description in  the SFP-RJ45 datasheet shows:
> 
> Please give a link to this document.

https://www.alldatasheet.com/datasheet-pdf/pdf/465165/AVAGO/ABCU-5710RZ.html

> 
> The problem with copper PHYs embedded inside SFPs is that there is no
> standardised protocol to talk to them. Each PHY vendor does their own
> thing. At the moment, two different protocols are supported, ROLLBALL
> and the default protocol. It might be another protocol needs to be
> added to support the SFP you are testing with. So we need to see the
> protocol specification.
> 
>       Andrew
> 


