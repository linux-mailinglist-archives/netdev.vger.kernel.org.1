Return-Path: <netdev+bounces-50410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F37F5AF3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098C61C20961
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB12031F;
	Thu, 23 Nov 2023 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394F41A4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 01:23:05 -0800 (PST)
X-QQ-mid:Yeas7t1700731238t090t49816
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.129.197])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5760696767292244872
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com> <20231122102226.986265-2-jiawenwu@trustnetic.com> <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
In-Reply-To: <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
Subject: RE: [PATCH net-next 1/5] net: wangxun: add flow control support
Date: Thu, 23 Nov 2023 17:20:37 +0800
Message-ID: <00f701da1dee$51bfb0b0$f53f1210$@trustnetic.com>
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
Content-Language: zh-cn
Thread-Index: AQIZ7m4FfqhO6yXRbjtvxmXj2jKlSQLU6mPhAVK4luWv5sA6cA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

On Thursday, November 23, 2023 12:15 AM, Andrew Lunn wrote:
> > +	/* Calculate max LAN frame size */
> > +	link = dev->mtu + ETH_HLEN + ETH_FCS_LEN + WX_ETH_FRAMING;
> > +	tc = link;
> > +
> > +	/* Calculate delay value for device */
> > +	dv_id = WX_DV(link, tc);
> 
> That looks odd. tc == link. So why pass both? Or is it a typo?

This is because I've temporarily removed the FCOE related code,
as something to support later. So now tc == link, which looks odd.
 


