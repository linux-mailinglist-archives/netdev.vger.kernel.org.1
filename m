Return-Path: <netdev+bounces-280863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOvyOIl16mmbzgIAu9opvQ
	(envelope-from <netdev+bounces-280863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C6456DAA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59D02300FFB8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F431E85B;
	Thu, 23 Apr 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj2ce3T0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB9314B8C;
	Thu, 23 Apr 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973189; cv=none; b=hMijDWAyDfA7j6kw2uXHcwCOFBfI6twa0CP1u/JaRCR35+atPzFcVIRfjgDQXSSd1i4rXRBs/neW79R172QrB1jhBZnc9hV4FWKqGqn4BQcoFPBiUjFO7eIfrSaCjY9iwV09QADruD1NIQqrUJ8m5s3qMr6PCQUoQNCi9RO6QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973189; c=relaxed/simple;
	bh=GGFSJeIzTqFHDDyGBEjnK9+way6aNvCig6oj3Gt/GYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar59laFGC3XVSF5dL4U7laASV5woNtsK1CZx7QORzqqGGcTNA6y5oCRx0bWa9cPzrIX5SUee9NNtWWj/6u9kz+bPWdwyZGQrRCDab9l/yT26ZW5yx1nlRVfkK/qMSjbXghe33rbjs057zAIMW6py8xXHIcPCxcavtHOLeuh8hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj2ce3T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA77C2BCAF;
	Thu, 23 Apr 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776973189;
	bh=GGFSJeIzTqFHDDyGBEjnK9+way6aNvCig6oj3Gt/GYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lj2ce3T0L9yScN0kd0HJwNyaf+d2b/5V9vm0AIXAIcBHsSiGMDC4HzAjqhQkIpIjP
	 yWTI++t+WVKPp9JL7pzb1IT4omD0958Vg9RCht6tZvP8YYqkcpRrf/pBkPofZAL36k
	 pJt1sQUp+wbRptAiiStMS0zwNhFOpk0WFAV0gpibudC0MzCB+riZMONFnVv2nqQvJO
	 k79vWCZROdbo+nOVe4bxOGQ11BIUfjUxvoausJw3O4awJ5N/O66UBKQRskp7wn57ln
	 NmA90jDHG44SvNBJsJeBFWdid8AWh8/iK19333Mr0ArOo0AfUi+S/2fEpZubZKRQ8K
	 7HJLKc1nJIiUA==
Date: Thu, 23 Apr 2026 12:39:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Anderson
 Nascimento <anderson@allelesecurity.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Message-ID: <20260423123947.156ce741@kernel.org>
In-Reply-To: <20260423115853.59273351@kernel.org>
References: <20260423105639.6e0a0a7e@kernel.org>
	<20260422161438.2593376-1-dhowells@redhat.com>
	<2990993.1776970042@warthog.procyon.org.uk>
	<20260423115853.59273351@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-280863-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B9C6456DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 11:58:53 -0700 Jakub Kicinski wrote:
> On Thu, 23 Apr 2026 19:47:22 +0100 David Howells wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > Have you had a chance to look thru sashiko run for this?
> > > 
> > > https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com    
> > 
> > It wasn't available this morning when I looked.  I know there are a couple of
> > things to fix from other checks.  
> 
> It is now :) May I offer the following menu of options
>  - all the complaints are already taken into account / intentional /
>    will be addressed later
>  - I need more time, let's wait until tomorrow
>  - some of it looks legit, apply patches ${list} only
>  - let me respin completely

I've been hacking up Sashiko on top of Claude in these past few days,
and it's far less nit picky. For this series it doesn't flag a thing.
I'll just pull this in, if you could LMK whether any of the "real
Sashiko" reports are actually valid commentary on the current patches
I'd greatly appreciate.

