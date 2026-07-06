Return-Path: <netdev+bounces-304887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t+DsL99XS2r1PgEAu9opvQ
	(envelope-from <netdev+bounces-304887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7F70D7A8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304887-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304887-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9382230184D5
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033883E172C;
	Mon,  6 Jul 2026 06:54:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2B3E0C4F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:54:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320852; cv=none; b=hNX5/0Rd1n53x8RzOu/Gv4rGtI/y1VvfScuwoOSgTlfjl5l6/oB8DKlrurOIutBoYLW4q8b4FsorUTN+lvWjDOm6ULizfRwTsXkAH+T+ZqgbUvjXTTkVl65HCCW7OL9pbvP8dI2pr+UUiAMzuLjRwU+BdGl9c71UQsuQkQzw+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320852; c=relaxed/simple;
	bh=CW1QrPZ/84Xc1S5fxWfdrxrRFouH1TmDZbxVYwQgotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEs8DyyZNdHtWH4VXhpqsv/mCqN3Mg4rcz4CgkyJnVh3cFfU8XVtrl0QlxW45xmtgZYxrgbgyeL62+s2EqNH/V29KBXYkhICvL+M+idrix5g63L2oBOPle0FNhhzkZ0RXZcVNAnS3UkBltkVUKviHOgNrRNnz0aYEbjeuvcy/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EF92860288; Mon, 06 Jul 2026 08:53:55 +0200 (CEST)
Date: Mon, 6 Jul 2026 08:53:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Dharmik Parmar <dharmikparmar2004@yahoo.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: netfilter: conntrack_resize.sh: fix skip
 exit code
Message-ID: <aktQ5kLLtdG3pn3W@strlen.de>
References: <20260705204252.630729-1-dharmikparmar2004.ref@yahoo.com>
 <20260705204252.630729-1-dharmikparmar2004@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705204252.630729-1-dharmikparmar2004@yahoo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dharmikparmar2004@yahoo.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304887-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid,lib.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A7F70D7A8

Dharmik Parmar <dharmikparmar2004@yahoo.com> wrote:
> When conntrack sysctls are unavailable, the test prints SKIP but exits
> with $KSFT_SKIP.  lib.sh defines ksft_skip instead, so the kselftest
> runner did not see a proper skip.

Acked-by: Florian Westphal <fw@strlen.de>

