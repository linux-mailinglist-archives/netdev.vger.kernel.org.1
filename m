Return-Path: <netdev+bounces-221441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B86B50829
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45E7165950
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC5259CAB;
	Tue,  9 Sep 2025 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sHHLf+YY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE612580CB;
	Tue,  9 Sep 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453277; cv=none; b=q3CaRSBZzH8JCuVV1+GZr/f9y1718ASdXqAzlGkUXVdPB82wYwVDZbt0GANy0bxrXERlaliisdhwA6a/YfcywgwiT79Xcza26ZtmSLU70LmlyfpQz9OKmXZPrvQD7PLqnywDMsKvLz+2AzesNfvRUILIuUoTbsF2IwS9xXv7L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453277; c=relaxed/simple;
	bh=TBjcddyXdui2P0D9MUL0dzdXo1aCkVJmS6lSukGXoR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e79Ocn+OPb5JelF+MASUX+PB8M2oCkTxwLOG8F0cqZvwbvlM6I3oJg/Pr9D/wF4cuB3/+QcJA0ZE54XtrOukn4AitgrPLwWAUi9w7GGOVSb5PX0hb5hwFtC6Mv0mrfOfjpZq+tPuFsmmE0Q7FCtGOAEcCE81Q9zjwpk6Os+znOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sHHLf+YY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CHSm3x+Lu2Cb6X6/0BQX8W9IE/Gr1bHUfNXKM7UAzQ4=; b=sHHLf+YY6VT7CMzW8RAMBkPt0p
	BHn85561f47Inw8NYwv9cgXMAIh6bPqyJbsw3KpRt/9DjDHIyinK4/MjV52UHhmbJXFdQgOofMgCK
	nHiiYw9CpUz9BsszPTOlyw6r3XRi3dL8RnwRbj0foFI2Q2pR4ThmM4+o6EYUAcQdP/+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw5sR-007rVn-5y; Tue, 09 Sep 2025 23:27:47 +0200
Date: Tue, 9 Sep 2025 23:27:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: introduce phy_id_compare_model()
 PHY ID helper
Message-ID: <4f5ab865-5edc-4357-896b-755b142ef9a8@lunn.ch>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909202818.26479-1-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 10:28:10PM +0200, Christian Marangi wrote:
> Similar to phy_id_compare_vendor(), introduce the equivalent
> phy_id_compare_model() helper for the generic PHY ID Model mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

