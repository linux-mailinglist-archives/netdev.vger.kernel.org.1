Return-Path: <netdev+bounces-268902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMkqAD1Uumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:29:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187A2B6EFF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F966306ECAE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CF9368946;
	Wed, 18 Mar 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7lNnBev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sYJiqZbW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175F4A02
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818681; cv=none; b=TdAGCqFnVEKvWZDh3tii6EbL3N7sX+qJ8vojEqiYckalnlthOh0NUlySFE5m5Z0BI/9LNudWCmIveUSR5SrvPuqmkUmwa5hIDjDJwgy52fo8zYR8W3NxOqf8eaL5GlkbjWAIJs6qDaeknwCZR3Y/qubUN9wNPJMrlFZzTDz1W1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818681; c=relaxed/simple;
	bh=I4awxfqk4O7MQlZuO3DMH2SeFRu0qfiWRR1f/Rdcsjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhmZ1xyapN3ZynXl/amoOeaQ2x0gAbM79376vrmuPgrZF0FGOvKR/wL1m/OhVU9avYazjivCOvFCsKSlmIpdHZztOuY/82MjYjWOtNtyiJ+A+VsZPERew2iCDxsj4Bl7ryBOCIvZBo5k4vTXwsfSTsVrUqYO6lRIv/V87tFcqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7lNnBev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sYJiqZbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 08:24:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773818678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMXojMRx2DusSv/c5foBS++mXTfilxtffy+hvVganPA=;
	b=S7lNnBevReHY99KsphuvNO/RK9P26Ns+4nArqabBAs1aBiuHflX+bv+F5qvBlR4+2ljCsv
	4ghLWAw7eXvoyKM4agFSwLDTsQirl6Cb3lYs15mATHR4H9Suz0KRc7xYxnPuwdz/K6v7xt
	OjyBiWzESZ7awsJbWfKleMx6+RkAYeR3iQK0sATcjWYzoLKnpgtiOdn/MSeJcdEuQmv2j2
	rzQAbKFWbZDajTEQZPXi3OVDJ7cuhgvblcvgWupHh+1hf99uXLAhv3JkQP+m3pZMcabAdC
	j3BjhQUMOeqD5xSj5xJt8twr4bWoUUnSx15waNrj2TS6URBSezG/HxHhTSvkPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773818678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMXojMRx2DusSv/c5foBS++mXTfilxtffy+hvVganPA=;
	b=sYJiqZbWtA9QAURWngFUcR85rU8xJ40MigLKGcHADExuVS2kSkbUQ+itgzSefupLqBrc/8
	N4d7P2Q42WVCnhDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com
Subject: Re: [PATCH iwl-net 0/3] idpf: virtchnl locking and async fixes
Message-ID: <20260318072436.4JmVdDfK@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
 <20260317090054.DuPZ6O0O@linutronix.de>
 <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
 <20260317143850.BLrnAox8@linutronix.de>
 <f77ad6b1-1fff-4f3c-a411-5115bb66e31d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f77ad6b1-1fff-4f3c-a411-5115bb66e31d@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268902-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 5187A2B6EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 12:30:39 [-0700], Tantilov, Emil S wrote:
> > What would break if you make that lock a spinlock_t?
> 
> Right. Scope and risk - these fixes are specifically for the async
> handler and I did not want to touch the global locking that will
> impact the entire VC handling. We do have series in flight for -next
> that refactor that code, while moving it to libie:
> https://lore.kernel.org/netdev/20251117134912.18566-10-larysa.zaremba@intel.com/

Now I understood. You fiddle with the completion's lock. That is
something that should not have been done.

> ... that also remove the raw spinlock. With that being said, I can look
> into converting the lock to spinlock_t if that is the preferred approach.

The preferred approach is that, if you pick raw_spinlock_t for locking,
you are aware of all the consequences and you have a solid reason for
it. The comment in the file says
| For now, this API is only used from within a workqueue context;
| - * raw_spin_lock() is enough.

that is not it.

> Thanks,
> Emil

Sebastian

