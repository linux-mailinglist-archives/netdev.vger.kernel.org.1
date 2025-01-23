Return-Path: <netdev+bounces-160602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25EA1A7BE
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF9188C81E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BC212FAC;
	Thu, 23 Jan 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PV4lO1nJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVh6BE4J"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC10212F97
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649250; cv=none; b=I52dPBvNGoCmza/DKppzKPlscXPjsA4kgvx9sllAQU1yd/n9BB4gIhvmmCAfnM/QR0CCs3U0/XfAN9lW21dh1vNpe9JoMajezBq1YWkL3DqCKCOTepm+Mj3VDf1j1pRo4iATfLNiMQsvMYr/bq8/UUDpyMKXU/hScgSE4/ZCK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649250; c=relaxed/simple;
	bh=eL97M0gp/qs3PRs22VlP6z8k2az9AuVwx4v9DARnu8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM2d0CpVtvw+8DtK20721DR9WpPc/dCiuM8WmXAk54sbaTMxz2IxnKzMRUkdI900pO4/Lusn03wQ40S5kaXWuAYY0zDy5wa26v68B+MVi+lOQo/4MpbLeuUvIQlL1TpYhknd7Isbm55pOZwEGAn3QTFZYmkt9sI/oQ/GKewphHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PV4lO1nJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVh6BE4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 17:20:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737649246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hi+Td9IjXeaFr3rXP/8iHYMvxQDjM44Q0Iq0unBoQD0=;
	b=PV4lO1nJArORACaCc5a3GrTFsaOhRwyz/yLzvTxxsbTXmQ0W3GIgW7MsV8CwDdEWyJ4xNF
	AwaVgVd0VNRCgEGrcUHBW3rC4d5iiYvJvLD4G9otCm7b14UwNREhkazJzQMjB2rAKwbgn2
	SQ1NWbIcYbwp9SHisGZDkusZTMlZRJiDSiis4qkxwJDicr2y44w8KNkwwavMymrhXBJMR1
	LOWGQeuTutZOMb/5a2fH2AAF35z6SbTQknP1EmihUToHCNxHnlI64R4ytOGqQLm3n5ChzT
	TdGUflsjHmojbkw3kJKGWEZWn6hlc8QQ6dQPanxcDoczvsYAT55IlmHVUpOFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737649246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hi+Td9IjXeaFr3rXP/8iHYMvxQDjM44Q0Iq0unBoQD0=;
	b=vVh6BE4JhPa8DNfjsmFEQtyRiu/LMSAkMd1Gu4WQXpkjX5mCYTkCoMqNfkAHA6sMdT/dlq
	LvqJTWb1WYXiNUCQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Network Development <netdev@vger.kernel.org>
Subject: [PATCH net] xfrm: Don't disable preemption while looking up cache
 state.
Message-ID: <20250123162045.INxxt33y@linutronix.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
 <20241218154426.E4hsgTfF@linutronix.de>
 <Z4oOldW33zFbYQ6/@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4oOldW33zFbYQ6/@gauss3.secunet.de>

For the state cache lookup xfrm_input_state_lookup() first disables
preemption, to remain on the CPU and then retrieves a per-CPU pointer.
Within the preempt-disable section it also acquires
netns_xfrm::xfrm_state_lock, a spinlock_t. This lock must not be
acquired with explicit disabled preemption (such as by get_cpu())
because this lock becomes a sleeping lock on PREEMPT_RT.

To remain on the same CPU is just an optimisation for the CPU local
lookup. The actual modification of the per-CPU variable happens with
netns_xfrm::xfrm_state_lock acquired.

Remove get_cpu() and use the state_cache_input on the current CPU.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/all/CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com/
Fixes: 81a331a0e72dd ("xfrm: Add an inbound percpu state cache.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/xfrm/xfrm_state.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 67ca7ac955a37..66b108a5b87d4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1116,9 +1116,8 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 {
 	struct hlist_head *state_cache_input;
 	struct xfrm_state *x = NULL;
-	int cpu = get_cpu();
 
-	state_cache_input =  per_cpu_ptr(net->xfrm.state_cache_input, cpu);
+	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
@@ -1150,7 +1149,6 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 
 out:
 	rcu_read_unlock();
-	put_cpu();
 	return x;
 }
 EXPORT_SYMBOL(xfrm_input_state_lookup);
-- 
2.47.2


