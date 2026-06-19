Return-Path: <netdev+bounces-300736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qe6pKN13NWqnxAYAu9opvQ
	(envelope-from <netdev+bounces-300736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBD6A73D4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=JV5cI6il;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300736-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA3603024548
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52893C13F9;
	Fri, 19 Jun 2026 17:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B73C10BA
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 17:09:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888981; cv=none; b=YRQkwI+60DY3Q/Ey3JtJaDoEAm5XRmhyhG0c6V3G0sT/nsr6eHtidGCIUQFBSCGZoiyRWUVAt8/i4pmPZ2+IzoEs7ZNg5185+ED+1THOXXcGQ3ohUfewNR3Q2tpg9Wiw+Uy17wMFXq/J8b4x4XLxw9AAo1KGU76Sx1/vCn3lS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888981; c=relaxed/simple;
	bh=5Cz8io4XwM9zbG2vzsMVHkkGxGSSG7G3Ylj1fihEjls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2G7QGe9BVytHzrwRG8Yg1+PiOKDA80fGIN3wnWAE6Wo4avYH98sXFEvFyl/G8R9OlXZbqxq5cdjdtPdFhweup/bxRvTFUZEAhPniqCnNjQnND6emQ2Z9pivGJdigWgAyhKX4jjE0+UfvQI8D9GN4goALBJzzsSlpOn3OMN9gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JV5cI6il; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso2644918a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781888979; x=1782493779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npcHSxG0m/aHLbt4AL5sRlKVlIL+7/LCZnpoUwYXLuY=;
        b=JV5cI6ilwTtO1mxVCXbwS6wH2NR8NPypgPkB+l4v+gPyyjP2z65jBAFz4tXCQ3GutO
         oe923h7yZL0b4bTre7grWbNgPV2KMhpsmt3aLGDdQHkbISkCksmGADKq0WMGIlgTWAYR
         3IJ1oK+BwclohU6X2kv4i6GftD9Ta7sYPn7yHC+06fl3htByAAOTFfRunnGDB0vY27Vr
         PX619WRzoN8RWOTzCEyaLkoDASj9sTf3hcREE69HYOnKBkc3sUsJybCtAN+wbBd8nOql
         J8IDp/BGXNWEnvZPoMloKj0jD/TEffvmcn5+DAzJpkLGL7a2tWkC29ACOMT5vK0gY7f1
         vIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888979; x=1782493779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npcHSxG0m/aHLbt4AL5sRlKVlIL+7/LCZnpoUwYXLuY=;
        b=Wycbr2jkETo8pKulQTPTlr1SpSUG+VeyX3qBGWhbODxtkhPRz6duBaF5BtYjzcGx2C
         IsqZ+g0TSb3UX04HT3ztei4AQxRCZR9Bqu8AE/w5dxT3szsVD6nmLcrtnE+ANTvdZEbt
         0HajORKuw1Bk8/HLdEkP2BC4jJG02TecQN4jEKoOHiv42xiRN3Oeog0AOrq9mCOpfy1B
         12MburB4nxnTVZIx0QvQeZTgwb/FNiHJxMttlUBIk8iT8X4Sd6wp/Ueq+ldV7pZEuj50
         MNKddIrA697lwmtRfSnHSG9lfT2t1/tvLfI88Bzd8DEhIdX+/HniC44bchez5V6ZnyMN
         8O3Q==
X-Gm-Message-State: AOJu0YzyCHLfttdsGEjsKTj0fEf/TMReFbd1PXTTFzMfzbEEXZaP7uh8
	GtbHRHp0RMpYblvVPV405cnzpheXTHKAEf7UI2jKYjqaT4cFpHxE94XPP23ss6kqlf4=
X-Gm-Gg: AfdE7cmVcg0jZ3up9/ABhLDA2CCxm4EDQWiPq27Ko3uvFoeUbCyN5tH4jLeIlj/IAxv
	e6un9gidzB8ecIBHzoCZRTci9OqVq3Amd6jDB4ejHZJ27Kmj7JX9Fl00Xjv2D8eOfHa8gBogF2T
	gQLujkLBDBGeKyEBVP2z/ysDA00pto5KxcsMcihbP5P4xmvxLUdbpYbN2PShjC9n6lfwC7UYxFS
	EyLpeLr3t4a/XtzJJ2lB1HctarD82WBoAG8oyU5nu9QwCoV1LZ2SJIQJagsE08iQIKloMiGGGIB
	xG45+zyKZLirf/hTHjduulVqz2vTSPChrbNhZKmJsErGtVi9h/NumLYiWov1U159FV5NvFBdtLM
	556qgMMEb7WYnN/JaJfs32PO72EkjugtZNdyGHOoWguIFPFI0VpGPjXZsLsj60jd+uXAHg5cU2i
	gv3+0ntFyb/41z4ueS4ymGChXxY3dp94XnxXBHS4Necn2PC2IT5UfU9zhv5M8=
X-Received: by 2002:a05:6402:5186:b0:697:649e:98a4 with SMTP id 4fb4d7f45d1cf-697649e9ac1mr1212285a12.13.1781888978862;
        Fri, 19 Jun 2026 10:09:38 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-696edc880b6sm1057088a12.7.2026.06.19.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:09:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 19 Jun 2026 19:09:28 +0200
Subject: [PATCH net v3 1/2] net: lwtunnel: Drop skb metadata before LWT
 encapsulation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-bpf-lwt-drop-skb-metadata-v3-1-71d6a33ab76b@cloudflare.com>
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
In-Reply-To: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300736-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:martin.lau@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CFBD6A73D4

skb metadata is meant for passing information between XDP and TC. It lives
in the skb headroom, immediately before skb->data. LWT programs cannot
access the __sk_buff->data_meta pseudo-pointer to metadata.

However, LWT encapsulation prepends outer headers, moving skb->data back
over the headroom where the metadata sits. On an RX-originated (forwarded)
packet that still carries XDP metadata this goes wrong in two different
ways, depending on the encap type:

1. Non-BPF LWT encaps (mpls, seg6, ioam6 ...) call skb_push()/skb_pull()
   and silently overwrite the metadata that sits in the headroom.

2) BPF LWT xmit calls bpf_skb_change_head(), which uses skb_data_move().
   That helper expects metadata immediately before skb->data. But since
   the IP output path runs LWT xmit before neighbour output has built
   the outgoing L2 header, for forwarded packets skb->data points at the
   L3 header while skb_mac_header() still points at the old L2 header.
   skb_data_move() sees metadata ending at skb_mac_header(), not before
   skb->data, warns and clears metadata:

  WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
  CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
  RIP: 0010:skb_data_move+0x47/0x90
  Call Trace:
   <IRQ>
   bpf_skb_change_head+0xe6/0x1a0
   bpf_prog_...+0x213/0x2e3
   run_lwt_bpf.isra.0+0x1d3/0x360
   bpf_xmit+0x46/0xe0
   lwtunnel_xmit+0xa1/0xf0
   ip_finish_output2+0x1e7/0x5e0
   ip_output+0x63/0x100
   __netif_receive_skb_one_core+0x85/0xa0
   process_backlog+0x9c/0x150
   __napi_poll+0x2b/0x190
   net_rx_action+0x40b/0x7f0
   handle_softirqs+0xd2/0x270
   do_softirq+0x3f/0x60
   </IRQ>

