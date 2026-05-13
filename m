Return-Path: <netdev+bounces-287652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHFMBiScBGr3LwIAu9opvQ
	(envelope-from <netdev+bounces-287652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:43:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 207855365ED
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF366310D5C3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D964D2EF2;
	Wed, 13 May 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="JjOth9Ad"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E4C9009;
	Wed, 13 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685375; cv=none; b=T3W+R5Ku1A6ezROHeeD2yS2lEyosQsjzBQ+wiaAEdEI+yRu1U5Rowd1geueG2I/yDGWl4mWMDqEwpgwI0SO27eUSKaM64i1OybGA7/Q40ZnbvNkgzgi687ESHl7/9z9iOFEvnfrc2+irWudnVRS9VBrjftx17jU1pXYYYsjYds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685375; c=relaxed/simple;
	bh=udfFmRkoSwPuAnu3VVhPRFk0F0P/tijObG52lqyofpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7kRfm4MvSBWehU1L+9Sv7bkK5edYp2aRtblaXWXK3GDuDr78hAPOvQWxME5oPC6LWqohQILmIXOE+FylpkpGyhpxjSTBxsfhtCd/EA/UN00Sz0C0FRXITqQSSjEuctNfVsp9csvz1BSEB4OaK51ZG/9+CywqQOYSEJFOb46B6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=JjOth9Ad; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=13483; q=dns/txt;
  s=iport01; t=1778685373; x=1779894973;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Cof/Y3U6FkTC9zKuqV3gUgOvlNkPfv17f3DSFuLXP74=;
  b=JjOth9Ad6ktSeYyAbugZP2zmx4TJFpBsNSjovuf6SC28u9AtQSIViA40
   m8VPwC6GtTa9T9T4ojFph28SxBB+G44NlgxhPjF6RvC6zM/jB3JsPxzHJ
   a9jntnRUeTCAddWLgyEU3XZhKQlk0j1CpUP9feCnnfdyQy/cXovWxJfQR
   iZGDOn0ew9p/paAE7mQ1hiVg1x76hZDQhyLOWm8I2YTf+t+DQ8T1UQ7S0
   k/Onz45IdIqTplyGEYJh6hXjFfKs/ESjP4RTgAnSRc1I6NDXJ7nI1RB0X
   NQsoNQ3ojIs4ImJS/hNNeHyTWS5N6ZlGtEwCFb/Mt10qzsjwIUBifvU62
   w==;
X-CSE-ConnectionGUID: mRc5k11JSfWpQSYfykGCKw==
X-CSE-MsgGUID: 4PyesxIMTRGs/NWzyXmqHg==
X-IPAS-Result: =?us-ascii?q?A0AnAACnlARq/5D/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?hc/gVBDSYRXiByHN4Ihnh0UgWsPAQEBD1EEAQGFBgKNMgImNAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBE?=
 =?us-ascii?q?oMCgnQDswx6fzOBAYR92USBZAELFAGBCi4BhXGCZwGBcIQGO4RAJxuBSUSBF?=
 =?us-ascii?q?AGDaIEogwKDdIJpBIMcFI54CT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVA?=
 =?us-ascii?q?hQvDwQWMh1wDCcSLBczWBsHBYFLggVyFDEEIYEChF94IywDToFDAwsYDUgRL?=
 =?us-ascii?q?DcGDhsEPQFuB4o/HQ+BNglRGQcOSxwaB4EpDD8UHwIUXpJjBxaDYY1da4E1n?=
 =?us-ascii?q?1mEJoFkoA4BMoQEk2KTBZkGIoI2ogGEaIFoPIFZMxoIGxWDIlMZD44tFhx4A?=
 =?us-ascii?q?QLLJCcyPwcCBw4CkXMEgXkBAQ?=
IronPort-Data: A9a23:QeQfg6CPCXQ4qRVW/+niw5YqxClBgxIJ4kV8jS/XYbTApDwigWAFn
 GBLXmuAb/vfNmXzKdAjOt+38RxSscDVyYNnOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jWGthh
 fuo+5eBYAL8gGYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TExs9lUUJvZK8j9NlvOFp/+
 +0bBxsucUXW7w626OrTpuhEnM8vKozveYgYoHwllW6fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYzBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FMtiOezboWOK7RmQ+0JpleVv
 XLn2ljDLQpdEuON2AqA61Kj07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9KW4EeD9BTgYf5dTniJ88gwiJTdt5FqOxyNrvFlnYx
 T2WoCUgr6scgNRN1Kih+13DxTW2qfD0ohUd/A7bWCehqwh+foPgP9Pu4lnA5vEGJ4GcJrWcg
 EU5dwGlxLhmJfmweOalGY3hwJnBCy65DQDh
IronPort-HdrOrdr: A9a23:MbOQH6Pohr1r6MBcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: 9a23:oaXmOGx1R3OzeAtEK+qgBgURIMt4cSSE7kzeHFeBMldnWb66YnyPrfY=
X-Talos-MUID: 9a23:zDZyVgafblZXBOBT6wf9iSpyFeJU2Yu1T2Yyg4Q2vtCkOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="740766739"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:07 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id C87A118000485;
	Wed, 13 May 2026 15:16:06 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 13 May 2026 08:15:46 -0700
Subject: [PATCH net-next v7 09/10] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-9-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685360; l=13859;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=udfFmRkoSwPuAnu3VVhPRFk0F0P/tijObG52lqyofpw=;
 b=JO8JsJ6K9wUM2BdZb2JHq9XplBOWZrG4g/Y1S6UGbPFhnWBXzgXXc1Toe/daZTD7AKxuyzJ5d
 RIwtKnWHsEgD2LbA7OLdb5ql1JyUhn7AIffqCp0lRbvrRsDoT5hmnBi
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: 207855365ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287652-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Action: no action

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
 drivers/net/ethernet/cisco/enic/enic.h       |   1 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |   2 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 182 +++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  13 +-
 drivers/net/ethernet/cisco/enic/enic_pp.c    |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c   |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h  |   4 +-
 7 files changed, 194 insertions(+), 14 deletions(-)

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
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 83d43e6e4d17..5eefe6fd6955 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -589,5 +589,7 @@ void enic_admin_channel_close(struct enic *enic)
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);
+
+	WRITE_ONCE(enic->admin_rq_handler, NULL);
 	enic_admin_free_resources(enic);
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 53d68272d06a..65069440ec9a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -2155,12 +2157,35 @@ static void enic_reset(struct work_struct *work)
 	enic_set_api_busy(enic, true);
 
 	enic_stop(enic->netdev);
