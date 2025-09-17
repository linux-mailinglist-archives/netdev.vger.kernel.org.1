Return-Path: <netdev+bounces-224009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5FB7E8CE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823EB188E72B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEAD30CB51;
	Wed, 17 Sep 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U7QIVbC2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208301A76BB;
	Wed, 17 Sep 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113399; cv=none; b=JELSbO+qt+WhYchxuwCjfZf+KP03t/Y+y1dRRA/t8Sl/QVa64nB0xqfCweg1OFGEWegek+ZTkVRNWD0QX/FytWawgEBB8wSwZlG3O6XHNrERe1Sn7lOoLqwJlsaJ35cBaLl8uQn5FlX3EUOoxU8QXtWzQkOjvbbiIlqqLAxxRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113399; c=relaxed/simple;
	bh=sHei6uVHnE2QzMvQFzab7qbk3dhyqGbXW9tH7AkJOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdNCouCCtQPmecTD567DdKeD49zPnD8/NJdKHp1Nvu/zcSE31L+ZE4Kf5z4eD0vz0nKUbZW9BgmwL2vmMqXtgRA3hHfDDbpPkCe0+Bd0kJC+VxMrPxVUlhRG7AL/0Rm75G96qT9C3PCSLSpPDXhAuVv5A2JEPC3SJNECpvG9L9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U7QIVbC2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b1ZOPZrGB3gzRi4MB+vIpGB9lVTWlQxCvO5gF7adQPM=; b=U7QIVbC206yGoi65q3TKXphFGU
	SG8D0LKxVrD+qDanFBsHnJrxOh1WA+kyFd41zpO71bf9KuzjzBdmnoUf8TCGqqF02K64NJ+dXr+yU
	johy32FdCmgxeEXfsz4bHI0SVYTGs7umE3Txzipa/G60yp9hCE2Ofk+BeJ6gcQgEoO7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyrbY-008gNy-Oo; Wed, 17 Sep 2025 14:49:48 +0200
Date: Wed, 17 Sep 2025 14:49:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: micrel: Add Fast link failure
 support for lan8842
Message-ID: <7fee1c03-63c5-4847-b24a-e46bbdcaa42e@lunn.ch>
References: <20250917104630.3931969-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917104630.3931969-1-horatiu.vultur@microchip.com>

On Wed, Sep 17, 2025 at 12:46:30PM +0200, Horatiu Vultur wrote:
> Add support for fast link failure for lan8842, when this is enabled the
> PHY will detect link down immediately (~1ms). The disadvantage of this
> is that also small instability might be reported as link down.
> Therefore add this feature as a tunable configuration and the user will
> know when to enable or not. By default it is not enabled.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

