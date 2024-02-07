Return-Path: <netdev+bounces-70027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FE84D680
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F78FB226EA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28720312;
	Wed,  7 Feb 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s79taOEB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7628E8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347755; cv=none; b=kVFNCAQM9SSXA7ypkwwbdvQ8Ya64ceNrY2sRHCXjs/Z0VjqyNQiCp3+6SrwIuNrC/Glgqq2BIwJDLHz7IGveS6R7J5BAnTlmQnwRP9t1ZIjb+lYAt+COeCnDBMikkpTbFwIGXL0VdPO6r7Hbdtg8dFsF+G4Nb6nA3pP6rgXTQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347755; c=relaxed/simple;
	bh=IPgUJO0HIv9gMX30P3OE/rRYXgitauNmNc4QZ3gRIp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC39GQwZ1N3eBRlTiKhEbtLIKsLE8nFhRzGjdsxiuyEVl4mgjp7mH80UvIy+YSOeksJ4VbXlIFrA1x0nzqHobzgYr/gbSpmD7ACJo6ILurHnmy49I9s9ZGjYnUjb0bH3fWeXRTd9/witqNu83idBByj2PUb9pf8WdO5CNRjSxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s79taOEB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7CFg46iziGbkoqCNx59PYISDoO+LtB3L2Zs/s31+P0g=; b=s79taOEB+GBcOm2KGqTumfhQK8
	nTuc+rLVe2guMIiXT28M3TX6RcUD8XLQ2cqloRkrYcciyjvKK77cQ383H0ELldQyTIkBSlPzxt4Sz
	PXFfDJvAVFcAEirbAAUWxq61JLMVROCvwI4ZQGAFdeZMBxC7rSdjWVAC5Y8mVDOrOpb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXr8m-007GAV-Cc; Thu, 08 Feb 2024 00:15:40 +0100
Date: Thu, 8 Feb 2024 00:15:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Add support for LEDs on i225/i226
Message-ID: <4eaa21ca-9d14-444d-9b55-86ceeaad236f@lunn.ch>
References: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>

On Tue, Feb 06, 2024 at 03:27:32PM +0100, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed and activity are supported. Other modes are simulated
> in software by using on/off. Tested on Intel i225.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

It looks like the mutex could be a spinlock, which is probably
cheaper. But the code is O.K. as it is:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

