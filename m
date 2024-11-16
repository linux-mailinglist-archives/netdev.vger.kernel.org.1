Return-Path: <netdev+bounces-145579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250869CFF76
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22882827B2
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3B179A3;
	Sat, 16 Nov 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jQklbqBF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F78D529;
	Sat, 16 Nov 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770689; cv=none; b=pdZ9XLetj2vGlyGQJkROhuRNpWGZHiHmKOv2jOr/Y6rnckOdEbMUjCnPUY8Hlxmog2srDnmmQ8LRh+zUlBSpMy/EUchSpHnqGrm4M9OBw7C1l5ie5IZqEfLrpv6icEe/MV8uc1COSglhS8SBxn3w+H9IdsDnXIZRj5NcuAbh4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770689; c=relaxed/simple;
	bh=jDOjDDgZ7NeERfOKKdvK+6lgxU7doXUeIzzP6RaCQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw8KR9k8+yoWidjkWc0R2IDRR2cXFoVAuEMcqufWAs0/doltaN3dtoVtyvdmA6X3iEmlPKm396OWbXqxWSbzU/FVrHThzZobIB+l6m9S/pGR40Szoi71d0OoOVVS8XEElt8IvY774U3Ell/ugghf/Q8MuCDIo4JZmj2IVIYVnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jQklbqBF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MOwl+3RRY6hxipxxoc7tx76VBhuRwRCiipNgIx+NOyw=; b=jQklbqBFpGHK1wDK
	vjkNxGjl6RAxQS9DO47Bsw2jtozWJttx6ZB4jIWFlJpRpK2hNZYeXEoBPiHntqEqgMk9qr2S/wkHf
	KFXGqkrQlvZZQb1C5b2aVG7h281MAvIwN4fJLGZ/XMB8chosS6aQ1TEYKVGY0kgkd9/ptY8Ltux5i
	31krpcPcsyNjVqGoyQK2ZAMS/Sx4xTEOmrKbY3KkScxEkXyJd4Q7IaUr8onugrJJxkhE7NoGStCVZ
	gnlOo56gLspSWEXJqxFtkgS1G2k3KYAmuIZ5zGjEdPLB1is79sYeK4RQY/0ITaMb3Gq3vcpRtpysx
	bH+o5fdUxvaPTEFXuA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tCKf4-000ISC-1X;
	Sat, 16 Nov 2024 15:24:34 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] intel/fm10k: Remove unused fm10k_iov_msg_mac_vlan_pf
Date: Sat, 16 Nov 2024 15:24:33 +0000
Message-ID: <20241116152433.96262-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fm10k_iov_msg_mac_vlan_pf() has been unused since 2017's
commit 1f5c27e52857 ("fm10k: use the MAC/VLAN queue for VF<->PF MAC/VLAN
requests")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 120 --------------------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h |   2 -
 2 files changed, 122 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 98861cc6df7c..b9dd7b719832 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1179,126 +1179,6 @@ s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid)
 		return vid;
 }
 