+
+	/* Quiesce admin channel before soft reset.  The reset disables
+	 * all hardware queues including the admin WQ/RQ; mask the admin
+	 * interrupt, drain NAPI and work, and block further MBOX sends
+	 * so the channel is cleanly idle when we reinitialise.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		vnic_intr_mask(&enic->admin_intr);
+		napi_disable(&enic->admin_napi);
+		cancel_work_sync(&enic->admin_msg_work);
+		WRITE_ONCE(enic->mbox_send_disabled, true);
+	}
+
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
+	/* Re-enable admin channel after reinitialising hardware */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		WRITE_ONCE(enic->mbox_send_disabled, false);
+		napi_enable(&enic->admin_napi);
+		vnic_intr_unmask(&enic->admin_intr);
+	}
+
 	enic_open(enic->netdev);
 
 	/* Allow infiniband to fiddle with the device again */
@@ -2200,6 +2225,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 static int enic_set_intr_mode(struct enic *enic)
 {
+	unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+	unsigned int min_intr = ENIC_MSIX_MIN_INTR + admin_reserve;
 	unsigned int i;
 	int num_intr;
 
@@ -2210,12 +2237,12 @@ static int enic_set_intr_mode(struct enic *enic)
 	 */
 
 	if (enic->config.intr_mode < 1 &&
-	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+	    enic->intr_avail >= min_intr) {
 		for (i = 0; i < enic->intr_avail; i++)
 			enic->msix_entry[i].entry = i;
 
 		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
-						 ENIC_MSIX_MIN_INTR,
+						 min_intr,
 						 enic->intr_avail);
 		if (num_intr > 0) {
 			vnic_dev_set_intr_mode(enic->vdev,
@@ -2310,7 +2337,13 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->cq_count = 2;
 		enic->intr_count = enic->intr_avail;
 		break;
-	case VNIC_DEV_INTR_MODE_MSIX:
+	case VNIC_DEV_INTR_MODE_MSIX: {
+		/* Reserve one MSI-X slot for the admin channel interrupt
+		 * when V2 SR-IOV admin channel resources are present.
+		 */
+		unsigned int admin_reserve =
+			enic->has_admin_channel ? 1 : 0;
+
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
 		 * used based on which resource is the most constrained
 		 */
@@ -2319,7 +2352,8 @@ static int enic_adjust_resources(struct enic *enic)
 				 ENIC_RQ_MIN_DEFAULT);
 		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
 		max_queues = min(enic->cq_avail,
-				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR -
+				 admin_reserve);
 		if (wq_avail + rq_avail <= max_queues) {
 			enic->rq_count = rq_avail;
 			enic->wq_count = wq_avail;
@@ -2337,6 +2371,7 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
 		break;
+	}
 	default:
 		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
 		return -EINVAL;
@@ -2689,6 +2724,124 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
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
+	pp = kzalloc_obj(*enic->pp, GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pci_disable_sriov(pdev);
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+
+	kfree(enic->pp);
+	enic->pp = pp;
+
+	return 0;
+}
 #endif
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2787,12 +2940,18 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2804,7 +2963,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -3033,14 +3191,16 @@ static void enic_remove(struct pci_dev *pdev)
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
index b555362379b3..fb656327a874 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -599,8 +599,17 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
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
 	WRITE_ONCE(enic->admin_rq_handler, enic_mbox_recv_handler);
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


