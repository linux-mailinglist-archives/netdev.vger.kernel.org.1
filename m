Return-Path: <netdev+bounces-282592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jyEmC/e18mmotgEAu9opvQ
	(envelope-from <netdev+bounces-282592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8873549C1C3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F228C3015848
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C266274B46;
	Thu, 30 Apr 2026 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzT1Jnao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09360175A69;
	Thu, 30 Apr 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513970; cv=none; b=O5IOLnzr539DJi5fkM6W1LKERit5f6wQkfFfrm67qYf7oYAZGO6bD4WT/u/MgzuK0XnMUbegie0HPXqaqCbPvIaixI7NRYpDmKFT8yob42iX17ulrsH4GkG3EIrdprd6r9Ltu2z1cjFhzkU0z8x6NVjVTVMbEvBO5EOF9YO0mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513970; c=relaxed/simple;
	bh=E+XGsNj5AokmPM1PgTaVBZcD8WKFKbhr8obxekK97dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWpprxXTgKNEFvZ8BcNi2SymF+bPiKw4MxoE9SzVpSuafhsvJREzxa9WqAiQ/YFrs7LXVToQYdInvAch63bctAykRvwm4KtrwcVJTaJqFn2xHPbDHvA58eEYd6KfmvUd00lxJ3w1aoMoobteBtgNCzUOk4xNnHp4I/KLpw2i9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzT1Jnao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29409C19425;
	Thu, 30 Apr 2026 01:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777513969;
	bh=E+XGsNj5AokmPM1PgTaVBZcD8WKFKbhr8obxekK97dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KzT1JnaoI8cc+dEEE3ahak4pDxGs/pXaDk3qIWFCAYVireDkmlZeBXbU/aMGeBt1n
	 4egLx+wJvjVN0wVAb7wIlNl+UB05yZUKVa2SMNcnaOqoccTYJi3GZi6j0qvL0xo4d8
	 aUjU+AOlpLlv3g23cPCcEbH9hN/Y2YoziSjxZH+iQcR0n1GsV9jGaTYTkOG/qLMgB/
	 vyZbvts6OETvcrLnhumbkt4s1dwQbIp4d+KZ4w9It1UGQseUjX9FomKaDzroA3+025
	 FW4OB87EJFNHgj4oAq1OQThfu5cVKBgD5RozpPRRfPNMcHl5MuiNLUFzVn6SKcXTi0
	 hqvvg4aXbHpiQ==
Date: Wed, 29 Apr 2026 18:52:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manas <ghandatmanas@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 rakshitawasthi17@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_dualpi2: Add missing skb check
Message-ID: <20260429185248.4761905d@kernel.org>
In-Reply-To: <20260428145730.26375-1-ghandatmanas@gmail.com>
References: <20260428145730.26375-1-ghandatmanas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8873549C1C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282592-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 20:27:30 +0530 Manas wrote:
> A packed is dequeued using the function `dequeue_packet()` but there is
> no check to see if a packet is dequeued. The assignment is always
> considered as true resulting in null-ptr-deref
> 
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Reported-by: Manas <ghandatmanas@gmail.com>
> Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
> Signed-off-by: Manas <ghandatmanas@gmail.com>

Sorry but the patch is nonsensical. Please don't waste our time.

> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 241e6a46bd00..e360bf16d617 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -588,7 +588,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>  
>  	now = ktime_get_ns();
>  
> -	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
> +	while ((skb = dequeue_packet(sch, q, &credit_change, now)) && skb) {
>  		if (!q->drop_early && must_drop(sch, q, skb)) {
>  			drop_and_retry(q, skb, sch, QDISC_DROP_CONGESTED);
>  			continue;
-- 
pw-bot: cr

