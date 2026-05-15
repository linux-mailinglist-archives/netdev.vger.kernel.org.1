Return-Path: <netdev+bounces-288261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtMORH2Bmo4pgIAu9opvQ
	(envelope-from <netdev+bounces-288261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ED54D633
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8D7D30DB396
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4043DA24;
	Fri, 15 May 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="X86GfgkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FB327BEC
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838957; cv=none; b=fFEddJVmesQyKYkQxtkwvUS3l9Kuhra8dsN/FpxJo0L67iRvMaVHSMH0JBcPdXx58wd4pJYradfghdqelJoh+depReewxzljfUMotjV31zk2mbVP6KCWEdHeGCt8u8+zeM6o+xV1bogMnfQSTdmhgMLhoRkyP0WDwRRpV0F39qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838957; c=relaxed/simple;
	bh=fYA0tsdOchNOKD7cbKJgL7szj3xMZxkkEpbnap1UeYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXahEFdIJ3qzqX55aDc1jiVN/f12dXvHgM1R6+ZwH0uWDBsE1Dm5NotoW9omLYs5cB0ukN4LQgZssi24g/ZOU2HW7V1tD3LPK5nQb4JizTdstJe7qIu1YO4thY1MB6v6KPzU1lSbdqxn0YqNybubVcOGIsBvVbg1t7HVwCrvwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=X86GfgkJ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WdW96lwjZLtv5rn+c5R3Ebu/EKI3ykmUo3hD6IAnLSk=;
	b=X86GfgkJHPGQ+jvTknJbGTTTLciNEs7qckV5iKMyYWnc+fCdSvG2EN1y9OiFGQoNET+5mQ
	/IlWzAQfNjZvOKWhBvvXMNNCdOFpb4ASVtnoVJ48r+6eum1AgN8mkYrJaiCcREiwVdAFCo
	jgJ1G6Msgwt5VbiJPM83iNoTW3gO6J31fi3WcIccBP1WxuQ4wp7TR8ij+6ENEiT4qmljAY
	OiVpr3oLrkdGBR3EV2WPVybqNbY5l7tncwgwgL+S5RnhiyIAtudFk8aL6m/Qdl2FqDaVWa
	yRT5kr+yrJrGj4OnlNW/84HFjcetC87nnfQKGz0rxckXS/weRuQ/wBZo3iDtrA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/14] pull request: batman-adv 2026-05-15
Date: Fri, 15 May 2026 11:55:25 +0200
Message-ID: <20260515095540.325586-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD7ED54D633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288261-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Dear net maintainers,

here are quite a few more bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ba9d20ee9076dac32c371116bacbe72480eb356c:

  batman-adv: bla: put backbone reference on failed claim hash insert (2026-05-08 14:29:02 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260515

for you to fetch changes up to d5487249a81ea658717614009c8f46acc5b7101a:

  batman-adv: tp_meter: directly shut down timer on cleanup (2026-05-15 10:41:55 +0200)

----------------------------------------------------------------
Here are various batman-adv bugfixes:

 - fix tp_meter counter underflow during shutdown, by Luxiao Xu

 - fix tp_meter tp_vars reference leak in receiver shutdown,
   by Sven Eckelmann

 - fix various translation table integer handling issues,
   by Sven Eckelmann (3 patches)

 - fix various translation table counter issues,
   by Sven Eckelmann (3 patches)

 - fix fragment reassembly length accounting, by Ruide Cao

 - clear current gateway during teardown, by Ruijie Li

 - handle forward allocation error in DAT, by Sven Eckelmann

 - tp_meter: avoid use of uninitialized sender variables in tp_meter,
   by Sven Eckelmann

 - disallow unicast fragment in fragment, by Sven Eckelmann

 - directly shut down tp_meter timer on cleanup, by Sven Eckelmann

----------------------------------------------------------------
Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sven Eckelmann (11):
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow
      batman-adv: dat: handle forward allocation error
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: tp_meter: directly shut down timer on cleanup

 net/batman-adv/distributed-arp-table.c |  3 ++
 net/batman-adv/fragmentation.c         | 58 ++++++++++++++++++++++++++++++----
 net/batman-adv/gateway_client.c        |  4 +++
 net/batman-adv/tp_meter.c              | 36 +++++++++++++--------
 net/batman-adv/translation-table.c     | 55 ++++++++++++++++++++++++++------
 net/batman-adv/types.h                 |  9 ++++--
 6 files changed, 133 insertions(+), 32 deletions(-)

