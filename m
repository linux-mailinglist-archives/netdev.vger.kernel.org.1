Return-Path: <netdev+bounces-148402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC49E160D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CE7B243CC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C71D279F;
	Tue,  3 Dec 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXUHrhhL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CC1CDA17
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214487; cv=none; b=ACqRY5MdxACvKgQKkDH2u/xnaJbaAJAz+ZDZwd3C6A/hbx77oiUaMVNZrK0qaAJdfsJShVJUvDxmuuidrc//RXpSsxE/j8MlOWVoQlnq3aVqnRnjQC7u76Mc/xJ3GX40neU2pWvgqNWjP0VhKO0GJC36o+4TK96FWzwx2eULkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214487; c=relaxed/simple;
	bh=II6l3Ydybgfvkv2hN8JeiJTpharRPOZoUX5XEw8lMwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNg1WtERMrNjhXREHZ/837qck8c7fpugkIE+zsj/cCcbmZ1MgclkOIRPrSLbcGpixQOELSUmDAMSoEa0u28Dd+xPb/mXobPD1f9w5c5v5Djegz213FriDC9mEn4ghuu5xDV4F0DlR3vfFgShIplJLe11stYBI/C+oP5lveF8/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXUHrhhL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733214486; x=1764750486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=II6l3Ydybgfvkv2hN8JeiJTpharRPOZoUX5XEw8lMwc=;
  b=JXUHrhhL0f6bpV2JECEuMMPE6Him7bvqunkbHATR2x0kzjjx7dzAgCur
   O2kIqBuNWAeh//bzNeGBT+/NyKZMGnMti3oWFlCLZUz6QaLFF3yLIW7iN
   eYn4GeEHUJW3H8Qxk+qVa4uf2uTE2UZsX2OTZwzh836MCzKqmEh9/JrFT
   2s1l4GvK1gEc3pW/MPCvBB4poU5B1DyIN9llWnnJ6a4OS29AUWyszjSko
   yqVRHRPn0CnDRflSeFP3LeuZ1NDAQYtOHVPoQRH/JueRpjjqKTROTzSci
   sx42/H5X35BARKni5D8a5SbPvprZGrtsKV7uQ06kfmR8jQf+kBP25tYQf
   A==;
X-CSE-ConnectionGUID: J9hNEIjNQnCGZF4ug4zAFQ==
X-CSE-MsgGUID: om7Ec5wQQd6W7mpN+dOoCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44081447"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44081447"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 00:28:05 -0800
X-CSE-ConnectionGUID: hAoOTeqKR8Kh+8bWRhxIuw==
X-CSE-MsgGUID: TgTOXg0SSZ24Wwm0Y74H8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93820710"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 03 Dec 2024 00:28:03 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.131])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 141552876E;
	Tue,  3 Dec 2024 08:28:01 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH iwl-next] fixup! ice: dump ethtool stats and skb by Tx hang devlink health reporter
Date: Tue,  3 Dec 2024 09:25:33 +0100
Message-ID: <20241203082753.4831-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan has reported [1] than @event variable is dereferenced before the check
against NULL, fix that.
[1]: https://lore.kernel.org/intel-wired-lan/b1453276-9043-49c4-a603-9b6bb41306c7@stanley.mountain

Tony please squash this into my devlink-health series (no need to amend
commit message) that is in your dev-queue.
The last version of the whole series was send here:
https://lore.kernel.org/netdev/20240930133724.610512-1-przemyslaw.kitszel@intel.com

CC: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index c7a8b8c9e1ca..d9b852ccf99e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -163,11 +163,10 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	struct ice_tx_hang_event *event = priv_ctx;
 	struct sk_buff *skb;
 
-	skb = event->tx_ring->tx_buf->skb;
-
 	if (!event)
 		return 0;
 
+	skb = event->tx_ring->tx_buf->skb;
 	devlink_fmsg_obj_nest_start(fmsg);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);

base-commit: 9e11d56a825f5e927039c285df38c22c20dcb757
-- 
2.46.0


