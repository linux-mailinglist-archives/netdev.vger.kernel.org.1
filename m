Return-Path: <netdev+bounces-299099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w84nLknsLWpImwQAu9opvQ
	(envelope-from <netdev+bounces-299099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:48:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 076506800F2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FHUMTJp3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299099-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF12301725A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E602FE060;
	Sat, 13 Jun 2026 23:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6B1917FB
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:48:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394503; cv=none; b=qUZvQ9tI8PK33lGfmV9sFPwdtkerq3DRYDm6yVC8oKqABMOewKvl7M9f/MhKGrUCXLcwSKTBvH+qmBHizhIF+j1PW+pRKjXcu+9tDxtyv/cgenSE1GvKLw+0gq9QgayyWQH1xsHL88MJDGYzSf+adOuJsmquuswK1gjOd+AL7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394503; c=relaxed/simple;
	bh=Oi56VmWhC7PoTC+233Fedx2dmPJcN1ZeBOwypeKtA/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/ryh8BqcKj7wV2HCw/GBYg3suRjRWAhzmR/qNMZNuOUJgKxul3fzTVs5LUR3NFwfNb6/BR+8lBXOgwrhCrVQUMi+gRPozYNe3tMjEvSPRy97R4zpKVxTE77kLqkchpsQRZQvJWopHh/sfOYNF/s6wGrG873aQBW8eoNRyCa+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHUMTJp3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB61F000E9;
	Sat, 13 Jun 2026 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781394501;
	bh=oA+5Fp0zS7dd7lJyhRmLUPe3Ae1RmQaiJfK3BW8Xdoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FHUMTJp3a5oHvl47Hr2pvjFGWBOugF78BUfab+qZOqz+QXVWKmKMIsu64ZGLAPVo7
	 FNha7jaM2vioxKb0p4+RzMSeSlNZw7iJpzbL1fu6kX6wADFDjPcn+LbqmWGWZ2Z7LK
	 pJeA7vtUb1QMLU5Se9Nflhf18BvrVca75PDNEGxRYqbNPCnQQrmkyxxk4tu/SaZ5ZG
	 3vg15SoFBVz60JRm/Uh64Kn/xyOHO/2db8MAE1d6eZsk5u+wRP+EcWrWfaHvhhE569
	 LVEk90Ijdtrj0EKD7wG4mH8Agus/iGp1Q4tq/0xgYg/5hnUqmzS6SoL8NZVsA4vqNZ
	 pb4ZGnXSrIWHg==
Date: Sat, 13 Jun 2026 16:48:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260613164820.491226a7@kernel.org>
In-Reply-To: <ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
References: <20260607031640.2743713-1-xmei5@asu.edu>
	<20260609183018.1764046d@kernel.org>
	<ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 076506800F2

On Sat, 13 Jun 2026 16:33:44 -0700 Xiang Mei wrote:
> That looks better. I just found that nla_reserve can memset for us:
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..c112e1f0ccac 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -476,12 +476,11 @@ void psample_sample_packet(struct psample_group *group,
>  		goto error;
> 
>  	if (data_len) {
> -		int nla_len = nla_total_size(data_len);
>  		struct nlattr *nla;
> 
> -		nla = skb_put(nl_skb, nla_len);
> -		nla->nla_type = PSAMPLE_ATTR_DATA;
> -		nla->nla_len = nla_attr_size(data_len);
> +		nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
> +		if (!nla)
> +			goto error;
> 
>  		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>  			goto error;
> 
> Let me know if the new patch makes sense.

I assumed the author intentionally was avoiding the memset for 
the memory we will override with data. Otherwise the whole dance 
could be avoided and nla_put() would have been the answer.

