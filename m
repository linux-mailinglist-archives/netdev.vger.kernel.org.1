Return-Path: <netdev+bounces-30569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53078813C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8055B281715
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D81FD3;
	Fri, 25 Aug 2023 07:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F21FC9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:49:26 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF12109
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:49:13 -0700 (PDT)
X-QQ-mid:Yeas48t1692949617t909t24556
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.177.96.73])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16920672897235981624
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<Jose.Abreu@synopsys.com>,
	<rmk+kernel@armlinux.org.uk>,
	<mengyuanlou@net-swift.com>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com> <20230823061935.415804-8-jiawenwu@trustnetic.com> <7d999689-cea9-4e66-8807-a04eb9ad4cb5@lunn.ch> <039101d9d62e$c97b21f0$5c7165d0$@trustnetic.com> <8b142b43-65fa-465b-aa41-bd2200e71c63@lunn.ch>
In-Reply-To: <8b142b43-65fa-465b-aa41-bd2200e71c63@lunn.ch>
Subject: RE: [PATCH net-next v3 7/8] net: txgbe: support copper NIC with external PHY
Date: Fri, 25 Aug 2023 15:46:56 +0800
Message-ID: <042201d9d728$52af63b0$f80e2b10$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLjS4V8x90Nevlz1qgYPpmCd0AswgJrx3vJAVCl4+cBaEK6jQGoDBvmrbE1ErA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, August 24, 2023 9:02 PM, Andrew Lunn wrote:
> On Thu, Aug 24, 2023 at 10:00:41AM +0800, Jiawen Wu wrote:
> > On Wednesday, August 23, 2023 11:36 PM, Andrew Lunn wrote:
> > > > +static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
> > > > +			  int devnum, int regnum)
> > >
> > > There is a general pattern to use the postfix _c45 for the method that
> > > implements C45 access. Not a must, just a nice to have.
> > >
> > > Does this bus master not support C22 at all?
> >
> > It supports C22.
> 
> I was looking at how the two MDIO bus master implementations
> differ. Once difference is a register write to set C22/C45, which this
> code does not have. The second change appears to be a clock setting.
> 
> If you added C22, do the two become more similar? Should this actually
> be one implementation in the library?

Yes, it could be moved to libwx for txgbe/ngbe. I will send a patch later to implement it.


