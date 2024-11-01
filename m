Return-Path: <netdev+bounces-140937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F209B8BC3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280F71F22676
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B021527B4;
	Fri,  1 Nov 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="meA3DhTs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA614F9F8;
	Fri,  1 Nov 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445008; cv=none; b=b1V/6qjGBtkaZZFixqnl+sBrnoBHYVUmqEbQFxXQ3E2T+y0OJBt5yLd4IoOEFUc1zMjTRBOyqa5aU1TL7ECNJSuKCBcf2YcPVfrVQlMzGGZxsd+U/K4g2TSaVo+/xSEtte6q0c7+uY5AGP7hWe0B8rkiTnZceMnrBnBSU+c0+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445008; c=relaxed/simple;
	bh=bNDvHwGZPuV+jga52Bz0VxfXArVfgtjiFjQDUPKRnEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WR5d5rAeMoxrrg9OmIxkiHup92xQ2ibL86EydkkaZsP+/CIXhHnztIs9u+FN05qvMDYMx/JzDJ1NPSNofDB7s7bnzfCl18TENYMzb2h4FuPB/VORUolzhUZaiI6DlGsBv3J03hDRVTDaeUwJyPW0AOwPnA/RfRkTYhY0Mm/T4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=meA3DhTs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730445005; x=1761981005;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bNDvHwGZPuV+jga52Bz0VxfXArVfgtjiFjQDUPKRnEw=;
  b=meA3DhTshUlWYcgDngRgAZv0KHHCYx0OZ6/xtwdS5vzSk1w7iAcJcKsk
   EeKVPcwgnX6n6NLh8OXIFmEcNeR2p166fHd3ZkF5IqS+Ogw4ZslxOSbn7
   OX+koBwhR7RHdvgqaKVTLtD35dDTrRc2kQsgQudTPjaE9ZNA9LPgYtX2B
   pBMKlmVAPw6neF0vLflE6fCU5AR3EZs9K7iwZ4yg7afp3NUiB+Z23LKlM
   /ocNpei3XjhjsZA7e4U6ADJikK+arRYofwf+UyAfjc9d7NiGSqvstklPs
   E0UK1ewJhWOLm1RSnYDCaB1b2fUqxGChmpNROAz9kkjPBBUkWKB91RcVS
   g==;
X-CSE-ConnectionGUID: LaL60DmvQP6I/WsdV/7gQA==
X-CSE-MsgGUID: ACGpuLYZRUqqf5TabdThyw==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="37215414"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 00:09:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 00:09:57 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Nov 2024 00:09:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 1 Nov 2024 08:09:08 +0100
Subject: [PATCH net-next 2/6] net: sparx5: replace SPX5_PORTS with n_ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241101-sparx5-lan969x-switch-driver-3-v1-2-3c76f22f4bfa@microchip.com>
References: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
In-Reply-To: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <christophe.jaillet@wanadoo.fr>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

