Return-Path: <netdev+bounces-244498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D871DCB8FBC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB373054809
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D32F49FE;
	Fri, 12 Dec 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CMiBUqoz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A127B50C;
	Fri, 12 Dec 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550591; cv=none; b=CHyH53JR/QvoRhRZvRLIOru/XCeyNFCSDeXg7Kb6nqIUxWRH2AcYh9N6+HUj2ov+Iiy29kaZY9pONVIle/GtaO4s0B94boigIbO3MXNy/yo1W+3x7RSzl9mlUGESwthS45/hRx8qO8yWDdpyBNsPZGn6Xvk9qIlpqI9Jxc/d93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550591; c=relaxed/simple;
	bh=rzMQ/037zwg8z3uaIT3ZqZJNRtyStxnh8UKMN+kQ8IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPLbg1N51mzGqMDnRa+E4bMZTXPJskkJZDIkgoRVwArxuyY3p8AlWsscADEyV1gICvTZj7wPRO5P96nADH6OOAnyM+YJEoHc7ve0lG+r3mZrIdBRDrsDveA0V3KT+ydJ/aRh5OACxv0rhHKrcisPg89wyXcBUJIYb0b4OgDJqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CMiBUqoz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kAASwr/6DNPwttxcrRLp3+naX7IaQbsctQ3H3dxQ2x4=; b=CMiBUqozdPWfhN5fiFIjp5PANS
	GPaJRXWvJyj6Ma582GD90oebwDt3LkYWsLx2fHNUOG4ReYsGWgEW8AZFjYd3NQCYGjwGco5OZLdGc
	VLXNasGJ2r8zFmfZMUqAgf++WCG5DjR/DBBw5sDqw25SYVGYNHro9nRV9NFIMHsfoS2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vU4ML-00GlAX-NX; Fri, 12 Dec 2025 15:43:05 +0100
Date: Fri, 12 Dec 2025 15:43:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xu Liang <lxu@maxlinear.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] net: phy: mxl-86110: Manage broadcast configuration
Message-ID: <64765daa-ae1b-43f8-a81f-a2820d2107c2@lunn.ch>
References: <aTwom4FdQDcTyIdL@Lord-Beerus.station>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTwom4FdQDcTyIdL@Lord-Beerus.station>

> Is there a recommended or established approach for enabling
> user-configurable broadcast behaviour in PHY drivers?

Hard code disable it.

Unless you have a real need for it, a board which requires it. Then
place explain your use case.

	Andrew

