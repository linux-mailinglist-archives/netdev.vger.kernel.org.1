Return-Path: <netdev+bounces-280386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPhbFf6p6GnEOQIAu9opvQ
	(envelope-from <netdev+bounces-280386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:59:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B23974450B7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025773011F22
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A93CCFC8;
	Wed, 22 Apr 2026 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMz06eNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcCSdox/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258317DE36
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855539; cv=none; b=Bs7Vk/EHG41VYMqmk8c3p9azAIxttdMLWI0DbuJkPYsGmXNmNFAg3I4wB1GLMg9OV3EzE06XgwDvn17jaJDkWJ+Yz5GtXMeaosGppkAkBRbHgDjNu1xYkHDWTCSvoIkQG2A0O2RrIxINKMnMXjmH7RB3r4+NevLmWi85peUfUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855539; c=relaxed/simple;
	bh=r18c/7FHWjAfUJ4mgup1bEnwDm+754O+tVmKP+uT2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcUSO91l1eksklCzQlWu/OOe8J8sZqJZ6XOMU1YRfnVwZpLYNAlnYIBL/Jkfs3D+ke1qV5tiyygYSm/ptY2RIGVh+tuopoLREp4d49sBdkYY50GcbxLM7OyqS24DzDvS2owMquTUAQ+7wKJmMHv0JLJsmYBshX9kU1oc7sxKVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMz06eNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcCSdox/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Apr 2026 12:58:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776855536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSGw1jif+weQFLDuy+lS15aJ3QkgtlFox/KOoopjEFc=;
	b=zMz06eNG7hjXscV+wjn3jvg6u4YmA1ro6QN9u30S9w5UrbtCJ9jcX8un5U+bh7ygRXLm1U
	a+Wk+GmKItWsf9PnT42RxCh2hwN1+6G9Ix5t67rmXpX0FoQ5FIqTD2UnrCnUVOicTGpGpY
	cTGtf/PB+kL2WIVdp7GuxyQxQSGxOQNV9N+ql/GkRAkO32gYg3FqzhHbfRA09mT0/tX45F
	Ftc72nJ8p71tae3S1fk9d9Ak54Am1f+UxiNfEOhELFEAk1VPjtH/yUrczH/a1F1bL7T/yy
	UgErnThI0VtKe2bDa0jEkYiBiIGuGuH/JO2sFCTA0BcG6Kcb1n5UHzvbB2qUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776855536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSGw1jif+weQFLDuy+lS15aJ3QkgtlFox/KOoopjEFc=;
	b=tcCSdox/8cwsK9cETfgvG6Wm3S0RZAtpljOtyDcx+4wH7CCsWjxkgomuBadc8VyIMbONJ6
	FSJkTdwZA+8WNtBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, kexinsun@smail.nju.edu.cn,
	luka.gejak@linux.dev, Arvid.Brodin@xdin.com, m-karicheri2@ti.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <20260422105854.trLbmAmZ@linutronix.de>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
 <aeiHa7rzmSqzMIaJ@thinkpad>
 <20260422085242.3TkVbXc2@linutronix.de>
 <aeiYpkiWUD5MtGEB@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeiYpkiWUD5MtGEB@thinkpad>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,smail.nju.edu.cn,linux.dev,xdin.com,ti.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B23974450B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-22 11:45:38 [+0200], Felix Maurer wrote:
> > I don't think the node count exceeds 100 in production. So having a
> > counter which is incremented while adding to the list and decremented
> > while removing items from the list would optimize the "worst case". So
> > instead traversing the list with 1000 we would just give up.
> 
> The counter is what I had in mind. I agree that allocating under the
> lock isn't what we want.
> 
> I'd argue counting through the whole list is the normal case.

yeah but counting here is just a register increment which is cheap. 

> hsr_add_node() is only called after the node table has been searched
> already (without the lock). Here we go through the whole list again
> under the lock to prevent TOCTOU-type situations.
> 
> I agree that, overall, it would be optimizing the worst case, but I
> think it may be worth it to prevent the memory allocations and walking
> the whole list. But I'd go along with the (current) on-the-fly counting
> as well.

Yeah. But then you have to manage the counter on add and removal just
for this "we have too many nodes" case. And theoretically you would have
to hold the list_lock while checking the counter because nodes might be
added on both sides in the RX path (unless you check early lockless &
optimistic and then again before adding under the lock).

So overall this looks simpler.

> Thanks,
>    Felix

Sebastian

