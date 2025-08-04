Return-Path: <netdev+bounces-211602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A4B1A54C
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110607A23F2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14F202961;
	Mon,  4 Aug 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AB+VOytT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4660367;
	Mon,  4 Aug 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319263; cv=none; b=nXeg2mlEIZTIUvw5UCjqhHVQItI5OwaviZAy4qY6SIkZD0/uE0bsmPRi+UyHiRrCiKV0RMAt28OO9rsIkMlm6V8qHY3VNxClPI47ZVB/KWrNSMAa5WjcppEIt0XcZ84UiTbgPZBdGVZmcRkcdGWo3uEnSBm1s0bzyMkDQFmQTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319263; c=relaxed/simple;
	bh=jCMJWwYlr4J0X8/4vVzJbWQqy9TRR6vVrOUGMFK1qGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI+REL0ZC+Uby2R5e1LCPueIrpLCn1oAk5iZwhP8pcJrufdCmUUB5tYqVoxNPSv3zAA3BbT/8vGsreOE2yDlq0v3ccdDt8ZnZMcfqLH+fZlqHeDdkRPdZ06jUcv0mTTtOGfbwDmmU2rMwlQSWbAe2eugHhCqux5oWDYhtNdjEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AB+VOytT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jrFQwCo1xWqosXts8zjdtVWiV6mVo0cdC1KxEXN6Nl4=; b=AB+VOytTiwcqaV3NDhle+365yG
	PXm1FWtWqMLR2keiXDClrD4esYbeiRwcLCf2PKq86liWpaUm1j7xQe94MjrSfIqLUH0snK71WRj4c
	vY9TooqmPMYzoulKQxGRXVjl3/0nfq2vGGdaUofXFry991FZMTRqfoqWZF9JtilPQJPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uiwZZ-003ijB-8g; Mon, 04 Aug 2025 16:53:57 +0200
Date: Mon, 4 Aug 2025 16:53:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <9d578a13-0be6-45fe-80b1-0588d2dfa9cc@lunn.ch>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <4acdd002-60f5-49b9-9b4b-9c76e8ce3cda@lunn.ch>
 <aIuTqZUWJKCOZYOp@shell.armlinux.org.uk>
 <aIxUWqTSpwkJEV9Z@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIxUWqTSpwkJEV9Z@FUE-ALEWI-WINX>

> I don see any firmware problems. I have one of the latest builds, and from what
> I understand, the firmware consists of base image and additionally a
> provisioning table. But this table is a kind of pre-configuration. That means I
> can override the entire PHY configuration to my needs.

This pre-configuration is what i don't like about these PHYs. It means
you cannot assume any register has the value the datasheet says it
should have after a reset. The driver might work for you, but not for
others because your firmware has different pre-configurations to other
firmware. So in effect, the driver needs to write every single
register with a known value...

	Andrew