That is what happens, as for how to fix it - a received packet that
carries metadata can reach an encap through any of the three LWT
redirect modes:

  LWTUNNEL_STATE_INPUT_REDIRECT
   ip6_rcv_finish
     dst_input
       lwtunnel_input

  LWTUNNEL_STATE_OUTPUT_REDIRECT
   ip6_rcv_finish
     dst_input
       ip6_forward
         ip6_forward_finish
           dst_output
             lwtunnel_output

  LWTUNNEL_STATE_XMIT_REDIRECT
   ip6_rcv_finish
     dst_input
       ip6_forward
         ip6_forward_finish
           dst_output
             ip6_output
               ip6_finish_output
                 ip6_finish_output2
                   lwtunnel_xmit

Every encap funnels through the three LWT dispatch helpers, so drop the
metadata there, right before handing the skb to the encap op. This
single chokepoint covers all encap types and all three redirect modes:

  - lwtunnel_input():  seg6, rpl, ila, seg6_local
  - lwtunnel_output(): ioam6
  - lwtunnel_xmit():   mpls, LWT BPF xmit

Alternatively, we could clear the metadata right after TC ingress hook.
That would require a compromise, however. Metadata would become
inaccessible from TC egress (in setups where it actually reaches the
hook it tact, that is without any L2 tunnels on path).

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/lwtunnel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index f9d76d85d04f..b01a395d9a96 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -350,6 +350,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->output)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
 		dev_xmit_recursion_dec();
@@ -404,6 +406,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->xmit)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
 		dev_xmit_recursion_dec();
@@ -455,6 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->input)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
 		dev_xmit_recursion_dec();

-- 
2.43.0


