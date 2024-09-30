Return-Path: <netdev+bounces-130573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FF98ADC1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8BB229BC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB219F42E;
	Mon, 30 Sep 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f5j1WQ0t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33737131E2D;
	Mon, 30 Sep 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727041; cv=none; b=Z/KaizhPHZ6oi427PyW8yEtzf7ViW7tHqXriMHDehbfSay9JUfrTE4CRbMctRV5/N5yPC5MAaiHw4RT8YDh8TZznX7/KE367K3061O5QLG56E+zTC3kEAwJURA2e3x4e1UGdIDEBF17H85YCxHKJgJNVq8/bKydQV5Dvmt9olVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727041; c=relaxed/simple;
	bh=IuzDvz6CaFkUTqBqJqXg8TmtAs76PPZXyrDWEuwGADM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYFhYNTVVj8rsZ050Bk2qcQnWzBHTLJ2sZBVRGtV7MG+8xToG2z2gsPErH/B9n0WIwy1+BS45m3H36VaW7iL+NLnBMeFd/fU/Vm/G8oDlcu+AKisVeEJXoJxkf5ujzOVfG7yzLG1x8LQBsy+o/kogBI1v2KskzWUhQw4CM+ZOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f5j1WQ0t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lqu5u7mXkeUogSz5T90Ei4jvVwmcYEQRpgQfkW/EFrQ=; b=f5j1WQ0tTYNWVlZFl2QowmivVH
	/42hhEaxNSx06PmTUxxfCimKegG5YlJ0W4VJkD4NiApErG8VsZEdwi7KtJx4U/E+QBcX5+sWWoPTf
	JrUxSG+zhYCsVSlVzp7vChGw6rHR4ZwtZY0aiYGIct8tDyD94fhtz8bvU7Vmvw+WlH4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svMiv-008eyS-6g; Mon, 30 Sep 2024 22:10:25 +0200
Date: Mon, 30 Sep 2024 22:10:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: mdio: switch to scoped
 device_for_each_child_node()
Message-ID: <2ebbc75e-6450-464b-8c65-7f8b1f752fbd@lunn.ch>
References: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
 <20240930-net-device_for_each_child_node_scoped-v1-1-bbdd7f9fd649@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v1-1-bbdd7f9fd649@gmail.com>

On Mon, Sep 30, 2024 at 10:03:29PM +0200, Javier Carrasco wrote:
> There has already been an issue with the handling of early exits from
> device_for_each_child() in this driver, and it was solved with commit
> b1de5c78ebe9 ("net: mdio: thunder: Add missing fwnode_handle_put()") by
> adding a call to fwnode_handle_put() right after the loop.
> 
> That solution is valid indeed, but if a new error path with a 'return'
> is added to the loop, this solution will fail. A more secure approach
> is using the scoped variant of the macro, which automatically
> decrements the refcount of the child node when it goes out of scope,
> removing the need for explicit calls to fwnode_handle_put().

Hi Javier

I know you are going across the whole tree, multiple sub systems, and
each has its own rules. I think naming patches is however pretty
uniform across the tree. Do what other patches did:

d84fe6dc7377 net: mdio: thunder: Add missing fwnode_handle_put()
a93a0a15876d net: mdio: thunder: Fix a double free issue in the .remove function

netdev has some additional documentation you should read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The change itself looks O.K, its just the processes which need work.

	Andrew

