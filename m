Return-Path: <netdev+bounces-275567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAtCKHKN02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:39:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C153A2E0E
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0F6D3013D55
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18732C94B;
	Mon,  6 Apr 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSraxYjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F032B989;
	Mon,  6 Apr 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471722; cv=none; b=kk54+WCCi4/Fo+FsNiigqECYODjvrYK6Zcz35zaAcxHmeyMv6QqD1R2YT3wEpo6jkSlsRf9jEwo9TekBFHr+1QmkdJ+ClT2nbR/pMoJFVF35bK82Z6RrzSxKTqsyJtPo5Jxi7DsAnp7VD9CnCNVq43gbD+rjG4b+3AdN1D1udOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471722; c=relaxed/simple;
	bh=8Mrg0yy4Xk/C/etY2AlCJfZSISnYqkitJZWt4ANfVg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aswYM8pyQV/BEBcOLjAQ5iXhHxWpCIy+BcLdAUx2hsA0rTzOiMt6WKutChQ8J6Qch86G6z35qcMtOAQ8m0Yl9ad7n2A8oMysJJihJHZFqde1Z+4WtYbFWzl6A8ln/E1NbG/4B8/9+1kD5/MRD7nC6jWo1Vt3BwkQsGadvV3wm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSraxYjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E03C4CEF7;
	Mon,  6 Apr 2026 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471722;
	bh=8Mrg0yy4Xk/C/etY2AlCJfZSISnYqkitJZWt4ANfVg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XSraxYjCgU2J0H4fZt2UrtpCMSvrd0BINn2NKUnixlTRwQKX3841/yr6APDsyWLhr
	 qYgkshMMezsdYHobUf81wY5fFSjqQTaewACtRnMgJ6scHoIX2+tr5ZSJo/s//gjICG
	 q1uU0mnBMVPK1i3T+zKIykv0yOvtg5O31Ltw951gBX51lKatP6kUYxapsnUw7ygBlv
	 gjk6KvkTLO66flsBbZ9MyEL/ElXTFRIPjB6ta+ENDmCF6qlWJnHrv68SyGcDhm7EqA
	 YpHzGjTlTm7qKmAlwJvGvfH/uguzDOKctnxeewYD7T5o/qfiofwAiAWw4k5s52qaET
	 C6G5fFO+CfpOg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:17 +0200
Subject: [PATCH net-next v3 12/12] net: airoha: Rename get_src_port_id
 callback in get_sport
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-12-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08C153A2E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For code consistency, rename get_src_port_id callback in get_sport.
Please note this patch does not introduce any logical change and it is
just a cosmetic patch.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 12 ++++++------
 drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9988011dca53..c14dee3c9bfb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1770,7 +1770,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	src_port = eth->soc->ops.get_src_port_id(port, dev->nbq);
+	src_port = eth->soc->ops.get_sport(port, dev->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -3102,7 +3102,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 		/* Verify the provided nbq parameter is valid */
 		nbq = be32_to_cpup(nbq_ptr);
-		err = eth->soc->ops.get_src_port_id(port, nbq);
+		err = eth->soc->ops.get_sport(port, nbq);
 		if (err < 0) {
 			of_node_put(node);
 			return err;
@@ -3309,7 +3309,7 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
-static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+static int airoha_en7581_get_sport(struct airoha_gdm_port *port, int nbq)
 {
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -3373,7 +3373,7 @@ static const char * const an7583_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
-static int airoha_an7583_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+static int airoha_an7583_get_sport(struct airoha_gdm_port *port, int nbq)
 {
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -3431,7 +3431,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.num_ppe = 2,
 	.ops = {
-		.get_src_port_id = airoha_en7581_get_src_port_id,
+		.get_sport = airoha_en7581_get_sport,
 		.get_dev_from_sport = airoha_en7581_get_dev_from_sport,
 	},
 };
@@ -3442,7 +3442,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
 	.num_ppe = 1,
 	.ops = {
-		.get_src_port_id = airoha_an7583_get_src_port_id,
+		.get_sport = airoha_an7583_get_sport,
 		.get_dev_from_sport = airoha_an7583_get_dev_from_sport,
 	},
 };
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8dec25fa0478..ec31a3b5efc3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -591,7 +591,7 @@ struct airoha_eth_soc_data {
 	int num_xsi_rsts;
 	int num_ppe;
 	struct {
-		int (*get_src_port_id)(struct airoha_gdm_port *port, int nbq);
+		int (*get_sport)(struct airoha_gdm_port *port, int nbq);
 		int (*get_dev_from_sport)(struct airoha_qdma_desc *desc,
 					  u16 *port, u16 *dev);
 	} ops;

-- 
2.53.0


