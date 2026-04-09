Return-Path: <netdev+bounces-276921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEbkEUR812mXOggAu9opvQ
	(envelope-from <netdev+bounces-276921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:15:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EDE3C90D5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0633087D14
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C973BADB4;
	Thu,  9 Apr 2026 10:11:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07364394795
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729467; cv=none; b=A9grAX/mKZnXHLqAq9CwLRusD9jLGH+3FWEwx3P1JrCH1EVzSWnAd+7TZWfhUaIne9BAmVsXFk0jyUI4hElTIaasEr7Cnwtvbed8IXzSWnJ54WWFFREdjMSZWQMMHMbwGQCBcFy4HUm2litvXRZLl6hZL8plKtW8RqXx5hwB0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729467; c=relaxed/simple;
	bh=MxxTUrwaIQjddzhIjjDFVA+6/b+Bv3pOvDAomJuK3WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJwaMlEGZUQrI8UIane7nAuhhdkhYiyNfqnY2fkH1m4CYwf3bk3F7rf4LOTztiAoNgKKTfVDcegMjItAt1Zd3n3eBBuxuOzG65mScNF85G70RDYpEKX2dv/iR5De4iS/QQxZyiTls+G/iwbfCy1nyDb+gqmI6YzDFEWBPtsClfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1236E60636; Thu, 09 Apr 2026 12:11:02 +0200 (CEST)
Date: Thu, 9 Apr 2026 12:11:01 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] nft_tproxy_udp.sh flaky after Fedora 44 upgrade
Message-ID: <add7NeuWubAQzGrg@strlen.de>
References: <20260408152432.24b8ad0d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408152432.24b8ad0d@kernel.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276921-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,nft_tproxy_udp.sh:url]
X-Rspamd-Queue-Id: C8EDE3C90D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> wrote:
> When you have a sec -- we upgraded the NIPA systems to Fedora 44
> over the weekend, and nft_tproxy_udp.sh has gotten quite flaky:
> https://netdev.bots.linux.dev/contest.html?test=nft-tproxy-udp-sh
> 
> One thing that we hit immediately is this, in case tproxy test
> uses socat:
> 
> commit e65d8b6f3092398efd7c74e722cb7a516d9a0d6d
> Date:   Sat Apr 4 16:01:03 2026 -0700
> 
>     selftests: drv-net: adjust to socat changes
>     
>     socat v1.8.1.0 now defaults to shut-null, it sends an extra
>     0-length UDP packet when sender disconnects. This breaks
>     our tests which expect the exact packet sequence.
>     
>     Add shut-none which was the old default where necessary.

Thanks for the pointer, I will try to get to this later today.

