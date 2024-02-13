Return-Path: <netdev+bounces-71505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D223A853A3E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C7FB289A8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1C60DE6;
	Tue, 13 Feb 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zq66ewOB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB460DE7
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850161; cv=none; b=cyFtKY8aOqOWQmpP69xXNVThPyBaXNh++7FLeyCpYz1Wf4kPbyOf1utZ1Y45vLR7m1yCBj2oB9E0+Gl+aWBiOzqcDilYOCM3tfB83GatFMezodF2QtgBK8kSZjLmHE8dNN2KY8RvZ//sr3AfGhbztaQZZWSB/Dd1vYMGVsidiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850161; c=relaxed/simple;
	bh=VgAacJyZohNK49xWRj8vUbsuUdfWP6lgnbEml2wBwuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8RbLl8v1SiqRrm7uN3vibXwhLte9YAR+prJCPUjRfA5knKmi9cXXaML8vt5CkJPt5Oku6Et2kg1K9RuG6LxKqxVE7YoHbwNKono7QUEBzlhVuMIY0D9HUSz8326T3oKh/l2mPuYVwKQkhrDbpFvnNDB63hsOONu4wKBMR3gGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zq66ewOB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cqmIUng1Hbd6yEjh+b8BlOyBJtDiQsezlAaWkCQRUM0=; b=Zq66ewOByvDG9jnjrVFNNb4vQ4
	V4TwpcflpQcj3fmq7h2Ljb1AofDHl86niYyhxiKwtBu+O1KesxkHn2W/WLqvgfWFb3Xqdik89cuKz
	yOPU2lKWFa0G1JQ+H3EOQld/2jP8cDnTABNvts/03XX+CEg+8jvFO7cnBw39mWvbw6Bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZxqL-007iJD-4s; Tue, 13 Feb 2024 19:49:21 +0100
Date: Tue, 13 Feb 2024 19:49:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>, sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
Message-ID: <7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>

On Tue, Feb 13, 2024 at 10:41:37AM -0800, Tony Nguyen wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed and activity are supported. Other modes are simulated
> in software by using on/off. Tested on Intel i225.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Hi Tony

Did you change anything? I'm just wondering why you posted this,
rather than just giving an Acked-by:

       Andrew

