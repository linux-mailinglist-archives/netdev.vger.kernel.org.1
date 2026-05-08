Return-Path: <netdev+bounces-285592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFusB91U/WkYawAAu9opvQ
	(envelope-from <netdev+bounces-285592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD64F1093
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A463032F66
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F52D738A;
	Fri,  8 May 2026 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOKw2stF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB82D8376
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209956; cv=none; b=fhNC5LvwLpgjoz1kqcX3eSDFKtcfLu4EZoXKj0Gf86aMFFoQVtfgeehHuRLTc0fDcqW/sr5ICHfU4hsynAqHiRuIf7tzbtbYMr3cdtLQM0eP+Nsp0qcQOqjHtwc4Sot8dmWjKsmczhIW802xPNuAKJb93H+YKdb+idgEIZj0Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209956; c=relaxed/simple;
	bh=cyk7C6u2sQlQMQ/Lr6UpLcUYzBBZP3dUYKCPN5FKMgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFuMt+cYfRt7S5qDDthqzMIYhmEVGGW9GljB6ko7thSIcg7iEZM8Z+b2IxZR2b/ERyb3v2njr/XkVZ/CUWD65m4mSpRWWLuSin/48AaLcUqV2M/jwEw2uecDf/7S62hQRA9mWfLGgA0uAaHhD30lLaYXW3U+7xKzLSInXab63O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOKw2stF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209955; x=1809745955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cyk7C6u2sQlQMQ/Lr6UpLcUYzBBZP3dUYKCPN5FKMgg=;
  b=TOKw2stFzwWHzxgJeGgaDDsCk63rAq9uNcDvaCKQ5DH85K/oRj1aZG94
   LJEeDg0PvVHv7ZbQ8cN87TVbM+TuGYg6isw9rEyRWUa3ai0P2ffJxR4SN
   Hh2I3f+EQoPEsE6nupqb7+AOiRnNSqq81favawa12tLoij/lE4lKVy6va
   DHGVYyrxfgBA2dreEtZXua3TNVPErGyPsikCMx5eF1VOimugRxVYEYvxG
   gAPJ6wgtlqJ20PIX8nEZ2xYRKvJGT82G29XKFZ241epHxNbmTCEQkSzLf
   wq6pZLOwoBcRSBXhPBwcl8GrBoS+CRvL9YTC52DO15I00Agy4VTvIw5VL
   A==;
X-CSE-ConnectionGUID: l7yxOJOuQCS7CEG4P/WGbQ==
X-CSE-MsgGUID: 01DvNNYARVe+4JK5g6aW9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027502"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027502"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:35 -0700
X-CSE-ConnectionGUID: 5yJMNqWSQUqKtuGONmWiwQ==
X-CSE-MsgGUID: 7mzQEoI5QO2MZbBwMkcYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623201"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 4/8] ixgbe: increase SECRX_RDY polling frequency in ixgbe_disable_rx_buff_generic
Date: Fri,  8 May 2026 05:12:22 +0200
Message-ID: <20260508031226.3601800-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3BD64F1093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285592-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Maciej Rabeda <maciej.rabeda@intel.com>

ixgbe_disable_rx_buff_generic polls for SECRX_RDY with 40 iterations
and a 1000 us (1 ms) busy-wait per iteration via udelay(), giving an
exact total wait of 40 ms.  On fast hardware the security block is
typically ready well under 1 ms, so each iteration wastes up to
999 us of stalled initialization time.

Replace udelay(1000) with usleep_range(10, 20) and raise the iteration
limit to 4000.  Because usleep_range(min, max) is guaranteed to sleep
at least 'min' microseconds, 4000 * 10 us preserves the original 40 ms
minimum wait before timeout.  The worst-case is now ~80 ms (4000 * 20
us) plus scheduler latency, which is acceptable since SECRX_RDY
failing to assert is a non-fatal informational condition (the function
just logs a debug message).

On platforms where SECRX_RDY asserts quickly this reduces the typical
stall from up to ~1 ms per iteration to ~10-20 us.  The function is
called only from process context, so usleep_range is appropriate.

Signed-off-by: Maciej Rabeda <maciej.rabeda@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 3ea6765..c85618c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2683,7 +2683,7 @@ int prot_autoc_write_generic(struct ixgbe_hw *hw, u32 reg_val, bool locked)
  **/
 int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
 {
-#define IXGBE_MAX_SECRX_POLL 40
+#define IXGBE_MAX_SECRX_POLL 4000
 	int i;
 	int secrxreg;
 
@@ -2695,8 +2695,7 @@ int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
 		if (secrxreg & IXGBE_SECRXSTAT_SECRX_RDY)
 			break;
 		else
-			/* Use interrupt-safe sleep just in case */
-			udelay(1000);
+			usleep_range(10, 20);
 	}
 
 	/* For informational purposes only */
-- 
2.52.0


