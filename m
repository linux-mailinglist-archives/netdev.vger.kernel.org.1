Return-Path: <netdev+bounces-268982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OnkICSKumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:19:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7E2BAB17
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DEDE3004434
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C23A5E76;
	Wed, 18 Mar 2026 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AO2RpScD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQYbW7vy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8383A5E71;
	Wed, 18 Mar 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832732; cv=none; b=DDDZUtNH+NfsrY996i4suk4akV7Njbs5buDTy5UjEtJYB9sp6fcbVcmq4KKKZxq1CpdmNxKNKzXsGHFLsZ4B9N1IONM1XW2OHEtfLxP9usm2HfrcPjhaU0hUSyhYNGXeX0ob+1vQbjt5Jz90YDtVqjvKRncejHxijxp+ZiAHCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832732; c=relaxed/simple;
	bh=bJe0PYpyRjHukT9qLOBVKaNIzLteT/yA64kVgxBFI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBvgs3ErozLAJw4NlCdvtGJuGmcxZyRc6p++0ZfzaDdLDlCkKrcvCNfVDY/Pk/DLWpJgydA43R6TCVDmgs8P4FrLisfOzFJSTA/UT1W8++pQvMcEZbDQ8OOesgT4HxWAsorWIgX8HsaeeJD/Sv/7o9kSrr7EW7UeEPx0fc+0jjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AO2RpScD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQYbW7vy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 12:18:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773832730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxaCdQ0lQZu2iwO4iw6e+PL/8HdlRXgvCeHY4BHJs9E=;
	b=AO2RpScDqME6HxDyDfxEULxFreHHNu2Ir9bQdUO8E0nV8OJNmNl/pFcc6B/QoqsVvJnkwf
	SKvXttrKxRO3Axd+hMY7/btc4lIhcw/qllkuJvYZbcKZomkAmUdFkTSp8J9gNNieky71Ix
	jRXTuipy2SV6+KGJNUa9DfHbKCjdzI7z47y4OM70Ajk4lT9A00MlRI0lPjs9Ugkf/AYje2
	rWq1nqAAZgnWp5vtlbReqY7XvlhGNKONH9OYEKuu6oq+YPD2VhAlPxM/+a1LdtgdE70kQr
	mBJFWQPsQ4v0Ox11/X17iirIVpIMBrmHB6CA712uA2obCnRo86M0Dok1jbIi/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773832730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxaCdQ0lQZu2iwO4iw6e+PL/8HdlRXgvCeHY4BHJs9E=;
	b=bQYbW7vyenNb1Uaq+9z2eUwImWSM2hgVT6+UrWJzC7T8vQRHrksoiLtjok/6FG1idaL8V0
	6U1CAoX+zei2WJBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Vacek <neelx@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	spasswolf@web.de, tglx@linutronix.de
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260318111849._MMol8Hr@linutronix.de>
References: <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
 <20260217095700.SjYjM8RO@linutronix.de>
 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
 <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318103009.2120920-1-neelx@suse.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de];
	TAGGED_FROM(0.00)[bounces-268982-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85D7E2BAB17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> >  		/* Other cpus might concurrently change txq->xmit_lock_owner
> >  		 * to -1 or to their cpu id, but not to our id.
> >  		 */
> > -		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > +		if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> 
> Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> which has already locked the queue (and hence the same CPU) evaluating this condition,
> the condition was skipped, which is no longer the case with this change.

The above was me thinking and does not even compile for !RT. Commit
b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
netdev_queue::_xmit_lock") is what was merged in the end.

Sebastian

