Return-Path: <netdev+bounces-284602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAGVBId7+mlePQMAu9opvQ
	(envelope-from <netdev+bounces-284602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144984D4ABB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 865C93008FFF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF063264C2;
	Tue,  5 May 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGv3ZvQS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFB21255A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023297; cv=none; b=kl/XXbhQvTQK/dj94jZuhSVePbBrFgo0b4Oy4R1cA/3QwrpZ+llvV5UJC7Kne/BrSBxAYAj0vf6HPmsSSazZY+9sJjv0637IbrWN9NssdGgLRcuVY2p/a5M8QZ5KGA6FGrYMM0Xe3JTAYtTECNeHrTlxdbfM0U6t9xxiji+egMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023297; c=relaxed/simple;
	bh=mRTIFtNuxZYumxF7+GS+t/V5M4NQFuc0MwoExPvZUqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWl2J1uGCHTNdgbSxsVAKdQYsSN53dh7LxxkPJZXvLSiFzAMt0YrJ5nmFF3vk950ab9Gc2uYnNi1YaLR6tt8PCykrXf4/UFYC9VyqD4+ExHqAtIlngYhSsGDcndN3UegEF3jrg3KkEAURindH2N39v8aCqmYHqWzw+V66x7V4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGv3ZvQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD8C2BCB4;
	Tue,  5 May 2026 23:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023297;
	bh=mRTIFtNuxZYumxF7+GS+t/V5M4NQFuc0MwoExPvZUqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGv3ZvQSoswg3lIArBuZAHgLf6xkocVZ8DlsBHvF4a3P0wNfYVABG7SbyjIs2COzz
	 GM+5n7HM9sy7nhDgaOd67LbGQYHX2ugf9bqYVrlKqLLseEdL/5vBSMhfXspve1Zie8
	 0HzLcZNhqO8UCLszrkISOwjhYmlLFmzqc6edA2FOxp1vW0N6AptL3xpkHgXLr7L7wg
	 nAw5wVy33gYh8/pc2dpd3G5DofjI+1xeGkm/XBzi7kOQu+IKVxgMqtS6WT4b1BfMiM
	 m1AMB5iJmVJUA3wskDDUlsWiJ8IPJmoLEoQZUqwKMQ/jul1/w+Tt4FI1RjqDsb4hvY
	 24+0nLxjHbyZA==
Date: Tue, 5 May 2026 16:21:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] ionic: Report "link_down_events_phy" in
 ethtool statistics
Message-ID: <20260505162135.5fa39358@kernel.org>
In-Reply-To: <a1a9ebf6-fde7-40bf-ada4-7b032a5fdafb@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-3-eric.joyner@amd.com>
	<20260501163951.0e0b7e97@kernel.org>
	<a1a9ebf6-fde7-40bf-ada4-7b032a5fdafb@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 144984D4ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue, 5 May 2026 12:53:26 -0700 Eric Joyner wrote:
> > We have a standard stat for this:
> > 
> > struct ethtool_link_ext_stats {
> >         /* Custom Linux statistic for PHY level link down events.
> >          * In a simpler world it should be equal to netdev->carrier_down_count
> >          * unfortunately netdev also counts local reconfigurations which don't
> >          * actually take the physical link down, not to mention NC-SI which,
> >          * if present, keeps the link up regardless of host state.
> >          * This statistic counts when PHY _actually_ went down, or lost link.
> >          *
> >          * Note that we need u64 for ethtool_stats_init() and comparisons
> >          * to ETHTOOL_STAT_NOT_SET, but only u32 is exposed to the user.
> >          */
> >         u64 link_down_events;
> > };
> > 
> > 
> > IOW the definition of this stat is - ignoring asymetric link faults
> > this counter should match between link partners.  
> 
> So, this is a little awkward to talk about -- we are already filling out that
> field with a stat that's calculated by the driver; there's a task that monitors
> link transitions and increments it.
> 
> But, I'm not sure if that method exists because of older firmwares or cards not
> tracking the link_down_event count for us. So, I didn't want to just overwrite
> this stat with the value from firmware because then we'd lose the count on cards
> running firmware that doesn't do that counting for us.
> 
> So that's one reason why I put the stat in the generic ethtool stats output, and
> gave it the slightly different name "link_down_events_phy" to distinguish it
> (this also matches Mellanox's name for consistency) from this stat in the struct
> you posted. Though reading the doc comment you posted, this new stat really does
> belong there.

If the stat is currently filled in with something that does not work as
documented it should be fine to drop it. The counter is optional and
relatively recent. I think it's unlikely that any monitoring will have
a hard dependency on it.

