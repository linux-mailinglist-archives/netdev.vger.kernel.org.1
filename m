Return-Path: <netdev+bounces-111247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B1930605
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D841C20DAA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8A13A402;
	Sat, 13 Jul 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lEdRe/+g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE231E86E;
	Sat, 13 Jul 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882487; cv=none; b=hUPlWWejpzp/aDsPVWtnikG/l4BUi+WTZQj39ZryrT8eqTAkuikGcHWFLXlom2MLUaHfX8i8XVrLN5OthcZmQ5WF0rS2LgYgDYw7sX8x+7nqJ/kuEXIojg+mSK9huw73MtDyqdq8zwNl3xfnIfvegW+0Fsd7BDUIrX9OO/J2fEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882487; c=relaxed/simple;
	bh=JILoX4cWZkmYdfzXM2xCca7N6CAVWVTdszo/m/TWSbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRRu3hTMc4Cl1dvnwYhqKKd513R0MzUOcbpQs/arwnY95lNMo2NiumKoxYNVZJiUHLyj6XsEyIX/H+4ge/PCNkkY0Fv5mSnO/4en20LgudG3LMtTZCznQRIVhrmgqYas7q3kVW3tegxkX2nGbse7BE0Hdg0+yDcVwE3VDWRGUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lEdRe/+g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/aPkPabH19VpUu4CIy6gNsmOzf5KDbYTNDQV35y2+QY=; b=lEdRe/+gGEEN/WA7f84Zh4wzfR
	HdBTZhJLNYTZLIJ056nB+QzitQc5ScyOupqduZLp3kjfa7qZiIlPhY/4UNHZ5bQEhuBmffCVlHxmW
	TYTEVtufM8VTraxfA7Ie97rOLLoSZ9dgNozZ+CJFR3elm0Lw1G+1pR1MOEJxHGzLHQ5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSe8y-002Sjw-9s; Sat, 13 Jul 2024 16:54:36 +0200
Date: Sat, 13 Jul 2024 16:54:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [LINUX PATCH] net: axienet: Fix axiethernet register description
Message-ID: <cbd29d03-c9bc-4714-b008-ceef9380c46c@lunn.ch>
References: <20240713131807.418723-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713131807.418723-1-suraj.gupta2@amd.com>

On Sat, Jul 13, 2024 at 06:48:07PM +0530, Suraj Gupta wrote:
> Rename axiethernet register description to be inline with product guide
> register names. It also removes obsolete registers and bitmasks. There is
> no functional impact since the modified offsets are only renamed.
> 
> Rename XAE_PHYC_OFFSET->XAE_RMFC_OFFSET (Only used in ethtool get_regs)
> XAE_MDIO_* : update documentation comment.
> Remove unused Bit masks for Axi Ethernet PHYC register.
> Remove bit masks for MDIO interface MIS, MIP, MIE, MIC registers.
> Rename XAE_FMI -> XAE_FMC.

Might be too way out there, but why not modify the documentation to
fit Linux? This driver is likely to get bug fixes, and renames like
this make it harder to backport those fixes. Documentation on the
other hand just tends to get erratas, either in a separate document,
or appended to the beginning/end. There is no applying patches to
documentation.

	Andrew

