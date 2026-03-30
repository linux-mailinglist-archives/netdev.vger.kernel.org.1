Return-Path: <netdev+bounces-273055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPTRLE7kyWlC3QUAu9opvQ
	(envelope-from <netdev+bounces-273055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1E354DE5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB17303F7E1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78641396B68;
	Mon, 30 Mar 2026 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT+U+oJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD293939AF;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838718; cv=none; b=c11kqI5PZyiJJ+nJs0oATJZ1HSypRU6vqZowhBZgn8YAXb7rnlLuxp6eqlUYE3mThpQY6Gj1baRquLJfWEzAxblgdyvE6TUPemnsk3Lk3rhZCTuaqFZmeSJssaIcrK6+W7VlxeC98q145XioZj3fsxqEKksF8rL5LGZagiTbq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838718; c=relaxed/simple;
	bh=YhIMr4yYwBZ5EllsEmbIO/ym48ayC5JDhQ8YCwvYqy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Btvt+6GaAHi+ilDoYKvtNN1k0GP3ozozvJ6UdrMjMniVylRg4FAVFdUq/cuZZo5L1F7XJ7eomtacaLxJbAPhJoMBRqIWqZkxbEQ4wm9WZhQ3AEjzDZSq6Exa3yphcY4I5gm4+wQduLRG4HlNSJ3ZD3Xez4BWTG33xyWKsDOKPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT+U+oJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D23E5C2BCB2;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774838717;
	bh=YhIMr4yYwBZ5EllsEmbIO/ym48ayC5JDhQ8YCwvYqy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kT+U+oJAZyIxRAtDgVTRzxcEg4FTCHTNh4TziPcxfubv8KFYBMVKv0xsKbcGKWFaN
	 mzZyif+OagQBy5a5LkoGK2jRTSPOFHqdet+vUEXUSHs17WGfmrFYZssWQOd7yeBV4D
	 Dqyxi/uG7KBLFg5CaYFq4HVPTIi+YKbaE7xLRzmlrfDlN3jxr6rJGNweMNfbFKpGgj
	 fRr14m6/xeht05GKoUbpruWzlBjM31CHspwUhM2OacWJJMujRvf9Whk8aVor8zKiFa
	 /boW/ccDkLli8t3d8b6werWrq34CPyiJfFrLPzY2WuKCmOl7g0eMVg7PjzfjeaS9Cu
	 rATSDVD8RC6Kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB18FF4934;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sun, 29 Mar 2026 19:45:22 -0700
Subject: [PATCH net-next v3 6/6] enic: detect admin channel resources for
 SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-enic-sriov-v2-prep-v3-6-19a477549ef6@cisco.com>
References: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
In-Reply-To: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774838716; l=2466;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=1nJliUotDMusF5w/UMmuyqwJOqlCYgr21D/fx9rjM1w=;
 b=FP3N6n9JNqA14RAcxqQshUiFQzZBox6Hs9ztDbhE85d+PFcCHb2lUFqDb+YhKX9YHpF/yaE8j
 GOKEOtvVDYaCEZQAGa6PQk5dxH8bmwgEKsBktNdKFJMu0DkDpYCipUg
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273055-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17D1E354DE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Check for the presence of admin channel BAR resources
(RES_TYPE_ADMIN_WQ, ADMIN_RQ, ADMIN_CQ, SRIOV_INTR) during resource
discovery. Set has_admin_channel when all four are available.

Use ARRAY_SIZE(enic->admin_cq) for the admin CQ count check since the
driver allocates two admin CQs (one for WQ completions, one for RQ
completions) and both must be backed by hardware resources.

Add admin WQ, RQ, CQ and INTR fields to struct enic for use by the
upcoming admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  7 +++++++
 drivers/net/ethernet/cisco/enic/enic_res.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

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
index bbd3143ed73e..2b7545d6a67f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -205,10 +205,18 @@ void enic_get_res_counts(struct enic *enic)
 	enic->cq_count = enic->cq_avail;
 	enic->intr_count = enic->intr_avail;
 
+	enic->has_admin_channel =
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_WQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
+			ARRAY_SIZE(enic->admin_cq) &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
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



