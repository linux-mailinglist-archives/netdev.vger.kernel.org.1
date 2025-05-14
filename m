Return-Path: <netdev+bounces-190573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F9AB7A45
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4D01BA7245
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5C22A4EF;
	Wed, 14 May 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fkuXlE2g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF61FC7CB;
	Wed, 14 May 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266991; cv=none; b=FqzwcjU7Y92AD7qyICZ1ggucIf09pBlmqyJUC72xdQFU7z9JQY/kktTFywumcOs4lniTADqsJCxRGhLdAoVNyZlPiI8eZLoiwu7gM9xmk4Ds8cxLEMxx3jRkQXA/Oq/uZJpIV3FUKRgeWC/ZUeN+gobexerVFTRGypQfo8PkoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266991; c=relaxed/simple;
	bh=YjuDc20yD3zYfkam5SCRBrQenV5e7Hx0huQEmIbUDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yio4tQFDG4xtuU8oyCBqfFoaDVCC4dqAInAHHMmsb8FDUydKeSfLP3ejAvpWaSF+Il7pgV1WknxkJ6VrteqPgz84e8WsbrY3Uw1Kb6+QdhNJZkqGMYxPAf+cPuzZ6OWaF30C6rJOHfuZ3dySmAnjOBpaREDGFmYuNRY6W5CoM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fkuXlE2g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c/kmfchyOtnnD9armwcuETD5tHj5mjd7I0LLNz2Cgc4=; b=fkuXlE2gzjJAlv6f7SwVqYYu7b
	s6yIImsurhqMtm1tCOuUE1/S2tmHTQULWr/yQvXPcsEwVrY8iVz1wuKfnLNOFGOKZRHb6uLrdds1j
	D5JzfkA6kG7visCVX30AKWeGWZJvVzkExMQbSy7N2foVsvMnMgp16G0UDJQ4mySEyvQs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFLxW-00CcDJ-Va; Thu, 15 May 2025 01:56:22 +0200
Date: Thu, 15 May 2025 01:56:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH v2] net: phy: mxl-8611: add support for MaxLinear
 MxL86110/MxL86111 PHY
Message-ID: <d994cff7-e960-41fa-9ce6-c35cee3a2560@lunn.ch>
References: <20250512191901.73823-1-stefano.radaelli21@gmail.com>
 <20250514173511.158088-1-stefano.radaelli21@gmail.com>
 <4c64695a-fb98-4b77-a886-3a056e6b229f@lunn.ch>
 <CAK+owoid1woDTiCxcGiEmdvKNHJeCnaKBjPEHyNrtHt_hKqi9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+owoid1woDTiCxcGiEmdvKNHJeCnaKBjPEHyNrtHt_hKqi9g@mail.gmail.com>

On Thu, May 15, 2025 at 12:29:48AM +0200, Stefano Radaelli wrote:
> Hi Andrew,
> 
> Thanks again for your detailed review and suggestions,
> I really appreciate the time you took to go through the patch.
> 
> After reviewing your feedback, I realized that most of the more complex issues
> are specific to the MXL86111. The MXL86110 side, on the other hand, seems much
> closer to being ready once I address the points you raised.

I did not look too close. Does the MXL86110 not have this dual
Copper/Fibre setup? Removing that will make the driver a lot
simpler. So yes, submitting a simpler, more restricted driver is fine.

	Andrew

