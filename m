Return-Path: <netdev+bounces-252442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEJ+Oh5Wcmk7iwAAu9opvQ
	(envelope-from <netdev+bounces-252442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:53:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 612296A65F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBFDE3014A2E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03763EB20B;
	Thu, 22 Jan 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDMuJOzr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F630C62F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099150; cv=none; b=tbFL1gJESK9jl/+SHL9C0uhU8cbWkwwBd0YgwKG6rNHpdr7okvOhiYd5ga22rUK17AmfS9FdbURz3jSsJjrAnXWpDEBqFQuFkxCHIpq7XiSLQBF4o7BOl0sWGgM+SjEQoxMC6OdoOh1E551PozG2GJ9dFUqsxlkVssqSqvR464A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099150; c=relaxed/simple;
	bh=w9jjE/827GDIiy15D5+mRoXR0bkspeO497qEu/hDD18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/2VTZfvrvDAIj5r11RZYgzRfPUXQ1TbLyxWy7KemYCzbsRqbTdAWcEtPhILo+5RHNjKQ4UHjfDz7VChej+7wSrmI+bTt46A4b8HgsZe3hVmhGmQdVO6zMiUzvI6dS3nDEHNXHRW3NytdKDENMlV6h6G1EGmamnX9yDEAnWbd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDMuJOzr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769099145; x=1800635145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w9jjE/827GDIiy15D5+mRoXR0bkspeO497qEu/hDD18=;
  b=GDMuJOzrAOCW5s25s1KXi+MU3IKdCl418rDQMF/ts164W7TbUjNz0xkL
   Q9CHng1iL+Z9yl1tPu4bEKcoJ4Z8uP74cAqaLwPq1fhPZqMohMCNhLjDw
   bC5uCgMN5LRcObZljDvxwtxtpJk1AvJfkAtOZkNS5+2iZKKfzyz/bJqvn
   oN6P28/ULW4txzBi2Y286xvyOWL7wgNevTsl0/wIc8cB1i4Ulp1kX8k0Q
   IAtq8ZIpOm+IhjRw4bjzIbDQyUzl3L6uWRNufM7iT7Gazcvow6jko9bZt
   E3gGA5XjMDUOoao8pNxEuuXbnIlWJfie5bzOTd1BCfmQ/7ouxUca0zIbO
   A==;
X-CSE-ConnectionGUID: vuXC5WGaQOC4ACXCn16xPA==
X-CSE-MsgGUID: UOZAuW6aR7OKDFoQ7xAMbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93013897"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="93013897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:25:40 -0800
X-CSE-ConnectionGUID: +PzVEmp9R32gEgTFtX3CPA==
X-CSE-MsgGUID: KQ0/2GylQeatCx8vV5pmGQ==
X-ExtLoop1: 1
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2026 08:25:38 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 1/2] ixgbe: e610: Convert ACI descriptor buffer to little endian
Date: Thu, 22 Jan 2026 17:46:32 +0100
Message-ID: <20260122164632.112607-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252442-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 612296A65F
X-Rspamd-Action: no action

The ixgbe device registers/descriptors expect little-endian ordering. Make
the code aware that the e610 adapter operates on data with little endian
ordering. The extra conversion is required on big-endian hosts. In most
scenarios this conversion is not required.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189..f494e90 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Descriptor is written to specific registers */
 	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
+		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
+				le32_to_cpu(raw_desc[i]));
 
 	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
 	 * PF_HICR_EV
@@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
 	}
 
@@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
 	}
 
-- 
2.47.1


