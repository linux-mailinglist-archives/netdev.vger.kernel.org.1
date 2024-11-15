Return-Path: <netdev+bounces-145123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73359CD52C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FD1282E11
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210F13A88A;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQYHoVrn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBF126C16
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635636; cv=none; b=ikprk/TW2veexkpbOPOJ6Ff0OCN/j0GIA9isypW9dAWIaXnaEPQx2VJ5/WLw019FX3hd4JR9L9oN5uux64etN9D6VMam5ViCjyQoMuD2XVC+ENGwjbeZANOz+GE8RqlJBWtKMaDmzAVU5zbm92aTCux91L3GJmFPP32oQA75XdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635636; c=relaxed/simple;
	bh=26Fjd3MBkfRlfdCVvaOsCZ/JsM60Wx94WzmlZcUvQFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TON9F27RX36VBKlq8eJibHGxwU1sL8Pdr81PXarlTw21fjAcS7OplBUeSVX/6LCq9m1czOS36epRaVbSrNOnG9keG2FVxwLjyifZo5nEI2aaSjCUkDkXk2JixgPhvxR0Fk7Q6cX5FIf6OXCqHC8H5gnZezNKqlCJig6UKfPzp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQYHoVrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCAEC4CED7;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635636;
	bh=26Fjd3MBkfRlfdCVvaOsCZ/JsM60Wx94WzmlZcUvQFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQYHoVrnzpgYQXg15cHnRryV5E50MFCajayxLGt7Hx6FaZ8uZBkgjP7WlqQBsXSaS
	 7rMk6kag3zMShEo4YuhXmqpMgoVq8mndXtHNn3Yr4digDPofBji6OjynPRPn0c6JD3
	 X0c0c6IHaChXU0k36VEBjmOQe9dVNMLJvwb7BfXhxaMrAZ2h2kYtG7gWJIJgU5yZci
	 UevSPfKkEyVbgw6t/jkwqY9/3thdzb+Hv/BDKSiCaFjSJlIi2h5j4zE5u0gyUeIsQL
	 OGAtB0CF+MOgXenvC7BdvbTnu51bsTckHITp4KzPg+Pfkgh5e/i5to7jbocg+FU5d2
	 SvryJaA+oBt3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: fbnic: add missing header guards
Date: Thu, 14 Nov 2024 17:53:41 -0800
Message-ID: <20241115015344.757567-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
References: <20241115015344.757567-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While adding the SPDX headers I noticed we're also missing
a header guard.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index a2b6e88fc113..199ad2228ee9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#ifndef _FBNIC_HW_STATS_H_
+#define _FBNIC_HW_STATS_H_
+
 #include <linux/ethtool.h>
 
 #include "fbnic_csr.h"
@@ -41,3 +44,5 @@ struct fbnic_hw_stats {
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
 
 void fbnic_get_hw_stats(struct fbnic_dev *fbd);
+
+#endif /* _FBNIC_HW_STATS_H_ */
-- 
2.47.0


