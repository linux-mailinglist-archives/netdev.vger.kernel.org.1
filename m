Return-Path: <netdev+bounces-270783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHK0OaG+wWlSWAQAu9opvQ
	(envelope-from <netdev+bounces-270783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:28:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46C2FE3F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88C6C30480C3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9A382F02;
	Mon, 23 Mar 2026 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRoobjaE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53863822BB;
	Mon, 23 Mar 2026 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304738; cv=none; b=JeodRSHg8NsSw9tyGmixVIP6O+U6hH/lZ6zYC+d00wQ2cZS2380nhl4sp2aMZRLRF6xoagdbfac8NawXuesR8Fx2ogmHFr+rAS9QX7EoMm669EO9D6MeLKCluAckL3wkFNiYdSknhxFAz4k83GCp7kYedCaVhXBHUXE1a3JKeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304738; c=relaxed/simple;
	bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lh5Cwa7T93Jnft72UnxVPcZ2xZWzg4/ASNcH0yIN/IpaucR0CV0i58ZuduLu030ZTEGK2GPsCpbU/l7e2mgdv01x338GMPKSBPPdgLfU6HaB+ewcKZwjymOjJkbaxdzgg4jtQ48+/KCE+HaCfR0CpF5QLM2jQ2O8SgQV1eYzAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRoobjaE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774304737; x=1805840737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
  b=CRoobjaESQANwCOWKE4ZywwP/A3h4Bqzb5mIq6+Fr0l+xkxktZGzhK8i
   h7LhTdskO7GSzYETH1ox6lyepFkSojmVRrPsfO3TSVCPxg8FMNUafVKpU
   2dKrUYT1bV1NCIR8ljiQRl3uKr83T61M+Z4tsE8z34ky/Jchxevxge7dj
   GEIlPURqbubE5HzLMSACw7VJ0LktXCwLxc4JA/u2kQ2/nMNTvcoCA97GC
   BQKZYanlZndiLLXSNtFw8/06Vgvh7rFI2DCqKga7TUa1eWkgRkT2Y58oA
   qdXX6cTm7XeFvAMIpBEIial/6Gz1ly+40QFwJWeuPgFiHX1MKB0/HgsvW
   Q==;
X-CSE-ConnectionGUID: FBtOq8caRzC+rjw8b5DpKw==
X-CSE-MsgGUID: CR9SflBWTUCeyPiKOsaYMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221890"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75221890"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:25:36 -0700
X-CSE-ConnectionGUID: EpPg9dw5T/y9by777PzEoA==
X-CSE-MsgGUID: idTlC5mrR/isx7/yoepIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247207387"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:32 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v3 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state change
Date: Mon, 23 Mar 2026 23:21:29 +0100
Message-Id: <20260323222133.1796997-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 7B46C2FE3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SyncE_Ref pin may operate as either an active or inactive reference
depending on board design and system configuration. Some platforms need
to disable the SyncE reference dynamically (e.g., when selecting a
different recovered clock input). The hardware supports toggling this
pin, therefore advertise the STATE_CAN_CHANGE capability.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/zl3073x/prop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..acd7061a741a 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
 
+	       /*
+		* The SyncE_Ref pin supports enabling/disabling dynamically.
+		* Some platforms may choose to expose this through firmware
+		* configuration later. For now, advertise this capability
+		* universally since the hardware allows state toggling.
+		*/
+		props->dpll_props.capabilities |=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+
 		/* The output pin phase adjustment granularity equals half of
 		 * the synth frequency count.
 		 */
-- 
2.39.3


