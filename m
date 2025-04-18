Return-Path: <netdev+bounces-184024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD46A92F7E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF3B1B6350B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6D22A4C5;
	Fri, 18 Apr 2025 01:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FB21170D
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940683; cv=none; b=bTUu1FMQpoIxH8aOBj4AGWS3ZtWv1Mux0l55BeUqWWZDl/QoyAgxt1aYQj/0TuDaaEKLh9xG7boXsm4R6E5eFvmBnJVuExiiMRfjwBSJp2Z8hoz3U93YtA0Eonr7bEpUBpDj/ZcjEj1BZw987aPXRumKY2/lP/YXdFfcTWCGxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940683; c=relaxed/simple;
	bh=9IlkPH2fUvBZKEwJQ3y7t31XJ4HaQilSs13QrUDHaZA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RVIKtSNmrV43dHwGQ2HRL0Kmyp4IXKszjcPL6hjX7RI6FZqFpNcLmuziu/iiZbGsWl6x40zpPpe2cKZ+O3nt7CNv7jHCRi3HM3RQETEmHL9MSVC0L2jbtJeDzdXP2oz+ha/Jsumk6RZasq7R/w3d83CauNAluKKH8o9fX74n0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1744940641t555t29120
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.64.252])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8704088794086630319
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<dlemoal@kernel.org>,
	<jdamato@fastly.com>,
	<saikrishnag@marvell.com>,
	<vadim.fedorenko@linux.dev>,
	<przemyslaw.kitszel@intel.com>,
	<ecree.xilinx@gmail.com>,
	<rmk+kernel@armlinux.org.uk>,
	<mengyuanlou@net-swift.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>	<20250417080328.426554-2-jiawenwu@trustnetic.com> <20250417165736.15d212ec@kernel.org>
In-Reply-To: <20250417165736.15d212ec@kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: txgbe: Support to set UDP tunnel port
Date: Fri, 18 Apr 2025 09:44:00 +0800
Message-ID: <01fb01dbb003$5b920bd0$12b62370$@trustnetic.com>
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
Thread-Index: AQHTQdIaykwAzFMEiQKHJOM0w1kQSwKFSxn4AihjOFuzlBRD4A==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MXE8fio8Dejkt/LySmj1phzEbVyjgI+oLg0WS6+W1dt+AgmBJs+FRfbk
	qWL8gViVFPCVxH+ZFvlSaNQDx1jiBAONfoXUOVm3hsPOmRrW5u7WGdeS35njbWwUhqiflP8
	ZdjKuU0tg6TU9WSILlfkQIE8g8ITf60cb/KSV25zC3ZDdFr0uJEAfDU1pdYOB7oEO1Rzr/P
	StRTK1VqLTNfXCU3XBRIwxrJ8xol+Mgi+Ga4iOeyEl80PTvljPXiR4WpPxI87AHFYqFYyIz
	0lpmYu6on5gckXyhpt9aURGn8qPc4MX0xGWXQ9FhJ3y56D57cBUMRv0NsHv/RLCkqiAkdt6
	8YbnDTbTrJ2MonhKSS5N499KXjisEqemOs/8jTlR8PQoGfASjNc2M+z95gMZNexq4L+IbR0
	+ao6Synq40RAKv3tduvhIVA61UytXQPPBBgbRBlaAhwPL35ASqJyZhf3qBvb7DhV4mqXlbi
	DCQodFmkCym/fHFePi2nbo/c3Mlk0qih8/meaKx5utu1Hzo0ny/jLFoIPRzg040mCRrZ0bJ
	tl4ojaQbpVDPve4QqNg5cV31UmXtvVS4BnJimiG4gB3xDLui6qkp6gt3VrhgajvgzNoXnXI
	vOLDjFC8i/zIsrgUQPnaivZEXDEcr4dtRkoR0RRX+QwQ9gokf55ppTBLJIW3/erX1elVecU
	wbx65AzQgaB26L0t0Ir1Ep8xUNJSWm3bqwjb/EVDXxZ4SXKcvBuYpwVurJZg0qndfBlO6HT
	p99dFI2fHjTgbhhCdGw8iSf1KHjrBT4lJmJhcSokhZnuNwhVpRjsQpbGVyy/FwueMY6K/7I
	NiwAzVLydLKR9rrOD+8aJ7NdoClmUt/4zwIA54DZb92KB6wpjO03V5dY4RiDbVlRFYowJS3
	NPXUR6aNXL4AYwTOIGq7D4iuqvlxrNbMGp+dHN0/x3saFc7b7wH0itrrCTemJ9SrpawZdJ8
	dPYcmvNpe6Y0xxCQTFpED+Jd31mCFNfx+gu7qZWDZpfvv5QEoK3zAtooSvw9MqjHGnog=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, Apr 18, 2025 7:58 AM, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 16:03:27 +0800 Jiawen Wu wrote:
> > @@ -392,6 +393,8 @@ static int txgbe_open(struct net_device *netdev)
>                                  ^^^^^^^^^^
> >
> >  	txgbe_up_complete(wx);
> >
> > +	udp_tunnel_nic_reset_ntf(netdev);
>         ^^^^^^^^^^^^^^^^^^^^^^^^
> >  	return 0;
> 
> > +	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
> 
> Documentation says:
> 
>         /* Device only supports offloads when it's open, all ports
>          * will be removed before close and re-added after open.
>          */
>         UDP_TUNNEL_NIC_INFO_OPEN_ONLY   = BIT(1),
> 
> Are you sure you have to explicitly reset?

Yes. Stop device will reset hardware, which reset UDP port to the default value.
So it has to re-configure the ports.


