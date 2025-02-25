Return-Path: <netdev+bounces-169601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F3A44B56
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EAF7A300D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3431A727D;
	Tue, 25 Feb 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="C2wGlaBv"
X-Original-To: netdev@vger.kernel.org
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6F1A01BF
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511797; cv=pass; b=VB4VDrqrzlgB/nItcMiTJOGPAbo3F9ioWpTWPzGmvcoGZH2+GBHM7IXvGC7T36t0uEzL2oVtS1rQOptTotcxOfx3dX6E51kaMHzOdna78WrvMzi1ytFJDG2114TjRFROHBpbn3+1MOKIC0EzVoDi5lCmlb0iAplJGRX2RxLmpgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511797; c=relaxed/simple;
	bh=uHTS0aZeHVMDl8x05huiq327tgmC1LkZ5GiAaKT5TAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8c8gek3cF7iI4aoPybVzkO6ZLn+eXxYbCbo2vJV6Ej/3pVCL0p34q0eFxb486zsWUeJpU7YQicjvoNofVH/Qk+ole08mhQNpXTMA8QA11ex5wL7Hcc8qJ2z+aOylrVd8id0qj3og5jNANHmNupfJIKCOSqAau9PiOgRviHNvx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=C2wGlaBv; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3FF832C1C26
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 19:29:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.101.208.230])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E2B462C2095
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 19:29:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740511787; a=rsa-sha256;
	cv=none;
	b=C2X5183EXWY9LI6G0dAYout2ShPOoGKqS4yUfsrWjo3qbNjXB5tCd6tzzIgrrV70cI92MK
	C5dr1B61gbwLis+69yCCL1W32XWL4r1dccXU+/CWKm1RtjRssabjnfFyLxIfJRTGUSHI8R
	Gzato7saMG0PvWemJy512QHRBkFdsE74hq03LmFySFvaaAhIyaZXnc6/kWKrT5+jh0DYw+
	LSgc0Olc2Z+CdmdTDYBq/tJal8euHRiPSKPSs8+ZSsHd+Y8vD18O0PC+nqC8iDwB7ZtYW3
	bJlnlLw4ChwvEVQz3Y/88jT2qLwU2bsBJTxSggigoV7W1xqiEnVos3jRykq9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740511787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dNsJeVWnpdB2ZrkwHUjnKpeY/O9YgmbYD69phFHtX2Q=;
	b=NfBfalIoFoq/SW4p+h6xc57lGh2eVIxY80pg0eYwyIYiqpSzpKFDvwQTZB0jzZFnaoZTWo
	Y4qO/5fRPh+qW3G+rhWxiDhPf1BBbVVrhJa1TdG+3xSzTagAhesGfMqJn7+2hUDS8sA/j0
	9I1GawwNmFU59kdMw6wTpdkUVfcroCfHM7cGo+EVayIomU62LmP+XQ3HM6rDopeksgJI4U
	6Y8wzlvTPmJef68uHJ6mndA+p+57m+UvGPL3uAqXumo4QhIOE2+mdXNzpTVi0I8hjq5aUR
	cgvxdvpAFu6SaI0OXRAvnYRRv76/sOqZFSlHQfFRM4xMZts4CJ2IpQj1E9oVGw==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-hjk8c;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Hook-Wide-Eyed: 30881a631b34fbf0_1740511788125_3503079243
