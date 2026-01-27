Return-Path: <netdev+bounces-253751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mON5N3J8eGkFqQEAu9opvQ
	(envelope-from <netdev+bounces-253751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:50:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C091499
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2782A3045ABA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A732C028B;
	Tue, 27 Jan 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fj7fMxY+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xikKYsly"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144C2D5C83
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503803; cv=none; b=UaBB5Ls6010dVONs83e7NxZl061phr6wpVydIxu8gmybbCa5PyzgY065aKZ9/3Bm6sMlDCrHXl8VCZHWnUVzp3iacxlV8AyOPHNp58erXsUo9cheHfnKwE6yubb9MR/21yTT9YxO3kmphjt35+NaL+mDmQnFt8xdFx6n3kndPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503803; c=relaxed/simple;
	bh=Lqi4B3DfalJW/g7RguaI+aZ9llcE6Ysa1VltoLhmtXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCdZSVyPY+pRg/6BpJDXJ2pZifzdMImftktAXOYsx7iLlzpkxTUfpG/KCUzLcmN+z0RzSiUmh/gUjQKtMIZaZ7sPd2s8hU07yj/QqaJwIj+eSmggr+thYZIyDL+E8WZ0cGqewv1m7JVcpfRKbqPtkO2PR2Hr9mN+bvmqWiV1hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fj7fMxY+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xikKYsly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Jan 2026 09:49:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769503795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9IU1ZVqem7xJXypm2gIQFdXpfRZpQK6loV/8Rj9rWbk=;
	b=Fj7fMxY+tpJZ3QaRR5+LhvYrzS9ARN00wp6lmk2QAco/D7tKEiDSwMVDqrAn9cFqASf9Cp
	rLhjo5S5oxdO/coi05meN6AYCKICDn7Pbfat0NyoZIjrQvjV0hbHF3gFLTxIVikrnvlsWv
	3LYct2B0uIzIITBy14X8T9bLZtNA5WlhTEx/m1CngVOrxdnt5v8yruWinDr9jxn1LIu309
	aWH6KC2oMjeEz3jU5DNiB2ALX+bXZnbBhV01pyEdp15On+BFQmkBfJ2SRb+kytOFDvCCFj
	r443JkJs9lqu0HGUJPkBmouR3ysgj7auAtfif987XsuQmw1jgI1Sr7YslJ7JPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769503795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9IU1ZVqem7xJXypm2gIQFdXpfRZpQK6loV/8Rj9rWbk=;
	b=xikKYsly7Ayi1Tpr2k59v+hXcfmmUOpasSEtUs3UdGIq6HIhNvNC5tl+Aeym/E/BtZJjQQ
	bc3bQVzlj7ceoEAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] declance: Remove IRQF_ONESHOT
Message-ID: <20260127084953.knXW3cK4@linutronix.de>
References: <20260123110616.416384-1-bigeasy@linutronix.de>
 <20260126194054.79e6f56d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126194054.79e6f56d@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-253751-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 387C091499
X-Rspamd-Action: no action

On 2026-01-26 19:40:54 [-0800], Jakub Kicinski wrote:
> > lance_dma_merr_int() does nothing but a printk() which means if it is a
> > level interrupt then once it fires it remains asserted and that printk()
> > takes over the machine.
> > I guess it never fires and is just left over debug.
> 
> have you seen 0fabe1021f8bc9cffdede4ddad0dd04d43c5166c ?

no, I did now.

> Sounds like it may have been a hack local to MIPS.
> On a quick read indeed your changes seems fine but it would give us
> certain warm and fuzzies to have the commit message refer to and 
> reason about the patch that introduced the flag..

Will do so.

Sebastian

