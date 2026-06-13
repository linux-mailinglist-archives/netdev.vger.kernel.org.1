Return-Path: <netdev+bounces-299018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nMOcIdSiLWpgiAQAu9opvQ
	(envelope-from <netdev+bounces-299018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F667F516
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=DZlPyhiR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299018-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299018-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549E93043F8A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC762388E72;
	Sat, 13 Jun 2026 18:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DA33F377
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375677; cv=none; b=Ko1HJk9IzAYdE1DTCVlMO6wIqlnxZ7k91NdmhnZpOvvPEX5F0U5qLq4Mb8iAZHOiE41kFgBC/XqCsHxBkJY0jM2YbLATKSdGV3SraDdxVAac0+gRzLcD9Jt0HBdi908VDV7wPi+inAZMA+xRyJW2k5wb+ONdJgBmuNuZJEoYhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375677; c=relaxed/simple;
	bh=4XBejezJwJUWg3ebsSGgxMlB7tycHo/ivdoQZ42t6Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtf7eftnBHG+LRyYYAy5rwRxW88P76o6jwe8EOyh5JLaY+XLMwhOEj9UGawMREaSW7yJfXuJmiBEm04+1lTUtIVnmnrKtOTp6yXLMwkrC6aa3gi/xgiGrVbzZfesGLQX03uHJhEOwjV253hhiClkNl/lr8JifiKSf0qme6ws/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=DZlPyhiR; arc=none smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137dd3b29d5so126162c88.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375675; x=1781980475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k/pxlb3nzhZvX5D10rXnPFy/NJtoITQ+9ZSRRvEAWA=;
        b=DZlPyhiRC9wivcDlTa32yBMRUH9EnJ/h432dzAdwb9wAyrDiDTGVyr7/reQkf0ltNm
         llFyHseB+QtaSNTLVqisZ1hnAF/TBtLlqve5J/bHeWwwpz2/emawsm494BjUJr1KfByP
         Q4/QgQFCe0OHGtVd7a80fUqUcPl6Ab8Fc3pfF05Dbg5aiLkkv0QX08psZYRrTUillGjr
         4pRdTje1oItsCjxh3/Lxry46S+ViXoOxZeuxIPrDTLfeV1jDfQ6BdCJR+F3yOXywX4Zt
         XXdF6uvruJBA1VaO5hUN+quROzrTQNnslPpWvdCrXnPsR0NPK6u2exoIp6IuWy/oyKAF
         Yc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375675; x=1781980475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9k/pxlb3nzhZvX5D10rXnPFy/NJtoITQ+9ZSRRvEAWA=;
        b=pPm7fi7+SHjsqjQ/9vy5doGxv5JADxXi4CS9prgNOAutrR14SaejmNk8KrNFSn1EpQ
         k1wzE90mUJA/hdpxEVBBkZL7FB+nAn2KbpOiUWvV9NjtKFSypM4Zo0SAiJeq7giVNypg
         igfOc1LAAAWQySSuVE5trpymtQ04IXxyrGxAYD9OYuraaML/dDi5Zmz1C1eeEBhM5gWj
         foS+LPqOs/3k9xJqwSaQPQLMa1uXjwiQqj7+M2MMNhE/fc9HfjM9Jx1my2YyszK2tilK
         SNwoEDZIptjfdGd5EU155JnFOcRYw5Odrzy3tWNGGm6g6IPI2xbs2UGGdsc53aLgzUVG
         PRQA==
X-Forwarded-Encrypted: i=1; AFNElJ9uNpZZBL7UbhYTw3QvTFvoQC7yBKolbyqFbEAmC4HIxUNxSQnEp9cV1dpH+35V5Uput4/JsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1Vxc9JkrosDIzTx+3uIBLGiAc/C6ZhKkZoTZH9L829WFtXgL
	Msc0ldo6vH99MDm6RU9RLndY0izwQFIa9QCG53smWNCFe8zQUacubh4UNF8h32KWULo=
X-Gm-Gg: Acq92OGhha5GmNkqXd3HHPvbqhckJvsl546WsQIl5a7xJeCmCK8o1xF7RkumoLjbpGU
	jr7zFQcunpj7+GzOxGyfIzYAwsyKzJYngeJz6mDPUHeh565wo0IjOKh1biktkbwAZ+yDxJ1crA1
	Ac2NCJediKRwQHSBj/1E8rVe9wuLZvSLj2apGUlYfr/WDJULKSyjGtiuOhHvx1bSS/9T9KJmRX4
	CggMc6E4kHM5FA4dk16AHAyoCMloe25Xafl1omsJFsKflt8kfNCZGJdXWB6Lr3ii5zhKTqn2lU6
	GHHPdeiBxBh8YZln9SlzSjTyDyXr9Bv6qrMfhMu7OKPwrrV3eFrMnhCtm8fjT+TwWRd3SZckfjR
	p0e5tibnIvTMvxZqJjQaejE207ExZZo0sFdkTtKevd1JB6gdley3P/nKrFdjRXWbQFaQQ5OUl5B
	5Yehkm297o/OI=
X-Received: by 2002:a05:7300:7495:b0:304:c73b:79fd with SMTP id 5a478bee46e88-308200b9c28mr1937100eec.5.1781375675021;
        Sat, 13 Jun 2026 11:34:35 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:34 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_INGRESS with bpf_redirect_peer
Date: Sat, 13 Jun 2026 11:34:05 -0700
Message-ID: <20260613183424.1198073-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-299018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[jrife.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jrife-io.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 294F667F516

We have several use cases where a pod injects traffic into the datapath
of another so that the traffic appears to have originated from that
pod. One such use case is a synthetic flow generator which injects
synthetic traffic into a pod's datapath to enable dynamic probing and
debugging. Another is a transparent proxy where connections originating
from one pod are redirected towards another which proxies that
connection. The new connection is bound to the IP of the original pod
using IP_TRANSPARENT and its traffic is injected into that pod's
datapath and handled as if it had originated there. This can be used for
mTLS, etc.

We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
flow generator, etc. towards the target pod, ensuring that eBPF programs
that are meant to intercept traffic leaving that pod are executed.
However, this doesn't work with netkit.

With netkit, an ingress redirection from proxy to workload skips eBPF
programs that are meant to intercept traffic leaving the pod, since they
reside on the netkit peer device. One workaround is to attach the
same program to both the netkit peer device and the TCX ingress hook for
the netkit pair's primary interface, but

a) This seems hacky and we need to be careful not to run the same
   program twice for the same skb in cases where we want to pass that
   traffic to the host stack.
b) We're trying to keep the proxy redirection / traffic injection
   systems as modular and separated from Cilium as possible, the system
   that manages netkit setup and core eBPF programming.

