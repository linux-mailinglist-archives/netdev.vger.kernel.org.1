Return-Path: <netdev+bounces-304835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XbmmJvw/S2r1OAEAu9opvQ
	(envelope-from <netdev+bounces-304835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:41:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8D70CAAE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gurudas.dev header.s=spacemail header.b=k2dVqGub;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304835-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304835-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDBA302836C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 05:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A903BED4A;
	Mon,  6 Jul 2026 05:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBF3812D0;
	Mon,  6 Jul 2026 05:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316324; cv=none; b=DbdJ9GKVI1tBiy6TNscYFxcyz+lwAKRcPsS9SCgSL9h+MwyP56VxiOMLr2W5XOtq1HmLDIu2MCEL9W+wmD60uZmxqv3PNyB80BpY30ntouhvsqKX8fK96R5JEyXLyYkIKczoaZJZy4cuFXgKGBHntq1fHe/KJS/AvseCiU3125s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316324; c=relaxed/simple;
	bh=IFp8KIfJQFaD5SxJ03pX/G7sKzcitokGMS85gqHLheo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Elh5mLFZJxVRlmJyTGvxP3Z71F5nFlKdOlpg52neywIeBJZiLvJXmg4Ep7weEiclJeOs7Hsr5JDCOMnO2oUwv50YLdMvp4+KOUmBpEv1p8vjIqWdTtJ2AxXvZbf/PLUxxmTTPE/ttro8iU1XV661dP9Q2zXWpOP1hyPr50EF+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=k2dVqGub; arc=none smtp.client-ip=63.250.43.88
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gttSc5tqrz8sWR;
	Mon, 06 Jul 2026 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783316322;
	bh=YIeQik7zWpB4jmw4IE+FSK27BQvQ/I/lwKnJtdpPOVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2dVqGubQeJZ/e19iWyC9GpO7M42DTeclfVQsXzV8z6tiazu50dAOpDe66lAlfIRY
	 j3/psXNvzyrq8HacTvSx2dHO6aI3hcM9vkNdI4CPocTmYhVRJbzJOhVj9tCyOBwCm9
	 VQXTsZsLCsWDuZugDRPBiGyzlwC6BxV+mC4r34bl+18cZ5Yt9MQ4GjZfLNBemXeBG/
	 t1oe0/ZAlXfxV+eaAvyhi0aLYhB6+7JNLtQRySqHZ3xBq9d2hveuL2Sz5jD76bgIDa
	 RE/xP9gr49zu001yR006hkfp9JDTF0D95vsogGjz8WIUTBDQVRzWG4y8dhdSoAQe/k
	 VdIPCLdmHo10Q==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 05 Jul 2026 22:38:40 -0700
Subject: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import style
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
In-Reply-To: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gurudas.dev:s=spacemail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux@gurudas.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,umich.edu,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[linux@gurudas.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[gurudas.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304835-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@gurudas.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gurudas.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gurudas.dev:from_mime,gurudas.dev:email,gurudas.dev:mid,gurudas.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCA8D70CAAE

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 2d24628a4e58..5a21fe09bd62 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,12 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    net::phy::{self, reg::C22, DeviceId, Driver},
+    net::phy::{
+        self,
+        reg::C22,
+        DeviceId,
+        Driver, //
+    },
     prelude::*,
     uapi,
 };

-- 
2.54.0


