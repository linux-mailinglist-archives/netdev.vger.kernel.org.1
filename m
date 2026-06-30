Return-Path: <netdev+bounces-303149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f+R8B6O3Q2rNfgoAu9opvQ
	(envelope-from <netdev+bounces-303149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 879806E433D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=qhzzuu2o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303149-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A60C305C102
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEF40757B;
	Tue, 30 Jun 2026 12:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D2391E77;
	Tue, 30 Jun 2026 12:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822816; cv=none; b=OjtTRbX2RhAd7th6M2jQHuDwogFIwSKnp3wWtMelDHaxmvrRpv3qk3A3Hy24ImnlFr3kgdCYlHZ4Qssb8nSqqu5968Jzmow7Psimov9NEs5ip6Ifu9W1AC0we4KpX/65FtXNPWsW+IIiRETNKhPhW49eaiN0HCVgbBnVxbyx0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822816; c=relaxed/simple;
	bh=j/4atb9+pcESumLeAY7R129iJqrRFKgjemNXrb52HZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx9c8DGqtweTCynWnfYQYWZsj8v6siTFUISL/quZ/dztPKBYO3A13b1AxJFjRpp8h98Ap/Ds++X0GmXzkkOVs9zzoVbCkkaIxwkDzxMgNxwNtI/YNW8cGbhgCJuPwOwvfPv6HfMFl/AOPEHgXBdWwMPSl6bDX3FxJ0TKQpTCLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qhzzuu2o; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=z4p7hUd9/x0IqFiaZtRCAdL6WlP2+E1Y5oVefYB42/8=; b=qhzzuu2odfImJinNs9D/14O9nO
	AfQsvdbBfcOzurIzUsGKpsp7SnDuwYfuaUNzF+o90r3PUtUOrtqC+fRqmZWXuW90R4nqqwP8HUsNp
	QgGteBoTz4mVcQN3DiWN3K26gU+YQ1htP2J5MQNonnNjLCNuS6dT14T126ZVKf9VhKhrPvhwVby0U
	E6upjR5pbx8STpmWeSgn/MsYBrpL+wbClc0+JAYe1CJg+QQfHDqt+JyRJyxmPgek1g2dmsVc9sCI9
	t/4a6fFsUYdrVXvVGHvcyNdJgASsdjPZrxRTOIpxLZvaJ2rjTww7M/fNpQ0/kDzu80VhDH4RJpXnB
	WsxxDXhQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1weXee-000NcL-01;
	Tue, 30 Jun 2026 14:33:32 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	jhs@mojatatu.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 0/3] Fix broken TC_ACT_REDIRECT from qdiscs
Date: Tue, 30 Jun 2026 14:33:28 +0200
Message-ID: <20260630123331.186840-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28046/Mon Jun 29 08:27:20 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303149-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iogearbox.net:dkim,iogearbox.net:mid,iogearbox.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 879806E433D

This is an alternative fix to [0] in order to not uglify
__dev_queue_xmit() with sprinkled ifdefs given this can be
simplified and isolated through a simple test into the BPF
redirect helper itself.

I've also added a proper BPF selftest, so there is no need
to check-in a binary BPF object into selftests given we do
have BPF infra for all of this.

  [0] https://lore.kernel.org/netdev/20260629102157.737306-1-jhs@mojatatu.com/
  [1] https://lore.kernel.org/netdev/20260629102157.737306-4-jhs@mojatatu.com/

Daniel Borkmann (2):
  bpf: Reject redirect helpers without a bpf_net_context
  selftests/bpf: Add test for redirect from qdisc qevent block

Jamal Hadi Salim (1):
  net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

 include/net/pkt_cls.h                         |  14 ++-
 net/core/filter.c                             |  17 ++-
 net/sched/cls_api.c                           |   6 +-
 net/sched/sch_cake.c                          |   2 +-
 net/sched/sch_drr.c                           |   2 +-
 net/sched/sch_dualpi2.c                       |   2 +-
 net/sched/sch_ets.c                           |   2 +-
 net/sched/sch_fq_codel.c                      |   2 +-
 net/sched/sch_fq_pie.c                        |   2 +-
 net/sched/sch_hfsc.c                          |   2 +-
 net/sched/sch_htb.c                           |   2 +-
 net/sched/sch_multiq.c                        |   2 +-
 net/sched/sch_prio.c                          |   2 +-
 net/sched/sch_qfq.c                           |   2 +-
 net/sched/sch_sfb.c                           |   2 +-
 net/sched/sch_sfq.c                           |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/tc_qevent.c      | 113 ++++++++++++++++++
 .../selftests/bpf/progs/test_tc_qevent.c      |  23 ++++
 19 files changed, 175 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_qevent.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_qevent.c

-- 
2.43.0


