Return-Path: <netdev+bounces-283115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJMJEEVL9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97054AAB42
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3877D3051BCF
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC236BCF0;
	Fri,  1 May 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsrcBL9L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05C364045;
	Fri,  1 May 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617517; cv=none; b=IT07kVAM1uc/Kfj/EQpFNSYc1d/BFcAhdu+/bKTth3GTBO1za58JfggujDv9tdOI9VYev59VpZLj/3tpy/hgLC93phLz8PsKnVElYDAH4KzXaKWLCF4Qa5EhyXekoUikom6Er/uZXLUIH6HEgwoEbvnHmZprb6rYVLjzCV9sK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617517; c=relaxed/simple;
	bh=bZ2vP+E4nRubcr8z05aW0zLO08M66BVyDXcFD80rasQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sipofeX/39TAlMsA/CKA6dOvTGgYbwMOic3vNYWtNWmTcOf0o63h6e/hH676/JBLd52dFhLYn/kJFtG8xuF9YPiFeaBLwqyFtBA6urUU3cpaSS+ZYwwfXjpyEnn5Hon4gIUhIqvaMiS1I2X9FJeS7N0ewPSO9QWJ4o314ZNo45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsrcBL9L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617516; x=1809153516;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bZ2vP+E4nRubcr8z05aW0zLO08M66BVyDXcFD80rasQ=;
  b=IsrcBL9LnqXrU+2sHpYBD8hZWYbdqmGzs8cXlAVGbSYO/8c8d1hbCCvL
   BAvxVVQInWUHEKsMxqlef8FnMqyF4wZsHganMbCEsa2OQuXEAD5byi2C3
   UzSRg3GIFeM3C2f5hSVTQN+tmBhwvZYwOWYKAay6GONq1arO4tacjKEjs
   6iG3ZnR2fDaaERUGvN1A+Ds10MEQfYnJEjAL4/RgwBqseT3Js2Ae5rmY6
   Oizc5TFCv09GbS2zUzQZ/D7PBrItu4tATqHG8RV5YFrDQr03tAu8D+xUc
   HcSrgtT+mxiIU/7w60xZ0hg+PC8G4fSKcwBvVAGvsgkkzSQLWPAULXl9f
   Q==;
X-CSE-ConnectionGUID: wi2QN2fwQJOr1aYl1wMebA==
X-CSE-MsgGUID: aEti7ZgtTP2z33uDIjuXbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271887"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271887"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: /NXGYkg1Ti6YL3hiPKVfFg==
X-CSE-MsgGUID: CvQazrnjT8qQa1nTL2EHGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752852"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:16 -0700
Subject: [PATCH net-next 05/15] ixgbe: move EEE config validation out of
 ixgbe_set_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-5-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4123;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=+UYOBw1om1HhT8Rq1KbBklwfxBv/e5K+mQfxVIFcl9I=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXikS/8Ty7+6smcPo57puc5liS5LSDhshlQ2LnqdsF
 uwy0ebpKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCJvLzH8j0lovn+XSe+qWstU
 w+obu6P25TUEs0y8NkWin42jKXx9PyND+z2Z+GJuLfn4zY5nK+WTmgwnWiXfYmR47yBYv+askiA
 LAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: B97054AAB42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

To make this part of the code mode reusable move all
EEE input checks out of ixgbe_set_eee().

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 98 ++++++++++++++----------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 8450094a028a..186345933f3f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3557,6 +3557,47 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
+static int ixgbe_validate_keee(struct net_device *netdev,
+			       struct ethtool_keee *keee_requested)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ethtool_keee keee_stored = {};
+	int err;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
+		return -EOPNOTSUPP;
+
+	err = netdev->ethtool_ops->get_eee(netdev, &keee_stored);
+	if (err)
+		return err;
+
+	if (keee_stored.tx_lpi_enabled != keee_requested->tx_lpi_enabled) {
+		e_err(drv, "Setting EEE tx-lpi is not supported\n");
+		return -EINVAL;
+	}
+
+	if (keee_stored.tx_lpi_timer != keee_requested->tx_lpi_timer) {
+		e_err(drv,
+		      "Setting EEE Tx LPI timer is not supported\n");
+		return -EINVAL;
+	}
+
+	if (!linkmode_equal(keee_stored.advertised,
+			    keee_requested->advertised)) {
+		e_err(drv,
+		      "Setting EEE advertised speeds is not supported\n");
+		return -EINVAL;
+	}
+
+	/* -EALREADY here is for internal use only, must be converted into
+	 * early bail out with 0 by caller
+	 */
+	if (keee_stored.eee_enabled == keee_requested->eee_enabled)
+		return -EALREADY;
+
+	return 0;
+}
+
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
@@ -3615,53 +3656,28 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	struct ethtool_keee eee_data;
 	int ret_val;
 
-	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
-		return -EOPNOTSUPP;
-
-	memset(&eee_data, 0, sizeof(struct ethtool_keee));
-
-	ret_val = ixgbe_get_eee(netdev, &eee_data);
-	if (ret_val)
+	ret_val = ixgbe_validate_keee(netdev, edata);
+	if (ret_val == -EALREADY)
+		return 0;
+	else if (ret_val)
 		return ret_val;
 
-	if (eee_data.eee_enabled && !edata->eee_enabled) {
-		if (eee_data.tx_lpi_enabled != edata->tx_lpi_enabled) {
-			e_err(drv, "Setting EEE tx-lpi is not supported\n");
-			return -EINVAL;
-		}
-
-		if (eee_data.tx_lpi_timer != edata->tx_lpi_timer) {
-			e_err(drv,
-			      "Setting EEE Tx LPI timer is not supported\n");
-			return -EINVAL;
-		}
-
-		if (!linkmode_equal(eee_data.advertised, edata->advertised)) {
-			e_err(drv,
-			      "Setting EEE advertised speeds is not supported\n");
-			return -EINVAL;
-		}
+	if (edata->eee_enabled) {
+		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised =
+					   hw->phy.eee_speeds_supported;
+	} else {
+		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised = 0;
 	}
 
-	if (eee_data.eee_enabled != edata->eee_enabled) {
-		if (edata->eee_enabled) {
-			adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised =
-						   hw->phy.eee_speeds_supported;
-		} else {
-			adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised = 0;
-		}
-
-		/* reset link */
-		if (netif_running(netdev))
-			ixgbe_reinit_locked(adapter);
-		else
-			ixgbe_reset(adapter);
-	}
+	/* reset link */
+	if (netif_running(netdev))
+		ixgbe_reinit_locked(adapter);
+	else
+		ixgbe_reset(adapter);
 
 	return 0;
 }

-- 
2.54.0.rc2.531.gaf818d63126a


