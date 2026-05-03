Return-Path: <netdev+bounces-283589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF3DFW8x92lidQIAu9opvQ
	(envelope-from <netdev+bounces-283589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:28:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF64B5483
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740BD3045014
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100934DB6B;
	Sun,  3 May 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="NKqpz1wa"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B8347FFE;
	Sun,  3 May 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807454; cv=none; b=mCOV4FC1b1cZWWkCaualpBMwj9lCqz8mIx4FRB8WG+7egbHcKvNjvomKZHvtoCufmEGK3PvRx2xY97txPqlf+59ctjgCR+miAO/eOFYuaVurr7+pSZwoh8NEt+W/XT8HqNbpWemDDlgcFT79pc7k0VKkJshXEmTBu+ZPL7Wc5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807454; c=relaxed/simple;
	bh=98HiIa1W+ZDwSMfxvLFC1y+jPE25eZ8OwNCbntSWJX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOHj/vYTB4zWkDuOZzNIkklUDC7k5JFQgB1yE6UlmvWQixhOUeEdmhLd+ZrI95a/oS7fe/auqw7c7psKsQmuugxhcAgZsuPg1I0bDZV1w6FcFnI72GrknWVxfKqw5PrlGP+EXaTd6PMQlHGNwOGUCFkfDCG21CFTozjnHlFF9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=NKqpz1wa; arc=none smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9758; q=dns/txt;
  s=iport01; t=1777807450; x=1779017050;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wr9E2hgyq5hI01dxAyTO4C42w+m31gJequVXo2bhuqU=;
  b=NKqpz1waYSZMKu3BjPU1dMjmonS37iImF9uYimg54srd/KEGNPr4IUye
   QkQiOuiWe42tN2Dqbm6RLUqQfqNLmsPxI6FfldEn9YE3ifrD1eOG+RstG
   6GNHlEzp7rnuaS/MkM/zaMzi/zkTyi0wdI7MKhBhhVzimrQpx3mSowklS
   oy0I+BEEPzue93NJDt7skS7NvzkdwiiypD84O3c0Hq+krpaU54XafnRZ8
   MsMXKKN9XT1wokb5K74Y9V8d8jk4Nr8kJVPjstW+Cx5Ya9bG9TBWtISvK
   OlD5CH1TXyxLjrEiulbZpP4abVbCUGtcbZD6w1EUlNYSHwC6DGT43qjJS
   w==;
X-CSE-ConnectionGUID: B43om+E5T5mKVBR7fSFlTg==
X-CSE-MsgGUID: WTFrMjVbRyy4Z5X1dLckcA==
X-IPAS-Result: =?us-ascii?q?A0AaAADQLvdp/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBghc/gU9DSYRXiByHN4Ihnh0UgWsPAQEBD1EEAQGFBgKNMQImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAgEDIwRSE?=
 =?us-ascii?q?CUCJgICRhAGARKDAoJ0A7Qeen8zgQGEfdlDgWQBCxQBgQouAYVxgmYBgXCEB?=
 =?us-ascii?q?juEPycbgUlEgRWDaIEogwKDdIJpBIMcFI8bCT+BAhwDWSwBVRMNCgsHBWFSM?=
 =?us-ascii?q?wMgCgsSEhgVAhQvDwQWMh1wDCcSLBc0WBsHBYFLgwBtFDEEIYEFhGB4IywDT?=
 =?us-ascii?q?nIDCxgNSBEsNwYOGwQ9AW4HimYdD4E2CXEOSxwaB4EpDD8UHwIUk0EHFoNhj?=
 =?us-ascii?q?V1rgTWfWYQmgWSgDgEyhASTYpMFmQYigjaiAYRogWg8gVkzGggbFYMiUxkPj?=
 =?us-ascii?q?i0WHHgBAshBJjI+AQcCBw4CgXOQAASBeQEB?=
IronPort-Data: A9a23:nopz3Ktpt9irghr7M8kjcCiINOfnVJZfMUV32f8akzHdYApBsoF/q
 tZmKWiFa/2LZDDyeN10bI+woUhQ6MWGndRgS1ds+ypjQyoVgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFYzdJ5xYuajhKs//b80s21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw0LosBmQN2
 KEkdTUuUDq52OyN7raHRbw57igjBJGD0II3oHpsy3TdSP0hW52GG/+M7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxGYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoPRH5QNzh3I+
 Qoq+UzGPj8AEd6hwwCU4y6e29+WkQfwW4k7QejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRfoWpYcmsrFPc9/sFdNzfRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:S+uo46tF2/oDG8UQp5E7YnHQ7skDgNV00zEX/kB9WHVpmwKj5q
 STdZMgtCMc6Qx+ZJhOo7290cW7K080sKQFg7X5Xo3MYOCZgguVxehZhOOI/9SjIVycygc378
 tdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9J7j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZf
 yhD7J81l2dUEVSSNinDX8YWOWGjdjKmJX6JSMiPXccmXGzZffC0s+BL/BetS1uKA9y/Q==
X-Talos-CUID: 9a23:tM0tqG3a9q0bMJv2ykm7zrxfMJx+dXie4SrsfkqbN0xTF7OuZ1us9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ABsgvrwwxjnvx047zwT/iMIpEdkuaqJuSJlook6s?=
 =?us-ascii?q?MgdiVaR4tC26RqD+0SaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="732908387"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:23:02 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id D458818000367;
	Sun,  3 May 2026 11:23:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:46 -0700
Subject: [PATCH net-next v6 09/10] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-9-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807375; l=9981;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=98HiIa1W+ZDwSMfxvLFC1y+jPE25eZ8OwNCbntSWJX0=;
 b=99JUCy4YpKCFPGEVWgaHKDsKemriwDJF94SQNj8T09t3W/sg0bXeGhIrfyMD9Sdb2eWw0b10J
 L6+I36BqkTeDVIncuwCyJSRs2v82iXcq+IXxscbkrStWZV5uKA/XCfc
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: B1BF64B5483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283589-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Extend enic_sriov_configure() to handle V2 SR-IOV VFs. When the PF
detects V2 VF device IDs, the enable path allocates per-VF MBOX state,
opens the admin channel, initializes the MBOX protocol, and then calls
pci_enable_sriov(). The admin channel must be ready before VFs are
created so that VF drivers can immediately begin the MBOX capability
and registration handshake during their probe.

The enic_sriov_configure() dispatcher and its V2 helpers
(enic_sriov_v2_enable, enic_sriov_v2_disable) are defined here but
intentionally not yet wired into struct pci_driver via
.sriov_configure -- hence the __maybe_unused annotations.  This
series introduces only the admin channel and MBOX infrastructure;
sysfs-driven V2 enable/disable will be activated in a follow-up
patch by adding ".sriov_configure = enic_sriov_configure," to
enic_driver.

The disable path reverses this order: pci_disable_sriov() first (so VF
drivers unregister via MBOX), then the admin channel is closed and
per-VF state is freed.

Reject VF port profile requests when V2 SR-IOV is active
(enic_is_valid_pp_vf), since enic->pp is not reallocated for V2 VFs
and the V2 protocol uses MBOX instead of port profiles.

Update enic_remove() to run enic_dev_deinit() and vnic_dev_close()
after SR-IOV teardown, so the PF device remains functional while VFs
are being cleaned up.  This ordering applies to both V1 and V2 SR-IOV
paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 139 ++++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c |  13 ++-
 drivers/net/ethernet/cisco/enic/enic_pp.c   |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c  |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h |   4 +-
 6 files changed, 153 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 483053c781df..1bf7a91ad915 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -323,6 +323,7 @@ struct enic {
 	 * waiter.
 	 */
 	u8 mbox_expected_reply;
+	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 53d68272d06a..057716ccc283 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -2689,6 +2691,122 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 	}
 }
