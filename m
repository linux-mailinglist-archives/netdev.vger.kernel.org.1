Return-Path: <netdev+bounces-298633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I63OHhf+K2qnJAQAu9opvQ
	(envelope-from <netdev+bounces-298633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CC67967B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=HeOZkO8G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7ED3302BD09
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF473E5A2B;
	Fri, 12 Jun 2026 12:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336913E556D;
	Fri, 12 Jun 2026 12:38:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267929; cv=none; b=L32y/J066Q6JfdDquTXiAO04GXBegIAqh0aFwo80lffhlyWS+r2L8LrN/c2OZZ6B4r7oqvsX0XXYpX4pHSCWKXV8mrB0iBD+uvU4upLYjoXHCaliV96p+0P+vutXmS1Tiu4ieUv+/BoD2KsAPzih8ZRwz390xkC2Lx739D18ZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267929; c=relaxed/simple;
	bh=4b6cks/CDELaa0LmQZjfqkmWAr9MTiZ9LYIdy6MhNMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J3VGE9Vv3P3Mq9tSLhEXQZwn+/kZZkM7Q7Kh3Py0+kQqXPFHIMMSK+SjtkKbfAmBlyOWQ0Kb0GQxXMuVI/oBd7VST2GDwl1jUvDwXA9twigKUo8Y5whhfUuDt/TLf0IRcjm2sQgKb030e+QxsZ08vsOc8bMKQqv2Czfx54fYlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HeOZkO8G; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267928; x=1812803928;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4b6cks/CDELaa0LmQZjfqkmWAr9MTiZ9LYIdy6MhNMc=;
  b=HeOZkO8GV9LgFcvDQgn7yNMrZa77OVnIT7xwrZhjbhiurgDoSbtlKRSD
   lpwx+5NAASlJyx2MsDGRBmW5RJo6UhJvblXbZhg1AdkJGLdrRwFISDW+s
   xBKmqFZVmkpgwkrDVfmTh3c+3xbm5Ydi3dOXR/LnZoBjdihrkOfCo8W+b
   yxc2gKIj6xVnfXGN1SJ3BXGPMWLNpyXuWPuX1EqK/BlpMBydjvHi9I0he
   sb70SOf3puFAtQCoynrTQ+jWvFaSxkTSIRbJHPWIDeuSjEsOEU2SYJ1ha
   0ayZ+B9x3sAHfA6yzdO2bUmVOojuQ0cyTSGC+SBVNrs4FAynhOg4UVhAl
   w==;
X-CSE-ConnectionGUID: SpMwF82rSPmQXISODnxGVQ==
X-CSE-MsgGUID: sA6//y8gQ1a1wUwe0XCASA==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="59410184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 05:38:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 05:38:47 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:44 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:13 +0200
Subject: [PATCH net-next 4/9] net: microchip: vcap: expose helpers in vcap
 api and update debugfs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-4-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
In-Reply-To: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298633-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339CC67967B

Add new helpers to the vcap client api, in preparation for L3 routing
functionality:

 - vcap_val_add_rule(): wraps vcap_val_rule() + vcap_add_rule().
 - vcap_rule_mod_action_bit(): modify a bit-typed action on an existing
   rule.

Rename VCAP_CID_PREROUTING to VCAP_CID_PREROUTING_L0 and add
VCAP_USER_L3, both needed by the upcoming LPM VCAP user.

Extend the debugfs display to handle the new IP4_XIP and IP6_XIP key
fields.

Fix a latent undefined-behaviour bug in the debugfs action-field
printer. The old mask expression (1 << width) - 1 is UB when width is
32. The bug is unreachable before this series, since no existing field
in any client hits this, but the LPM VCAP introduces VCAP_AF_MAC_LSB
which is 32 bit wide.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 25 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |  4 +++-
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |  6 ++++++
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c | 13 ++++++++---
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 30700648672f..0905e4f192a0 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2379,6 +2379,19 @@ int vcap_add_rule(struct vcap_rule *rule)
 }
 EXPORT_SYMBOL_GPL(vcap_add_rule);
 
