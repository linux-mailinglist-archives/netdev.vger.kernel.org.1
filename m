Return-Path: <netdev+bounces-296456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yHOHIx+SJmqSYwIAu9opvQ
	(envelope-from <netdev+bounces-296456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:57:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A13654C90
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="HuHSGJ 1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296456-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68628301E813
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E23C3428;
	Mon,  8 Jun 2026 09:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEF3BB66C;
	Mon,  8 Jun 2026 09:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912552; cv=none; b=G8KjpnflBluG5PFaP9BuZRviWJDwMtrRhZvOzpkChl0C92b5K3NoHzIdIr6Z5LJ/30/oVXxA+jvDM3SRnNVCKiJYMCBjwWpbKH3/OmcHfzxFaxKwKnthbaruRSCSgVKJF+I66Cu3eEeCkWC33DJhOOjk+cvRBdR2OcvJZMDLtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912552; c=relaxed/simple;
	bh=ZOQ7ZWm+IVLSejJLe/JbhA3HzZujgn0s13fyAYpTg6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkdgCTEzPo1ErRlgF9euqPA1OsITVEy8/A2grvIMXwvN7cVVgEWLF/rGm2UjpAHqL3Jx7VgdKSWT3qg4IbsHIr8UjA9qcDa4aAHNXg0U20dRG20jmfTOS4C8GIeg+b2kgrwc669oqczIUJ+pVz+NOE5ee8jVLg6Q20D7Dk5cenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=HuHSGJ13; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhu-00BrES-AO; Mon, 08 Jun 2026 11:55:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=NUEglK/PcR5hVhVgEimvST8ok54VecaaKx4Mk0IYhWQ=; b=HuHSGJ
	136pkVOg0HXbODgoXHwHJYCD06uZ49ifzNIb5LMsa2mS7jlG6qBKDJhQfj9/zo1ksP820AuYQCTWT
	LSpy6sH1B7WMn3FhWuJeftVre6ZQcV0lKrRLEtAbNZgV4W8sGN6zFe95014EC1szMvuREo1JZYWro
	EJGJy6DigtSC2XpkrgYH3gillyXrhRYecWax7kIpO83FyTzwdzrhrkdKzcqfukf1akLw8Rqpf2PGz
	FtRk5LWxLVm8yz1yngkwikYMfNLBYTJd1UN6iXlOLLsWZOBIBs4la6a8yoNgfo1Ae1aVZxAAhGSPN
	DuykiKHQLbt+++wfU4DGQFdHIuZg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWht-0003ho-P4; Mon, 08 Jun 2026 11:55:45 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhZ-00Ag6G-Pw;
	Mon, 08 Jun 2026 11:55:25 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/falcon/ethtool: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:45 +0100
Message-Id: <20260608095523.2606-1-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:ecree.xilinx@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,redhat.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24A13654C90

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

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

 drivers/net/ethernet/sfc/falcon/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 3d81b3ca61e9..ef5a7117be5a 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -222,7 +222,7 @@ static void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
-			strcpy(unit_str, unit_format);
+			strscpy(unit_str, unit_format);
 		snprintf(test_str, sizeof(test_str), test_format, test_id);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
-- 
2.39.5


