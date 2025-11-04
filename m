Return-Path: <netdev+bounces-235523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036DC31EB7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01120423C26
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C002550D7;
	Tue,  4 Nov 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FROoWnct"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0D199385;
	Tue,  4 Nov 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271231; cv=none; b=b4sz6JbkhpFbpE5kUzPc1AcK+0sV1pKMqmEU/cFmRrDwVrfzHZ7Nr8jI9XkGF6gEPn67Ms3nIkGwG8I8euAZ/3SDPxAdqdGyp6xIaPkalEPIPTQbOiJ1620PBuQl5blgMCyX+z2WlVkHEnAryX7m4MAzLdtLYuTsIrWg7OqGz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271231; c=relaxed/simple;
	bh=YNHMR9Jla3bG3jY/KBByy+ewldizloJMXcS50QhJ6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+L5JocTv7l8YYvv8y+orQ3xv87xAljl2Dk6Z+svBteSHNFkfTq85WDmn+OIzgPQMeJm+WISx75Sur4ajw6NAb0elMcBDAcS93TyyA7jIyFpNlpu+j5oO6SHBKRgzbO9AOz/nSyhTA6tlz8hyxq+r/9aeqzQiUAIicnSZv4464U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FROoWnct; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sVcWQWRT/+ZC9br9URqsUiBuXIHakkuM4BbnSgXDHBs=; b=FROoWnct9Blk3q9zFvsBTNanRL
	i66HcfkFOMBKYACUKX8NY45oV5cBlt85ZjXszbXUQ2m+RLn8lywt2qR39eknMv/StojUeD6spjzAh
	etK4DkOORAJxSWfN0ghaxyNg7kThnrvDb6AV3HNmZUiwbOvaIRzZ4fgHgJtdu+SByNDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGJFC-00Cu4T-FU; Tue, 04 Nov 2025 16:46:50 +0100
Date: Tue, 4 Nov 2025 16:46:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add OATC14 10BASE-T1S
 PHY cable diagnostic support
Message-ID: <a202e0d0-4ece-4697-89b3-28bd9e3d07b1@lunn.ch>
References: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
 <20251104102013.63967-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104102013.63967-2-parthiban.veerasooran@microchip.com>

> +/* Bus Short/Open Status:
> + * 0 0 - no fault; everything is ok. (Default)
> + * 0 1 - detected as an open or missing termination(s)
> + * 1 0 - detected as a short or extra termination(s)
> + * 1 1 - fault but fault type not detectable. More details can be available by
> + *       vender specific register if supported.
> + */
> +enum oatc14_hdd_status {
> +	OATC14_HDD_STATUS_CABLE_OK,
> +	OATC14_HDD_STATUS_OPEN,
> +	OATC14_HDD_STATUS_SHORT,
> +	OATC14_HDD_STATUS_NOT_DETECTABLE,

You frequently see the first enum has an = 0 at the end. I don't know
what the C standard allows the compiler to do, in terms of assigning
values to these enums, but it won't work if it uses 42, 43, 44, 45.
etc.

Otherwise, this looks O.K.

	Andrew

