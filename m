Return-Path: <netdev+bounces-305201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mrpgBpYLTGpbfQEAu9opvQ
	(envelope-from <netdev+bounces-305201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:09:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B1715504
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:09:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YRSK9Uam;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305201-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305201-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE84F30AF647
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5163CC310;
	Mon,  6 Jul 2026 18:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60553CC33C
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:58:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364291; cv=pass; b=vBdjIqeq+rAowmFYDFaAlJ6xlEsfNcU/QU/bm3UG1kBmTLqhozaLVfytgjzl9l5dH/4L1cxZuOnC/wOoy5+L0r3LR6Ab3sD7UxfMXl+ubPkbtWD9VDyHve9qzo3+6skdbuT5is79Koa1fb1jVgqyfEPeS4Tcg8v0G7j+IG37G8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364291; c=relaxed/simple;
	bh=aXiQ/mXNfv1WVBqcleueHbtZhUyR/lXb76+wTP1D3AI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FXTpPkWcz7YXcvemQv8sfGkCw0ZNx32BPf/sibOB4dsTDUwkPv+oSGNOZWfRiA3N55uZgu0QDhY6ldLy93dPiFyLRopav0otDqaMMxRkjWfw5VA+PFeNMzS2THD5f1MclWVZsWisx882mUagVsb/RkY7yYvT3N4HPb50QS/uP+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRSK9Uam; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7fe36f1be74so47153197b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 11:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783364289; cv=none;
        d=google.com; s=arc-20260327;
        b=WHxuEUxvaGxLP2BAV64Fp6iPfbRwBegAGKK5PrvD2dfLbosvb1j4bMpsTA5IwCr1ma
         o0g/SZST/qUhKis3RignoDYlDNZmq9NJmmtvZ/QbZXBIgIhAIiTckfDL7/kJE6SHMofg
         5M2VQv3G4585Joqq5snfnaKL3QkMv0eePfvjv0YksyU3qcHwknRrZej782cyvTuxhoqa
         FJAsuG/q1yHqYSi8iT0Zs0VvyXZRPbLGL4G4K6upFxP22nvKTUy4TE+6uewgwp3GtFrb
         UzFU+nDtbLLcWmPkzz7FtloFaoTZrnbwmB0PtNX7FojaIJS3nvTzpcD8k9D0JI5wzphI
         324g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BojKGwo+Yhn9RIq6DBw8lPoGESteaP9pLTm9CXIlISw=;
        fh=WYVcHDSCWQFGnjr1ljuDaWahFIJyvwF5dcklcYy9eoA=;
        b=UARork8qxIu7djW/PeuJ0Wb/EhKZpOfI5YXukQMaSeRkldT3PUQJBAQco78giDnvyR
         L1oE/9FJnGGaaJycDf3nsI4Luv3/PyeJYalG57mIZiTvYdW/DJ8hxauChPHaLRhhSX0P
         8b7qWAxkf95jmYC528qQ1ii7lU96W2PmDplpmxX+JHE+/H5XOTD+Byg1c+rcIIJWvbH+
         ROd1OxMpbN9cxkKDlWHGva4+DnlwwuYd7UNyyONcLHErlig7bpOmxD9APoArsPQXO/o1
         uH37Blqf1qYazEZCzGJDpu5/uiYaVANMlLNHdsT3VRAF31wWbLuYQLu/BVDDE6y4nUuf
         7zWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783364289; x=1783969089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BojKGwo+Yhn9RIq6DBw8lPoGESteaP9pLTm9CXIlISw=;
        b=YRSK9Uam92swVwUrtNZWkZ4kK/AGQfEKKGD7B8LHTF1tUHkW+wUdwZIcyPo3krKFsY
         G5goxo5XN9kQ7+O7SuPcolTa6NAGud75/Ih/KzggP172y/MyLLXzn4RokpPNUo0Wrj7+
         RGY9zj0M+YdJvh/E4XgPtF5sG6NDRX8lu2r/P7VdLcn1Idx6Q91cUvyM+agnVJZiQGNw
         fRsxcrEa6jHKVl7vLwzlWVoxRFtJoByGB2WAnOQQrWs2GoAEnC5Iu45j4EpgXCIB0NNQ
         OzyFU0j4FvKpufwzL2j2NFx7zZGgnTNDsOpcJFzQ02lnv+J14av6jYqTiauiupnhZFKJ
         Brvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364289; x=1783969089;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BojKGwo+Yhn9RIq6DBw8lPoGESteaP9pLTm9CXIlISw=;
        b=tXPU+kd9x4B6TKSmgxOqpILHq1jpUajOMezA1Wc5bjDVsKzEpZ/PRBB3SzVa3TWJs2
         Qlq6nEM0/IBOPwyOjt8qI5nGzd3wsO7z2/nS1KuwGSrTfzb9FDLsNfcww1xcFTSkB1hr
         wIhggnOJ0X18Cd6LYuMjwyE9m+8Z4lCwXB4PVAi4fqRGhLQzVrPg0LeWPgZRyK9JPGII
         r8oKUzVCyISzuCmS5zx/scNoOy9NpYSkELZkTaTGzbxzh5fswGLJvpLFZ8IswKwBEKw/
         IkJFp6Z2uNosZwKKvDd60OwcxftH2mxBu4cQ2BHMeUJzHdnZQWLLO92eEnnJAFj0nl8U
         lSAA==
X-Gm-Message-State: AOJu0YzglQb9l57QMGKYy+Ykr51S7CZ29/IP63gLeySy/fElNeB8Of88
	V8FuT0Vg0o3XffVK5GvaT+VhljpjCPXUHj7SLqOgQ5qYag9ZbyDSuX/lsKZRKbFBJF1z3NoZgif
	LW8o/P4ZUhhxWq/hqI54aEz5qlVBNORc=
X-Gm-Gg: AfdE7clacRSj0/h8yNYQFHROsGJ/j2iBdJpqFt3sZIIZOOxa5+6vMtVQrBEKkRyyKAU
	6TllZe7u4XSw3+ZrA470JuUoctO56a6rdWdWolyuLeMvYoWu+GOM7R3zzjYadGPcPQOhd7stZgp
	SY7tlw2POZ9kiOPKpnhSMu8T0Wt9rYKXgPuxakpbIGWfnBSJsZN7a3MzLjHEhdyt7cEZE81fvp1
	IrdIV+G+vvZGz8x8oG3mGIhs2aC+16Bg4AseNAnilN4a/HCTwU+JBrngkZn5u+nK1QNB9dL2tX5
	ygTgi/4H9RmmppP4lzxCv/xnewGrCc4=
X-Received: by 2002:a05:690c:6210:b0:80d:66b2:842 with SMTP id
 00721157ae682-81be3cc9337mr12675977b3.50.1783364288813; Mon, 06 Jul 2026
 11:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cen Zhang <blbllhy@gmail.com>
Date: Mon, 6 Jul 2026 14:57:57 -0400
X-Gm-Features: AVVi8Ce0JQyVqQ8UppwT6i6hWFbF39DQwG2g-D75zPagc6Ql_O6eTaYYGhL_v74
Message-ID: <CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com>
Subject: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU validation
To: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, 
	Cen Zhang <blbllhy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305201-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,microsoft.com,linux.microsoft.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 747B1715504

Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied MTU
values but only enforce a minimum bound, not a maximum. When a user sets
the MTU to a value exceeding U16_MAX (65535), it passes validation but
is silently truncated when assigned to u16 fields l->mtu and
l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
values (e.g. 65537-131071) produce small incorrect MTU values, resulting
in link malfunction behaviors.

Crash stack (triggered as unprivileged user):

  tipc_link_set_queue_limits  net/tipc/link.c:2531
  tipc_link_create            net/tipc/link.c:520
  tipc_node_check_dest        net/tipc/node.c:1279
  tipc_disc_rcv               net/tipc/discover.c:252
  tipc_rcv                    net/tipc/node.c:2129
  tipc_udp_recv               net/tipc/udp_media.c:392

Two independent paths lack the upper bound check:
1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)

