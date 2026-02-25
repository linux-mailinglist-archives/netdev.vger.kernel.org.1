Return-Path: <netdev+bounces-260825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHwTALC/nmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:24:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E6194E0B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F26BD30E316F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EB387379;
	Wed, 25 Feb 2026 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="nQDqls5e"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148D387575
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011007; cv=none; b=nkKnFRYm6XToSDmHFrhG7c9LevZ4gvO88FR6UToXq7GEY/YuaHZT0EFvfvbtOp7Ygh0lkHQ2z5C9RpM35G8SToumn7b/sVzysjU7F9/kjZ0IpaRCSnfZhSHPZuFYgxDKDTWmfpHjFKodY0lXWPRrZYcUFN7s9jIMSMCVcFOx9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011007; c=relaxed/simple;
	bh=bHJqadrpyBkAE/sw7rkPoWqJSQLj+OXSScZ7sLaMa5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4DByLI/85yf9P/cysN1o5n7DpHlM5VH/gvih+SH9/Ohkv4DvC3Am4L21tJgNFu1y9wFYB84usOOGNoS5HoOcnTkX4iUujZt5483UvD2FPoTPWrb/o258+pMgRVjJsqnrhnk1yFloPuKMvLB5/lp8VwWZYKjvpVjLCqeiGk7NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=nQDqls5e; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7128A4469;
	Wed, 25 Feb 2026 10:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772010999; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FLsZqW3nEfG9aKEh7gvYLDJ1scIluaWtEy6CAIMSOxk=;
	b=nQDqls5e62TnsaqSXoswgqZGpl1PwjlInagfXYnzMeZbso/8T1BOJNLJIKQgD3nHTSYPVa
	LDyHXrvZv94ticHgxrXxsxTY2UbtfbV9UyDyfIcmiz3Nl6Xa1jPDVvS05KK3GMk4ci+2oM
	faMIfKHECs1nBvuDfCOElZgbpy61vUjksa/wBvEfRR2Fn+Sy+P2EpCEzDU7+d36pWlFOo0
	uHi83t2fdq9EGqtP3Ld7BMlR4Ux9z3z14Ck/vXVGOAldIyly2l54Nfq8VTam/SM3pDbqsh
	kOFit+9F20yHkBCp8ptCKpsRppbJBNeSTOC7kisUBUQ9DJJksOwzEoQfDsxDRA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 5/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Wed, 25 Feb 2026 10:15:58 +0100
Message-Id: <20260225091558.51157-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225091558.51157-1-nb@tipi-net.de>
References: <20260225091558.51157-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-260825-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 679E6194E0B
X-Rspamd-Action: no action

Enable IEEE 802.3az Energy Efficient Ethernet on the Raspberry Pi 5's
RP1 southbridge by adding MACB_CAPS_EEE to its platform config.

The RP1 contains a Cadence GEM_GXL MAC (revision 0x00070109) paired
with a Broadcom BCM54213PE PHY, both of which support EEE at
1000BASE-T and 100BASE-TX.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 37a5b866e3a5..7fe7e5338a2e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5517,7 +5517,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.51.0


