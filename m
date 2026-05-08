Return-Path: <netdev+bounces-285915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK4UDEkG/mnumAAAu9opvQ
	(envelope-from <netdev+bounces-285915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1404F8FFA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8322301AA7E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E630649C;
	Fri,  8 May 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="eMQSS70w"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA943002DD
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255430; cv=none; b=Q5oVzagDyMQJB1A1p2K7WxuxksqLBhim2KzJPadRgSD6YJmmtf584zOP5WCKNqx5+8I1kp9y5hU5yN+Esti46rSHR08FleSwQYmVM94lOG+vVltgDhWdlk0GOVtFx9Wsd/czFWURe30EXgduu27T6tUFYbZ0FQ6e9JO+fKVjGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255430; c=relaxed/simple;
	bh=EV9pyTwVgtQ8OQAfRIcWb0vGF3HesC5dvxiqueUXGNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uo26BIzo2Aq9juQ1iwPGGQ6gp31taWlKQiPSMhwonKoT1IomUUYzYpLq6IbTMIlyU5CN9llLnkGDHkcBg91iaOfs0SC0ycVIZ8QfvtlfDm+8OrdsDQ0R9Q0Y8JT168yo5R4H1BCCvy6AqwSuIIMbFiCg2cw/gl0yicvllCSZu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=eMQSS70w; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8zhRPnfLe2NDUY+iSHXVns7vYjJltQ03OVMAkw18IsM=;
	b=eMQSS70w0o8Hxn0SN1KG+7odxp01shVyfDXNODrtYMZWnf2If0W19IfQ9EVzbHACsHuHU9
	DvSM2KX39r5gtgTs4g7zex5T7uGXw48/XScBjk0jv137ceubkYzDqrscSX3SptKyyRlMD6
	Ij1Rer/hNkJsbPusM3sFnj4UYylMqJSWuLorp8tIqaQHu1zxtVlJyEseBTyfqLmECR0jy7
	ozMGnLj3QCU2iY9PZdLsCdt2nZm94YuGixFSzUOqnxeiTrLmbXi4QLhWkw6wDaDrcBlDwM
	f2kTbsr8vLDRhw4u1jXe9qyYaO/9KQIPpXTAW+3T4GW79KOf3Rn2vkP2T2VlJw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/8] pull request: batman-adv 2026-05-08
Date: Fri,  8 May 2026 17:43:06 +0200
Message-ID: <20260508154314.12817-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E1404F8FFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285915-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:mid,simonwunderlich.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,open-mesh.org:url]
X-Rspamd-Action: no action

Dear net maintainers,

here are a couple of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260508

for you to fetch changes up to ba9d20ee9076dac32c371116bacbe72480eb356c:

  batman-adv: bla: put backbone reference on failed claim hash insert (2026-05-08 14:29:02 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- fix integer overflow on buff_pos, by Lyes Bourennani

- fix invalid tp_meter access during teardown, by Jiexun Wang (2 patches)

- stop caching unowned originator pointers in BAT IV, by Jiexun Wang

- tp_meter: fix tp_num leak on kmalloc failure, by Sven Eckelmann

- fix BLA refcounting issues, by Sven Eckelmann (3 patches)

----------------------------------------------------------------
Jiexun Wang (3):
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop tp_meter sessions during mesh teardown
      batman-adv: stop caching unowned originator pointers in BAT IV

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Sven Eckelmann (4):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert

 net/batman-adv/bat_iv_ogm.c            |  85 +++++++++++++++++-------
 net/batman-adv/bridge_loop_avoidance.c |  11 +++-
 net/batman-adv/main.c                  |   1 +
 net/batman-adv/tp_meter.c              | 116 +++++++++++++++++++++++++++------
 net/batman-adv/tp_meter.h              |   1 +
 net/batman-adv/types.h                 |   4 ++
 6 files changed, 172 insertions(+), 46 deletions(-)

