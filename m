Return-Path: <netdev+bounces-185939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146DA9C339
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82D19280E3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA09221FC9;
	Fri, 25 Apr 2025 09:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FA4C6E
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572954; cv=none; b=tj12xU12IZRY7kwp17RQIC33UNKCnauzWMi36SbQsJhmHyHWhNb9N7cpLbGWQyDqwRnGaPPcw2bvO1R+UuBNuxFm1J3icB6JohcpXkyEAFqLr7gedr5Cd+W4gBd8gZsRcydCdIcChn3neDqpal989WZFX9tdwTDrmPkXFUnCkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572954; c=relaxed/simple;
	bh=Y1YHoiRnwmzGqHoxlpRxrubBVFZcVY+7ZxeCzF5GFj4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7sJqZe2Hx/pZyq/F5AbRS7H1ADixruav068ifhJpiGzw8PFqG+TwaqV6GFlwUsuJVZSmRzgmj71bFbaLQx9MQR5k7lwLVnAWCOpiNKL/YBlyZzFXtGuIO7Ng2mW3IxnTXhF5BcwKpkXfUt1CP9YGI/5dVnmRVKAH66LfNKYOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1745572854t895t13832
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.188.93])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6676197562459129134
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<pabeni@redhat.com>,
	<kuba@kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<mengyuanlou@net-swift.com>
References: <6A2C0EF528DE9E00+20250425070942.4505-1-jiawenwu@trustnetic.com> <aAs79UDnd0sAyVAp@shell.armlinux.org.uk>
In-Reply-To: <aAs79UDnd0sAyVAp@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: libwx: fix to set pause param
Date: Fri, 25 Apr 2025 17:20:53 +0800
Message-ID: <046701dbb5c3$58335190$0899f4b0$@trustnetic.com>
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
Thread-Index: AQGrOoFUwnc6DDI8c12ntTx1ZV8pAAKAlWBrtAEL2XA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mc/7Da/97eYXJHrUjNgznHa34wB2pi0nPakF/Eig2F19ey5qiyD6sbRc
	Ox7V8I9aKkQB2Syi8dpd7zKRROaZVONuQUud7fWZyc/ztns5f27rT8PFvPq/4ekbREobV3y
	c3wV14O9tVqPtzwKh9ZMzll/JwhbPSRaPPXktU5G0II/g4pvD0nCV3DW+0ypOAIQNhpwOz1
	lhVOuc0FhFCvr2KozEQvdcIi82SXnadYKx5LuUyUH5FA+aS8cRk2ig6sTzsGs6P234TqOcN
	YHEM8Y6eyP2NS52Kk58C6yO3VOR8ONOXnnwK5fcKN4c9of1Bo62qnClBdYA0SaYcsg3Uqey
	ZxLrbc+i9dQ5uM8JOxnnFFjawZT3oKlDN+axX3fRYvThcGK1dIt2LdSoPfy5gJZQ2ZzLkQJ
	hKUZSkpjyGkZP5lt8hSMURkj0RQOYw4uN9oR9V+5H877g8Sm7Wtxx/RyWMsaoOX15ZsLajy
	+wTd3aJQ2u7+WisV7IJfUYQvnxblmcuznfc3zHvl3eVOE7gheMdSXlyjAYiL6gW88HCnKrU
	r/SQzDmBrIgs9MYJbYLrEqwPE38EXST2x00DLyiYq0MkqbPSctVQRj/Kn+jQtXyJ0p79wsV
	TQ7K+yPDezceB5WUbZxt+u9DnCTYT834j/2HnL3d5HIHPDTRG1VUobY2Eb4g0bdhHM1/BBo
	xzTWsOnYqsPKRsbNfv0u9W52vCUK1PLNQINbVE1AKWc5MT/+v2bKxldEhd3Sr+Y6S+GPDAi
	Bkv16pj0L1/ZgCaw9r7J7Bd6IHOiM725vNOYOJfoMd5Wt3fKUogvPQjvS5aY2610gziliXR
	77kkx3fGLFLmbpb+w5fC0vIB6xbm44mny60Ct0CTkkYUSp5mYe6GugFzaFbVmMBa09B5Hmo
	nVnv2xL085+mFkMstSLewLXWLA/gG7vOTICtvTTyAfywXQk64GhbxaHfDJYupfnmJhy7INA
	uU4xthu7Jlgt8WAJti13jluv0FFWWT9jDvwa12TO5U6c6jX29uo59kHB0kVszc+v9h8yaSD
	ArqN285BjPmXCR4MwZJpR7CwJT5xc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Apr 25, 2025 3:38 PM, Russell King (Oracle) wrote:
> On Fri, Apr 25, 2025 at 03:09:42PM +0800, Jiawen Wu wrote:
> > @@ -266,11 +266,20 @@ int wx_set_pauseparam(struct net_device *netdev,
> >  		      struct ethtool_pauseparam *pause)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> > +	int err;
> >
> >  	if (wx->mac.type == wx_mac_aml)
> >  		return -EOPNOTSUPP;
> >
> > -	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
> > +	err = phylink_ethtool_set_pauseparam(wx->phylink, pause);
> > +	if (err)
> > +		return err;
> > +
> > +	if (wx->fc.rx_pause != pause->rx_pause ||
> > +	    wx->fc.tx_pause != pause->tx_pause)
> > +		return wx_fc_enable(wx, pause->tx_pause, pause->rx_pause);
> 
> Why? phylink_ethtool_set_pauseparam() will cause mac_link_down() +
> mac_link_up() to be called with the new parameters.
> 
> One of the points of phylink is to stop drivers implementing stuff
> buggily - which is exactly what the above is.
> 
> ->rx_pause and ->tx_pause do not set the pause enables unconditionally.
> Please read the documentation in include/uapi/linux/ethtool.h which
> states how these two flags are interpreted, specifically the last
> paragraph of the struct's documentation.
> 
> I'm guessing your change comes from a misunderstanding how the
> interface is supposed to work and you believe that phylink isn't
> implementing it correctly.

You are right.
I should set autoneg off first, although there has no autoneg bit in this link mode.