The Sparx5 VCAP implementation uses the SPX5_PORTS symbol to iterate over
the 65 front ports of Sparx5. Replace the use with the n_ports constant
from the match data, which translates to 65 of Sparx5 and 30 on lan969x.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   | 24 ++++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 0bdf7a378892..bbff8158a3de 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -1777,6 +1777,7 @@ void sparx5_vcap_set_port_keyset(struct net_device *ndev,
 static void sparx5_vcap_is0_port_key_selection(struct sparx5 *sparx5,
 					       struct vcap_admin *admin)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int portno, lookup;
 	u32 keysel;
 
@@ -1788,7 +1789,7 @@ static void sparx5_vcap_is0_port_key_selection(struct sparx5 *sparx5,
 				 VCAP_IS0_PS_MPLS_FOLLOW_ETYPE,
 				 VCAP_IS0_PS_MLBS_FOLLOW_ETYPE);
 	for (lookup = 0; lookup < admin->lookups; ++lookup) {
-		for (portno = 0; portno < SPX5_PORTS; ++portno) {
+		for (portno = 0; portno < consts->n_ports; ++portno) {
 			spx5_wr(keysel, sparx5,
 				ANA_CL_ADV_CL_CFG(portno, lookup));
 			spx5_rmw(ANA_CL_ADV_CL_CFG_LOOKUP_ENA,
@@ -1803,6 +1804,7 @@ static void sparx5_vcap_is0_port_key_selection(struct sparx5 *sparx5,
 static void sparx5_vcap_is2_port_key_selection(struct sparx5 *sparx5,
 					       struct vcap_admin *admin)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int portno, lookup;
 	u32 keysel;
 
@@ -1813,13 +1815,13 @@ static void sparx5_vcap_is2_port_key_selection(struct sparx5 *sparx5,
 				 VCAP_IS2_PS_IPV6_UC_IP_7TUPLE,
 				 VCAP_IS2_PS_ARP_ARP);
 	for (lookup = 0; lookup < admin->lookups; ++lookup) {
-		for (portno = 0; portno < SPX5_PORTS; ++portno) {
+		for (portno = 0; portno < consts->n_ports; ++portno) {
 			spx5_wr(keysel, sparx5,
 				ANA_ACL_VCAP_S2_KEY_SEL(portno, lookup));
 		}
 	}
 	/* IS2 lookups are in bit 0:3 */
-	for (portno = 0; portno < SPX5_PORTS; ++portno)
+	for (portno = 0; portno < consts->n_ports; ++portno)
 		spx5_rmw(ANA_ACL_VCAP_S2_CFG_SEC_ENA_SET(0xf),
 			 ANA_ACL_VCAP_S2_CFG_SEC_ENA,
 			 sparx5,
@@ -1830,11 +1832,12 @@ static void sparx5_vcap_is2_port_key_selection(struct sparx5 *sparx5,
 static void sparx5_vcap_es0_port_key_selection(struct sparx5 *sparx5,
 					       struct vcap_admin *admin)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int portno;
 	u32 keysel;
 
 	keysel = VCAP_ES0_KEYSEL(VCAP_ES0_PS_FORCE_ISDX_LOOKUPS);
-	for (portno = 0; portno < SPX5_PORTS; ++portno)
+	for (portno = 0; portno < consts->n_ports; ++portno)
 		spx5_rmw(keysel, REW_RTAG_ETAG_CTRL_ES0_ISDX_KEY_ENA,
 			 sparx5, REW_RTAG_ETAG_CTRL(portno));
 
@@ -1846,6 +1849,7 @@ static void sparx5_vcap_es0_port_key_selection(struct sparx5 *sparx5,
 static void sparx5_vcap_es2_port_key_selection(struct sparx5 *sparx5,
 					       struct vcap_admin *admin)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int portno, lookup;
 	u32 keysel;
 
@@ -1853,7 +1857,7 @@ static void sparx5_vcap_es2_port_key_selection(struct sparx5 *sparx5,
 				 VCAP_ES2_PS_IPV4_IP4_TCP_UDP_OTHER,
 				 VCAP_ES2_PS_IPV6_IP_7TUPLE);
 	for (lookup = 0; lookup < admin->lookups; ++lookup)
-		for (portno = 0; portno < SPX5_PORTS; ++portno)
+		for (portno = 0; portno < consts->n_ports; ++portno)
 			spx5_wr(keysel, sparx5,
 				EACL_VCAP_ES2_KEY_SEL(portno, lookup));
 }
@@ -1885,19 +1889,20 @@ static void sparx5_vcap_port_key_selection(struct sparx5 *sparx5,
 static void sparx5_vcap_port_key_deselection(struct sparx5 *sparx5,
 					     struct vcap_admin *admin)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	int portno, lookup;
 
 	switch (admin->vtype) {
 	case VCAP_TYPE_IS0:
 		for (lookup = 0; lookup < admin->lookups; ++lookup)
-			for (portno = 0; portno < SPX5_PORTS; ++portno)
+			for (portno = 0; portno < consts->n_ports; ++portno)
 				spx5_rmw(ANA_CL_ADV_CL_CFG_LOOKUP_ENA_SET(0),
 					 ANA_CL_ADV_CL_CFG_LOOKUP_ENA,
 					 sparx5,
 					 ANA_CL_ADV_CL_CFG(portno, lookup));
 		break;
 	case VCAP_TYPE_IS2:
-		for (portno = 0; portno < SPX5_PORTS; ++portno)
+		for (portno = 0; portno < consts->n_ports; ++portno)
 			spx5_rmw(ANA_ACL_VCAP_S2_CFG_SEC_ENA_SET(0),
 				 ANA_ACL_VCAP_S2_CFG_SEC_ENA,
 				 sparx5,
@@ -1909,7 +1914,7 @@ static void sparx5_vcap_port_key_deselection(struct sparx5 *sparx5,
 		break;
 	case VCAP_TYPE_ES2:
 		for (lookup = 0; lookup < admin->lookups; ++lookup)
-			for (portno = 0; portno < SPX5_PORTS; ++portno)
+			for (portno = 0; portno < consts->n_ports; ++portno)
 				spx5_rmw(EACL_VCAP_ES2_KEY_SEL_KEY_ENA_SET(0),
 					 EACL_VCAP_ES2_KEY_SEL_KEY_ENA,
 					 sparx5,
@@ -2026,6 +2031,7 @@ static void sparx5_vcap_block_alloc(struct sparx5 *sparx5,
 /* Allocate a vcap control and vcap instances and configure the system */
 int sparx5_vcap_init(struct sparx5 *sparx5)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	const struct sparx5_vcap_inst *cfg;
 	struct vcap_control *ctrl;
 	struct vcap_admin *admin;
@@ -2069,7 +2075,7 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 		list_add_tail(&admin->list, &ctrl->list);
 	}
 	dir = vcap_debugfs(sparx5->dev, sparx5->debugfs_root, ctrl);
-	for (idx = 0; idx < SPX5_PORTS; ++idx)
+	for (idx = 0; idx < consts->n_ports; ++idx)
 		if (sparx5->ports[idx])
 			vcap_port_debugfs(sparx5->dev, dir, ctrl,
 					  sparx5->ports[idx]->ndev);

-- 
2.34.1


