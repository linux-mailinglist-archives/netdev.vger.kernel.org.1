Return-Path: <netdev+bounces-266688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Aj7JoiQsWlsDgAAu9opvQ
	(envelope-from <netdev+bounces-266688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:55:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5A266D5F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B404303E2F4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C437189A;
	Wed, 11 Mar 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4UT12zv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LR1+Yq0v"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665842DCF6C;
	Wed, 11 Mar 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244544; cv=none; b=ZUyxOcSdKQS3MGDcUPSe3/Fix97mRtE1bnlDUh2pNDj4ysfD6ApWDzH7wbzWB/+gknXDnr6HWCGPSgM4qwb9ywQ7WcXKu6RpOWG/b8npeWFD/kgn8PJgql4Rr8EktzFvaDRxzZL+5Z9zUNCPNINuMVD7DcG8gPGxPm4rJWvVq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244544; c=relaxed/simple;
	bh=kNGWMAuAFJUCTwM+D5+zfcnFYD7g7UDWzz8DtJnm0N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH9RRV07Pdig+TPg010opD2doxz/Kp7ejg20GkOBcnocnn1sEtogO401vsYj9HJe3ClIp0h34LpwtR6bMSgklNzoiay+hwQV7EG0z6Sue3lZOFREPHSFloJVSd9WRptl5o1UcNnCZgnxGA59Bb5KULJ+Nl5lpJr52ec6QWaCHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4UT12zv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LR1+Yq0v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Mar 2026 16:55:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773244541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEKMDuXDr4mviq3Bbv4PbHGuu5oLRbir+U+6jFwP5yM=;
	b=C4UT12zv/gFwMUJYX6VoZAlOkyKGxArwblm99apnYG6o2d587SRkXBXtJA+Q6PWdzGDVyW
	fFM6URXxKc5ua4Coy2l6DrHA6p2/kw1eJEzwCPXTagOnSDyv/mTkSPtG3ktsGGmUNSlfOm
	8J3/9n5rTP19N/jLDlI78/yxLSYXTnbW8KJB7wF0E0l096dXBL3sW7T5eZQvWTgIbGRCX5
	OV4CRurdSYVHvtaKNNLs1LsNqJW4tccYiiBIvqaKuKG1YUaCAJepe9/CKV4s+8LgbAhBOT
	JkQn3IDBuyHoj4EcN25ZAqCTuqE2UvUz4pSiwzhg7EZ4/J44WylpUnwzykNRIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773244541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEKMDuXDr4mviq3Bbv4PbHGuu5oLRbir+U+6jFwP5yM=;
	b=LR1+Yq0v+zfRQ1Rgb8FlJyeSfjXraETWc+A7SfcrNuE6qg2QtfVIV+PNbN/FRpME8DQCcv
	w8Kc3QoThWO9OyCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Marco Elver <elver@google.com>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh()
 overhead
Message-ID: <20260311155539.3Aikrlaz@linutronix.de>
References: <20260309122055.1226507-1-edumazet@google.com>
 <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
 <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
 <CANn89iKyPZUqmirYza5ewD2dBQfZCMunG771x7cMpUFkvw9x9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iKyPZUqmirYza5ewD2dBQfZCMunG771x7cMpUFkvw9x9w@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-266688-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 1BE5A266D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-09 15:52:34 [+0100], Eric Dumazet wrote:
> > +void ericeric(void);
> > +void ericeric(void)
> > +{
> > +       raw_cpu_read_long(this_cpu_off);
> > +       raw_cpu_read_long(this_cpu_off);
> > +}
> >
> > I am guessing __raw_cpu_read() is forcing the asm ?
> 
> Might be a clang issue. Oh well.

So the difference is that with gcc we have USE_X86_SEG_SUPPORT and with
llvm we don't. This leads to two asm statements with LLVM of which only
one is eliminated. This optimisation origins in commit ca4256348660c
("x86/percpu: Use C for percpu read/write accessors").

__seg_fs and __seg_gs is supported by LLVM but enabling it leads to tons
warnings and aborts later.

Is there something missing in LLVM? The generated code for
raw_cpu_read_long(this_cpu_off) looks fine.

Sebastian

