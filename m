Return-Path: <netdev+bounces-293736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGK6CvJ8HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA361F599
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56207300C336
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012637B00C;
	Mon,  1 Jun 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="ZK8XN8qJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F9377EDC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317413; cv=none; b=RHxNVWft+5Vrxz+dLEQha6RlGuQCP1ZoySMYfzUz19EZvU865S0XBm2govT+Yoc7LrJJdd/Qmkst/ze1v9xywBq1eN1F/6DYW9fImku0/4/yM8oIu8BiaTDRcgroI/qAitPU7NHic3+HkeghucLBwr2KHfhnKe8SVuDyMgRe7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317413; c=relaxed/simple;
	bh=nIiFM0zUQQ3DATlbqolt5LBx2SnOeqHNUP/dCUB29PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXh2Q9bQMUIDuSC4DrMfPNK8Ih2LI1VEWirEMaWAe+iIorRDBwXKmw1J1QxBkMAmuraEK/1RiN8RAuCwQ9aO3p0zpJErTMo/z4xIOZHw4Tkpjjlt605AGFjYNOD4HiJdVYvTdKs1H4G4xXRW8hJWS8Zk+fXEUadE3kaw471FdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=ZK8XN8qJ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VAwlRpw3cuwp2rmiwA0Nrn27eTvWbfo8mto76+Q0O6U=;
	b=ZK8XN8qJO8nLAnBSKyr4xjuEVxi8nB1oAqHTzwf0ySKDSF0+/qJVjyIBo9s6JHEwI+2jNt
	ul/RmutxaVsgIhgTaaPAtcw7BA2T/zvTKAa7XuLwAcwDVagVX7X7MdZv5wAW35b9zlf9/1
	/pYZ2zzPvesj5Oc/Ddd+10eJENLI8YOYbPEhjw7xr7UXDwnpanaIhR5BN4oDNY/cqxEWkG
	NpbHGa73JdRRHPw3WAqrXFU2H+3wgd30VA6CMMWrwrY3eEA9XrnQhz49G0AkRtGy9tA2gM
	WS7t6bp2e/0+dZ39TVabuYkwiYfm3P4ZatUGeo5+Q4jhUl3yrOkKqP7iqa0gYQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-06-01
Date: Mon,  1 Jun 2026 14:36:14 +0200
Message-ID: <20260601123629.707089-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293736-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,simonwunderlich.de:mid,simonwunderlich.de:dkim,open-mesh.org:url]
X-Rspamd-Queue-Id: B0EA361F599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next. This
pull request supersedes batadv-next-pullrequest-20260528 [1]. The
following minor changes were made (I marked the changed patches with v2):

* removal of version.h and switch to `init_utsname()->release` to dynamically retrieve linux version
* switch back packet_size_max to signed integer datatype to match consumers
* add missing kerneldoc for batadv_wifi_net_devices_init

Please pull or let me know of any problem!

Thank you,
      Simon

[1] e-mail subject was: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-05-28
reference: https://lore.kernel.org/all/20260528142924.329658-1-sw@simonwunderlich.de/

The following changes since commit 68993ced0f618e36cf33388f1e50223e5e6e78cc:

  Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-21 14:39:12 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260601

for you to fetch changes up to 3bd64ca11d9a1672d67d3130a7264c2cf7f93cdf:

  batman-adv: use neigh_node's orig_node only as id (2026-06-01 14:22:03 +0200)

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
 net/batman-adv/hard-interface.c        | 207 +++++++++++++++++++++++++++++----
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
 net/batman-adv/version.c               |  12 ++
 28 files changed, 581 insertions(+), 299 deletions(-)
 create mode 100644 net/batman-adv/version.c

