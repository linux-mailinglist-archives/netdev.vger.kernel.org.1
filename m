Return-Path: <netdev+bounces-296154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KNGdBkmEJGri7gEAu9opvQ
	(envelope-from <netdev+bounces-296154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EE64E47F
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:34:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="YRXnFU N";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296154-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 908A5303AADA
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224693C4563;
	Sat,  6 Jun 2026 20:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF843C343F;
	Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777649; cv=none; b=abD2o7LaGUh3lw4oqYmZGUyEqfk9q1AgejMVHLqH9qQUXl2DSiOip1o/LpDe6XzlRqkfJIRLaoKVgDEfw/wuCVizzd9W/eSFp+CUP5dsAKXe16ON7XG+s8pFXbYMDEAjta/DBci9bDc+98iElXfClDsxtrDxYESpAZndgaWeClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777649; c=relaxed/simple;
	bh=8WsZo2uD3Ic6JcqSST4DIWo7T0OLmGNFHElL2tGM7+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4Zjh+BxZBI309QBsFlvP4dRNW3SY55uhfaXMy6R/hFxZzoFNlMvb6J0EIYNT/7jp7H+lfLSLhFpJMDqKZg051xWQU+rhCyvpGpIndYgcVUyYNeQRrkgEWsXcHeIIemiAyvY5iKbf6P3kv+k0e+H12nJsU8J800rh5TlUXB3BK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=YRXnFUNn; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007NRE-KQ; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=/XypvNHBLtGuNNU4DGSzapBmyHJWYnckw+LASZ5j7ZM=; b=YRXnFU
	NnPncDO7bbgmK/rOMFDQIlzqLsujVSooP+wShnT3IF0FV8LTXX/SR0YLlBk8tj2tyzTbD/Zc0pDmQ
	wJnSu4nTIDx7nJ8eA+hzs1izuV1StYlmfO1Sq6xyIoHhyhBMcbeY84KXXCJQaivMU3C98tKpv4kTx
	C0Yzq6RTcxfv2S4Acg6blXEzJdix0RsCdKZ3rgiNOUChVyXenWPvVcbZh6qF/L/jXBfe5D+Yl8BJD
	yNTN965nv5cKcR2aTx9xECjuZQzvmZtVjmRo5P85uddTxj5CD4x50imZMGPqTBY2EvXf9VdXFEB0B
	AKUa5zP+/RpC4QvZaUgICc/83RtA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-0005Cy-4d; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbg-006V18-07;
	Sat, 06 Jun 2026 22:27:00 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/ef100_netdev: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:11 +0100
Message-Id: <20260606202633.5018-17-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296154-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:ecree.xilinx@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,redhat.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,runbox.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 127EE64E47F

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
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

 drivers/net/ethernet/sfc/ef100_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 3a06e3b1bd6b..f2309e79dab5 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -29,7 +29,7 @@
 
 static void ef100_update_name(struct efx_nic *efx)
 {
-	strcpy(efx->name, efx->net_dev->name);
+	strscpy(efx->name, efx->net_dev->name);
 }
 
 static int ef100_alloc_vis(struct efx_nic *efx, unsigned int *allocated_vis)
-- 
2.39.5


