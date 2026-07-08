Return-Path: <netdev+bounces-305710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9zRDhYZTmq6DAIAu9opvQ
	(envelope-from <netdev+bounces-305710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC7723C2F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:32:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XAtDioUD;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305710-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5953017032
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BF40BCBC;
	Wed,  8 Jul 2026 09:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B6409604
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 09:25:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502738; cv=none; b=NH8dUHgV+EaYDEmvZNfFhOLBHAelg/KdaV9Y3+wnL7JbJ42tH/dNZscYgA7SdjPluKhxExt1gCi8niQM5Mt/egLPMk3//wNMeR8l4tlYOiB/2q2ZPrgWMLeHUw/3F89GPc32/6NuzyIVLJw96q70QLa+jIT6rtC4yAP5jiGCzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502738; c=relaxed/simple;
	bh=3vN/ULZGpFFyN5ckZxRRrREJIWoW0aNmPunjbOmS3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkjkJvwSOIgu1lEbYyPjLyS2/xbp7xjphAhPTgCxfcZSVru0uk6eszNfwka3DmYxRQG6QFo11Gi3LgagYsyBI1LOfwAKg1bkHB2YTooNS0wZGdfAX0cDZ8U2G9qP0HXdIWEyjX0JqCF29FGktRBBYseROLFSG6fQQvjGZU4cr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=XAtDioUD; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWkYU4Tl1LIlSBFPEbkVF+ndyjxVNCuoXkEReRpmdi4=;
	b=XAtDioUDr99Cgtu7OTy1gMTDubFDxzvz5iPtM3udwsCPfWhxUsrk9zl69t+IeJ57MxJmbD
	9hJc61i3XPFYxM2lJJF00zroGHFBckEJuzh6iqJ8rbG84BR0Vj3knN/uyhepxQbAh2rVYo
	mq5zfOaIpE2FukxV8EBeXO4i8DPgItpHzoaK03e6TRbMRO9hoCWelmIm31PY3N8flQxUFH
	SC5tVQoy25Fxgvvo3iubb9GWLIhlxEgULUWRLUnNOu1y6Ial0xLcC9rshhF+OSN5npFHUF
	VV1VpqdIaxWl8qr3KDLFMSSyVe67xIMRfzPuWNNgJBDg8Z19onux6hyz0Qe+1Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/9] pull request: batman-adv 2026-07-08
Date: Wed,  8 Jul 2026 11:18:12 +0200
Message-ID: <20260708091821.314516-1-sw@simonwunderlich.de>
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
	TAGGED_FROM(0.00)[bounces-305710-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:from_mime,simonwunderlich.de:dkim,simonwunderlich.de:mid,open-mesh.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89AC7723C2F

Dear net maintainers,

here are some more smaller bugfixes for batman-adv which we would like
to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 26560c4a03dc4d607331600c187f59ab2df5f341:

  batman-adv: dat: ensure accessible eth_hdr proto field (2026-06-28 11:49:04 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260708

for you to fetch changes up to 98052bdaf6ac1639a63ffc10244eeeab1f62ed2b:

  batman-adv: dat: fix tie-break for candidate selection (2026-07-06 07:18:59 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes, all by Sven Eckelmann:

 - ensure minimal ethernet header on TX

 - fix VLAN priority offset

 - clean untagged VLAN on netdev registration failure

 - tt: avoid request storms during pending request

 - tt: prevent TVLV OOB check overflow

 - frag: free unfragmentable packet

 - frag: fix primary_if leak on failed linearization

 - mcast: avoid OOB read of num_dests header

 - dat: fix tie-break for candidate selection

----------------------------------------------------------------
Sven Eckelmann (9):
      batman-adv: ensure minimal ethernet header on TX
      batman-adv: fix VLAN priority offset
      batman-adv: clean untagged VLAN on netdev registration failure
      batman-adv: tt: avoid request storms during pending request
      batman-adv: tt: prevent TVLV OOB check overflow
      batman-adv: frag: free unfragmentable packet
      batman-adv: frag: fix primary_if leak on failed linearization
      batman-adv: mcast: avoid OOB read of num_dests header
      batman-adv: dat: fix tie-break for candidate selection

 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  8 +++++---
 net/batman-adv/main.c                  | 10 +++++++++-
 net/batman-adv/mesh-interface.c        | 16 +++++-----------
 net/batman-adv/mesh-interface.h        |  2 ++
 net/batman-adv/multicast_forw.c        |  7 +++----
 net/batman-adv/translation-table.c     |  5 +++--
 7 files changed, 28 insertions(+), 22 deletions(-)

