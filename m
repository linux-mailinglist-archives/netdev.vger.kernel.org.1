Return-Path: <netdev+bounces-115819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F58947E27
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE1B1F20226
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8C5339D;
	Mon,  5 Aug 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOJ33s1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFD2BCF7;
	Mon,  5 Aug 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871972; cv=none; b=S8a06pnv4tKtyC8qglpK9lVz/Y00pjRSoR3lswwU0jdWysJGZpQZXuNMCTt27XUg1j5QrC1+FMJkwAwMVfgLiJJmeGCnKFsXDBCbdyUMqoDvd+p42llu8/R77ZMzp79ptE/xEhDtB6fSTrh1wfHjujCoiz5aT/RqJas8HF7ZEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871972; c=relaxed/simple;
	bh=h/7X12A81EhfvIeA9+iacrDIRb8js1iGxOgkAsdUCX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sVuUT9qyKLUCe92+EAtQi/pV6g+a4T4w3+N9KbjkgvJ+t0vVUVZkVEt4gr3RootkigY9VErhY9T4j/b3xR9Q/Tjxn4rd3vOJr/mnwCDmoiBRGAep5nuNlWc2NiKf4AKBfjSn6ynmLPfoGy6MHhaLAbSKZAnoh5/pGnEQEOpIuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOJ33s1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A5FC32782;
	Mon,  5 Aug 2024 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871972;
	bh=h/7X12A81EhfvIeA9+iacrDIRb8js1iGxOgkAsdUCX4=;
	h=Date:From:To:Cc:Subject:From;
	b=DOJ33s1TJVCb3zQgkzN4m76kmakm/Qwn7f+aSAWYj/tC+oFXHDNX1mhVEwGG5mNQC
	 8MAnowyESbYWjoD4r0KpB3wBgAfNk0XJbSxDkxalEa+hUwI6R+n7ZjV1UNLv8sLQdy
	 0hviqiNGtquJSZsl9MzUTcyRYvg2mDUypjqncrJBsX7P4xOxKtB0YQ1nat+nRSXpa2
	 Qc4R+XdHdvcUXzk6xrQ7arkMD7VvrVK6zGir3CdxMqkQ8dr+zu1+2hmjIowus5FRYm
	 IZsiwfbuDe4gnx3HI+zTZvJoJjBzJsAL4/Xvq8ymWhy7nmM4+m0H5Tr9Ec+qXOK4nJ
	 /3nsZBa1zQwwA==
Date: Mon, 5 Aug 2024 09:32:49 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: atlantic: Aavoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZrDwoVKH8d6TdVxn@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct hw_atl_utils_fw_rpc` ends in a flexible-array member
through `struct offload_info fw2x_offloads;`

Fix the following warnings:
drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index f010bda61c96..a66cd784f90e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -194,10 +194,12 @@ struct aq_hw_s {
 	u32 rpc_addr;
 	u32 settings_addr;
 	u32 rpc_tid;
-	struct hw_atl_utils_fw_rpc rpc;
 	s64 ptp_clk_offset;
 	u16 phy_id;
 	void *priv;
+
+	/* Must be last - ends in a flex-array member. */
+	struct hw_atl_utils_fw_rpc rpc;
 };
 
 struct aq_ring_s;
-- 
2.34.1


