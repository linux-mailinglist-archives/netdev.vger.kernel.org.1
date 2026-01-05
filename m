Return-Path: <netdev+bounces-247084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D75CF455B
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E60FF300769C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE053128DC;
	Mon,  5 Jan 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1KhpNIvR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E673112D3;
	Mon,  5 Jan 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626118; cv=none; b=X13sKr5n9V6tZa2K5w6R2OvPVcBXVrEsFQLY8eSjYfvkPuOLsCTyzJ+npzhOmG6eOe9ub0ewcMMaboVYPcX+oFs5a/Y81+2ojxy4pkeWdN5/pTPmXnX/MVpGK7BzHJj5XUnYTAzKPiLgS/BJ97aJ9Gniskl5Zdlmo6j/P/L0bA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626118; c=relaxed/simple;
	bh=5n+ANbAU4ANCbpqDjRTT25sSPAglUK25gtviJYwYo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9K8HsVmONeflc/y4KGOXnvFD1L3rOGFJpS9cymVmJm4urGqzFQO2sSIR2Elh/+AVDY1IkmDdN40Az9rOX1DurHrAvrZ+iqlX6qYCf6JoeyBwf0pJ28j2kan//mXiZsEFYm3s646/fe9ct56ClkKsrrzEnnYzB/StTmF+sp0Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1KhpNIvR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mV6sFDh5Q+DxptEQ1uojrM6H0FNZVatRu3qJldV/mwk=; b=1KhpNIvRMrqcJZnhBM/f0EAcf6
	nnGC2JWU2ssXBeV/OnF3AeSxNN1dreBV6hp7fxszApYO+R8Zwpiyac30cFCFOOuuULJ6HEYr2alR2
	Xj+IEfNdDEXJL+kF9ha+gdlS5DTSHHSDLgmKGdpotRAFcSI48o5akxR7g2daTXcmWIqA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcmIa-001V34-8l; Mon, 05 Jan 2026 16:15:12 +0100
Date: Mon, 5 Jan 2026 16:15:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	sumang@marvell.com
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <f247416a-c774-4e32-86f0-9a3c22342f1f@lunn.ch>
References: <20260105023254.1426488-1-rkannoth@marvell.com>
 <20260105023254.1426488-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105023254.1426488-2-rkannoth@marvell.com>

> +static void npc_subbank_srch_order_dbgfs_usage(void)
> +{
> +	pr_err("Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");

Isn't checkpatch giving you warnings about pr_err(). It wants you to
use something like netdev_err()? This is a network driver, so you
should have a netdev structure.

       Andrew

