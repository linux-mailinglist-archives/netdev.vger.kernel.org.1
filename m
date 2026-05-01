Return-Path: <netdev+bounces-283110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMuxDmxK9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C04AAAB0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D375B30058F2
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1535F614;
	Fri,  1 May 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKujK0Nu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C882770A;
	Fri,  1 May 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617513; cv=none; b=AsXRE+EMzjlKJyY3ZxiGEAA35VilKsCoXU9zZcveH/xl4MG2PwW+uVQ7xzdLInaPgcRHWqz7nM0pcKfx/W9CRTj9u1/CrWi9lvXeDra25Jha+VnBJD8JorbXyZnEQv1od0SbIxiiZ1tWoVFi420hzc8NNc6KXBMJnxnV1NMoBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617513; c=relaxed/simple;
	bh=XSYe7jkpijRWFzoQHobj2J+nayL2ngnYFQd8umnnDPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLbdjnhqheADp4OIsvKwuDaoCQ4nN4ZSOog3+eO27GiKkFJZofjnldSdm0jK38rJLhecyWZY1OdNptC6FH7g/tyuOJ6fsutR80Ttvjua7kx7LKu2Q2FXQy3q5gq2xE1T8GfOcz0Q9P6Ol/E0gO9e/1lcuJK9ViHOCMZIW8zu+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKujK0Nu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617512; x=1809153512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XSYe7jkpijRWFzoQHobj2J+nayL2ngnYFQd8umnnDPE=;
  b=FKujK0NuV6MGXk5LEX5lOxlqMUg6bKwoYJ7WcatiudTwsCfb2eP4oBff
   ECcdVjmzq0jdnsyC/zPI1vhNHqsYPyQhnNNupYJk37SeX2wKVLqdLuBD6
   ViysbssgIa+MzbeTe5CpZrTGe6fvOcpBrRmVSJmXFzKD/TuHI+TNQVNLQ
   WXBjQ4sNBJz7NdoJnysotyC9x07tDUjofa104lGcxcwaChf9XfH82oc+X
   MRqyC8xYotgAxk53I7+Kdwdk8i7pDU1egtDoSTe+fnjbve9FFD6GUNsQB
   Kwf8U6F9mHHBf0rOGrpcRFZPURCLI1g2B/vFgSkuVLY6Z5kUFWYeHH8B8
   g==;
X-CSE-ConnectionGUID: qitlHOdYSc+TBl1tHQzj9g==
X-CSE-MsgGUID: 76FHRBn7SMa4MUXXptowWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271858"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271858"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
X-CSE-ConnectionGUID: cGAuR70URKuVIFC3mPJeAw==
X-CSE-MsgGUID: 3PiMGmLdQuC8QTGONu3KzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752839"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:12 -0700
Subject: [PATCH net-next 01/15] ixgbe: E610: add discovering EEE capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-1-6f27ae1cd073@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=piRjMZsWjhPpWeIoF5aPcVpYYh7oDNAqZaQNX2L0ThE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXslbP++R3XPlcZVuiuej2aZC2SeTKmtOH9b3KD3+a
 dpd8x0+HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExktjLDPyuddqbHDncj+5oV
 Ful9eyfJdS0u/Abv5f8MkxedmN49K5SRofd9yuynBQVOcyQviXLq2AT1bsoJ1UjIDndOXPzctsy
 WDQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: C97C04AAAB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283110-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Add detecting and parsing EEE device capability.

Recently EEE functionality support has been introduced to E610 FW.
Currently ixgbe driver has no possibility to detect whether NVM
loaded on given adapter supports EEE.

There's dedicated device capability element reflecting FW support
for given EEE link speed.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 1 +
 include/linux/net/intel/libie/adminq.h             | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index ff8d640a50b1..34f62a416eaa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -891,6 +891,7 @@ struct ixgbe_hw_caps {
 	u8 apm_wol_support;
 	u8 acpi_prog_mthd;
 	u8 proxy_support;
+	u8 eee_support;
 	bool nvm_update_pending_nvm;
 	bool nvm_update_pending_orom;
 	bool nvm_update_pending_netlist;
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index ab13bd777a28..839114d8975a 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -196,6 +196,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_BIT_ROCEV2_LAG			BIT(0)
 #define LIBIE_AQC_BIT_SRIOV_LAG				BIT(1)
 #define LIBIE_AQC_BIT_SRIOV_AA_LAG			BIT(2)
+#define LIBIE_AQC_CAPS_EEE				0x009B
 #define LIBIE_AQC_CAPS_FLEX10				0x00F1
 #define LIBIE_AQC_CAPS_CEM				0x00F2
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 52f73142ff75..5383f0fd55d6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -628,6 +628,9 @@ static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
 			(phys_id & IXGBE_EXT_TOPO_DEV_IMG_PROG_EN) != 0;
 		break;
 	}
+	case LIBIE_AQC_CAPS_EEE:
+		caps->eee_support = (u8)number;
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		return false;

-- 
2.54.0.rc2.531.gaf818d63126a


