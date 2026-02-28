Return-Path: <netdev+bounces-262047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM4YK1xTomm61wQAu9opvQ
	(envelope-from <netdev+bounces-262047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F51BFFA8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EAC1301A6B6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423A261B6D;
	Sat, 28 Feb 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqZnHHBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455E20C463
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245847; cv=none; b=mSxRGCE0hhSig1wv8FfKaxY/taFE9PHYtD+tIM5EZOCFuFa2XF/7I9JyEKa25pGXVcbebWNtcVU1lF/2k8yKn1G7vOfe0Z0O7yoh4W+ALoKL3gHzEBcwIVEMbd5KoBHAUdxPB8fTFQGrHNTbrnmRZHfKWZokd4oFRpX6af5+OxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245847; c=relaxed/simple;
	bh=qrISZWw5F6E3LRb8nXuVgjEgyw6h+K6AQTyttB3MpHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVSC4ZC5gATnR17KRPR+1qLfgiGwFCnCe0cHtdc3SQ+C7Zdicd+NLHuad1gIZt9AAWhpzlRUtlWQSZAIGHBH4btMpxjRxmt+KlPaD1Y/xqN64K7m7UACa+n0rw+eRv7kBLhQA+/5v67UAUfu0jj5lP1Wr8NEecw2XUqyBYh9xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqZnHHBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B4BC116C6;
	Sat, 28 Feb 2026 02:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772245846;
	bh=qrISZWw5F6E3LRb8nXuVgjEgyw6h+K6AQTyttB3MpHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tqZnHHBE5QdBPTGsScBpbJtdavRA8LGV0bt6HZCEF3RnGVhhGeoYn+NxFPsKxsfD6
	 w6FPEG8c8FNFnPisopTWncjzYDyF045QMYCQZqEeTxLNfZULYdzNXIV3vjG0NcvDUL
	 s3OALVUmL40XnbknA14JeL3fOa5dUl4TjVltPlLXQR0yhK1JZmTVD995ZTjQQ2hYqy
	 /eBA+5WDek3G/31zf3TZ0G2f2KY7jFfCGIFbZyqzi7S0GblAZ5EAaRY9/WbFY5DGeX
	 vn0RIuRecO5LbOguU5bgjdDd5ZTQxVEFDyJ2NVPy6hGkLQC263qOHVVcOwCbWMNP09
	 J70MuGAR+AKdQ==
Date: Fri, 27 Feb 2026 18:30:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@fb.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, netdev@vger.kernel.org, Daniel
 Zahka <daniel.zahka@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 3/9] selftests/net: Add env for container based
 tests
Message-ID: <20260227183045.234a841b@kernel.org>
In-Reply-To: <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
	<20260224002410.1553838-4-weibunny@fb.com>
	<aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-262047-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C75F51BFFA8
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 10:10:31 -0800 Bobby Eshleman wrote:
> > +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
> > +network name spaces behind macvlan, veth, netkit devices). DUT must be
> > +reachable using these addresses from the endpoint.
> > +
> > +  +-------------+        +----------------------------+
> > +  | INIT NS     |        | TEST NS                    |
> > +  | +---------+ |        | +------------------------+ |
> > +  | | NETIF   | |  bpf   | | Netkit                 | |
> > +  | |         |-|--------|>| nk_guest               | |
> > +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
> > +  | +---------+ |        | +------------------------+ |
> > +  | | Netkit  | |        +----------------------------+
> > +  | | nk_host | |
> > +  | +---------+ |
> > +  +-------------+
> > +  
> 
> One thing I noticed when I tested this was the flow broke down when
> NETIF's address happened to match LOCAL_PREFIX_V6. I didn't fully reason
> through why this was the case, but maybe it's worth mentioning in the
> docs here?

+1 I think it may be useful to add to the diagram some example using
the documentation IPv6 prefix, to explain what the addresses and routes
are in each of the boxes (and please include the remote).

Also 

	local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")

please use Python's built in ipaddress. The standard parser will be far
more flexible for user input

