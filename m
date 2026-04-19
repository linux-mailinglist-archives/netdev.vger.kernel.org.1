Return-Path: <netdev+bounces-279592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A1pGInn5GkNbwEAu9opvQ
	(envelope-from <netdev+bounces-279592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71B4245F7
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB63A300F94A
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F937C0F1;
	Sun, 19 Apr 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKlLQm5f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81540DFC4
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609158; cv=none; b=CxxUKcsRG33+BHD6Yfpt0BS8yYzTmoOdPIdZFlsCDVvL4YaQiS5YAfUWFAftE8fUIjjVntvZVoqecp46kN99elh/K1gTllXifWHj0RQjPtaVcrL7hzmi/Jhj9caqmEJW+mdJq9IwldniU4WSgbhfltl4qkQqTnPCX/uE6RAcdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609158; c=relaxed/simple;
	bh=a/oHZPmgRrZuGTYBJTy79UBBz7lT/PaGSYcEUaesVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dryqy4zuINhnfWEXLuHTZC8iohOzb220O1sZNvS2xFgdBV2XDQ6TtbJiJUXFDiq8DYOcxQsu5HVlTcupLO8mKWyw7hcnNPIqStWZGfPPU4oG3ErEk4DmnS0yABn6ng2l2L4RiLY5Kk+ienjSNt6mnF62gRHYvP+vYWqceDEwC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKlLQm5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC6CC2BCB7;
	Sun, 19 Apr 2026 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776609158;
	bh=a/oHZPmgRrZuGTYBJTy79UBBz7lT/PaGSYcEUaesVJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKlLQm5fLLNd+VpT+fXqxStXjRWSXozX24c0R4et4VKO1h/L8LeJylcc0CJu5brcx
	 nMZmS+xDqVMeXup7naUYsNd+bE6DektFSuAKAhvJeSe9QkUa4U+3pHbCrfkLTvVM77
	 zYmHt3zWSQIqRZwspkBHKb3yu1rU9Cyk/q5T6bvGdj+YA0nMqAdbt6GIgRKJVOQYM2
	 OUoru2Bv1koGDo+e2JKYTN40ywiKchJDSCTMX0sI0LMT85/p7ReHH9KZ0SzWsk5Amm
	 /2eC4Vg3FmcR7+NhGwLOwZvvXqgq8F74mX0dLQO4p38XprWtquFUrWULBkcqHZ7EJ/
	 OzCL6UebwmVOA==
Date: Sun, 19 Apr 2026 15:32:33 +0100
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
Message-ID: <20260419143233.GK280379@horms.kernel.org>
References: <20260415213359.335657-2-bestswngs@gmail.com>
 <20260419142720.GJ280379@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419142720.GJ280379@horms.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279592-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF71B4245F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 03:27:26PM +0100, Simon Horman wrote:
> On Thu, Apr 16, 2026 at 05:34:00AM +0800, Weiming Shi wrote:
> > sl_bump() reserves only 80 bytes of expansion headroom before calling
> > slhc_uncompress(), but the reconstructed IP + TCP header is up to
> > ip->ihl*4 + thp->doff*4 bytes. IHL and TCP doff are 4-bit fields and
> > both can legitimately reach 15, so the header can grow to 2*15*4 =
> > 120 bytes. A VJ-uncompressed primer with ihl=15, doff=15 followed by
> > a compressed frame of size buffsize - 80 therefore writes up to
> > 33 bytes past the kmalloc(buffsize + 4) rbuff allocation, with
> > attacker-controlled content:
> > 
> >  BUG: KASAN: slab-out-of-bounds in slhc_uncompress
> >  Write of size 1069 at addr ffff88800ba93078 by task kworker/u8:1/32
> >  Workqueue: events_unbound flush_to_ldisc
> >  Call Trace:
> >   __asan_memmove+0x3f/0x70
> >   slhc_uncompress (drivers/net/slip/slhc.c:614)
> >   slip_receive_buf (drivers/net/slip/slip.c:342)
> >   tty_ldisc_receive_buf
> >   flush_to_ldisc
> > 
> > Raise the reservation to match the real worst case. The ppp_generic
> > receive path already enforces skb_tailroom >= 124 and is unaffected.
> > 
> > Fixes: b5451d783ade ("slip: Move the SLIP drivers")
> > Reported-by: Simon Horman <horms@kernel.org>
> 
> FTR, I was mainly passing on information flagged by Sashiko.
> 
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

I'm very sorry but the text below below was for a different,
albeit related, patch:

- [PATCH net] slip: bound decode() reads against the compressed packet length
  https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/

The corresponding text relating to this patch was posted as:

https://lore.kernel.org/netdev/20260419142710.GI280379@horms.kernel.org/

Sorry for the mix up!

> Let me summarise my understanding of Sashiko's review of this patch.
> 
> TL;DR: I don't think that review should block progress of this patch.
> 
> 1. The issue wrt concurrent MTU changes appears to be a separate,
>    pre-existing problem. Maybe you've looked into it already,
>    if not, you may wish to.
> 
> 2. The bounds checking problems are addressed by other patches in flight.
> 
>    - [PATCH net v2] slip: reject VJ receive packets on instances with no rstate array
>      https://lore.kernel.org/netdev/20260415204130.258866-2-bestswngs@gmail.com/
> 
>    - [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
>      https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/
> 
>    In future you might want to consider creating patch sets for related
>    patches. But I think it's too late in the case of these patches.
> 
> ...

