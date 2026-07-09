Return-Path: <netdev+bounces-306388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sklIOPUuUGoHuwIAu9opvQ
	(envelope-from <netdev+bounces-306388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:29:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B641E7363E2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=VS0IFjVT;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306388-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306388-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CAE7302590F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7F3B5843;
	Thu,  9 Jul 2026 23:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF426E71F;
	Thu,  9 Jul 2026 23:29:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639793; cv=none; b=lD2EnfySFF46RBYdFh+LdR3D0yArfKszI56VvwzYCDH2472YW9HrB9GSLnci3xglcr8UVoSfDog0SsW+UYcEaVGeZ5wZPNZ70OkyF1FX6Jfp8N3HQWCjGwdQE+2zAhe6t3NPcJrXFlJ4+kXfD64C3VMC8lyextqZDiHTgLSJs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639793; c=relaxed/simple;
	bh=NKLIZegGU8Y1LkKHqZPoBeWjAUFqhf97ghB1/LdcwzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UUZZdwPX/zxzQgWGbxRP83KfQFFHKY8M5PwoxhWIr/7t4ikvraU50x/gkgSzDlGS5Qeit2Oc/iIS12XDPPJ6udJpR7a/BOrgDDkZsjgaF0kB8IWGx1D1nFOGmZzaYAaaArk8CI0xj61AmZlQISfnQJDrsI+UZkbcyLp9bfeIp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=VS0IFjVT; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3662560212;
	Thu,  9 Jul 2026 19:29:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783639784; bh=2RZl0wE492oUg2uWq2VVSw1AcEFcPDIBHPyT93/L2pc=;
	h=From:Subject:Date:To:Cc:From;
	b=VS0IFjVTdwc+dOuQy5WhWFERhKky1dxXtAGwElenQWNk8rWItVMgscwKFmmLtP4mF
	 ilg/bZW5NmFPnf9Ks1iWMre3LbCRgNAUhUhDl6lfDd04DDDOUiqCBlt9IegWAyO/Ms
	 LwNC+b2u7VJpAqlnZ0I5DcCujc13iDa19jC6Rl/1q4TR7nr5DSKDWCVrdnCC6amcTL
	 Pzjf3SP0UGXhd3XX3Xmmm6WN9dVkBld47PsRstpW+2EiDR/oSiTT7vBAhUWB6XAOo3
	 dDmuZD8vhUQwPdH4phy7j2slTEI/BMsOwhQ/LKoapHc7+MRhUnAV6VeC6tHr6bqYUR
	 Q3zPzp6HTZ/yw==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net v2 0/2] net: dsa: mv88e6xxx: 6141/6341 workarounds
Date: Fri, 10 Jul 2026 09:29:31 +1000
Message-Id: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsuUGoC/2WNyxKCIBSGX8U562gAkbBV79G4UDgkTV4GjLFxf
 PeQli3/67dBQO8wwLXYwGN0wU1jEvxUgO7b8YHEmaSBUy6p5IIMUSmUq2DEuhUDMUIrYeuqwk5
 DWs0ec5BGdxhxgeZnhnf3RL0cX0etd2GZ/CdzI8vljLjQ8g8RGaHEdqZsWWdVLavb3JrXWU8DN
 Pu+fwHm3qArxAAAAA==
X-Change-ID: 20260624-mv88e6x41-fixes-d4c84f955ebc
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783639779; l=1923;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=NKLIZegGU8Y1LkKHqZPoBeWjAUFqhf97ghB1/LdcwzE=;
 b=vgbdgJNOfqBigHAugTQAk0mfpV28x6tvoGtCwvwXt4eeM5MlRU8OIYepZvxIwJoyc1NK+n+FG
 zDDuKZ33ogJDcCErgAk6RkLyVVhJMW4D/AFmPVwx7Id9ZkCZq9Hh7sA
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306388-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
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
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B641E7363E2

This patch series addresses two issues I found with the 88E6341
switch, which likely also apply to the 88E6141 (which is the same
chip without AVB/TSN support).

The first was a genuine bug, which assumed the chip did not have
a dedicated ATU FID register (it does).

The other is an issue I noticed with hash collisions in the ATU
on the 6341 when using multiple FIDs. Different algorithms could
be selected using devlink, but the FDB was not flushed which
resulted in a corrupted FDB.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v2:
- Rather than special casing ATU hash algorithm for the 6341, simply
  ensure the ATU is flushed when changing it via devlink.
- Retartget net instead of net-next, as this is a bugfix
- Link to v1: https://patch.msgid.link/20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Vivien Didelot <vivien.didelot@gmail.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Luke Howard (2):
      net: dsa: mv88e6xxx: write the ATU FID register on 88E6141/88E6341
      net: dsa: mv88e6xxx: flush the ATU when the hash algorithm changes

 drivers/net/dsa/mv88e6xxx/chip.c        | 29 ++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        | 12 +++++++++---
 drivers/net/dsa/mv88e6xxx/devlink.c     |  6 ++++++
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  4 ++--
 4 files changed, 45 insertions(+), 6 deletions(-)
---
base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
change-id: 20260624-mv88e6x41-fixes-d4c84f955ebc

Best regards,
--  
Luke Howard <lukeh@padl.com>