+/* Validate and add rule to a VCAP instance */
+int vcap_val_add_rule(struct vcap_rule *rule, u16 l3_proto)
+{
+	int err;
+
+	err = vcap_val_rule(rule, l3_proto);
+	if (err)
+		return err;
+
+	return vcap_add_rule(rule);
+}
+EXPORT_SYMBOL_GPL(vcap_val_add_rule);
+
 /* Allocate a new rule with the provided arguments */
 struct vcap_rule *vcap_alloc_rule(struct vcap_control *vctrl,
 				  struct net_device *ndev, int vcap_chain_id,
@@ -3547,6 +3560,18 @@ int vcap_rule_mod_action_u32(struct vcap_rule *rule,
 }
 EXPORT_SYMBOL_GPL(vcap_rule_mod_action_u32);
 
+/* Modify a bit action with value in the rule */
+int vcap_rule_mod_action_bit(struct vcap_rule *rule,
+			     enum vcap_action_field action,
+			     enum vcap_bit val)
+{
+	struct vcap_client_actionfield_data data;
+
+	vcap_rule_set_action_bitsize(&data.u1, val);
+	return vcap_rule_mod_action(rule, action, VCAP_FIELD_BIT, &data);
+}
+EXPORT_SYMBOL_GPL(vcap_rule_mod_action_bit);
+
 /* Drop keys in a keylist and any keys that are not supported by the keyset */
 int vcap_filter_rule_keys(struct vcap_rule *rule,
 			  enum vcap_key_field keylist[], int length,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.h b/drivers/net/ethernet/microchip/vcap/vcap_api.h
index 6069ad95c27e..e197e7257560 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.h
@@ -22,7 +22,7 @@
 #define VCAP_CID_INGRESS_L5          1500000 /* Ingress Stage 1 Lookup 5 */
 
 #define VCAP_CID_PREROUTING_IPV6     3000000 /* Prerouting Stage */
-#define VCAP_CID_PREROUTING          6000000 /* Prerouting Stage */
+#define VCAP_CID_PREROUTING_L0       6000000 /* Prerouting Stage Lookup 0 */
 
 #define VCAP_CID_INGRESS_STAGE2_L0   8000000 /* Ingress Stage 2 Lookup 0 */
 #define VCAP_CID_INGRESS_STAGE2_L1   8100000 /* Ingress Stage 2 Lookup 1 */
@@ -41,7 +41,9 @@ enum vcap_user {
 	VCAP_USER_MRP,
 	VCAP_USER_CFM,
 	VCAP_USER_VLAN,
+	VCAP_USER_L3,
 	VCAP_USER_QOS,
+	/* permanent enabled users above here */
 	VCAP_USER_VCAP_UTIL,
 	VCAP_USER_TC,
 	VCAP_USER_TC_EXTRA,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
index cdf79e17ca54..3f17e1e76b7d 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
@@ -167,6 +167,8 @@ void vcap_free_rule(struct vcap_rule *rule);
 int vcap_val_rule(struct vcap_rule *rule, u16 l3_proto);
 /* Add rule to a VCAP instance */
 int vcap_add_rule(struct vcap_rule *rule);
+/* Validate and add rule to a VCAP instance */
+int vcap_val_add_rule(struct vcap_rule *rule, u16 l3_proto);
 /* Delete rule in a VCAP instance */
 int vcap_del_rule(struct vcap_control *vctrl, struct net_device *ndev, u32 id);
 /* Make a full copy of an existing rule with a new rule id */
@@ -266,6 +268,10 @@ int vcap_rule_mod_key_u32(struct vcap_rule *rule, enum vcap_key_field key,
 int vcap_rule_mod_action_u32(struct vcap_rule *rule,
 			     enum vcap_action_field action,
 			     u32 value);
+/* Modify a bit action with value in the rule */
+int vcap_rule_mod_action_bit(struct vcap_rule *rule,
+			     enum vcap_action_field action,
+			     enum vcap_bit val);
 
 /* Get a 32 bit key field value and mask from the rule */
 int vcap_rule_get_key_u32(struct vcap_rule *rule, enum vcap_key_field key,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index 59bfbda29bb3..56464ece8e6b 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -40,7 +40,8 @@ static void vcap_debugfs_show_rule_keyfield(struct vcap_control *vctrl,
 		value = (u8 *)(&data->u32.value);
 		mask = (u8 *)(&data->u32.mask);
 
-		if (key == VCAP_KF_L3_IP4_SIP || key == VCAP_KF_L3_IP4_DIP) {
+		if (key == VCAP_KF_L3_IP4_SIP || key == VCAP_KF_L3_IP4_DIP ||
+		    key == VCAP_KF_IP4_XIP) {
 			out->prf(out->dst, "%pI4h/%pI4h", &data->u32.value,
 				 &data->u32.mask);
 		} else if (key == VCAP_KF_ETYPE ||
@@ -88,7 +89,8 @@ static void vcap_debugfs_show_rule_keyfield(struct vcap_control *vctrl,
 	case VCAP_FIELD_U128:
 		value = data->u128.value;
 		mask = data->u128.mask;
-		if (key == VCAP_KF_L3_IP6_SIP || key == VCAP_KF_L3_IP6_DIP) {
+		if (key == VCAP_KF_L3_IP6_SIP || key == VCAP_KF_L3_IP6_DIP ||
+		    key == VCAP_KF_IP6_XIP) {
 			u8 nvalue[16], nmask[16];
 
 			vcap_netbytes_copy(nvalue, data->u128.value,
@@ -133,7 +135,12 @@ vcap_debugfs_show_rule_actionfield(struct vcap_control *vctrl,
 		out->prf(out->dst, "%d", value[0]);
 		break;
 	case VCAP_FIELD_U32:
-		fmsk = (1 << actionfield[action].width) - 1;
+		if (action == VCAP_AF_MAC_LSB || action == VCAP_AF_MAC_MSB) {
+			hex = true;
+			break;
+		}
+		fmsk = actionfield[action].width ?
+		       GENMASK(actionfield[action].width - 1, 0) : 0;
 		val = *(u32 *)value;
 		out->prf(out->dst, "%u", val & fmsk);
 		break;

-- 
2.52.0


