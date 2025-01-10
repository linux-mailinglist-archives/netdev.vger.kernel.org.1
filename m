Return-Path: <netdev+bounces-157220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFDAA097A5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BEB16B041
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679820E026;
	Fri, 10 Jan 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bWf6/m4U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903F213227
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527123; cv=none; b=hVMs+XQU56wl3DBM+vuCjVNXrKcqjgI9NWBoF1btOrXhHXF6bkCjd2nBzUYzv3lbIQTOoo6kDQYJU/Z/WLihA5vxIDpIDs1/RiCUhCd5tb0CG1xMDgwzOpIOln2lvfzqfRFoDQlQWhIMwNkdpiEwWb6Teah5UtOgCwvMSch43hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527123; c=relaxed/simple;
	bh=ic8FQHTkIavz1KP9Dm4WjlBKMToFTyFEI3Sfp6XMjJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCWmNALxQDAjHiiDu8TIS3SSJDykgsUPzYA/brtcLFM41QPHetgcQyp525i9FOVM14Carb3rSWZxxe+LjKJioh0gl+7jFwi5NgcrMnIQHSPtB0MU4eJh9ObvLWQIAFR/h+h8rE3anc5PYUzLnWCaT4D5LYD3GaEH/KxXy35idxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bWf6/m4U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sGdp9dHy1W7SK7azi7NmFMQlQprN1dXVUBvDY6YiY14=; b=bWf6/m4Upki4wePu+pqVHJtVPt
	qT/NkJ2OpBjwDjC419s97SiZ93uHM3f948q9bwrcPLGzw6/wcBIxhpa4wJtncjcub8g194nxmLm0N
	hm42SqWjFWZQ5MuLz16Sa0qH4rx/VtIcJDfvQJsXfEpf29epJDMFQYvIvOi54dliLcDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWI1n-003IAM-84; Fri, 10 Jan 2025 17:38:31 +0100
Date: Fri, 10 Jan 2025 17:38:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: remove redundant hwmon support
Message-ID: <8e4c02b1-ef45-4532-8a08-b6836208c8e1@lunn.ch>
References: <357e6526-ee3e-4e66-b556-7364fdcb2bfc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357e6526-ee3e-4e66-b556-7364fdcb2bfc@gmail.com>

On Thu, Jan 09, 2025 at 11:29:09PM +0100, Heiner Kallweit wrote:
> The temperature sensor is actually part of the integrated PHY and available
> also on the standalone versions of the PHY. Therefore hwmon support will
> be added to the Realtek PHY driver and can be removed here.
> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")

So this patch is for net, because 1ffcc8d41306 is in

v6.13-rc1
v6.13-rc2
v6.13-rc3
v6.13-rc4
v6.13-rc5

but not a released kernel. So there are no ABI issues with removing it
from the MAC driver and putting it in the PHY driver where it belongs.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

