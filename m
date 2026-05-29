Return-Path: <netdev+bounces-293193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM1uI+TZGWoAzggAu9opvQ
	(envelope-from <netdev+bounces-293193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 137BA607350
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1518E3015A6D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C15380FFA;
	Fri, 29 May 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/uLafvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B6370D62
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079072; cv=none; b=a3oTuhUftE1lmTicVD5oQQOoEZdB8ceRAGV7po7gWFRixBhv2t0+7YY0jZC3yZ9F6ijU/2p1m2zqeltOGKnFW36OfMEilvi7UebZ1MI+Pi5Q3Gg+MneeUvDXlYxWdw9uzMPmeKGSeUEz8C4Sg1sbIDbRc6O8hYYDF2RHBWCyT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079072; c=relaxed/simple;
	bh=wWDxRLxgZd2OEhBcy8qdwSbqqrN0uGpvUo6l+bJQ6M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G21/itkIaj53DaR6we9BMOyG7tM4Kn1Q4Q6ZiU3cErkOWXKsOEi7t7DfwwkcnKxkHcx+MVbwFUAFXUX6UxGHMX3AkniacPDWxFhLL9vKqbqPY6vOkMi2wD2CBD/m7gsT5bmEDzmv7hVEnoLHsS704bPqXeSlvU1+FnfW4CPqpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/uLafvG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451521F00893;
	Fri, 29 May 2026 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079071;
	bh=1sjeWKVlflwMhfQsa4hT1/XP4L2DOWkP9sxkSpmoiwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S/uLafvGPP+MzTCzEVTAnr/zB5MenAak4E8xYpBW8ZtOqarDyEax+MTsH1cOvIwh6
	 qMitNDOsYq9Siyip9meHkKULmwA2t6V9YRuTcWfLpSE6QhoTV4ex+YLpboF0xxTcWl
	 30Jmz7WnVUYAAPGEByzcjf/KLovs9isztpCKWIugIHlRUm4syhPqnTDLPT+2SCWGQD
	 zQtcoWSCEStKui9jiUsio+ziu4+stWkHfHwYcZ9HwVwZFlwLoPraaXng9NDDZyW6JV
	 yLUnOFMWns7KUs4T5mb1SNF+RBEhWPz0nFNPVhP9hQRgzeELOxMN9jUSTi8Py7+r0I
	 nYswPRYMw59VQ==
Date: Fri, 29 May 2026 11:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260529112430.09c1a08e@kernel.org>
In-Reply-To: <5075322.GXAFRqVoOG@ripper>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<20260528142924.329658-2-sw@simonwunderlich.de>
	<20260528171412.7a60e8f7@kernel.org>
	<5075322.GXAFRqVoOG@ripper>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-293193-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 137BA607350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 09:06:56 +0200 Sven Eckelmann wrote:
> On Friday, 29 May 2026 02:14:12 CEST Jakub Kicinski wrote:
> > On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:  
> > > +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE  
> > 
> > What purpose that does "linux-" prefix serve?
> > The unwritten rule is that the OOT drivers have to append something 
> > to their version to distinguish themselves. In-tree version is just
> > the pure kernel version.  
> 
> We don't have a real preference here. If you prefer UTS_RELEASE only then I 
> get rid of BATADV_SOURCE_VERSION and just use it in both places in
> version.c
> 
> https://git.open-mesh.org/batadv.git/commit/?id=8cc63db2462ad7d3ee213059025bf5fffe2e7982
> 
> > To be clear, definitely a move in the right direction. I hope we can
> > move _all the way_ in the right direction, tho, without still defining
> > OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION  
> 
> version.c and version.h are there to not recompile more parts of batman-adv 
> than necessary when the linux kernel version changes. Has nothing to do
> with OOT. If you consider this a no-go, I can also just place 
> generated/utsrelease.h + UTS_RELEASE in the three different files.

Ah! My bad, sorry for the accusation! :)

The re-compilation thing is annoying but it's solvable.
Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration.

Thank you!

