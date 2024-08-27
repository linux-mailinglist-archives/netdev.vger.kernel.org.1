Return-Path: <netdev+bounces-122440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E513961533
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19831C22C1B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBC1C9EAD;
	Tue, 27 Aug 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XLo0rjej"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A043AD9;
	Tue, 27 Aug 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778725; cv=none; b=WNFYniO7Ogj+nlf4v00SrxGgemxQBg3BtXOWMo7kZkogChgirexracSsE9MaZs9AC3iiDkdFJ5rRjECYwoWZIQg3TiaeOW3hfD1y3yvQc5bgw2tDaWq4hgPvRsUTD48cAjycW8wRKNn3KkrtWzu+NPTSPtfkFjsY9Rgcvs0iGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778725; c=relaxed/simple;
	bh=KbjSHZNZ/VdXZo65wv8fvAnqHoSdaVLRnrqEHrBX0Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkjCGkdDeC+TFEyoCd5CRNQvhqJZMB1kyiJsvORzmXQIFMVueqS7PMyZSu/pwd+GgVGT8y1mixxsZ5QKy37gyGpK7pcsfxf6an03YV4AneXrzSCn89M0U+nsQwRvPO779cEgeVR2lqcy2q2Ib0iwNkPInwWDO83NsFxmbC1ZW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XLo0rjej; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6MHRwTiI+GJOjlA9is2OP/wAzm7/f6vGKWRbmNuRdiE=; b=XLo0rjejjBa9evrNxWmqv2QqW6
	wI/rfBn5KFSiJY8IcYQ88fDjrekYf5G2pIOrXjRLCuZNOwpmqH/+6tMCryv6Gqf1weEtuWkjgQ3S7
	nBVTs6iE6/tEg4LeBqYtKyXYUJ/ISSdykSVqRr3zxoLQTk6OSZ9RzjqXSYQcDQNcDYkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sizjc-005qc4-8G; Tue, 27 Aug 2024 19:12:00 +0200
Date: Tue, 27 Aug 2024 19:12:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: mv88e6xxx: Remove stale comment
Message-ID: <57e756a1-6dfd-4487-8a57-4e088b2cca4e@lunn.ch>
References: <20240827171005.2301845-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827171005.2301845-1-andriy.shevchenko@linux.intel.com>

On Tue, Aug 27, 2024 at 08:10:05PM +0300, Andy Shevchenko wrote:
> GPIOF_DIR_* definitions are legacy and subject to remove.
> Taking this into account, remove stale comment.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

