Return-Path: <netdev+bounces-154787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA69FFCD1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA04D3A2E65
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832F1865E9;
	Thu,  2 Jan 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cjgLBWE+"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53817CA1D;
	Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839462; cv=none; b=MnRhXf4nRrDcqhC5vQQlgVpFKF+Aw7VwL/3s+t6P6zWLxu8+C1GslYE0NxL6rACC8BkuXYyXPGLVm4dj2ydZK3VTHBYFkpFZOxGGiN434ftTSMxtaAJBZ5XLmNoWRGMAcbr13O1rvw1RpKmeUrX1UonCz+YCpZJNtb2jxHKDN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839462; c=relaxed/simple;
	bh=6D+qVXt+if69Ak1Tp7vDfLqm1tFNmkM4gIg9Y3dvZJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLjJ5JJ4DEvVXg02CcdaNA9CdTFY0RtDsBdBFqE2v9+dR/YafARXwOFhhPLSWTZBwkxPzb9U3GPNBljIRGU9h4sFFVbkX2u4xFr8aLWkaIMGdsoFShz21eHdeB2dUxofnDsfc0YmO4X8n8LFnn0O4Ad92PbvlxqBnqQVSGYOfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cjgLBWE+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VIOsW7CThUdxqZazplbAYuS4wCenu5gwxB082K8tTE8=; b=cjgLBWE+AQGwouVE
	S5vDwc9ZaGxooRFqKMUjY4+++UEKig701HZLmcI8O0QBQP2TlKUi8bYtelzl7KlmcXWFHhVX2JBP0
	6oHlvI7kl0W2fti64GLzmrIxv8POg0xcbNaibJ967G8tuySRt45SaMGbzYoc7UbrD9XHrnMCyPD/n
	hgdg/bxJ3qnE++npjxllU0FEG4YB5QjMLHR/nJJslEUx1GDViPuH+AbFA9s2B4OPuAf8YdybLk+L3
	L3lvR39p44H/rH81uF2TenLyc8VRhif9ppBTzEB7glsxbo1Kqf2ClLCnmAFIU9XK0obcywgDbkNUc
	UdIzLCC0hkgnVhjSsw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8P-007tod-0F;
	Thu, 02 Jan 2025 17:37:25 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 8/9] i40e: Remove unused i40e_asq_send_command_v2
Date: Thu,  2 Jan 2025 17:37:16 +0000
Message-ID: <20250102173717.200359-9-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

i40e_asq_send_command_v2() was added in 2022 by
commit 74073848b0d7 ("i40e: Add new versions of send ASQ command
functions")
but hasn't been used.

Remove it.

(The _atomic_v2 version of the function is used, so leave it).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c    | 10 ----------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index f73f5930fc58..175c1320c143 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1016,16 +1016,6 @@ i40e_asq_send_command_atomic_v2(struct i40e_hw *hw,
 	return status;
 }
 
-int
-i40e_asq_send_command_v2(struct i40e_hw *hw, struct i40e_aq_desc *desc,
-			 void *buff, /* can be NULL */ u16  buff_size,
-			 struct i40e_asq_cmd_details *cmd_details,
-			 enum i40e_admin_queue_err *aq_status)
-{
-	return i40e_asq_send_command_atomic_v2(hw, desc, buff, buff_size,
-					       cmd_details, true, aq_status);
-}
-
 /**
  *  i40e_fill_default_direct_cmd_desc - AQ descriptor helper function
  *  @desc:     pointer to the temp descriptor (non DMA mem)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index ccb8af472cd7..099bb8ab7d70 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -27,13 +27,6 @@ i40e_asq_send_command(struct i40e_hw *hw, struct i40e_aq_desc *desc,
 		      void *buff, /* can be NULL */ u16  buff_size,
 		      struct i40e_asq_cmd_details *cmd_details);
 int
-i40e_asq_send_command_v2(struct i40e_hw *hw,
-			 struct i40e_aq_desc *desc,
-			 void *buff, /* can be NULL */
-			 u16  buff_size,
-			 struct i40e_asq_cmd_details *cmd_details,
-			 enum i40e_admin_queue_err *aq_status);
-int
 i40e_asq_send_command_atomic(struct i40e_hw *hw, struct i40e_aq_desc *desc,
 			     void *buff, /* can be NULL */ u16  buff_size,
 			     struct i40e_asq_cmd_details *cmd_details,
-- 
2.47.1


