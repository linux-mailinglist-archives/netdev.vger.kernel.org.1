Return-Path: <netdev+bounces-263441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKLxHYlYp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C71F7CAD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F05C83049322
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66A4F7980;
	Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYucdmN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9224DA55D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574827; cv=none; b=AZqOVY9MdwWwWzA4lhToyq1VnxFeaLBVXtUjmuN30HC2REwDkgRInVbGVj+2bhSk4rBA33z8fmFJajzjRVX8q1vFNLhOrzHfLEMDnUVW0cDn+9oCx2bZdwpswvZjoenbYOUJijiamfVw87AeTvwnqeJzYDV10lmBn6LFE2ktDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574827; c=relaxed/simple;
	bh=PuOFBYjDLshOhCboh5/JtLn8meqrz4cb1eodgALOJjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXaLzfJ3efPF1UuQzSum0fiAUhCEN6JEG+FEXvxkSnv+h8e11bBrf+pEUB6CSmKm5hiZHJsIwLe/jMuZSsRqlht/np0vZ8OpP0GWZS8SS9eScAat4xf/L/N2K07/a0xg5n3qWnBhB1f2bKBYRiRSS9t/578k4s05I57di5ImPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYucdmN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8A5C2BCAF;
	Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574827;
	bh=PuOFBYjDLshOhCboh5/JtLn8meqrz4cb1eodgALOJjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYucdmN4Yp+rX5/4CY79pUorWjLVFCzZTm5Q/0+4W2C616rrRr3S+NBidkKxBYbR2
	 kQDJF6yiqlm+yeXNQWD6qhaM+EcVCzWpcEVrHgeuVRVqDJxNItoLSW3/rNI4csVhuQ
	 OASU1IBaHI1pf8Jtj0fVgnpFC28rv+ohsuhsx9a9dvFnFupMYy7Ck2FxWNXE9of7Da
	 o6g9Lhc3bz5He57px5Xo0+a0fQAdqYuJVFYxbxtpTn+Ae2yDuJkzH7qg5mD8ebwo7z
	 MdIwbW9jO2Qa6paCXKIaQDF/QgX1koAkmxXIk8SGY+h2Zvn6VgimK58/oHoAfZguvO
	 s1griBpChirMg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com
Subject: [PATCH net 07/11] MAINTAINERS: replace Clark Wang with Frank Li for Freescale FEC
Date: Tue,  3 Mar 2026 13:53:07 -0800
Message-ID: <20260303215339.2333548-8-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A5C71F7CAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263441-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,lunn.ch:email,prolan.hu:email,nxp.com:email]
X-Rspamd-Action: no action

We have not seen tags from Clark for FEC in over 5 years.
He has some limited recent activity on the mailing list in other
NXP subsystems (stmmac, phy). Wei Fang and Shenwei Wang are active,
with decent review coverage (61%).

Frank Li has been reviewing code actively more recenty, let's
make it official.

Subsystem FREESCALE IMX / MXC FEC DRIVER
  Changes 57 / 92 (61%)
  Last activity: 2026-02-10
  Wei Fang <wei.fang@nxp.com>:
    Author 25eb3058eb70 2026-02-10 00:00:00 33
    Tags 25eb3058eb70 2026-02-10 00:00:00 61
  Shenwei Wang <shenwei.wang@nxp.com>:
    Author d466c16026e9 2025-09-14 00:00:00 6
    Tags d466c16026e9 2025-09-14 00:00:00 6
  Clark Wang <xiaoning.wang@nxp.com>:
  Top reviewers:
    [23]: Frank.Li@nxp.com
    [17]: andrew@lunn.ch
    [4]: csokas.bence@prolan.hu
    [3]: horms@kernel.org
    [2]: maxime.chevallier@bootlin.com
  INACTIVE MAINTAINER Clark Wang <xiaoning.wang@nxp.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: wei.fang@nxp.com
Cc: shenwei.wang@nxp.com
Cc: xiaoning.wang@nxp.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b2d0bfd3936..165147562e1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10169,8 +10169,8 @@ F:	drivers/i2c/busses/i2c-cpm.c
 
 FREESCALE IMX / MXC FEC DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
+R:	Frank Li <frank.li@nxp.com>
 R:	Shenwei Wang <shenwei.wang@nxp.com>
-R:	Clark Wang <xiaoning.wang@nxp.com>
 L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.53.0


