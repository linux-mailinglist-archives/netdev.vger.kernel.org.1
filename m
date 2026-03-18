Return-Path: <netdev+bounces-269125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQvF2vXumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049252BF96A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C5D8302FB07
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D43EDAA4;
	Wed, 18 Mar 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNfQrjyv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CA35F193;
	Wed, 18 Mar 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851899; cv=none; b=R9el/5C3U10MtKQM/vMNXXvTos9kZi/mvvYS3vc697Zw86xcSCcaK7flqNib6ijvnlb1x6pzQO61ujgN55LwLdRsaEk/d8umQxgLUU1mBmwd/dlCn5II39CW+Br+6Lu8K3Pm1E3vvAUrFBpV2HI4MKSD03NUyCLilpUwfiqfBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851899; c=relaxed/simple;
	bh=hLF9AXo3lnRxCyN0gi/H0Xuz7Ot4l/b2adjyOOaaEI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk7hdtaZquCMYMcprejHv1RZ6IitpF1yM7B2jeZ6vZKatX9FvAxfxIxRFYwkWUReqhPodfp7kj7kk7Zfa+pGzUDYxGtepEpnvjwLFG0v3a4Mt7Y1TKWBHhpYjoS0o7hkyyZApuxTE5dvs8rPv8NbQk3TRsMncLQs+VJt+yOj5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNfQrjyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C160CC19421;
	Wed, 18 Mar 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851899;
	bh=hLF9AXo3lnRxCyN0gi/H0Xuz7Ot4l/b2adjyOOaaEI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNfQrjyvgBvtGHNPRo0OANz7BA29qWKQlchsp/bqemK0aECOmY8tq4f+iS+a9PGR4
	 MwjTxo2T7qsCvgLRzBuxzrnpjjBRloM2x4D2hWjG2Yd1REMceziX2FblGMQUQ30e9s
	 2W3eApiKQz5bkB6NnzS2+nXXuR+GoGD02oqb4/Py9/2MdUXz220l6oxyZh2E6qbset
	 yvty6VkgxhEp/uRyNG4SoBe4trazcYpEq7R91YhL2OYXQvI1SUjWnMotOcCIkVo/m/
	 npSXFQWpnFEPYVuXO1gZua3TUxquUqyeMuSR0uTnPS6dWVAkfhlJnM+oHjMLATYumW
	 oNexBO0QQngSw==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v4 05/13] net: macb: np4 doesn't need a usrio pointer
Date: Wed, 18 Mar 2026 16:37:36 +0000
Message-ID: <20260318-quarters-idealism-e45402bd5fed@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=F9UBzeUId/kao0gPpAeZyIh8nfmZqgwg0AfcGoyheCk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlx8mCM8kYNLeVfI0Qs3X+bzM+wTKT9ctPqkXbrP6 181pX1XOkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRM1YM/2Prs0VOlm3T73gr 9kH07nV1/p/ZX6WXc5zUcJr35deUh4cY/sqvdHLptvRKmME+xeWxG090hMSfjWeOq2U804rcUb/ 1JTMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269125-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 049252BF96A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

USRIO is disabled on this platform, having a pointer to a usrio config
structure doesn't actually do anything other than look weird.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1f9e46cf7e1cb..414a8fa3f99d9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5349,7 +5349,6 @@ static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
-- 
2.51.0


