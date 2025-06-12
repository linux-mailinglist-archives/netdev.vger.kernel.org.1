Return-Path: <netdev+bounces-197045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45825AD76B4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6383D1653B7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0729B771;
	Thu, 12 Jun 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t3MZyEAW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1429B233
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742698; cv=none; b=kFIJ8iYIXqxsKU644qcZZ5PpKLu7mCtauUVq3twaB7FjPxGkEzHQj5teE5av0Wz0AORUuQvLdi9h4NuN99guQZ/YRWunCFv1fTL5BBM1x5qhAdAbPV0wg9TvEQtyN6XcdHbsupAbPi2j775komsy0cwRNFNUW7FB6ruZ23P4wI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742698; c=relaxed/simple;
	bh=F1Xfpiw4C2EOYsiE3yZvxNoyoKvNZZ8yECmkSGqenM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1twl2Y0d5du82iIq+hvlp8k7XKVxHT5p+UAJ4Y5TnY98fzLFiNuk143F9Elu71IhyikFZ55JzNRkHK8sIcW3eRJAae0dpFqlwCh7CxbnNQ+6XZuM7hXrkWd0ZKfI6Ii8DJMQGe5JSlzJ4OJDsEdPhyCqKYJap5RoDKcrtrfrow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t3MZyEAW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G5POUqW1rltQsu6avIe5+vCSwYLUFkxsUKOIbWl9pNs=; b=t3MZyEAW5OLaDTShR+5c45r6lX
	aPwDXlvK7XznRwNmoqTVwI/1XVysz3mSuDwyJ09jGr6+lR4/8YiJBW93elkb26nuNqixnntrJHovB
	DiGX4yVaBJKnREdDqYnlnR8PPiq5uyDFVnjyhfNf7uWrxtoc7T5iRglA6RvA4aNo5uLI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPk0G-00FYsW-E3; Thu, 12 Jun 2025 17:38:08 +0200
Date: Thu, 12 Jun 2025 17:38:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: move definition of genphy_c45_driver
 to phy_device.c
Message-ID: <b35b2efe-81fd-4118-849b-92abc4888b4b@lunn.ch>
References: <ead3ab17-22d0-4cd3-901c-3d493ab851e6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead3ab17-22d0-4cd3-901c-3d493ab851e6@gmail.com>

On Tue, Jun 10, 2025 at 11:34:53PM +0200, Heiner Kallweit wrote:
> genphy_c45_read_status() is exported, so we can move definition of
> genphy_c45_driver to phy_device.c and make it static. This helps
> to clean up phy.h a little.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

