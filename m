Return-Path: <netdev+bounces-287348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP4RGz6+A2qb9wEAu9opvQ
	(envelope-from <netdev+bounces-287348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68352B698
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D2530794FD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253E3655F7;
	Tue, 12 May 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH9SNWvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6563655D4;
	Tue, 12 May 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630202; cv=none; b=MvP/BjagbDQP+n57UzWd8Qovi0MxyCIwsVKBJzcWWAPub38Ip8MD+NRtpwGAo7d1iXclkuIQCHNYT74r5ZGge7s7ZboZ+Xlmt9YWQATyFyvqkxV1D71O9LXsTcIOCwVNiH3lVbmoMZ5rjIyAqgTHc2SGpPLt8TNU0pWg+O+NGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630202; c=relaxed/simple;
	bh=O9+vFtQJ1OxM9xBTPkg7zSPs5fLrZMg/EyiOeBqJPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8ib1cPWOpnjlb+z1D2gn8xLfT5ekSYYR2++KyGqfYhR7WWjyNS7cKGQfwk2Nu0ZuhU356r6hyAtpjTHF5NnLaE3vuOqUwupC0HK+uHo0qqNPNzypyt9qkE4zv7871aj4nNc2B/v4j1L5gj8NyO9IYjWkC3Ak6F3WsmQrklHj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH9SNWvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA74C2BCB0;
	Tue, 12 May 2026 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630202;
	bh=O9+vFtQJ1OxM9xBTPkg7zSPs5fLrZMg/EyiOeBqJPhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DH9SNWvjqn/VlBHbanvjYpVjlXVctgjFIQNPIszIB/D4F7Obrxj+effV9eaNZNFGW
	 IAM2xOLuyCiuqf8giQIkMPdRzcam6ROhK9BwtOPBM8J76j8d3xQ8f+1CBjNB/MlrhW
	 EM6Bztb0lEyh9layxobE4YKQmN10LC6Jtz3h7f9bYEFMl9uDzA9EOdo+P00z7SPGou
	 /jqUWdJupFJYKUu5O527qSDBqElr6bkUBfM248YhhVxH7l+0pU58mfbQODHA738Zyv
	 9351BAAsO/krE9fa99bBKb06+bx6iZNyB86Mbc7dP5X/fdl+vT9QhWW1U2j+U+pC0R
	 cFVy7OmhAB7/w==
Date: Tue, 12 May 2026 16:56:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 2/2 net v4] selftests: fib_tests: add temporary IPv6
 address renewal test
Message-ID: <20260512165641.1f557ba8@kernel.org>
In-Reply-To: <agLenteVpazkwn0j@gmail.com>
References: <20260511122645.6233-2-fmancera@suse.de>
	<20260511122645.6233-3-fmancera@suse.de>
	<agIKdx3q9ewyhq7r@gmail.com>
	<20260511170848.756e9347@kernel.org>
	<agLenteVpazkwn0j@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB68352B698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287348-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 01:08:15 -0700 Breno Leitao wrote:
> On Mon, May 11, 2026 at 05:08:48PM -0700, Jakub Kicinski wrote:
> > On Mon, 11 May 2026 10:01:00 -0700 Breno Leitao wrote:  
> > > Should you check for ra6 before the "setup" above?  
> >
> > Not really. AI bots love to complain about this. But "ra6 command
> > not found" is as good of a message as the explicit skip, honestly.  
> 
> Right, but why call setup() before checking if ra6 is available?

You cut off the sentence from my response which told you why.

Checking dependencies is not a priority for our tests.

