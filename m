Return-Path: <netdev+bounces-67581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454AC8442AC
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8328C4FF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B584A3B;
	Wed, 31 Jan 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q+B6N8P8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4484A2E;
	Wed, 31 Jan 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713753; cv=none; b=r35lt1fGpk8wf0xehe02NWYtFMFUOS3G9W8G0bDuXQATngKtU56OiY3D9ZhsOpMJJtmNHIbMYdg5bpVb7lHhEmYG9IG295sRpIa4o6ZOzBsucio1fynbG9BRGeXFbK1Tvn+CVEwaSz6PWQ7/1VhnvcRvdvM7gO70pxzLiIr5NOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713753; c=relaxed/simple;
	bh=XC0EvNphrUcJq0j8q4O4vs/j3i5oUwM7G4PQZOorKIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otxQVKEYF8AFC9lwpzFnVMyPSgXFnuzA0yXnlA0GdtpuD2yphvq/jQQpu/DursTAQAGft5EiNSMdBh4N+a7EDiVV/5Fd2uFlrVRUP0G9rAjosupFg34IqJu5JcVix7vIFnLHfVu6WLJZ7SRfZV1XfESolb8326hn6CrDvOrtS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q+B6N8P8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5M5xVqM+PiELlH0mfygUqZUpkmPOx2ReByodunoLq8Y=; b=q+B6N8P8Mce5ldTqxt1pFMk4bk
	ANroDBW2nNEahY5qriecHcAw9WannyiE9aQJeC5q3mJ0zjYgdLT49T++3Fi5ExFegSf6fsR9Itqg5
	0b0ecnua0hEqOyX9QYmkzDkx/jYdj98d8chpPvoCmqAKuOrMDy/ncsrZpcyu9FtbUEEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCCu-006akv-Iq; Wed, 31 Jan 2024 16:08:56 +0100
Date: Wed, 31 Jan 2024 16:08:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 05/13] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <c278afc2-49e7-4621-8c5c-31fb8a2766c2@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-6-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-6-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:38PM +0100, Dimitri Fedrau wrote:
> Add a driver for the Marvell 88Q2220. This driver allows to detect the
> link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
> master and slave mode. Autonegotiation is supported.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

