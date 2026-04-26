Return-Path: <netdev+bounces-281180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAfeJudi7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9146AD7C
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60EBC3001D51
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE737BE7D;
	Sun, 26 Apr 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="pr6C5QR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129E37B41B
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230565; cv=none; b=V0ESB4vn0nxNgKwHA7PpNnuEbuORWZj9iOx66vXXIayhIu/znqZHCHeSzrANJvetD0/eTRvLeJpJGqJww+bKDWPmJwM/igIqr4+sAPeTEfUSCPxIv1VHMBuDdgo95zWdWWpzkt9cmn7S7epRxqBuJHWsZ/N8FC0s64cgiMan8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230565; c=relaxed/simple;
	bh=ZYCClso4vhZufQVzcfiwfd98DsgDbkkC/ByaYb3yuLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rO3hkdJHlTZ6gwwazYOy/hcescFnOD+reWgITd60uOqqEZMpyvofCAgopJP+Fen0xml7hAl1er+pa60gjcBYyyyrxed3QAslJNHu5j9bEJg/0ETxsuWRrE5K83wfclEFW0HqEmIuR/yJH8neMnf8/D9usqI7kAE28yd5FP/0Wd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=pr6C5QR3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ac9ef74131so145745686d6.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230561; x=1777835361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVKF1tuC4uOVR60jHy7jU8iO6O8z/hS/qhPlZIKifg4=;
        b=pr6C5QR3ZPf/2GihpauN8gAMVO8ErjGvRHfPOQyoD+bYQYbK/nv70WDIhI0hn6+7+4
         4QP8snwsq+sEBnqLIK8zb9E3WnY7OJPGtWreE9sMA79b+pfXojNLrJa5oaNFCLns2ntH
         J+CukAxDUov+jTrvYdO2GUlxssMBVss9vBReaF7UOO3hXchIurroyMLQ/aQWBX6J1V1C
         kcy+Z232LI5X01xIFibHFEbMUOCWyr5F95BgAMKbf8jmo81Lvrjtw/XRH4drF+KaX1na
         gOf+0mwubvjvNrxdYvdGhrHWnexQgxR0udGWmMt8tLfkm3fN6AVFEc074KfYn7uUSH7X
         ewIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230561; x=1777835361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVKF1tuC4uOVR60jHy7jU8iO6O8z/hS/qhPlZIKifg4=;
        b=qxPFWBfb3x/uNvaI1R+lq8qJ8ianOcoI89NfUWBlI/qL7A0C1+RxiSqr8yc5wXVrL7
         qbYLjjESN4Sng8jLsST84+i8I/4wz8SLvrlY2Y/vU2Ji6L8b06w7bZXux9ufGJkoJmOU
         12jhBb7wE9twOBmfvTLd4EhLxLjQIywoZITjUH6j29a6u74IoApKXxDWshIAQ1qynkM/
         hDBtv2p2K7PQ/NyQxoTQV+TpR0sYg0Or062ctilDC+99UR9SFvu29XtBm3QMyepTcLpS
         YS5FkHQpflitzXb3OkaFmxSrfU+TogExQClvWv7EA3En0ffcpNy0g3t8iyaD5C+/+9DJ
         RaZQ==
X-Gm-Message-State: AOJu0YxE46aUtqzecz4D3INnG7pPTZDw0GFMZWD5rR1lw7EAihjzvrhb
	UeWOK+AX0n7m0HaYkvnUtGSn+zmHNK4StupsVeN3j2HaQoNaPlL9Jn6uzkwbsLxzI3PPcMhNTT6
	esrU=
