Return-Path: <netdev+bounces-153262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDF9F77AD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85291895351
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480461FA8F1;
	Thu, 19 Dec 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lSThL6v8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD653C147;
	Thu, 19 Dec 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598013; cv=none; b=iPsAnUNJybgBW2sTBN9W5BWABfP5kZNlKdroE0Nur+Rhd8oXvmvFrPSOC5HnQ4IA3BRKH3Ml/u5smYjOAwu+dW0ojxb+WKCaUoDgOc8fdWTyoWxIm2m6MJv1tMrf/c9NdBciUB2Xcw7FOuUeI+vN+UW3CldAz+eP3YZqDLGj/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598013; c=relaxed/simple;
	bh=mUcOkXZiiwQnR0f4uDT53lvVwWB4SmR14chFZ6DNG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htLDe9ZQHy5knjSqefBDHh4l39zs816Acj6PYNeJNxABJM9qjIR28EdLogd8untibDXUm0OxSrFCWt6G/9WgWXvf+FJNzhit824Dy1uqBbKW8rLuAKQGH7kdM5EIQkUIkj/7WPvFMjON/2lW5/h0qwbcC2NpZnc+IsXFq47h9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lSThL6v8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zIGfB7JN3lTfPB7tYOtAgbkXkR9HfA+WpnjbHoBoTmQ=; b=lSThL6v8pu/dftvUG8aPIi5UtR
	uydX0hDMywUs7T2MALEBbWphxWIVNNfGk5ngF53AzemwpcyCgYXgro7NomicFzMsH0HTHtAYHzn1y
	oyO/9k0zLCFXoL4G0Fx/xpxEQ7lClMq73hRSevVUOjHZ+t9chRMMYCl7r4GqeMEO1Od4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOCB8-001YFY-Hi; Thu, 19 Dec 2024 09:46:42 +0100
Date: Thu, 19 Dec 2024 09:46:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: andrew+netdev@lunn.ch, cai.huoqing@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, gongfan1@huawei.com,
	guoxin09@huawei.com, horms@kernel.org, kuba@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	meny.yossefi@huawei.com, netdev@vger.kernel.org, pabeni@redhat.com,
	shenchenyang1@hisilicon.com, shijing34@huawei.com,
	wulike1@huawei.com, zhoushuai28@huawei.com
Subject: Re: [RFC net-next v02 1/3] net: hinic3: module initialization and
 tx/rx logic
Message-ID: <03fa6e84-65a9-4563-b289-bd75508234a2@lunn.ch>
References: <b794027a-ef3b-4262-a952-db249a840e89@lunn.ch>
 <20241219085502.2485372-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219085502.2485372-1-gur.stavi@huawei.com>

> > > +static int hinic3_sw_init(struct net_device *netdev)
> > > +{
> > > +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> > > +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> > > +	int err;
> > > +
> > > +	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> > > +	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> > > +
> > > +	hinic3_try_to_enable_rss(netdev);
> > > +
> > > +	eth_hw_addr_random(netdev);
> >
> > Is using a random MAC just a temporary thing until more code is added
> > to access an OTP?
> >
> 
> No, using a random MAC is not a temporary solution.
> This device is designed for cloud environments. VFs are expected to be
> used by VMs that may migrate from device to device. Therefore the HW does
> not provide a MAC address to VFs, but rather the VF driver selects a
> random MAC address and configures it into the (current) device.

If you look at MAC drivers in general, this is unusual. So it would be
good to add a comment why this unusual behaviour is used.

	Andrew

