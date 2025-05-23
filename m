Return-Path: <netdev+bounces-193062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C63AC2489
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB8E1C001BE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1B292931;
	Fri, 23 May 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GCDjF6xv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082672DCC07;
	Fri, 23 May 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008521; cv=none; b=qP1AEMRs5VxTPRQWalpwaAUdQcK7QAjvfU+LtqtacJj8DRIsBZUbV+zwSxiN489WffMtgUTW31TIqFsujFX4xarOMFkYWWei1hvBThbYNG3oYjhpE1nn+ZpVWs6EUjyb3PEiScvnq4Aki3r0h7JPUy7XFEbp9GO345vdISD0fTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008521; c=relaxed/simple;
	bh=sdVTyOgKOEBTZ4Wy75P9tVY++UBtwRAc+YJWz0YdVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMe6e7QoX10j50itQUBduJuFo6Wa07JxLG5ffpMH8gzdcHDdzf+PLhJIZgrcwXEuiLG/jFN/QQfwQA9MKpxwOT+Y+VuyvVEwah3QT+7xT8NdKqggGuKcpvHjWdOPEED1rCMGQPjPbyU3ShVkqF7irDwg82Dc5s5x1hyYqS3CP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GCDjF6xv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ss01O2PxHPqZcKIbbJUvUkCLt86vG9SaRe+yz2gl1dE=; b=GCDjF6xvt6ar6Ihcjb5zvzf9L9
	t/VdHUugqvGEOnQJuSexw8l41My6F/38XM0gnabTmU0y17qMI9eFE1/RgG9avtBHF/uKO3DzcJR+k
	lUllO4fftZrJ5oipHsveBpKA418vDOkoXsd6BvbFTAejkthtQeopassGgJgs3kNHpITc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uISrb-00DcKj-9z; Fri, 23 May 2025 15:55:07 +0200
Date: Fri, 23 May 2025 15:55:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
Message-ID: <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523132606.2814-1-yajun.deng@linux.dev>

> +What:		/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids
> +Date:		May 2025
> +KernelVersion:	6.16
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		This attribute contains the 32-bit PHY Identifier as reported
> +		by the device during bus enumeration, encoded in hexadecimal.
> +		These C45 IDs are used to match the device with the appropriate
> +		driver.

https://docs.kernel.org/filesystems/sysfs.html#attributes

  Attributes should be ASCII text files, preferably with only one
  value per file. It is noted that it may not be efficient to contain
  only one value per file, so it is socially acceptable to express an
  array of values of the same type.

These are static values, so efficiency is not an issue.

It might be better to have a directory
/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids and then for each MMD
create a file. I would also suggest using is_visible() == 0 for those
with an ID == 0.

	Andrew

