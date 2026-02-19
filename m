Return-Path: <netdev+bounces-259499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPx6INAol2mXvQIAu9opvQ
	(envelope-from <netdev+bounces-259499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:14:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60515FFFB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC2B3300233A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5348342530;
	Thu, 19 Feb 2026 15:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAD341AC7;
	Thu, 19 Feb 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513882; cv=none; b=NGR2kHrel34baghsp9vn81Pi3yVDk+ZW1ukbJfmHUtpMsj1J60Q2Wv6uJ/OxkPrGFDnuEuJWwe+TsXzEPfihWwtICqlUc6EO2xb8dB4EC5IFGQgs86XK79FqW1c/VGS04T3T6gxTzz3pUgBuqb+53EPJtPFUzHJMpAjRIsS/NBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513882; c=relaxed/simple;
	bh=AaxuMe/wbr8zu4fW7tQYMdRqwwj2KbDM6WvVshEybXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebiaaHPo7AAPvPCzqj56UzPvO6uSEMq6ksRTdoNvjv7+vyktSfXYC7P6UzmAkrW38BzBGQTpnA/HvPrP5hfOQpjGFpGFDDhEr+7Ua4qGoeus8IHT1hjzqjGdO1Ui4Nger94ZuoTT3J5kco4vr9Xv/Rs9+pOQsJaRrgwtcvfyHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CB6E6602F8; Thu, 19 Feb 2026 16:11:12 +0100 (CET)
Date: Thu, 19 Feb 2026 16:11:09 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org
Subject: Re: [TEST] nft_queue / test_udp_gro_ct flakes
Message-ID: <aZcoDclA37Pk3UJp@strlen.de>
References: <20260206153048.17570-1-fw@strlen.de>
 <20260206153048.17570-4-fw@strlen.de>
 <20260218184114.0b405b72@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218184114.0b405b72@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259499-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1F60515FFFB
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri,  6 Feb 2026 16:30:40 +0100 Florian Westphal wrote:
> > Without the preceding patch, this fails with:
> > 
> > FAIL: test_udp_gro_ct: Expected udp conntrack entry
> > FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 10 and 0
> 
> Hi Florian!
> 
> This test case is a bit flaky for us on debug kernels:
> 
> https://netdev.bots.linux.dev/contest.html?pass=0&test=nft-queue-sh
> 
> It's 3rd flakiest of all netdev selftests at this point.

Ouch.  Sorry about this, I will look at this asap.

