Return-Path: <netdev+bounces-293192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILdbIuzYGWqjzQgAu9opvQ
	(envelope-from <netdev+bounces-293192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:20:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9C607310
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26BDD30027B3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B58400E18;
	Fri, 29 May 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTqUKRzh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0719374736;
	Fri, 29 May 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078826; cv=none; b=HbalO66Xr7ko2m6SVl8q8EXrJ4MlEzG6lfwvA1hWXatJjQZtne1ddFd9c52PwHx3k9RHwXi+9nAROzBI9iqCWlBFiIyFrjH8eNo2Z1JlVfLPu/VgpBvG2A9s9jd/ouimahYPFJyGSs8xeeoy9njpGlFRYNjkSPgHabjvYG51nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078826; c=relaxed/simple;
	bh=usirvGFJnGIEJqXejy9CS0lk+DVgpLgywayZdaqg200=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+OeyqzCWhLK0ccSkkpIz/LdN+0nTW0mQBPTx9iW43knQnzqQi4ysu0iPOnz/i+/B1V9CJrnmj18iu0ngFlBnTtVb/kPrcvJmDH9BTZNZVZtNpqEJZu34orqLb63HfcuVmdH8Ut5fDMnMk5QkIIPB7mbPedbbTdF66LB7pfoVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTqUKRzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0211F00893;
	Fri, 29 May 2026 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078825;
	bh=usirvGFJnGIEJqXejy9CS0lk+DVgpLgywayZdaqg200=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jTqUKRzhI5QHnjJ6UCFkgT2TcntlADijpGYYo+HQq/x7FiDsl7Dy+pQ24ZS5p95gf
	 c93pHB/SGFgcrq+26wxGFCXfZ/412WnmMzTNiMI53E1TxXw/Oap2UdU6f9mdyhkYQD
	 oQ/rI8Ae0vYltw3MLg5XUwkOP6D+Wg2Hciii6Hs1uqUbdn9hydVtZz8l7SGD8UKttn
	 9DtSk7kE6il9iJo3L9tyOg6YQHMq3bXXVrxGytyd+pFc3VPntDBZ7j5aB12liSHhf2
	 Vt3cPvQ73aDuz1RIyBNtrWvTtcupmuE32ZeSeokQB1OJ3Rcok8hFkOGggLUDKcvq+a
	 5VlgDqux3Vp1A==
Date: Fri, 29 May 2026 11:20:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-05-28
Message-ID: <20260529112024.2c0d2c51@kernel.org>
In-Reply-To: <de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com>
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
	<46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
	<CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
	<de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 20F9C607310
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 09:35:20 +0200 Paolo Abeni wrote:
> Even multiple PRs per week makes sense to me, if the average size is
> still significant. I'm not sure about others maintainers opinion, please
> don't take my last statement as "a please go ahead with this" before
> more acks.

That's a pretty costly fix. It takes me ~3h to generate the PR I suspect
it takes you similar amount of time. So it's not going to help the
patch review queue if we waste time generating multiple PRs.

Luiz, simply run this bash script before you send the PR:

github.com/linux-netdev/nipa/blob/master/tests/patch/verify_signedoff/verify_signedoff.sh

it's not the first time you're missing SoBs

