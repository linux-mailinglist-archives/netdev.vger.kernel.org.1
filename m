Return-Path: <netdev+bounces-307615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WEW9IILGVmpRBAEAu9opvQ
	(envelope-from <netdev+bounces-307615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C164075970B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=EGRjZuak;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307615-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307615-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E48E6300407F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA36432E77;
	Tue, 14 Jul 2026 23:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9A27587D;
	Tue, 14 Jul 2026 23:29:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071801; cv=none; b=B+TNf7p5/T20RLy4hQYOinq9uHLB/Q28cbccL6QgCIpgeOKOxY8v7eL8OvMmiibEtlCSAut3mw8w0PMqaqqbzjQXP+E9m1QEoHtudq3LAe0f1M68RSBWHtbXsjTg+8TJBxVgE2dVOtNgQqD0kbRhwm4UExrxUCWTKKKPJjj6WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071801; c=relaxed/simple;
	bh=7W5eT1xRMe+lQAlx3S2PGPiMBpD92mBmI8WngHV9CmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d5oV3Co0TXarfrkjc/HPsTJW5G2DusEKuqEkIfcolD6+z+P8h+7cEONk01cAkx+FbDm2kLmH44Y85lZhU1u5Ou51tIcleFqXJTFqdW1S16JmgnB1nU5vSeJ6ba+X/XMJr83fotHj7ytkAHRguB9/IFpbVJw9ndx3wM6yqFwjkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=EGRjZuak; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 7918E601D1;
	Tue, 14 Jul 2026 19:29:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784071791; bh=mJ3eeMr2WabasbFGDNIC/lHqi3RhnkGb3IDzylOIyKg=;
	h=From:Subject:Date:To:Cc:From;
	b=EGRjZuak7f/y20V6SjK+Fq1yT6Cc9SmqyKw7jkBCRtohU8pNXtkWEYPFw4a4FZFSf
	 kSCP/JwWm8uH9/9jYK4Tr2k/lYUYiabQKWEGLpenAR/vEQJagSyd92tChJNk+gAf/Y
	 X2lv958TPbtfMyeBXXLgm8/G9LwQCBwKM0hgpDVHUGXqOgYVg73WQnDELJRfY24fk5
	 hUKtb69G6NRoNl8/eXyIif382Yf0RYZ0qhPWS/mf2zax3mH4gN5p8jvRsfhGyyl8iW
	 x8bg9ILbVzNlvtbpSSz9MJaI/DoaGrNzI+Jaah/JfDG9fIN/rD5MXIhZ8qd2Pf8N6d
	 hjWuaUMIfZNRA==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net v3 0/3] net: dsa: mv88e6xxx: 6141/6341 workarounds
Date: Wed, 15 Jul 2026 09:29:40 +1000
Message-Id: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTGVmoC/2WNyw7CIBBFf6VhLQYoIHXlfxgXQKcWYx+BSmqa/
 rsUN026vDP33LOgAN5BQNdiQR6iC27oUyhPBbKt7p+AXZ0yYoRJIhnHXVQK5MwpbtwMAdfcKt5
 UQoCxKFGjh/xI0B31MKHH/xg+5gV22ra2WuvCNPhv9kaay1lxIeVBESkmuDF1qalpVCXFbdT1+
 2yHLo9HtsMpOeIs4cBKKbiVQmuyw9d1/QFmP/YUAwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784071787; l=2604;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=7W5eT1xRMe+lQAlx3S2PGPiMBpD92mBmI8WngHV9CmU=;
 b=qYA7b9gdCfSyuZU97Z6AEzCpo5K7h51IfGxr832vW3+cQjnXrkn8U8YnoDCvLA5rQR5CLMxJz
 XmVcF2YCxx7CPVVvr9/NqVcS/2T4YBkGGmWg/fJATn6PaAhoYfPIJui
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307615-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,padl.com:from_mime,padl.com:mid,padl.com:email,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C164075970B

This patch series addresses three issues I found with the 88E6341
switch, which likely also apply to the 88E6141 (which is the same
chip without AVB/TSN support).

The first was a genuine bug, which assumed the chip did not have
a dedicated ATU FID register (it does).

The second is an issue I noticed with hash collisions in the ATU
on the 6341 when using multiple FIDs. Different algorithms could
be selected using devlink, but the FDB was not flushed which
resulted in a corrupted FDB. (There is an outstanding question
as to whether this should only be allowed when all user ports
are administratively down; this is not addressed in this revision.)

The third is an issue (not originally included in the first two
revisions of this patch series) where flushing a FDB entry would
instead move it to port 3.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v3:
- Don't reorder mv88e6xxx_info to optimize alignment; just add
  atu_fid_reg
- Don't clip ATU Move ToPort delete sentinel (flushing learned
  FDB entries was broken)
- Link to v2: https://patch.msgid.link/20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com

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
Luke Howard (3):
      net: dsa: mv88e6xxx: write the ATU FID register on 88E6141/88E6341
      net: dsa: mv88e6xxx: flush the ATU when the hash algorithm changes
      net: dsa: mv88e6xxx: don't clip ATU Move ToPort delete sentinel

 drivers/net/dsa/mv88e6xxx/chip.c        | 29 ++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        |  5 +++++
 drivers/net/dsa/mv88e6xxx/devlink.c     |  6 ++++++
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 11 ++++++++---
 4 files changed, 47 insertions(+), 4 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260624-mv88e6x41-fixes-d4c84f955ebc

Best regards,
--  
Luke Howard <lukeh@padl.com>


