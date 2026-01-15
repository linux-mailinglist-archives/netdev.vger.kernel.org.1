Return-Path: <netdev+bounces-250283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B71FD26CEF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE33D30B5D4B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DA3B530F;
	Thu, 15 Jan 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CbsUxWna"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE03624C4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498916; cv=none; b=hohBQtRekzXKkEs0Yn8HzWu0ei2SIuRulE8iwCZ4heiWdbcLh4roH05/eDmp7dmLsVZsn2dq3woVQPA9W6yW8VDDB8E9KWCVUvry5+uXVw5zHSMaaEC8/eGV2etczTOTRpU6EeuPipPEev58N5WXKTFRCq3f784O7IRtsFiRusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498916; c=relaxed/simple;
	bh=q8KYT4sbvVkbG5IqadL8WHzzvO2Tahgr4QE2etf1VIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bms58tlufMZvV0cN5ORx3bvHAG6l8w7NSmutPive3pMoNrGNRZSWbEQqfYb+UTb8mGjEVKROpvoE6KUFysIxtzsXqcxUMk4pXo9dMhlvTQUOUvXRdzAsNS6enBwtKVnwOx9IC1n2sifHzOMPCYJKQcl8nCvTGdIdgMWvHnF92Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CbsUxWna; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+kDi0Nl3A+slky2xKqNT3JRyrF+r1xn6UkkHjegXuiw=; b=CbsUxWnatxSQjbieGBw08x9PxE
	oq3z3oR4bitdTyXDbS8VOFY86Uzf2NksTtTUqWX8gpKqAOMbTplPjvC+NFbsMw13y5o5XahFqPXmT
	QuDVSYVQukaQuaPwJoApwSiD3K4GXnX0SOwPlYf8Y9CHBF9BgGzCPp3+RECaCaqNvlkY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgRLv-002xwl-OO; Thu, 15 Jan 2026 18:41:47 +0100
Date: Thu, 15 Jan 2026 18:41:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	rajeev.kumar@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
Message-ID: <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
References: <20260115084837.52307-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115084837.52307-1-sayantann11@gmail.com>

On Thu, Jan 15, 2026 at 02:18:37PM +0530, Sayantan Nandy wrote:
> The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
> sub-system, an extra 4 byte tag is added to each frame. To allow users
> to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
> to 9220 bytes (9216+4).

What does the hardware actually support? Is 9220 the real limit? 10K?
16K?

	Andrew

