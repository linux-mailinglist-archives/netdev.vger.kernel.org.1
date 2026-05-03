Return-Path: <netdev+bounces-283582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBtiHlgw92lSdQIAu9opvQ
	(envelope-from <netdev+bounces-283582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE5F4B5401
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4573017006
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0A34AB19;
	Sun,  3 May 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="M4cXih7r"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B583126C0;
	Sun,  3 May 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807391; cv=none; b=r10i6ZuRReNxB7gWFp9WY0jYDGqTqnwIptP7hSRKyE6TYis51VD+PMLHXFhxc/jV1exPWYmIGOuxmgR8h5NNrh1VoZOiA7vLVyhrwq0KNGuVdjB5upPf2Z0t7lMPY9ZKFHBiy9kAc+YfyaO0dF/mJ4cxPIUKiWm3ryNH2RlCAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807391; c=relaxed/simple;
	bh=j8jcnV6R/vBeZYaBxbZgAebIz9HVZjEefr0QryF5/TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFGgd3MmRjU/SMLV1JKVZUumzlwXGUtUOBxQuYnvkumFsxuQ4JUKuls7whVd51BAuBv5T2sIQ7MFlz4AkA3nrslr7uqEoF0MtCEwAa5pkMEczkcuuMnqcKpC3GigfRZKotpfSVxvJiyjtR8+ggolMfYBQtCOfzEWe3FWXbB7OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=M4cXih7r; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11264; q=dns/txt;
  s=iport01; t=1777807389; x=1779016989;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8w/FShKlryzv94gx8ZTG6swlZLJNnDreKhG8F9f16+8=;
  b=M4cXih7r1RAA/9eOd5JizHQjSwNgr/A4XIQEFt3EewE/kVHT/kC+KyAx
   giHuwQBxHFtsGaQ76WjUGbwwMlwn/nzMohU34LXvx5BM4hdCKSmc5aGN3
   3ZnHEc55JoDCu2j1fdmBdFINsqgo9CNZqJmV8ZadC/gAw5KS6Q4f7DaPZ
   W58aWOz2btsrk9jRXkveEOXxYbQuv51xYeW4z+GlWhGSqczEy4WbTyBmj
   5mJ1kW1EnNxYKKx2+5dUYvTW3CKlpC9zA4tKbjrBAFEZs+A5DFAQUvQeb
   rKJtu+eWHVoEyeW9YBuBCGxJ4pL+LStl0gM4Lm3Qtm5q39EiB19P4tTsn
   g==;
X-CSE-ConnectionGUID: 8GSCGoNySvaYkCJ3/9Z2jQ==
X-CSE-MsgGUID: XLeIEepvQx252Lr6ZbK90w==
X-IPAS-Result: =?us-ascii?q?A0AaAADQLvdp/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBT0NJhFeIHIc3giGBFp0HFIFrDwEBAQ9RBAEBhQYCjTECJjQJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEQ?=
 =?us-ascii?q?BIQJQImAgJGEAYBEoMCgnQDtB56fzOBAd5AgWQBCxQBgQouAYVxgmYBgXCEB?=
 =?us-ascii?q?juEPycbgUlEgRWCcnaEBQUVg3+CaQSCDYEPFI8bCT+BAhwDWSwBVRMNCgsHB?=
 =?us-ascii?q?WFSMwMgCgsSEhgVAhQvDwQWMh1wDBAXEiwXNFgbBwWBS4MAbRQxBCGBBYRge?=
 =?us-ascii?q?CMsA05yAwsYDUgRLDcGDhsEPQFuB4pmHQ+BP2oHFidSezFnFQUwCZNhgzyNX?=
 =?us-ascii?q?WuBNZ9ZhCaBZKAOATKEBJNikwWZBiKCNqExUIRogWg8gVkzGggbFYMiUxkPj?=
 =?us-ascii?q?i0WHMk8JjI9AQEHAgcNAwuBaJAAEReBVQEB?=
IronPort-Data: A9a23:MI7GtK/JCTUmZ4CKQPfkDrUDQH+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 GYdCzuCbPffMWHzfNpxOYWw8BlX6JHVydM1GlFoqnhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mpyyHjEAX9gWAsbzpPs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2lmErYz1eFREFpQ/
 M0bAxJWKUGx3eCPlefTpulE3qzPLeHxN48Z/3UlxjbDALN+G9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZOEwn1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3Fb4GPJ43bGpoP9qqej
 lLi8kXUDwkEDczFlGCh6CyejMyexTyuDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcATA0Y85zgrZs1gxbnUNluCui2g8fzFDW2x
 CqFxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2Dt7BLLZ2SSR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnwjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:Pk+jVak52INoU8mO4D8fiR2MpVLpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: =?us-ascii?q?9a23=3A0vEQpWse5GESIQMNh/JF4khf6It1XUb243D2MnS?=
 =?us-ascii?q?mAFdqY5/ODg6ioqFdxp8=3D?=
X-Talos-MUID: 9a23:OSlCYgnha1mCzZ9iAx1ndnpSEMpJzqm2Fnkdy8hcn9PaByZTam+C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="732599772"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:23:01 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 1E608180007D0;
	Sun,  3 May 2026 11:23:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:45 -0700
Subject: [PATCH net-next v6 08/10] enic: add MBOX VF handlers for
 capability, register and link state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-8-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807375; l=11669;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=j8jcnV6R/vBeZYaBxbZgAebIz9HVZjEefr0QryF5/TU=;
 b=Xeej+NpjOYpRxAtQ14XFeKWRhzQiB9paC5/nfmicB6XP/e1xgDW4L7SqQOZwUEvVTblP9578f
 0szD/9PBPeNBoJZ3pZfStUpUZgXkeX/47tgCtjfJAH9kJFPRCx0QMZr
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: EEE5F4B5401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283582-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Implement VF-side mailbox message processing for SR-IOV V2
admin channel communication.

VF receive handlers:
  - VF_CAPABILITY_REPLY: store PF protocol version, signal
    completion
  - VF_REGISTER_REPLY: mark VF as registered, signal completion
  - VF_UNREGISTER_REPLY: mark VF as unregistered, signal
    completion
  - PF_LINK_STATE_NOTIF: update carrier state via
    netif_carrier_on/off, send ACK back to PF

VF initiation functions for the probe-time handshake:
  - enic_mbox_vf_capability_check: send capability request,
    wait for PF reply via completion
  - enic_mbox_vf_register: send register request, wait for
    PF confirmation via completion
  - enic_mbox_vf_unregister: send unregister request, wait
    for PF confirmation

The wait helper (enic_mbox_wait_reply) uses
wait_for_completion_timeout, signaled when the admin ISR/NAPI/
workqueue pipeline delivers the reply message.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  17 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 256 ++++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   3 +
 3 files changed, 275 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 9b1fa3857df5..483053c781df 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -258,6 +258,8 @@ struct enic {
 	u32 tx_coalesce_usecs;
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
+	bool vf_registered;
+	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
@@ -305,9 +307,22 @@ struct enic {
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
 
-	/* MBOX protocol state */
+	/* MBOX protocol state -- single-flight: on the VF, all callers
+	 * that wait on mbox_comp run under RTNL or during probe/remove,
+	 * so only one completion is outstanding at a time. mbox_lock
+	 * protects the shared admin WQ from concurrent senders.
+	 */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+	struct completion mbox_comp;
+	/* Type of reply the current waiter on mbox_comp expects.  Set
+	 * under mbox_lock before reinit_completion(); cleared after
+	 * wait_reply returns.  Reply handlers compare against the
+	 * incoming reply type and drop stale replies from previously
+	 * timed-out requests instead of waking the unrelated current
+	 * waiter.
+	 */
+	u8 mbox_expected_reply;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index f3c0e94c2417..7680baece802 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -127,6 +128,16 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
+{
+	unsigned long left;
+
+	left = wait_for_completion_timeout(&enic->mbox_comp,
+					   msecs_to_jiffies(timeout_ms));
+
+	return left ? 0 : -ETIMEDOUT;
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -290,6 +301,157 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
 			    hdr->msg_type, vf_id, err);
 }
 
+static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_capability_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_CAPABILITY_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale capability reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major) == 0)
+		enic->pf_cap_version = le32_to_cpu(reply->version);
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_register_reply(struct enic *enic,
+					       void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_REGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale register reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF register rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = true;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_UNREGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale unregister reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF unregister rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = false;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
+{
+	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
+	struct enic_mbox_pf_link_state_ack_msg ack = {};
+
+	switch (le32_to_cpu(notif->link_state)) {
+	case ENIC_MBOX_LINK_STATE_ENABLE:
+		if (!netif_carrier_ok(enic->netdev))
+			netif_carrier_on(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> UP\n");
+		break;
+	case ENIC_MBOX_LINK_STATE_DISABLE:
+		if (netif_carrier_ok(enic->netdev))
+			netif_carrier_off(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> DOWN\n");
+		break;
+	default:
+		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
+			    le32_to_cpu(notif->link_state));
+		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
+		break;
+	}
+
+	enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK, ENIC_MBOX_DST_PF,
+			   &ack, sizeof(ack));
+}
+
+static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
+				    u16 payload_len, size_t min_len)
+{
+	if (payload_len < min_len) {
+		netdev_warn(enic->netdev,
+			    "MBOX: short payload for type %u (%u < %zu)\n",
+			    msg_type, payload_len, min_len);
+		return false;
+	}
+	return true;
+}
+
+static void enic_mbox_vf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload,
+				     u16 payload_len)
+{
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_capability_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_REGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_register_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_unregister_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_PF_LINK_STATE_NOTIF: {
+		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_link_state(enic, payload);
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF unhandled msg type %u\n",
+			   hdr->msg_type);
+		break;
+	}
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
@@ -330,11 +492,105 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 
 	if (enic->vf_state)
 		enic_mbox_pf_process_msg(enic, hdr, payload);
