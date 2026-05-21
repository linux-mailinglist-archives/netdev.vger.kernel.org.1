Return-Path: <netdev+bounces-290240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHACKgyiDmpCAwYAu9opvQ
	(envelope-from <netdev+bounces-290240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087559F4F2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A00A303CFBB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB671386552;
	Thu, 21 May 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="p0LUN66t"
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE4384CF6;
	Thu, 21 May 2026 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343876; cv=pass; b=uBlP8dAKV+D+IA6+TEfX/GlPp8+JYWfrLg1tDDxA9OrnQPWCHL243DDRfEyvsuElnp9//DsagBitOQ4t9eTf6+PHAMgeMxDsVAYT4ZK6YEn5WVVzX7xakftJygTdMrF20K7rMH3Jvr6WcmQWaqnEs8lHhEYZ3YW6S8Zpb1ezqLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343876; c=relaxed/simple;
	bh=3/GDE0tBsuSbyzPc11LktqHFxXzHDMvK+cA/oTLLSHc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=OJz2ykRJ2BQeVNXePiGCKvi0l2QBUUBPeibdVXl+0PV2utpaU9Yu9uzJWkTEIqu+ft2pBGhnZSTxY7neuwj1+45dJW0N9W6PIwheCHMQOFM805YB1IrvmaztYZa5T7v8n1JeZhmWSC47pBvXnNkd/xYqbacciGcgftxe3M/U5gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=p0LUN66t; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1779343828; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=ZdoHJQqyT/sdSj+9pX3W7UlwLWq3pRWl4FJ+eU7sXyDcujetypKNZ94IBJF2Wk31sHh69irhf41TvF+x/PM8Lc/A60htlIwn0vL4ke6S62kEHpxH/6XA33Aq8am6A8YUzzx1sA3Q/OSRysQHgIhKn4rVU5GRYDOIMma1PVu3eq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779343828; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EQSpA4ZTPRnz9G9H3FIaLAkaSDGkNEul7L4Q8NT2ouo=; 
	b=NhvT0EqPM3n/EBW56byQG2gdbTZaX7ZPDIsET/RXXbPedE2VZX16O3hV8CtVbRQK8QbKGFc7a8rFPTlHniFvuh/07Xxkhy0+BMEFJWjdu/7NIOz0Ad9FNY+lpzLkmOmRAluVDpCEXHY6xZ2y2S6e2WT+96uSfGNibkDMsuRuCJ8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779343828;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EQSpA4ZTPRnz9G9H3FIaLAkaSDGkNEul7L4Q8NT2ouo=;
	b=p0LUN66tKJtnMqgbMoL3gcbNvX6Or5P1xY7lbeWoubjE5dyUK5IQshG+oRKzT97Q
	r9AqfLVIcKt8s42yb0da/rXqBED+Xvuqn0xcrdkxy/YIaKMxru5pG6UK1uLjwzg/w3v
	o5h13xDI3YzK+wIC1IxNo5u5DcsRxrLI3Aptl3SU=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779343819672847.3911387241204; Thu, 21 May 2026 11:40:19 +0530 (IST)
Received: from  [27.59.63.162] by mail.zoho.in
	with HTTP;Thu, 21 May 2026 11:40:19 +0530 (IST)
Date: Thu, 21 May 2026 11:40:19 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrewnetdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
In-Reply-To: 
Subject: [PATCH net-next] net: e100: replace silent 'hope for the best' with
 debug message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-290240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.in:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxuser509@zohomail.in,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.in:email,zohomail.in:mid,zohomail.in:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Queue-Id: 1087559F4F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sun, 10 May 2026 15:09:12 +0530
Subject: [PATCH] net: e100: replace silent 'hope for the best' with debug
 message

Replace a silent return with a debug message when no MII PHY is
detected on known variants. This gives users visibility into the
failure instead of silently hoping for the best.

Found by checkpatch.pl inspection.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9074b558de35..bfacf877ca40 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1450,7 +1450,9 @@ static int e100_phy_init(struct nic *nic)
 		 * But do this AFTER MII checking only, since this does
 		 * lookup of EEPROM values which may easily be unreliable. */
 		if (e100_phy_check_without_mii(nic))
-			return 0; /* simply return and hope for the best */
+                        netif_dbg(nic, probe, nic->netdev,
+                                  "No MII PHY detected, continuing anyway\n");
+                        return 0;
 		else {
 			/* for unknown cases log a fatal error */
 			netif_err(nic, hw, nic->netdev,
-- 
2.43.0

