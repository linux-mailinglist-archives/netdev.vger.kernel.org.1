Return-Path: <netdev+bounces-183591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B436A911BC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 04:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445C8441E4F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02B1AC882;
	Thu, 17 Apr 2025 02:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6620330
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857680; cv=none; b=XOuQuwgDAPqhJ9gUp2VZLjdbwqXeAX44R1U9q9q9QTEadsur0J0G6aamL4vIlreKaESJLEJtx/gerHOWyXbqMEwrY7+VtXfTuwBJFks/UiijG5y2oG4rLIRZZ8775XCPNFuwwCxzTCQxkCsGDYee+ADKvMbuVKmR1pxGoRdJIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857680; c=relaxed/simple;
	bh=4dSHKMhJP3V7b8BkEzdZu9o4Xh1naOPPFQjpsHv6u8Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5cLC6UttmFh5JzJmWYEmomezyighCQpckuMbvx4q6IunrXDxOtJPNxedoPmApGRKe76pDJUsbmOMK+Y6greJ26IGHOBnenQwblnZWpheTR1QUdBTo5wPohE3P2i17IJZDQkGVZTdga75lpwz78aWfgGQfGhCMVkCfeBZPNfK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1744857637t376t63855
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.107.143])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9468956657044576948
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
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>	<20250414091022.383328-2-jiawenwu@trustnetic.com> <20250415173329.27f83c52@kernel.org> <00f201dbae98$edc58b10$c950a130$@trustnetic.com>
In-Reply-To: <00f201dbae98$edc58b10$c950a130$@trustnetic.com>
Subject: RE: [PATCH net-next v2 1/2] net: txgbe: Support to set UDP tunnel port
Date: Thu, 17 Apr 2025 10:40:36 +0800
Message-ID: <013901dbaf42$194fbcc0$4bef3640$@trustnetic.com>
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
Thread-Index: AQGLV3gqB/5cQyoCfnN+NjDlZ7u1HwJyCwCfA5LZR8YCDoK887QGHPmQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MACXe2l6e7j93G5WIncS7KvUCQTd3LsKBcv6bF17BgAJi4w7BX558HYQ
	wXTuoNdRk+8/mYeODk5zQnKwqIZ3Zyhy0nl5NdVVutTWV2DlDU4SelmPtYAdoy2FNh75TUV
	MjBQQ7/rNVGvDFamW7indQ0ocfAu33evVOmlCFdcTZ99B3YK46Aqy4IcLTcyVzaOQ743WiG
	vyVi+XpBEfS7Vv/scBgXRMaB4m211Tfjfs6Ne6NDEqA0AjT3YOGIIydBV6aXYLYj+a1yv0V
	5nRAG05Y55BDMWLWQC4JRdlWJIh7Bih3b/8snidVH8NMTVyzNMqgc/VZYEiBaup53ecAvNg
	TVMWAaOyBv/J4mh8X/02QmUaNTaXzIHatrck/+oX6C1o3QgX7VWXISlkMW8N9w0QvhTrtW0
	Qm45J2+GrTqNjIvqBAv1h6xmMMFnZdr290DCL7ZjjaPkeb9y+UpwasTY7xYa4aRlcgaOb86
	pHsW+LhcBff1uoXFNCogqRyh33bXB8WhV9+hAuOGSqihmkPWr9ikDNUEUYHWKltttocmrv+
	HDTAV9E5Wh51NS6vKuHHYPvJlLTO3RsteIg7YXV41K0C5QAmM8ZMv1V+9Ochu4MvK4Z60cJ
	/PvN9lA25hTwsOiFEkfiddNrtUzx7oPhHueI//QXzybr+jJ5xe6vFcisN7R4/AeIYND/Zs8
	bjolvkkJ5csj93zjAbfPCOfucB53L1NSbgu8PUghF/zApYxkK6YAXM22PcUPROTKoPy7yCx
	FrLkIrMTz/buahJALxAxnF7pzZ0od9cagljucEWLRKqoWK1afjYf2cgSlCls6LQyoq5HERL
	6U63XSXCmTFk8cg/5scdgT0S2vbDMabU5H+7a3+tiOcd0Z6sVQ2jtl8WX8JaFmqKf+sGGxX
	JGtMJXbbkz0MfTg7XJOZM3uBertOw7TO3lzwFGSJEsPCAQcx0D+fbi9i90IXR9kYykog1Ja
	8cJ/7XpsVVW6jOov8lEH8YBhLtngC22WQVxeLiqos7NNXo1R+usJVNcXdXdciT/Iigfw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Apr 16, 2025 2:30 PM, Jiawen Wu wrote:
> On Wed, Apr 16, 2025 8:33 AM, Jakub Kicinski wrote:
> > On Mon, 14 Apr 2025 17:10:21 +0800 Jiawen Wu wrote:
> > > +	udp_tunnel_nic_reset_ntf(netdev);
> >
> > you issue the reset here, without clearing the ports...
> >
> > >  	return 0;
> > >
> > >  err_free_irq:
> > > @@ -537,6 +540,87 @@ void txgbe_do_reset(struct net_device *netdev)
> > >  		txgbe_reset(wx);
> > >  }
> > >
> > > +static int txgbe_udp_tunnel_set(struct net_device *dev, unsigned int table,
> > > +				unsigned int entry, struct udp_tunnel_info *ti)
> > > +{
> > > +	struct wx *wx = netdev_priv(dev);
> > > +	struct txgbe *txgbe = wx->priv;
> > > +
> > > +	switch (ti->type) {
> > > +	case UDP_TUNNEL_TYPE_VXLAN:
> > > +		if (txgbe->vxlan_port == ti->port)
> >
> > then you ignore the set if the port is already the same.
> >
> > Why do you need the udp_tunnel_nic_reset_ntf() call?
> > Read the kdoc on that function.
> > It doesn't seem like your NIC loses the state.
> >
> > > +			break;
> > > +
> > > +		if (txgbe->vxlan_port) {
> > > +			wx_err(wx, "VXLAN port %d set, not adding port %d\n",
> > > +			       txgbe->vxlan_port, ti->port);
> > > +			return -EINVAL;
> > > +		}
> >
> > Why...
> >
> > > +		txgbe->vxlan_port = ti->port;
> > > +		wr32(wx, TXGBE_CFG_VXLAN, ntohs(ti->port));
> > > +		break;
> >
> > > +static const struct udp_tunnel_nic_info txgbe_udp_tunnels = {
> > > +	.set_port	= txgbe_udp_tunnel_set,
> > > +	.unset_port	= txgbe_udp_tunnel_unset,
> > > +	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
> >
> > Where do the callbacks sleep?
> 
> I now understand how the "reset" works, it will be changed to
> UDP_TUNNEL_NIC_INFO_OPEN_ONLY, and use .sync_table to simplify the flow.

But I have a question.

There are two ethernet chips on the board with four ports eth0~eth3,
they all use txgbe driver. When I add a VXLAN port for eth0, in fact, all
4 devices are configured. So I can't add another different VXLAN port
for eth1~eth3. Is this a fixed behavior of the kernel?



