Return-Path: <netdev+bounces-249812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08DD1E63D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 479393058A2A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9F394476;
	Wed, 14 Jan 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B8nwzilc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DF38FEE3;
	Wed, 14 Jan 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389995; cv=none; b=GOb8ZGUTMX1C6tIGwgB9GD4dsnCNjAfe7s1MQP/Z7DA5mKGTjKYcL+Juyw1sNxpxPV7rvBzw212ml8hiRf9jFR3jN4rEMW5E2sD8R4BPmJF6xULvw/4/rP0m2gqK7O6OlpGvdAoDtJx+YIF18tK3zxNsvdwvTklLpWPKWm8KCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389995; c=relaxed/simple;
	bh=3R7aGXkmrAlcnHbsJlqLfFOTxNQctONIW+dEMUzHkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgOF46hhhTXcIibaB1E0Bw0S0hEx2YvWwfu3XoBBZioyLsk5Zv/law9sbNMQitNU49EXf6VCDPzBbY0sWjA4L+P9I1BEtl+ZelJBgEwgIYz+jFIyeStq8fRdXbpfOIqJsz0BfY8j1HqGUMvsriZxl7bieILWb0eglotmBwUWeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B8nwzilc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U2VBhAIqVc+Ad2EEEY7j2m8eAnaVVil1jXNoQt+h07M=; b=B8nwzilcna8h+RA5veOgLMmWev
	NVJ+7+pjZAdT7xdnWNHnOcMaZUyApk36jynqZPWvHwb5sFsKdPLVkjyJ7BVRYXtI+/wS46ms8i88+
	0AvSNERwAOwG6I6QEBxVI5XIoYi1wOvgxRW5ROXCSStTJViVAhaifPpBWn5c+4vUgvjGQ2aVlf6Kb
	SnSm+hq6sh8+83sR4mGxYgsGnQ5Z0qV3yF9HOThoq8C48kMeIeCn/mtQyXk7hLN4iymZV2TD6eac6
	st8m9Z5vW/l09JHj3nI3Ui0cRqFTiuiWdyHGbNToBOOAEJoH6NERLHi37ACuDN/mdEd7+F7Kqfr07
	jKfdbJAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vfz14-000000008Vv-0IWn;
	Wed, 14 Jan 2026 11:26:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vfz0z-000000001bw-1RuS;
	Wed, 14 Jan 2026 11:26:17 +0000
Date: Wed, 14 Jan 2026 11:26:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: kuba@kernel.org, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
References: <20260112200550.2cd3c212@kernel.org>
 <20260114110031.113367-1-tao03.wang@horizon.auto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114110031.113367-1-tao03.wang@horizon.auto>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 14, 2026 at 07:00:31PM +0800, Tao Wang wrote:
> after resume dev_watchdog() message:
> "NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"
> 
> The trigging scenario is as follows:
> When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true,
>  and the last_segment value is not cleared in stmmac_free_tx_buffer after
>  resume, restarting TSO transmission may incorrectly use
> tx_q->tx_skbuff_dma[first_entry].last_segment = true for a new TSO packet.
> 
> When the tx queue has timed out, and the emac TX descriptor is as follows:
> eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
> eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000
> 
> Descriptor 221 is the TSO header, and descriptor 222 is the TSO payload.
> In the tdes3 (0xb04416a0), bit 29 (first descriptor) and bit 28
> (last descriptor) of the TSO packet 221 DMA descriptor cannot both be
> set to 1 simultaneously. Since descriptor 222 is the actual last
> descriptor, failing to set it properly will cause the EMAC DMA to stop
> and hang.
> 
> To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
> tx_q->tx_skbuff_dma[i].last_segment = false.  Do not use the last_segment
>  default value and set last_segment to false in stmmac_tso_xmit. This
> will prevent similar issues from occurring in the future.

While I agree with the change for stmmac_tso_xmit(), please explain why
the change in stmmac_free_tx_buffer() is necessary.

It seems to me that if this is missing in stmmac_free_tx_buffer(), the
driver should have more problems than just TSO.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

