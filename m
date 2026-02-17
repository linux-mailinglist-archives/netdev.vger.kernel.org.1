Return-Path: <netdev+bounces-258973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5ZEDgclGn0/wEAu9opvQ
	(envelope-from <netdev+bounces-258973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C2149458
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89243302268F
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC62D640D;
	Tue, 17 Feb 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeUxhY0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxjZNW6h"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8318C02E;
	Tue, 17 Feb 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314188; cv=none; b=I2bQVH/PcVSDOOC3efQpSDdLbbyBxYTO2Zu8Hr8t841K/4542o6iDJFW5L+zbUKzSgqBq0991EPdVugHNPxugGo/vEh1+qY9CQS9r0cPT6tYmTa8iDSrvz/ViQkr494/VlxLXO8wWMdUfQD3BAeK8xFsHjdO5F3Lu2kavxSA2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314188; c=relaxed/simple;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0tHS3JRR+FGxR8ai2E1io3vC1qRSaDP9h9VIstwfbLxM9N7Ow0YrOViY5btclp4nWsOz3krkrC+p0KGpq+StXepfcKWUvUcFooP3+w5PzWbtr2j0v9R+s3XUK1usyZxu7BBGzzaEWj4PPRWLUPNtVkCfSn9g4FksVM8R2GZUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeUxhY0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XxjZNW6h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 08:43:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771314185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	b=UeUxhY0G+UqdM9PdYKA9MazplqRkMefwPQh76oCDjKnNA9wDciUHgwi7/iSi76NpIuGZyW
	pu6g41NbQ0GI+j5X9lQTgpovf5nnBxs6ht9pXb1z6bGAIKA4uJjBT5OdyTdoMkYTMUhlYQ
	HsaalDsmJOu0i1O70v91rhyONULOSXigk4FtNl3ZNtOrbhxKQ2llhRQfQ83wz8DFa1ZPpf
	tjSfNTX+krK/6DXAmJtw78xPYypTAgpVOz/14YUu7lfmNA2ZKosRribcTz6fR2TKjnyBPl
	P/Hu+jGksWdP4Y7ng3MXZ9Qc8i7Pd6f7f0s957e4DF3H83WitNb60l882iZsPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771314185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	b=XxjZNW6hQE5t4LsmEhyv1PVamaqNcnnZoFjkzqmIxc9fhnOrcilnZS7wr2eEAIaqOV9wPp
	K3h2VMcIMjKGAFDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: jiayuan.chen@shopee.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue
 races on PREEMPT_RT
Message-ID: <20260217074303.aWlBuoFG@linutronix.de>
References: <20260213034018.284146-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260213034018.284146-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[shopee.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: AF3C2149458
X-Rspamd-Action: no action

- xxx@vger.kernel.org

On 2026-02-13 11:40:13 [+0800], Jiayuan Chen wrote:
> On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
> (when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
> preemption. This means CFS scheduling can preempt a task inside the
> per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
> another task on the same CPU to concurrently access the same bq,
> leading to use-after-free, list corruption, and kernel panics.
>=20
> Patch 1 fixes the cpumap race in bq_flush_to_queue(), originally
> reported by syzbot [1].
>=20
> Patch 2 fixes the same class of race in devmap's bq_xmit_all(),
> identified by code inspection after Sebastian Andrzej Siewior pointed
> out that devmap has the same per-CPU bulk queue pattern [2].
=E2=80=A6

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

