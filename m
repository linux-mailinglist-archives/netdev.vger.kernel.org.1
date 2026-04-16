Return-Path: <netdev+bounces-279059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNhpFKzk4GlhnAAAu9opvQ
	(envelope-from <netdev+bounces-279059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9AA40EDAB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1D5A300C9A2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827F3B38AF;
	Thu, 16 Apr 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooFmWVoy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1A39657E
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346189; cv=none; b=rQ5cd/RrTkqMMcjSA6QWo48BQiL5Jv4qui+Hv8NR71MSaxXuPLRZRNPBAWNbcSgCSNKFEQ4z5GazWeL6Ij0qGR613eaRZO4w1rWvaaFzcOx89ubgCNPJXvnAM/r4sPJMzlbsDAwVBYLRF6hzFkqoDK6sfK1T/wuh5cK5Glcq/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346189; c=relaxed/simple;
	bh=TD0UVB4QDOczS9ajeE/KW9nzXJ9QMZAv+muPY3AVbBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMJJWptp2Tq9r4FwYEkhByhCO2Mk3OADlT7YVEL5kZFYK9yQ5KFF2CaNKWN1w4hr0PacmqUYmniCwfaHWahM6aw8L1HyCofTPB3k/DAgCsimp0UTxiqWKh02NQdcANBsRhV1266/5j3EjvBmtO+ub60dXheZST2A6hOEd2zyF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooFmWVoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0CC2BCAF;
	Thu, 16 Apr 2026 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776346188;
	bh=TD0UVB4QDOczS9ajeE/KW9nzXJ9QMZAv+muPY3AVbBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooFmWVoyjulIZ/2UdJhww0q8nlp7Uhqr1hnAlDc/yFgA3h/6B9xUU6Jjl/rCmbUlN
	 wFzZ1USo3eG1YUV8iaCJkmeKm+9Kiv79TP+4rmyp730Jh28nLW+ThOzxq0kJHFFKJw
	 Tl/L0DwZEjdYM3N8Ih037NVaBnbPmADeidO1LupkcFmQayZ1VxGmVrzcrcAltMxyyB
	 duwh0wznpmn8OiDYuDGHQ57E8X2IKTDvAKv/oDU/RwPA29tHtRJJIHkefEH1UqtkRF
	 22Fz3KLFlBa8aKbyOsbGqm0UOSAEsNuiWOn0TL84kU0KQyvXmMKQWHpte8CGk4efva
	 x11wXirEycBmw==
Date: Thu, 16 Apr 2026 14:29:44 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Message-ID: <20260416132944.GA863718@horms.kernel.org>
References: <20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org>
 <20260415164643.GQ772670@horms.kernel.org>
 <ad_DrrC6duye_lR0@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_DrrC6duye_lR0@lore-desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279059-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9AA40EDAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 06:58:22PM +0200, Lorenzo Bianconi wrote:
> On Apr 15, Simon Horman wrote:
> > On Tue, Apr 14, 2026 at 08:50:52AM +0200, Lorenzo Bianconi wrote:
> > > Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
> > > airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
> > > TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.
> > > 
> > > Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
> > >   order to avoid any possible NULL pointer dereference in
> > >   airoha_qdma_cleanup_tx_queue()
> > 
> > This seems to be a separate issue.
> > If so, I think it should be split out into a separate patch.
> > 
> > > - Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
> > > - Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org
> > 
> > I think it was covered in the review Jakub forwarded for v1.  But FTR,
> > Sashiko has some feedback on this patch in the form of an existing bug
> > (that should almost certainly be handled separately from this patch).
> 
> Hi Simon,
> 
> I took a look to the Sashiko's report [0] but this issue is not introduced by
> this patch and, even if it would be a better approach, I guess the hw is
> capable of managing out-of-order TX descriptors. So I guess this patch is fine
> in this way, agree?
> 
> [0] https://sashiko.dev/#/patchset/20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022%40kernel.org

Hi Lorenzo,

You responded in a different sub thread, so I think this is probably
implied. But FTR:

1. I agree [0] is not introduced by this patch
2. If the hw is capable of managing TX descriptors then
   I think that [0] is a false positive

Regardless, [0] doesn't effect this patch.

