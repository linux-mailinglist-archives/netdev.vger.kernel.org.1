Return-Path: <netdev+bounces-165347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B79A31B92
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BFE1677FF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757670809;
	Wed, 12 Feb 2025 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u0eNQkhh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBF1CA9C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325241; cv=none; b=I9hd62CSKBk93p3Y+tqfrhdXxi2WDdJi4P6Uj+0JxFWt6usVJkf4+jYank97rqk9/ApY9D7hguUUwyYVoNzX6ZI39kUZKfF8rMLAO3U0qT7b0aH2TO0UcNtxmwoItAE9z1G6BKpYXr2UcdU3kU+zw16wmjiLyaeJr1MOWUPZbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325241; c=relaxed/simple;
	bh=fyMm4nhD0Wh4AbhqvIPJiPdSikHLX0pz4jqRraqik9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnqgykDbugN7a5EfMag/dKOKCOkrRmNIRIOtARhMEFsbYTwJyRYQWF9vPxKgHcXW+7o3OcmPF4vqb9xx7h/9CRoBrPHwcBElwvA6Za59YaPTBoXHv/oFIxeWq8d7D7gPJI+MiNWWbDAME3XA2Yl3XAPZmTcdhzXQx30g25/AQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u0eNQkhh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qAw437I0JcgYcW27A0ntYHYRaw1lmpPc61sfVUgFbyg=; b=u0eNQkhhXcIGIy9q3ww/EZYHuA
	79byOMcBCq71+Ah0BAy3dmn2nIF8ffLVMfsnJVO8wMavllSVsZ+SaO4LpkoEc6GExS6VlbMVYKID3
	D17CqGjaSUbRoMYgy4AX3EwsaZm+j7skbSIV8Gc6QmCr7Pi04cIe2eel4yI41P8PArg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti1wm-00DF9N-C9; Wed, 12 Feb 2025 02:53:52 +0100
Date: Wed, 12 Feb 2025 02:53:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] net: phy: Allow loopback speed selection
 for PHY drivers
Message-ID: <163593f4-473d-4a7f-884b-d5617edc2ba4@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-2-gerhard@engleder-embedded.com>

On Sun, Feb 09, 2025 at 08:08:21PM +0100, Gerhard Engleder wrote:
> PHY drivers support loopback mode, but it is not possible to select the
> speed of the loopback mode. The speed is chosen by the set_loopback()
> operation of the PHY driver. Same is valid for genphy_loopback().
> 
> There are PHYs that support loopback with different speeds. Extend
> set_loopback() to make loopback speed selection possible.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

