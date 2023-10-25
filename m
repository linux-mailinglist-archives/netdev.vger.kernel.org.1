Return-Path: <netdev+bounces-44197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12A7D6FA9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AFE1C20C91
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432AD28690;
	Wed, 25 Oct 2023 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrdAC7gn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E76C8EA
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:48:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75186E5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698245324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Pt8PD3fKJKJEHUeXOD6j5kypGWK1I6rGvh+TneYCRQ=;
	b=VrdAC7gn95oi0c282RmonxPYvTbICK7cdJm+vFb/u3w/ejLfSHDlGt9pn/WpBX3MV8Vggi
	Y0DMVS9idJcGrEYONYvoMmz0J5MTLYZBJNg8lgt4a0US7Ihy+eHPvC3TSdrJ2tYcd9aFZE
	KcK9TcwKGvjM46e/qF3m6di9GNkvFq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-8kJ3MnFsNg-wBKvUmRwjXw-1; Wed, 25 Oct 2023 10:48:41 -0400
X-MC-Unique: 8kJ3MnFsNg-wBKvUmRwjXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA182857CF1;
	Wed, 25 Oct 2023 14:48:40 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D704B2026D66;
	Wed, 25 Oct 2023 14:48:38 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH iwl-next v2] i40e: Delete unused i40e_mac_info fields
Date: Wed, 25 Oct 2023 16:48:38 +0200
Message-ID: <20231025144838.1827302-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
the field i40e_mac_info.san_addr is unused (never filled).
The field i40e_mac_info.max_fcoeq is unused from the beginning.
Remove both.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c  | 5 +----
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
 drivers/net/ethernet/intel/i40e/i40e_type.h    | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 1ee77a2433c0..4721845fda6e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -827,15 +827,12 @@ static void i40e_dcbnl_get_perm_hw_addr(struct net_device *dev,
 					u8 *perm_addr)
 {
 	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
-	int i, j;
+	int i;
 
 	memset(perm_addr, 0xff, MAX_ADDR_LEN);
 
 	for (i = 0; i < dev->addr_len; i++)
 		perm_addr[i] = pf->hw.mac.perm_addr[i];
-
-	for (j = 0; j < dev->addr_len; j++, i++)
-		perm_addr[i] = pf->hw.mac.san_addr[j];
 }
 
 static const struct dcbnl_rtnl_ops dcbnl_ops = {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index e0849f0c9c27..88240571721a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -147,9 +147,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 "    state[%d] = %08lx\n",
 			 i, vsi->state[i]);
 	if (vsi == pf->vsi[pf->lan_vsi])
-		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
+		dev_info(&pf->pdev->dev, "    MAC address: %pM Port MAC: %pM\n",
 			 pf->hw.mac.addr,
-			 pf->hw.mac.san_addr,
 			 pf->hw.mac.port_addr);
 	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
 		dev_info(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index e3d40630f689..76bcbaec8ae5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -270,9 +270,7 @@ struct i40e_mac_info {
 	enum i40e_mac_type type;
 	u8 addr[ETH_ALEN];
 	u8 perm_addr[ETH_ALEN];
-	u8 san_addr[ETH_ALEN];
 	u8 port_addr[ETH_ALEN];
-	u16 max_fcoeq;
 };
 
 enum i40e_aq_resources_ids {
-- 
2.41.0


