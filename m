Return-Path: <netdev+bounces-166839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F93A377F7
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89E416A8A6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5B16EB4C;
	Sun, 16 Feb 2025 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rtKELwiJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556A1624E6
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739743758; cv=none; b=JSPRIsefS9H5WaLiYDY3qNozQLRB/y/fJa/QDlj5Qu1tU6NwqcjuOia9gLw4R3gVFWDu7Hk3aGSPBDcyD6YfIzbYgo0/HYh9lBjKKc6phvRJp/hbhkDA/bi09hpAGEzTo3SWzUp857cjGaBHqmCUDFgzQQejMUDfBbYaOS+Hyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739743758; c=relaxed/simple;
	bh=MPfm0a7gjMfvt1X1TvsFPjAMbDf5TKlNBva+Cm/3UGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azG90ymW2Yw1NTQMvq4Y0thkpeGw5muqUK0tXTybmOkkDdLXVN0cy4rn7OmuQTxS16VD01dLII8GLHOCF5g6ZNYhzk3qFeillj5lV8snkc6DHH529FPJ6A/dxybCvjKlpQJcuq9LeoKHE1+w1zxI3onkp1LSfVzR7KVGIMSXHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rtKELwiJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RjSfKUL+Uu/cKujDGO6oVqf4Yq51JZL+l3E1MO82ftE=; b=rtKELwiJQ0g58yqOLdCZRBfR1S
	RryWca0I5sJXA7quRJtKmZ5Rxwzndr5HmmV5E+UhgaakSgGZKXMjogtlNQuw6hk6gi0b6gEDBI+Eq
	FbhgIkRbqu/Cdj269mZPl5w+phWD115fw6FHKU9Vlk+gjdB1xCW7Q92piXVFUSHtoFtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjmp3-00ElkB-5j; Sun, 16 Feb 2025 23:09:09 +0100
Date: Sun, 16 Feb 2025 23:09:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
Message-ID: <347f5390-0827-4d2d-b8e7-3e02e6fe27fa@lunn.ch>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <bd121330-9e28-4bc8-8422-794bd54d561f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd121330-9e28-4bc8-8422-794bd54d561f@gmail.com>

On Sun, Feb 16, 2025 at 10:20:07PM +0100, Heiner Kallweit wrote:
> After the last user has gone, we can remove the local advertisement
> parameter from genphy_c45_eee_is_active.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

