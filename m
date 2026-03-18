Return-Path: <netdev+bounces-268976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE/7BemDumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:52:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D02BA41B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F0513038D19
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351833A543E;
	Wed, 18 Mar 2026 10:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FA39F185
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831100; cv=none; b=CfHlFIhXjo/6DDLW89j4T4+9XM/5PedJpS2EyeDfkSjpceH1B64HVl43U8yeGUIVlKjwp1EfQegiUNTtygqwoIWn4A8k5CBHbyXGNllQKgbDNXOQFE8WneePpOYy3zD6YquRtXQSO//58GXfiOi40uEv1NBKk00htpmL5/lD+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831100; c=relaxed/simple;
	bh=Q3V//YbZg8/h/78beYdtoq1xUvbkhkNfZvyJd033Ag0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA8gRKP8GRglgViJ8Bsh7RdXyisfiLbmrLfK/y/NvF3BR9mDMoLAuwrB/SDX3R9sy2kM7sbGLSPYDUmwISrtzMbK9w5bDDociEQ3WgINSfPQ7CKu7Ecggl7c0KJn+LJZut0SHCXv1xNqm/rIMBRUikVqiYBzoIODi/V49lXwcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WL-F3; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-000tSR-0H;
	Wed, 18 Mar 2026 11:51:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-00000003RIm-01bL;
	Wed, 18 Mar 2026 11:51:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: David Jander <david@protonic.nl>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 4/7] ARM: dts: stm32: stm32mp15x-mecio1-io: Fix GPIO names typo
Date: Wed, 18 Mar 2026 11:51:20 +0100
Message-ID: <20260318105123.819807-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318105123.819807-1-o.rempel@pengutronix.de>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268976-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonic.nl:email,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: C67D02BA41B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Jander <david@protonic.nl>

The reset pins for the LPOUT lines were incorrectly prefixed with "GPOUT"
instead of "LPOUT" in the gpio-line-names array. Fix these typos so the
pin names consistently match the LPOUT0-4 signals they belong to.

Fixes: 8267753c891c ("ARM: dts: stm32: Add MECIO1 and MECT1S board variants")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
index f91b3d1f037b..e50e9ae085e8 100644
--- a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
@@ -185,14 +185,14 @@ &gpiod {
 &gpioe {
 	gpio-line-names = "HPOUT0_RESETN", "HPOUT1", "HPOUT1_ALERTN", "",
 			  "", "", "HPOUT1_RESETN",
-			  "LPOUT0", "LPOUT0_ALERTN", "GPOUT0_RESETN",
-			  "LPOUT1", "LPOUT1_ALERTN", "GPOUT1_RESETN",
-			  "LPOUT2", "LPOUT2_ALERTN", "GPOUT2_RESETN";
+			  "LPOUT0", "LPOUT0_ALERTN", "LPOUT0_RESETN",
+			  "LPOUT1", "LPOUT1_ALERTN", "LPOUT1_RESETN",
+			  "LPOUT2", "LPOUT2_ALERTN", "LPOUT2_RESETN";
 };
 
 &gpiof {
-	gpio-line-names = "LPOUT3", "LPOUT3_ALERTN", "GPOUT3_RESETN",
-			  "LPOUT4", "LPOUT4_ALERTN", "GPOUT4_RESETN",
+	gpio-line-names = "LPOUT3", "LPOUT3_ALERTN", "LPOUT3_RESETN",
+			  "LPOUT4", "LPOUT4_ALERTN", "LPOUT4_RESETN",
 			  "", "",
 			  "", "", "", "",
 			  "", "", "", "";
-- 
2.47.3


