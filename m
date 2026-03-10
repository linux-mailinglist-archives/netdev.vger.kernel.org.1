Return-Path: <netdev+bounces-266261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ld5KmVTsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:22:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E025579C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FFEC30E11D7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796A3D3CED;
	Tue, 10 Mar 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZOu3jbw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7B3D1702;
	Tue, 10 Mar 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163170; cv=none; b=r+8mh0kD0LxSnoJuat6d6YSlSUvUr5hMq0ouTdIUBBxqHrHPvzHQSR+DGRSSqretRLsh8WT4k4GctCvMin23stu256bzG8kNGRM9rXz6VJdyfTY+7WEExJhqi7tCMW51q6ETIJ+Of6Ez/e0OC8xlUfi8ulth1gumRC0mMu0hDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163170; c=relaxed/simple;
	bh=l0HWcNcVkVo9YLSrRqspDdP84/kdc2LHA5rpvVoVGqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxu5Sqv2gxkWoRg34JqBiJujXD5qg7+KmSAOXl0AQVNzNybttVi5LY6MgE1jAF2HtY9jL1GYuuktsBKUc7mxB6fPFoznOzed2XifUFI3ff7XkITzp+U1YTqauxTXLPz2W2MIBHwXf77Tgdo5hBuuolVXMt08LaWfxwohEiv1L+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZOu3jbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D81C2BCAF;
	Tue, 10 Mar 2026 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163170;
	bh=l0HWcNcVkVo9YLSrRqspDdP84/kdc2LHA5rpvVoVGqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZOu3jbwCJQybbw9ITXnq/6jm5sdEpvaO+pzakWGIN+iyNSYTLLBQrrVJbrd1idVB
	 DybwhA0D4ougEcRqKzQY3N4YRh37XIXm03vtPrUhecWaT6kICBhAOSfcPQu6zKE0zK
	 BbLFZDPLFdD9iHsUglpz5krTCzo8mskSRB367Xkmbx91gFSLrobe3B4okgNBfdqIR3
	 jjom2dj3pT88Xcnvdb4uEKRdZ2N6kYYIBCP0qYrODBczDflStGNgQaJyhb0uC4J3df
	 wV8Ojw8QDjkE2u3Avb3ERM6xrUmPVREwxR2jkYto+Hozb+H72DReSd8/Vzeg1Ra29F
	 zVeznfyxV7fEA==
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
Subject: [PATCH net-next v3 08/10] net: macb: clean up tsu clk rate acquisition
Date: Tue, 10 Mar 2026 17:17:15 +0000
Message-ID: <20260310-undefined-unfocused-805b5f2d3b37@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pBzsAzv0f5XjXC1axq0Olq90oNiYo0A1zmrCQdWDjrw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgvRMZz1RyXH1WvCHJZxzkUWcxREP8bC0lU/neAeYM hRfYb7SUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInEzGT4Z5Ta9aBIhzcmk3Ph vnTjuc1xro67WCsSdZ7HCfTq7n5wlpHhf6Jd9lSnx3qf/E61ss7fvejji/+v+B+t3DhX1VmLV0q FAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 296E025579C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266261-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

tsu_clk is grabbed during probe, so doesn't need to be re-grabbed here.
pclk is mandatory, probe will fail if it is err/NULL, so there's no need
to check it here or have a !pclk 3rd arm. Simplify gem_get_tsu_rate() to
account for these facts.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6b37598ac57cd..38e75c2e097bf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3527,16 +3527,14 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
 	struct clk *tsu_clk;
 	unsigned int tsu_rate;
 
-	tsu_clk = devm_clk_get(&bp->pdev->dev, "tsu_clk");
-	if (!IS_ERR(tsu_clk))
-		tsu_rate = clk_get_rate(tsu_clk);
-	/* try pclk instead */
-	else if (!IS_ERR(bp->pclk)) {
+	if (!IS_ERR_OR_NULL(bp->tsu_clk)) {
+		tsu_rate = clk_get_rate(bp->tsu_clk);
+	} else {
 		tsu_clk = bp->pclk;
 		tsu_rate = clk_get_rate(tsu_clk);
 		dev_warn(&bp->pdev->dev, "devicetree missing tsu_clk, using pclk as fallback\n");
-	} else
-		return -ENOTSUPP;
+	}
+
 	return tsu_rate;
 }
 
-- 
2.51.0


