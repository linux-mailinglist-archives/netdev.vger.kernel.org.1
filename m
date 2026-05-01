Return-Path: <netdev+bounces-283112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBnHINtK9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE834AAB11
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD6F302DA25
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779B364038;
	Fri,  1 May 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQtJsdUA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89193603FC;
	Fri,  1 May 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617515; cv=none; b=VGsc3dyLauIaPYU2qGbniaLHlvQ7Gpt21qJS8Eh5i1sZjDa6/L7mPCdzMY0ohhF5vyUVDkDj9oLA9OvJv5y16sdGo3Z7STulZkkgEcuheWNfms7vxhdP3GmDJSrr1Jo7pOjotjrf1MObvA7YnF0B3Kph15c/YOJInosvR8SN4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617515; c=relaxed/simple;
	bh=F6pZxeazA8H7XagIyG1by9jazL+U+edc48kAmCX5S8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdPdXD2I41h8n8VH94KiKxWThjatsn/1p6SHlKc8/ISnZ/RlyjoIcC9ujNJEwrFcXDEYheB9QFvquoyyy/KUnaGtaPgjpD6kL2Io8xB6mDCLgMwhs9BJAgZi2aLuRIYjdXh1IcaI5E8xWsAOWVCxtJHqMVslkAX69qXC6OcbrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQtJsdUA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617514; x=1809153514;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=F6pZxeazA8H7XagIyG1by9jazL+U+edc48kAmCX5S8c=;
  b=HQtJsdUAaC+99NtWlbKRWiPAGfT5epMz8w7kncXmEbovumC7m2ZVGwpm
   sxMf103KW9BNYrRltjZKhvvtIe4mRA5EHMqOAkhmfG5litaOT8+cIJys5
   sbPLwEWH3OULILpTUVX09KLQ/CYbKVvsjYrRkmj0xuW0jCvNn+r6bzowK
   rTNFk+JWh0ryIh3c2Pm9m8THiMKRa5CJRN/mPuRW7N7PoRJose6SwZahP
   lTMY2Ha8L51qiCUqIl8zloXuZKUBY8fin7cAlsToE/nF/4keDgCLwp6dM
   mj0729fHVPqvux9+lTm11tanJqCV+3Vti3Gp7kAeDCaSmkSRbOERUc46u
   Q==;
X-CSE-ConnectionGUID: ZIwP/glzQICb8pHMgu8brQ==
X-CSE-MsgGUID: smdNaxwHRjeqPxymJV5LSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271865"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271865"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: qAmWQXYHTx6HAvdJod5HcQ==
X-CSE-MsgGUID: evdBjwuXRdmaDmNwv2OrSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752842"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:13 -0700
Subject: [PATCH net-next 02/15] ixgbe: E610: update EEE supported speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-2-6f27ae1cd073@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ac5X7jGfbRIkX633o+bauck12PclZCfVS7L27CYA9Sk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXsmasx49MXz4/fI315d7UmZt2HT9jnthulw8p4n0p
 n9XPnFN7ihlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAidx0Z/ql86P3j99ZBtqpz
 TVjdlm/vzGL7I+Uvyof+Xn4j1YfFQovhn0Yjv8m526/qWyckqiSfmfH7h6nhFB2VVDuNrQnb/V8
 o8QAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: CFE834AAB11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Despite there was no EEE (Energy Efficient Ethernet) feature
support for E610 adapters, eee_speeds_supported variable was
defined and even initialized with some EEE speeds.

As E610 adapter supports EEE only for 10G, 5G and 2.5G speeds,
update hw.phy.eee_speeds_supported. Remove unsupported speeds -
10M, 100M and 1G.

Add also entry for 5G speed in EEE speeds mapping array used
by ethtool callbacks.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    | 11 ++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 5383f0fd55d6..097a3e1c67aa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1983,9 +1983,14 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_10_FULL |
-				       IXGBE_LINK_SPEED_100_FULL |
-				       IXGBE_LINK_SPEED_1GB_FULL;
+	/* E610 supports EEE only for speeds above 1G */
+	if (hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL;
+	else
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL |
+					       IXGBE_LINK_SPEED_5GB_FULL |
+					       IXGBE_LINK_SPEED_10GB_FULL;
+
 	hw->phy.eee_speeds_advertised = hw->phy.eee_speeds_supported;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ba049b3a9609..8450094a028a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3541,6 +3541,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
 

-- 
2.54.0.rc2.531.gaf818d63126a


