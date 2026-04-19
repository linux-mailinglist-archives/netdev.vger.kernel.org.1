Return-Path: <netdev+bounces-279590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBaAFojm5GnObgEAu9opvQ
	(envelope-from <netdev+bounces-279590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98C4245B6
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2363F3013A7B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96C37BE87;
	Sun, 19 Apr 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipyDdfA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E8350A1F
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608846; cv=none; b=mhSHFRlSOeWyuSmny5CkQRjX31HIws5hxXR8zR80TvoBAi318nw+eAYskxNh8OzEVVgurXDBkrMyswapUQ3jc8zhktBViMCogi8GmJm/qF4W1wCXVmS3MWmelBZX50Q/Vd/68Kmwaj+m3h/ZtmUwS6aWVR4JLuzFh7dA5AywQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608846; c=relaxed/simple;
	bh=s2gMblZeAzDupssGDahxpIBxVS2I27a2cO8kefDoF7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1Hddf+u5Gr55VHR5ojTrFnmydgcQXFdflW5cEsFiq6komzjYRZkVx37NhSPXZ8J1eicdybrnCM0i2nOfUfUYspPLk3tZ3cglXXN1DwP/lZ9m6pCv0Ky7CHno1SkhS72/0G7zvspUZl/uIQxu44hi+q1xZ5B2tUjAmgR9+0DDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipyDdfA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF1C2BCAF;
	Sun, 19 Apr 2026 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776608846;
	bh=s2gMblZeAzDupssGDahxpIBxVS2I27a2cO8kefDoF7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipyDdfA/zvgMVTZzdEzFV/v0EWF8UatxqesyHAXKNnRb764GAi2PyhH+PtPZCSh82
	 molAwAp+hGY/vxn9Y/BKWYY1hli/OKLCpwuTrUebC7jb4R4yH+0vXklXEbBtbmAYGf
	 qcVAuDE2WkTabUCpr1e+5dDGNfQHZTLYBU00CE7pJGeQyuD7DqD0B7sijl0lG+coC4
	 9qkfNIeeuUK07fNGvuLbLPffAGUmWHV64uRu40oMup3FG5BXdkz09+VsDm6ZR5Gx2l
	 s2Cm3Y5TZHXXYlLlvbk7lDpMK3b3D2O8KIoTarXOgDzUF1xYtBVFAtBJXuPB+v0Tx4
	 hmMc8noJQuAgg==
Date: Sun, 19 Apr 2026 15:27:20 +0100
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
Message-ID: <20260419142720.GJ280379@horms.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279590-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 9D98C4245B6
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

FTR, I was mainly passing on information flagged by Sashiko.

> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Let me summarise my understanding of Sashiko's review of this patch.

TL;DR: I don't think that review should block progress of this patch.

1. The issue wrt concurrent MTU changes appears to be a separate,
   pre-existing problem. Maybe you've looked into it already,
   if not, you may wish to.

2. The bounds checking problems are addressed by other patches in flight.

   - [PATCH net v2] slip: reject VJ receive packets on instances with no rstate array
     https://lore.kernel.org/netdev/20260415204130.258866-2-bestswngs@gmail.com/

   - [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
     https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/

   In future you might want to consider creating patch sets for related
   patches. But I think it's too late in the case of these patches.

...

