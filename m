Return-Path: <netdev+bounces-30191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E535786505
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3F21C20D75
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399517D0;
	Thu, 24 Aug 2023 02:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C477F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:03:43 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CAE59
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:03:39 -0700 (PDT)
X-QQ-mid:Yeas50t1692842443t179t49387
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.177.96.73])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3700357475013354537
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
References: <20230823061935.415804-1-jiawenwu@trustnetic.com> <20230823061935.415804-8-jiawenwu@trustnetic.com> <7d999689-cea9-4e66-8807-a04eb9ad4cb5@lunn.ch>
In-Reply-To: <7d999689-cea9-4e66-8807-a04eb9ad4cb5@lunn.ch>
Subject: RE: [PATCH net-next v3 7/8] net: txgbe: support copper NIC with external PHY
Date: Thu, 24 Aug 2023 10:00:41 +0800
Message-ID: <039101d9d62e$c97b21f0$5c7165d0$@trustnetic.com>
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
Thread-Index: AQLjS4V8x90Nevlz1qgYPpmCd0AswgJrx3vJAVCl4+etx+K/8A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, August 23, 2023 11:36 PM, Andrew Lunn wrote:
> > +static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
> > +			  int devnum, int regnum)
> 
> There is a general pattern to use the postfix _c45 for the method that
> implements C45 access. Not a must, just a nice to have.
> 
> Does this bus master not support C22 at all?

It supports C22.


