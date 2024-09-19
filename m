Return-Path: <netdev+bounces-129019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266E697CED4
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C571C216AA
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96013B2B0;
	Thu, 19 Sep 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Utkk3OTT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DB1CAA6
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782429; cv=none; b=kwrTFKnfBt91UdrJJQLvSlHM7vKlzVX167etwaW7pk3P941RVBq6A5+GzqlGeD3qyS+vwHxfKALim4WbgOgFwOEQppP4cYgYv+8C14dfMpIV4DM8azm43nw1lAxZyOZMXGn4BpbAWstUaMBfjiEPWiDgtnn7vJK/3rI18v7uZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782429; c=relaxed/simple;
	bh=WavAKV75lC2gacTRHNjFicWJr5/ASLksBN+tkxyhG90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM4GFuxYlQQCsoEAgPVbps4zkr3SKR3dGieDfXEbwiAzMp04+4FFHGE0ogL4e20qFOsdoTZZRUNRBSmCuOobZN5iFIhohL5R0a85MXCLm6Qs4S1IIN1UC9+7Pk6kKSc5h5r0e0LjHjxDdUeh1yg5h5LBpNhmxzmFYY4ocd+vXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Utkk3OTT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=txD1zTuBds5IiZ3eFY3QoKHxzMC+jnkyrFY+hsOLLuM=; b=Utkk3OTTazfOgzijT0Zg7kdTjR
	6gWwCo6IuvVCZb+iu/GaNyRWaYkXLJuWBulJDdoeb722S0Yj5T5MVihM4rbHmM0evA8cijdkidxlG
	R8vASCv5ANj8HJnT78C2E6WMDFJ6FU5we7i9UlFHQ9fKpY0LRtn8t/rqy6vpdj0UcYSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srOzQ-007qwm-2U; Thu, 19 Sep 2024 23:47:04 +0200
Date: Thu, 19 Sep 2024 23:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, o.rempel@pengutronix.de,
	spatton@ti.com, r-kommineni@ti.com, e-mayhew@ti.com,
	praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 5/5] net: phy: dp83tg720: fixed Linux coding standards
 issues
Message-ID: <25904339-bc6c-4ace-988c-cc6e832a18f2@lunn.ch>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <dcf72baf9ff9a82799edd40f06c8d255f5c71b1c.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf72baf9ff9a82799edd40f06c8d255f5c71b1c.1726263095.git.a-reyes1@ti.com>

On Thu, Sep 19, 2024 at 02:01:19PM -0700, Alvaro (Al-vuh-roe) Reyes wrote:
> Driver patches was checked against the linux coding standards using scripts/checkpatch.pl.
> 
> This patch meets the standards checked by the script.

This patch should be first, to cleanup any existing issues. New code
you add should already be checkpatch clean as you add it.

These patches need quite a lot of work. Maybe you can find somebody
inside TI who can mentor you and point out issues before posting to
the list.

	Andrew

