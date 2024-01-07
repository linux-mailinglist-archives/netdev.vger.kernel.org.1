Return-Path: <netdev+bounces-62241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B905E826526
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF76A1C21548
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7A12B60;
	Sun,  7 Jan 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gh5Mwg+d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0F13ADE
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mqlTmwQiLAzIdbPcA/JxSq+0uzGlZHDWhZsN55vYGpk=; b=Gh5Mwg+dBpqjukJzvQrono+0i8
	IYBO2YnZwV/5V3i1KcoOvj8cA0gGlOia2QKAyMDXW9Tc2nNbkGzPV6W8WSKLatIFV18hCYVfVcwHm
	jgf1b6aH4tx7gvnyRFEGyZ10vEBenuQV7W6iRpF62CqlR7wsTm+0fmS3rg5N7GCyCyVs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMWCV-004Ztr-Er; Sun, 07 Jan 2024 17:40:39 +0100
Date: Sun, 7 Jan 2024 17:40:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 RFC 3/5] ethtool: adjust struct ethtool_keee to kernel
 needs
Message-ID: <ef42a586-0b5a-41c4-af4a-50a7d839fa1b@lunn.ch>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <bb510240-edc5-4e52-aadb-fe00c0c94708@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb510240-edc5-4e52-aadb-fe00c0c94708@gmail.com>

On Sat, Jan 06, 2024 at 11:20:43PM +0100, Heiner Kallweit wrote:
> This patch changes the following in struct ethtool_keee
> - remove member cmd, it's not needed on kernel side

Ah, O.K. That invalidates most of my comments on the previous
patch. Please expand the commit message of the previous patch to say
that keee cmd will be removed in the next patch.

> - remove reserved fields
> - switch the semantically boolean members to type bool
> 
> We don't have to change any user of the boolean members due to the
> implicit casting from/to bool. A small change is needed where a
> pointer to bool members is used, in addition remove few now unneeded
> double negations.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

