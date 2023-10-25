Return-Path: <netdev+bounces-44142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E27D69A3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C880B2102C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21C26E1C;
	Wed, 25 Oct 2023 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Uxxmdl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462526E11
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:59:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998F116
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698231559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbl9d2tDVXT45ZlkhFJ2cNIXoUOP4mWOh9E5YishFi8=;
	b=U1UxxmdlqpizscMCaK0NS5oDt2R47qUihAAwZkbSUD7XbFuarXvfJiKgKQ/KvpRX2Eq4IU
	xGEoUJWW+9ex31MUVN7ADsGDCXEuXDHsYn2DdNRbgluy/pGTOMXc3/RCeAXM+OY/ZoAdyX
	Ko4MTiMouAEfIg0Yt9jqxGTHyhdF0go=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-T7Rw2M5QPlWoXC_SolU-0g-1; Wed, 25 Oct 2023 06:59:14 -0400
X-MC-Unique: T7Rw2M5QPlWoXC_SolU-0g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5733F101A54C;
	Wed, 25 Oct 2023 10:59:14 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5086F492BD9;
	Wed, 25 Oct 2023 10:59:12 +0000 (UTC)
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
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH iwl-next] i40e: Delete unused i40e_mac_info fields
Date: Wed, 25 Oct 2023 12:59:11 +0200
Message-ID: <20231025105911.1204326-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
the field i40e_mac_info.san_addr is unused (never filled).
The field i40e_mac_info.max_fcoeq is unused from the beginning.
Remove both.

Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
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


