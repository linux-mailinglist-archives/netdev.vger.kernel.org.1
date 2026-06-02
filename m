Return-Path: <netdev+bounces-294253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W5DQFsXxHmqXZgAAu9opvQ
	(envelope-from <netdev+bounces-294253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D762F97C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:07:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=ZOh+40ab;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294253-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294253-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC766318590E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7A3F86FA;
	Tue,  2 Jun 2026 14:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD23EBF13;
	Tue,  2 Jun 2026 14:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410438; cv=none; b=eKwhynb+/cTJI3Tg8bDT8WUHmaTyBBcJwtAiq53Z/MAMq9iG0bbfKmt629et5A2VHweraR95W9yblVN83IIpiPCzoVl5cXnXitWY2A3aSzocWcfZ7PJMOzBXc7E5iGMOrTkoPbFc3cPID2X6mYxRKWpcMfRIskgx7I6XhKc7UmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410438; c=relaxed/simple;
	bh=bDYkJi3ddRJ16FAZTOQ+rlLCaLGjWXuhyci/Y3ITwzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kmHgGF+w8CN32cdjoGyoL1BTTH08a8xt4O1VBede5PpgME2K3zVgnUnvR/w7JFuCs94n53SsP14UhhcWL1b07ofoT7mEj84nlCXRPXzzEwGvqBOpwpEJSbgYce0kHtkNhsEO5Gon1l2Efjt3seqHBMQ2gehJ6884usRe3ZPT0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZOh+40ab; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=dGs2sYNZ19+EpURNMVUo5v10yx5mZoqltpICdZ/ZCo8=; b=ZOh+40ab+tk+R1pPbFkqGmB6U2
	ieKeJ2xgW71ZwZU9Z+Wjg4060l6ZubkAH24aQYRi6lGSXY5qWsZZYHQeKE9qB4IfiMqhoC90rnsYi
	Vdwk3aiOLr6Q8S6JQv72DllwMV0sWD9/m3MZKxSeT35166RnTnNN380Iw08ucxiky8pMrnqhj9iNv
	LxIxw5NGqWDPWKtR6w9AJ0934MDfOw10WE35sw9WYb8uCjWH4lXPH7qQmWO/U79FrjwqtnDhzbom5
	/8F4DmFYOZAOb0wvrBcz92q7ZShI2sXNwjGTnaSZe9iOYAlMOiLV+qzoQoAP4KMqUCRLW+gdiu9my
	MW/OQBlw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUQ5G-0031HU-0Q;
	Tue, 02 Jun 2026 14:27:10 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/3] netconsole: Fix reported problems
Date: Tue, 02 Jun 2026 07:26:56 -0700
Message-Id: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDoHmoC/yXMUQrCMBQEwKuE/W6gBFtKriJSbLrRJ/giSSyB0
 ruL+j0wOwqzsMCbHZmbFEkKb1xnEO5XvdHKCm/gejf2g5ussoakZY7S5oUxZc7PtNGGdQyR4cQ
 pDugMXplR2m8+Q1mtslVc/lLey4OhfmMcxwfRAZIahQAAAA==
X-Change-ID: 20260528-netcons_fix_before_move-cd6cfec4e8f5
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=leitao@debian.org;
 h=from:subject:message-id; bh=bDYkJi3ddRJ16FAZTOQ+rlLCaLGjWXuhyci/Y3ITwzA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqHug53Tv2c/smJycsNQ/sMld9aomCyIsFdf68b
 3LvwGe4GxGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCah7oOQAKCRA1o5Of/Hh3
 bbWsEACNlMsH+xDTPcUpaIn8ZGpWg9iAIRTQtDlWeyN9nJBNTT2xxwOWPQ+VDKs7z+82lgrtXQu
 Uj2G0GhhRfDIuYzGqh8tbIu3iPY05CKxQFVGy/d66eoP+d2wveA7CA8xdszGI8F1vmIH+jE+U1f
 y8AxcmTfdIymEsaQ36Dm8ERXFnaNSSyv8c+8+hsoPGkLgsQH88rjaBUjtWj4ypOwijNTpOFvBSV
 m+BvOHeN1AV8nTicUsyMLSswPp8W3A/jBT1DlejlQ8tgAGHdTgMcO4/VoI7NGtZ/sbjeDiPHffB
 zBfGSq9itmxjS/dgfXGMmX3SCcttx0d+LxkO53Vqb/vrNfqD+kN6vp6RSyGyEKMef13W6QidvRw
 nmJ8e0U66XYbBbqOpH/MNXcnZ183la97fePXMU/sPcLfDCjMY6GPLGDgS8KKxQVZcxYJF/Qd38S
 9fgfAePiexK/OrCzti8F0XUTToyvzhAUXZE0BaRb0KpvOo5Zj222RQXgnomXSSDQlBS7Z05AI+8
 Jqu9U+gJsNz3RGXjSGcU5HdxIwEadOCW2VWecnCXrlQd7E6YK5Tldbdl56vfn3nhMPHsQ938Tij
 11aTpdXZKa7et0eHyO8a5Lv0tIB9QW4S/P39d7FyPDLuxn0IshQIKb8Y9pMkU0tZyCR9g+wm3HR
 sEULdYDn7NprG/w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 961D762F97C

These are some of the issues that LLM reported to netconsole, and they
are being addressed here before big refactors.

I was doing some big refactors, and got some "pre-existent-issues"
during LLM review of the refactor, that make them hard to guarantee that
refactor is not introducing any bug, so, let's clean these pre-existent
bugs first, and then submit the refactor.

The issues fixed in this patchset were reported during the review of
https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/

Not all of them got fixed, but, those that were easy to reason about.

Why net-next and not 'net' tree.

Most of the functions that are being fixed here moved from netpoll to
netconsole, thus, fixing this on net will cause merge conflicts from
'net' to 'net-next', thus I decided to fix it on 'net-next', given we
are on 7.1-rc6 already. Sorry if that is not the right approach.

Changed from v1:
  * Change it from 'net' to 'net-next'.

---
Breno Leitao (3):
      netconsole: do not schedule skb pool refill from NMI
      netconsole: do not dequeue pooled skbs that cannot satisfy len
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()

 drivers/net/netconsole.c | 26 ++++++++++++++++++++++++--
 include/linux/netpoll.h  | 16 ++++++++++++++++
 net/core/netpoll.c       |  7 -------
 3 files changed, 40 insertions(+), 9 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260528-netcons_fix_before_move-cd6cfec4e8f5

Best regards,
-- 
Breno Leitao <leitao@debian.org>


