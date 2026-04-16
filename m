Return-Path: <netdev+bounces-279056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIhaN6ni4GlhnAAAu9opvQ
	(envelope-from <netdev+bounces-279056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:22:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EBA40EBCD
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 671643046FF9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22F3242BE;
	Thu, 16 Apr 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE955X1J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDA1922F5;
	Thu, 16 Apr 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345613; cv=none; b=iatIJznRYd2n2dbMjt4jN9vW2S5dTR1lPFpSsQl5NadQ+dbdfDTXsIPmwpIjzeMdFD7qHzCQ3emhYuH/TtXrt3YbSNdv9+rQmVwDCGwhF+lc0WMVN4lFdJlyEkGltXhqkcmtlKJL3Rahs5DQvt1fIoQUxgZ33R5oUkrAIqrhRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345613; c=relaxed/simple;
	bh=E7eGyefqW133ukX7BbFEmtGfErOk/FmhqY5MWm9KLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc92OgF37O0vUj8Ub9/fKEZLhbrKn26MnltSdCLdJUmURYK9hiiDJDlHCoURVI72pKnIZxL449RX3A9iiXAdVU1Cil8mGWsMziGGyb+OJTTgcYgXx/xLmD9pIJQw+8CwRAMRRtWP9g2pOQuBlB2zPnRaIkmMJApq+za6JcJLLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE955X1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4AAC2BCAF;
	Thu, 16 Apr 2026 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345613;
	bh=E7eGyefqW133ukX7BbFEmtGfErOk/FmhqY5MWm9KLN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EE955X1JKX9779kze5sp+z4VPaiXETLF7oHsOPXG5HpyT3Ru4sBTbdsYTGSyVvau0
	 +oDRWn0GLXS+GC1LLpFL84DZUsxWt//juIbWJRLTDtaXU6cbXtu+x4l6QUOqkAlGBI
	 HBhBCilAw2R65AJ5KTSyGjX2zJ6uOagZVC3r0P6ErtU20Mz26T8ZUfLhT01QKKUnsc
	 WQNFDTbmIFm/b0iiyonMKt2j7CogfalHS3oTcd/MudNc/G3pR6fNgyLliiY/bWTfeY
	 1k2oRoH++0k0uv+lNz1qpclXBXC7TWrz6QiA3bZwE5IbQM5BhSevyRIx3qTOaVNch/
	 fmCdBjukZS8cQ==
Date: Thu, 16 Apr 2026 14:20:08 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Charles Perry <charles.perry@microchip.com>,
	Conor Dooley <conor@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
Message-ID: <20260416132008.GS772670@horms.kernel.org>
References: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 85EBA40EBCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:30:47PM +0200, Geert Uytterhoeven wrote:
> The PIC64-HPSC/HX MDIO interface is only present on Microchip
> PIC64-HPSC/HX SoCs.  Hence add a dependency on ARCH_MICROCHIP, to
> prevent asking the user about this driver when configuring a kernel
> without Microchip SoC support.
> 
> Fixes: f76aef980206e7c6 ("net: mdio: add a driver for PIC64-HPSC/HX MDIO controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>


