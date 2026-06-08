Return-Path: <netdev+bounces-296734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ghf2GJ40J2o0tQIAu9opvQ
	(envelope-from <netdev+bounces-296734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF465AAE2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="n0/DAp 8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296734-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 515993022E32
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF23ACA7F;
	Mon,  8 Jun 2026 21:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAB26AE5;
	Mon,  8 Jun 2026 21:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954267; cv=none; b=Kvr5QEXuNvDrAR07Srj/kQUhqLsjbh5WHIT/tbDRoDnfXQwXMnlnWBZSfrPb05wV5Kv14Ro0FEcoUnXMqNWvTwiVrREKXySihxEiO/SdU50o7ya8TXaAT6hZapIUvf+UwK/MrC9qssfI6ewTcZEPnWfebhpqFr/lxPtAAPhyOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954267; c=relaxed/simple;
	bh=X9OSzZe8q9NDMLj+Me6B8O65fYIfYSYHSQjZUs1Itzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQblDrktsG/93DkQmH1i7xO4SFPVVv0D1jSXmAvCD/u1BEkAo9v3Xjmk8EFI8VsHfjx9QQOsiHkE3hU8ebpgfxmhX1sb0LqL+qTZBgfx4yvL0mrlYVffqJQW4ioHltVe/dKt2V35fWjJHWV2ZLQMquNITRRgN0jggtirqQgmUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=n0/DAp8B; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWhYi-00DJ52-1p; Mon, 08 Jun 2026 23:31:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=NmiKciKHXv4C9xD9HOuVDqRWiEHYVQXSczgOsSWg0yc=; b=n0/DAp
	8BDzh/OSrSSdhdRhuKkl+RzAHJ2wZedQgiod1Z/alKM50Rsie8euceqCEUFSNHEqNT0C3FXJqfhLH
	Q2SRwEq7hoUvMcq/vMH+7T4eMRSUb0b5Zsp8qJymAZgikrohXS5ZbB5ghIBG4SSAKyDHjLu8Nigl6
	RAzHmDvVLYRw4TLPNVU3f4n3QDWxlyWFB8g50Jn/dlIB2/qgFKVU2yjt2uOM+d5lKamVcS4OMz0vp
	oAw73Y8U7WlXW6EvC5TXbVstywJZROLOUHPDg/DJNl2oLRi9WYmz6jfQG1eq1k5Im6D7HAATiULVs
	w57AwER9k6glU5t98AxvU6BbRrVg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWhYh-0001RU-Hh; Mon, 08 Jun 2026 23:30:59 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWhYW-00BuhU-Bn;
	Mon, 08 Jun 2026 23:30:48 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 net-next] drivers/net/bonding: User strscpy() to copy device name
Date: Mon,  8 Jun 2026 22:30:42 +0100
Message-Id: <20260608213042.25563-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296734-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,jvosburgh.net,redhat.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[runbox.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,runbox.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9DF465AAE2

Replace the potentially unbounded strcpy() with the safer strscpy().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v2: Merge the patches for bond_main.c and bond_options together.

This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/bonding/bond_main.c    | 2 +-
 drivers/net/bonding/bond_options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletion.(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index af82a3df2c5d..76ca61cad875 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1792,7 +1792,7 @@ static void bond_fill_ifbond(struct bonding *bond, struct ifbond *info)
 
 static void bond_fill_ifslave(struct slave *slave, struct ifslave *info)
 {
-	strcpy(info->slave_name, slave->dev->name);
+	strscpy(info->slave_name, slave->dev->name);
 	info->link = slave->link;
 	info->state = bond_slave_state(slave);
 	info->link_failure_count = slave->link_failure_count;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a..c57b7d6af043 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1525,7 +1525,7 @@ static int bond_option_primary_set(struct bonding *bond,
                if (strncmp(slave->dev->name, primary, IFNAMSIZ) == 0) {
                        slave_dbg(bond->dev, slave->dev, "Setting as primary slave\n");
                        rcu_assign_pointer(bond->primary_slave, slave);
-                       strcpy(bond->params.primary, slave->dev->name);
+                       strscpy(bond->params.primary, slave->dev->name);
                        bond->force_primary = true;
                        bond_select_active_slave(bond);
                        goto out;
--
2.39.5


