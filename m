Return-Path: <netdev+bounces-119903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318B957712
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EC4284D75
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9D158D81;
	Mon, 19 Aug 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z3T48oZd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9B3C482;
	Mon, 19 Aug 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105009; cv=none; b=rW9MXLlUzeKLuPUmj0zCexTu5urLzA+23FY3QJkoBi2JZes/HLOxpwDfvZLv1WxFNzKLj52atcBm3hYX+kYnXQfaaHWVeLwvkb6mo0EYu+5PDQ+eva8YFWIWSTjrCaFZjRCeBbwxAZlUjM170jcnb5NwDEOYCc2vQ3q8LgegLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105009; c=relaxed/simple;
	bh=/Um0RmFIuy0u5RdZIhDz546qnr0gm/N6GzujyLXJNkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyegC4q8z3OY/qwUDgG3iDPYPZRiOLiJNUyd17KLDsw9yyB5a4TaYd/wMcs9cOiHH7VspVRw2jXozo8qC5UmlbwBjhjoo6URws7yx1YhHPX3G3EFaoe52boVGSDdKuEyRselv1e4eRRnh4uvcH4HgzZph9Q7YWxJjb4i3UM5q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z3T48oZd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1LSVFIQjALML3OzkHveITrXnxye6r3UuLFjLqf6lVYo=; b=Z3T48oZdGQ/QyDrcC9NuMixr9Q
	5tTbQAQEkzSopHVOetbs0YJaEmsLG0BXTwNtJb0L+d7+cVce2gDgHK9iKhSrdx5v9omzKvjTVoLUV
	zz0n/twjYrqn0AGAXTo/ic0E0kdbZUGO14f+pR+V9pjIPMVfBoJ+ge2SLJJXauIGQVWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgAT7-0059oX-8C; Tue, 20 Aug 2024 00:03:17 +0200
Date: Tue, 20 Aug 2024 00:03:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/3] ethtool: Extend cable testing interface
 with result source information
Message-ID: <b2ecfecd-997e-40b5-9478-c7b240bf0a21@lunn.ch>
References: <20240819141241.2711601-1-o.rempel@pengutronix.de>
 <20240819141241.2711601-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819141241.2711601-2-o.rempel@pengutronix.de>

> @@ -573,15 +573,25 @@ enum {
>  	ETHTOOL_A_CABLE_RESULT_UNSPEC,
>  	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
>  	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
> +	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 */

Please follow the convention of given the prefix of values,
ETHTOOL_A_CABLE_INF_SRC_ in the comment. I also wounder if a u8 would
be more in keeping with the API. _PAIR and _CODE are u8.

	Andrew

