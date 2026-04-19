Return-Path: <netdev+bounces-279589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CruEEvm5GnObgEAu9opvQ
	(envelope-from <netdev+bounces-279589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41042459F
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25DB1300383B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4237BE76;
	Sun, 19 Apr 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auHq+FVa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA1350A1F
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608837; cv=none; b=NTL/+Cb/s4tkKhWeYvzNgVsZuXoGtPF9UAsMbGlYgqR9q2PyaeKMdkd/uGQj0EA01/07ewOBueiuU1x2SESXEke3aOuMZz/KYyCFJ9bGBN3Ncoy478oBh1qbYDNxiwbs52chOJfc1OSxOlRjnHt71a1kiUiLHkVERDPXJDP3Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608837; c=relaxed/simple;
	bh=AB4jVQsgi7uqedE2FJNh4SDnHnZrL+5MT3pzKz6LHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/+osJlq6ZhAZZZ/cnw5lhifVgZPbvRY+c5tq4aleQe/KuX0pNFWag5BCimZAbfbPF+w7vi+AbKulNPiGXsieKwYd/e203esAZFkXyor2eVpD36pocM+nT8dyhPfUBxk6cs5dWG+t9k2+buIa+5Slz2lSkwVDIr/+u8Eew3Td8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auHq+FVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95AFC2BCAF;
	Sun, 19 Apr 2026 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776608836;
	bh=AB4jVQsgi7uqedE2FJNh4SDnHnZrL+5MT3pzKz6LHPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auHq+FVaTc97w3+YJDioNbU4QZ+HB/NBiUswCvTKGnaXMC1iH4UNKa2jZcXT3uyDA
	 PS3Kk/v39AALwOjKnYdysdUKM14g5BpwpHLlx6GNLhKG87nLm67Faquzr0CSkzSv4V
	 BkVvNkG3ip+N25e04ajjf3JgXwKwZKHbZCdrxov1rAInnhgmJ1wDUTy32e+7sJRuG8
	 L7mWVo61q/H7IhUtlaVV/kI5IIyMuzaR8bx+QCrDiUVe3piOowNhRNes2VLEyzocs4
	 PR609Kl2Q+/A9fNUWUBErlhxH86SZb9BxhLcEOipxaBzIbHTwTn6Eb5D4ZUa28CqXm
	 TuuHugG4Rj4PQ==
Date: Sun, 19 Apr 2026 15:27:10 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ian Rogers <irogers@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Alan Cox <alan@linux.intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] slip: fix slab-out-of-bounds write in
 slhc_uncompress()
Message-ID: <20260419142710.GI280379@horms.kernel.org>
References: <20260415213359.335657-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415213359.335657-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279589-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cisco];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E41042459F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 05:34:00AM +0800, Weiming Shi wrote:
> sl_bump() reserves only 80 bytes of expansion headroom before calling
> slhc_uncompress(), but the reconstructed IP + TCP header is up to
> ip->ihl*4 + thp->doff*4 bytes. IHL and TCP doff are 4-bit fields and
> both can legitimately reach 15, so the header can grow to 2*15*4 =
> 120 bytes. A VJ-uncompressed primer with ihl=15, doff=15 followed by
> a compressed frame of size buffsize - 80 therefore writes up to
> 33 bytes past the kmalloc(buffsize + 4) rbuff allocation, with
> attacker-controlled content:
> 
>  BUG: KASAN: slab-out-of-bounds in slhc_uncompress
>  Write of size 1069 at addr ffff88800ba93078 by task kworker/u8:1/32
>  Workqueue: events_unbound flush_to_ldisc
>  Call Trace:
>   __asan_memmove+0x3f/0x70
>   slhc_uncompress (drivers/net/slip/slhc.c:614)
>   slip_receive_buf (drivers/net/slip/slip.c:342)
>   tty_ldisc_receive_buf
>   flush_to_ldisc
> 
> Raise the reservation to match the real worst case. The ppp_generic
> receive path already enforces skb_tailroom >= 124 and is unaffected.
> 
> Fixes: b5451d783ade ("slip: Move the SLIP drivers")
> Reported-by: Simon Horman <horms@kernel.org>

FTR, I was mainly passing on a review generated by Sashiko

> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

As usual I'll comment on the review of this patch by Sashiko.

TL;DR: I don't think it should block progress of this patch.

The review by Sashiko flags out of bounds errors. However,
these are addressed by one of your other patches:

- [PATCH net] slip: bound decode() reads against the compressed packet length
  https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/

As noted in my review of that patch, while it seems too late for these
patches, please consider bundling related patches in a patchset in future.

