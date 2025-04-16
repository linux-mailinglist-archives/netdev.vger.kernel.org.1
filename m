Return-Path: <netdev+bounces-183132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D298A8B058
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279983A6B4B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D51F4611;
	Wed, 16 Apr 2025 06:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC91DDC1B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785021; cv=none; b=Izckh1pPP35oIc2MLFokUc4d0pgeiA+vCRSFWB2oAtlcw84rWU23TH47IENz/uaF0oDsViODshv2qJhHKluAYGweiLIclnCXXYpgHA0d50Y5sVwoFdzsaXjd5e6DyFudzMb1dIzlO/c1ujkRUC7jm9PoHJ58rPIlBXlWqw1HDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785021; c=relaxed/simple;
	bh=ZqdzE6jcdUlT/wssoNNXSSUK8WF8u3k5ACj1O/DNqf4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgnJ6GvHn2cj3tZ8y0OvnmhCi5J5bZY18RKFQjWcR2+fPWY/2yNDezxn4/Gmv5ra3MhKNP744G1FiFcJZBIS6Biin0yaKZwaqNTsFocnsZ4Yk6EHVzP2YWIoW854UkjTJKUum8ArX8icdtb0XINPYnl+IKaZaxDj+FRqUVdsor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1744784979t346t13655
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.107.143])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7490138915053721233
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
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>	<20250414091022.383328-2-jiawenwu@trustnetic.com> <20250415173329.27f83c52@kernel.org>
In-Reply-To: <20250415173329.27f83c52@kernel.org>
Subject: RE: [PATCH net-next v2 1/2] net: txgbe: Support to set UDP tunnel port
Date: Wed, 16 Apr 2025 14:29:38 +0800
Message-ID: <00f201dbae98$edc58b10$c950a130$@trustnetic.com>
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
Thread-Index: AQGLV3gqB/5cQyoCfnN+NjDlZ7u1HwJyCwCfA5LZR8a0Fg11oA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NeHZ50d3l/WZpqaK9Dmg874WIMXKpMKBUaIwC8If4x2IGdEaiFBBoYbl
	Dj0YhrPLRo/H7LSs5q4U+TnZdnA90npkk2N6Z1h2yQjwJebJ9C5EZ/ydH1brkkX/eYiMSm0
	VwM7fAKDaLUXPNTLzvD8PMpbhjeQntagUrbWzawX0Cxse1PCKAh6cw1WFmNrIT9KdcxNGfn
	BStAFrdkuQwiiAzxOR0FxjqVHLW8gyzx3zeqP6c9T+dfRDwDlCvQSlBp+lJB/QoINyb6P4V
	1wYjvhuzD04kLrWFzOiIDzyR0hcAXUc7sEFAq74BIMcL0QUeRDxBfcmkO5aGKx/FarUEm2F
	bcK1tWCF2MACnZlp6FbEfZDpmULYQ0fraBdmKnLVveSI2oy1vRS8+31/hB24AqBU11zfgHU
	JQ5ABS+PQi6DkUWQ5QcZLQUw2T8R2Xfp+MhYVKw1cVkyEZTrvGud2KdRe8whbNDtELf9p+y
	rhAJYgBr3qPZYnhFtwzco1x+n9Njlz9LRrlruKdWlCuaZWhMksVOUtV8euEzIbhMZp8Y1qg
	8gBY5R3ZMBUcW2lkwnAJ+iDCLV/vtAsmeazdpUmWomXt6EYXVFtelxgp1duxSWZXRsMo45z
	FcnEFk5eUi4CCgY/e1r3GLQdWXHyuO1UiJ5E9TQzuCoDlnucxBJL2Jq6EqlckVMAUjKfHWa
	SF6kTVRujxMncNXPFaNrC3IafIPyr0aSoJXY4N9hNJgueMiSJ2ylQt7F4vJMrjms54kSHAW
	qklFEIOllZ2gFesvGVCTaw/gNpWiw2QbDK0VVS55+u1Y7Nb0GhhoycRaQnXrAjLBxgXpetx
	d2udmPAuSBxbb5VZXnlU2Nlw+dseWSZBKmhLEEejrrqOmjiPZuXfHT5vo6Y0Fm52IRpsQUr
	08/8deIHeCwN84YEDbvlZhW+bt1TdzqexJk2yO/uREJSSukc9XhCIpNMZyaq0VF0qX0m0uD
	1LRrVrnp1tDi3fQ8DN+PutOijfKqYoTec4a7S1h5QRar0cK7e8h13I4PamGESxGn7bM4hzs
	izoy5P7x6WzmnTVw6JOVFfZ2dA46U=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Apr 16, 2025 8:33 AM, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 17:10:21 +0800 Jiawen Wu wrote:
> > +	udp_tunnel_nic_reset_ntf(netdev);
> 
> you issue the reset here, without clearing the ports...
> 
> >  	return 0;
> >
> >  err_free_irq:
> > @@ -537,6 +540,87 @@ void txgbe_do_reset(struct net_device *netdev)
> >  		txgbe_reset(wx);
> >  }
> >
> > +static int txgbe_udp_tunnel_set(struct net_device *dev, unsigned int table,
> > +				unsigned int entry, struct udp_tunnel_info *ti)
> > +{
> > +	struct wx *wx = netdev_priv(dev);
> > +	struct txgbe *txgbe = wx->priv;
> > +
> > +	switch (ti->type) {
> > +	case UDP_TUNNEL_TYPE_VXLAN:
> > +		if (txgbe->vxlan_port == ti->port)
> 
> then you ignore the set if the port is already the same.
> 
> Why do you need the udp_tunnel_nic_reset_ntf() call?
> Read the kdoc on that function.
> It doesn't seem like your NIC loses the state.
> 
> > +			break;
> > +
> > +		if (txgbe->vxlan_port) {
> > +			wx_err(wx, "VXLAN port %d set, not adding port %d\n",
> > +			       txgbe->vxlan_port, ti->port);
> > +			return -EINVAL;
> > +		}
> 
> Why...
> 
> > +		txgbe->vxlan_port = ti->port;
> > +		wr32(wx, TXGBE_CFG_VXLAN, ntohs(ti->port));
> > +		break;
> 
> > +static const struct udp_tunnel_nic_info txgbe_udp_tunnels = {
> > +	.set_port	= txgbe_udp_tunnel_set,
> > +	.unset_port	= txgbe_udp_tunnel_unset,
> > +	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
> 
> Where do the callbacks sleep?

I now understand how the "reset" works, it will be changed to
UDP_TUNNEL_NIC_INFO_OPEN_ONLY, and use .sync_table to simplify the flow.




