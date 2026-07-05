Return-Path: <netdev+bounces-304808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uLcjLiqqSmrGFgEAu9opvQ
	(envelope-from <netdev+bounces-304808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:02:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27F70AD68
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tillo.ch header.s=mail202603 header.b="l/hxzEAH";
	dmarc=pass (policy=quarantine) header.from=tillo.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304808-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304808-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF813000FE0
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D83A0E93;
	Sun,  5 Jul 2026 19:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445A3EA66;
	Sun,  5 Jul 2026 19:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278054; cv=none; b=fKAfzThjyDy0NW+A8t8XH7v7g33vxM7LaUFwVr9QOvCLEwpupopFxzL7rofsC3h+tpEECPRtNDVMptBUEbLU+lpvctNFDt4g1nsT5sLdVxpDGSspyvjmwj++cfmwR25NpkAa5J3HB6KPWzXjOUKZINY0gERnkT+aJYhFMS7FkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278054; c=relaxed/simple;
	bh=duqXLDPQETQQ+U4fgvsQIJ496Fi9642hU+8ipHBbK4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPeedJV+T557Ezcm7S7FNNe917XwS1ujU0qylNlFacRhZzyovDkJ/ktqoweuDrrzrLah0oO3X7rRIDAYDUN0TV3q7qOzEjNv2M0+mqwLfXlKnWmumIyJBGX30oT62JCbQ4RmirsnNsllUTND56cw8Oy6MoOCvdZr0tzXOQXQ0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=l/hxzEAH; arc=none smtp.client-ip=31.3.128.54
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1783277683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSbm9eb07lNpMQeGNDv+47Xz9cCa+fkEB+5vEXOugUc=;
	b=l/hxzEAHmdYokvb9tcSk5vIGuNVOle/glzII3RmdoQwMqW6dS1BsL+GYRB6DCGq1OC8wZM
	/TkZRgqJE82Q2F3H8bCsmalDtjdB1Oomzco/JRf4DIapbBpKJcBPCfx2MsJOWPzf0JG0JL
	mz/DQ8aOJXc+UU/OCcYEQR+4CcChVg/OZpO7nKbUV2jMYB93wWe91PZ+kP+Rb9EuX8/y1p
	x17FCXQUF+CbGUIEj12QS/FmQxKhN6ZzVFXR8DwN2hKXHq8LocoQZtyLCh9MNdmd6uyaeK
	zePbY73mmQ+Lo1X3p/L3gMs0Pw6HCzhE4iKRwl+Ash2E44qUYOgwHTK0YEq5kg==
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
Subject: [PATCH net-next 1/2] net: sfp: allow prefix matching in quirk lookup
Date: Sun,  5 Jul 2026 20:54:38 +0200
Message-ID: <20260705185440.136496-2-tillo@tillo.ch>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,tillo.ch];
	TAGGED_FROM(0.00)[bounces-304808-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tillo.ch:from_mime,tillo.ch:email,tillo.ch:mid,tillo.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F27F70AD68

Some clone SFP modules (notably XGS-PON ONT sticks) ship malformed
EEPROMs where the vendor PN field is filled with non-printable garbage
past the trailing legitimate characters instead of SFF-8472 mandated
space padding. The current sfp_match() requires an exact full-field
length match: sfp_strlen() returns 16 (no trailing spaces or NULs to
strip), but strlen() of the quirk string is shorter, so the length
comparison rejects the entry before strncmp() is even called and the
quirk silently never applies. The kernel then honors the module's
spurious TX_FAULT signal and the SFP state machine eventually disables
the module.

Add a prefix_match flag to struct sfp_quirk and a SFP_QUIRK_F_PREFIX
macro. When set, sfp_match() compares only strlen() leading bytes of
the quirk string, ignoring trailing field bytes. Existing exact-match
quirks are unaffected (prefix_match defaults to false via zero-init in
the existing SFP_QUIRK macros).

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
---
 drivers/net/phy/sfp.c | 22 +++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f520206..e7ba642 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -516,6 +516,13 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
 #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
 #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
+/* Like SFP_QUIRK_F, but matches as a prefix. Use for clone modules
+ * that fill EEPROM trailing bytes with garbage instead of the
+ * SFF-8472-mandated space padding, so sfp_strlen can't trim the
+ * field down to the legitimate length.
+ */
+#define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
+	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, .prefix_match = true }
 
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
@@ -626,13 +633,16 @@ static size_t sfp_strlen(const char *str, size_t maxlen)
 	return size;
 }
 
-static bool sfp_match(const char *qs, const char *str, size_t len)
+static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
 {
+	size_t qs_len;
+
 	if (!qs)
 		return true;
-	if (strlen(qs) != len)
+	qs_len = strlen(qs);
+	if (prefix ? qs_len > len : qs_len != len)
 		return false;
-	return !strncmp(qs, str, len);
+	return !strncmp(qs, str, qs_len);
 }
 
 static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
@@ -645,8 +655,10 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
 	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
 
 	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
-		if (sfp_match(q->vendor, id->base.vendor_name, vs) &&
-		    sfp_match(q->part, id->base.vendor_pn, ps))
+		if (sfp_match(q->vendor, id->base.vendor_name, vs,
+			      q->prefix_match) &&
+		    sfp_match(q->part, id->base.vendor_pn, ps,
+			      q->prefix_match))
 			return q;
 
 	return NULL;
diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index 879dff7..867e45e 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -12,6 +12,7 @@ struct sfp_quirk {
 	void (*support)(const struct sfp_eeprom_id *id,
 			struct sfp_module_caps *caps);
 	void (*fixup)(struct sfp *sfp);
+	bool prefix_match;
 };
 
 struct sfp_socket_ops {
-- 
2.47.3


