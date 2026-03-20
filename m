Return-Path: <netdev+bounces-269844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDEmM3kHvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:38:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399672D74A1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DFD3098759
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B235C1B4;
	Fri, 20 Mar 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvuq5Xp6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928635A39C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995758; cv=none; b=QcmGkTnJhkIX8L4mPl21ixBAXCyJkPLcqFkKGju0QkT6hNEGgIVJAkX9NbV6GLT+PKiDZ7wUur8Gd1000tKLvWmkGiw8cdYB43ZiwKyDSTS1IZlfTzOFniLUTvp+uaXh+YZ0a2hKpB/3sM70zJTX2Lqw8WTtEs8H8ZonF4zRtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995758; c=relaxed/simple;
	bh=EXYMoywbEg6I7ipMKu2B+8UWo6AsK3Ubq2SrweO67HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA/WRisuWxwLlF//AzvuJ2cHMmBVYJM1yq4jvp6IBiLO3xVCT4tVOQ6rBa8qrqrSk6fQKoejTST0mfEnE4p1PP5U+YoNFa9T9zzyfIcQb1wGjHrKw3ES9iBMVmkAlbSe+Nt3RA1SX3mlYUaaUS/gXNf5xdX1ZzVeQegPsX/v1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvuq5Xp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C5BC2BCAF;
	Fri, 20 Mar 2026 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995758;
	bh=EXYMoywbEg6I7ipMKu2B+8UWo6AsK3Ubq2SrweO67HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvuq5Xp6UseMUOiaEpPby4k95jxighut/b4DZJTsuIwWnYgTLOvL0TQjn2MzwgcZF
	 hX28dbGQb0hcuVyKHgoN3lb9yVlMlyxeVfuyOZhGBJb0OW5UGQ0clrbWZvBGLRDVt4
	 OMtDfW3MNrO9ucsDZXekMlHrKzRvrMm6WPpfLRqSXAA4+wX0jWYNdYfHB6VBq1wqEE
	 +RhpJ+UWkuKqYbwB7BlLYdt0Nx2PpmrFtFmUWJ0Pibig+cHLF6UXOWsWQ1r8DlSu2x
	 x4+WIqhoOd+XXxTSlQNK89qR2ubrZyjMNx8G9f0lhyug9OANWpYKlKrv3dWWB6u41b
	 rJx34QdM0kM7g==
Date: Fri, 20 Mar 2026 08:35:54 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Reset PPE cpu port configuration
 in airoha_ppe_hw_init()
Message-ID: <20260320083554.GB1753385@horms.kernel.org>
References: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 399672D74A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:40:47PM +0100, Lorenzo Bianconi wrote:
> Before this patch, the PPE cpu port configuration used for a specific GDM
> device was set just running ndo_init() callback during the device
> initialization. The selected PPE cpu port configuration depends on the QDMA
> block assigned to the GDM port. The QDMA block is selected according to
> the GDM port LAN/WAN configuration as specified in the commit
> '8737d7194d6d ("net: airoha: select QDMA block according LAN/WAN
> configuration"). However, the user selected PPE cpu port configuration can
> be different with respect to the one hardcoded in the NPU firmware binary.
> The hardcoded NPU PPE cpu port configuration is loaded initializing the PPE
> engine running the NPU ops ppe_init() callback in airoha_ppe_offload_setup
> routine (this is executed at runtime by the netfilter flowtable
> infrastructure during flow offloading).
> Reset the PPE cpu port configuration in airoha_ppe_hw_init routine in
> order to apply the user requested setup according to the device DTS.
> Please note this patch is fixing an issue not visible to the user (so we
> do not need to backport it) since airoha_eth driver currently supports just
> the internal phy available via the MT7530 DSA switch and there are no WAN
> interfaces officially supported since PCS/external phy is not merged
> mainline yet (it will be posted with following patches).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Thanks for the detailed commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

