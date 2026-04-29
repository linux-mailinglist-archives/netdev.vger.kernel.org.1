Return-Path: <netdev+bounces-282500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOIVFlx08mkHrgEAu9opvQ
	(envelope-from <netdev+bounces-282500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0D49A78D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09061300F5DF
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF4378D94;
	Wed, 29 Apr 2026 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyPxQTtB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBEBA34;
	Wed, 29 Apr 2026 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497104; cv=none; b=OrINyUmop6kBrCEjKTNLBijkS3QQ85uzykRXNEpZrp0wuZz+1LAinxBPXAI7yfYUSirLk0a9oLqVGhzAYeE6TtJQnzpe90EyBJjtBcprPq9iWQbT0GUMZwJoLwGnMK1iQIQ3sAkyUvaUND8wiC2yJw5hufpLCrsXDBYRgYt5Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497104; c=relaxed/simple;
	bh=MRSJho1zZoNjgvRjTorbWpBPzXTaPpyCP6FGZl9fLEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmgDaoi9wSokx++M1Fx3ROfsPu5qnyTt1HHYYM6xhB66yC+FOyGRJ5yV5/8zEJEMV7hqzvqrWXOK3jxsD2eC1cqo4/p53rt+RsngHlJZpVLvnuA5H56mS5GuoUHiL9SyXmaxrKdmp8K0/GmBxqdI8fMMy/UGMpcf4fbEISJ2iVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyPxQTtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C342C19425;
	Wed, 29 Apr 2026 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497103;
	bh=MRSJho1zZoNjgvRjTorbWpBPzXTaPpyCP6FGZl9fLEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyPxQTtBnD6hY9ZQifbdFDd1MdEbZnqfpvN2xCaJd199Vhs3N44ytaHP4HY89l2sp
	 UySOr4Rh7YggJu7K4msWINmI/TeeQm4nBR3HQkmG7X6QMgeTMpidUtIkVdqPvS+98E
	 xqTB7c7gl2fFFpeyyTZ1pOyNmy6x3qiD3wIV71lwYGD4vJl6Uslajv5sZlBVCecB58
	 KjVoGWvSbQjmCW+VfgzjgXxBKkhru0Dd4eWuVvQL1MXXkuDwCIQFgLR2w2ShXMwbjb
	 zijpctcS8JR2xyHCnymIPVPGwMHuaM6ksQwwi5d56QNaCdfZ8aKEU5W3cIodEaDVrH
	 //D+jRJUcgVJg==
Date: Wed, 29 Apr 2026 21:11:41 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ardb@kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au,
	0x7f454c46@gmail.com
Subject: Re: [PATCH net-next v2 1/5] net/tcp-ao: Drop support for most
 non-RFC-specified algorithms
Message-ID: <20260429211141.GB621449@google.com>
References: <20260427172727.9310-2-ebiggers@kernel.org>
 <20260429185828.1539480-2-horms@kernel.org>
 <20260429194456.GA621449@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429194456.GA621449@google.com>
X-Rspamd-Queue-Id: C4E0D49A78D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 07:44:56PM +0000, Eric Biggers wrote:
> > One more question, on the commit message and documentation rather than the
> > diff: Documentation/networking/tcp_ao.rst still describes TCP-AO as "May
> > support any hashing algorithm"
> 
> That "May support any hashing algorithm" statement has always been
> incorrect, so I wouldn't pay much attention to it.  It also appears in a
> table describing TCP-AO as a protocol, not the kernel's implementation.
> 
> > and does not mention the newly enforced
> > whitelist or the -ENOENT failure mode.  Should tcp_ao.rst be updated in
> > this patch to list the accepted algorithm strings and the rationale (e.g.
> > the 20-byte TCP option MAC cap), so userspace has a documented contract?
> 
> As stated in the commit message, the list of MAC algorithms supported by
> the kernel's implementation of TCP-AO has always been undocumented.  It
> should be documented, but I would suggest documentation improvements
> belong in a separate patch.

The missing documentation is added in
https://lore.kernel.org/netdev/20260429210856.725667-1-ebiggers@kernel.org/

- Eric