+	else
+		enic_mbox_vf_process_msg(enic, hdr, payload,
+					 msg_len - (u16)sizeof(*hdr));
+}
+
+int enic_mbox_vf_capability_check(struct enic *enic)
+{
+	struct enic_mbox_vf_capability_msg req = {};
+	int err;
+
+	enic->pf_cap_version = 0;
+	enic->mbox_expected_reply = ENIC_MBOX_VF_CAPABILITY_REPLY;
+	reinit_completion(&enic->mbox_comp);
+	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
+				 ENIC_MBOX_DST_PF, &req, sizeof(req));
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: no capability reply from PF\n");
+		return err;
+	}
+
+	if (enic->pf_cap_version < ENIC_MBOX_CAP_VERSION_1) {
+		netdev_warn(enic->netdev,
+			    "MBOX: PF version %u too old\n",
+			    enic->pf_cap_version);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int enic_mbox_vf_register(struct enic *enic)
+{
+	int err;
+
+	enic->vf_registered = false;
+	enic->mbox_expected_reply = ENIC_MBOX_VF_REGISTER_REPLY;
+	reinit_completion(&enic->mbox_comp);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF registration with PF timed out\n");
+		return err;
+	}
+
+	if (!enic->vf_registered)
+		return -ENODEV;
+
+	return 0;
+}
+
+int enic_mbox_vf_unregister(struct enic *enic)
+{
+	int err;
+
+	if (!enic->vf_registered)
+		return 0;
+
+	enic->mbox_expected_reply = ENIC_MBOX_VF_UNREGISTER_REPLY;
+	reinit_completion(&enic->mbox_comp);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err)
+		return err;
+	if (enic->vf_registered)
+		return -EACCES;
+	return 0;
 }
 
 void enic_mbox_init(struct enic *enic)
 {
 	enic->mbox_msg_num = 0;
 	mutex_init(&enic->mbox_lock);
+	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index f1de67db1273..15e30ee2b0ed 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -88,5 +88,8 @@ void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
+int enic_mbox_vf_capability_check(struct enic *enic);
+int enic_mbox_vf_register(struct enic *enic);
+int enic_mbox_vf_unregister(struct enic *enic);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