It would be handy if instead we could redirect traffic directly from
one netkit peer device to another. This patch proposes an extension
to bpf_redirect_peer to allow us to do just that.

With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
the skb in the egress direction of the target interface's peer device
While the main use case is netkit, I suppose you could also use this
mode with veth as well if, e.g., there were some eBPF programs attached
to that side of the veth pair that needed to intercept traffic.

 +---------------------------------------------------------------------+
 | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
 | | pod (10.244.0.10)       |           ------------------------      |
 | |                         |          |                        |     |
 | |              +--------+ |          |      +---------+       |     |
 | | 1. packet -->|        | |          |      |         |       |     |
 | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
 | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
 | |           |  |        | |          |      |         |       |     |
 | |           |  +--------+ |          |      +---------+       |     |
 | |           |             |          | 2. bpf_redirect        v     |
 | +-----------|-------------+          |___________________   +-------|
 |             |                                            |  | eth0  |
 |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
 |             |________________________                    |          |
 | +-------------------------+          |                   |          |
 | | proxy (10.244.0.11)     |          |                   |          |
 | | IP_TRANSPARENT          |          |                   |          |
 | |              +--------+ |          |      +---------+  |          |
 | | 3. packet <--|        | |          |      |         |<--          |
 | |    enters    | netkit |<===========|======| netkit  |             |
 | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
 | | 4. packet -->|        | |                 |         |             |
 | |    leaves    +--------+ |                 +---------+             |
 | |    sip=10.244.0.10      |                                         |
 | +-------------------------+                                         |
 +---------------------------------------------------------------------+

Using the proxy use case as an example, in step 5 we would redirect
traffic leaving the proxy towards the pod's peer device using
bpf_redirect_peer(BPF_F_INGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
which skips the host stack and uses BPF redirect helpers to do all the
routing.

  (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
   eBPF host routing mode)

BASELINE [bpf_redirect(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
  3. eth0        ==over network==>                         [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
  [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver

TEST [bpf_redirect_peer(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
  3. eth0        ==over network==>                              [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/uapi/linux/bpf.h       | 16 +++++++++-------
 net/core/filter.c              | 14 ++++++++------
 tools/include/uapi/linux/bpf.h | 16 +++++++++-------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..dd0f2c3aea58 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5074,17 +5074,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_INGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..c24fdf744f75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2529,16 +2529,18 @@ int skb_do_redirect(struct sk_buff *skb)
 	if (unlikely(!dev))
 		goto out_drop;
 	if (flags & BPF_F_PEER) {
-		if (unlikely(!skb_at_tc_ingress(skb)))
-			goto out_drop;
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
 			     !(dev->flags & IFF_UP) ||
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
-		skb->dev = dev;
-		dev_sw_netstats_rx_add(dev, skb->len);
 		skb_scrub_packet(skb, false);
+		if (flags & BPF_F_INGRESS)
+			return __bpf_redirect(skb, dev, 0);
+		if (unlikely(!skb_at_tc_ingress(skb)))
+			goto out_drop;
+		dev_sw_netstats_rx_add(dev, skb->len);
+		skb->dev = dev;
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
@@ -2575,10 +2577,10 @@ BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
-	if (unlikely(flags))
+	if (unlikely(flags & ~BPF_F_INGRESS))
 		return TC_ACT_SHOT;
 
-	ri->flags = BPF_F_PEER;
+	ri->flags = BPF_F_PEER | flags;
 	ri->tgt_index = ifindex;
 
 	return TC_ACT_REDIRECT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11dd610fa5fa..dd0f2c3aea58 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5074,17 +5074,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_INGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
-- 
2.43.0


