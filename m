Return-Path: <netdev+bounces-267531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL7YEDg7tGk4jQAAu9opvQ
	(envelope-from <netdev+bounces-267531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:28:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9B287023
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BA6A3008245
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55836405C;
	Fri, 13 Mar 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwDjLg6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCB35BDD5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419318; cv=none; b=WpJtjkiJ/sVY7lMS+S+isFyvbvCXc1R2IQTV8TdEDXvilTJwvjAEjY1T+agJnjd+A7KvypYW+WWSuYW6ATRBHGCdKQfsE8OXeyRe/4v3u6vr3MfwgrrVfKUSoLWp+CGPolgOhAiOPfB/hZH7iDs3Jqg1TB1N4NTT8SbSevDuF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419318; c=relaxed/simple;
	bh=jKX0pj1jKoF+guypTdltnGFFHDEUGXo71s4o3l+W9ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFXFtVxX5/ngX+hGTfnp5/kP6wNPXjkHxadDSu53GUugrPl/wf+hxlykpAJbKTaJ8e7BSqPlz6cKGA0ZXDUy0W3PXAiuDr4hqpdlPEczj1E5w9osynngcT43YO/tMCGeZrhHeXFn2nNazweU8lvbgKQ1ZGTKi9HGhXSvF/SAYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwDjLg6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D9FC19421;
	Fri, 13 Mar 2026 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419317;
	bh=jKX0pj1jKoF+guypTdltnGFFHDEUGXo71s4o3l+W9ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwDjLg6jIO0j0FTjXyAfgw0KCGHJdLhSMgy1pL3MJmbzy6Srl/odcTsWnVe7U+cp0
	 IacU1BcRWTNaqqoDFj5o9pnRSPa0T5KDbFPlD0VWqkRgl4LfanuNCQR6+tniPU56LI
	 3QMIg7nSn98UedFpmrli2/EmaRSvbPJ0RLuQoB2aOeVbUfIF01VRb1w6/pgxl73AYA
	 01eeI7zdaDI/kGZWvQpVCC/LrT9YgRq1JeOJgupkW4K/39nHdBQD6Rf2CNOp14WqO2
	 l0vlaNEyb8SHVX5gKSvVNnvZ9U68d24u0ZsJqn/daxnFvnSlIYhbh2iNOpHT8YzO6I
	 SgvafFB7qbLtQ==
Date: Fri, 13 Mar 2026 16:28:32 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: avoid passing pci_dev
Message-ID: <20260313162832.GA1363644@kernel.org>
References: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFB9B287023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:13:52PM +0000, Russell King (Oracle) wrote:
> The pci_dev is only used to provide the ethtool bus_info using
> pci_name(priv->plat->pdev). This is the same as dev_name(priv->device).
> Thus, rather than passing the pci_dev, make use of what we already
> have.
> 
> To avoid unexpectedly exposing the device name through ethtool where
> it wasn't provided before, add a flag priv->plat->provide_bus_info
> to enable this, which only dwmac-intel needs to set.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


