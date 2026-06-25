Return-Path: <netdev+bounces-301919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cyAIL5j6PGo0vQgAu9opvQ
	(envelope-from <netdev+bounces-301919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:53:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2876C46A6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Gc9QgqNJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301919-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301919-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B320230075DC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87F43C1096;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10973BB104;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381079; cv=none; b=iSBPDvPKAiXlDmvg05/i5Lxx9FGx0qIMEta6MW5OiPHKN95bMZct7gV2kvQp8P89RJdPyhSIj9AZX0KinXv21SktWqdT2Zj5/nJz56nxY00k/t1Wh1hBopltbpvBUJlm+JiqeoU+rj6SOnzuH0aFZSI7b8DcmKyUAK+dnzEQTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381079; c=relaxed/simple;
	bh=B7/s9d6mVek1Q/XNG+xw8Tpj1nPLed6zevlG4m/N6iQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qbgwxuXf+VRdza5LNpWZIqBcJKK7QZZxORQEhnUhcaGvBM2s0HFkLBGC/ktFquLqRqQKkNHlm4kkaaHsCK7XiQ4vA2pK9vSyyDaGBtDFtu+DLQUtE/A2vE2V5sFlvSXrdb2/I2rv2fydgI3U+ggurUMyt7SLY0v+4q7wNZLhRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc9QgqNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E64C2BCB3;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782381079;
	bh=B7/s9d6mVek1Q/XNG+xw8Tpj1nPLed6zevlG4m/N6iQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Gc9QgqNJ9RIwsceGCBwKo25l34Wh2mKOyVA5vOBSZauWTORglrmJkWx1AcVveEBQP
	 6pOHaWtMkNoJhOMrMtr7OYBEBZKmp/vZ+1vMAD/QSuz6vRLkuBpBbcwYTLkpAJ/YGn
	 PTYc0WLFvaT/PW8OKn3md4iVw6U/Ds6BRFZe2g0iKehoepjNNJh/ojBL8rp0A/j/0m
	 GWI+Ze+p0lreLZD6O4y+2n+yVdtpiTLHpKi4UW6LpgulyG6keACMDm08+loYqMHrVp
	 /zkPOyveXRanQkLzZZg4mOQJnvqMCiErHgF/C5gYnH8ZG75hLvIFHwTs3wbPcY4r0T
	 3PSkfFIQ/5wGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1584ECDB479;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH 0/2] net/sched: finish the qdisc_dequeue_peeked conversion
 (taprio, multiq)
Date: Thu, 25 Jun 2026 04:51:18 -0500
Message-Id: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABb6PGoC/x3MTQqAIBBA4avErBuwMe3nKtFCc6rZVChEIN09a
 fkt3suQOAonGKsMkW9Jch4FTV3BsrtjY5RQDKTIKksGfYtB0oW68YunbkDVE5vBaee0hZJdkVd
 5/uU0v+8Hn0+1GGIAAAA=
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 Jarek Poplawski <jarkao2@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782381078; l=4699;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=B7/s9d6mVek1Q/XNG+xw8Tpj1nPLed6zevlG4m/N6iQ=;
 b=r833+U02l28X7VE9MKQUlfqmiACBRaY/LH1TePDXczr8Q2WauMtTMHgCt+8yOwMaTu5tKOoWn
 w4+EgQKEOVXCJEl+t5zjFPXe+ou9m8m8TbfRjhpHqm1p3SE9T6h7T8a
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jarkao2@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301919-lists,netdev=lfdr.de,hexlabsecurity.proton.me];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,nxp.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:replyto,proton.me:email,proton.me:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A2876C46A6

Commit 77be155cba4e added peek emulation: a non-work-conserving qdisc's
->peek dequeues one skb and stashes it in the child's gso_skb. A parent
that peeks such a child must then take the packet with
qdisc_dequeue_peeked(), not a direct ->dequeue(), or the stashed skb is
bypassed and the child's qlen/backlog desync. sch_red and sch_sfb were
just fixed for this; taprio and multiq still take the direct path.

With a qfq child the desync re-enters qfq_dequeue on an emptied aggregate
list and dereferences NULL, panicking from softirq on ordinary egress.
taprio reaches it on its own (root-only software path, all gates open);
multiq reaches it when a peeking parent such as tbf wraps it over a
non-work-conserving grandchild. Both need only CAP_NET_ADMIN.

