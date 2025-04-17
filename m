Return-Path: <netdev+bounces-183861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C69A923F0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E50440FFC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847F255238;
	Thu, 17 Apr 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BDfj3BtD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC314F90;
	Thu, 17 Apr 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910814; cv=none; b=kHIO7orepT2FTF8YgTRp9jK3YhLMSmx776+rRAkFWn4Ud//b5falTVdU65tig42k7s9h1ALQywIvFSzMOTeTp+TB1WrSKQl5XOn/1T/ufjy5kS6hhz3gxFQwu6hGoD9/HXMpe94Ln7BdWBRMNjBCLuNTOc2pZjI2tVQzivkG5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910814; c=relaxed/simple;
	bh=MhwF/BwHo6EQq2Mw/JlLGUsZKi6aWNKmwAb9vucDW6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvMBf+3fv/GSopxWSR6R6ZC6wgdB9z0lCdevqk9/y+BCy/qnYK3NAMp3cqJYGNG7o+ui4yppkHNsZtTV3RvdXvF9CcjK4eV00QXkEBG24/KFHvT02vyq5Rttp4ql+l7uPafXZoApk24fArGI1TUi1m+7Z3olD1EOiccILtli9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BDfj3BtD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mwH5L53HDNq+argaP1eYSzJK66XTnQVpZ9LqansbCzs=; b=BDfj3BtDbRYXNvTqh5rzikbE3R
	CkZNiGTRvdNV0dSi1QUVqpFs3jTX6mtxkjH+rnFnzZipMcEEryYMybNEXbQstbvx7AZOZ80xoMoQX
	jRfA/0pwoBiEc9hd9jJIOPuq5nRKwYloZV36gZ1Y5OjF13QGLBUnDs5F0dGn/+X5amgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5T0f-009oLn-FS; Thu, 17 Apr 2025 19:26:45 +0200
Date: Thu, 17 Apr 2025 19:26:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: Add entry for Socfpga DWMAC ethernet
 glue driver
Message-ID: <03dd6fb9-fb9d-42e2-8f9f-e53c77e34bac@lunn.ch>
References: <20250416125453.306029-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416125453.306029-1-maxime.chevallier@bootlin.com>

On Wed, Apr 16, 2025 at 02:54:48PM +0200, Maxime Chevallier wrote:
> Socfpga's DWMAC glue comes in a variety of flavours with multiple
> options when it comes to physical interfaces, making it not so easy to
> test. Having access to a Cyclone5 with RGMII as well as Lynx PCS
> variants, add myself as a maintainer to help with reviews and testing.

Thanks for signing up to maintain this, and helping out Russell with
testing. We need more developers to take ownership of the stmmac glue
files.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew



