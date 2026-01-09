Return-Path: <netdev+bounces-248404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE776D0831A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92BD3302AF99
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6493596E6;
	Fri,  9 Jan 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czX2GjCA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C53590DD
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950971; cv=none; b=pwtQoxX7kbBG72WXF4OpSWDmuBhb0zdgPWD0OzWFH2Wu38dyWpoUcrOzUKlrQTvXpoJC2eu00r8D+cHKF42JstYxEu9h1Yae3YXRn8J4v4QJNR1xnRzXuwoe/OA0VFBqterMGWrc64rHGlmpa0Yhc9d57++3rvgxERSB+BjDXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950971; c=relaxed/simple;
	bh=F8KU75i1fjmpG4l5aTfjbV+GEVEuy07tlxmJFSjhreU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUbakqFy44wisObLE/9PECLWpLrKJrU6G54Fqq1lTWqP5A/ii2QLpR1ZZ8kyVTKd1H5Fpyfy6LAe2BMnLw7K5TXGXALuDADCy+0xDWlP7MptUFf+6OSJhxi90gy70wWaSVsSMfsc631M1GUUemfAQ1xD3yefrBqyTO/npkDNHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czX2GjCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C661CC4CEF1;
	Fri,  9 Jan 2026 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767950971;
	bh=F8KU75i1fjmpG4l5aTfjbV+GEVEuy07tlxmJFSjhreU=;
	h=From:Date:Subject:To:Cc:From;
	b=czX2GjCAeKk37ahXBnQsU480j02YUGaX/yrFmxCnr8yj8jKljqUXAJTYQQ2moaEiP
	 EG0bUvNe75IGzsZhYZcYogfPCZdMuImCSQxPm3KMgpJChp8ZnjZea80DfmsGWoP+ZG
	 Kv0lVd49uHyi3wJgNqj+XC7IHrqAQY7VTJnAraN4HySSh5Es8681rLiZmlXP/EHEgd
	 O1Hcj6dSaYRSRTWKhZLQGVpUu237PHSOl3WJtZDfzS3pll05AT8hMOBVSYXNyTDSMN
	 iiUYEmL9bIg1Omx8tGKLkGvbKg8SoMzxRRbCKD69uOfu2rClZKriAmZNYVAD9lfSG0
	 Z3Q5Mv20TOjSQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 09 Jan 2026 10:29:06 +0100
Subject: [PATCH net] net: airoha: Fix typo in airoha_ppe_setup_tc_block_cb
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-airoha_ppe_dev_setup_tc_block_cb-typo-v1-1-282e8834a9f9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBA0auUWRtIgrTqVUSGZDraQWmGJC2W0
 rsbXL7N/zsUzsIFbt0OmVcpkuYGd+qApjC/2MjYDN763jp7NUFymgKqMo68YuG6KFbC+En0Roq
 mbpoM03COIbiLHxhaSzM/5fv/3B/H8QMG8jevdwAAAA==
X-Change-ID: 20260109-airoha_ppe_dev_setup_tc_block_cb-typo-ec74baa1827e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2

Fix Typo in airoha_ppe_dev_setup_tc_block_cb routine definition when
CONFIG_NET_AIROHA is not enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601090517.Fj6v501r-lkp@intel.com/
Fixes: f45fc18b6de04 ("net: airoha: Add airoha_ppe_dev struct definition")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/soc/airoha/airoha_offload.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index ab64ecdf39a06dd1ceb461fafc5e1437edb6141c..d01ef4a6b3d7cef2e8dd0cbaf183fd6cc040c45b 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -52,8 +52,8 @@ static inline void airoha_ppe_put_dev(struct airoha_ppe_dev *dev)
 {
 }
 
-static inline int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev,
-					       void *type_data)
+static inline int airoha_ppe_dev_setup_tc_block_cb(struct airoha_ppe_dev *dev,
+						   void *type_data)
 {
 	return -EOPNOTSUPP;
 }

---
base-commit: fc65403d55c3be44d19e6290e641433201345a5e
change-id: 20260109-airoha_ppe_dev_setup_tc_block_cb-typo-ec74baa1827e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