+
+static int __maybe_unused
+enic_sriov_v2_enable(struct enic *enic, int num_vfs)
+{
+	int err;
+
+	if (!enic->has_admin_channel) {
+		netdev_err(enic->netdev,
+			   "V2 SR-IOV requires admin channel resources\n");
+		return -EOPNOTSUPP;
+	}
+
+	enic->vf_state = kcalloc(num_vfs, sizeof(*enic->vf_state), GFP_KERNEL);
+	if (!enic->vf_state)
+		return -ENOMEM;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to open admin channel: %d\n", err);
+		goto free_vf_state;
+	}
+
+	enic_mbox_init(enic);
+
+	enic->num_vfs = num_vfs;
+
+	err = pci_enable_sriov(enic->pdev, num_vfs);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "pci_enable_sriov failed: %d\n", err);
+		goto close_admin;
+	}
+
+	enic->priv_flags |= ENIC_SRIOV_ENABLED;
+	return num_vfs;
+
+close_admin:
+	enic->num_vfs = 0;
+	enic_admin_channel_close(enic);
+free_vf_state:
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	return err;
+}
+
+static void enic_sriov_v2_disable(struct enic *enic)
+{
+	pci_disable_sriov(enic->pdev);
+	enic_admin_channel_close(enic);
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+}
+
+static int __maybe_unused
+enic_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct enic *enic = netdev_priv(netdev);
+	struct enic_port_profile *pp;
+	int err;
+
+	if (num_vfs > 0) {
+		if (enic->config.mq_subvnic_count) {
+			netdev_err(netdev,
+				   "SR-IOV not supported with multi-queue sub-vnics\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_NONE) {
+			netdev_err(netdev,
+				   "SR-IOV not supported on this firmware version\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_V2)
+			return enic_sriov_v2_enable(enic, num_vfs);
+
+		pp = kcalloc(num_vfs, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			kfree(pp);
+			return err;
+		}
+
+		kfree(enic->pp);
+		enic->pp = pp;
+		enic->num_vfs = num_vfs;
+		enic->priv_flags |= ENIC_SRIOV_ENABLED;
+		return num_vfs;
+	}
+
+	if (!enic_sriov_enabled(enic))
+		return 0;
+
+	if (enic->vf_type == ENIC_VF_TYPE_V2) {
+		enic_sriov_v2_disable(enic);
+		return 0;
+	}
+
+	pci_disable_sriov(pdev);
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+
+	kfree(enic->pp);
+	enic->pp = kzalloc_obj(*enic->pp, GFP_KERNEL);
+	if (!enic->pp)
+		return -ENOMEM;
+
+	return 0;
+}
 #endif
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2787,12 +2905,18 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_vnic_unregister;
 
 #ifdef CONFIG_PCI_IOV
-	/* Get number of subvnics */
+	enic_sriov_detect_vf_type(enic);
+
+	/* Auto-enable SR-IOV if VFs were pre-configured (e.g. at boot).
+	 * V2 VFs require the admin channel, which is not yet set up at probe
+	 * time; use sysfs (enic_sriov_configure) to enable V2 SR-IOV instead.
+	 */
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos) {
 		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF,
 			&enic->num_vfs);
-		if (enic->num_vfs) {
+		if (enic->num_vfs &&
+		    enic->vf_type != ENIC_VF_TYPE_V2) {
 			err = pci_enable_sriov(pdev, enic->num_vfs);
 			if (err) {
 				dev_err(dev, "SRIOV enable failed, aborting."
@@ -2804,7 +2928,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -3033,14 +3156,16 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
-		enic_dev_deinit(enic);
-		vnic_dev_close(enic->vdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
-			pci_disable_sriov(pdev);
-			enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+			if (enic->vf_type == ENIC_VF_TYPE_V2)
+				enic_sriov_v2_disable(enic);
+			else
+				pci_disable_sriov(pdev);
 		}
 #endif
+		enic_dev_deinit(enic);
+		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 7680baece802..71da7f05d4a0 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -589,8 +589,17 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
 void enic_mbox_init(struct enic *enic)
 {
+	/* mbox_lock and mbox_comp must be initialized exactly once per
+	 * device lifetime; the PF sriov_configure path can re-enter this
+	 * on each enable cycle where these primitives are already set up.
+	 */
+	if (!enic->mbox_initialized) {
+		mutex_init(&enic->mbox_lock);
+		init_completion(&enic->mbox_comp);
+		enic->mbox_initialized = true;
+	} else {
+		reinit_completion(&enic->mbox_comp);
+	}
 	enic->mbox_msg_num = 0;
-	mutex_init(&enic->mbox_lock);
-	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_pp.c b/drivers/net/ethernet/cisco/enic/enic_pp.c
index 4720a952725d..3f611e240c25 100644
--- a/drivers/net/ethernet/cisco/enic/enic_pp.c
+++ b/drivers/net/ethernet/cisco/enic/enic_pp.c
@@ -25,6 +25,11 @@ int enic_is_valid_pp_vf(struct enic *enic, int vf, int *err)
 	if (vf != PORT_SELF_VF) {
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
+			/* V2 SR-IOV uses MBOX, not port profiles */
+			if (enic->vf_type == ENIC_VF_TYPE_V2) {
+				*err = -EOPNOTSUPP;
+				goto err_out;
+			}
 			if (vf < 0 || vf >= enic->num_vfs) {
 				*err = -EINVAL;
 				goto err_out;
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 2b7545d6a67f..436326ace049 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -59,6 +59,7 @@ int enic_get_vnic_config(struct enic *enic)
 	GET_CONFIG(intr_timer_usec);
 	GET_CONFIG(loop_tag);
 	GET_CONFIG(num_arfs);
+	GET_CONFIG(mq_subvnic_count);
 	GET_CONFIG(max_rq_ring);
 	GET_CONFIG(max_wq_ring);
 	GET_CONFIG(max_cq_ring);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_enet.h b/drivers/net/ethernet/cisco/enic/vnic_enet.h
index 9e8e86262a3f..519d2969990b 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_enet.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_enet.h
@@ -21,7 +21,9 @@ struct vnic_enet_config {
 	u16 loop_tag;
 	u16 vf_rq_count;
 	u16 num_arfs;
-	u8 reserved[66];
+	u8 reserved1[32];
+	u16 mq_subvnic_count;
+	u8 reserved2[32];
 	u32 max_rq_ring;	// MAX RQ ring size
 	u32 max_wq_ring;	// MAX WQ ring size
 	u32 max_cq_ring;	// MAX CQ ring size

-- 
2.43.0


