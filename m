Return-Path: <netdev+bounces-260558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK9AH5S/nWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:11:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B46188D80
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96E0A301FD62
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4453A1A4C;
	Tue, 24 Feb 2026 15:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042A3A0EA5
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945761; cv=none; b=kyXtg52wPIolatu87pK9WKJ7u4jG94J6Wv2kZrg/l8Ip9tamW/7j4BTseaGPKd5sr655XJivNGQ0oePJ7o3IZ2wFw2Ir6MX/yW5ZibFWKHgLbV7qbgBS5GTqx8GN0ANRUHZjiGUA6TPpBgWzfbHRGeA/S2Jg2hPWJ/S0Vb2LOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945761; c=relaxed/simple;
	bh=EhgcqEPws5l/3DS9JlZjbt+JZZ2KDlqVzefnhjkxAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADyAXsmoNjcbi9PpYAzjVR/BTUdKYD3u0o5MBro3NtfhUlixFkDeCzF+pkAO6yJoaIUs2NI5LKZSX9ljMslOPtcxCd0R+wKBXKJFuSVt38bVucXkMlrbXvKFfOgeXW2pIPXEhrWr7ARmu951A69vdMyBlLjFa3kvnrYNTBLd77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 99FCA604AA; Tue, 24 Feb 2026 16:09:17 +0100 (CET)
Date: Tue, 24 Feb 2026 16:09:17 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: netfilter: nft_queue.sh: increase
 udp_gro_ct subtest timeout
Message-ID: <aZ2_Hc3oQgukfVDy@strlen.de>
References: <20260223190108.28139-1-fw@strlen.de>
 <20260224065921.0d4f5cdc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224065921.0d4f5cdc@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: C6B46188D80
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> wrote:
> Thanks for looking into it! Unfortunately we saw the problem again with
> this patch applied:
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/nf-dbg/results/531881/3-nft-queue-sh/stdout
> 
> Looks like it repros once every 25 runs for us:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-nf-dbg&test=nft-queue-sh

Yes, I already saw that it did not help, I can't explain this so far.  I
restarted a long test run (1000 runs) with '--cpus 4' on my laptop, I
hope it triggers this time :-/

You can mark this patch as deferred or changes requested, I will
hopefully be able to send a v2 that gets rid of this problem.

