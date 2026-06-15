Return-Path: <netdev+bounces-299578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /3j9DWVWMGoiRwUAu9opvQ
	(envelope-from <netdev+bounces-299578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A095968987D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="G2/cIqLH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EAA30F47C2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587293B27DF;
	Mon, 15 Jun 2026 19:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81D3AE193
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552661; cv=none; b=GNHBibtjNvXgIpg9V2pvMi8hJKAQCeR28XgFlvDas9JS6OS4yOuEDZIiruEgHydgwIlK8YbwkWpq6VD8w2NfeXIyYHN3Z2vgXcN1jCyEJ3ynlxVqo3FI3XmjvGGLm4bmYDG+xN5BLdMGBBMFQOn/Rn18P7D37Kgc8hwvu0yW6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552661; c=relaxed/simple;
	bh=8YSR6CFEUKgEVbak/RzJf66YHaU4HqZ018p3ZNUz3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi7jWPvak0uDlDYhMu7EVyRpPPMMN1oEmzwYqlQL84srpyaX7rU8RE2ql9MZ0i0yxGqF6P9QrvYhhgHXWj2E6NnIuEl3UaT6xe9rMwIz3d1A1BfN9Y84zGZfytFtRx44jyatfAyfXTw0sxige4vOsdBbp2RNw5cV+pXSmHJY1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2/cIqLH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D71F00A3A;
	Mon, 15 Jun 2026 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552660;
	bh=O0u0Y5M06QrMQh3ALmuEJ2zJI1febqpd9gcTIM54ds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2/cIqLHb3zV5nBK7e6sy5CZd13aAf5qGqXWH5X60AuATfmmj0Lwb2GLOM+tF+uPz
	 Vvbl6yqH+aYN83etvHQO1COgc2bYSV+uVsxdKHOSqq0ofA1jxheAe5+TuJYD4wdPi9
	 6yWTwngpykAJborG60AgsL+dQiQ6jx+C/Nz3dWqEJRfB6CZOCPReJ83vjyHyQ4F8H7
	 8qbQgM1MXavpPSyKH04WKYa5WsFZv9ZNOJn/i+DfmNwEyz0vC0Vc/jKR7GWZgSvZde
	 n90cNBKiwO6ff5R6S/H9Eo+3P4jVpRoTAdIlBIwPD75oC44n88GC2jpNuUSpEBFzH0
	 DqHj/45fpqMEQ==
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
Subject: [PATCH net-next v2 1/9] atm: remove AAL3/4 transport support
Date: Mon, 15 Jun 2026 12:44:08 -0700
Message-ID: <20260615194416.752559-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299578-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A095968987D

AAL3/4 is an obsolete connection-oriented ATM adaptation layer that has
seen no real use since the SMDS-era hardware it was designed for (90s?).
We are only maintaining ATM support in-tree to keep PPPoATM running,
and PPPoATM runs over AAL5.

Drop the "raw" AAL3/4 transport (atm_init_aal34()) and the ATM_AAL34
cases in the connect and traffic-parameter paths. A vcc_connect() with
qos.aal == ATM_AAL34 now fails with -EPROTOTYPE.

uAPI cleanup is performed later, separately.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/atm/protocols.h |  1 -
 net/atm/common.c    |  7 -------
 net/atm/raw.c       | 12 ------------
 3 files changed, 20 deletions(-)

diff --git a/net/atm/protocols.h b/net/atm/protocols.h
index 18d4d008bac3..30158efb5e1a 100644
--- a/net/atm/protocols.h
+++ b/net/atm/protocols.h
@@ -8,7 +8,6 @@
 #define NET_ATM_PROTOCOLS_H
 
 int atm_init_aal0(struct atm_vcc *vcc);	/* "raw" AAL0 */
-int atm_init_aal34(struct atm_vcc *vcc);/* "raw" AAL3/4 transport */
 int atm_init_aal5(struct atm_vcc *vcc);	/* "raw" AAL5 transport */
 
 #endif
diff --git a/net/atm/common.c b/net/atm/common.c
index 60132de4eebe..913f7e32ce41 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -293,9 +293,6 @@ static int adjust_tp(struct atm_trafprm *tp, unsigned char aal)
 	case ATM_AAL0:
 		max_sdu = ATM_CELL_SIZE-1;
 		break;
-	case ATM_AAL34:
-		max_sdu = ATM_MAX_AAL34_PDU;
-		break;
 	default:
 		pr_warn("AAL problems ... (%d)\n", aal);
 		fallthrough;
@@ -411,10 +408,6 @@ static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, short vpi,
 		error = atm_init_aal0(vcc);
 		vcc->stats = &dev->stats.aal0;
 		break;
-	case ATM_AAL34:
-		error = atm_init_aal34(vcc);
-		vcc->stats = &dev->stats.aal34;
-		break;
 	case ATM_NO_AAL:
 		/* ATM_AAL5 is also used in the "0 for default" case */
 		vcc->qos.aal = ATM_AAL5;
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 1e6511ec842c..0d36aeb3671b 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -68,18 +68,6 @@ int atm_init_aal0(struct atm_vcc *vcc)
 	return 0;
 }
 
-int atm_init_aal34(struct atm_vcc *vcc)
-{
-	vcc->push = atm_push_raw;
-	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
-	if (vcc->dev->ops->send_bh)
-		vcc->send = vcc->dev->ops->send_bh;
-	else
-		vcc->send = vcc->dev->ops->send;
-	return 0;
-}
-
 int atm_init_aal5(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
-- 
2.54.0