-/**
- *  fm10k_iov_msg_mac_vlan_pf - Message handler for MAC/VLAN request from VF
- *  @hw: Pointer to hardware structure
- *  @results: Pointer array to message, results[0] is pointer to message
- *  @mbx: Pointer to mailbox information structure
- *
- *  This function is a default handler for MAC/VLAN requests from the VF.
- *  The assumption is that in this case it is acceptable to just directly
- *  hand off the message from the VF to the underlying shared code.
- **/
-s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
-			      struct fm10k_mbx_info *mbx)
-{
-	struct fm10k_vf_info *vf_info = (struct fm10k_vf_info *)mbx;
-	u8 mac[ETH_ALEN];
-	u32 *result;
-	int err = 0;
-	bool set;
-	u16 vlan;
-	u32 vid;
-
-	/* we shouldn't be updating rules on a disabled interface */
-	if (!FM10K_VF_FLAG_ENABLED(vf_info))
-		err = FM10K_ERR_PARAM;
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_VLAN]) {
-		result = results[FM10K_MAC_VLAN_MSG_VLAN];
-
-		/* record VLAN id requested */
-		err = fm10k_tlv_attr_get_u32(result, &vid);
-		if (err)
-			return err;
-
-		set = !(vid & FM10K_VLAN_CLEAR);
-		vid &= ~FM10K_VLAN_CLEAR;
-
-		/* if the length field has been set, this is a multi-bit
-		 * update request. For multi-bit requests, simply disallow
-		 * them when the pf_vid has been set. In this case, the PF
-		 * should have already cleared the VLAN_TABLE, and if we
-		 * allowed them, it could allow a rogue VF to receive traffic
-		 * on a VLAN it was not assigned. In the single-bit case, we
-		 * need to modify requests for VLAN 0 to use the default PF or
-		 * SW vid when assigned.
-		 */
-
-		if (vid >> 16) {
-			/* prevent multi-bit requests when PF has
-			 * administratively set the VLAN for this VF
-			 */
-			if (vf_info->pf_vid)
-				return FM10K_ERR_PARAM;
-		} else {
-			err = fm10k_iov_select_vid(vf_info, (u16)vid);
-			if (err < 0)
-				return err;
-
-			vid = err;
-		}
-
-		/* update VSI info for VF in regards to VLAN table */
-		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi, set);
-	}
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_MAC]) {
-		result = results[FM10K_MAC_VLAN_MSG_MAC];
-
-		/* record unicast MAC address requested */
-		err = fm10k_tlv_attr_get_mac_vlan(result, mac, &vlan);
-		if (err)
-			return err;
-
-		/* block attempts to set MAC for a locked device */
-		if (is_valid_ether_addr(vf_info->mac) &&
-		    !ether_addr_equal(mac, vf_info->mac))
-			return FM10K_ERR_PARAM;
-
-		set = !(vlan & FM10K_VLAN_CLEAR);
-		vlan &= ~FM10K_VLAN_CLEAR;
-
-		err = fm10k_iov_select_vid(vf_info, vlan);
-		if (err < 0)
-			return err;
-
-		vlan = (u16)err;
-
-		/* notify switch of request for new unicast address */
-		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort,
-						 mac, vlan, set, 0);
-	}
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_MULTICAST]) {
-		result = results[FM10K_MAC_VLAN_MSG_MULTICAST];
-
-		/* record multicast MAC address requested */
-		err = fm10k_tlv_attr_get_mac_vlan(result, mac, &vlan);
-		if (err)
-			return err;
-
-		/* verify that the VF is allowed to request multicast */
-		if (!(vf_info->vf_flags & FM10K_VF_FLAG_MULTI_ENABLED))
-			return FM10K_ERR_PARAM;
-
-		set = !(vlan & FM10K_VLAN_CLEAR);
-		vlan &= ~FM10K_VLAN_CLEAR;
-
-		err = fm10k_iov_select_vid(vf_info, vlan);
-		if (err < 0)
-			return err;
-
-		vlan = (u16)err;
-
-		/* notify switch of request for new multicast address */
-		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort,
-						 mac, vlan, set);
-	}
-
-	return err;
-}
-
 /**
  *  fm10k_iov_supported_xcast_mode_pf - Determine best match for xcast mode
  *  @vf_info: VF info structure containing capability flags
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index 8e814df709d2..ad3696893cb1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -99,8 +99,6 @@ extern const struct fm10k_tlv_attr fm10k_err_msg_attr[];
 
 s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid);
 s32 fm10k_iov_msg_msix_pf(struct fm10k_hw *, u32 **, struct fm10k_mbx_info *);
-s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *, u32 **,
-			      struct fm10k_mbx_info *);
 s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *, u32 **,
 				 struct fm10k_mbx_info *);
 
-- 
2.47.0


