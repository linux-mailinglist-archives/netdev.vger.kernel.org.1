Return-Path: <netdev+bounces-293177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLnnA0DSGWodzQgAu9opvQ
	(envelope-from <netdev+bounces-293177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:52:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E80606DB9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2E08301FE46
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2B38F932;
	Fri, 29 May 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zle2z5ls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2aoLXtd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07038F624;
	Fri, 29 May 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076387; cv=none; b=YMdosUgqRHHchgCZQg2QZ5mr59iVTEijnij3de+YU2B/mNDxbqqRMVMlP9y5CSXXX2P2vDkkoRzsdjTZJRxXZUcRu33CDjFa1aEOkQBCtk4Zi+LpWzDAVmzVegLQDsLNDLZK6ze6r8mZLEZo3oq4k+icmLPr6rXoqhmWAvCHjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076387; c=relaxed/simple;
	bh=5rmLfBjBPMwYbOt7zh/C+qkEroMeV6NHO0X7rlgwSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWo3WaypHd6ruXAmGquZObx1O8Qv/TSw0QuA3o2wvpbbq2gGAJvDtJGMCxl+MN+xawn7iO9rorBRBEywGWOx6b0r1CeFgkf/fcYpuEDe/9p0hJV8aHhGwsl/wEyr/cBD16qIO86JyYJr/uip4wp0ATj9kPtjmWWo1kXVLqbJ7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zle2z5ls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2aoLXtd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 May 2026 19:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780076384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0O7hbUL4Sl1IPUjI+OKV+mISVBGqa54rUK2LRWlDBsw=;
	b=Zle2z5lspCFzmskAEi1lr88grAGaLFFcNPR4qGoofENcYo3iEoF/+CD3YkKR1LH29WmMZe
	Bti92b11OrphVdyDyJHcvxHBPo91uarzpqB330akp+JKYo/EDukEpIdiBjjPjVxTViknMv
	b0NAIu0/tbRs4LBTZDavtiE316EGh5LC+VWaJcLxykvoSgIv77SY27NDGJLQyo4oW2vHOK
	WihtM1eQmUzQzPStU7PEhyutM9s4uSnP6rt9IJwAYtTiwywaZiqSf4rNH7dDTTI4We+x9f
	nb1F5OiDyrQJuK+74dD+yIBYpSuKsF57UDxnzSyy2YcImiktI9jLJmZQRYyGOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780076384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0O7hbUL4Sl1IPUjI+OKV+mISVBGqa54rUK2LRWlDBsw=;
	b=l2aoLXtdy2LNYFw7si94dmlod81EPENh0YKgEEuAatgwLF+tl+Akw8T3tjZjvHFwDv8RZs
	1QcaOiQczTy5uwCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Florian Zeitz <florian.zeitz@schettke.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ptp: vclock: Switch from RCU to SRCU
Message-ID: <20260529173943.9aedelBp@linutronix.de>
References: <20260529-vclock_rcu-v2-1-02a5531fab92@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-vclock_rcu-v2-1-02a5531fab92@linutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293177-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,schettke.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,schettke.com:email]
X-Rspamd-Queue-Id: 69E80606DB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 19:11:47 [+0200], Kurt Kanzenbach wrote:
> The usage of PTP vClocks leads immediately to the following issues with
> ptp4l with LOCKDEP and DEBUG_ATOMIC_SLEEP enabled: "BUG: sleeping function
> called from invalid context".
> 
> ptp_convert_timestamp() acquires a mutex_t within a RCU read section.  This
> is illegal, because acquiring a mutex_t can result in voluntary scheduling
> request which is not allowed within a RCU read section.
> 
> Replace the RCU usage with SRCU where sleeping is allowed.
> 
> Reported-by: Florian Zeitz <florian.zeitz@schettke.com>
> Closes: https://lore.kernel.org/all/00a8cce8-410e-4038-98af-49be6d93d7bd@schettke.com/
> Fixes: 67d93ffc0f3c ("ptp: vclock: use mutex to fix "sleep on atomic" bug")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

