Return-Path: <netdev+bounces-170471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8DA48D56
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA5716F4ED
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750E3595B;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt1BeSes"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC821364;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702542; cv=none; b=YExz6NMlhWVTgNVnexaVYm+lsp06HvTZjdybp6Z6EELdIVRhU+R1112IC1wU2Zd1IIT8SDjD33E4weS9IHGiGwXqQAGliqR1lcvdzjHZCRGJU1Q+fFEeLZ3MHdNLm+LWZz+PyHa2SklkZYTHaec7fLQoh+KcU8axMTyABNSekR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702542; c=relaxed/simple;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOCNOXJjgMBluACYcpSozZ0/+tUNthvbMLXPr6xtZ3x8+lmleu+mcMUrcA+5I86XS9hlZ1Hq4ZyU45LUkbgpBiP6AIkKqnXYQzN+lVe0HsE2VKUw7Z+3/Mi+44J5vF19UAYMh10hvmB4aO+ScRqmf/pX+bVemBdWC5znlGF0A4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt1BeSes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48A9DC4CEEA;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740702542;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zt1BeSes5RoL4diM0CN3bNrEadCANIyvSYwNyU5S8BZWvu/OkI2V7Qzt8IRT0RUYq
	 Am/N2HQEk2xxzKtEXCh8ay7MB/ALrauUfg+By11X7GHoaTZy2tlb0N8fC17svnKmK6
	 DlAp8pYVuX7/0vM//oN1n9YGqpGQl2TH2DJMe0j06YIv525qbMrYKLOmZtcbOjvnMX
	 igDrK6p+MjXkK+eltJ1/TI0KRV/uZE7dcIOypyYrlMQQkaSUgXxvSxb9XLJ8OBNP73
	 lN9TkZ/miMUh8X+AbOKG8UytCISvIwFgoriSa9lrWgc9s8uhUq4YHrfxMuGA8L85/e
	 KeDMlM50dP60w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA21C19F32;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 27 Feb 2025 19:30:48 -0500
Subject: [PATCH 5/8] enic : remove unused function cq_enet_wq_desc_dec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-enic_cleanup_and_ext_cq-v1-5-c314f95812bb@cisco.com>
References: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
In-Reply-To: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740702696; l=1103;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=+dPGv5N9MWqWyMEvqnn1fc2Fu6Bu+7Wi7gCqqsYQK6M=;
 b=KWA+6iTevuM6VxykwGpIvdzMWcm2zsYvB9CpEIOXq9oPTHmkgkQ9a25+u65xOpBfcoe+PCc4a
 CKb9/SvVB2NC885ngyrWicFXgv15omQJq1AyDKvWwYR6kCW6/vwulgV
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



