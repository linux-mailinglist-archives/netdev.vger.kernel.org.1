Return-Path: <netdev+bounces-267121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NujIuXZsmlMQQAAu9opvQ
	(envelope-from <netdev+bounces-267121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0D27439C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A303019F0F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BD3603FC;
	Thu, 12 Mar 2026 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4SrkK6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4619310655;
	Thu, 12 Mar 2026 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328764; cv=none; b=pOpdmPSV2oTDPnQdsdrstOK/0EM8ODkpnUZS3KOJajwzVyw8ajQmROuzW4BuNGLpHPFqicOlxnG0X6u3ySFE1n+YNXdWmr7asNxi3ZE8MeMNbolls7genETODojLbCGSSLnxxrXMJWLG0WPte6Go9wtEA0ixDRzpbwb+WSijZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328764; c=relaxed/simple;
	bh=sOswyamaty815adp4oHchgJKP78qnaSCZU50yYAAvGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feL6mZCU3dcAf02HYp+5CDmBKjnUkqKClAAZ8zdcGy339+ASl0A6GFusDPkDx8xgpE4LHocbUari6Kx3S5k2fvKyjEgQ+SiVPCpHSNj+ONW9Mxz82IPtpjd5h+wloMMqlrbknUNJcIaf2LGu2YiYAILJd005pnoqLtNv+YQYk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4SrkK6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B61C4CEF7;
	Thu, 12 Mar 2026 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328764;
	bh=sOswyamaty815adp4oHchgJKP78qnaSCZU50yYAAvGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4SrkK6HqJc6P8LO9JFX/NEi89adx8usy2vv9LB2/2sxxOOui8JrxZhlltqm25XeD
	 vGKbfybKCRcKzD3Xioe+icrqug2lfyj/99JqApZGHduKHQKsAQMnLxjHb5O0M3ibvJ
	 PCx/qGDnH7NmjWe9ldxGPHFmw9BD6tJ6w9HAEugVxvtG0XE77z/LEkHuAEv3HXSilQ
	 NKpDN2Qoe3a3bYtEDvx65gz8WLQBSDIQiNlrHpZHxZXIG3V0GROwqWYEv0YbwA6oIl
	 pZS87Wqv25e/AQ92nAZOl6MiGtaZhp+Px6Z1e9sGLxrcorfk7v5vXaAD3XlGUKkxHw
	 DK9kTL3pNRzQQ==
Date: Thu, 12 Mar 2026 08:19:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] selftests: drivers: bash support for
 remote traffic generators
Message-ID: <20260312081923.01b0537d@kernel.org>
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267121-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA0D27439C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:17:31 +0200 Ioana Ciornei wrote:
> This patch set aims to add the necessary support so that bash written
> selftests are also able to easily run with a remote traffic generator
> system, either be it in another netns or one accessible through ssh.

I think this breaks a lot of tests:
https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--15-00&pw-n=0&pass=0
-- 
pw-bot: cr

