Return-Path: <netdev+bounces-274428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOI+NworzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF8386247
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB819300E177
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC73630BC;
	Thu,  2 Apr 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r5wr3P+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuML5iXI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57B33F5AF;
	Thu,  2 Apr 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118687; cv=none; b=DJI47N0vVtbZ4PBNYEz+Fwd51MzY8cMPea0CYZcPyf+TfUlQ7dB+2uygnWRDTv2BhQykxigAHSqtCXvEkj5BVotm3T3qvdMKbc5N8yJDoN2i35qc2gVICRhoCR6B65vqjwqzDKpgkVDUtY55vv1UWofsnKV6T5inaTm8LTS3+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118687; c=relaxed/simple;
	bh=uKKtP07RRZn/4h0DSBdW11+g/FJIF3/0cIUxaEyE1qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYzym0Ecac2SQwaB4kL2qeG9j0IIsJ8Rtz9pfB4nLbmkVwJ7g+3y6hEUAoqfaBEE235THH1ukteixSiTydE8reSBWRil74pmNKB19bk12CQv2ORzlvVi/eF7ELjlBo1IwbjZRLdiThOBczcDiAIb2pjXnh1T14c0/S01z38MypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r5wr3P+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuML5iXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Apr 2026 10:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775118685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MaazjW7/FCpbO9IcEWdomGTGLW4pCW6rEmQxTog2Lwg=;
	b=r5wr3P+M8ZPUiz7A3+Zz5wDYtrPybMf22U/Md5TQ0EH74hX0eiTpCWca6eH1k3uLSBkPrP
	WQTzAJzJCv7vB+6nCpe2Q8GA5cE0DU/f0PwEy42PYiGWQTaSJAOJVx8DkpOcJbnhJamtHk
	3bTWruF9fvXe/7BF52FtiUGMEB+31Q3vRqdaZMQmYKQ4h8iTX9jjNNs07VviQ4UWLMBMTW
	x2T9cFHHudjb4+d7cKsui2xnaFuK4Ropr0S5sWf8WxmoVFsZY5XWluuAOU4oY+JNTyaH3i
	4B0f3G3OQ4NQfAKH13aaqpXERkXLoCEQ3uV+WMyF44RSKQIQn1DnTh9IdqIT5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775118685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MaazjW7/FCpbO9IcEWdomGTGLW4pCW6rEmQxTog2Lwg=;
	b=ZuML5iXI17uHPoZwilv08se3Zic41s6IzYgsI68jT/TUjkM3QrN5GWV6+tYrSW8+U9OONS
	XupZcKrdSgrNwUDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Vacek <neelx@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	spasswolf@web.de, tglx@linutronix.de,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260402083123.1H4kyAEn@linutronix.de>
References: <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de>
 <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de>
 <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de,atomlin.com];
	TAGGED_FROM(0.00)[bounces-274428-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BDF8386247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-02 09:50:35 [+0200], Daniel Vacek wrote:
> My idea was that the non-preemptible one can record `current` task
> instead of the CPU to detect the deadlock. And that would also work
> for the preemptible case (it would actually match the lock owner
> approach as you did for the PREEMPT_RT case).
> One code for both configurations, no special-casing. I'd argue that's
> a better result. Am I missing something?
> 
> The size of the netdev_queue structure would grow by 8 bytes for !RT
> case, but that's not a big deal, IMO. For RT case it would just fill
> the hole.

We have xmit_lock_owner as int. If you replace it with task_struct *
then on 64bit the size of the struct netdev_queue will remain unchanged
as it fills the hole before the following long.
Then you could record `current' as the lock owner in both cases. This
should work.

> --nX

Sebastian

