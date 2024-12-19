Return-Path: <netdev+bounces-153314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D39F796E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2143216F9AE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5FA222570;
	Thu, 19 Dec 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sqv9qOd2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE554727;
	Thu, 19 Dec 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603634; cv=none; b=OolhT9sdZhBSzD0rS45KclqeATIwqa8cZ+lhAPXh7UO1iP7QhneQlbTRJep6tzBeqVoK+YATsBfyqAouuD2FGE0UJ5MvxiRAxIm3Lm+0bJ2EPcnUTqIhRzYFXjCu2Q6Inyq17iQDeZ/VNpCMuPTejLciawnufFa6McQsPNZdTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603634; c=relaxed/simple;
	bh=mOsHmf21w2kEGtHA9vz/4siHs98lAYBIBeWr3qbIM7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcoOxu9cruDxYu3boemJky1l9S9FGmmCPcNOzANVO9tQcK4td4KVGqn68PAmtf0P+cLHn9w+X5l7XujbFR1Ss+6ngPQMCOIB0FyhoBRRTtOxIeqmWgAAAC97bSIhgwpZ314/KdrMCFNtX9agaW6I1UPnwQAhFZCwHBmLqfnj5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sqv9qOd2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DfGYeTp86HBcaa5jKwlVE/9NSjOWFdG/6KQHNq3Q73I=; b=sqv9qOd2D44ajvgmh4FExM10DQ
	LWYNOPXzmPrVlBQjX5Y/UXnJUNERCADBwt1tbskGEF1EnNV55ffl4oSaz9nzcUiRfc9Sn0C0qtQRl
	DqeE5tWDnEZsBXagFfSjOEUnwlm5SInFa103Ymn5F8VVul4GsxgjAEaFmFdUucwOfhO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tODdm-001ZmE-Uh; Thu, 19 Dec 2024 11:20:22 +0100
Date: Thu, 19 Dec 2024 11:20:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mdio_bus: change the bus name to mdio
Message-ID: <f062d436-5448-418a-9969-f1c368e10f8c@lunn.ch>
References: <20241219100454.1623211-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219100454.1623211-1-yajun.deng@linux.dev>

On Thu, Dec 19, 2024 at 06:04:54PM +0800, Yajun Deng wrote:
> Since all directories under the /sys/bus are bus, we don't need to add a
> bus suffix to mdio.
> 
> This is the only one directory with the bus suffix, sysfs-bus-mdio is
> now a testing ABI, and didn't have Users in it. This is the time to change
> it before it's moved to the stable ABI.

So are you saying nobody has udev scripts referencing MDIO devices?
Nobody has scripts accessing the statistics? You don't expect anything
in userspace to break because of this change?

I personally think it is too late to change this, something will break
and somebody will report a regression.

	Andrew

