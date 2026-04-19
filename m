Return-Path: <netdev+bounces-279595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNzBODTt5GlPcAEAu9opvQ
	(envelope-from <netdev+bounces-279595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:56:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52F4246A7
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 220FE30041E8
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A2D3290DB;
	Sun, 19 Apr 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKkMqaHk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617D272E56
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776610611; cv=none; b=n4wz/l8iCf25Y/HKGpy0qUHtnTh4IcNK9tbXm3gjKh2O/Wdj3vMQ6GRiqf+8C45SbFfRXiCRseIE55Fu+ol7KUKDxQcqlOMxxGvukSu9IQun1HNhNWcBQDGUTMjQjQtiuKWcOl+Hj1rDjWx3jXj2gDJTWBxNGweVykcNXYML2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776610611; c=relaxed/simple;
	bh=xyNBB0pgqTSysjr755wVqGkHcdDubavV7wTzj82xcdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EinedlSmm53ux6Qxe6dwg0H8ODUA0RPitedBQYF7ddRKmPaR+bW9MBRuQew06wZOc11179rufWPLR+AA0Yn04oYVN8KF3pKauMPIgz5lD/HZ6jABLzo5Y8mwfMCB4I2qDmJTGJ138XCMyGPPdz7xXfCGsfqbfQzg5Mi/jRJKzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKkMqaHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F23BC2BCAF;
	Sun, 19 Apr 2026 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776610610;
	bh=xyNBB0pgqTSysjr755wVqGkHcdDubavV7wTzj82xcdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKkMqaHkWj1JJVd0d4Aee9e2TVA2M1KscD2vHBMD7j7Xl8P1BYWRV0jT3jOeJe/Zj
	 1QmwuAs5Z/nV4KQDW2UtcjlSqVJqBaY3+ewVwyxyKQj6VBUvt91CnDIwhDfM98/7t1
	 XZ81ajY/fXd1ic3H60rnZyRjBNGk4loE0Nk3scAyTPdD2nHuZD08ztXO6z/QVsAQ5y
	 fekPxBY2vJLmB+MyDvEJrv26ZSTBW2rgilLMfxD2PUc1W3VAKhKCGgf21C0UAHL+kV
	 tO7ZTEPRkE3tWmYESDXvENmdUYvR3KZTF+9AUvRRoI9UkcisWYDTRREyJuqs4Vzzg4
	 tHYbn0DONipFw==
Date: Sun, 19 Apr 2026 15:56:45 +0100
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
Message-ID: <20260419145645.GM280379@horms.kernel.org>
References: <20260415213359.335657-2-bestswngs@gmail.com>
 <20260419142710.GI280379@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419142710.GI280379@horms.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279595-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: AF52F4246A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 03:27:10PM +0100, Simon Horman wrote:
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
> FTR, I was mainly passing on a review generated by Sashiko
> 
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> As usual I'll comment on the review of this patch by Sashiko.
> 
> TL;DR: I don't think it should block progress of this patch.
> 
> The review by Sashiko flags out of bounds errors. However,
> these are addressed by one of your other patches:
> 
> - [PATCH net] slip: bound decode() reads against the compressed packet length
>   https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/
> 
> As noted in my review of that patch, while it seems too late for these
> patches, please consider bundling related patches in a patchset in future.

I'm very sorry but the text above results from me muddling
up my response to different slip patches.

I'll post the correct text for this patch elsewhere in this thread.

