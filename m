Return-Path: <netdev+bounces-295576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id heGOMYQuImpETgEAu9opvQ
	(envelope-from <netdev+bounces-295576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:03:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939F64494A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RMI9oC9W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295576-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E627E3076B1D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AC37FF66;
	Fri,  5 Jun 2026 01:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B2253F13;
	Fri,  5 Jun 2026 01:52:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624350; cv=none; b=AoYdADyexM1rmX0VwO0HZUMwLlxGdevOA7nQq1278vxdHMXXIITGB1dMM2Claq/R6VJH7BoOloitAMiSdSA5yXpWK8Y4/Cj5we1vFSEMa/ew7FleS+QcE+tkUBU07u8NauM1DAyhGPOx2XY2kj88l5L9H+OPOzx8usyx0oKuPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624350; c=relaxed/simple;
	bh=XdNGHLzzmLPQLk5Np/UxW7RO8EfDraHy3LUeRDy4IFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK0C6GADWLhF5NqCuC37OAflOE02qu54Lt5K3qmueu/jJFvxtcLRKKYBP2iRD+8RNa9Puv+ywobxDMAPnLaygIcNG6hG+XTVoPJSN/rc7JtaxIs/I5p2SitV1YIJWHmlmat2DtFqT2JEj86uc1cL7R6TitMvqGJN7/knvdJ7rIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMI9oC9W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB1D1F00893;
	Fri,  5 Jun 2026 01:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624344;
	bh=zYZKQzJ7zPWE8IzZN6QipGkw8psLqfyPxmzoQEcOgD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RMI9oC9WkY4Vd3JhcbLzodR4vkSfN1AOUPQ1Y1xPvQEhB9E0f7J2IhtI+dPwwxfUo
	 HPM1Mb4t0fCtCW6FzTJJ0Fn9JMD7zInl5p12tWQSu90hxDg2/6xBaULX42qVRpxruP
	 WyDyV8+2PT3n1U7TdbjJzHZ034mzIdT52x7lF6QG7N/JnnujDaETGwgfZTVNu87fEL
	 h9Wm0AYmBmBAws+3CIsW8yaPKsvrqpShR1J4e9GU6uKV9VlLCVwGqWI7VNFyqPW48L
	 3mMt4S+taTAlIfip+xmT1Me+n/Pw8WGthEsx+RnzWa5yB00vwoamZCsMM9QvhqeX9B
	 sJlHBeCQg34Zg==
Date: Thu, 4 Jun 2026 18:52:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Li
 <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes
 <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Simon
 Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki
 Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
Message-ID: <20260604185222.794ea329@kernel.org>
In-Reply-To: <20260602183122.747759-3-pfalcato@suse.de>
References: <20260602183122.747759-1-pfalcato@suse.de>
	<20260602183122.747759-3-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:vbabka@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1939F64494A

On Tue,  2 Jun 2026 19:31:22 +0100 Pedro Falcato wrote:
> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> These allocations can be variably sized and their contents can be more
> or less controlled from userspace, which makes them useful for attackers
> that want to overwrite a use-after-free'd object from the same kmalloc slab
> (which often just requires the sizes to roughly match into the same kmalloc
> bucket). [0] is an easy example of an exploit that uses netlink skb
> allocation to target another similarly-sized accidentally freed object.
> 
> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> probabilistic. Use the existing kmem buckets API to further isolate these
> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.

No idea on the merits but from networking point of view:

Acked-by: Jakub Kicinski <kuba@kernel.org>

