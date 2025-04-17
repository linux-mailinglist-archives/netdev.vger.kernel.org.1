Return-Path: <netdev+bounces-183666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D54A9174D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4711904568
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6720219A75;
	Thu, 17 Apr 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3UFEoHpe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfERbxsb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494A320F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880895; cv=none; b=RFxbLf+UqRFric/bzMqbsT+ZYQ/HSV8UYYxRvVdnedLAA2RFfRxxENIZVFOOzx14asjiOVWM7rhy1RfAVqWmQ3Nf1klJ1k41NvGSCZDWZS/ihTQ6lJbzFLIBo65P/Gjg6AFzX/KTOvB7s9L4vEkv5zlmBL3jhMETEZD6/ZKeAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880895; c=relaxed/simple;
	bh=gAdm6E8emYUWFEsHp/Xl7FFTU6Pi048XggtN6Z97bY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHn0SwWlRGqJshDOLHwQTwk1e4xl/hZNHvONtASyXK2HpvCHsxted2L8LMnfBSzK1RON/sWaebk7kaHt2pdLZcPOJmksXYKb356vEV7eTakbH/I79dm9p2iVyOM1tiWCvYwc7NmE7LzaQwSwFrrFRQGUf9oUEQ0ZqyKVdpLhBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3UFEoHpe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfERbxsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 11:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744880891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH+wxhsjZ2ATwN7/Y3o+pB9OFZzUKz25HqEzdFZJ9Ow=;
	b=3UFEoHpeQUAC1xXgt8tBY+6GJqsdTGP0UP605yUyPsdYAz+ufN1jhwSYizlkQx6Vbs/jjW
	WbNYfOH8GrN+z+xMzICDU0Fg+pWihuSv+S/SrTYkf2kCMYUun8YCYd5wGWvHRCxmYHsN02
	7qvvPPRepnpQsokarHB7pgb7wAG0B6+QBzaoUuV1pDm5RZ4MjYW2aiBtLRR5Muq7xUoKOp
	PqNoHt9tm2ADIBPBexmmziWRY7SA6PQaNDEKzl8zndysfI7xGiRO4UpamRHYK192GISMWE
	1teS2yHrTmMK96iJ2XRjc9oXphajb9PNlvnfJYo928SY/2NwjcUDyH3qO7OeuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744880891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH+wxhsjZ2ATwN7/Y3o+pB9OFZzUKz25HqEzdFZJ9Ow=;
	b=TfERbxsb/mSULigG8/dp4M4Yjk/zv4QCQnmq11bwworu22Z2nDQSqVn/cpipiD6HMQ7byu
	t9vPcBaV07PUoNAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
Message-ID: <20250417090810.ps1WZHQQ@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de>
 <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
 <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>

On 2025-04-17 10:01:17 [+0200], Paolo Abeni wrote:
> @Sebastian: I think the 'owner' assignment could be optimized out at
> compile time for non RT build - will likely not matter for performances,
> but I think it will be 'nicer', could you please update the patches to
> do that?

If we don't assign the `owner' then we can't use the lock even on !RT
because lockdep should complain. What about this then:

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index a3989d450a67f..b8f766978466d 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -294,8 +294,11 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	sf_acts = rcu_dereference(flow->sf_acts);
 	/* This path can be invoked recursively: Use the current task to
 	 * identify recursive invocation - the lock must be acquired only once.
+	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
+	 * Limit the provecc to RT to avoid assigning `owner' if it can be
+	 * avoided.
 	 */
-	if (ovs_pcpu->owner != current) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
 		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
 		ovs_pcpu->owner = current;
 		ovs_pcpu_locked = true;
@@ -687,9 +690,11 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 
 	local_bh_disable();
 	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
-	this_cpu_write(ovs_pcpu_storage.owner, current);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_write(ovs_pcpu_storage.owner, current);
 	err = ovs_execute_actions(dp, packet, sf_acts, &flow->key);
-	this_cpu_write(ovs_pcpu_storage.owner, NULL);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_write(ovs_pcpu_storage.owner, NULL);
 	local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
 	local_bh_enable();
 	rcu_read_unlock();

> Thanks!
> 
> Paolo

Sebastian

