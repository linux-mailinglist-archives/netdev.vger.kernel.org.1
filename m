Return-Path: <netdev+bounces-120556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA9959C18
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C1B25975
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80179193437;
	Wed, 21 Aug 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C1YXmyZq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52818E757;
	Wed, 21 Aug 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244150; cv=none; b=lFGlVhlu6haouNYu6bHYhat/nie8Va8Dta7dH300f5rRHjudVTjbTLvXEFDRuE9jhNi7DLWjmBkjgPIXmtY3JcXizQX8cLMOnZpGm7ruyG6u6ZfSeEKNdIlnmPfwPBL3mRtnvasHXHa9OyLo2NlBNVr6hhIyuWF6W69jIcEKpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244150; c=relaxed/simple;
	bh=IVJmgagFpPOYr27K1OM7lZ/14ItyaxWKQcaApEP3X6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFdztuu1icyGhdEV1IhpWVmKK+imOf4TJ85xV/FNw+KAeRg1m32sHb+WfjoYKrMAHZrn3WuKOHBEZ7+S19+tI7ubeA8PfV5M2ZWk0wNR+YqaleBeRcfFvY/oGFkxwbdGJUa3y80bvnzS/JPn8RYGHuZMWoFWhkCUjmEbbqObAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C1YXmyZq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CZrYL4SBWV1LwtsSeryiwRK7gzIRzBt/InjKvG5ljeU=; b=C1YXmyZq4fzpY+0OFIri1feSzm
	m7hxxpBEZWI3H/nkkTQ3x9JOVzPxn+iEaInCCuQZs15LoZWklfXk4etPZosSnXHyojRlKwqTRLAcF
	TFGB7wn3EokIjs2BQzCrsWl8P0BKQNm9jybEQBCYvlOt8ZjFHnoKCLSJzTbsCaZHsqF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgkfK-005K7f-KZ; Wed, 21 Aug 2024 14:42:18 +0200
Date: Wed, 21 Aug 2024 14:42:18 +0200
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
Message-ID: <bd793119-3a0f-40c8-8c78-201e2fcf9664@lunn.ch>
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

There are a number of out of tree x86 boards which use this, flying in
various aircraft, so have a long life, and do get kernel updates.

I'm happy to support this code, and as a PHYLIB Maintainer, it adds
little overhead to my maintenance works. If you really insist, i can
try to get code added to drivers/platform/x86/ which use this.

	Andrew

