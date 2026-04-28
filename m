Return-Path: <netdev+bounces-281643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WxCeFF1F8GkyRAEAu9opvQ
	(envelope-from <netdev+bounces-281643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B947D906
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D6F3027B6C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B633128B6;
	Tue, 28 Apr 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/QxpjUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04130C62E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353866; cv=none; b=ECaLhXwEzMm1JBVpDlBqPk+zdFGVc7nIwhct4nzyFC2KJd19UYTudGcULPdOh1rzDG8lIQFme/fn5COJ627zIr9QX5I2zq2DVwoVND6qvNQS1uN4j9HfCv01PlH4uqDK0nbtqZBl2FB/E9zEkYq9welR5TyvF739jQ+M0B8MYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353866; c=relaxed/simple;
	bh=1UkRQ1r97l+xc61Uq3I8d6KMQlkth8YQu7hGa3Ydr5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hosp2jZEavS7mJPHerxRbikWckl2d0L0IkJivP8qzVeYolxTtCESY0/WoymW/R6gtcBY8YwF3H8fJOhd7bqqUKxDs61LpLu+XdqLfhUwnu5oQ1Sqati4kPTSGVMiPz5qgvOB+/vAV7PfH4kZDnp6h8xefV5lyIYx+tQTQ1wUOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/QxpjUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B1C2BCAF;
	Tue, 28 Apr 2026 05:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777353866;
	bh=1UkRQ1r97l+xc61Uq3I8d6KMQlkth8YQu7hGa3Ydr5M=;
	h=From:Date:Subject:To:Cc:From;
	b=j/QxpjUsfYCizp9tzn4Wf73emzAquwIAOatTVkshO+HVt9Z7TzmvHCnywq0UK1XJH
	 8b22M8Wcrlf9V+mMHB/1hzp0r1PIGOGzxoH+Ao/NwML/A5OLna/miDqaAG8Pp8Cxnl
	 N9Zf0lkAx5IlWID0kWWKwzWH+1kjHT3P/d3VPJZ/RZ8Vl5+U1y9WkAAeXDHjPMxoEF
	 nn9MPyGtylN2mXgVVbNYZPPAFr1PXgq2OYfG5IsxByvRsvy0bVI+s8Y0oKkKvRVLEc
	 ZeQTIGJGHCRiEgdXa4xnObotSz0w6W7zQdBwWQvO54ZyqmSmkm+JuWcPV/x0BpKum2
	 ULuGkKgMR1+mg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 28 Apr 2026 07:23:38 +0200
Subject: [PATCH net-next] net: airoha: Rename get_src_port_id callback in
 get_sport
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-airoha-get_src_port_id-callback-v1-1-3f765c91c1e8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3N0QqDMAxA0V+RPC/gwuzcfmVIiTXTMGklLUMQ/
 31lj+fl3gOymEqGZ3OAyVezplhxvTQQFo6zoE7VQC259kY9slpaGGcpPlvwW7LidcLA6zpy+KD
 ryElPIz+6O9TKZvLW/X94QZSCUfYCw3n+AOhPGEN7AAAA
X-Change-ID: 20260428-airoha-get_src_port_id-callback-6526e82ba957
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C18B947D906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281643-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

For code consistency, rename get_src_port_id callback in get_sport.
Please note this patch does not introduce any logical change and it is
just a cosmetic patch.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
 drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2bb0a3ff9810..56441b99448a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1813,7 +1813,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	src_port = eth->soc->ops.get_src_port_id(port, port->nbq);
+	src_port = eth->soc->ops.get_sport(port, port->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -3187,7 +3187,7 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
-static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+static int airoha_en7581_get_sport(struct airoha_gdm_port *port, int nbq)
 {
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -3240,7 +3240,7 @@ static const char * const an7583_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
-static int airoha_an7583_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+static int airoha_an7583_get_sport(struct airoha_gdm_port *port, int nbq)
 {
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -3288,7 +3288,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.num_ppe = 2,
 	.ops = {
-		.get_src_port_id = airoha_en7581_get_src_port_id,
+		.get_sport = airoha_en7581_get_sport,
 		.get_vip_port = airoha_en7581_get_vip_port,
 	},
 };
@@ -3299,7 +3299,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
 	.num_ppe = 1,
 	.ops = {
-		.get_src_port_id = airoha_an7583_get_src_port_id,
+		.get_sport = airoha_an7583_get_sport,
 		.get_vip_port = airoha_an7583_get_vip_port,
 	},
 };
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index e389d2fe3b86..1a052b898816 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -578,7 +578,7 @@ struct airoha_eth_soc_data {
 	int num_xsi_rsts;
 	int num_ppe;
 	struct {
-		int (*get_src_port_id)(struct airoha_gdm_port *port, int nbq);
+		int (*get_sport)(struct airoha_gdm_port *port, int nbq);
 		u32 (*get_vip_port)(struct airoha_gdm_port *port, int nbq);
 	} ops;
 };

---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260428-airoha-get_src_port_id-callback-6526e82ba957

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


