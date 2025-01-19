Return-Path: <netdev+bounces-159627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3044A162E9
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5911646E3
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107AA1DF260;
	Sun, 19 Jan 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HblUkgMf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401491DED49;
	Sun, 19 Jan 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304189; cv=none; b=t7sf/Z/iRQXa3rJNEOPlcdGCyMFv/Sp3hK8/IXsgS9sjmplwRmigGKOdi591m40mcEXPjTvwYmZR++LbR9ZVJALCeaQHbWqGkjSdFqDX0JF+QstR3aRqOvv3xrZcLkJcOAmHg3HjSpXVajlcISUjJT/HvqRLdHPUk7XN7mRISn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304189; c=relaxed/simple;
	bh=0YY7KcCbRBLWvEbb/JemH1uoz2BZ743oj+kYvcEZ5Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrF6fjXlydN9esKMfcS8ssKp9vVSI2YJtfs9ZAYwYIRw9YDpxyxqnJql0JV9TSaGp6IJxXcdEejdUYGlaH/1f/yjH+qv/1vKVpUdX88ddwTzwQThtFGCI4lGFAxsZKk6W/5UfBFd0KzD1oxm/8g71cjCCcFFX59wITQU1CA8R3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HblUkgMf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GkMN2aiNcMtwM9jl9lEjHLo0ZTfRfDHxtekdQsM42Vg=; b=HblUkgMfcp70c8rpGkSB7hhpz7
	EJ82u4kKk+C0Xqy5iS1TmRvz9G7pjkqrcAHASk9c0Ldx4Aa6CdMiklt+gXnoeyewipTYL3FlYSf6a
	CB9BfjAH34gGofr20mR923xiwlXpiHpK4egWJqdJ6j+DHztfQ+Bomt/s593/0Um21Miw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZYAx-0065Md-De; Sun, 19 Jan 2025 17:29:27 +0100
Date: Sun, 19 Jan 2025 17:29:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	daniel@makrotopia.org, ericwouds@gmail.com, kabel@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: HWMON support for standalone
 versions of RTL8221B and RTL8251
Message-ID: <894b6f10-6c01-4f53-b830-588719edf56e@lunn.ch>
References: <20250117222421.3673-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117222421.3673-1-olek2@wp.pl>

On Fri, Jan 17, 2025 at 11:24:21PM +0100, Aleksander Jan Bajkowski wrote:
> HWMON support has been added for the RTL8221/8251 PHYs integrated together
> with the MAC inside the RTL8125/8126 chips. This patch extends temperature
> reading support for standalone variants of the mentioned PHYs.
> 
> I don't know whether the earlier revisions of the RTL8226 also have a
> built-in temperature sensor, so they have been skipped for now.
> 
> Tested on RTL8221B-VB-CG.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

