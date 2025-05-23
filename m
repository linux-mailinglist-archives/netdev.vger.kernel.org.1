Return-Path: <netdev+bounces-193091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FFAC2789
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1103A9ADB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A9296FA0;
	Fri, 23 May 2025 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h/5y2yq6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF64296D10;
	Fri, 23 May 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017492; cv=none; b=eBwnUh2Ipu+yWQ49RdSTHzsJhVVEgrnuZwxKUYYWQ4aCGF5LYgS22Xwu/PcmNW3c46izZS9Se13NpRwxcnYdo838NN3Llsvlegxo0AG+IxGisky0Xj2X6IPwWt1GpXEuJ/lt8FzpEl4PtwrABWLM3wvu8dPIFLBW88pBjZd2wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017492; c=relaxed/simple;
	bh=OMWbik/NljTxLVHitW6Xb4QzUTsQkPmTYT9rwbPrbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2sOtgWp9pCH1khRXib+p0j5q7Ee8JvBHA6+50m6MAcLZT3G9+WAyzHzk7bVNWPadzR4W4xoY9q4h7sM/K1utsAYb3heiaT4YjNRwcOosKZj9CVVwnuxaEyXDW8KMKEu44ndhI0Kuf6qVPIfS0NJw+hD1dP4rSc4gLT3FDs7Kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h/5y2yq6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hESkZdTC/uPfN133oPdSMXZrn+AWoJwgnuY0gQbq8Z0=; b=h/5y2yq6rqJ+DpodOUjbbUA9UH
	3FsIPsT9p6sYu3aybA0lNR/jckqqHIVW6GKAGZzJVy6+HmBQ50qdYsqbLNhjUwsitqZBH9jT6GPFG
	ACLI/0D1scNt4ZAmNxUb9vyv7FDaEQf5xhreyudwHoFuv1VVXatJJT3fA9rWiiTEZkcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIVCM-00Dd7D-DB; Fri, 23 May 2025 18:24:42 +0200
Date: Fri, 23 May 2025 18:24:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net 1/2] net: lan743x: rename lan743x_reset_phy to
 lan743x_hw_reset_phy
Message-ID: <3d701ee7-253a-49a4-8097-0231aacff459@lunn.ch>
References: <20250523054325.88863-1-thangaraj.s@microchip.com>
 <20250523054325.88863-2-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523054325.88863-2-thangaraj.s@microchip.com>

On Fri, May 23, 2025 at 11:13:24AM +0530, Thangaraj Samynathan wrote:
> rename the function to lan743x_hw_reset_phy to better describe it
> operatioin

operation.

With that fixed please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	Andrew

---
pw-bot: cr

