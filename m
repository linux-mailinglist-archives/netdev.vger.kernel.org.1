Return-Path: <netdev+bounces-280356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACIvE2WM6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EB443AB3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B925300C399
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B1376BCC;
	Wed, 22 Apr 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwFX0Ynn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEOJEHPi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFB3612FE
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847967; cv=none; b=kho6bTcTqrIEmNxgLcFrIGrr331HYd1BmxYnS8Tkel5uHnBz+M9V2mgyifVp7Q9MNYqh9YA8XHEkYxY84ctYQbsfWhscjW7ifD6UARLPzqwRVxYABrOiRtUgBdVRBMpoqVtb1kpU83YQPxTdgVQnW3pF7QsvXtElg06Sv3Fq0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847967; c=relaxed/simple;
	bh=UBObT8iO/vf4D6/b8pnEOMv2hV3mF9Y327nTPnd46X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2AP7Qi3NRlALrsBVqse5fYGeLoprdKJyMqv6iqjSVVXrTHw+cDWf8J6E3iOqqwn2AltiLb5sYBLFSdAYqRMzrMxDLKY8S8qxO64vHNJjWG2OLhmz3zXjmjN/Q7vtzPlZDVjsBYBL6TCvPQ5JByfboDUIvIh7SehXoQ3G/nRyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwFX0Ynn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eEOJEHPi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Apr 2026 10:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776847964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YlgJAWWX1POSj2Z7QVgPUdXiVYf0xmAWEaptmxSACM=;
	b=nwFX0YnnDQ7pQKT/yGkLBJmdAyqWf+eYYzEf0JQt+L6jfV3hh7zt4sXFHDBjSHBsoMKuEd
	aaAlK+94joG/ZfAH5tgbthpL3LHE+FEbWluPBE1PCVT6WJtUNkEyoLzeonCJ2xrVLN1PC5
	7S90UAmZuoDx9jOKlOcB3XclmII4muPENHQPbzEEYLeQBr+T0cKlbGQsAbihpqEPY5BU3h
	dV7B/VMyaAFF/U7+P9LYSCf9aVOzaMqfqC0NVK1WDnlMUIzYNMggXcYfI1+VEXAQtOFQkH
	Pp5vidb+uTv6xqF3At64CfGZschSWQELAsifPOEF2Qk3OZ0WIY0ctuOa9MuH8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776847964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YlgJAWWX1POSj2Z7QVgPUdXiVYf0xmAWEaptmxSACM=;
	b=eEOJEHPiYPIdGOJcDLYTvfU0xSe+HNhGkSLSDzNlG4zqlfbMmwQz4drCkXxvZQKdOjE0Vr
	VZkQvuG2Z8cJquDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, kexinsun@smail.nju.edu.cn,
	luka.gejak@linux.dev, Arvid.Brodin@xdin.com, m-karicheri2@ti.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <20260422085242.3TkVbXc2@linutronix.de>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
 <aeiHa7rzmSqzMIaJ@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeiHa7rzmSqzMIaJ@thinkpad>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280356-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 359EB443AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-22 10:31:39 [+0200], Felix Maurer wrote:
> On Tue, Apr 21, 2026 at 10:50:01PM +0800, Ren Wei wrote:
> > diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> > index d09875b33588..8a5a2a54a81f 100644
> > --- a/net/hsr/hsr_framereg.c
> > +++ b/net/hsr/hsr_framereg.c
> > @@ -189,6 +195,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
> >  				     enum hsr_port_type rx_port)
> >  {
> >  	struct hsr_node *new_node, *node = NULL;
> > +	unsigned int node_count = 0;
> >  	unsigned long now;
> >  	size_t block_sz;
> >  	int i;
> > @@ -226,20 +233,31 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
> >  	spin_lock_bh(&hsr->list_lock);
> >  	list_for_each_entry_rcu(node, node_db, mac_list,
> >  				lockdep_is_held(&hsr->list_lock)) {
> > +		node_count++;
> 
> I'm not sure if this on-the-fly node counting is the best solution here.
> My concern is that it comes quite late in the process, i.e., after we
> already allocated a bunch of memory, etc. As we are discussing a
> scenario where a lot of entries are created, maybe we shouldn't even
> allocate a new_node if the table is already full? For example by storing
> the node_count in hsr_priv and checking it early in the function?

The node is allocated upfront. Then it iterates here and we only end up
counting through the full list if there is no match. This is under a
lock so "many clients" are serialized. If we allocate the node later
then we need to do it under the lock.

I don't think the node count exceeds 100 in production. So having a
counter which is incremented while adding to the list and decremented
while removing items from the list would optimize the "worst case". So
instead traversing the list with 1000 we would just give up.

The "oom block" works regardless. This does not affect the common case
where we have far less nodes.

> >  		if (ether_addr_equal(node->macaddress_A, addr))
> > -			goto out;
> > +			goto out_found;
> >  		if (ether_addr_equal(node->macaddress_B, addr))
> > -			goto out;
> > +			goto out_found;
> >  	}
> > +
> > +	if (hsr_node_table_size && node_count >= hsr_node_table_size)
> > +		goto out_drop;
> 
> I think it would be good to somehow make this situation transparent to
> the user, so they can react if this an undesired behavior (for example,
> because they simply have a large network and need a large node table).

netdev_warn_once() probably.

> >  	list_add_tail_rcu(&new_node->mac_list, node_db);
> >  	spin_unlock_bh(&hsr->list_lock);
> >  	return new_node;
> > -out:
> > +out_found:
> >  	spin_unlock_bh(&hsr->list_lock);
> > +	xa_destroy(&new_node->seq_blocks);
> >  	kfree(new_node->block_buf);
> > -free:
> >  	kfree(new_node);
> >  	return node;
> > +out_drop:
> > +	spin_unlock_bh(&hsr->list_lock);
> > +	xa_destroy(&new_node->seq_blocks);
> > +	kfree(new_node->block_buf);
> > +free:
> > +	kfree(new_node);
> > +	return NULL;
> >  }
> 
> The two cleanup paths are almost the same now. We usually attempt to
> keep them unified to make sure that we do the correct cleanup steps in
> all situations. So please keep them unified here as well.
> 
> Thanks,
>    Felix

Sebastian

