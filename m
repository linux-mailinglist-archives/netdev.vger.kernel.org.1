Return-Path: <netdev+bounces-260628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLVpK4TtnWncSgQAu9opvQ
	(envelope-from <netdev+bounces-260628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:27:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B9B18B5B0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10C031FBDAF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126A2C0F91;
	Tue, 24 Feb 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN87nNtg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84B2C027C;
	Tue, 24 Feb 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957071; cv=none; b=itBDZKbWCXbzTrTq2akI0Ihx9WUP1gPBoFmIl6Egpeg9PGSMO8/B1K2I6oGuO4dCkUoK5n5ECu2WMDGeEtc9KEsgWDBErwVjHYs4FIFRUczfOvhvi1iHjBq2otUuqJqudv1MVadGP+SC9wZsdodNd+tMrJVdkD7ewt4f81IHSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957071; c=relaxed/simple;
	bh=q50JDotDeBfPCyxduuHGOAeQUqHLzD9vSewxG18NxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDTdreAzLviYsbp7raRa8LY2mLsckVdukHMBIizma7CMYHm6IToY1DevRwefBhGfTtJZkHTRquhseNJEIdhUlTbar8u2a9obKALKLPlwskEHoTsp08iChf7PH3mLtYeWirr1MdsabQ9CpS5d7oSNSPPG7jIIILcCxQbJpL4PGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN87nNtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE4EC19423;
	Tue, 24 Feb 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771957071;
	bh=q50JDotDeBfPCyxduuHGOAeQUqHLzD9vSewxG18NxyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GN87nNtgC2XNEVnLOOVo+mzSX0arU5K58tzmVTT5jbZIBuZLEVvvlfKqWAVYlZ+IH
	 1sTiSb+ccZeFW/puirrTKeyuWntQJiF4bb6ycBYYuCxghhJzOXxxo2+hwAsVKWK/7T
	 3nnicaNSj/AeH4D/nxcyWDrU4SBPYkYHGHTiX2SpJpKt5eDsPycrBOhEZkL7D1u+o9
	 vevCjg6JzQ3q3F9onfNrk5nPOF0Aa8a94qNzNrWHOJONBh6Bm1WbXLkMMEkqJzl2mI
	 3+e123k1yFhk1sK0Azk76c5Mi987qDaDMOs0nNjpaDwc2QrSgZ2X1V5IdKMLEL5bLb
	 2OdGinZMhmKXQ==
Date: Tue, 24 Feb 2026 10:17:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <edumazet@google.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <sumang@marvell.com>,
 <sbhatta@marvell.com>, <davem@davemloft.net>
Subject: Re: [net-next,v8,09/13] octeontx2-af: npc: cn20k: virtual index
 support
Message-ID: <20260224101749.015d6f89@kernel.org>
In-Reply-To: <aZ1DOQOswkO6bgmP@rkannoth-OptiPlex-7090>
References: <20260202074607.2535569-10-rkannoth@marvell.com>
	<20260205022525.2271130-1-kuba@kernel.org>
	<aZ1DOQOswkO6bgmP@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260628-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B9B18B5B0
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 11:50:41 +0530 Ratheesh Kannoth wrote:
> > > +fail1:
> > > +	if (xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> > > +		      xa_mk_value(old_midx), GFP_KERNEL))
> > > +		dev_err(rvu->dev,
> > > +			"%s: Faled to roll back vidx2idx to old_midx=%u, vidx=%u\n",
> > > +			__func__, old_midx, vidx);  
> >
> > This isn't a bug, but there's a typo: "Faled" should be "Failed".
> >
> > Also, at fail1, the rollback attempts to insert into xa_vidx2idx_map to
> > restore old_midx. However, looking at the control flow, fail1 is reached when
> > xa_insert() to xa_vidx2idx_map fails. At that point, xa_vidx2idx_map has
> > already been erased, so the rollback target is correct.
> >
> > But fail2 rolls back using xa_erase() on xa_vidx2idx_map, which was just
> > inserted successfully. The rollback at fail1 should restore xa_idx2vidx_map
> > instead, since that's the only map modified when fail1 is reached via direct
> > return.
> >
> > Could the error path rollback logic be reviewed?  
> This is getting flagged every time. i dont see any issue in the logic. Am i missing
> any thing here.

Maybe rewrite the code to be less confusing and so that the LLM
understands it? For one thing the jump labels are supposed to have
meaningful names, not err1/err2/err3, or fail1/fail2

Also perhaps xa_store() could avoid the erase + insert dance?

