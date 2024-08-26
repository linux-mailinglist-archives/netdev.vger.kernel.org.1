Return-Path: <netdev+bounces-121935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA8095F5A2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DD31C21CDB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DA192D6F;
	Mon, 26 Aug 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3EIB1eP9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7849631;
	Mon, 26 Aug 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687715; cv=none; b=lDUhipuH7MWcoOQb1tnHfe4JOSng+a/ahgQREdLSEG9UTsCRUz2rLUFerejZL6AbhPm6MjKKufdpzpzO+Xa7vcObqfUT+Li0lSeu2pwA7z9Xh+sxqi9sXR0bfWa/SWGnG3fBBa9gaGJYEx5lwajKTg9qN8dCl1w0XxTg/n21qBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687715; c=relaxed/simple;
	bh=L7hn7sXnbaGEXTqvjYV2FYj+u357R8RtFVukmUqjq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbQdDzpSVzV1powvzWV8EGYQyImaNUkjNGpATMOziTMLgNssuRxNfwbe2rcr7WOHxRSojHVZ8eMMOR2zQWxzn8Ncu3ZQiAd/CXLx4uIIu2pyX8DGSp/gDbvFPDYY9I8mTG4u2alYURDusEWiFo4FoVtCLwt+IyKuZvbXACxOn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3EIB1eP9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wNeX+uo8MdAh/CO339uqAEm5B1knAjxn4RKJZCwHod4=; b=3EIB1eP9SE/sF+ptrJRTMNRQQz
	bw/BDKiDFtmDDp5ugvkAlXi6MaWdMqt9ErkydMni+HSq1EA03I8neXxiA6UmDb6pzePzOEDl/k6jb
	CzusuQRMYuMgIC9y6ARRvBHLRuxH0tuOSkrJ4KvUKTtThgIBOSoYcPz68uOIY8NUNHxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sic3X-005isQ-P2; Mon, 26 Aug 2024 17:54:59 +0200
Date: Mon, 26 Aug 2024 17:54:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next] net: mdio-gpio: remove support for platform data
Message-ID: <30a51c9a-a94b-4b11-a611-ea176ade1b83@lunn.ch>
References: <20240821122530.20529-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821122530.20529-1-brgl@bgdev.pl>

On Wed, Aug 21, 2024 at 02:25:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are no more board files defining platform data for this driver so
> remove the header and drop the support.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

FYI: I'm working on a rework which changes the default for when there
is no DT node. That will allow the removal of the platform data.

It is being built tested at the moment, so i will probably post the
series tomorrow.

	Andrew

