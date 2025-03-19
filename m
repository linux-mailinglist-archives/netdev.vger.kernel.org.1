Return-Path: <netdev+bounces-176277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D456A6997B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DA248516E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDF2144C1;
	Wed, 19 Mar 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e2yv1Syg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCE2144A3
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412849; cv=none; b=oBo/GUNZuqtvFZ213kRd/cUAgBJUs4vADt+V+Qdhlyk4B2hsKyWGxZ8n/vV1DHR1u7Itz6GDR9hyk4JMS/4oAVrnB+yvUZ7hyu38lg4rTQWXEHS/zJ5KqvSjuy+xJI2AMOid7t3pTrggYCzCBu6Ii8ZHnvDa9VhHOI+0YnQty/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412849; c=relaxed/simple;
	bh=UmzafZoa7AXiMC+cgx6NlXi9EvURBfs8bWpWe9i+iz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgKNfZzVq4QDrGMtI5KLb8zG7vLljCCUgkaG8ajRlmkcfhFX0MhEeJlW7C71hoiP1f+TOSVbhnJb7VQzPDIgyA+nkaeZxISVK6HOFaOVI+3uvtz3AH06jASrmObQTP33RC7bPqSIHCV+aWfTw7YHXtDwdDWJHK9tTEpHPwtC2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e2yv1Syg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yNIk2ZMZXR9b9CzELF2SLY7h26MjFE2wiObW/SubYnw=; b=e2yv1SygkTC6U64RD9qNsWn+Ii
	hbjebMpz0Bbj7CoZeTt4n0PG37u0rAIC6udyFPnzpaMiqIN0zIURGTkYG2O3YmWm/sdRNnN1Epvlg
	XEVlc1zdRv8UWRxvbb1sdfSPVxMZsjuvBtHkYd2HooPmMbHowzj+uyARki5nrUXg7eYdrxj+NMpOq
	NfpirCbjzIrUs2iQgSOVhCA60I2XsBzt51Q1eRQjC7F7Q6+4cCEcCM0SRBQgr9MyNwy5W9nZFugJA
	2YiZSSXqmcnbrR4DMClNegnDjyt5frOQrvVY4/3LnSqzjs/MoYdXfw1pAKbwO/n6YygnZadoExD2M
	O9OWTCUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32784)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuzAz-0006rV-1w;
	Wed, 19 Mar 2025 19:34:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuzAy-0005s9-1f;
	Wed, 19 Mar 2025 19:34:04 +0000
Date: Wed, 19 Mar 2025 19:34:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH] net: phylink: Remove unused function pointer
 from phylink structure
Message-ID: <Z9scLKGWBoEwVA66@shell.armlinux.org.uk>
References: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 10:46:25AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> From what I can tell the get_fixed_state pointer in the phylink structure
> hasn't been used since commit <5c05c1dbb177> ("net: phylink, dsa: eliminate
> phylink_fixed_state_cb()") . Since I can't find any users for it we might
> as well just drop the pointer.
> 
> Fixes: 5c05c1dbb177 ("net: phylink, dsa: eliminate phylink_fixed_state_cb()")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

