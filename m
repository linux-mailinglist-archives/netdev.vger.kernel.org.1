Return-Path: <netdev+bounces-142870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF69C0858
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F9E28098A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182338F82;
	Thu,  7 Nov 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="drnnJQmp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9520EA45
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988161; cv=none; b=WjcwOKojR40Ds0RXiO80HHFl0cvTIpfAh9MkkeFi4dfi/+QKLfPeXuRSARlo8/k/NGRpmRwDTBUiwWfL7IhM8PZtHdnyKUTq1hWtcmhHH4h0NmKwyEgzDbmPkwNGG/GTfvJgjOXW3Dlj2TO9io2pBh279GaIxp34bUAxIfIamLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988161; c=relaxed/simple;
	bh=2wkXnB4wuh+Q++9xh7rlAprKlJnzHxrUXY8LmC2zFYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFlk5wi7VAiO+dHyFyvDoR6ueWTZhC8O8BPuvCLjIQuNNBjc6I7OcJfY13vT+bD2QdYTgLRpQXV94Fc+CN0rwloR5pXZrIRl6GdPZsOixXjt206nJl4eUrnj7H3L7DwngkmKN8QPzXjMZcB2LE+OmJZVIJX458xqWo9G1g58Ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=drnnJQmp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F5GB1V+ENdU56MIT8KsMtw7neUIv4tGeQfGJ6O6am2Y=; b=drnnJQmpvJ0TsCMsm/SDy3fRfT
	4Sw+7YlWVY3FwIT+ANMSP0Ho1cDcGWjFBPcZyBb/wXgTjz3lVQC6RiLTW0de+1d7PKtPW7M0k8oi3
	Tmt01P1er0uRg8R33+SNvwHpr5zDj9ZiAqaL7xsf9uakqdNdAGdqLUCY+j5J89HPv/1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t935b-00CT6a-7m; Thu, 07 Nov 2024 15:02:23 +0100
Date: Thu, 7 Nov 2024 15:02:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH net-next 3/4] net: phy: broadcom: use
 genphy_c45_an_config_eee_aneg in bcm_config_lre_aneg
Message-ID: <d5b8b7cc-703f-47ec-b8ef-b4f31f18fee2@lunn.ch>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
 <6e5cd4ab-28bb-4d82-b449-fec85f3d1e8a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5cd4ab-28bb-4d82-b449-fec85f3d1e8a@gmail.com>

On Wed, Nov 06, 2024 at 09:24:18PM +0100, Heiner Kallweit wrote:
> bcm_config_lre_aneg() is the only user of genphy_config_eee_advert(),
> therefore use genphy_c45_an_config_eee_aneg() instead. The resulting
> functionality is equivalent, and bcm_config_lre_aneg() follows the
> structure of __genphy_config_aneg().

I think the commit message could be clearer. Just looking at
genphy_config_eee_advert() and genphy_c45_an_config_eee_aneg() it is
not clear they are equivalent. You need to dig into
genphy_c45_write_eee_adv() where phydev->eee_broken_modes comes in,
and they start to look similar.

It does however look like this will work, so:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

