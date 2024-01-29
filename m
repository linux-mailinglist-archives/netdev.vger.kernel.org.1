Return-Path: <netdev+bounces-66553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314283FB2A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 01:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954CC1C213EF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187318F;
	Mon, 29 Jan 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6L/k/k+i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87546634
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487201; cv=none; b=IGzp9eN57aVEO6WW/CtlMKwdBtg64GLitb5HqjOkaacNtP3ZHqL0wKyyAGWGjkODgt7pj5GxkIREk7XxF3DjHCzuPbPV92TtPrNLrGyfCgG5PfrybY/9vm4A/1FrR6GXRccYEWlIP2CGsHbBFeD1K1qbThq1EGkFWCcTHZKUVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487201; c=relaxed/simple;
	bh=e6rht//779Kp45s8x+t3Ta0Z7jkjDeJXb9JEQi6uo3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MffFvCKP5HBFu4xHH86XKeSugYYvkbI23vpRHAoFv2dmFF5L3GC2MVpu/Pl08tclLXLDRWwP7MjXQgptnqHC+kLOuzWpRSNviviFU7k4Q9CihyKI1mSVGuYW9Qfju3joL8eOnlf6nmdRqPsGoeNnnXLUQXpwJyj+/lNWKquqAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6L/k/k+i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t9YJL+6ifTrAruKmR1+5I1QL/oC4KCffwVF6bz5a+qA=; b=6L/k/k+iQ34BVQpSLzENzoD0z0
	9eMPtObvDIkq++e4A0dPgOlyFmTKBNnT76q3F0/KSCY5962aV80YWfvynzfdvwwGO/IoEbcQS3rb1
	gU48DiRx64kApE8P6txIZxlSVRBvxp3maRtxZGfiEOT2LRXz3k52WJP+q0KxkMUMu6Xs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUFGx-006Kr2-GO; Mon, 29 Jan 2024 01:13:11 +0100
Date: Mon, 29 Jan 2024 01:13:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/6] ethtool: add suffix _u32 to legacy
 bitmap members of struct ethtool_keee
Message-ID: <73b28306-21fc-4071-b9ad-b5409dd277a8@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <3d4f2051-90ab-4aa7-bce8-3622cbfd27aa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4f2051-90ab-4aa7-bce8-3622cbfd27aa@gmail.com>

On Sat, Jan 27, 2024 at 02:28:47PM +0100, Heiner Kallweit wrote:
> This is in preparation of using the existing names for linkmode
> bitmaps.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

