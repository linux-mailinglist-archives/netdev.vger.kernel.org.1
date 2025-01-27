Return-Path: <netdev+bounces-161201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8DA1FFFE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6771887CFB
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261151D86E4;
	Mon, 27 Jan 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Z1hsLN9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF91D7E47;
	Mon, 27 Jan 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013854; cv=none; b=oKSy/amdaCokPrjKEcLTTZGYbzRd8EqYahiCmag8aXIOkMmt7pH412nmCjtNJkHy6wpg9caK/u2OS/HQ+SrBQK7DFhJbhSWJCe34nyDzo50kBhKzl4XRYv1ewFRyvihhQgZSyWRvGgd0Jp+tqp+xvPl8VQmY3XjTThvbn3UKBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013854; c=relaxed/simple;
	bh=FQjxcukhBSRKyXDHqUoaoy0lmOtZ76UZ/VFTLM0hQwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+dHrdwKvQVKVzImlm4wZCv5kqyL1i0fQ2/bua5uk/Tp94XwYmJA19N1mynV2dR5RI4oqs82vd0k8P1NzZ9sBMSKkKz/7EIv3WZadF5jw78lEmBH5c3+R+sF+BDm0DEhNJ4YHE0lh5lMnysVw1JyBQ0LIbh3eVEseY5/+yplMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Z1hsLN9Z; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Q8DeE6I21KdBtXf2UfwnvRGRhf/hWXsyOW9lcfV/klU=; b=Z1hsLN9ZabpWcSwL
	DqYivA9Tj6o0TsyKsvprHs3XDDQP96dN4lf2UbzKrrEjbDs2yRK9+Ucabtoti0Ca5yfvz5cWlKQVS
	yKyGNZHI9dbaeNTMpkf2Ir9UxByypCVdqXJAifMPKphmGtANWXCzJfkrC0JqRvlW9/5Gq4rEJ5vLE
	uuUoip3O/FVExVpMBRgmOEXgAlt2MxXVg9q3TIYkR2nymmlc/1Oo1NsiIrvHNFcG2jolZFlm7vXP8
	IbxnXGMZWUQiHGeLd2z85HxgOlUvRMmtnPXd1EJu+4oRX07jO7Rhi96cocoMTawx0DMSwBzNrzeje
	76HXdVsStVUYbsZzgA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tcWnF-00CMm7-2I;
	Mon, 27 Jan 2025 21:37:17 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] Bluetooth: MGMT: Remove unused mgmt_pending_find_data
Date: Mon, 27 Jan 2025 21:37:15 +0000
Message-ID: <20250127213716.232551-2-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127213716.232551-1-linux@treblig.org>
References: <20250127213716.232551-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

mgmt_pending_find_data() last use was removed in 2021 by
commit 5a7501374664 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/bluetooth/mgmt_util.c | 17 -----------------
 net/bluetooth/mgmt_util.h |  4 ----
 2 files changed, 21 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 17ab909a7c07..e5ff65e424b5 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -229,23 +229,6 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 	return NULL;
 }
 
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->user_data != data)
-			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
-
-	return NULL;
-}
-
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index bdf978605d5a..f2ba994ab1d8 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -54,10 +54,6 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev);
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data);
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data);
-- 
2.48.1