X-MC-Loop-Signature: 1740511788125:1074514555
X-MC-Ingress-Time: 1740511788125
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.208.230 (trex/7.0.2);
	Tue, 25 Feb 2025 19:29:48 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4Z2SNW2mLBzZx
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1740511787;
	bh=dNsJeVWnpdB2ZrkwHUjnKpeY/O9YgmbYD69phFHtX2Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=C2wGlaBvyY/TMgKdjPBG9d08Y2S1Tf+Xy02GPV+KX4zCAjbzqS1OdjrQZidTxWVYy
	 0ZxAnslhLDhdYIlGhX+Ieix/fLRdoOcezf+HakmupsrMzx+jRUKsu5PQS08EUfE2qn
	 6E3VVRCbbacoMTmaXLVAVdAwWfbI+bwpNKtIvyEsZLLsp/CuTgkJH9QGanEYilFM2A
	 3LlsWIIEFukRuaFzjYPwA8zXWGdi+BsnaNp07nh8OP9FzKHKi6VjACjgWqtq1jpiLq
	 fZEYqm9FwEC4t9jGvjZaPomw9fm47g/B4xz1j0PIttd0FOgk5OOUPMQSrWMBUtCfcN
	 X1QdFGOEZS52g==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00d7
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 25 Feb 2025 11:29:46 -0800
Date: Tue, 25 Feb 2025 11:29:46 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <20250225192946.GA1867@templeofstupid.com>
References: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
 <20250224232012.GA7359@templeofstupid.com>
 <e8039b96-1765-4464-b534-d6d1385b46eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8039b96-1765-4464-b534-d6d1385b46eb@kernel.org>

Hi Matt,
Thanks for the review!

On Tue, Feb 25, 2025 at 06:52:45PM +0100, Matthieu Baerts wrote:
> On 25/02/2025 00:20, Krister Johansen wrote:
> > If multiple connection requests attempt to create an implicit mptcp
> > endpoint in parallel, more than one caller may end up in
> > mptcp_pm_nl_append_new_local_addr because none found the address in
> > local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
> > case, the concurrent new_local_addr calls may delete the address entry
> > created by the previous caller.  These deletes use synchronize_rcu, but
> > this is not permitted in some of the contexts where this function may be
> > called.  During packet recv, the caller may be in a rcu read critical
> > section and have preemption disabled.
> 
> Thank you for this patch, and for having taken the time to analyse the
> issue!
> 
> > An example stack:
> > 
> >    BUG: scheduling while atomic: swapper/2/0/0x00000302
> > 
> >    Call Trace:
> >    <IRQ>
> >    dump_stack_lvl+0x76/0xa0
> >    dump_stack+0x10/0x20
> >    __schedule_bug+0x64/0x80
> >    schedule_debug.constprop.0+0xdb/0x130
> >    __schedule+0x69/0x6a0
> >    schedule+0x33/0x110
> >    schedule_timeout+0x157/0x170
> >    wait_for_completion+0x88/0x150
> >    __wait_rcu_gp+0x150/0x160
> >    synchronize_rcu+0x12d/0x140
> >    mptcp_pm_nl_append_new_local_addr+0x1bd/0x280
> >    mptcp_pm_nl_get_local_id+0x121/0x160
> >    mptcp_pm_get_local_id+0x9d/0xe0
> >    subflow_check_req+0x1a8/0x460
> >    subflow_v4_route_req+0xb5/0x110
> >    tcp_conn_request+0x3a4/0xd00
> >    subflow_v4_conn_request+0x42/0xa0
> >    tcp_rcv_state_process+0x1e3/0x7e0
> >    tcp_v4_do_rcv+0xd3/0x2a0
> >    tcp_v4_rcv+0xbb8/0xbf0
> >    ip_protocol_deliver_rcu+0x3c/0x210
> >    ip_local_deliver_finish+0x77/0xa0
> >    ip_local_deliver+0x6e/0x120
> >    ip_sublist_rcv_finish+0x6f/0x80
> >    ip_sublist_rcv+0x178/0x230
> >    ip_list_rcv+0x102/0x140
> >    __netif_receive_skb_list_core+0x22d/0x250
> >    netif_receive_skb_list_internal+0x1a3/0x2d0
> >    napi_complete_done+0x74/0x1c0
> >    igb_poll+0x6c/0xe0 [igb]
> >    __napi_poll+0x30/0x200
> >    net_rx_action+0x181/0x2e0
> >    handle_softirqs+0xd8/0x340
> >    __irq_exit_rcu+0xd9/0x100
> >    irq_exit_rcu+0xe/0x20
> >    common_interrupt+0xa4/0xb0
> >    </IRQ>
> Detail: if possible, next time, do not hesitate to resolve the
> addresses, e.g. using: ./scripts/decode_stacktrace.sh

