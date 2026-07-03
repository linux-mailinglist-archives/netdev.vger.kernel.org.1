Return-Path: <netdev+bounces-304378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6JvHO9bR2rCWwAAu9opvQ
	(envelope-from <netdev+bounces-304378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:51:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D97226FF381
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=eMcAuOHq;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304378-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304378-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED463028F54
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF173546C6;
	Fri,  3 Jul 2026 06:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51C274B5F;
	Fri,  3 Jul 2026 06:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061478; cv=none; b=e9xLhlbQz4mrPaE4n/en0/UvhJWMVHiCw4Gxm3pY/QRUZR2prNcwjbaGMkEK/hu4IcCFH7/BkatBqq+igUR9lj7F9Wl/vB2MmYcnvSJGaTyqim9w7sExMNKjD9tOO5AnFd9iR9SR7tEooWoZnI7AXrMgFGb3apSl7LKwRbKST6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061478; c=relaxed/simple;
	bh=r2Vn6gTQSBPsuGIzN60t6OHVGEZDkPdQZwODgNmS6Qw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A5kBjQxzY31YczACY23bliCf7xP7UxaptgrKozn/Dg0C/Sjt89YxOOWq+Rckb3JpeSJLbq+klszwS0EsK+XjiZtYPj3I//uiMMKSt31wcZ9km9PPqMvqwIcQg3BTmkHK+mD4kYUv0n5BKf8xNPKQLcrjsZPrpH7ZisseqP5nMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=eMcAuOHq; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id BCDE360C42;
	Fri,  3 Jul 2026 02:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060929; bh=mgESd7ft/+5vPI8gkcA0IJUnWwWpyJlxZQKiu7HNPBY=;
	h=From:Subject:Date:To:Cc:From;
	b=eMcAuOHqGdLFmxBnQGBjgNU4vOqj0TNvDAZyW3Ae36uvEqMuzBZxklNFeo6t+2UAu
	 3ROqRTE5S8VlF5ijx+Tfjk084cO1h3NIfWdg4B1c4yIVm9vMLtdYcpNGYwPsKcylBl
	 ObrhWG8eYwMGDld9re1syS6ndbgirIRsCx8nuL5DxIQyyyOGOntxu0PzOoYQfmBRDv
	 yHtqDGIjSSbyIud/REJImS4uX6TTVNRk5Pt8rfvguGf+2bwmKBxGqHSYiSgiEUjEGx
	 4psqFrgCSknRJ1gYf6RsEj+kFRjih9V6H1GnRTVwc5b1D5qLUgS+ElO9x6AMvwmCxl
	 xMaOsevWm4oMg==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: various hwstamp fixes
Date: Fri, 03 Jul 2026 16:41:57 +1000
Message-Id: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVZR2oC/yWMwQrCMBAFf6Xs2YU0xTT6K9KDbZ8awRiysSyU/
 ruxHodhZiVBDhA6NytlLEHCO1ZoDw1Nj2u8g8NcmayxzrjO8GvxHk5VOZXEt6AQbvvOHnszem9
 PVMuUsYsaXiiicIQWGv5GPuMTU/lNadu+tWwZD4EAAAA=
X-Change-ID: 20260630-mv88e6xxx-ptp-fixes-1732570b8829
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.deA>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060925; l=808;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=r2Vn6gTQSBPsuGIzN60t6OHVGEZDkPdQZwODgNmS6Qw=;
 b=zHVMElf2SkHw6cZj+dafCRCT4sq3QH9evezdDlwMkh0DxiNKb33g5nxEegoSILrOenxbEDqfW
 f+QDl6fTBJQC+cuITJwCoYUxy/04hBgWwrlyOoFusPMIvOhY1IaIJyw
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304378-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.deA,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.deA,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D97226FF381

Two fixes for improving the reliably of hardware timestamp acquisition
on Marvell switches. In our tests this eliminated missed timestamps in
ptp4l.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Luke Howard (2):
      net: dsa: mv88e6xxx: use ARRIVAL1 counter for all peer delay messages
      net: dsa: mv88e6xxx: embedded PTP timestamp support

 drivers/net/dsa/mv88e6xxx/chip.c     |   3 +
 drivers/net/dsa/mv88e6xxx/chip.h     |   8 +++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 132 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  14 ++++
 4 files changed, 144 insertions(+), 13 deletions(-)
---
base-commit: b8ea7da314c2efcb9c2f559ed65b7a36c869d68e
change-id: 20260630-mv88e6xxx-ptp-fixes-1732570b8829

Best regards,
--  
Luke Howard <lukeh@padl.com>


