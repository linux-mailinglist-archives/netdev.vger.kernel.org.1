Return-Path: <netdev+bounces-280114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HmVLnlx52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53043ACF9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A03013028665
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7AA3D3002;
	Tue, 21 Apr 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KayMGw/U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE493C9EF0;
	Tue, 21 Apr 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775168; cv=none; b=R03fA6IJQ0RrkR5ki3uUCXBKdUCN/ZwVujl+OZ0D/YkeHV6zWpxcdf+VNJf/fBziEHJ3FOuXaTKmkiesF4ePJTtAarQ2+OAZ9pUVgkxtb49yg/SY8AgW8gA7ElfbmKArSxFCATOxPJ1nEU0gnnTwxtcCpFeVDefZMXlKv3gLEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775168; c=relaxed/simple;
	bh=FZRxT2Zxzs9+HC3NXjgSkzE/MF+8oH7QSAOwbGXNAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXtirZ/afKqhRWOKYIlnMnsoEpR4dRbiIvH3ftTZjpUGvra8mIvOcZYUXpP9R/KZMm3w3UKS+dktEQLv7KXWFwBfl9shrfQMUp+cGzKADt1zMfOqj8ot6bed1mG0IttXX+EbiRRLa6Bg5MV4mrl8l/T+AhL7SZpBBIxG/DWP/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KayMGw/U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yKZf8xxpFuABnQc+Q/sZVGBB6lGknC2PmRrdojznxRY=; b=KayMGw/U7f6U0o+MVkUTCLVn6k
	0SHiX1+lckzzD7EGtxujnxHDk1UDww/XxCwfEUDDbWsWHekp5fjXiN0P8IU0L/940BitOEjmKxETH
	wblmkC1SvSVhzMJuiMszFy/g7XTo2522FLOSFWOBe8zx/1+vq+jEITePQp2iV8z1ApIw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFANn-00GtRj-V0; Tue, 21 Apr 2026 14:39:15 +0200
Date: Tue, 21 Apr 2026 14:39:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
 <20260421115008.2690541-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421115008.2690541-1-j.raczynski@samsung.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F53043ACF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -78,7 +78,7 @@ static const struct stmmac_stats stmmac_gstrings_stats[] = {
>  	STMMAC_STAT(rx_vlan),
>  	STMMAC_STAT(rx_split_hdr_pkt_n),
>  	/* Tx/Rx IRQ error info */
> -	STMMAC_STAT(tx_undeflow_irq),
> +	STMMAC_STAT(tx_underflow_irq),

Please take another look at this one and think about it.

    Andrew

---
pw-bot: cr

