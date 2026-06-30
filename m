Return-Path: <netdev+bounces-303240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2suOLDVQ2phjwoAu9opvQ
	(envelope-from <netdev+bounces-303240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:41:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7196E5846
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:41:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=CgemoEDA;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=D5H2UWkM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303240-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AFE3151AD8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67743CED7;
	Tue, 30 Jun 2026 14:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D243900E;
	Tue, 30 Jun 2026 14:37:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830254; cv=none; b=HKAakKxJj0CNAwcGngvLZwYl20QrbNDKa8CRxUjLXV4YTr/dxGEG5kUVOX3cjxlDklY0jWHuFytWgzke2oQqwXI75FsgBG3k2FArGvrfZzUXePj1oPv4HPud/DQKeseaCZTF5e5bV9yHqtbr1keTrHuceSscyBwHdElFdUKbHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830254; c=relaxed/simple;
	bh=qYkGTJXbPXZcHnt20w8gJCZ37O5G4G3Mba+cie49R0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWteplM4Qs0U7xBke+uylZrER02fHXC5Tb6Mu9Ymg8FDFOHP5pvXhSgTT6Anwe/mjrzPU/wuOt7QekPXqZvS20eUJGBgTBrNF4zJYwQiWR+RaLAJZdE4dKCkKX0yC1TrN4luXMPs2/vySA0jazLJX3XFx075rryq+DmIORJIddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CgemoEDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5H2UWkM; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 30 Jun 2026 16:37:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782830251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezLN1M9JlwArYj7BBJygaHQ3CcZPQGglpyFqaQ1V4EU=;
	b=CgemoEDAhBhli2MXnGblrEhYV4/HcyVG4Xjp+/Gd2phD6kvZ1O2qSs1SIjc0nbTGDvSe1t
	SUJgsFTMOKgoypA7l9oYtkoLES9+TVoa4dzx1NmzQlSTu0UbjXTPPVl7queu7A0B036oOl
	+mTf78Onz3uOxHkVFhcZhJXi4AQT3wzFKLh7ZDLlloV7JEPFhRHH+VfT+XErIq3g2UR85A
	STi/ttIDIN1dryJa3rHioQ6LwN6vECe0c+OC2C5wMP+AVoLXLOPYe2/WkueA8QNKog3IFk
	hs3ENulEsxDhWGQEaiwGDa4zWbL8cCFIic4c/wm3xEpvKXuMR+tzrug7dBSBYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782830251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezLN1M9JlwArYj7BBJygaHQ3CcZPQGglpyFqaQ1V4EU=;
	b=D5H2UWkM9IozabpBUu6oLVONiIjo5RguuKx2l7+CVKip0gjzunesfuYXepr0BBWbXW1QU0
	33ipBUNDFvJMU6DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, andrii@kernel.org,
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/3] Fix broken TC_ACT_REDIRECT from qdiscs
Message-ID: <20260630143730.ZhXWjEIh@linutronix.de>
References: <20260630123331.186840-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630123331.186840-1-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,mojatatu.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A7196E5846

On 2026-06-30 14:33:28 [+0200], Daniel Borkmann wrote:
> This is an alternative fix to [0] in order to not uglify
> __dev_queue_xmit() with sprinkled ifdefs given this can be
> simplified and isolated through a simple test into the BPF
> redirect helper itself.
> 
> I've also added a proper BPF selftest, so there is no need
> to check-in a binary BPF object into selftests given we do
> have BPF infra for all of this.

1/3 makes sense. Assuming we wouldn't have this per-task memory
assignment, wouldn't then the state from one redirect leak into another?

For what it's worth:
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

