Return-Path: <netdev+bounces-303212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7UeTAn3PQ2rLiwoAu9opvQ
	(envelope-from <netdev+bounces-303212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E2B6E54B7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:15:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=I9aeYTkz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303212-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303212-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6AB4310B0B9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB9373C1A;
	Tue, 30 Jun 2026 14:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3B3BB57
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828388; cv=none; b=FuCrLe1zzbiifnSRWdJe4kUn9am1ZOpleDBUg029IC4GBw9A5th5CvZ1Hyvb7sO045Cex4inWVfc1pyGQwr8lPmrqoyACjxpab9Syob08Ch2NSuAt4thHkg6DhK+ZJ8I3SxNTjBY9xGO6HF7IkUZPxHp9dZi0DHr5Z9C+9v+o4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828388; c=relaxed/simple;
	bh=czmVNJLBzYnqYzRW1H4oNqFTDuuhbwfs2khaJXKGkuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vj18Ud163Fxht0ixc+l1j8ziZB/4k1kYLju/dYJRT56Y83xmhm0+eWUH9gzX8NFMmV0j9dzbrCAxXky+4D7q3CYPL6dZNSK2j2dAeZbdnOr9qyoPmE9A/8sPElzZ9ZWUQCKtIf0WURNDsLeKkiwbAoFa0nyrd9RKyE+Erxp4eNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=I9aeYTkz; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RML7WXnJKm0QCAIXXu6o7fujESjNPIoRg8QFFLLlkbU=;
	b=I9aeYTkzmQugHZyHbSOxmQbBHfhCBE3wpKMbAzOuqMdNFiDQErANeChF3fCNehDgcmB781
	hBAx+RBlYDivhXhRxdiSpaK+aLYbJJOsyVd34S2Mp2sw0vJWC1YVQNjslp3lrR685+psAa
	Es/H1cWpv9vdiq6qZggoZmfao2oXbzbtCIK59lyUrX98L7mzFSCDXdXQc3eSx0o3OZP+UB
	6sAxZetzP7TUKMd8KDU9hndeAq+yVy8tpcPCpwn8PL+Jab+1Em66xAcPVtAKa0epdjPP33
	qSJycq2AuR/8v7eqbJmFJdVapL5T/4vcuFdZPJqsxZWrwCKFUQ2I8gyqbf0V8g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-06-30
Date: Tue, 30 Jun 2026 16:06:08 +0200
Message-ID: <20260630140623.88431-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303212-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[open-mesh.org:url,vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:mid,simonwunderlich.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1E2B6E54B7

Dear net maintainers,

here is cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260630

for you to fetch changes up to 247691642fd4de7a029de253e47dba936542ce9f:

  batman-adv: tp_meter: delay allocation of unacked entry (2026-06-28 22:09:04 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - drop hardif global list, by Nora Schiffer (2 patches)

 - make hard_iface->mesh_iface immutable, by Sven Eckelmann

 - further post-hardif global list cleanups,
   by Nora Schiffer (3 patches)

 - cleanups and simplifications depending on the hardif->mesh_iface
   immutability guarantee, by Sven Eckelmann (3 patches)

 - tvlv: extract tvlv header iterator, by Sven Eckelmann

 - tp_meter: improve unacked list handling,
   by Sven Eckelmann (5 patches)

----------------------------------------------------------------
Nora Schiffer (5):
      batman-adv: create hardif only for netdevs that are part of a mesh
      batman-adv: remove global hardif list
      batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      batman-adv: move hardif generation counter into batadv_priv
      batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()

Sven Eckelmann (10):
      batman-adv: make hard_iface->mesh_iface immutable
      batman-adv: drop NULL check for immutable hardif->mesh_iface
      Revert "batman-adv: v: stop OGMv2 on disabled interface"
      batman-adv: iv: drop migration check for batadv_hard_iface
      batman-adv: tvlv: extract tvlv header iterator
      batman-adv: tp_meter: simplify unordered ack calculation
      batman-adv: tp_meter: combine adjacent/overlapping unacked entries
      batman-adv: tp_meter: keep unacked list for receivers
      batman-adv: tp_meter: adjust name of receiver lock
      batman-adv: tp_meter: delay allocation of unacked entry

 net/batman-adv/bat_iv_ogm.c            |  12 +-
 net/batman-adv/bat_v_elp.c             |   9 +-
 net/batman-adv/bat_v_ogm.c             |  33 ++---
 net/batman-adv/bridge_loop_avoidance.c |   9 +-
 net/batman-adv/hard-interface.c        | 165 ++++++++-----------------
 net/batman-adv/hard-interface.h        |  10 +-
 net/batman-adv/main.c                  |   9 --
 net/batman-adv/main.h                  |   3 -
 net/batman-adv/mesh-interface.c        |  13 +-
 net/batman-adv/netlink.c               |   4 +-
 net/batman-adv/originator.c            |   4 -
 net/batman-adv/tp_meter.c              | 217 ++++++++++++++++++++-------------
 net/batman-adv/tvlv.c                  |  86 +++++++------
 net/batman-adv/types.h                 |  28 ++---
 14 files changed, 273 insertions(+), 329 deletions(-)

