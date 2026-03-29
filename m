Return-Path: <netdev+bounces-272980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHGROdR6yWlIyQUAu9opvQ
	(envelope-from <netdev+bounces-272980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B55353C1D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD52300462C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9EA1EF36E;
	Sun, 29 Mar 2026 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="Ucz1g4is"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6B219EB;
	Sun, 29 Mar 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811832; cv=none; b=ZmJ0Lm2+W44c3tavfCNcM83wiubJnI9GW8oUevmTRj+naY1hWczqrFRGvnGH5Jg16FDJde+HuLW7tbONoHgDYwWuGCkr/XlmSTxGkfMkpRUH7t5DE0gsLl1rhNN7tqXi0FWjCtv7UjrRwlYgUPSPkZTACZJ0bWXWev3CQ8CevjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811832; c=relaxed/simple;
	bh=iDguSZeDDg3K/rUzPfSTz34uIIU6lSSUQBvG2SUCra8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otcTwPP3t4BTd0gK0SI/qszbIdRbgESmRndF7/QD300q0tUnSq0TDk4XWcgDMdXixMs2/EIsC6CADNqKDt+hYoZPtldh49O2b2YxKiN7bQI3813xPZjzw6WzARtseFkaKCaVLHGGyhDOQyavd9J4d1l9SPpTw0y4K5hAEd7t/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=Ucz1g4is; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed471586a0ca7f531ffd8aba41.dip0.t-ipconnect.de [IPv6:2003:ed:4715:86a0:ca7f:531f:fd8a:ba41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id C34B640242;
	Sun, 29 Mar 2026 21:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1774811753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=urO0gciKGpIOPjd+7D68lJt9wPp29NDycNeCkBLbJcw=;
	b=Ucz1g4is2wHhaROEeucQ9UqJv6ZW1fjHv071uZfmwHs79ew/r4UqQAkUxwUf417rOv+yY8
	NXBxwqirNN7RnvQlm/aZaaUyCW8SwGCsAiyoElArIuHRQ1X+BV9Derztoqt7vHg3mSm0DW
	7al0RblMoofcdMfvreJPs7S6xN2xdjBDgPPsiG2o72EIYTP8Esre50KvHaXA3PbCOj+VfM
	W46YPAWR0O7tHZr5mAgCZWqABUrWyqMo1qF/M8rG8cUhViY0PeEq/xgYQnUISQja78CeFj
	JA7kkAurCzGkb+TXqgqa4GewB106z9HrvXyTZHLRgIpTRkJnVKWfn0RZnb8yEA==
From: Jan Hoffmann <jan@3e8.eu>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Hoffmann <jan@3e8.eu>
Subject: [PATCH net-next v2] net: sfp: add quirk for ZOERAX SFP-2.5G-T
Date: Sun, 29 Mar 2026 21:11:11 +0200
Message-ID: <20260329191304.720160-1-jan@3e8.eu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[3e8.eu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[3e8.eu:s=mail20211217];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272980-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[3e8.eu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,3e8.eu:dkim,3e8.eu:email,3e8.eu:mid]
X-Rspamd-Queue-Id: 42B55353C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a 2.5G copper module which appears to be based on a Motorcomm
YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
(I2C address 0x56 provides only read-only C22 access, and Rollball is
also not working).

The module does not report the correct extended compliance code for
2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:

  Identifier          : 0x03 (SFP)
  Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
  Connector           : 0x07 (LC)
  Transceiver codes   : 0x00 0x01 0x00 0x00 0x40 0x40 0x04 0x00 0x00
  Transceiver type    : FC: Multimode, 50um (M5)
  Encoding            : 0x05 (SONET Scrambled)
  BR Nominal          : 2500MBd

Despite this, the kernel still enables the correct 2500Base-X interface
mode. However, for the module to actually work, it is also necessary to
disable inband auto-negotiation.

Enable the existing "sfp_quirk_oem_2_5g" for this module, which handles
that and also sets the bit for 2500Base-T link mode.

Signed-off-by: Jan Hoffmann <jan@3e8.eu>
---
v2:
 - use "sfp_quirk_oem_2_5g" instead of "sfp_quirk_disable_autoneg"

 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5db841377199..0a455a2daccb 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -567,6 +567,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
+
+	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)
-- 
2.53.0


