Return-Path: <netdev+bounces-297259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2jriArpvKGp9EgMAu9opvQ
	(envelope-from <netdev+bounces-297259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB71663F0E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:55:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=t3MaWyiB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297259-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E80FF30031EA
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D204ADD95;
	Tue,  9 Jun 2026 19:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DA48BD30;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034640; cv=none; b=fVtGC3uxTz2dYLCLOqXn5xyJKV5lmzF4J6hahLT1gyg8y8m4d//oEaFeXQqjYePwZFR3i5k6svoUBHd8tXnLcjv7fMV4cscq/cBj8U73iMkcnMpjDefy+1XrzoRJ2a/fh7WbkOMO/0EpZXsaJ5rPOvbuevg2TvLWPOs65zaqSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034640; c=relaxed/simple;
	bh=KW08t5lJgrtbiRiI4iWflun/lKNAeW7NI8u1pgoTVdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q78BQX0v0gKnFcyU7ScapUsuW04lGmOK2qwZXmfELQQ52dSfJHbZZGS8sVY8rtexT0/+1H0Y0vDmNrFgT4wKf2PXtx8IrD0EDLYu/1anOKzisbzMnbFKsPUc6hPSF68sgOzfMd5Pc1uvgr9S+SLG6f5Bqnij3l67RmIuMNWPF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3MaWyiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A3DC4AF0F;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781034639;
	bh=KW08t5lJgrtbiRiI4iWflun/lKNAeW7NI8u1pgoTVdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t3MaWyiBF1tCq3ikDFRyFL1w5vs+aY7xELG81KPjcpgqql1deCN7mPGnhiQ130I51
	 G1bsFhBoCtU1mZDtSGpprECxmDGMFOK5VXTkrAXJMG/5hhVLJoxLuk8NWc6TKdBXoc
	 jrZw/r3ePdf2t5FclSvMAy71HfcaqdBLyP0rRrS+6yeXSXo1ycwpL7d1oVjvDTJyMR
	 aOMtH5TAHfofw+tSIfmuY/Olx5yyzop2aopL0IAic1QVsR/CS7bLgwNjzz7XooziZk
	 zkyMVFTZ07aLFRzd5GwyYFfsfcFRyIr9MelcNhr66QJAnIAYhavitSkgBmjLT8cBn1
	 3+3PBLGMceFaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D5CD98C8;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Tue, 09 Jun 2026 12:50:26 -0700
Subject: [PATCH net v4 3/4] net: ethernet: oa_tc6: mdiobus->parent
 initialized with NULL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-level-trigger-v4-3-6f389abdd192@onsemi.com>
References: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
In-Reply-To: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781034634; l=1221;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=9JvUZCq1pALq6vC7gW8b4EQtBM4qeeaqZV2789jkVMw=;
 b=Qe4ffO/zEnjsqkbQGH/QcsHu3tQYGNqSgzzDMWybwPKW8sMwSMr8NENBvAKBU0Ub6VAAdPC5j
 mRbJ21ZicnzARN1XTyXWsXb9KFHo0hnL5hcrpY87Q+2ffs/pzDhIooE
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297259-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:pier.beruto@onsemi.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:replyto,onsemi.com:email,onsemi.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFB71663F0E

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

As "dev" pointer in oa_tc6 structure is never initialized,
mbiosub->parent was initialized with NULL.  This change
fixes the issue.

Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Changes in v4:
   new patch
---
 drivers/net/ethernet/oa_tc6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 20c9e98d1d60..0710a5a8dcde 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -108,7 +108,6 @@
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
-	struct device *dev;
 	struct net_device *netdev;
 	struct phy_device *phydev;
 	struct mii_bus *mdiobus;
@@ -517,7 +516,7 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 	tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
 	tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
 	tc6->mdiobus->name = "oa-tc6-mdiobus";
-	tc6->mdiobus->parent = tc6->dev;
+	tc6->mdiobus->parent = &tc6->spi->dev;
 
 	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
 		 dev_name(&tc6->spi->dev));

-- 
2.43.0



