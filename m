Return-Path: <netdev+bounces-176928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31299A6CB4A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921E83AD2B2
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693D2309A8;
	Sat, 22 Mar 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zv9VS79H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EB70809;
	Sat, 22 Mar 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658613; cv=none; b=prOHpGDPr9AFuUEeIlHVhIRLwUnM+UsLNqZ0CUteFbHHmmnQFkM+QdEpKG6HYUrL4gDagjkfqb+rYUhXx0CS9TV9WdpdhuX1OrApYwz86jOEDUj2JiaKkiuMCUzKKWOFTFLbAfNRoWXb/LkqTU5sxQFUvfGquQp/2HRu2ifYNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658613; c=relaxed/simple;
	bh=cucS2Sa6NoyQTCD0HbmPA13xdiP+TBhe7gVdSE8cit0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1m9zCmADRNJISm0US5s/OLlPDWiUlor5z2ZeB4IvC/zYHYAY1IJDYwyNt92pXbUbowkZCNl0YY6bglc3IfVXM6yEbVs6rEe8/ey4PxPn/Sgg5qFjKM/oWFVROtm35qcQbOZyqXRWRWb8aUhbAmtqCVKgL+HHwe+F6t+iHdNMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zv9VS79H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N3ESk4vMnD6UiAmqLrcNDWUozQqCCXr1IGO0DZxz6kU=; b=zv9VS79HBeis9k+7m3UIb2Oq8E
	6aGuLiZL6xsi0fJ1nhG8CCdde6d8GoiXQbtiVWPPF0cOYzQfL7ySfZu2kjIg3yFwmKtPr3GyLAFJc
	DIR6SpsGbXjVwgYX2vOnc6oPMigXYfaMyo/ShPnsjWL5KkkMb7YnZyNh28MMkYP/y2Hc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw16q-006jcy-8a; Sat, 22 Mar 2025 16:50:04 +0100
Date: Sat, 22 Mar 2025 16:50:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/7] net: tn40xx: create swnode for mdio and
 aqr105 phy and add to mdiobus
Message-ID: <9edd482e-f410-4aa1-9d55-792bfaf5eead@lunn.ch>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
 <20250322-tn9510-v3a-v7-5-672a9a3d8628@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-tn9510-v3a-v7-5-672a9a3d8628@gmx.net>

On Sat, Mar 22, 2025 at 11:45:56AM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> In case of an AQR105-based device, create a software node for the mdio
> function, with a child node for the Aquantia AQR105 PHY, providing a
> firmware-name (and a bit more, which may be used for future checks) to
> allow the PHY to load a MAC specific firmware from the file system.
> 
> The name of the PHY software node follows the naming convention suggested
> in the patch for the mdiobus_scan function (in the same patch series).
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

