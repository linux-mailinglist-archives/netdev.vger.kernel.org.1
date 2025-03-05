Return-Path: <netdev+bounces-171883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC2A4F313
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52307188FB84
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC3154C1D;
	Wed,  5 Mar 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+4FerY2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30286330;
	Wed,  5 Mar 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136049; cv=none; b=Spis4RyWQyxuywe281RhC2ln6FR9cYCGEhso2JjHrT+JK8JCTcqsiG4Ien5ODMr0egL42ILJNt4ded96sJiGB45to0hqqaKHudHNvfI14TAojc8vrHfoaTL8xClcDPrSYM7ip3pygISJL4b5u+nEuB3QQHy27cYol8ed2gQ0aqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136049; c=relaxed/simple;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVDTbmMAUuxApc9qBJDrX6eWCmUw58Cwg7sXDE1reKSKPiif6BIy4H5Ju5eaZ2lqq5kVUJS/ISBI1z9LH9aDixkcF2Zi+bJRaU74yjv/ZDnWN05lHb5N0F9eTvTfLEcUC6gLLcI5j+3aCRvsZXwRPsIFMCm3YkYgDmW3Er2tmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+4FerY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B78C4CEED;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136048;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m+4FerY2dgXcUIvlTGXbp9YG/8lS95WPeDf22XP68JglH4HeBLzvLZByocjuHRc6j
	 Of9RoMe3TkXJpbrF8MSutYfAulmdgziidjOESGhTJSqM7Q6YxccfDiTwoSTLnWM1Lq
	 SCSWzsj/s7IX+nTOtnAft4HBdLfBnfa3Ud9fIfykhECXsflVnAPMBxVGJrva+gynTZ
	 McTEmH/dYstzEB9ChkxKQgPz/XglS2UrBBObX1tlGhs0ZI0qrGnUddie4lSc6oOz8f
	 JUNde3mtv9Tk4oecFswDAwPmE5iDoSepjNrszNCx+mR0BFN1MUCTDhqm8/a3GGOjKC
	 EbHKWnaes+aLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF08C282DC;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Tue, 04 Mar 2025 19:56:41 -0500
Subject: [PATCH net-next v2 5/8] enic : remove unused function
 cq_enet_wq_desc_dec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-enic_cleanup_and_ext_cq-v2-5-85804263dad8@cisco.com>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
In-Reply-To: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741136202; l=1103;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=+dPGv5N9MWqWyMEvqnn1fc2Fu6Bu+7Wi7gCqqsYQK6M=;
 b=VUI8+9j9uSWTnuX0XkDjSnpylJM3UmNKFGC2BgFkqo51jBGh6s0MF6lZxQGvgwP0oNuEo9ecf
 BkoPODpIiujDxscGTYHs3kaauq7nDlkK+AocADPC2p3vnVManRBN2vq
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Removes cq_enet_wq_desc_dec, not needed anymore.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
index 809a3f30b87f78285414990a2a42c9a30a8662c6..50787cff29db0cc9041093521385781cf557e4cc 100644
--- a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
@@ -17,13 +17,6 @@ struct cq_enet_wq_desc {
 	u8 type_color;
 };
 
-static inline void cq_enet_wq_desc_dec(struct cq_enet_wq_desc *desc,
-	u8 *type, u8 *color, u16 *q_number, u16 *completed_index)
-{
-	cq_desc_dec((struct cq_desc *)desc, type,
-		color, q_number, completed_index);
-}
-
 /*
  * Defines and Capabilities for CMD_CQ_ENTRY_SIZE_SET
  */

-- 
2.48.1



