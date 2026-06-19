Return-Path: <netdev+bounces-300633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hViMAG3rNGpykAYAu9opvQ
	(envelope-from <netdev+bounces-300633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564F6A43FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=h6ql4ZWx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A53300916A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B0351C3B;
	Fri, 19 Jun 2026 07:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E633E36A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853032; cv=none; b=e22Lcks0Fy8NqovAliUMxEo7l2o7IFYId5N7lt70I34wWdrlnSLA7hZDTe9+H0hcEDSa4LPr6wodFHGNIYDq+57Kb2krJUfvr9rLccZ8Cr85yF7GnN1GpRuhdxBrzcfFzULbGIlgKugOp5ahSgHkLtJvslIMZYDPFFw3hsKc2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853032; c=relaxed/simple;
	bh=a+oGRw41dh1HY1aj2eszImyS6m4/Gxab2Oaii5OlU3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jg0aWxs/jRu4jaavmYddzCvZ0KIP+blNAwRVFk2+aiAu+kOn80rIxZVqGZn7p2iSIUAJGuxbZ17w2ytPxZFaC1XoqbwLV9OIBecdiX05kISPowMw8JYoRrM3GN70HEGr3xsr7NB7iMPfVZIq1km47DZ9NSlT8r0WgBORvbEkCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=h6ql4ZWx; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1TkLzyUd1JwPopxOLN6MeiT5+G1+YihcZtxk0na7ro=;
	b=h6ql4ZWxeEWdYnFm1M3mQeM7XLANR3/OrTo0BibVg5XKaA2jrGcDTlCfhrKDHsCGM4eskA
	a9GGheNn3gp+OsmVgfmuiebwqXbiI8kpxye54C3HydJeN4e3InzAHzSY2zT4zJenVSVB4K
	x9oaLAI0T3zQckgdydd6ntHJayiEigiU4X5hbU6ds8yDF/154BdOV0kQiqXJKt1sgupeXi
	Dei5CEQEAgYm93WS0Ix+pOzBLeqSnAXj/Pid0bz1/l/5a/mnKeqIW5agmHxiy/hPlNvYYJ
	dGPfagCKL/JowiAPmRrqqIOXuQXWf1z3Du4PTzav9WqJARxfT/0QBDOO7DPlqw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/15] pull request: batman-adv 2026-06-19
Date: Fri, 19 Jun 2026 09:00:30 +0200
Message-ID: <20260619070045.438101-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300633-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,simonwunderlich.de:dkim,simonwunderlich.de:mid,simonwunderlich.de:from_mime,vger.kernel.org:from_smtp,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6564F6A43FD

Dear net maintainers,

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit dad4d4b92a9b9f0edb8c66deda049da1b62f6089:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-11 14:33:35 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260619

for you to fetch changes up to edb557b2ba38fea2c5eb710cf366c797e187218c:

  batman-adv: tvlv: avoid race of cifsnotfound handler state (2026-06-14 12:33:18 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes, all by Sven Eckelmann:

- gw: don't deselect gateway with active hardif

- TTL fixes in bcast/mcast and fragmentation handling (4 patches)

- BATMAN V: prevent OGM aggregation on disabled hardif

- tp_meter: concurrency and range fixes, add cap to unacked list
  (4 patches)

- tt: fix unchecked VLAN ID in tt for local add and roam (2 patches)

- dat: check VLAN ID in the hash

- tvlv: enforce 2-byte alignment

- tvlv: avoid race of cifsnotfound handler state

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: gw: don't deselect gateway with active hardif
      batman-adv: ensure bcast is writable before modifying TTL
      batman-adv: fix (m|b)cast csum after decrementing TTL
      batman-adv: frag: ensure fragment is writable before modifying TTL
      batman-adv: frag: avoid underflow of TTL
      batman-adv: v: prevent OGM aggregation on disabled hardif
      batman-adv: tp_meter: restrict number of unacked list entries
      batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
      batman-adv: tp_meter: prevent parallel modifications of last_recv
      batman-adv: tp_meter: handle overlapping packets
      batman-adv: tt: don't merge change entries with different VIDs
      batman-adv: tt: track roam count per VID
      batman-adv: dat: prevent false sharing between VLANs
      batman-adv: tvlv: enforce 2-byte alignment
      batman-adv: tvlv: avoid race of cifsnotfound handler state

 net/batman-adv/bat_iv_ogm.c            | 11 ++++-
 net/batman-adv/bat_v.c                 |  1 +
 net/batman-adv/bat_v_ogm.c             | 23 ++++++++++-
 net/batman-adv/distributed-arp-table.c | 12 ++++--
 net/batman-adv/fragmentation.c         | 22 +++++++++-
 net/batman-adv/fragmentation.h         |  3 +-
 net/batman-adv/hard-interface.c        | 28 +------------
 net/batman-adv/routing.c               | 73 +++++++++++++++++++++++++++++++--
 net/batman-adv/tp_meter.c              | 74 ++++++++++++++++++++++------------
 net/batman-adv/translation-table.c     | 12 +++++-
 net/batman-adv/tvlv.c                  | 69 ++++++++++++++++++++++++++++---
 net/batman-adv/types.h                 | 21 ++++++----
 12 files changed, 270 insertions(+), 79 deletions(-)

