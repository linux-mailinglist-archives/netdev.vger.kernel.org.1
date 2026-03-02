Return-Path: <netdev+bounces-262792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOQMDjfspWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:59:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51F1DF0AE
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD83E3075E9B
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0F383C80;
	Mon,  2 Mar 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NkC6y0UE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF333F8BA
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481275; cv=none; b=MoOHkOhFbx15B9n9+feHoDEJX8TSakQKiFwlst6VAg1IpOn8i3Llbms9ejpzRsB9b/XskXpLVOTVYhfAbWaN2pWU+woa9G3daTxyCCjFlf++4tgyXDD4oZr1u083jOF0uXRIeYnS7Vb6FoPahcRCOvMsfiyffvUFKJFSxA0Zpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481275; c=relaxed/simple;
	bh=wWQCRkOW4iqit3j0Cj5I/waGyxA4vH1GLCmRkmFZ2qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/PDkyfzi/yIwDv4v9fnE3lDrbt5iPhuoiD3NkhSpe/KLuChUhFdlnZIdFSnGoSZpSDZgr6aDnKkqxhxZEirajWVUeya2Zb2h5hG7Qt3k8/M9q7Zt/4MveSigEh2NbqZc0fbOq2nH7i6p+GNxaEgIj7E3egRHeivMRnXw/Irmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NkC6y0UE; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso3220646241.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481272; x=1773086072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAaX3Kv2lAlE9d5YGhlxio3GXtW87/iaolDngHMpMnU=;
        b=Sow+QZ9+m7Dxwwu2ZdoxeYYOOfH38leBQFPeWCfcVjZAEie58sERlxYW5xbZg513d0
         Q3J84c9a0cdwS8R8DQMshTc7N4jSC2cxrj8YhFk+GRBmZkVlaY2KyNgcRimF87YcN2Vr
         Fkdp1KHGfHp+l40SxAej+iTzpJ04nt/oHlb5aIyLQkEC7I+ZCmdwOs+c00fzdgIHtbLd
         CJNKWvrRKy50fWBCbzCvPsZ2YLxAvpD8/drVZeNbGR7BlmztMSC5Oq64Gvntz6D5mKL0
         V8n+GMx/dp9KZ55hYy0QASw6V58wVv2uEnrh5LDe12xEPe+uEwWd1f6+qLBzWvBxo1IR
         69Cg==
X-Gm-Message-State: AOJu0Yxqq8G23kVlHJB0ZyLcLeWB+eIm3DhMV9LIxBpkxaA1kMZ9ZlEa
	hTrTg8deRVz/JSPvBz95zR7zZgFAjJQV/j651dbKeY7ul/pNkiIe0bO/xxfcULSBi3Zyu1PRz2N
	tuqYK2C9Aq//VqUCQaJRS8QFrrwzwByb4kMTRC+3eNJm2oMZfzP6QXcMDB9mrXmV+ItzzDPZpzr
	6zM6lO7N8eg+o/7xB8JJcC5rPPsxDKO3EvimslJML2nyH3/EJ3KrrNF7xQN1GDGtOf8bnY7yIDk
	xGgIBiJSNJsXVWg55M6
X-Gm-Gg: ATEYQzzBv36+X7GW5IQ5UJnXWIUBgl6XUpZdDYApsJKIxTvjb+NOG5wCpSysw1+fEVd
	1VRf6S7+oDO/Bs00CoAGS656JsYYzHIlmyaOa+7wpeJepUykWhvE2kuUhVc7uDYnrmbtP+k9vUA
	mY59IUGasDtjK/yrCzd9I/+1iSS9kFxGLjeZgE6Cp/6FTclxN6xwfN8CFAkyAM+UdwNax4RJLeN
	m1UZ3V5E+38kyagtXwbgh+ZbSCcFISiha+o7VCuZLT8s2OXmkVI8aytgSl+j/fTDSRu/LjOPFIx
	QXWTmaQXUgO9kVnRNpf8y74uwktDdKyZr8z6PzS900wXqAb1mnP8Uq8aIluaCy+CvjQqhl/VsUd
	LWO0BcJPLffnFiDnxRJ6HRsIpPPAJle8srwRmrSSjuMF0HmrB6w8yL77BZujKNMM7QyOoHenFkt
	tvAMAy23q2uaKA2vx2l0syw6Ba2DAQ1FI0+idUZeyNuKbyQ69U87UJbBORc4yeW8DNwg==