Confirmed under KASAN: the unpatched arm panics, the patched arm is
clean, and a work-conserving-child control is clean. The reproducers and
splats for both are below; the per-patch changes are one line each.

taprio reproducer (self-triggering, no parent qdisc needed):

  ip link add dummy0 numtxqueues 4 type dummy; ip link set dummy0 up
  ip addr add 10.10.11.10/24 dev dummy0
  tc qdisc add dev dummy0 root handle 1: taprio num_tc 2 \
     map 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 \
     base-time 9000000000000000000 sched-entry S 03 200000 flags 0x0 clockid CLOCK_TAI
  tc qdisc replace dev dummy0 parent 1:1 handle 3: qfq
  tc class  add dev dummy0 classid 3:1 parent 3: qfq maxpkt 512 weight 1
  tc filter add dev dummy0 parent 3: protocol ip prio 1 matchall classid 3:1
  ping -c1 10.10.11.99 -I dummy0

[  903.769174] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[  903.769953] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[  903.770456] CPU: 7 UID: 0 PID: 16162 Comm: ping Not tainted 7.1.0-rc5 #1 PREEMPT(lazy)
[  903.771725] RIP: 0010:qfq_dequeue+0x362/0x1580 [sch_qfq]
[  903.777452] Call Trace:
[  903.778311]  taprio_dequeue_from_txq+0x383/0x680 [sch_taprio]
[  903.778685]  taprio_dequeue_tc_priority+0x19a/0x330 [sch_taprio]
[  903.779645]  taprio_dequeue+0xa6/0x330 [sch_taprio]
[  903.780299]  __qdisc_run+0x16c/0x1890
[  903.780854]  __dev_queue_xmit+0x1ece/0x3390
[  903.784109]  ip_finish_output2+0x571/0x1da0
[  903.785996]  ip_output+0x26c/0x4d0
[  903.789572]  ping_v4_sendmsg+0xd22/0x12b0
[  903.796118]  __x64_sys_sendto+0xe0/0x1c0
[  903.796612]  do_syscall_64+0xee/0x590
[  903.818669] Kernel panic - not syncing: Fatal exception in interrupt

multiq reproducer (needs a peeking parent over a stashing child; tbf
values chosen to force it to throttle):

  ip link add dummy0 numtxqueues 2 type dummy; ip link set dummy0 up
  ip addr add 10.10.11.10/24 dev dummy0
  tc qdisc add dev dummy0 root handle 1: tbf rate 88bit burst 1661b \
     peakrate 2257333 minburst 1024 limit 7b
  tc qdisc add dev dummy0 parent 1: handle 2: multiq
  for b in 1 2; do                          # qfq on every band
    tc qdisc  add dev dummy0 parent 2:$b handle 3$b: qfq
    tc class  add dev dummy0 classid 3$b:1 parent 3$b: qfq maxpkt 512 weight 1
    tc filter add dev dummy0 parent 3$b: protocol ip prio 1 matchall classid 3$b:1
  done
  ping -c12 10.10.11.99 -I dummy0

[ 1066.385097] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[ 1066.386385] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[ 1066.387227] CPU: 1 UID: 0 PID: 5357 Comm: ping Not tainted 7.1.0-rc5 #1 PREEMPT(lazy)
[ 1066.389183] RIP: 0010:qfq_dequeue+0x362/0x1580 [sch_qfq]
[ 1066.396316] Call Trace:
[ 1066.396768]  multiq_dequeue+0x163/0x360 [sch_multiq]
[ 1066.397885]  tbf_dequeue+0x6b9/0xf17 [sch_tbf]
[ 1066.398269]  __qdisc_run+0x16c/0x1890
[ 1066.399315]  __dev_queue_xmit+0x1ece/0x3390
[ 1066.403276]  ip_finish_output2+0x571/0x1da0
[ 1066.404818]  ip_output+0x26c/0x4d0
[ 1066.408620]  ping_v4_sendmsg+0xd22/0x12b0
[ 1066.415264]  __x64_sys_sendto+0xe0/0x1c0
[ 1066.416251]  do_syscall_64+0xee/0x590
[ 1066.441210] Kernel panic - not syncing: Fatal exception in interrupt

---
Bryam Vargas (2):
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked

 net/sched/sch_multiq.c | 2 +-
 net/sched/sch_taprio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
change-id: 20260625-b4-disp-31bcb279-082e59a3aa36

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



