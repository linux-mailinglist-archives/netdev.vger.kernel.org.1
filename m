Return-Path: <netdev+bounces-20640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F0D76050B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAB1C20D3B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26915C2;
	Tue, 25 Jul 2023 02:06:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BB7C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:06:32 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805410F0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:06:27 -0700 (PDT)
X-QQ-mid:Yeas52t1690250706t815t09035
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.134.159])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 697003431169480465
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
In-Reply-To: <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Tue, 25 Jul 2023 10:05:05 +0800
Message-ID: <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK+uvcotIA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Monday, July 24, 2023 6:35 PM, Russell King (Oracle) wrote:
> On Mon, Jul 24, 2023 at 06:23:38PM +0800, Jiawen Wu wrote:
> > Wangxun NICs support the connection with SFP to RJ45 module. In this case,
> > PCS need to be configured in SGMII mode.
> >
> > Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores
> > Ethernet PCS (version 3.20a) and custom design manual, do the following
> > configuration when the interface mode is SGMII.
> >
> > 1. program VR_MII_AN_CTRL bit(3) [TX_CONFIG] = 1b (PHY side SGMII)
> > 2. program VR_MII_AN_CTRL bit(8) [MII_CTRL] = 1b (8-bit MII)
> > 3. program VR_MII_DIG_CTRL1 bit(0) [PHY_MODE_CTRL] = 1b
> 
> I'm confused by "PHY side SGMII" - what does this mean for the
> transmitted 16-bit configuration word? Does it mean that _this_ side
> is acting as if it were a PHY?

I'm not sure, because the datasheet doesn't explicitly describe it. In this
case, the PHY is integrated in the SFP to RJ45 module. From my point of
view, TX control occurs on the PHY side. So program it as PHY side SGMII.


