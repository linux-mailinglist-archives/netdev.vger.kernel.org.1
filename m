Return-Path: <netdev+bounces-296315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fikcH3LoJWroNQIAu9opvQ
	(envelope-from <netdev+bounces-296315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8746651C32
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=POBeGCwd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296315-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F04302D5DA
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 21:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96A3385B2;
	Sun,  7 Jun 2026 21:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3E311C2F
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 21:51:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869119; cv=none; b=PGPKItKHkk+AmFChPYB0WFjM3gKtL/nnODnBWnBo36rgoFvd1M94CnsehlcyWvwAxYjX7M719XzpszuK8yRKOPnYRnoMT/z39tuqB2Tnh+IHhEwKWvSGpSVqBF4SetO5GkvtrLd5+XBST+gH1Y00hSTs7hE6JjAIQfGqvjsN8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869119; c=relaxed/simple;
	bh=NAaExrt/68p/yQk6XMbCccmj7nalUSJz9F0LPpYRe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7GfVzlFSBhONBytqHYxnnU6rSmLMh0i8aO2L5hMHNAY69J0Qhjjx6CZcgQO0JsjT+jraQ5kg7deFGOncZYZRWPGhItaHxEpEuin3Or4P2QvRfwXH1977HtLsMe4jsY+dEDdRqdAW8eGrf6pTwtqebkljawn+ilZrusNF1ap06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=POBeGCwd; arc=none smtp.client-ip=212.77.101.10
Received: (wp-smtpd smtp.wp.pl 7656 invoked from network); 7 Jun 2026 23:51:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1780869107; bh=Awa2x3oF60Kc91g0Y3ZUcvIEaXACBkCppfZxAnF2Cco=;
          h=From:To:Cc:Subject;
          b=POBeGCwd5jMvMAc/Vf2pN0yqTS7kaeXPWG70t0NUC+pfF15Je6UIVJHSK9eR0f7JP
           uBJm/8S9PuSJWQxCoQostosjLSEJDgGkMXUbzUZ8vfv0HK9okJd8ufEk1B27lBqyZl
           zAxqwkP8GemoGC1a7IbUAnWnPQ1elB21EqihHaZpY19lhkhBhSuivyv3Y4CdOkSrvI
           ueNanfcMXroVSEGTYjh/GqBCA+s2POOCwW86RB+4tWlWSeQmxCNxEqnjhSoBJs+Fmc
           sViknGsiDxqrmkN3XBa9yPOfC/WrVhCY/jDcaiNCp7XD5wAwLdWg0nWErVMFDIJamp
           BxgyIVBzE8cZg==
Received: from 83.24.121.144.ipv4.supernova.orange.pl (HELO abajkowski.home) (olek2@wp.pl@[83.24.121.144])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <netdev@vger.kernel.org>; 7 Jun 2026 23:51:47 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: netdev@vger.kernel.org,
	mkubecek@suse.cz
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next] qsfp: add support for newer SFF-8636 compliance codes
Date: Sun,  7 Jun 2026 23:51:39 +0200
Message-ID: <20260607215144.1642394-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: f2ca205b20edeba4e5f2881ab03a6cec
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0cO0]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:olek2@wp.pl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:mid,wp.pl:dkim,wp.pl:from_mime,wp.pl:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8746651C32

This change adds support for newer compliance codes defined in
SFF-8636.

Standards for SFF-8636
a) SFF_8636 Rev 2.12 dated Apr 29, 2026

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 qsfp.c | 6 ++++++
 qsfp.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/qsfp.c b/qsfp.c
index 09d9ace..55cd1fb 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -451,6 +451,10 @@ static void sff8636_show_transceiver(const struct sff8636_memory_map *map)
 		sprintf(value, "%s", "SONET: OC-48, short reach");
 
 	/* SAS/SATA Compliance Codes */
+	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_24G))
+		sprintf(value, "%s", "SAS 24.0G");
+	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_12G))
+		sprintf(value, "%s", "SAS 12.0G");
 	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_6G))
 		sprintf(value, "%s", "SAS 6.0G");
 	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_3G))
@@ -528,6 +532,8 @@ static void sff8636_show_transceiver(const struct sff8636_memory_map *map)
 		sprintf(value, "%s", "FC: 1600 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_400_MBPS)
 		sprintf(value, "%s", "FC: 400 MBytes/sec");
+	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_3200_MBPS)
+		sprintf(value, "%s", "FC: 3200 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_200_MBPS)
 		sprintf(value, "%s", "FC: 200 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_100_MBPS)
diff --git a/qsfp.h b/qsfp.h
index b899d4a..8d6bb97 100644
--- a/qsfp.h
+++ b/qsfp.h
@@ -217,6 +217,7 @@
 
 /* SAS/SATA Complaince Codes - 133 */
 #define	SFF8636_SAS_COMP_OFFSET		0x85
+#define	 SFF8636_SAS_24G			(1 << 7)
 #define	 SFF8636_SAS_12G			(1 << 6)
 #define	 SFF8636_SAS_6G				(1 << 5)
 #define	 SFF8636_SAS_3G				(1 << 4)
@@ -269,6 +270,7 @@
 #define	 SFF8636_FC_SPEED_800_MBPS		(1 << 6)
 #define	 SFF8636_FC_SPEED_1600_MBPS		(1 << 5)
 #define	 SFF8636_FC_SPEED_400_MBPS		(1 << 4)
+#define	 SFF8636_FC_SPEED_3200_MBPS		(1 << 3)
 #define	 SFF8636_FC_SPEED_200_MBPS		(1 << 2)
 #define	 SFF8636_FC_SPEED_100_MBPS		(1 << 0)
 
-- 
2.53.0


