Return-Path: <netdev+bounces-282932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMauLth/82ni4gEAu9opvQ
	(envelope-from <netdev+bounces-282932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BD4A57F6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50CA3306DC8C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B845BD4E;
	Thu, 30 Apr 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spBhA6pg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73444E03B;
	Thu, 30 Apr 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565208; cv=none; b=KilwcehBh5rpmghIXUaYvOZkpyRDPpamN9D4n+caZPYEJlg+Z+4uxrktwVyGM5NegpaUe+qWqCk5Mo0Stie6BaVv2pSK0BYYpyitYS0ixEpqdSvMEDfZquAd9iQtfBLbEQbNcK/L6/QajpYVVw0Bo1J5JQj7XVOuml1tAzHwD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565208; c=relaxed/simple;
	bh=GIRvz4CtKMyqM6AnssrDgYhg/bBnQXEUYJr0j3ySicw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkpgAbjey+CBsJTgG15OQHbRgWkwmsuDwL9d/duH/gWZjzE9jdbM3M7cbJx7nfOwG0FURRXKP8TTKk/UCIhDt+olKvjXqBBfe2X5QIgRACerXY0Xkbc7yXmU0viB09syJeD2uqluRi4begCbF981XXbMAnD3CaxnUPdhC6TQndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spBhA6pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CC9C2BCB3;
	Thu, 30 Apr 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565208;
	bh=GIRvz4CtKMyqM6AnssrDgYhg/bBnQXEUYJr0j3ySicw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spBhA6pgH1M04QfVKtWLIJhaKkIYr5fgTXb55CJZpBl2AGjfsqRBQTc7wE+I5olPW
	 8FhMFBvWPnlcCngSSSD7CQewg1vaSO0b4lPF6xIl4lFOi1mskaMs4cLwMYGcytVGfY
	 X+XLsiiUpNCtsB+c1pb/XTao60QTiI7Cyj8ETEq5wXplUFbthgAusqe3oBHiZcSdJI
	 SjL3rOX7cTC6pzfuA+cxJPKmPEmdTqPz3zFm992coPg9ToO+Obxyf5+kVgz32oQ6HX
	 11oEMFkTP7NopbjhgY1JHm2hgN0tKjXPbJPDthxfvUjEixUw6ObktqTG09/QP1eTDq
	 LsGzBgE9WA0QQ==
Date: Thu, 30 Apr 2026 17:06:43 +0100
From: Simon Horman <horms@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Divya.Koppera@microchip.com,
	horatiu.vultur@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: micrel: fix LAN8814 QSGMII soft reset
Message-ID: <20260430160643.GA900403@horms.kernel.org>
References: <20260428134138.1741253-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428134138.1741253-1-robert.marko@sartura.hr>
X-Rspamd-Queue-Id: 3B1BD4A57F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,sartura.hr:email,sashiko.dev:url]

On Tue, Apr 28, 2026 at 03:41:01PM +0200, Robert Marko wrote:
> LAN8814 QSGMII soft reset was moved into the probe function to avoid
> triggering it for each of 4 PHY-s in the package.
> 
> However, that broke QSGMII link between the MAC and PHY on most LAN8814
> PHY-s, specificaly for us on the Microchip LAN969x switch.
> Reading the QSGMII status registers it was visible that lanes were only
> partially synced.
> 
> It looks like the reset timing is crucial, so lets move the reset back
> into the .config_init function but guard it with phy_package_init_once()
> to avoid it being triggered on each of 4 PHY-s in the package.
> Change the probe function to use phy_package_probe_once() for coma and PtP
> setup.
> 
> Fixes: 96a9178a29a6 ("net: phy: micrel: lan8814 fix reset of the QSGMII interface")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

FTR: an AI generated review of this patch is available at sashiko.dev.
     I believe that both issues flagged there pre-date this patch
     and should not block progress of it.

