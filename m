Return-Path: <netdev+bounces-297270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27lDG69zKGq6EwMAu9opvQ
	(envelope-from <netdev+bounces-297270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:12:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30AD664090
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g22nnqto;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297270-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C6F301D31B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03F3749F5;
	Tue,  9 Jun 2026 20:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516336680C;
	Tue,  9 Jun 2026 20:12:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035948; cv=none; b=mUr/VdNgWNA9iglAorb4V0HXjWk8CClBaieLAXM4KcZLUWYsz/sz8U5FEqNcySHGqe3dJ/hglLLVW/aEExm8lR5zr7f+ep0NGlaWgXakuQUBOrsOGbtOhm4WpIYHgiHO0ujAs+Dtdwlp3bvR78tj8xfUwknwq5Ry9dTKnrbn/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035948; c=relaxed/simple;
	bh=Atyu/7pLp9nLA3fbR0DTc7/trd1D5Mix0uq3yK/JY1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap2tvQNUZXrF/aa3TjqCq1yOoBnBNWMD8nI+d4iyoAewvx85FBEelycdsLdViC2pUNCgcHdKsJutMqIlZMS+OKvx3SJ+SpgxShr+chvr4lKQdRpQClozMqD0DEgzfdLr8RXjpB53KCdwL8athin05h3mEQLvhxYReJJXLIYfcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g22nnqto; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D856B1F00893;
	Tue,  9 Jun 2026 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035947;
	bh=emWf4agjYWuWZV+h8FdWLJQebR+n3UTCVhIW+1ZyukI=;
	h=From:To:Cc:Subject:Date;
	b=g22nnqtou1sbm5A0gVcZ+Wk1+ftAm941psaVn/UDeVLl3TIJIQ2Fcr/OGqK5kkb9B
	 mGhyWjjckWG1oceWoGYpYK0RWtxgxmHzAnggFDHXvn7opGwB0qmuoxwyC9GWvDwWf6
	 V4jGROWKkvyoGoKRikYOoka2PAhQRU1c7TSas4nYfKpeD0HoGArZUAD423zPmd2FX2
	 WcFq1Xz/rjPUHxIcSR8bx2JKmKnwdK9+28abA0YX3UADRyTwaku1inOhnaJ4bNkTPW
	 w/laJAElTr8mbpViN3L8YqSH/TSunHGurDih4dRqj4vGrd1fstFm2deozRLvUIXyx6
	 VNkwQPmEnfvQg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] docs: net: more adjustments to docs
Date: Tue,  9 Jun 2026 13:12:21 -0700
Message-ID: <20260609201224.1191391-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297270-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D30AD664090

A few small updates to the docs. Mostly typos this time.
This is trying to prepare docs for getting fed directly
into AI reviews.

Jakub Kicinski (3):
  docs: net: fix minor issues with XDP metadata docs
  docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and
    rekey
  docs: net: fix minor issues with devlink docs

 .../networking/devlink/devlink-health.rst     | 12 +++++---
 .../networking/devlink/devlink-params.rst     |  2 +-
 .../networking/devlink/devlink-port.rst       |  5 +++-
 .../networking/devlink/devlink-trap.rst       |  8 +++--
 Documentation/networking/devlink/index.rst    | 10 +++----
 Documentation/networking/tls-offload.rst      | 29 ++++++++++++++++++
 Documentation/networking/xdp-rx-metadata.rst  |  2 +-
 Documentation/networking/xsk-tx-metadata.rst  | 30 ++++++++++---------
 8 files changed, 69 insertions(+), 29 deletions(-)

-- 
2.54.0


