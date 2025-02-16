Return-Path: <netdev+bounces-166837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BBA377F5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696027A3581
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76080BFF;
	Sun, 16 Feb 2025 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ZI26giE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E323BB
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739743371; cv=none; b=uHBjEOnF+6znd/AFva0nl729SUVnCWk6c+uzEPEMxrt5vaNXJxUS9F9cnINgoix0ee/xjnIUToI5cg/dWZI2BqgpVxiOonsm0TojG16flv82TtB76yP0JyfAkBVrg5RH402AQn3c8lRpdP+QAU678fhIGQv8ZTiyYtriE5Zca2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739743371; c=relaxed/simple;
	bh=I7wAdXGfC05hrVj5YtNL3KSIqhPYgJkbfiG2VvI1+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBGUxhQEIiY3YKyHlFi2++Zp5EXdDQRCakADBLzM4luneuwFwmoAtLejKL8uKHUne7faxd+qG2egOgx09i2DWygDd5EThPv0zdElr8u3uOKMH5TQXRly/zRyde3T+R/pkl2UPDgS1TXX8DKnpEbuA7+5YPWHq5ns3ddyeULpjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ZI26giE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YLGDECX0iUHU3afw9qtAZkefa3vAqMd65f8RFtiJiiY=; b=6ZI26giE0LKdlyn6x5RT9fI4yq
	QmhzDNGjronKdqQDovYM5f7EOBhGYrTDu6k1qK4pp30n1N3x8uh5vWb2EfStNn0Kmwn/63CiVl5Nn
	WL4y+4YmyIAhjasC6UgFdjQ6AmjrdLAUu/t6QLNbC9dUfYdkp+4oioXGYQRZIsQ+vwHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjmio-00ElfH-Gr; Sun, 16 Feb 2025 23:02:42 +0100
Date: Sun, 16 Feb 2025 23:02:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] net: phy: remove disabled EEE modes from
 advertising_eee in phy_probe
Message-ID: <54639da7-ba66-4818-9357-b14ade5e5f24@lunn.ch>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <493f3e2e-9cfc-445d-adbe-58d9c117a489@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493f3e2e-9cfc-445d-adbe-58d9c117a489@gmail.com>

On Sun, Feb 16, 2025 at 10:17:48PM +0100, Heiner Kallweit wrote:
> A PHY driver may populate eee_disabled_modes in its probe or get_features
> callback, therefore filter the EEE advertisement read from the PHY.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

