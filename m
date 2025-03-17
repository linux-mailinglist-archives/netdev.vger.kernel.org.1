Return-Path: <netdev+bounces-175476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE0A660CE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FC5189CF98
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BE1FF7C3;
	Mon, 17 Mar 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4H8ja55q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74E1F790C
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247644; cv=none; b=bVjNE8MTNxxqluXLgohyJzlL2p5h6/D9fKEyKZXjJxP7VZ5mPDC9tzi70M4S8QZj69m0MC+qegnV3XyPZr3cnBLzGiH+jEGWtuqezNb689EQtb7m7N13CT+Wdx/+cbT35BwIpVw4KSWrU8FLsAOP54UpxMG+NBFT3lO1YFZkA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247644; c=relaxed/simple;
	bh=O1I3hV87aU6uWZceAL6YFvxMshl7hSy+WUOOYVkJs90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjFGTEnsDwGTKxaC2OsD5TDVlt1Sc+M2U0WEnfSxbc0QwqbUvxVB3NuJlY/+OLjqEDvYFm/4tx4w9Toq9Ih/c9UgksqkVVftQyY9Rfz+uavRb31yhKucn6cu0jyorzdXVNQLDGu4fxVdsrUkWui/vcMfK3bKT3yM7cunWVRwcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4H8ja55q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eNtDs+07Xc1PGmhIRhSPJVD9XOMMdV9qyYbJO0N/nw4=; b=4H8ja55qsmm+b8TehMiTaJJnCp
	xD9FiliM1bMF7Ep2acnJP2AUAP/+dCW+/KJOO5nNkfdHPbMkCpnsFRhyva15H/W8IiWJfJU5dYNY0
	YMXp6NRirLgpJHlTESlNcLalAfZ2YJjMQ7cM0CuHJ6AhQ4zTiBkhCoYeaFXrldNBSAfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuICM-006BSv-1y; Mon, 17 Mar 2025 22:40:38 +0100
Date: Mon, 17 Mar 2025 22:40:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: realtek: disable PHY-mode EEE
Message-ID: <303bfbde-db51-4826-b36e-030114b2630c@lunn.ch>
References: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>

On Sun, Mar 16, 2025 at 12:39:54PM +0000, Russell King (Oracle) wrote:
> Realtek RTL8211F has a "PHY-mode" EEE support which interferes with an
> IEEE 802.3 compliant implementation. This mode defaults to enabled, and
> results in the MAC receive path not seeing the link transition to LPI
> state.
> 
> Fix this by disabling PHY-mode EEE.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This patch isn't the best approach...

But i guess a better approach requires we have support for PHY-mode
EEE? Which at the moment we do not have.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

