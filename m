Return-Path: <netdev+bounces-25938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C29776385
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D6E1C21269
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DD1AA96;
	Wed,  9 Aug 2023 15:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639F1AA90
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:15:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639771FD4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691594144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02YW8ArM2LukzalrlbsBsHAhHbZsYD1kRvVtXeVpNE8=;
	b=BOQ8V7cxCRbOUenuns99tZbn9dgwY+FZKWC2CCQZ0zD3ZJBE2rS3BC1umDYse6UqT/ytN7
	WaNT2BoldL0b006a7ctB6GXXlN06smfLjZ9mqRawJmVPRIf29nsRw6PTg/oZvqMseCWDJf
	oSSwxg2UTSDrIWRorDclwWfLoQbsFMM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-sEMSBrkhOPuE60yA-D9Shg-1; Wed, 09 Aug 2023 11:15:38 -0400
X-MC-Unique: sEMSBrkhOPuE60yA-D9Shg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6FC801FA0;
	Wed,  9 Aug 2023 15:15:35 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.226.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE292026D4B;
	Wed,  9 Aug 2023 15:15:33 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jacob.e.keller@intel.com,
	przemyslawx.patynowski@intel.com,
	kamil.maziarz@intel.com,
	dawidx.wesierski@intel.com,
	mateusz.palczewski@intel.com,
	slawomirx.laba@intel.com,
	norbertx.zulinski@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net v2 1/2] Revert "ice: Fix ice VF reset during iavf initialization"
Date: Wed,  9 Aug 2023 17:15:28 +0200
Message-ID: <20230809151529.842798-2-poros@redhat.com>
In-Reply-To: <20230809151529.842798-1-poros@redhat.com>
References: <20230809151529.842798-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit 7255355a0636b4eff08d5e8139c77d98f151c4fc.

After this commit we are not able to attach VF to VM:
virsh attach-interface v0 hostdev --managed 0000:41:01.0 --mac 52:52:52:52:52:52
error: Failed to attach interface
error: Cannot set interface MAC to 52:52:52:52:52:52 for ifname enp65s0f0np0 vf 0: Resource temporarily unavailable

ice_check_vf_ready_for_cfg() already contain waiting for reset.
New condition in ice_check_vf_ready_for_reset() causing only problems.

Fixes: 7255355a0636 ("ice: Fix ice VF reset during iavf initialization")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 19 -------------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 1f66914c7a202a..31314e7540f8cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1131,7 +1131,7 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1246,7 +1246,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto out_put_vf;
 	}
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1300,7 +1300,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 		return -EOPNOTSUPP;
 	}
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1613,7 +1613,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index b26ce4425f4559..294e91c3453ccd 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -185,25 +185,6 @@ int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 	return 0;
 }
 
-/**
- * ice_check_vf_ready_for_reset - check if VF is ready to be reset
- * @vf: VF to check if it's ready to be reset
- *
- * The purpose of this function is to ensure that the VF is not in reset,
- * disabled, and is both initialized and active, thus enabling us to safely
- * initialize another reset.
- */
-int ice_check_vf_ready_for_reset(struct ice_vf *vf)
-{
-	int ret;
-
-	ret = ice_check_vf_ready_for_cfg(vf);
-	if (!ret && !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
-		ret = -EAGAIN;
-
-	return ret;
-}
-
 /**
  * ice_trigger_vf_reset - Reset a VF on HW
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 67172fdd9bc27f..48fea6fa036210 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -215,7 +215,6 @@ u16 ice_get_num_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf);
 bool ice_is_vf_disabled(struct ice_vf *vf);
 int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
-int ice_check_vf_ready_for_reset(struct ice_vf *vf);
 void ice_set_vf_state_dis(struct ice_vf *vf);
 bool ice_is_any_vf_in_unicast_promisc(struct ice_pf *pf);
 void
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index efbc2968a7bf6a..dcf628b1fccd93 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3947,7 +3947,6 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 		ice_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
-		clear_bit(ICE_VF_STATE_ACTIVE, vf->vf_states);
 		ops->reset_vf(vf);
 		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
-- 
2.41.0


