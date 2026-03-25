Return-Path: <netdev+bounces-271431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCcMOjmNw2lVrgQAu9opvQ
	(envelope-from <netdev+bounces-271431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA37320A07
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 692CE305D60B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD134CFBA;
	Wed, 25 Mar 2026 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS3IDviO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4F365A05;
	Wed, 25 Mar 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423300; cv=none; b=mVSv57vOZJ+UziENqT8RS6xi4TzVZnG3hwA+KnQttHP7FWhrigQzTI1nBCIomEAf8iLfcWbARf1SgQl+Rr5axbF3vbXpMqKRFG5Qx1JHY8DYg6Ma3kmav/ZusgqrfFNxup4a68YUBxon5TBT8PFG8PnC7trEnkIe6RKtClTQQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423300; c=relaxed/simple;
	bh=37FGZY+8d8I7xFQKUrk70CCSCQXTT/DB4uVq3pHa4GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvY/Pqe06KEYp0GZ3qId9VDouGkBpBkjJw39nr6GIs7aswwKkK8GJ9KsRUignuMsn8Af5/cXBPAQrzVT4EM8X/eZnX6TQJnBXB41shzrl8YNY7vwVSoacvin7mgahmyo4shi/BCQ5YpnWluIzct3o/BMJBoywZNuq09sh3Vz/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS3IDviO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9BA3C2BCB2;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=37FGZY+8d8I7xFQKUrk70CCSCQXTT/DB4uVq3pHa4GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NS3IDviOzK0HnNEA4zaOh+0/ES/4yVJkFErM/xy1/Mn2WD80Ydh+4NfvpUDXgyBcG
	 uS1ajUNtbcGSOFGh6ZuevFKlSMGRgaLqqAlUeZkVDAnEwqhaJrYJrbrCXdH4i3sR1V
	 By4JuK/fd0z5gcSmSH2JQOwUlB155x7wnOVs+Ec0I5S87guSuniFe4WjseA4EEIt+W
	 X1Cq7km9X2Kwwa8p1IMuvUxM/g5/TM/tQ9ftYSzkxnXER7H3nGCifbdMlS7r5JVna6
	 FURW2ft7utHrcGQTNb1rukDTQc8jSle7dHP07ozOFJi3up61i36tlrm/Ou3EZYUpR+
	 9qXwlJ0I7Km9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCAFEA820;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 00:21:44 -0700
Subject: [PATCH net-next 6/6] enic: detect admin channel resources for
 SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v1-6-48f04ce110cc@cisco.com>
References: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=2164;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=guisoYvjQEJ8FK6Xz6w9CEhNlc7jafORVN4tNVa2Oos=;
 b=PfpO0JF8mYFRAIQx1SWbsr9fLnn+L2FFn3IoY/UhwYFzFBPI7ORXO0bs64UCkYS0yKqHxNsE0
 57vrlNsMmyfBl2zVXYD8JaEuuVPosrfo1Z0kEj1taKVdbuUltDLyGSR
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271431-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 8BA37320A07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Check for the presence of admin channel BAR resources
(RES_TYPE_ADMIN_WQ, ADMIN_RQ, ADMIN_CQ, SRIOV_INTR) during resource
discovery. Set has_admin_channel when all four are available.

Add admin WQ, RQ, CQ and INTR fields to struct enic for use by the
upcoming admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  7 +++++++
 drivers/net/ethernet/cisco/enic/enic_res.c | 10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 67fd780b1fa1..08472420f3a1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -289,6 +289,13 @@ struct enic {
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
 	enum ext_cq ext_cq;
+
+	/* Admin channel resources for SR-IOV MBOX */
+	bool has_admin_channel;
+	struct vnic_wq admin_wq;
+	struct vnic_rq admin_rq;
+	struct vnic_cq admin_cq[2];
+	struct vnic_intr admin_intr;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index bbd3143ed73e..a3dc727d63ef 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -205,10 +205,16 @@ void enic_get_res_counts(struct enic *enic)
 	enic->cq_count = enic->cq_avail;
 	enic->intr_count = enic->intr_avail;
 
+	enic->has_admin_channel =
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_WQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >= 1;
+
 	dev_info(enic_get_dev(enic),
-		"vNIC resources avail: wq %d rq %d cq %d intr %d\n",
+		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",
 		enic->wq_avail, enic->rq_avail,
-		enic->cq_avail, enic->intr_avail);
+		enic->cq_avail, enic->intr_avail,
+		enic->has_admin_channel ? "yes" : "no");
 }
 
 void enic_init_vnic_resources(struct enic *enic)

-- 
2.43.0



