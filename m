Return-Path: <netdev+bounces-200697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C110CAE68E5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691BA189098F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086092D322D;
	Tue, 24 Jun 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR647Kj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75112D1F44
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775332; cv=none; b=O2sVfN/9qOQtTTb0LyqkzCP3s0iE1vDa+MRTsBH4exTRwmI8OFG5cABmgrLu4IYFzB0jVdZpaFx9PUs7idLHNm0GMlr26RRhXLi9tD3Ks6otvmO+TVMEVE/gDwjUOLCOajyZH9Q6v0l/J3jsexJIwIxJ8uVZduErN8XXGIomOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775332; c=relaxed/simple;
	bh=i8LCP0kG93vofjGJZNiTqrprLszdFbbN93YujLWYy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvXp6S9nmJH4MyjNsvyy+zKjmhwUaCSu32OYVvuYDrIcSy9Fmo7PiaS72UmX69DoWM0Gywid9Esq8gAEceqaw0mW/XtXiP53f0PPOeIWRzC4Q8iXKkl4XvDgovgPJ8VcJ3B6MxsbaXpVfR/n4QZxKn7g6Kh9ulQUh2KjufNFEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR647Kj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11259C4AF0B;
	Tue, 24 Jun 2025 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775332;
	bh=i8LCP0kG93vofjGJZNiTqrprLszdFbbN93YujLWYy4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RR647Kj7CweGT0WMAEdlGg0Z397r0HYU/ZaH3MJ731XnMTGeVExCXNUcPMJz1Tiq+
	 ZEjETEvfED2B5/5JnnoazpFuIwUk3B7gBkLdGFa0+M0Bz2MvzR5SMfhwY073bFa2rh
	 RjaF0N/xdArtEnt21K6roXGwf6gEgnYPg5CDyvPeBSw1EF3zJtaABRWLVA2Zu8hRGm
	 jbB9mrnvNCw3FVHh7mMN+JD27v/WDg9iz213LWjmpOY8Gl1oEFea7Aagi9Wqq28KIC
	 zD8/n5cm5JWTWydmnFoJW64DcWa8eNN0EuqPuVlSptJjzgxJLB0CxId0UkuNFTJiTu
	 1kMzJaEGz99kw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] eth: fbnic: rename fbnic_fw_clear_cmpl to fbnic_mbx_clear_cmpl
Date: Tue, 24 Jun 2025 07:28:34 -0700
Message-ID: <20250624142834.3275164-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_fw_clear_cmpl() does the inverse of fbnic_mbx_set_cmpl().
It removes the completion from the mailbox table.
It also calls fbnic_mbx_set_cmpl_slot() internally.
It should have fbnic_mbx prefix, not fbnic_fw.
I'm not very clear on what the distinction is between the two
prefixes but the matching "set" and "clear" functions should
use the same prefix.

While at it move the "clear" function closer to the "set".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  4 ++--
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |  4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 20 +++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index f3ed65cf976a..555b231b38c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -66,6 +66,8 @@ void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 int fbnic_mbx_set_cmpl(struct fbnic_dev *fbd,
 		       struct fbnic_fw_completion *cmpl_data);
+void fbnic_mbx_clear_cmpl(struct fbnic_dev *fbd,
+			  struct fbnic_fw_completion *cmpl_data);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
@@ -81,8 +83,6 @@ int fbnic_fw_xmit_fw_write_chunk(struct fbnic_dev *fbd,
 int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
-void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
-			 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 4c4938eedd7b..c5f81f139e7e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -182,7 +182,7 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
 	else
 		err = -ETIMEDOUT;
 
-	fbnic_fw_clear_cmpl(fbd, cmpl);
+	fbnic_mbx_clear_cmpl(fbd, cmpl);
 cmpl_free:
 	fbnic_fw_put_cmpl(cmpl);
 
@@ -300,7 +300,7 @@ fbnic_flash_component(struct pldmfw *context,
 						   component_name, 0, 0);
 	}
 
-	fbnic_fw_clear_cmpl(fbd, cmpl);
+	fbnic_mbx_clear_cmpl(fbd, cmpl);
 cmpl_free:
 	fbnic_fw_put_cmpl(cmpl);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index ab58572c27aa..1d220d8369e7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -338,6 +338,16 @@ static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
 	return err;
 }
 
+void fbnic_mbx_clear_cmpl(struct fbnic_dev *fbd,
+			  struct fbnic_fw_completion *fw_cmpl)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+	fbnic_mbx_clear_cmpl_slot(fbd, fw_cmpl);
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+}
+
 static void fbnic_fw_release_cmpl_data(struct kref *kref)
 {
 	struct fbnic_fw_completion *cmpl_data;
@@ -1263,16 +1273,6 @@ struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
 	return cmpl;
 }
 
-void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
-			 struct fbnic_fw_completion *fw_cmpl)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
-	fbnic_mbx_clear_cmpl_slot(fbd, fw_cmpl);
-	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
-}
-
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *fw_cmpl)
 {
 	kref_put(&fw_cmpl->ref_count, fbnic_fw_release_cmpl_data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 5ff45463f9d2..fd8d67f9048e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -796,7 +796,7 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 
 	*val = *sensor;
 exit_cleanup:
-	fbnic_fw_clear_cmpl(fbd, fw_cmpl);
+	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
 exit_free:
 	fbnic_fw_put_cmpl(fw_cmpl);
 
-- 
2.49.0


