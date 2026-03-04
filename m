Return-Path: <netdev+bounces-263563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o2EyDuOcp2m8igAAu9opvQ
	(envelope-from <netdev+bounces-263563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F271F9FC4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 203DA3023D97
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7987341ADD;
	Wed,  4 Mar 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCR53Xzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74217341055
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592348; cv=none; b=BdzXjATXBvxZo+t/VVL/1ncaDPW2ccTWzpY/i1OONqPOL39yfbV6EGTuBq1RRrbpw6tEsov13VQ230MWRuBjrhttAnprfCnftsI+uZ05aCfzPmc9TV53xC7YhF7mB0U0cg/RKAkrBIH2PcPd2g25r96m68YUzyWnftAGmYwxFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592348; c=relaxed/simple;
	bh=V3H5RZfqguvWb6GluByMTYr6CPk9AGES6uXohUctwIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aScuxdhkxIk5GwrNIRZc3PF5CNt3alCLrIAzQP4X9M2dDQSf7C7eYL1pH4JNDaRs4AF4UsNFPLx8wHuKVGVCf+QDeOYQJmx294GqCPvL2AHiRYJzS7F9FjrH6yBkkAZLT6llgui22jRGDysxsbZMe+WYUpJbUkdggYy2jwmhuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCR53Xzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97327C116C6;
	Wed,  4 Mar 2026 02:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772592348;
	bh=V3H5RZfqguvWb6GluByMTYr6CPk9AGES6uXohUctwIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCR53XzuTNDNBmxx2OGCC5EQQewybiqRoTdBiGZ7vPsmvoZpVRhSATfJhntvbxk1j
	 Y2wqXj7GOAfMwVXWVCaV1VFrgvauXxIG30c62nqFYpNX6H3a4A95Bp+vX+fmVsRp+a
	 93nvqFh74Waza1MZYEr5gzl2S+raKih6fXsdF9UMuqv6Zea865hz3bE5EOYE/P/yvt
	 VZLgCgNIwhEZM5NSMYFa0TxccPeQafl41e8z7lme8DejYwmyY59JIvzzc//N2LxsgR
	 3rAq5qWRlwU7adSeqrD2/Q7BWJE+zmMMVricYW6sQkkknh0pCGDQTSRhm94lZ2lTgd
	 O6gzPo0GruPMw==
Date: Tue, 3 Mar 2026 18:45:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido
 Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260303184546.6f646803@kernel.org>
In-Reply-To: <CANn89iLU9F3PKP26U_m22V6E=mpqA8LqvMfe42Xp3u5L4Q0k8g@mail.gmail.com>
References: <20260302154201.1621117-1-edumazet@google.com>
	<20260303170841.218b0816@kernel.org>
	<CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com>
	<20260303182429.49645ce8@kernel.org>
	<CANn89iLox=oWvU6VZKSKKtt36zstfJ6Lp5TgQvfmOz1g_-rMnQ@mail.gmail.com>
	<CANn89iLU9F3PKP26U_m22V6E=mpqA8LqvMfe42Xp3u5L4Q0k8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 32F271F9FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-263563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 03:33:59 +0100 Eric Dumazet wrote:
> > > I thought if we remove IPV6=m we would delete ipv6_stub completely?  
> >
> > So we will add #ifdef around helpers ?
> >
> > Lets take :
> >
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> > index 866746695712aeae425100eefb231e44d52d52d4..5de8fd283ac9b0dbc07d5851f05d15e84c3645e3
> > 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -411,7 +411,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
> >         fl6.saddr = src_in->sin6_addr;
> >         fl6.flowi6_oif = addr->bound_dev_if;
> >
> > -       dst = ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
> > +       dst = ip6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
> >         if (IS_ERR(dst))
> >                 return PTR_ERR(dst);
> >
> >
> > Is the plan to define ipv6_dst_lookup_flow() differently for IPV6=y and IPV6=n ?  
> 
> drivers/infiniband/core/addr.c was probably not a good example because
> addr6_resolve()
> is guarded by #if IS_ENABLED(CONFIG_IPV6)
> 
> But other places do not have such preprocessor clauses.

"Normally" for code which is either in or out we add static inlines, no?

#if !IS_ENABLED(CONFIG_IPV6)
static inline struct dst_entry *ip6_dst_lookup_flow(...)
{
	return ERR_PTR(-EAFNOSUPPORT);
}
#else
struct dst_entry *ip6_dst_lookup_flow(...);
#endif

