Return-Path: <netdev+bounces-304357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7qO9LnROR2p9VwAAu9opvQ
	(envelope-from <netdev+bounces-304357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:53:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C56FEDD2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:53:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=KrI4skxM;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=cju51aBC;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304357-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05063011BCB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C7328B4B;
	Fri,  3 Jul 2026 05:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68A285CB3;
	Fri,  3 Jul 2026 05:53:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058034; cv=none; b=o3gxx0/Q0oOUvmKLt3sZ+kjXEEIyWlRnqiqdjom6uahVcjsJMsoNlf5UsiFm0NQAA5lMRT9yAh3PavzfuR8VCuCaTa1KuT4YBofIBbMUiFjL8w800TzNb/+K8yAW5Cylc1R+yQF3sfraK/Q9JLDYshLYOhYCMmtckSFnKD8m/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058034; c=relaxed/simple;
	bh=gA+ohpEGOnnmWlMVdE7Hf5DmX580TNPRdJTBWNA/H40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZiCPWEe7l/Tj36xPLUzIDTN+G3tzWB/HCatQocxPCOPIqKvl9a1xeoT3ffMVZ/zEI/JcjVczjlaYI/4xQ4tavCTcZDqBARJ8kIpc61MwlUtv9s4jlx3rymky+i7mCQxGAH+c885FiIFwSPvwP/f4K9MR6R1T/WJxpr/Lv1EUhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KrI4skxM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cju51aBC; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783058030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrTTbM/MoRg1HsY6OQkPKeGxlPQ5We1d3Cm/DFl3UGM=;
	b=KrI4skxMxTZ5bBQqRl8ooZsbyFfkzyx7GwK4QDUq7wxU9LPWxbf3QqcJh/fJaVWvFJNG36
	8QPreHG1abi4++wQDCwc5OziccH0dk7yUV9ignlzvhBTXJxpfTIzo19hYQf+NHOyjTF215
	oOcF1hu0dIS0aGcxB2khIfmJdmOnxbcpNtAneRFkpo5ukuOhYsh8e1weaFctzKUJVGzfkk
	hYIxecB6/ZomxyM5vsmEc8tUl2WzD9KXPcVVL0GjVLcY8hefi8DXrHc2w3SNSjaKt+A9+V
	1kDo9vb9/jyX1+r6Zrc9WLWmhGgnaWCdQw3UciWjw1r1sG7No7/ygt8QRL5lYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783058030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrTTbM/MoRg1HsY6OQkPKeGxlPQ5We1d3Cm/DFl3UGM=;
	b=cju51aBCxPfqAvl1nBObWLPvCTEz4j8Y+yLjPRSoWoMDK5ZmsRGe4LVSylX8WL+CX3P1jY
	vOF4P9uJLTo5jeBA==
To: sashiko-reviews@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
In-Reply-To: <20260702163608.0207A1F00A3A@smtp.kernel.org>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org>
Date: Fri, 03 Jul 2026 07:53:48 +0200
Message-ID: <87mrw8sjo3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304357-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 115C56FEDD2

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Garbage collector is no longer scheduled when creating new inflight FDs, leading to permanent cycle accumulation and -ETOOMANYREFS failures in isolated environments.
> --
>
> commit 506189bd29f8ad56f5d9e51f3e0216203ebad5ec
> Author: Nam Cao <namcao@linutronix.de>
>
> af_unix: Do not wait for garbage collector in sendmsg()
>
> This patch removes the garbage collector scheduling and waiting from the
> sendmsg() path for AF_UNIX sockets. It aims to prevent priority inversion
> by relying on RLIMIT_NOFILE limits and asynchronous garbage collection.
>
>> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
>> index 0783555e25266..f180c59b3da9d 100644
>> --- a/net/unix/garbage.c
>> +++ b/net/unix/garbage.c
>> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>>  	if (!fpl->edges)
>>  		goto err;
>>  
>> -	unix_schedule_gc(fpl->user);
>> -
>
> [Severity: High]
> Does this removal prevent the garbage collector from running when a process
> creates isolated socket cycles?
>
> If a process continuously creates socket cycles (e.g., passing FDs to each
> other) and closes its local FDs, the sockets reference each other in their
> receive queues, so their file reference counts will not reach zero.
>
> Because the refcounts do not drop to zero, unix_release_sock() is never
> triggered. By removing unix_schedule_gc() from unix_prepare_fpl() here,
> unix_release_sock() is left as the only trigger for garbage collection.
>
> This could allow the inflight count to accumulate indefinitely until it
> hits RLIMIT_NOFILE, causing subsequent sendmsg() calls to fail with
> -ETOOMANYREFS and permanently leaking the network namespace unless an
> unrelated AF_UNIX socket is closed system-wide.

Sashiko found a valid issue here. But this is a pre-existing issue. It
is not introduced in this patch.

unix_schedule_gc() does not actually schedule the garbage collector
unless user's inflight unix socket count exceeds UNIX_INFLIGHT_SANE_USER
(2024). So user can already accumulate up to 2023 inflight socket counts
without the garbage collector running until unix_release_sock() is called.

Nam

