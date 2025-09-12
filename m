Return-Path: <netdev+bounces-222726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8FB557E5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FAFAC4B27
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EC2D47E0;
	Fri, 12 Sep 2025 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QhU3K4iQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C215C0;
	Fri, 12 Sep 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710165; cv=none; b=kib2F61d2S9aVX8ZpZgKp7yfa/yQex4j6uPe+6z78s4TwT8qpF3y34RbHNPhL8ireojZOYG/ZldQ9BvG5lAbjlqE+WGs34ciwSgEjv/ZmWPMGRx6PENflG2SSSsZoOID5D5tadPB8ZxWw8fjCfW1EMq4YRhy+6TZZdfigF7AaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710165; c=relaxed/simple;
	bh=Cyr0o8hFbBPPMclsQ4IpBU5CK5O+ROtO5ZGoexxGkzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrOSL/g3R02te1ctv3heNd8KVFpFDypBaHx4W/e/ZYiDHpVr+hyUIGYS2ymmoNrENkGnyvK8/sysKNyH4u/Jyg3XEYk+k4K88sD2BVy51jfFq+wXD3BuRlvoTF/y8B0lRjFMFhJQGOdyHo5Hi85VsmNzQyxy9VGgnSnMgbmqfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QhU3K4iQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QYnTzN6gjk1V62nRFuBUob8dYdTb4gR1ZVzcqrzfX9g=; b=QhU3K4iQeiZ9oPSOZ+eoh7CkKw
	Amrm0o0Ull3Hp9+SfF8McDK6Y0QT8xpCQHw64vu5pGuBELPk2k0ZPuLiraRJ1kJPTX0OtcOGdH9RF
	G1PmZ43Ta7MIN09WAjR/sL+6f8RMgXrwu+9mGtlQnP4a9UZrW3qzdNiniHgUuCDCiQCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAhg-008FuC-C5; Fri, 12 Sep 2025 22:49:08 +0200
Date: Fri, 12 Sep 2025 22:49:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v5 4/6] arm64: dts: allwinner: a527: cubie-a5e:
 Enable second Ethernet port
Message-ID: <45ec4777-51c5-4ed4-a1a9-568c3c027482@lunn.ch>
References: <20250911174032.3147192-1-wens@kernel.org>
 <20250911174032.3147192-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911174032.3147192-5-wens@kernel.org>

On Fri, Sep 12, 2025 at 01:40:30AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> On the Radxa Cubie A5E board, the second Ethernet controller, aka the
> GMAC200, is connected to a second external Maxio MAE0621A PHY. The PHY
> uses an external 25MHz crystal, and has the SoC's PJ16 pin connected to
> its reset pin.
> 
> Enable the second Ethernet port. Also fix up the label for the existing
> external PHY connected to the first Ethernet port. An enable delay for the
> PHY supply regulator is added to make sure the PHY's internal regulators
> are fully powered and the PHY is operational.
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

