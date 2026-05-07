Return-Path: <netdev+bounces-285547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MtYA54j/Wn6YAAAu9opvQ
	(envelope-from <netdev+bounces-285547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 01:43:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3344F0332
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 01:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D22CE30046BF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72016348465;
	Thu,  7 May 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrnB57p0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222F326942
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197399; cv=none; b=gx6hZWuKQTmf23CEmUtjRkxqE03PGcnocKXtX5hgMxy4d6GbxftGPZFPSZDDPm+pHx5Bikh1bOe8/hKgrq6fcyYBBV5tMaNcHtUHjZwZzAJ0ULCR4vGKcRiYAQ/y9fMNvIKIomriUiv0Ry2ZhOEhPeNSPMQC1yT5vIeSmIaRqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197399; c=relaxed/simple;
	bh=qkkBF3RQ7Ixw5ubxnV9KnZdzbMduZO2yaLLmTe4UUp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f5FBq7spliEnBt5gOWWlI+DUT/Xw+o8bqHmQomeN6TCPPRA1Q8/ufYWhZ1hhRGOKuLrXRCB4qDccreR4XiUot+3wZ7v1SuAdLq3wN4Cplk1b5ZufHJ1KsGt5wiPh7gyEx8TeZRpLXCeyOfpcjjSB947gvxAQ7XWEyec457bfqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrnB57p0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778197398; x=1809733398;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=qkkBF3RQ7Ixw5ubxnV9KnZdzbMduZO2yaLLmTe4UUp8=;
  b=HrnB57p0F0Ab0ULmC6Xv4M72Xe/V9QByspdYMQ9mB8BTG5QjZC7vxnkO
   bUH3bb+uvywTdhR3SJjxebgbuYz+nNCW0jImz/lPMiK7lStNZxjQKxmbD
   lpsEE95AO3zzGzBWUMVK0ThZ+7IgxQuEsCuqhW3lxWM+bdt2U+oRUkMeL
   iY4CzvVYk0JaG3Rocz+p71SsrWMAjRdEw23dIBqEJQUaQOEFc2xXeT847
   P1djXCQ8SWAOUO7iw9/Uqb/qX/7S/ZzcTmZoBG30KkjWe1Q2ua5B+Tl0p
   iZ494hTfRqoG35EftWVAAlNVOgh05yOFGhC8FZdIvJr/a0EcAQCTnm4+u
   w==;
X-CSE-ConnectionGUID: kuvDSzfWSM6/k4wGfxxOTQ==
X-CSE-MsgGUID: C9J5V1r1SR+tGZ46HwzN9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96731672"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="96731672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:43:17 -0700
X-CSE-ConnectionGUID: T2szzNHETRyDLJMrNKxu5Q==
X-CSE-MsgGUID: +LgbT6PPQiWCt0i2uah7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241616007"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:43:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 07 May 2026 16:42:42 -0700
Subject: [PATCH net-next] ixgbe: E610: do not fill EEE lp_advertised from
 local PHY caps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-jk-iwl-next-fix-eee-ixgbe-v1-1-62bc1d197d1d@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xcs5cUCCD+ivEB6oKHppq2QhPCv
 3vC42RndqUALwh0yVbymCXI2ynkp4zso3MjWO7KVJiiNpVpeHqyLC92SJEHSQyoksYeXJq2zWt
 bocGZtP94qLB/X8kh7g3djiV8+wk2/q9p237aQrOlhwAAAA==
X-Change-ID: 20260507-jk-iwl-next-fix-eee-ixgbe-309916c5e7e8
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, David Carlier <devnexen@gmail.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=AR4mTTPloZw3fj31XNVXYIZcxf5GESK0zZLITIJsQGg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsy/yhP3zNLsUl66fkoAW7p/dnWUnuSOUzHiXcavAlYu/
 BH2WGZ3RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABM56cbwT3dKr+YdjvqXiieW
 f9mv6N9y9D9DjNyj7rDznK03uN4KPmD4nyOxTb3yd95OXdvK2+yb2x/NrvjvaCRUzXtx8gpO6c0
 1XAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 0C3344F0332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285547-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

ixgbe_get_eee_e610() fills kedata->lp_advertised from pcaps.eee_cap
returned by ixgbe_aci_get_phy_caps() with IXGBE_ACI_REPORT_ACTIVE_CFG.
That report mode (and the other IXGBE_ACI_REPORT_* modes) describe the
local PHY only, not the link partner. The X550 path uses a separate
FW_PHY_ACT_UD_2 activity for partner data; the E610 ACI has no
equivalent.

Leave lp_advertised zeroed via the existing linkmode_zero() and drop
the now-unused ixgbe_eee_cap_map[]. eee_active/eee_enabled are
unaffected (sourced from link.eee_status).

Fixes: b61dbdeff3a9 ("ixgbe: E610: add EEE support")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I'm sending this to next now since it fixes the recently merged EEE support
for ixgbe, which was merged last week (see [1]). It is a fix, but the
offending code is only on net-next currently.

[1]: https://lore.kernel.org/netdev/177777482779.3993534.10771712863528181433.git-patchwork-notify@kernel.org/
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6990fe53f049..36e43b5e88d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3558,17 +3558,6 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
-static const struct {
-	u16 eee_cap_bit;
-	u32 link_mode;
-} ixgbe_eee_cap_map[] = {
-	{ IXGBE_ACI_PHY_EEE_EN_100BASE_TX, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_1000BASE_T, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_10GBASE_T, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_5GBASE_T, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
-};
-
 static int ixgbe_validate_keee(struct net_device *netdev,
 			       struct ethtool_keee *keee_requested)
 {
@@ -3645,7 +3634,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_link_status link;
-	u16 eee_cap;
 	int err;
 
 	linkmode_zero(kedata->lp_advertised);
@@ -3670,14 +3658,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	if (kedata->eee_enabled)
 		kedata->tx_lpi_timer = le16_to_cpu(pcaps.eee_entry_delay);
 
-	eee_cap = le16_to_cpu(pcaps.eee_cap);
-
-	for (int i = 0; i < ARRAY_SIZE(ixgbe_eee_cap_map); i++) {
-		if (eee_cap & ixgbe_eee_cap_map[i].eee_cap_bit)
-			linkmode_set_bit(ixgbe_eee_cap_map[i].link_mode,
-					 kedata->lp_advertised);
-	}
-
 	for (int i = 0; i < ARRAY_SIZE(ixgbe_ls_map); i++) {
 		if (hw->phy.eee_speeds_supported &
 		    ixgbe_ls_map[i].mac_speed)

---
base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
change-id: 20260507-jk-iwl-next-fix-eee-ixgbe-309916c5e7e8

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


