Return-Path: <netdev+bounces-259060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OmWLQp/lGmwFAIAu9opvQ
	(envelope-from <netdev+bounces-259060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:45:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DD14D448
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCBB53004DB1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960536C585;
	Tue, 17 Feb 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7AEdZTu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FntZgPza"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3D36166D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339523; cv=none; b=dPbcF/HcAvFlaSGdlb0eTSWGD05w1UJ+5CMOnj3Lewhpgezr2M82Z+6x+PNobFqK5YB1cRu2CZEqjSe9++42myg6KgzbwofFGF3FHLrDU3nb2UOWhvocfM2Tw7a3ohtwgp692PV9DnRmNqoULUb/BDV5ezylDnMLrjy6PaPKO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339523; c=relaxed/simple;
	bh=aKW/uGyqBBo+lVtol6Xnv6AaHGm9YmPDfD/Jw2il46s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeo1kZjpUPHMJQOF4yQ4FrKCFhUUXrZvfveT3+IWg2jEf4HshARXf2KgcRwQCsT7XMxb5m0cM6zL3o8iKlF6rpx5Rq+/WSODncj0IzY6j+VmnZFKMOVdqriEjqyFHsw4fwuGMuQnv243NVmkrmyTPihnM3Ome3Oa8qWlue8GJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7AEdZTu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FntZgPza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 15:45:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771339520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKW/uGyqBBo+lVtol6Xnv6AaHGm9YmPDfD/Jw2il46s=;
	b=n7AEdZTu5ipYeSo/P3QOXDkKsM0OAGS8fIrThNZkqXGCgRjxTizuow8dvaE+PzQz/aFua9
	8Xyvqmiv88WhZ+e214FR0leLR9OAIiQ5o8hwmi4Pu78IcRXdUQa+liiJYdLMSGL7G8sqQM
	ydk+Dyfy07P0seNYaTKSRvrb5Ni80Ar4Ge8tCaZYhW0tpaCa1smHHOaT2I+8yIBj9aV+qd
	DmV/0BSSHvvnA3fXG7MX3W1CridvNlkDxmiyoKcYiJ5jugoYPLa/nBYlxqqlByW0fufp/D
	R8I8bzF24gRFrb7hVclINSMBPvukN6nhRN+Pi7lgxowjku4L5Phwawff4qIV1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771339520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKW/uGyqBBo+lVtol6Xnv6AaHGm9YmPDfD/Jw2il46s=;
	b=FntZgPzaSVlHMUwX4RB99xbP4F/okMO10r/VMP8Ig3tWng1z0LggF1Y52MlW8Lt9xQqLgF
	tdatpJKsR1HrrWAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260217144518.bYTnPi0j@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <CANn89iJLXKeadC1NAHEZdTszO9t3XwNJJTSWywBtxNf3dM=rgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iJLXKeadC1NAHEZdTszO9t3XwNJJTSWywBtxNf3dM=rgA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: BE6DD14D448
X-Rspamd-Action: no action

On 2026-02-17 09:01:53 [+0100], Eric Dumazet wrote:
> I think this should work, but can you also add this in your next version:

Will do, thanks.

> Thanks !

Sebastian

