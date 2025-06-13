Return-Path: <netdev+bounces-197533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7B4AD90E1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DDD189E3C7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F41EFFBB;
	Fri, 13 Jun 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2RXWf8iD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326F1E1E19
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827384; cv=none; b=BK0pM98nrtvy1nWJKuynmaIxVddeCZfSVmKzfzoI+cPQtQz8BS3EGoXgKDm2EC7nqtfvGQG8V3CeuEAJBX8cEKP4hjpb5iT/VrWS+9n8ekyHvnLD94+8ku5FyQyx6WvzQe3NBflu9nBkhYhWjoAvg9UhoLO2o8kUdJ6aFAk6L6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827384; c=relaxed/simple;
	bh=eauj/J+tAkQdJCKCicUGoMaYxVQKjqGRa7og26Xhtt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXyg5ynvM+k2O4PiFlmTCWaIzeM8zLWZs6/NW8o+GLuLJxpmjpaRxmAoxMXiEwBMQIHyoyuorzxNqTW89FvEAXnsJyKTB1FmJh1G1oKscuC8RTTYDq4N/aHowJ57cB7ngg9/o2kEU/XEBgQzZIF/O2K1Dhj9ad5q6e/p/zvKa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2RXWf8iD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MvYZPNiZpWVVbKxBOYi7ith0awFFNF1mQIZ8bgXzv4E=; b=2RXWf8iDFpKG9e/BHp9/oSOiIg
	93q02KW4QYAvHzdrpGN2/wECwsY3YM6iIVEK74XLEx/opoX8WQ+Cj2wqGAxUWPmoFrEB3g2RH2Q50
	iCBHeZkKF0TZddt6mRy82iOrSxMg1sEKyMMmdbX/xpVYPPQRVJzODvnzzSxWIgpIXNoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ62C-00FjVU-Of; Fri, 13 Jun 2025 17:09:36 +0200
Date: Fri, 13 Jun 2025 17:09:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] net: phy: improve mdio-boardinfo.h
Message-ID: <f79e25a7-776f-499f-b039-19ca0a0894cc@lunn.ch>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
 <86b7a1d6-9f9c-4d22-b3d8-5abdef0bb39a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b7a1d6-9f9c-4d22-b3d8-5abdef0bb39a@gmail.com>

On Wed, Jun 11, 2025 at 10:11:21PM +0200, Heiner Kallweit wrote:
> There's no need to include phy.h and mutex.h in mdio-boardinfo.h.
> However mdio-boardinfo.c included phy.h indirectly this way so far,
> include it explicitly instead. Whilst at it, sort the included
> headers properly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

