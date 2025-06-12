Return-Path: <netdev+bounces-197033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA5AD766D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD16616AAD7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8344298996;
	Thu, 12 Jun 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AnN0NOsV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EC1BC2A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742359; cv=none; b=IIyQmE6WqhGo8atW0k8g7dcTCinw1nS+E1MU8iG4kKL8RbUtgem0sgV4SFqlM5/q09Bh98k3iugvUFyAsjHsvMeD6sugpOwdHxbF8sMCqO6PV8ky7u9XZkTbJjB4dOwj/bdPRAwN3axl/mMzF4D92XacnEvVrimGkGp6fL1Rx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742359; c=relaxed/simple;
	bh=HMCSMEJOi5GWP7AZrMWPWH+kJx8F6zNeZQycz8A/xMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2bofhsTc6YjRkCjghLUzs1HsbAZDUOfCxqTgBbLHnwyGD9KJBUhaF/cfaR9T9GOFpbrzt01UVRavbsx2Ri4CTSOEAe2uMzKIfc99lxWf+HDFfB56r2/XiTvzpQNebihHsQ5LEZ5FME2Ix6y7QvxJVcb7GHkXHidVRQ0qG4QqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AnN0NOsV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f81J1It3CrO4pP8a18PprDUDCg+MbIYDa2YN9FuWp18=; b=AnN0NOsVgTFr2Zjv3QyYC7OubJ
	XJ//WoyI0madZDbgMg7qLtCHp+GI6m04q0oJLrMcKdinB0PUDsZbofa1uxNWpaZlKLA+jD6c0R7nk
	DD/6ZotaBA/W2qFDsvU7G9WZHsxl7yyeIKsRhrrB0/mqHztAN6O1xjTIdISoKo6C6kO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPjur-00FYmD-CI; Thu, 12 Jun 2025 17:32:33 +0200
Date: Thu, 12 Jun 2025 17:32:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: improve rgmii_clock() documentation
Message-ID: <fe60b9ad-8cab-4492-ae7d-404e73bba5e8@lunn.ch>
References: <E1uPjjk-0049pI-MD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPjjk-0049pI-MD@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:21:04PM +0100, Russell King (Oracle) wrote:
> Improve the rgmii_clock() documentation to indicate that it can also
> be used for MII, GMII and RMII modes as well as RGMII as the required
> clock rates are identical, but note that it won't error out for 1G
> speeds for MII and RMII.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

