Return-Path: <netdev+bounces-165182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282EA30DB7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DAA167B4D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5A24C66D;
	Tue, 11 Feb 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JzpGIwRG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64424CECB
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282728; cv=none; b=Ne95ga29AGqSKglw/YvA8gmI11NmkCYukEzrZYwiL56eDzlrRz9zOsTFAZYuH95iL4QEPVgigL3mewuyobXVRinkJZ9ARbp1Uf8OtKH2KOqtlDUAmMMlRcoguJy+a7ggON9EXpC9bKu+9bWx8NJnD1uwkgrNmiQllSetcDHICJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282728; c=relaxed/simple;
	bh=Vjp8BGagJBy5zyknqMToYmpH2sSSMz4ci/YY3lj8NTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPLw0SLbxnJYvj1EyIiYG/TvIYOTTzblQM7xH2EkZKN3+2dxfSXL8uFabihL5Gg6ieXuaPBFWy0kaJoX02I7dMWz/IyU7K/qEgvetm8dXQoO6wdwWAGggEGRiZ4Vcb2NdY0bGxnAu993On9YlXuzWjLAG8WzschYcoEKajsSlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JzpGIwRG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z3YTgAjKxNgsED33gsgTJw1o12Ejo0oERoakUKGqqGA=; b=JzpGIwRG/6drwOt74hbjtUqul/
	A4FiBlL3Fbqw3JsF/Z95vlEc/SH06o2V4oZC8jFXfktSSV2mvd0bJ+elczomN5gtt7IoVQf24nmZt
	dq+AfHqyqlH0todQRM23m9/aXR7bIB26nmeZElM18ISl1tfmqXDAX9nBpdQgHc4rWEjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thqt6-00D4vC-Te; Tue, 11 Feb 2025 15:05:20 +0100
Date: Tue, 11 Feb 2025 15:05:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: rename eee_broken_modes to
 eee_disabled_modes
Message-ID: <a6bc4c6c-f5e2-4bce-aa8c-fd2bd85dab94@lunn.ch>
References: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
 <6cd11422-dd67-4c87-a642-308de694af92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd11422-dd67-4c87-a642-308de694af92@gmail.com>

On Mon, Feb 10, 2025 at 09:49:22PM +0100, Heiner Kallweit wrote:
> This bitmap is used also if the MAC doesn't support an EEE mode.
> So the mode isn't necessarily broken in the PHY. Therefore rename
> the bitmap.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

