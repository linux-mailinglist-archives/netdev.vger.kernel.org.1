Return-Path: <netdev+bounces-271653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HesOB0TxGmfwAQAu9opvQ
	(envelope-from <netdev+bounces-271653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:53:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E13296C8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17755307DAAA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EFE4014A4;
	Wed, 25 Mar 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdwSgWBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DD3F788E;
	Wed, 25 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456201; cv=none; b=lqK43kzza6X/OhznfjJmuLGpozkEGdY9DaCBj8vxjK/8CCJ3+YebcvzAEXJ/ofNNhRmQW1cQM5Kd7Rj0FX6Ec3XUVzYXxtgafOrJhm0wSFX5owwTXjf/rb8yf1PR+Zxe30qHJyZg/hw2taVIbRX6R/V+4P83nTFuMrLXdAiFSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456201; c=relaxed/simple;
	bh=8wFQT0scIZH4MoUOnJP+cg31O9j6k3cRCJbdld+VpGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8BXpFdrj4bhtlYnegqJI16sVdmET/0tu6YYKh0nfgaSkM0wOWvwlotHruJNsPmNlWJ0Z7Q5eoVpiOFGTOpPhMIOgz3debS7VR+cnqvDl5FLB5LxLpfv3dI4blyv9Uz69GzofdeOnZZqhvPZtB536XBZicuZ4rm/W24Zasg4teI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdwSgWBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB96C2BCB0;
	Wed, 25 Mar 2026 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456200;
	bh=8wFQT0scIZH4MoUOnJP+cg31O9j6k3cRCJbdld+VpGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdwSgWBvgGBOmPe+dNJnjV4t34qvmdH8AHx1XYdA1Sox/Wtcpp+9i/KQctVOBXmpD
	 SacGnBJkzucQTgg1Gf1TCv0ebJsC9+//YtyDQzoNWQyqPWHYfr0FqehCxftP3rCu9a
	 LW9VLTCbLs1/TXIpxPj9Dy23qzig5baukpNkMwflRSul4uNPCmuclrm+XHE70/8pNr
	 ezlRe5JeKeRE4qOaMCFKILuggxfhVJNbSyplXYQhsIZenQorCNS2Wu8cZiO60YSZzP
	 3OSdL7r7GsYMrrbOpGba+iJd5CTT8yRh4IZaFJBe7zuVTYJRTz9ZbfUdcbOlK+OnRH
	 DFK+t7oiuZCLw==
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
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 12/14] net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
Date: Wed, 25 Mar 2026 16:28:16 +0000
Message-ID: <20260325-compactly-glue-f426a2e68904@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NgI/Gdg2EZ/vK6ibYq/phTDUhc8w3AlLuS5OcuYYPjI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM3Fzpk1/ptRdej3Ppez2nwZR/kvS1cua0+1npH5e Xb2/Lh1HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZgI1wNGhoknijZ277QNEter ZUp1Ofvyizfb7ZDg159Nt59/sCs7LpuRoW1nnFzC89VR+jOW9P8PXe71b8Vq/f1HahsYb/72yFa bxAIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: E64E13296C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

DCFG1 (design config 1 register) carries a bit indicating whether User
I/O feature has been enabled or not. The MACB/GEM driver has a cap flag
indicating that HW has the feature disabled (default is enabled). Add
the missing connection between DCFG1 bit and MACB_CAPS_USRIO_DISABLED.

Indirect impact: avoid useless writel() on USERIO register; this is not
an important fix because USERIO is anyway read-only when feature is
disabled.

If for some reason a compatible sets USRIO_DISABLED but DCFG1 indicates
it is enabled, we still keep the disabled capability flag. This ensures
we don't break "cdns,np4-macb" that sets the flag from compatible match
data.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      | 2 ++
 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8e5305f9a7545..16527dbab875d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -524,6 +524,8 @@
 #define GEM_IRQCOR_SIZE				1
 #define GEM_DBWDEF_OFFSET			25
 #define GEM_DBWDEF_SIZE				3
+#define GEM_USERIO_OFFSET			9
+#define GEM_USERIO_SIZE				1
 #define GEM_NO_PCS_OFFSET			0
 #define GEM_NO_PCS_SIZE				1
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 58d89b9e2f08e..b9791bbbec8bf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4588,6 +4588,8 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
 		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
 			bp->caps |= MACB_CAPS_PCS;
+		if (!(dcfg & GEM_BIT(USERIO)))
+			bp->caps |= MACB_CAPS_USRIO_DISABLED;
 		dcfg = gem_readl(bp, DCFG12);
 		if (GEM_BFEXT(HIGH_SPEED, dcfg) == 1)
 			bp->caps |= MACB_CAPS_HIGH_SPEED;
-- 
2.53.0