My apologies for the oversight here.  This is the decoded version of the
stack:

   Call Trace:
   <IRQ>
   dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
   dump_stack (lib/dump_stack.c:124)
   __schedule_bug (kernel/sched/core.c:5943)
   schedule_debug.constprop.0 (arch/x86/include/asm/preempt.h:33 kernel/sched/core.c:5970)
   __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:29 kernel/sched/core.c:6621)
   schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6804 kernel/sched/core.c:6818)
   schedule_timeout (kernel/time/timer.c:2160)
   wait_for_completion (kernel/sched/completion.c:96 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:148)
   __wait_rcu_gp (include/linux/rcupdate.h:311 kernel/rcu/update.c:444)
   synchronize_rcu (kernel/rcu/tree.c:3609)
   mptcp_pm_nl_append_new_local_addr (net/mptcp/pm_netlink.c:966 net/mptcp/pm_netlink.c:1061)
   mptcp_pm_nl_get_local_id (net/mptcp/pm_netlink.c:1164)
   mptcp_pm_get_local_id (net/mptcp/pm.c:420)
   subflow_check_req (net/mptcp/subflow.c:98 net/mptcp/subflow.c:213)
   subflow_v4_route_req (net/mptcp/subflow.c:305)
   tcp_conn_request (net/ipv4/tcp_input.c:7216)
   subflow_v4_conn_request (net/mptcp/subflow.c:651)
   tcp_rcv_state_process (net/ipv4/tcp_input.c:6709)
   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1934)
   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2334)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discriminator 1))
   ip_local_deliver_finish (include/linux/rcupdate.h:813 net/ipv4/ip_input.c:234)
   ip_local_deliver (include/linux/netfilter.h:314 include/linux/netfilter.h:308 net/ipv4/ip_input.c:254)
   ip_sublist_rcv_finish (include/net/dst.h:461 net/ipv4/ip_input.c:580)
   ip_sublist_rcv (net/ipv4/ip_input.c:640)
   ip_list_rcv (net/ipv4/ip_input.c:675)
   __netif_receive_skb_list_core (net/core/dev.c:5583 net/core/dev.c:5631)
   netif_receive_skb_list_internal (net/core/dev.c:5685 net/core/dev.c:5774)
   napi_complete_done (include/linux/list.h:37 include/net/gro.h:449 include/net/gro.h:444 net/core/dev.c:6114)
   igb_poll (drivers/net/ethernet/intel/igb/igb_main.c:8244) igb
   __napi_poll (net/core/dev.c:6582)
   net_rx_action (net/core/dev.c:6653 net/core/dev.c:6787)
   handle_softirqs (kernel/softirq.c:553)
   __irq_exit_rcu (kernel/softirq.c:588 kernel/softirq.c:427 kernel/softirq.c:636)
   irq_exit_rcu (kernel/softirq.c:651)
   common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
   </IRQ>

> > This problem seems particularly prevalent if the user advertises an
> > endpoint that has a different external vs internal address.  In the case
> > where the external address is advertised and multiple connections
> > already exist, multiple subflow SYNs arrive in parallel which tends to
> > trigger the race during creation of the first local_addr_list entries
> > which have the internal address instead.
> > 
> > Fix by skipping the replacement of an existing implicit local address if
> > called via mptcp_pm_nl_get_local_id.
> The v2 looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I'm going to apply it in our MPTCP tree, but this patch can also be
> directly applied in the net tree directly, not to delay it by one week
> if preferred. If not, I can re-send it later on.

Thanks, I'd be happy to send it to net directly now that it has your
blessing.  Would you like me to modify the call trace in the commit
message to match the decoded one that I included above before I send it
to net?

Thanks,

-K

