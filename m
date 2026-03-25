Return-Path: <netdev+bounces-271660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKQDInYVxGlAwQQAu9opvQ
	(envelope-from <netdev+bounces-271660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:03:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C183298CA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EBB530148AF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92C3FAE0E;
	Wed, 25 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="jphyO3UC"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12E3C661A;
	Wed, 25 Mar 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457449; cv=none; b=KLKRuYa85vVlTt3TrtIZOCfAlEY9cNbOeMs26G3z4kZrShyq2lR8mKUR7h6pJCF+mrvTiGaWf+VELJJN99sHm52YYCDydOXZF9xK//AnIbEY0SxyQy7xO1tzc9ppT8VoU4h98VrviUMAZFqDaSMeCeLGU32rXiFM8CpDe9n9cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457449; c=relaxed/simple;
	bh=/J3VTTHDV7gm+KiMpeuYjd85uL9tISLNLi2tM0ly8kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmKvzmxknYPkCxznozLxNLZYiX9Vx1AScWG5AkXtZqNTzwhe7Ss2WmxGl155IZ+AiLRioKE0zZoE3zTQqxx91vp3VkTWuUq9DnJow2UtCySqgVbvsw8EA+I1hSj2pgV+1MjZkc9BiCGEW9vYPADHg+pA64jmULck8ZdzE+e0KSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=jphyO3UC; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed4701bfa09bcb9dcee3f7b116.dip0.t-ipconnect.de [IPv6:2003:ed:4701:bfa0:9bcb:9dce:e3f7:b116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id 2BC504016A;
	Wed, 25 Mar 2026 17:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1774456876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9r421GwLqbjrvPuOfTygpT5A8GyPUPozP8aliP/oWI=;
	b=jphyO3UCsBCaWa2hZ6JAJGfMwtVSXYtG4PdIFE7AvJAHLPkwvub+5r12gx1UjU3MNLYdwy
	uTJ/hM9yUERlSa7U8jdnoCvV5p2otd1YKxtYxR7/YOPIy223oLAqosCDKXmaNk3jXFwo7W
	FRsqaanm/3puG8MvBWLq5oNr24R/Jt+kMdcfxIjsS3Spj/rm1pCIIJo1gW8UmIEFlXjxcX
	y/rukJFuQDG2lVRjhnJdPFpZlqI/5538xSlWwlQP0ZrxlYDpxclDJIQyjeFSFglhSYsvWY
	NM07kVc06GSzHzVtUACcDncHZsDkSh/Skk9onav0peGFYJ5pT9kVcGMvr1CTIw==
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
Subject: [PATCH net-next] net: sfp: add quirk for ZOERAX SFP-2.5G-T
Date: Wed, 25 Mar 2026 17:35:58 +0100
Message-ID: <20260325164034.1542787-1-jan@3e8.eu>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271660-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[3e8.eu:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9C183298CA
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

Despite this, the kernel still sets 2500Base-X as interface mode based
on the (incorrect) nominal signaling rate.

However, it is also necessary to disable auto-negotiation for the module
to actually work. Thus, create a SFP quirk to do this.

Signed-off-by: Jan Hoffmann <jan@3e8.eu>
---
Note: I'm not quite sure "sfp_quirk_disable_autoneg" is enough here, or
if it would be appropriate to use the full "sfp_quirk_oem_2_5g" quirk
due to the not really correct compliance code / nominal signaling rate.

 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5db841377199..2e2fad79b221 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -567,6 +567,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
+
+	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_disable_autoneg),
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)
-- 
2.53.0


