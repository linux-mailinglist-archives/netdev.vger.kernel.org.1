Return-Path: <netdev+bounces-306204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HGd2DdSPT2rqjgIAu9opvQ
	(envelope-from <netdev+bounces-306204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94910730D98
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306204-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306204-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78E1F3060263
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81342980C;
	Thu,  9 Jul 2026 12:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AB4279FE
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:01:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598513; cv=none; b=DiGoAPOKgyVXSINxpMM7pj58gHwN0cklBo9t6PQ+NYvbau7b2mdW5eMDyT/0EBDrnJAMKjWn5sXuxj1CXvOCkEl6GQgO6LE72oewsLOW+DkI3Zo0YduDpHW8+9f3snwK4obXlN1tRP2sge8SGuKwca535upnd9UnZpv2rJeeLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598513; c=relaxed/simple;
	bh=YaftiL5RUxufmRXVLTK7iUc4Nc+XKY2chptq1eO62ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF3NZCwLBiH3fG6a25drNjyIA5BRE3HuUJoUW3RdSYH8kD1iYwVOHs5A/Iy5lVzlmyRG1VXYeVGwK8Ryl9hgu+uevb1BthHzJ0ju1uYwERlZnxcXDL5ph7RStA2URuzj4jDWzYU8RoaWtfbEZIeHIbnoVO6ZwhEkdteKyiuOV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC35761C1;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4850A779B5;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDiqEJGNT2pEWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 09 Jul 2026 12:01:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 net-next 7/7] net: usb: usbnet: remove outdated sanity check
Date: Thu,  9 Jul 2026 14:01:16 +0200
Message-ID: <20260709120116.1423033-7-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709120116.1423033-1-oneukum@suse.com>
References: <20260709120116.1423033-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306204-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manuelebner@mailbox.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94910730D98

The cdc state is now included as a proper member in the descriptor.
There is no point in checking whether it fits into the scratchpad
area. Just remove the check.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:

- added to address concern about maintainability

 drivers/net/usb/usbnet.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ce932c81382e..0347f6887222 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2457,9 +2457,6 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_driver		*driver = driver_of(intf);
 	struct usb_cdc_parsed_header header;
 
-	if (sizeof(dev->data) < sizeof(*info))
-		return -EDOM;
-
 	/* expect strict spec conformance for the descriptors, but
 	 * cope with firmware which stores them in the wrong place
 	 */
-- 
2.54.0


