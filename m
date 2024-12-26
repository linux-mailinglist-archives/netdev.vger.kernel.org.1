Return-Path: <netdev+bounces-154300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B59FCB55
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FB4188206D
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5B1D1F6B;
	Thu, 26 Dec 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Pxtdpr2w"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80599647;
	Thu, 26 Dec 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735222178; cv=none; b=syWdPyvCqmrQ5wdkFgbONsA8SpGQQm23eivqiVW2XsOCmRC3i8kW3k0Zs4+ODZvZGUQvS1CUdSgzpoL3KacHHXT+65B6HxLNFfahc6b7IAECPaWtWfI1BtLNhBSHlChLPCstBi8N3ywnz8UHy5DYLJcxCjMNqovQaTNAlfbQpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735222178; c=relaxed/simple;
	bh=BJzrw74EndrPPXS4tjkut+DXSBdGyJ0cd+6p2kSCjHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBtqYA7ZxlWkrayrJ+UrdLxjxNTzWDrngKct8fn1GyIfVv6CBTv3rqEi9enU3cfoOSjBLplXtqshX2TjgxSJwHe4xtD7x94QiBIU//wV7Tm/znO9ZSXl8Mra5rEiDdmnyQN7ubCdgdMdjy0LT+djYw8U3BMmJTtXjYDoAOrPBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Pxtdpr2w; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kNbPgneaX7GZilz8mvKDzcGBDi52SBp2xJS4zJPPs40=; b=Pxtdpr2w3Q9gLjAg
	XMUhvi61B3+tWBJP2JP9QY2v0qkBDIjZjCxYv1RkAktWjtwn3y/05DYyawCdegr9gtIp/WH8kmlbl
	qu2pBR9T6QHM8EzZMKY3J4oFJEBXFGliZHnCG2GzMgvvP03lfFKCMrfoaL1Vs4aB9VRcjCMbpeqZP
	WpmRD5TCpXsNj9BLExuywX9iGgiAy/dDbttXsj4h93MUk8JgFygvL/Xs9GEUCEp0lkjA3kuAm5JQ4
	gOBZNMEoQZVyzIlYkrFnv2JrJnOclwyBmf9OFGcePg1rX/yFeOjW2C7Hsmv7PvKNBkSA41nqnPSEU
	znT+qyMr2ww/SjSLdQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQoYG-007HlI-1k;
	Thu, 26 Dec 2024 14:09:24 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Date: Thu, 26 Dec 2024 14:09:23 +0000
Message-ID: <20241226140923.85717-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")

but has remained unused.

The functions it references are still referenced elsewhere.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |  1 -
 drivers/net/ethernet/intel/ixgbevf/mbx.c     | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 130cb868774c..a43cb500274e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -439,7 +439,6 @@ extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
-extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
 extern const char ixgbevf_driver_name[];
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
index a55dd978f7ca..24d0237e7a99 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
@@ -505,15 +505,3 @@ const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy = {
 	.check_for_ack	= ixgbevf_check_for_ack_vf,
 	.check_for_rst	= ixgbevf_check_for_rst_vf,
 };
-
-/* Mailbox operations when running on Hyper-V.
- * On Hyper-V, PF/VF communication is not through the
- * hardware mailbox; this communication is through
- * a software mediated path.
- * Most mail box operations are noop while running on
- * Hyper-V.
- */
-const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops = {
-	.init_params	= ixgbevf_init_mbx_params_vf,
-	.check_for_rst	= ixgbevf_check_for_rst_vf,
-};
-- 
2.47.1