X-Received: by 2002:a05:6102:1610:b0:5fe:f530:2ba3 with SMTP id ada2fe7eead31-5ff3250136cmr7840489137.28.1772481271674;
        Mon, 02 Mar 2026 11:54:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94df6510d1fsm1165915241.6.2026.03.02.11.54.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:54:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb52a9c0eeso3824923185a.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772481271; x=1773086071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAaX3Kv2lAlE9d5YGhlxio3GXtW87/iaolDngHMpMnU=;
        b=NkC6y0UEbLHtZpBJ1dvRrEfMWH6W1ywgEUTod6ef4BXd6avfBPO4CDmFpOfxp0KgrP
         xxvU3e7BWEtLQp6ea3ZCvNoQQH4ALfRaz4YAn45reopSpmC70B+DfvmDcuiJTX2d9O2W
         qb/u7bQ/ldkWs0fsAF7WLUx77A5Gp1R7KbAgo=
X-Received: by 2002:a05:620a:254b:b0:8b2:e058:de83 with SMTP id af79cd13be357-8cbc8d6f11cmr1666154685a.15.1772481271001;
        Mon, 02 Mar 2026 11:54:31 -0800 (PST)
X-Received: by 2002:a05:620a:254b:b0:8b2:e058:de83 with SMTP id af79cd13be357-8cbc8d6f11cmr1666151785a.15.1772481270511;
        Mon, 02 Mar 2026 11:54:30 -0800 (PST)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736cfasm1208049285a.49.2026.03.02.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:54:30 -0800 (PST)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [net-next 1/3] psp: Support resetting statistics on a device
Date: Mon,  2 Mar 2026 11:53:50 -0800
Message-ID: <20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 9A51F1DF0AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-262792-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Drivers may need to reset per-device PSP statistics to zero.
Add a reset-stats netlink command and a corresponding optional
driver callback to support this.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 Documentation/netlink/specs/psp.yaml | 13 +++++++++++++
 include/net/psp/types.h              |  6 ++++++
 include/uapi/linux/psp.h             |  1 +
 net/psp/psp-nl-gen.c                 | 14 ++++++++++++++
 net/psp/psp-nl-gen.h                 |  1 +
 net/psp/psp_nl.c                     | 24 ++++++++++++++++++++++++
 6 files changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index f3a57782d2cf..e37ca142af54 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -272,6 +272,19 @@ operations:
       dump:
         reply: *stats-all
 
+    -
+      name: reset-stats
+      doc: Reset device statistics.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+        reply:
+          attributes: []
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+
 mcast-groups:
   list:
     -
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 25a9096d4e7d..7f9924e8ab0d 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -211,6 +211,12 @@ struct psp_dev_ops {
 	 * Stats must be filled in member-by-member, never memset the struct.
 	 */
 	void (*get_stats)(struct psp_dev *psd, struct psp_dev_stats *stats);
+
+	/**
+	 * @reset_stats: reset the statistics
+	 */
+	int (*reset_stats)(struct psp_dev *psd, struct netlink_ext_ack *extack);
+
 };
 
 #endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index a3a336488dc3..6e0c217a8366 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -74,6 +74,7 @@ enum {
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
 	PSP_CMD_GET_STATS,
+	PSP_CMD_RESET_STATS,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 22a48d0fa378..c8691f7a61ce 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -53,6 +53,11 @@ static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] =
 	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* PSP_CMD_RESET_STATS - do */
+static const struct nla_policy psp_reset_stats_nl_policy[PSP_A_DEV_ID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -119,6 +124,15 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.dumpit	= psp_nl_get_stats_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= PSP_CMD_RESET_STATS,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_reset_stats_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_reset_stats_nl_policy,
+		.maxattr	= PSP_A_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 599c5f1c82f2..67577c898f99 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -31,6 +31,7 @@ int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int psp_nl_reset_stats_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..aa8960c8d4d1 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -277,6 +277,27 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int psp_nl_reset_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	if (!psd->ops->reset_stats)
+		return -EOPNOTSUPP;
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psd->ops->reset_stats(psd, info->extack);
+	if (err)
+		goto err_free_rsp;
+
+	return psp_nl_reply_send(rsp, info);
+
+err_free_rsp:
+	nlmsg_free(rsp);
+	return err;
+}
+
 /* Key etc. */
 
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
-- 
2.45.4