Fix both by rejecting MTU values above U16_MAX.

Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/tipc/bearer.c    | 6 ++++++
 net/tipc/udp_media.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..0926692dd 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1163,6 +1163,12 @@ int __tipc_nl_bearer_set(struct sk_buff *skb,
struct genl_info *info)
                                               "MTU value is out-of-range");
                                return -EINVAL;
                        }
+                       if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) >
+                           U16_MAX) {
+                               NL_SET_ERR_MSG(info->extack,
+                                              "MTU value is out-of-range");
+                               return -EINVAL;
+                       }
                        b->mtu = nla_get_u32(props[TIPC_NLA_PROP_MTU]);
                        tipc_node_apply_property(net, b, TIPC_NLA_PROP_MTU);
 #endif
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc73..0d62a57c8 100644
--- a/net/tipc/udp_media.h
+++ b/net/tipc/udp_media.h
@@ -48,6 +48,11 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb,
struct netlink_callback *cb);
 /* check if configured MTU is too low for tipc headers */
 static inline bool tipc_udp_mtu_bad(u32 mtu)
 {
+       if (mtu > U16_MAX) {
+               pr_warn("MTU too large for tipc bearer\n");
+               return true;
+       }
+
        if (mtu >= (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +
            sizeof(struct udphdr)))
                return false;
--
2.43.0

