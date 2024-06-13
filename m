Return-Path: <netdev+bounces-103325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E909079C7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F88E28361E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625F7149C79;
	Thu, 13 Jun 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gm20mQi3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2873149C4E;
	Thu, 13 Jun 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299623; cv=none; b=s28eVgazIEAPYh8gDYFl1hz2yUExx6F75Sw4eKvSe/+fwojEGmMDJGkxlzYBrvC7VUKiWvtBh+fQ/+9+AEAnKb9+qsT3V6zpKA6ba/gWbX8QLqmaDsXP3tDjcZb4YvCJg7cYth4rejhgjRIKIIDFBaWmvfXs+9ib5lwfoNTnpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299623; c=relaxed/simple;
	bh=nddNo4pVZQKRxkA99bQpiH6XyMZVAKFtSQBZLXdSTg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5fiYHyR9bFYg2x2epxQjRaRm/5FSsF0DDbrCH0FG5zQ+N71r7CI2mgcvdOnQ00A09gO546do5rt4DV1YPfrSEd+SXqe16lRiRYfl1pAcTdhYVk9XUaM0CTh/sXCeoBs1pa2VBO5tpeOpZH3PRE6H0uwdSYF2L75A6R7D7tYYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gm20mQi3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YkoTlrKk96JiysjilnH2KkZACVtc7BHMMJmEGj/9+tA=; b=Gm20mQi3cu58Pik6MaCIi1cc2U
	aDLtCB4QyoArahZOsNhudBhMIh4N9VlDN3YMCJdsTB2j7FUDqwuH7mO1J+G7S0gDy6GGhZI9Y+dUI
	e2UpiLGEBNMkT7xLUvyVvElGgPgyT/VyZUXff7d23dtktJHrgVopBFLmIO4EH6uqpXl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHoDt-00HabD-G9; Thu, 13 Jun 2024 19:26:53 +0200
Date: Thu, 13 Jun 2024 19:26:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net: phy: dp83867: add cable diag support
Message-ID: <a0690702-9781-47c9-b7a7-06ab52707c40@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613145153.2345826-1-jrodrigues@ubimet.com>

> The TDR reporting in PD83867 is divided into segments (from which a
> cable length can be extracted). Because the reported lengths do not come
> in regular intervals, when doing cable-test-tdr from ethtool, the value
> of the reflection is reported, but not the length at which occurred
> (even though the PHY reports it).

So what does the output look like?

   Andrew

