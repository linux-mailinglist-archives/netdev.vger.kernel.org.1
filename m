Return-Path: <netdev+bounces-304807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwbqAO+pSmq8FgEAu9opvQ
	(envelope-from <netdev+bounces-304807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:01:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFE70AD56
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tillo.ch header.s=mail202603 header.b=WjvvEFc6;
	dmarc=pass (policy=quarantine) header.from=tillo.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304807-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304807-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16775300B46B
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D530DEDC;
	Sun,  5 Jul 2026 19:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4426288BA;
	Sun,  5 Jul 2026 19:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278053; cv=none; b=jQ8DMsfqoWpPf2y4VMkErWglSmg+n3MdCEtpqcCaVxFmbgJ5DsYnFeHFDh78WaLHD4FnPkxUWMhEnKDJJZa8Et7E5zj+rgp0n3P1IpBZWRKYklfEgRFDIldzEOPN1wx6dBZ3isQIVpXJ4c7UZqgV21v2pf+7nWGjNpGArfzkrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278053; c=relaxed/simple;
	bh=7KwFOJchovQ4DTB9hob9oakRZ0LaRD6itV5fUutdPVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLauv15IPdB+cKyeYSOHtdH5I9f80vHtXdV5HAaKU24gAgJcgHKwLtibay6PqVBQLfQh84jun9AzynnV1eGqTrjv/oWz6fCCuyoHlnlN3d6z3cWHzPRl1x2NlLMAnCpcdRM6yWJgq+qGbnVR+6O7tdt/k+YonYDyjEMbGXxtVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=WjvvEFc6; arc=none smtp.client-ip=31.3.128.54
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1783277683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cyl7PLNJDCrwAbTOOEXuua+rCNvPFYloTKA1aYf0D8=;
	b=WjvvEFc6ljbE3NQkomcn4RqRlxwJ2v2YhBt9qWftptGYbZc/zyUSAMTzihNHER8OnOo+PB
	SGhgo2bv0HkaoZbForM7m1rwCXI8Xwyvvzf/iH+Sadwoa9c8UGK2pOXncc9YeUkQwMtGzr
	lBen/4nMnbso0xQth3TxoA9q7o9tOGsvKDMOVbLFY9PDJ51ROl8t2QCbpmY+AwwXejFHeb
	223mabLpVhhrXNh8VIz+AVgE5Pr/6IHVis5IcR1TpEskJjMCGhI3kEfOZV95eDGS3AC9bu
	11Ft6qnhtceCAOovYAmuSUnp3u76PaBI/iph4UNtBqI+VCN4IdHKAb7JULNRhQ==
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net-next 2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
Date: Sun,  5 Jul 2026 20:54:39 +0200
Message-ID: <20260705185440.136496-3-tillo@tillo.ch>
In-Reply-To: <20260705185440.136496-1-tillo@tillo.ch>
References: <20260705185440.136496-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tillo.ch,quarantine];
	R_DKIM_ALLOW(-0.20)[tillo.ch:s=mail202603];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,tillo.ch];
	TAGGED_FROM(0.00)[bounces-304807-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:tillo@tillo.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tillo@tillo.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tillo@tillo.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tillo.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tillo.ch:from_mime,tillo.ch:email,tillo.ch:mid,tillo.ch:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49BFE70AD56

Cheap XGS-PON ONT sticks identifying as vendor "OEM", PN "XGSPONST2001"
have broken TX_FAULT and LOS indicators (driven by the ONU serial
passthrough wires) and need a longer T_START_UP than the SFF-8472
default. The Fiberstore XGS-SFP-ONT-MACI MAC-mode ONT stick has the
same ONT-class TX_FAULT/LOS wiring and startup behaviour. Apply the
existing sfp_fixup_potron handler to both, which masks both signals
and bumps T_START_UP to T_START_UP_BAD_GPON.

Both modules fail to space-pad the EEPROM vendor PN field past the
legitimate string as SFF-8472 mandates (the XGSPONST2001 fills it with
non-printable garbage), which defeats exact-length matching:
sfp_strlen() cannot trim the field, so a plain SFP_QUIRK_F entry would
silently never apply and the kernel would honor the spurious TX_FAULT
and eventually disable the module. Match both entries as prefixes
using SFP_QUIRK_F_PREFIX.

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
---
 drivers/net/phy/sfp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index e7ba642..eae0699 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -555,6 +555,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
+	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
+	// mask both signals and extend T_START_UP via the potron fixup. The
+	// EEPROM vendor PN field is not space-padded past the legitimate
+	// string, so match it as a prefix.
+	SFP_QUIRK_F_PREFIX("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
@@ -612,6 +619,14 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+
+	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
+	// LOS indicators and slow startup, just like potron. The EEPROM
+	// vendor PN field is filled with non-printable garbage past the
+	// legitimate string instead of space padding, so match it as a
+	// prefix.
+	SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron),
+
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
-- 
2.47.3


