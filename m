Return-Path: <netdev+bounces-289913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLt9JUqhDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8458D0D4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21F6E3067FAF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDE3B3C1A;
	Wed, 20 May 2026 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="tbQ7oyOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61B3B6363
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278086; cv=none; b=fLdtrVhQmZ6XBiezF84zt5oO7qZiAY5CCEJy87TZK2bcu/w26lSRc0e7d1NWTeBK1iuyLl7PUf12bjbG0a6XFlTV8IDh4GVTgZ0nJg/hj3EXhA4Cd9Y1WjHvIdFGm4YWPC+SoBpThq5tkcnWlu4T8K5WCqyvpzGjMOF9+Gw0PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278086; c=relaxed/simple;
	bh=vR1fDpcFLkqRqknyUjuTZ4PJxuKvXO03QMVETgIlL2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIPuBUeoAxPCrOhthnv6/6k2IptgIwfQyy5PFqgNrgoZxo5mgrGIqbzhiBCAjrgLp3HMpZUQLywMpm3bvtFbLJrKDjPxPradZ9YnoGornvOiRRlYtlE3SNxMukEeJFEl4kJydKq6BlwDOCy9+a3VAkoGMuy8cvZM4u5oPwAnQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=tbQ7oyOt; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8BixBb1DIhQ8qq6hCCdb7nigjWog786sWdT3/VpFGno=;
	b=tbQ7oyOtYkDHUCzAk1OGQdUYb+JvSVaIGTi0L5ZdtPVNam0zWxZ7TCtWG8E9jmYvMSo+VM
	aasRqmqW7h5U4RP9nlUS9InTsoka5oddjwgGsVNxbfxL1XyzsntVAAUrvDtM9Zv0uDBJLo
	B51Jktwg1JlRVFlJiENydCWgC4/6RI0WI8xK7ewRpy+m3jAB0ah2Ue++sLrde114Vc4QKN
	tJ28+am++SFu0L+FAHTTqJjHKDQhWKkG6w6muuVYRt0Am3CujbvN9UN0ugEsjN8/lpKCoy
	hX3bZ4WOGoiidJqJH7T5jcnlsufswGEHO7u3kL9cKKUoG6BPsQ2UHL9qhVPNpg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/11] pull request: batman-adv 2026-05-20
Date: Wed, 20 May 2026 13:54:11 +0200
Message-ID: <20260520115422.53552-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289913-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:mid,simonwunderlich.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Queue-Id: 12E8458D0D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear net maintainers,

here is another round of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d5487249a81ea658717614009c8f46acc5b7101a:

  batman-adv: tp_meter: directly shut down timer on cleanup (2026-05-15 10:41:55 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260520

for you to fetch changes up to f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24:

  batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface (2026-05-19 10:43:54 +0200)

----------------------------------------------------------------
Here are batman-adv bugfixes, all by by Sven Eckelmann.

 - fix batadv_skb_is_frag() kernel-doc

 - BATMAN V: stop OGMv2 on disabled interface

 - BATMAN IV: abort OGM send on tvlv append failure

 - BATMAN IV: reject oversized TVLV packets

 - tp_meter: fix race condition in send error reporting

 - tp_meter: avoid role confusion in tp_list

 - mcast: fix use-after-free in orig_node RCU release

 - BATMAN IV: recover OGM scheduling after forward packet error

 - bla: fix report_work leak on backbone_gw purge

 - bla: avoid double decrement of bla.num_requests

 - bla: avoid NULL-ptr deref for claim via dropped interface

----------------------------------------------------------------
Sven Eckelmann (11):
      batman-adv: fix batadv_skb_is_frag() kernel-doc
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface

 net/batman-adv/bat_iv_ogm.c            |  82 ++++++++++++++++++++-----
 net/batman-adv/bat_v_ogm.c             |  59 ++++++++++--------
 net/batman-adv/bridge_loop_avoidance.c | 109 ++++++++++++++++++++++-----------
 net/batman-adv/fragmentation.c         |   4 +-
 net/batman-adv/mesh-interface.c        |   1 +
 net/batman-adv/originator.c            |   4 +-
 net/batman-adv/tp_meter.c              |  99 ++++++++++++++++++------------
 net/batman-adv/tvlv.c                  |  28 ++++++---
 net/batman-adv/tvlv.h                  |   2 +-
 net/batman-adv/types.h                 |  52 ++++++++++++----
 10 files changed, 299 insertions(+), 141 deletions(-)

