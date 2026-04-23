Return-Path: <netdev+bounces-280880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCb8HB+T6mmr0wIAu9opvQ
	(envelope-from <netdev+bounces-280880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:46:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD7457F4F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D524E301DC23
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE13D6485;
	Thu, 23 Apr 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE+nck/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561163D5668;
	Thu, 23 Apr 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980764; cv=none; b=cQpFsJVQASwAG6urD5bCyyhDPlKC4BHFxWrBnxEhhnS7JVgSUYUtUYy6mHsgWINYJuk0VXfjxEOiYi+t6xt3Ja3w7mEuC+1Z+ZGDQh7TQZ2mXzsn1bWBoJJ6qucc//6ooO0Y8lWbqAcLpDB8kpHPJHfHXDj7e5nfHEzcGA66Ios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980764; c=relaxed/simple;
	bh=qByhxwu6Bt5xslpZsiI4eQ4Zl4sKrReDFKD5Bfhqfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9WzYr9d/LztxY6Z/zrCalZdhufOIchSN/KnG9GDsMoUH7KE168p6DnOT8aNsTLQSqJaqzdocXxb1msVYei7g1lM5jrpUXJNy4MFDlnz408J6gLtowT/kPtnQS9c3D+ywm9zU7OExSPngXXnMn2b50LQkRk213VSaAaXi8UfwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE+nck/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53671C2BCAF;
	Thu, 23 Apr 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776980763;
	bh=qByhxwu6Bt5xslpZsiI4eQ4Zl4sKrReDFKD5Bfhqfvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iE+nck/o9tVtvqzqBfb2DzoXx/daOClAwVG3siDCPi26JTkdqcJeHlRDXYvX2aK7g
	 IgSKH+b+Bq6yaG39Porqo/a/sMM/5uOw/uYFo6AgBvgOWbL+jnzKlJyhIxcxqClKmA
	 c9YP84BvjC64jrv8c1bNw+65hbX6UeAy7o/tCiXt/DhVbUt2dQ1jTLiTTyGNoZBEDr
	 j3dupUgXtEvNeDUQhL9WhO9o3O27eJMOMcLQVunWqjIyujRVCudd4AIvJjwToKT7LI
	 lXpUzfkzvR55dhJ2qeVgIlUgrYfcHEUOhQFrIavZbJZ9NA55vVwuN9ByCIeqzvB/S2
	 j6BgzYjETIIwg==
Date: Thu, 23 Apr 2026 14:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Anderson
 Nascimento <anderson@allelesecurity.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Message-ID: <20260423144602.127b7068@kernel.org>
In-Reply-To: <3047316.1776974185@warthog.procyon.org.uk>
References: <20260423123947.156ce741@kernel.org>
	<20260423105639.6e0a0a7e@kernel.org>
	<20260422161438.2593376-1-dhowells@redhat.com>
	<2990993.1776970042@warthog.procyon.org.uk>
	<20260423115853.59273351@kernel.org>
	<3047316.1776974185@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280880-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3DD7457F4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 20:56:25 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > I've been hacking up Sashiko on top of Claude in these past few days,
> > and it's far less nit picky. For this series it doesn't flag a thing.
> > I'll just pull this in, if you could LMK whether any of the "real
> > Sashiko" reports are actually valid commentary on the current patches
> > I'd greatly appreciate.  
> 
> They're all valid comments.  I've expanded my series by two further patches
> and modified two others (one just a trivial missing space) and will post a v3
> shortly.

There goes my hope that we found a way to reduce the noise.

