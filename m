Return-Path: <netdev+bounces-102349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4470902969
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F21F219B7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629D14B975;
	Mon, 10 Jun 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CeU/QKAf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77B2230F;
	Mon, 10 Jun 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048181; cv=none; b=Ce8BZhBnWkb5lSRWXQWC9IFpXpMsFeS9jZvStmI6/GF3rYH0BPDtz6sVCGg1HG4nTQ+LBcCHBD8MBaV561FEzdRcxQXSZ7FnCr/auLGZ2g7urtwK3e4Sm7uTS7PK3mZMppM3FWC/Ny3ibECK9ZhrD3ZBb6TYg+44ngPupDTZpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048181; c=relaxed/simple;
	bh=tMS6tBLh/D5dVlFWpkRUR8GjedWgB0bTz59xkhYVqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTYIw/aI/ANPekgx7tnRmPwvDc5r1Yyhz6hLZRGyS5Fmx3r+ZnG56uuaZJoaaW237XNGDhghM+PHOVMo6BHEkQZv3sRsQTtSKBh8oRwae+bqNTfZXDt5h4e5YLPoPUhHqttnhcp7RbBAJA0dxF34EoKVvm/jAjlrVgBHv9LBb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CeU/QKAf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jYzuoLcn+paF8D6hwBRNWpyNSs/pBEMZxZI5thdD4JQ=; b=CeU/QKAfY8l0/tShQA7/RW8iAi
	P8z6WQPAnlL5zdyFAvbme/u2okBddIQLYPCZxGpylS38HYN3FgcpYYE8elpC88906sa5drmszmDvJ
	1K5xkKm7pfk8O6Ih3yMTBhRnGHQCL4YbFnSsU43lLy2sx06AejdsDEbKD75HCapgR0dc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGkoK-00HK7b-71; Mon, 10 Jun 2024 21:36:08 +0200
Date: Mon, 10 Jun 2024 21:36:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Richard chien <m8809301@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard chien <richard.chien@hpe.com>
Subject: Re: [PATCH] ixgbe: Add support for firmware update
Message-ID: <e9b5eef7-8325-4d71-bbb6-ba063733484c@lunn.ch>
References: <20240609085735.6253-1-richard.chien@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609085735.6253-1-richard.chien@hpe.com>

On Sun, Jun 09, 2024 at 04:57:35PM +0800, Richard chien wrote:
> This patch adds support for firmware update to the in-tree ixgbe driver and it is actually a port
> from the out-of-tree ixgbe driver. In-band firmware update is one of the essential system maintenance
> tasks. To simplify this task, the Intel online firmware update utility provides a common interface
> that works across different Intel NICs running the igb/ixgbe/i40e drivers. Unfortunately, the in-tree
> igb and ixgbe drivers are unable to support this firmware update utility, causing problems for
> enterprise users who do not or cannot use out-of-distro drivers due to security and various other
> reasons (e.g. commercial Linux distros do not provide technical support for out-of-distro drivers).
> As a result, getting this feature into the in-tree ixgbe driver is highly desirable.
> 
> Signed-off-by: Richard chien <richard.chien@hpe.com>

How about you work on one driver at a time, to learn about the
processes for submitting to the Linux kernel.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

https://docs.kernel.org/process/submitting-patches.html

https://www.kernel.org/doc/html/latest/process/coding-style.html

I would also think about why Intel has not submitted this code before?
Maybe because it does things the wrong way? Please look at how other
Ethernet drivers support firmware. Is it the same? It might be you
need to throw away this code and reimplement it to mainline standards,
maybe using devlink flash, or ethtool -f.

One additional question. Is the firmware part of linux-firmware? Given
this is Intel, i expect the firmware is distributeable, but have they
distributed it?

	Andrew

