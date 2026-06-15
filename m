Return-Path: <netdev+bounces-299415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2R7sCF7sL2prJAUAu9opvQ
	(envelope-from <netdev+bounces-299415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0636860B3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:13:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kQXezVeJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299415-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299415-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26800303B4F2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668863E5A10;
	Mon, 15 Jun 2026 12:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC82379C33;
	Mon, 15 Jun 2026 12:08:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525286; cv=none; b=FtQU3FRTAtIgLHKfEkZ1IwpFYIzsx3wabQWP+8KuoyJ1tyyguQqmk1C7+3xRqbuAemzuoJ/MZWJa+PXZxEVkV7sX12K72Q4MJJYbrvlOFLr4yXSkvRrELzfQk+IxJy3WFzBULfT3FzQ06DDoFToLQ4Y9D/GJEN1n22gVc5/gDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525286; c=relaxed/simple;
	bh=CwJUj6I5kPJ/A7PWvRHQcW6DKhG8kGLWzT1dGwVTm6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHwA/FzqrwWrc2jeS9ZQEtvtrW9SgUUCW7XZCiVynfapY0S59IYx4F2koK6tkCLchrkSriT4wyLF1wcXQcQHby017B/6zB4sbKLsyiDP9KUa4FbylCsfqvrfmLtoVM/jq04GqmM4MBxaLFwVediWjoxVUIchJfZc/BAg1kcEWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQXezVeJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99CE1F000E9;
	Mon, 15 Jun 2026 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525285;
	bh=1mUZryqNrhJrA6yQ4bjuj9ZOB5+Z2b6bKF1iLQiqQNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kQXezVeJNQk6hi5xqqY6qBFU65wqDpm30pzdgat1bSKqOY92y7k7+Bh+tRw1q7L7B
	 bo5snRmcH2/hh9XvUoWy892UwX2dZpH2J/gs+CnR2p//o89OhOCnPkX/5DnHb9xqGm
	 WwYDAxjvdzuPe5yc0dELhQUqdZYlTw4UYOPBgek6YiHSpWZtECfJN/EcjR1mspo47W
	 lpJbGGkEi2SqifD/UEK35M9cXiS50Yxudsu4anYl7u0KmmoqVSoxS1oWTBk7QIeLfM
	 hibpMwkhNNPJoC5mOTMHB8J/2HgVKRX/JiUeJrJBjcRPjuKkjqXRmP2EkNefMOYpb/
	 S9eAaQqZkyLnA==
Date: Mon, 15 Jun 2026 13:08:00 +0100
From: Simon Horman <horms@kernel.org>
To: NeKon69 <nobodqwe@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, victor.raj@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
Message-ID: <20260615120800.GA757061@horms.kernel.org>
References: <20260613101440.80190-1-nobodqwe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613101440.80190-1-nobodqwe@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nobodqwe@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:victor.raj@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C0636860B3

On Sat, Jun 13, 2026 at 01:14:40PM +0300, NeKon69 wrote:
> Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> changed ice_sched_add_nodes_to_layer() from recursive control flow to an
> iterative loop.
> 
> Inside the loop, first_teid_ptr may be set to the address of a
> block-local variable:
> 
> 	u32 temp;
> 	...
> 	if (num_added)
> 		first_teid_ptr = &temp;
> 
> On the next loop iteration, first_teid_ptr may be passed to
> ice_sched_add_nodes_to_hw_layer(), after temp from the previous
> iteration has gone out of scope.
> 
> Move temp outside the loop so the pointer remains valid for the lifetime
> of ice_sched_add_nodes_to_layer().
> 
> This was found by Clang with LifetimeSafety enabled while testing C
> language support on a Linux allmodconfig build.
> 
> Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> Link: https://github.com/llvm/llvm-project/pull/203270
> Signed-off-by: NeKon69 <nobodqwe@gmail.com>

I agree that this patch is correct.

However, I do wonder if it would be cleaner to allow
passing NULL as the first_node_teid argument of
ice_sched_add_nodes_to_hw_layer()

...

