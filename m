Return-Path: <netdev+bounces-174774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A7A6048D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE619C469E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D291F5821;
	Thu, 13 Mar 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wXb11wbo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0618B48B;
	Thu, 13 Mar 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905715; cv=none; b=HF6ahW+VMUSyniWyBLPOUXJBExV22p56KQOtqIGFvN7ICeI8qrBYSAIKqcGu9A/RJUh9dNfHjBuxJhAR7JW0+Gbb3WJIX331AMwP+8QvxS58EQqLPQKqjDbySjhQjjoi64GcvB3Mv1Wy7q51YlGT7uyDeCYVtONfmzkTrXcnImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905715; c=relaxed/simple;
	bh=kmQLpP1H/8R9Re5ysO3RWYCNcQwK9I9FBWIQICank4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZLLLN6PMpGDKaajB5Cb2LxB7L+G/XGynUM0zwUaSMoeEcRjkim5TRZFerXlHwaNh1OU8hI8ZlwhvkzNnlmuBv6LxQU7ZhKKxS/T8m9+PM+VcNYBbkh3N9vs7SB7x2/vaduLRJjv+dSOHBG96ns4v806CmeIBbbrTqq09GsSbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wXb11wbo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o/1Mh0o88Dsb3LEqDeTz/KouVD4jeGs3U4MDb1Mlz1A=; b=wXb11wboAunMU07oXJuhWFbgd5
	aJpj/k9vObm1zqZS3szTeZFJROQeX+GijsnYf3MJ7cNndJ+PplW9sF9Uedl/Os4phaLpsR2zUhc0I
	JKHIBOFvidUdzs1JU1E/lRadZjY1ACecfk+uHw5IitYJRWy5G5mS/DTXg4ajGIUFhUhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsqiZ-0057P3-LD; Thu, 13 Mar 2025 23:07:55 +0100
Date: Thu, 13 Mar 2025 23:07:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Message-ID: <f6165df5-eedb-4a11-add0-2ae4d4052d6a@lunn.ch>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
 <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
 <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
 <6ae8b7c6-8e75-4bfc-9ea3-302269a26951@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae8b7c6-8e75-4bfc-9ea3-302269a26951@alliedtelesis.co.nz>

> I'm pretty sure it would upset the hardware polling mechanism which 
> unfortunately we can't disable (earlier I thought we could but there are 
> various switch features that rely on it).

So we need to get a better understanding of that polling. How are you
telling it about the aquantia PHY features? How does it know it needs
to get the current link rate from MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1
which is a vendor register, not a standard C45 register? How do you
teach it to decode bits in that register?

	Andrew

