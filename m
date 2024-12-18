Return-Path: <netdev+bounces-153046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBCB9F6A4B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D9018913EB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DE139579;
	Wed, 18 Dec 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txggNGRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/5E6T6Y4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CF35948
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536671; cv=none; b=IKwJrKtnBMM1yfnALc0pnyrczZkwfXwn0iNoYFWv2xzu2kfr8jrxvv0xZUTPKiMlPS3w2UFzWQlI4hm9vLps6QdWz2KhqKyIREJe6xjhrCfVgc9Z84ycCfBv9N5z4660ODaVaFo7956j/SZmiubO3l2b41aoQdh1gjSk10Mze7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536671; c=relaxed/simple;
	bh=KgEeepq+W3vD6EJTyqHiraa7AFQoLq5qkkIZhov67LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSvlgqWmtb4TWXcyAj83f3zuFx5+z1MKRPRpaXZGyT46IOYv8mEtsoyzTuDED3kJi1UnmEV6BdYmZwVBqoGVMX32ot2oOgZQLMQU1eyG8gYXCnbno7rnsK6NwNg8A6y/wqX3e1aqL9azbgc2VxRc6sey7Q1OjyhjkEmCNCtXm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txggNGRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/5E6T6Y4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 16:44:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734536667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nR7fBvMXjBK/VlWLsVgbSOjV8bUEdz2JlJG7o8gMGAY=;
	b=txggNGRi49Cl40obYwF9QUyrfPaAg7f/sr1YAoH3Z5xqGfejIw0tQzWJ9PfbcCmOOSh4sD
	wR0mY/aTSct8LcRyqxFqll4g/nZ6rCUSpHXLQHPR7okFQdC/kzmsdfNJM4AV/sp/uIfP0z
	m5Do3wk2Kwts8N3/cM3/mdE/b8xUiLIkAcoSqyBFQfmq6NPKJEP2MCuk9qYxUoO1ufN0Ya
	Ep6Hv2eateq2P9v2shFNVO9joOkkeYReZ4SXj0by5rOyH5WSIxQmUeU3k8JbgF/YyHpG3R
	1Hzytn0frPxahdzmXLM14CwSF807Mfmhih36q3WBBnV4q+pDxaVFXwyq/H+Pzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734536667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nR7fBvMXjBK/VlWLsVgbSOjV8bUEdz2JlJG7o8gMGAY=;
	b=/5E6T6Y4ci3GqUAGo99LSzaRewbtDKfcXv27VHWPgKo6Q7puavrm8Ug7dlawUg940lO32c
	rTaNKpCgBuuMM/Bw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: xfrm in RT
Message-ID: <20241218154426.E4hsgTfF@linutronix.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2KImhGE2TfpgG4E@gauss3.secunet.de>

On 2024-12-18 09:32:26 [+0100], Steffen Klassert wrote:
> On Tue, Dec 17, 2024 at 04:07:16PM -0800, Alexei Starovoitov wrote:
> > Hi,
> > 
> > Looks like xfrm isn't friendly to PREEMPT_RT.
Thank you for the report.

> > xfrm_input_state_lookup() is doing:
> > 
> > int cpu = get_cpu();
> > ...
> > spin_lock_bh(&net->xfrm.xfrm_state_lock);
> 
> We just need the cpu as a lookup key, no need to
> hold on the cpu. So we just can do put_cpu()
> directly after we fetched the value.

I would assume that the espX_gro_receive() caller is within NAPI. Can't
tell what xfrm_input() is.
However if you don't care about staying on the current CPU for the whole
time (your current get_cpu() -> put_cpu() span) you could do something
like

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

> I'll fix that,

Thank you.

> thanks!

Sebastian

