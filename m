Return-Path: <netdev+bounces-292729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FMHJCFVGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F275F3E84
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA8430E9401
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F83F0ABB;
	Thu, 28 May 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="ZlZVGjQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD913EFFDF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978909; cv=none; b=KXu9oJtAuXUjAymFFes7g8PDduutb9xJIArfZGOb/rQdZ6GNiWQwDlulw7zvLE+nF4npL/BTZjMfjZ7JL344iBcnfpahg/HrUOKaOWpFWc1Mg1xvKerY03LWlfTwugMRuL/+nbKRDPUvFU8T+3guocple88CbV5w1TCtdimcMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978909; c=relaxed/simple;
	bh=6fNjQyfcR7xnkM25tMUoM2RKA8fE8Wzr130hC9GXa+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYWanpmlVk6QoZbmej8GVPTO1P2xMwRXj1FYMP7heHIbGCHzNpGdeb9Q5gfq8sp8MmBVxIRZRxpuN7bvSKXkfVbisdkO+cgUxYZkIergzEW+iYUbtftLpbwle4+4CNIwr/ZEX92kgMnfM7Q6afneXzQnHNeWSWTiPzUuBXfxePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=ZlZVGjQD; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X4kan7JCTkyF54L0yh5ItmlcUh6wLoQny/A5S6Qin7A=;
	b=ZlZVGjQDXauEAjeKc/Nqzqj7ADPCwuAfjLxiA6L9Cs/A0jVrkJQMHRdOCJ0zYiWwRNa0b+
	XjGbfgM3+ldDKopN0pNBgdbKI8jJ/MmU1DkWCksardACMTCHJvvlrNRQ4ZofSuepoumkaD
	7JGxPmgps07E1fUrZXeosflYvFWXC4olQA1X6jv5oy4doC0K5rQ12QJmjGVR1Iw78rjshF
	XoT66Wt1v/UnKWRYzwv9AMuoTr11ynvHBajqsOB02m6rHyOXzFAF+geUiSfZMeXL1Avrzh
	VJwB++i5K9xdmR4b1xC+sDkd+W0cfLTNmIGt24q4n2MWlfG0NmXnT68JtSQ4Nw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-05-28
Date: Thu, 28 May 2026 16:29:09 +0200
Message-ID: <20260528142924.329658-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292729-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 28F275F3E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 68993ced0f618e36cf33388f1e50223e5e6e78cc:

  Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-21 14:39:12 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260528

for you to fetch changes up to 5edff65367d064b217f4b692271c61a4db992de3:

  batman-adv: use neigh_node's orig_node only as id (2026-05-22 18:24:20 +0200)

----------------------------------------------------------------
This batman-adv cleanup patchset includes the following patches, all by
Sven Eckelmann:

 - drop batman-adv specific version

 - MAINTAINERS housekeeping for batman-adv (two patches)

 - add missing includes

 - use atomic_xchg() for gw.reselect check

 - extract netdev wifi detection information object

 - replace inappropriate atomic access with (READ|WRITE)_ONCE
   (six patches)

 - tt: replace open-coded overflow check with helper

 - tvlv: avoid unnecessary OGM buffer reallocations

 - use neigh_node's orig_node only as id

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: drop batman-adv specific version
      MAINTAINERS: Rename batman-adv T(ree)
      MAINTAINERS: Don't send batman-adv patches to netdev
      batman-adv: add missing includes
      batman-adv: use atomic_xchg() for gw.reselect check
      batman-adv: extract netdev wifi detection information object
      batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
      batman-adv: tt: replace open-coded overflow check with helper
      batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
      batman-adv: use neigh_node's orig_node only as id

 MAINTAINERS                            |   4 +-
 net/batman-adv/Makefile                |   1 +
 net/batman-adv/bat_iv_ogm.c            |  65 ++++++-----
 net/batman-adv/bat_v.c                 |  10 +-
 net/batman-adv/bat_v_elp.c             |  15 ++-
 net/batman-adv/bat_v_ogm.c             |  46 ++++----
 net/batman-adv/bridge_loop_avoidance.c |  15 +--
 net/batman-adv/distributed-arp-table.c |  17 +--
 net/batman-adv/fragmentation.c         |   1 +
 net/batman-adv/gateway_client.c        |   9 +-
 net/batman-adv/gateway_common.c        |  14 +--
 net/batman-adv/hard-interface.c        | 205 +++++++++++++++++++++++++++++----
 net/batman-adv/hard-interface.h        |  34 +++++-
 net/batman-adv/log.h                   |   2 +-
 net/batman-adv/main.c                  |  42 ++++---
 net/batman-adv/main.h                  |   4 -
 net/batman-adv/mesh-interface.c        |  42 +++----
 net/batman-adv/multicast.c             |   4 +-
 net/batman-adv/netlink.c               |  80 ++++++-------
 net/batman-adv/originator.c            |   8 +-
 net/batman-adv/routing.c               |   6 +-
 net/batman-adv/send.c                  |   6 +-
 net/batman-adv/tp_meter.c              |   6 +-
 net/batman-adv/translation-table.c     |  32 +++--
 net/batman-adv/tvlv.c                  |  57 +++++----
 net/batman-adv/tvlv.h                  |   3 +-
 net/batman-adv/types.h                 | 138 ++++++++++++++--------
 net/batman-adv/version.c               |  18 +++
 net/batman-adv/version.h               |   8 ++
 29 files changed, 593 insertions(+), 299 deletions(-)
 create mode 100644 net/batman-adv/version.c
 create mode 100644 net/batman-adv/version.h

