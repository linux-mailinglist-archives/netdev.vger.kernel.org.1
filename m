Return-Path: <netdev+bounces-298632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jrW2Hi/+K2qsJAQAu9opvQ
	(envelope-from <netdev+bounces-298632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C0679681
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:40:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=XoZLK1RR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298632-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298632-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADECE31709C2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0873E4514;
	Fri, 12 Jun 2026 12:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1573DE43E;
	Fri, 12 Jun 2026 12:38:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267926; cv=none; b=SSIb8nY3BAdvwIeG3m7V8/dfeocy5YpTDx+3ixWW/0tTDsjZ6UTo2xYzTV9GEwemPBBHgVq1rZueBnmMNfdseKPhFPky/FFJckQsM1/vPJHUvja7lME0d/XNCkp0U1IJaRuSgOIUASMVjaYkZ9vgrkxXIGB++59piIqsB2muLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267926; c=relaxed/simple;
	bh=KEaEUJCYAEMjwC5QjXh2bDIIjrmXMR7PQDf3K1RKJdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LBF9bCCw44Qqnk5awAJK2iu2JFt8xcB6m63bErBxjmVyUDMx6DSSwfw/A5z2TEQgm5M1C+oUPP/yp8ylTMJm+LJlPeo9f7x+PFy5UeSjG81Qm9EmsN9ZBT2w8f3n0TPsJYdyorN9i+KKt+Tkg6f4rfhlImJqwkUd870g5Z2C1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XoZLK1RR; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267926; x=1812803926;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KEaEUJCYAEMjwC5QjXh2bDIIjrmXMR7PQDf3K1RKJdQ=;
  b=XoZLK1RR99bY8i5gRRkrtReCNzpNleTIVTQdWYW8zR1I8AoVld+p+woK
   QQHCfZlUt05R6CnXDgxot2JvHVun8P1u+Cw722QJ5EviejMF4spy7boiJ
   gjzqtWxx7QtoNMmnKoRnQoGlvyr78dHZjZiZw8DZhGuGQMWRiI25cW1ah
   gR7W83x/zhtAfcujY4xDCNW9C1kue7m4KTx6Mge42QHk/JbFdo6YbuUnR
   Dkdg22z0Nccv4hQShFUxQkpr+ZkNajMWr4I9ofzROjktWQ7KutXqgRkKb
   y06M7Pbkbrf9nwS17smZmIHYHus1+UHfi7H+Izxe8hr34AG4yV4s5QhWc
   Q==;
X-CSE-ConnectionGUID: rlQPc1ARTNKXdeL4uOz28w==
X-CSE-MsgGUID: A4ky+3h0Sg2hEwaLs8c/Zg==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="59023666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 05:38:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 05:38:44 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:41 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:12 +0200
Subject: [PATCH net-next 3/9] net: microchip: vcap: make vcap actionset
 decoding type_id aware
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-3-fc3c10160f49@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298632-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E31C0679681

When reading a rule back from hardware, decoding has to identify which
actionset the rule was written as. The existing logic was only aware of
the actionset subword length, which cannot distinguish actionsets that
share a subword length but differ in their type_id field. The LPM VCAP
added in a following patch introduces this case: ARP_PTR, L3MC_PTR and
ARP_ENTRY all occupy one subword and differ only by type_id.

A helper is introduced to extract the type_id bits directly from
stream[0]. This is valid by construction: the VCAP model places the
type_id field (when present) immediately after the typegroup bits in
the first subword.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 6946fd738458..30700648672f 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -216,6 +216,13 @@ static void vcap_decode_field(u32 *stream, struct vcap_stream_iter *itr,
 	}
 }
 
+/* The type_id field is always right after the typegroup bits, if it exists */
+static u8 vcap_find_stream_type_id(u32 *stream, u16 tg_width,
+				   u16 typefld_width)
+{
+	return (stream[0] >> tg_width) & GENMASK(typefld_width - 1, 0);
+}
+
 /* Verify that the type id in the stream matches the type id of the keyset */
 static bool vcap_verify_keystream_keyset(struct vcap_control *vctrl,
 					 enum vcap_type vt,
@@ -1331,8 +1338,10 @@ vcap_verify_actionstream_actionset(struct vcap_control *vctrl,
 				   enum vcap_actionfield_set actionset)
 {
 	const struct vcap_typegroup *tgt;
+	const struct vcap_field *typefld;
 	const struct vcap_field *fields;
 	const struct vcap_set *info;
+	u8 value = 0;
 
 	if (vcap_actionfield_count(vctrl, vt, actionset) == 0)
 		return false;
@@ -1355,8 +1364,11 @@ vcap_verify_actionstream_actionset(struct vcap_control *vctrl,
 	if (!fields)
 		return false;
 
-	/* Later this will be expanded with a check of the type id */
-	return true;
+	typefld = &fields[VCAP_AF_TYPE];
+	value = vcap_find_stream_type_id(actionstream,
+					 tgt->width, typefld->width);
+
+	return value == info->type_id;
 }
 
 /* Find the subword width of the action typegroup that matches the stream data

-- 
2.52.0


