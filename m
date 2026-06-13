Return-Path: <netdev+bounces-299030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vnuhFHa5LWprjAQAu9opvQ
	(envelope-from <netdev+bounces-299030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1467F977
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="C4CkPV/8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299030-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299030-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B66B83025E54
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F439657B;
	Sat, 13 Jun 2026 20:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DB3921D0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381445; cv=none; b=Eme3Y18eYp+97knz045gjMV/w2zTGa2IFkioKDZG4Qw/E4fiHlgtZgTcPFmO7OpGcDB7Fk1l8yq4iFp3eZoj7TBbXzrNMG66s7CP4wGf7yNGzfCn74SmJjEbgslnxg1Dl5ZfZwuPg/E9w8RmCoUw+r6SQfQftQJbGuvVY3qum9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381445; c=relaxed/simple;
	bh=vagjNGdyl9oInZTCnF6670xCfjcQJLjN2tge5WycSOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPiGwSGQpl6sMYQDYjtmL3h+4XU9IOCn/EhyrtaKbi5LgihXUF4R8QZGWa4wrTX4sOXJqj82APsgiyPupmC3hHSliAB956q5YAi69y+VlroILfnXfNbC82ek7XinSexJWK4PojlqcTU7gAocC4bSPwr4h5hsXvci4G582E3sh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4CkPV/8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43061F00A3E;
	Sat, 13 Jun 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381444;
	bh=JWSoMeIzBgrAKi8MVH4TkcJoLoP6HwP9YPHAZ+d3OCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4CkPV/8b3PjNhHZWNgfEeDLJjRgagKhOUJPKxAiWRC+elBa6M9Jz9aIuGv8DpbH1
	 ny5LLTYUKbrcXW9Whz8ra56+UYuHS7wq9vD9oSu9C00ja7EWZjGJirK1xsAphZGAPa
	 Pg8kRmtmndhEa34Jd+/LdlZLCcC0R3q+sA88m/VnBPLKrhoz5t7YcGnZ/2Sqfb/0ht
	 sxjBu39Kd/Cw3bl/ghiQ5AFi3ohVlh5TQrFlDdvQeUKAV0iaInyyRea36FzcCjXNPf
	 VkU8L3jn5EXLfGdw8GeCT21/HckHKmDpZueGiGuHgA6p6AsCk6niFx07+fmm9AyEot
	 /3NHr8Pqt/VOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/9] atm: remove dead SONET PHY ioctls
Date: Sat, 13 Jun 2026 13:10:26 -0700
Message-ID: <20260613201032.77274-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299030-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBA1467F977

The SONET_* ioctls are SONET/SDH PHY controls that atm_dev_ioctl() and
the compat path only ever forwarded to the driver's ->ioctl() handler.
The PHY drivers that implemented them (the S/UNI library and the framers
on the removed PCI/SBUS adapters) are gone, and neither surviving driver
services them: solos-pci has no ->ioctl, and usbatm handles only
ATM_QUERYLOOP. They now uniformly return an error regardless.

Drop the SONET compat passthrough and the SONET cases in atm_dev_ioctl(),
along with the now-unused linux/sonet.h includes. The SONET_* uAPI
definitions are untouched.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/atm/ioctl.c     | 13 -------------
 net/atm/resources.c |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 0f3f9ad8301f..4f2d185bf2f0 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -13,7 +13,6 @@
 #include <linux/atmdev.h>
 #include <linux/atmarp.h>	/* manifest constants */
 #include <linux/capability.h>
-#include <linux/sonet.h>	/* for ioctls */
 #include <linux/atmsvc.h>
 #include <linux/mutex.h>
 #include <asm/ioctls.h>
@@ -290,18 +289,6 @@ static int do_atm_ioctl(struct socket *sock, unsigned int cmd32,
 	int i;
 	unsigned int cmd = 0;
 
-	switch (cmd32) {
-	case SONET_GETSTAT:
-	case SONET_GETSTATZ:
-	case SONET_GETDIAG:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
-	case SONET_GETFRAMING:
-	case SONET_GETFRSENSE:
-		return do_atmif_sioc(sock, cmd32, arg);
-	}
-
 	for (i = 0; i < NR_ATM_IOCTL; i++) {
 		if (cmd32 == atm_ioctl_map[i].cmd32) {
 			cmd = atm_ioctl_map[i].cmd;
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 939452a610c0..7aac25e917b4 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -13,7 +13,6 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/atmdev.h>
-#include <linux/sonet.h>
 #include <linux/kernel.h> /* for barrier */
 #include <linux/module.h>
 #include <linux/bitops.h>
@@ -361,10 +360,6 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 		}
 		fallthrough;
 	case ATM_SETCIRANGE:
-	case SONET_GETSTATZ:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
 		if (!capable(CAP_NET_ADMIN)) {
 			error = -EPERM;
 			goto done;
-- 
2.54.0


