Return-Path: <netdev+bounces-292618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFiuDggKGGpBbAgAu9opvQ
	(envelope-from <netdev+bounces-292618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B265EF8B2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCAD315E554
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813853A8752;
	Thu, 28 May 2026 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qqly7QBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kdl1vzJV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC133A83BF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959687; cv=none; b=eiphqtURrui1uqbagF+o5u0UFgJM7AHR1D7hAmdD33CO51WcGdwMmPnEhowUXhMP5igRzv66fDTdvXMOL1L9tYRXObfn3Q24idBSzBJtdX3LFGNz3IJcRuQUZ5IsT5djK90wcIkKVJrfDay/fPoh/zErnoF8dykXeEceohpwROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959687; c=relaxed/simple;
	bh=J5EoOkQcC1C2LHC3LRO4I8jR0rDjhq8Pi8jPHHF9DG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo48KUYLOH7uMpJUoaj+3DGFfUwtEYtqT5wLK2myObMAoIp29qJXmA6q63F7pT+KBvYS1KTBWQoJ+qkl5RcZ6w4gJdEiQfmtTK6/3vu400KHWnbz0tbmCzIrVJLyegi10tVmuOq0w371I3Ee/lYwMY7rthR0QNuLw+ZVdk6ii2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qqly7QBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kdl1vzJV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B892EEC01FE;
	Thu, 28 May 2026 05:14:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 05:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779959683; x=
	1780046083; bh=kMZyAtIAWmEID4YioCHgyRgQ6c+WeT/fG/GOj/T0e7g=; b=q
	qly7QBc84dGv0KP6vtkspORChFoHCExL479nYQpf23f2JfBGCQUS/DuYhqRD6kki
	Yo8E/gpjH2WZMmvymFdmVMhlzzU8c7pRBLbyDf5VWKcxR3XEiWYe8fcuOwMsMVAs
	hdRvBkhISRF9flWWqRr16yQWK1pHACJCRsiB0gCzZDFNooZqvz2kX5ErUQ0O9wk1
	PpVMlGNPbO+msdKSKXQYTcz4++0dRb0sPmxxnoczVkaaoM6ebBqZ9SXlulAmwyD2
	80haB5rsfbR4VwAb5b9akGRB3qtuhNKBrPNC9Ppq6nxaEFOgx/1vc72UiSe0aV/u
	4Anu5zgKcgqIhCUcSXWYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779959683; x=1780046083; bh=kMZyAtIAWmEID4YioCHgyRgQ6c+WeT/fG/G
	Oj/T0e7g=; b=Kdl1vzJVg8epUlRmxL90izRQsQWlHvR0n019YGAmG3VP8JnCpqp
	LtUqhW5B7cWpE44C79SViTHGnQBM4h2GDD7c6BrzrKAzBLY+JSqo2IsemUKrB4XJ
	m0RaJmQAY6NIfHP13IesMVXo/k/g5+Z186vW61KNT6f4OXrzBNOxamTebFTUr1Jp
	0zF8WUD7cr6Vo24ewWylK3D6BwLjIG/bziMXuQ/dUpjttOF1arposAE1k1M0BLtu
	VQ7gRekcN83AVTkqULxBT619RrIoDYbxJn6fTt2TPduwn8PwEUTrk/InautULw+0
	/Yh4I+Bi1TWzy1fGS+RdVnUGzd4skb5sDMg==
X-ME-Sender: <xms:gwcYasQUE4RyaIFwRwUkDy_1Fj0LV5CN2AvmvUsuPm2aM_uHPkKN6A>
    <xme:gwcYas3w7K33f0tRZ5y80vMPxQRvzqehQwAPM-qMJkS1CCTEhMVjQGb_tunDHvARN
    nJtzYlRsSNsei2nnqlGHJdayoafCk2fIV1MoBhs5Zr5aJ8BpIXnDn8>
X-ME-Received: <xmr:gwcYakeNVA3rAi1BrxZSxBJM8juor3nkbsy6284x22L3VsYbMXT8EZTHhUV83KM71lQJU8KDYce_VO9NEujeDnY>
X-ME-Proxy-Cause: dmFkZTGJpxUy1L7Z53qytWadUE+499Cq0bFrq4z+jTFDp/8SOkytbQ7JSAL/HbDOpdc2Io
    tDvsPcdiQ5yloT5rPB+QLlDCM5aXDbB4HrUaS1RuK4ZOCMV4Cq+nWaNRV6CW0OCbf575ji
    3Is+jraaPgQ5QylIZIA95Ob7ij7fmpIq1tNfc0BolOm625s/ur1Ar6y6QWNOFu4HtZ9lDx
    otI/f7dLrx7U/E/jEjT3iWAC9TLsqCvY7sbaRAeYcRyx0m8mdVUQxxJWbPU3yimpksbYEw
    oVerPwOfgpRcyz4m1haBmwFzj+5Y8RhcV49W55OpKymQ5yhVxz7VmcXlb9hSELgks+oWkC
    cOcDaz0p0Fn9UgNRb+ifd1fCdyzqHLj6GWb0o8DY9Rj3uY1aL/keV8oVFib1FBxXxD20/U
    hFI908lOTtzJdFWC7Dek+nwcpUJxjA0XMTMH7hbvP2TMUUPF8qPn+whkdz9br8nyh9ZGLr
    YabzpPUph7JP/e8e7uSVBXi/2ZfRG+RrJ1co39wXqAyY8GyZITWimd2XZAYGQOkF3lqZ2r
    DNo/dfgmpS9HeWV1h6C4+qkx5+IUlbYLvLq+TlODz7N8MPYfcAHtHXkU3kxcnwiOI/eVah
    zifNYikMk0NY4NT4/xbh4NMbOt2hgJyz4ib7HNAOSWwMQOMsueejslk0M1ug
X-ME-Proxy: <xmx:gwcYasNoZExRGNts0RBJpIzi9xGbzhN6tuDx4XTuOIBtIiF8BmupMw>
    <xmx:gwcYagU2ZP78zSVv89F8EuHKPIy9uGS5FsTy98-eAHl1OqbP36olWw>
    <xmx:gwcYasyOQT4PglGyxJTibrb6HIhGsdb9GX7Jsg-Crq8VUUebtr8PXQ>
    <xmx:gwcYav_Wv31arV6swn_FvDRT9bHd_VmHfUb9-U9CzzNoP5sUT9YuWQ>
    <xmx:gwcYahrNFYbBjwLMPgHq1pEKqUYVNQMDx3-zSSedck_q7GT5pST2P3NE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 05:14:42 -0400 (EDT)
Date: Thu, 28 May 2026 11:14:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v11 6/6] tls: Flush backlog before waiting for a
 new record
Message-ID: <ahgHgQ84RCc8uYrG@krikkit>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-6-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-tls-read-sock-v11-6-244fe1dc4abd@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	TAGGED_FROM(0.00)[bounces-292618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B3B265EF8B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-26, 10:21:36 -0400, Chuck Lever wrote:
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index df4cdf11f784..d2f31623511a 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1400,6 +1400,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  		if (ret < 0)
>  			return ret;
>  
> +		if (sk_flush_backlog(sk))
> +			released = true;
>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
>  			/* Defer notification to the exit point; this thread
>  			 * will consume the record directly.
> @@ -1409,6 +1411,13 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  				break;
>  		}
>  
> +		/* sk_flush_backlog() can run tcp_reset(), which sets
> +		 * sk_err and then sk_shutdown via tcp_done(). Recheck
> +		 * sk_err here so a connection abort surfaces as the
> +		 * actual error rather than a clean EOF.
> +		 */
> +		if (sk->sk_err)
> +			return -READ_ONCE(sk->sk_err);

This should have the same "if (has_copied)" handling as the top of the
loop got in f508262ae9f2 ("tls: Preserve sk_err across recvmsg() when
data has been copied") ?

-- 
Sabrina

