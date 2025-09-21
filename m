Return-Path: <netdev+bounces-225095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0908B8E36F
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24C0189C5FA
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAF1F4289;
	Sun, 21 Sep 2025 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qaU7NRve"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6D8F54;
	Sun, 21 Sep 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480189; cv=none; b=qM0FdvRDAnKyIAZVmcx8IfgDHp+onWcgYahKApzfZr0J5FjLgsaC5bqYkPly5swXNwSPGRCI6oIw5qiw6pjQe0uLs51aChq1JcK0XJEnxdVsIxbbMz4jvX36Rmh7n/6zxNA9wWO4b15/vC2cveV0k/wX9i/vvEe7lX5OkvswJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480189; c=relaxed/simple;
	bh=kz8+rJ3OwRE88qi+eE8kRDASDAeDA8L3yK0pRJpy4Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGa9R5+fpGnHNO+vc3tneVc6DPfupaLG8RY35KA8+VRjt2cHiWXa1tHSTKyHOnsf8CKOER48T9131xd/tItrbPD/jMX6L/7fE+G3BHWdbY4UeFdOsuPqaPwfxmyv5kk/7/smMT4kHJ3dGDXshsAUMYJtK2/V6BpXAxZtWWb4A0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qaU7NRve; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mwIooN8k13SoYRJ7KEz/xkVOkWcWn7ux3nhsoOLZo9o=; b=qaU7NRvejjiEjJmEY8pUOQ/AVk
	ykrJ2rANOXWvNjd99dglSOASAKFgiqjyCTtDXZ2ndhSRx4lw/fVdOg8hVzMpm/cmDc9sF/FAgS5Bj
	BZr5Ez/LQaJlUYbNzwomFxLCoktJNMv6j+hcP3xYeTcxTUBx9GERViiz3m5x1jjgCC9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v0P1T-00962g-3H; Sun, 21 Sep 2025 20:42:55 +0200
Date: Sun, 21 Sep 2025 20:42:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: Query regarding Phy loopback support
Message-ID: <defa4c07-0f8f-43cc-ba8d-0450998a8598@lunn.ch>
References: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>
 <3b76cc60-f0c5-478b-b26c-e951a71d3d0b@lunn.ch>
 <aNA5l3JEl5JMHfZM@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNA5l3JEl5JMHfZM@test-OptiPlex-Tower-Plus-7010>

On Sun, Sep 21, 2025 at 11:14:55PM +0530, Hariprasad Kelam wrote:
> On 2025-09-16 at 22:13:20, Andrew Lunn (andrew@lunn.ch) wrote:
> > On Tue, Sep 16, 2025 at 04:48:56PM +0530, Hariprasad Kelam wrote:
> > > We're looking for a standard way to configure PHY loopback on a network 
> > > interface using common Linux tools like ethtool, ip, or devlink.
> > > 
> > > Currently, ethtool -k eth0 loopback on enables a generic loopback, but it 
> > > doesn't specify if it's an internal, external, or PHY loopback. 
> > > Need suggestions to implement this feature in a standard way.
> > 
> > What actually do you mean by PHY loopback?
> 
> The Octeon silicon series supports both MAC (RPM) and PHY (GSERM) loopback 
> modes for testing.
> 
> We are seeking a solution to support the following loopback types:
> 
> MAC Level
> 
> Far-end loopback: Ingress data is routed back to egress data (MAC-to-MAC).
> 
> Near-end external loopback: Egress traffic is routed back to ingress traffic at the PCS layer.
> 
> PHY Level
> 
> Near-end digital loopback
> 
> Near-end analog loopback
> 
> Far-end digital loopback
> 
> Far-end analog loopback
> 
> We need suggestions on how to enable and manage these specific modes.

Whatever you put in place, it needs to be generic to support other
modes. So you need some sort of enum which can be extended. When
describing the different modes, please try to reference 802.3, so it
is clear what each actually means. And if it is a vendor mode, please
describe it well, so other vendors know what it is, and can match
their vendor names to it.

Frames received on the Media loopback vs host transmitted frames
should be another property.

Are you wanting to use this with ethtool --test? That operation is
still using IOCTL. So you will want to add netlink support, both in
ethtool(1) and net/ethtool/netlink.c, so you can add the extra
optional parameters to indicate where loopback should be
performed. And them plumb this through the MAC ethtool to phylink and
phylib, and maybe the PCS layer, if you have a linux PCS involved.

	Andrew