X-Gm-Gg: AeBDiesywK2eKigX3ibIiHTvKU+LE2GygaXjJsXIe+arSjWVIRmd79LS7D8R+ItvApq
	KdydKY6iiJO4tx0h70sakbkbjXmEZSS19vtHCXjFpZ+zTE1/60F5S6qrQn6QaBC2pPLxHPARnVS
	o1KUaToWZhJalImYA9Q/cZpWmWDU9SOKJ/2rEwoYyeGyTM7aQGOReOUiwbu8BV9bfvfNRvO8cdz
	4itm7F8OFwyDd7BL7VWEDABRyU+j20GjNTcoiSgeX8XfgF78DfbEfaDrVZ2UacL6PiJpgA/SXFL
	73n5K+NbLhsY6exBUcdwsRwSohXUrnRX0xGyCyW5Zu9Cbc0G/aBLUCeT9KYxBb9kfTC9lVspNCn
	qQEQDV+j9sLh8XKXcRnw0gtcIUmV81ZddNZaBE3FeFtAL8975WfMz5/C6R8ezuSkFRHfA6l0d10
	iZuacihn2yw9oFv2MAtY6MmgPEzQMwHLHtjQDoe20iAt2IrketQ/SKcrrkS+kbZntQE18ff/144
	X2ZrwhOsIQwbU3roj7nDy547GVzaks=
X-Received: by 2002:a05:6214:4f02:b0:8ac:74d7:dd14 with SMTP id 6a1803df08f44-8b028167980mr589365846d6.34.1777230561528;
        Sun, 26 Apr 2026 12:09:21 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/9] net/sched: Fix packet loops in mirred and netem
Date: Sun, 26 Apr 2026 15:09:07 -0400
Message-Id: <20260426190916.128489-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FE9146AD7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281180-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim,sashiko.dev:url,mojatatu.com:mid]

This patchset adds a 2-bit per-skb tc_depth counter that travels with
the packet to help  fixes packet loops caused by mirred ingress
redirects and netem duplication in stacked qdisc trees.
The existing per-CPU mirred nest tracking loses state when a packet is
deferred through the backlog or moves between CPUs via XPS/RPS.
A per-skb field covers both cases.

Patch 1 adds the tc_depth field in a padding hole in sk_buff.
Patches 2-3 revert the check_netem_in_tree() fix and its tests,
which broke legitimate multi-netem configurations.
Patch 4 uses tc_depth to stop netem duplicate recursion.
Patch 5 uses tc_depth to catch mirred ingress redirect loops.
Patch 6 fixes the infinite loop in the mirred egress blockcast case.
Patch 7 fixes an skb leak in early return error scenarios in tcf_mirred_act
for redirect (caught by Sashiko [1]).
Patches 8-9 add mirred and netem test cases.

Changes in v4:
- Provide better context in patch 1 commit to appease Sashiko
  We'll see if it will stop yapping about corner cases! I believe
  I am making history being the first human to talk directly to Sashiko
  in a patch submission;->
- Fix infinite loop for the mirred egress blockcast case (patch 6)
- Fix skb leak in tcf_mirred_act caught by Sashiko (patch 7)

Changes in v3:
- Renamed skb->ttl to skb->tc_depth to avoid confusion with IP TTL
- Expanded commit messages
- Split mirred and netem test cases into separate patches
- No code changes from v2

Changes in v2:
- Do not reuse skb->from_ingress (which was moved to skb->cb)

[1] https://sashiko.dev/#/patchset/20260413082027.2244884-1-hxzene%40gmail.com

Jamal Hadi Salim (5):
  net: Introduce skb tc depth field to track packet loops
  net/sched: Revert "net/sched: Restrict conditions for adding
    duplicating netems to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net/sched: fix packet loop on netem when duplicate is on
  net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

Kito Xu (veritas501) (1):
  net/sched: act_mirred: Fix blockcast recursion bypass leading to stack
    overflow

Victor Nogueira (3):
  net/sched: act_mirred: Fix skb leak in early mirred redirect returns
  selftests/tc-testing: Add mirred test cases exercising loops
  selftests/tc-testing: Add netem test case exercising loops

 include/linux/skbuff.h                        |   2 +
 net/sched/act_mirred.c                        |  67 +-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 6 files changed, 691 insertions(+), 142 deletions(-)

-- 
2.34.1


