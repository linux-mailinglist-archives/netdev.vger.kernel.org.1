Return-Path: <netdev+bounces-258484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMgdDxgdjmmg/gAAu9opvQ
	(envelope-from <netdev+bounces-258484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7951304AE
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2FEF3019827
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE6224B0D;
	Thu, 12 Feb 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5HH8WYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pi/jkldN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F433EC;
	Thu, 12 Feb 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921218; cv=none; b=KAjXFww2ue0noumpogg6lVfM9Naa8vmO3xCufKx/54hiirElFrOxek2u4gnznUa9Efohm7gw64S3Jc+AndxedtooCQnJ19Y59zso5gZl8WBEtFXpYXquljYs8qxs1rOAm60NaNiN0sSjLL29zYGe50IjGQMroCECpILRB7ibKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921218; c=relaxed/simple;
	bh=8SdfDcKRPfuakCJSOPvwqaACHJV03rk0s1LVXIsBOds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ3MK//UPy+75jCxZY3QWBe+8QOwjgSS/JGllxR9qdwZNXxD2PCvNzdZUfc2cWBaD/N7PSy0VDjd7ZT+GYooX3hVQAbUXu25PhefaEwZNuUKh57YlsqPuwW8HL0lpbHaYa8Qk/nWxwy5vvIqAqoOavi2eaWn9qQ2mOgDp94xRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5HH8WYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pi/jkldN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 19:33:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770921215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQnh022aC2Z+7p6gcLCoz38vdpYDUmqlEBkvoc4gIk=;
	b=I5HH8WYWA4BkepNZSdnP4Dr+ER8kkScG6f40dlArA+Cj3Hpxntd+yuJXi1CH+12cV4Pxa3
	W5x7FvPv8xsQxCeUbECiwKp6BqHvSL6BvAncIt2oL2YxsdDc5gxZVhKJKfyfQ597Q7BfTR
	5wueV7IkDbaxZRQ89PHtT2G2j8iRI80WiVYEbF1acrPf/ZNnrisMlvwWy1ZNtXVpyZfwDT
	wjD2GKtYkTNvwD/Pkd0TV8A2fzOlsdZgpU/jPABGIAjFibl9azuS96P8PhEjt/CAPP7FcH
	Td0nesceEtJobaIcLnFdpXWko28mN2VDbFvJQyUVAu+C4KDLpdXjqiRfdaI3EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770921215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQnh022aC2Z+7p6gcLCoz38vdpYDUmqlEBkvoc4gIk=;
	b=pi/jkldNdevyqJBax/WTCm/DZPNoUUzRLh7IVtMb/LNANHFXl7e1d0BbDd0vw0v5FIscFW
	0jdd0+UsBX7AREAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260212183333.7xQmtLRY@linutronix.de>
References: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
 <willemdebruijn.kernel.2759f838d176e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2759f838d176e@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258484-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 8F7951304AE
X-Rspamd-Action: no action

On 2026-02-11 11:29:43 [-0500], Willem de Bruijn wrote:
> I think we should look at the locking. It is not clear to me that
> sk_callback_lock needs to be held here at all.
> 
> From the lock documentation itself its use is more limited.
> 
> sk->sk_socket->file is indeed dereferenced elsewhere without holding
> such locks.
>
> sk_capable is another indication.

That skb has a socket reference so that skbs should have a reference on
'sk' so it can't go away while the skb is around.
sk_socket should be assigned once while sk is created and not change.
Also that ->file should be assigned on accept and remain stable.
That assignment happens in sock_graft() under the lock or in
sock_init_data_uid() without it (but it both cases it should be new).

If you close that socket then I think sock_close() will be invoked which
ends in __sock_release() and assigns NULL to ->file. The filep itself
is SLAB_TYPESAFE_BY_RCU (as it comes from alloc_file_pseudo()) so it
safe to access it while in IRQ/ softirq because it can not go away.
It should invoke sock_orphan() which sets ->sk_socket to NULL under the
lock. I don't think that orphan can be called from outside the close
path. And inode (socket) remains around as long as the filep is there.

So based on this, if sk->sk_socket->file is accessed from within a
syscall then the chain up to file should be valid because the fd can not
be closed and so anything in that chain up to file become NULL.
From within the IRQ/ softirq a close on the fd/ socket should not result
in an immediate release. I *think* the skb holds sock holds the socket.
If so that skb would hold the destruction of the socket back and this
would make it safe to access it without the lock.
This is the theory so far.

Sebastian

