Return-Path: <netdev+bounces-247817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1ABCFF3DE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EAD32D595B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0F34678B;
	Wed,  7 Jan 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3OZIkils"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26734C838;
	Wed,  7 Jan 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802157; cv=none; b=lQRx2XBIXQe8HqXylC/nCQJrqHqvKcN85g6LMhCs4pbIOXCcDhfpSBAEIwN5uAjEdbwZzqQrvCa+QwCiHfo2/vTsUSHSvoL3RK/zwdmMvRGL9BlhMrxJ+iRmB4s9L5BlIWIgiNFIUhrzfw/40ppnWJTOYjfU6x4SEwUy9D1G5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802157; c=relaxed/simple;
	bh=V6QSAx6MThja6qsI138aej9awptqBrYw/QJWGZV6GL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/K4TGY+oaZYUjZiBn2/X1RROJF8HoCQOvocNrV+lVjkaIUiD04+fVJEIi/B/OAZq+1qVh7sAzWrFao9oQl13TcwA6KOmYVrEBrEJZ9Z+v8kheT5BPbO0PDCChhdi1rEe8SPL/YPaLiC9PoPdzH8ZIaORz8zUvwuWMAuMmFAN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3OZIkils; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xe2Xoa3Wd6mU+Mz7riqkrcJ34QnmVwIIYSGu9XDIBwg=; b=3OZIkilsdZ0m+n8qdoL1yzGKZa
	P8D565to+O1QF59hxiSo3T1DPRRI1J0xPYOcETTsHRY445xoLAr0yv/VNvcK4Mff5P6FSjxWHAvNE
	5NWwyuAQA8WoLub6epCbYC3X2huISE2E3OU6o49YnwQdoiZ3MrOXAnjo4evoOSHOt3iY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdW5k-001pGB-BL; Wed, 07 Jan 2026 17:09:00 +0100
Date: Wed, 7 Jan 2026 17:09:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Message-ID: <ec093af3-93a0-4a9a-9688-ba870d42156a@lunn.ch>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260107155427.GB345651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107155427.GB345651@kernel.org>

> I'm slightly unclear on the providence of this patchset.

This driver needs a cleanup before aspeed fix up the mess they made
with RGMII delays, which is going to make the probe code even more
complex. In a fit of boredom on a train, i made these cleanup
patches. But i don't have the hardware, so passed them onto aspeed for
testing and bug fixing. I said they could submit them, appending their
own Signed-off-by:

	Andrew

