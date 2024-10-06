Return-Path: <netdev+bounces-132566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD8C99221F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8F21F2150B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3678172777;
	Sun,  6 Oct 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I/Z3XDJV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6828136E3F;
	Sun,  6 Oct 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254916; cv=none; b=P5p8NClScGsJcYHPNlwltzVaOQL74GaX3hjF/pFZZlm/rmSuavo0UatpQ1vnQaOAHbJkYVXEhNmAKpIDK5acPfo972lAA8um+HBMeqd9QtWZfOhDVxdcTwgPViUARiP8jAgkJ9LqyJiKmfZwpEOrjAlCw5ucfWCFKhRBHkYCKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254916; c=relaxed/simple;
	bh=y3h8isw+sZMArpTg2oGtcAYeewD1Io5xAzOKFkDScRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMGhMzsSBniJij3gTdxQefIOFFHRsn42lyBBC+UEV643pHgzmrP0jFNVo+ll2HrSMhLMHAsOWE206DWhrvibtJtp+lXb2sby7nue4XcncAc6YDXqjGLDc1OLkyBzb49TkixrzU/bRqRGGAlqxs8JULkh1mq5LskZrDCLwAdoVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I/Z3XDJV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aEJPDCwTzsVRuDwSb7DoMTUdU0b4I0cCDfPqI9ISxjQ=; b=I/Z3XDJVA4SbIIZKnBvsmXhjJO
	tqdykfk6TYww4px+t06rxGPQs6fD3NlPqq18ZCcJ23DYtpnRliSIdDwfscQly6dqTnkQzwDMOiwQX
	DleNPM+Mg+Pf8rf0MTHfzedT+85ZvTfYzt4od8CZsEy7YDWSXPX3EKKkkPiLYGk5UFEo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxa36-009DIR-I5; Mon, 07 Oct 2024 00:48:24 +0200
Date: Mon, 7 Oct 2024 00:48:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Safonov <insafonov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: fix register_netdev description
Message-ID: <a230dbf8-2390-4cbc-9aa6-ef3cd052dcc6@lunn.ch>
References: <20241006175718.17889-3-insafonov@gmail.com>
 <844f8c95-634c-4153-bfab-d6a032677854@lunn.ch>
 <1ebce461-e4eb-4f10-9de8-19240193b262@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebce461-e4eb-4f10-9de8-19240193b262@gmail.com>

On Mon, Oct 07, 2024 at 01:00:19AM +0300, Ivan Safonov wrote:
> 
> 
> On 10/7/24 00:16, Andrew Lunn wrote:
> > On Sun, Oct 06, 2024 at 08:57:20PM +0300, Ivan Safonov wrote:
> > > register_netdev() does not expands the device name.
> > 
> > Please could you explain what makes you think it will not expand the
> > device name.
> > 
> > 	Andrew
> 
> It is the register_netdev implementation:
> 
> > int register_netdev(struct net_device *dev)
> > {
> > 	int err;
> > 
> > 	if (rtnl_lock_killable())
> > 		return -EINTR;
> > 	err = register_netdevice(dev);
> > 	rtnl_unlock();
> > 	return err;
> > }
> 
> There is no device name expansion, rtnl lock and register_netdevice call
> only. The register_netdevice expands device name using dev_get_valid_name().

 *	Take a completed network device structure and add it to the kernel
 *	interfaces. A %NETDEV_REGISTER message is sent to the netdev notifier
 *	chain. 0 is returned on success. A negative errno code is returned
 *	on a failure to set up the device, or if the name is a duplicate.
 *
 *	This is a wrapper around register_netdevice that takes the rtnl semaphore
 *	and expands the device name if you passed a format string to
 *	alloc_netdev.

So you are taking this comment to mean the wrapper. Then yes, the
wrapper does not expand the device nice. So please move the text about
expanding the name earlier. It is an important part of registering a
netdev, so should be mentioned.

    Andrew

---
pw-bot: cr

