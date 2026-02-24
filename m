Return-Path: <netdev+bounces-260278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH64KuPvnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB1180365
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 239AE301A693
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9B2135D7;
	Tue, 24 Feb 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="GJqrFvKs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273C221277
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892694; cv=none; b=bF3lTt9Zzq9kIonzHyGd65G+WOZXDli6UibJ8QXOTg7nwHzGRcS+YDPMx0149aT/Kcg90dYA11xZpi0oQrbE5wCdx5qhpHMgRij4pQar2YM0FImJNrE25VSjPdOjrCEasBef7TlDlXL8JYslWnoVn/KZHKlrofSx4UTDZZPsrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892694; c=relaxed/simple;
	bh=xqnxaguSeErwgLDXscG5kXGSJAYBBwmkMUrwv1GNpro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUcKDsiD87Yj89hHtU34wgWxBkr8POqWI0+ndkZQyiRqtwBUcB8qfkFEPRtu0B+X9f9s7ESTqdYt7OOzn4WoYmHEgt1j3agH/rCNLGS4KQoBG4t8Y66if8hVUIU3BQRXdJzrWftdovwqcPvqZkI6v9GBO1DxdyKsMwMzcUziNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=GJqrFvKs; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJD5Gg3058462
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=G4IH0zmrVinYhev5KrLW+QHxq9Z7F4wrMVi+mfJmamM=; b=GJqrFvKsChTI
	DQcec8Xx9GDqQVmGyn70Cjq8p392Z4IZzNYXQE2iM5S7crChPw+eR2ujIHk7EqA1
	Vw3erXz6GIZI+FwpaRCCQBcR3Feq74MzbVhjXUNN5djW8IGS93xkAiyAiKNL65/Q
	vZ1yPXHR5eL7CSy8BFpDppgktTr2WpK3PxyzZ/dF3aNE8Vgxzx62+1DEVjDCrBsJ
	hFiS4hgTMZAjN38RuRamSe39DCQZUCxNH442MXOKmPh7Q8gevmlwRzjxh0Eew5iL
	CZlnF/FqeVxi64peHem+VAWUwIU4VzI1eV2WpWsJPJGVt3NEqHkwSaT0SgqkX866
	JQotVF73jA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgvuyjxrx-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:51 -0800 (PST)
Received: from twshared18080.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:47 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 0C64765F7EDC; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH net-next 6/9] psp: Add new netlink cmd for dev-assoc and dev-disassoc
Date: Mon, 23 Feb 2026 16:24:06 -0800
Message-ID: <20260224002410.1553838-7-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX3rHX/YMixnaI
 tU9ELMwFKvmDIxicTycg7iNZ1T28g0Tsd7qx5kHdXocMXmoOcUIG67rniVXutOB5kpuskSPDOO7
 ItmFIhgwE2USJVcLEr7N+MVzgN5GRUD8jHwWdBYxY/BIiRBKgyv8Fahojpqz66xR06FJ7MfKQnZ
 CvB9YuHNqwyQ8rvZDmFxm7FsMH4lktxLRfUfez6Vbnpy8NgNtAvc3MjUVZVmKkHXpAoLRmCrZpf
 dtUEEQnBispIWY1YkQhxu2uC1DjE5EsXTbRd6OlpkOR35SOnozXcjBmg2KyXbLJXGVH7EUE5JRE
 92ps9YlQ6titS46c0BNK8vRsbQnGELBG9obSf4uTIDdsSSLyMVi29/xJIXGGmqHvl8ciSnJ26dE
 ySK5vILq8WplTzrNaTNGxn4hr8DpQvYK+rztpKQjojDm/FoW7cDqgHXS0B8oDFO7+boVowv998E
 ACxOCZDtRVrGyUafBFQ==
X-Proofpoint-GUID: rLInPClJb10gDG4vRJbDfnyJCi8pHUqZ
X-Proofpoint-ORIG-GUID: rLInPClJb10gDG4vRJbDfnyJCi8pHUqZ
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=699cefd3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=FOH2dFAWAAAA:8 a=Ugic4e9Wzjr2O-GaQSEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260278-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fb.com:mid,fb.com:dkim,fb.com:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5EB1180365
X-Rspamd-Action: no action

The main purpose of this cmd is to be able to associcate a
non-psp-capable device (e.g. veth) with a psp device.
One use case is if we create a pair of veth/netkit, and assign 1 end
inside a netns, while leaving the other end within the default netns,
with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
With this command, we could associate the veth/netkit inside the netns
with PSP device, so the virtual device could act as PSP-capable device
to initiate PSP connections, and performs PSP encryption/decryption on
the real PSP device.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 Documentation/netlink/specs/psp.yaml |  64 ++++++-
 include/net/psp/types.h              |  15 ++
 include/uapi/linux/psp.h             |  13 ++
 net/psp/psp-nl-gen.c                 |  32 ++++
 net/psp/psp-nl-gen.h                 |   2 +
 net/psp/psp_main.c                   |  21 ++-
 net/psp/psp_nl.c                     | 269 ++++++++++++++++++++++++++-
 7 files changed, 407 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink=
/specs/psp.yaml
index 2ef94f3503c8..0e096d79789c 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -13,6 +13,17 @@ definitions:
               hdr0-aes-gmac-128, hdr0-aes-gmac-256]
=20
 attribute-sets:
+  -
+    name: assoc-dev-info
+    attributes:
+      -
+        name: ifindex
+        doc: ifindex of an associated network device.
+        type: u32
+      -
+        name: nsid
+        doc: Network namespace ID of the associated device.
+        type: s32
   -
     name: dev
     attributes:
@@ -24,7 +35,9 @@ attribute-sets:
           min: 1
       -
         name: ifindex
-        doc: ifindex of the main netdevice linked to the PSP device.
+        doc: |
+          ifindex of the main netdevice linked to the PSP device,
+          or the ifindex to associate with the PSP device.
         type: u32
       -
         name: psp-versions-cap
@@ -38,6 +51,25 @@ attribute-sets:
         type: u32
         enum: version
         enum-as-flags: true
+      -
+        name: assoc-list
+        doc: List of associated virtual devices.
+        type: nest
+        nested-attributes: assoc-dev-info
+        multi-attr: true
+      -
+        name: nsid
+        doc: Network namespace ID for the device to associate/disassocia=
te.
+        type: s32
+      -
+        name: by-association
+        doc: |
+          Flag indicating the PSP device is an associated device from a
+          different network namespace.
+          Present when in associated namespace, absent when in primary/h=
ost
+          namespace.
+        type: flag
+
   -
     name: assoc
     attributes:
@@ -170,6 +202,8 @@ operations:
             - ifindex
             - psp-versions-cap
             - psp-versions-ena
+            - assoc-list
+            - by-association
         pre: psp-device-get-locked-unpriv
         post: psp-device-unlock
       dump:
@@ -271,6 +305,34 @@ operations:
         post: psp-device-unlock
       dump:
         reply: *stats-all
+    -
+      name: dev-assoc
+      doc: Associate a network device with a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - ifindex
+            - nsid
+        reply:
+          attributes: []
+        pre: psp-device-get-locked-unpriv
+        post: psp-device-unlock
+    -
+      name: dev-disassoc
+      doc: Disassociate a network device from a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - ifindex
+            - nsid
+        reply:
+          attributes: []
+        pre: psp-device-get-locked-unpriv
+        post: psp-device-unlock
=20
 mcast-groups:
   list:
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 25a9096d4e7d..4bd432ed107a 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -5,6 +5,7 @@
=20
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <net/net_trackers.h>
=20
 struct netlink_ext_ack;
=20
@@ -43,9 +44,22 @@ struct psp_dev_config {
 	u32 versions;
 };
=20
+/**
+ * struct psp_assoc_dev - wrapper for associated net_device
+ * @dev_list: list node for psp_dev::assoc_dev_list
+ * @assoc_dev: the associated net_device
+ * @dev_tracker: tracker for the net_device reference
+ */
+struct psp_assoc_dev {
+	struct list_head dev_list;
+	struct net_device *assoc_dev;
+	netdevice_tracker dev_tracker;
+};
+
 /**
  * struct psp_dev - PSP device struct
  * @main_netdev: original netdevice of this PSP device
+ * @assoc_dev_list: list of psp_assoc_dev entries associated with this P=
SP device
  * @ops:	driver callbacks
  * @caps:	device capabilities
  * @drv_priv:	driver priv pointer
@@ -67,6 +81,7 @@ struct psp_dev_config {
  */
 struct psp_dev {
 	struct net_device *main_netdev;
+	struct list_head assoc_dev_list;
=20
 	struct psp_dev_ops *ops;
 	struct psp_dev_caps *caps;
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index a3a336488dc3..1c8899cd4da5 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -17,11 +17,22 @@ enum psp_version {
 	PSP_VERSION_HDR0_AES_GMAC_256,
 };
=20
+enum {
+	PSP_A_ASSOC_DEV_INFO_IFINDEX =3D 1,
+	PSP_A_ASSOC_DEV_INFO_NSID,
+
+	__PSP_A_ASSOC_DEV_INFO_MAX,
+	PSP_A_ASSOC_DEV_INFO_MAX =3D (__PSP_A_ASSOC_DEV_INFO_MAX - 1)
+};
+
 enum {
 	PSP_A_DEV_ID =3D 1,
 	PSP_A_DEV_IFINDEX,
 	PSP_A_DEV_PSP_VERSIONS_CAP,
 	PSP_A_DEV_PSP_VERSIONS_ENA,
+	PSP_A_DEV_ASSOC_LIST,
+	PSP_A_DEV_NSID,
+	PSP_A_DEV_BY_ASSOCIATION,
=20
 	__PSP_A_DEV_MAX,
 	PSP_A_DEV_MAX =3D (__PSP_A_DEV_MAX - 1)
@@ -74,6 +85,8 @@ enum {
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
 	PSP_CMD_GET_STATS,
+	PSP_CMD_DEV_ASSOC,
+	PSP_CMD_DEV_DISASSOC,
=20
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX =3D (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 106607a201d8..753cbe993399 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -53,6 +53,20 @@ static const struct nla_policy psp_get_stats_nl_policy=
[PSP_A_STATS_DEV_ID + 1] =3D
 	[PSP_A_STATS_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
 };
=20
+/* PSP_CMD_DEV_ASSOC - do */
+static const struct nla_policy psp_dev_assoc_nl_policy[PSP_A_DEV_NSID + =
1] =3D {
+	[PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
+	[PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
+};
+
+/* PSP_CMD_DEV_DISASSOC - do */
+static const struct nla_policy psp_dev_disassoc_nl_policy[PSP_A_DEV_NSID=
 + 1] =3D {
+	[PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
+	[PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] =3D {
 	{
@@ -119,6 +133,24 @@ static const struct genl_split_ops psp_nl_ops[] =3D =
{
 		.dumpit	=3D psp_nl_get_stats_dumpit,
 		.flags	=3D GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		=3D PSP_CMD_DEV_ASSOC,
+		.pre_doit	=3D psp_device_get_locked_unpriv,
+		.doit		=3D psp_nl_dev_assoc_doit,
+		.post_doit	=3D psp_device_unlock,
+		.policy		=3D psp_dev_assoc_nl_policy,
+		.maxattr	=3D PSP_A_DEV_NSID,
+		.flags		=3D GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		=3D PSP_CMD_DEV_DISASSOC,
+		.pre_doit	=3D psp_device_get_locked_unpriv,
+		.doit		=3D psp_nl_dev_disassoc_doit,
+		.post_doit	=3D psp_device_unlock,
+		.policy		=3D psp_dev_disassoc_nl_policy,
+		.maxattr	=3D PSP_A_DEV_NSID,
+		.flags		=3D GENL_CMD_CAP_DO,
+	},
 };
=20
 static const struct genl_multicast_group psp_nl_mcgrps[] =3D {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 7abad086be1e..d3b331888f9c 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -33,6 +33,8 @@ int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct ge=
nl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback=
 *cb);
+int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info=
);
=20
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index ad2294622a7d..a836bb905f1a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -33,8 +33,18 @@ struct mutex psp_devs_lock;
  */
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool unpr=
iv)
 {
+	struct psp_assoc_dev *entry;
+
 	if (dev_net(psd->main_netdev) =3D=3D net)
 		return 0;
+
+	if (unpriv) {
+		list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+			if (dev_net(entry->assoc_dev) =3D=3D net)
+				return 0;
+		}
+	}
+
 	return -ENOENT;
 }
=20
@@ -70,6 +80,7 @@ psp_dev_create(struct net_device *netdev,
 		return ERR_PTR(-ENOMEM);
=20
 	psd->main_netdev =3D netdev;
+	INIT_LIST_HEAD(&psd->assoc_dev_list);
 	psd->ops =3D psd_ops;
 	psd->caps =3D psd_caps;
 	psd->drv_priv =3D priv_ptr;
@@ -117,6 +128,7 @@ void psp_dev_free(struct psp_dev *psd)
  */
 void psp_dev_unregister(struct psp_dev *psd)
 {
+	struct psp_assoc_dev *entry, *entry_tmp;
 	struct psp_assoc *pas, *next;
=20
 	mutex_lock(&psp_devs_lock);
@@ -136,6 +148,14 @@ void psp_dev_unregister(struct psp_dev *psd)
 	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
 		psp_dev_tx_key_del(psd, pas);
=20
+	list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
+				 dev_list) {
+		list_del(&entry->dev_list);
+		rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+		netdev_put(entry->assoc_dev, &entry->dev_tracker);
+		kfree(entry);
+	}
+
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
=20
 	psd->ops =3D NULL;
@@ -320,5 +340,4 @@ static int __init psp_init(void)
=20
 	return genl_register_family(&psp_nl_family);
 }
-
 subsys_initcall(psp_init);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 8e0e4a853f9b..40d702e34064 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -2,6 +2,7 @@
=20
 #include <linux/ethtool.h>
 #include <linux/skbuff.h>
+#include <linux/net_namespace.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
 #include <net/psp.h>
@@ -38,6 +39,58 @@ static int psp_nl_reply_send(struct sk_buff *rsp, stru=
ct genl_info *info)
 	return genlmsg_reply(rsp, info);
 }
=20
+static bool psp_nl_has_listeners_any_ns(struct psp_dev *psd, unsigned in=
t group)
+{
+	struct psp_assoc_dev *entry;
+
+	if (genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
+			       group))
+		return true;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		if (genl_has_listeners(&psp_nl_family,
+				       dev_net(entry->assoc_dev), group))
+			return true;
+	}
+
+	return false;
+}
+
+static void psp_nl_multicast_all_ns(struct psp_dev *psd, struct sk_buff =
*ntf,
+				    unsigned int group)
+{
+	struct psp_assoc_dev *entry;
+	struct sk_buff *ntf_copy;
+	struct xarray sent_nets;
+	struct net *main_net;
+
+	main_net =3D dev_net(psd->main_netdev);
+	xa_init(&sent_nets);
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		struct net *assoc_net =3D dev_net(entry->assoc_dev);
+		int ret;
+
+		if (net_eq(assoc_net, main_net))
+			continue;
+
+		ret =3D xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
+				GFP_KERNEL);
+		if (ret =3D=3D -EBUSY)
+			continue;
+
+		ntf_copy =3D skb_clone(ntf, GFP_KERNEL);
+		if (!ntf_copy)
+			break;
+
+		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf_copy, 0,
+					group, GFP_KERNEL);
+	}
+	xa_destroy(&sent_nets);
+	/* Send to main device netns */
+	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
+				GFP_KERNEL);
+}
+
 /* Device stuff */
=20
 static struct psp_dev *
@@ -102,11 +155,74 @@ psp_device_unlock(const struct genl_split_ops *ops,=
 struct sk_buff *skb,
 		sockfd_put(socket);
 }
=20
+static bool psp_has_assoc_dev_in_ns(struct psp_dev *psd, struct net *net=
)
+{
+	struct psp_assoc_dev *entry;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		if (dev_net(entry->assoc_dev) =3D=3D net)
+			return true;
+	}
+
+	return false;
+}
+
+static int psp_nl_fill_assoc_dev_list(struct psp_dev *psd, struct sk_buf=
f *rsp,
+				      struct net *cur_net,
+				      struct net *filter_net)
+{
+	struct psp_assoc_dev *entry;
+	struct net *dev_net_ns;
+	struct nlattr *nest;
+	int nsid;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		dev_net_ns =3D dev_net(entry->assoc_dev);
+
+		if (filter_net && dev_net_ns !=3D filter_net)
+			continue;
+
+		/* When filtering by namespace, all devices are in the caller's
+		 * namespace so nsid is always NETNSA_NSID_NOT_ASSIGNED (-1).
+		 * Otherwise, calculate the nsid relative to cur_net.
+		 */
+		nsid =3D filter_net ? NETNSA_NSID_NOT_ASSIGNED :
+				    peernet2id_alloc(cur_net, dev_net_ns,
+						     GFP_KERNEL);
+
+		nest =3D nla_nest_start(rsp, PSP_A_DEV_ASSOC_LIST);
+		if (!nest)
+			return -1;
+
+		if (nla_put_u32(rsp, PSP_A_ASSOC_DEV_INFO_IFINDEX,
+				entry->assoc_dev->ifindex) ||
+		    nla_put_s32(rsp, PSP_A_ASSOC_DEV_INFO_NSID, nsid)) {
+			nla_nest_cancel(rsp, nest);
+			return -1;
+		}
+
+		nla_nest_end(rsp, nest);
+	}
+
+	return 0;
+}
+
 static int
 psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 		const struct genl_info *info)
 {
+	struct net *cur_net;
 	void *hdr;
+	int err;
+
+	cur_net =3D genl_info_net(info);
+
+	/* Skip this device if we're in an associated netns but have no
+	 * associated devices in cur_net
+	 */
+	if (cur_net !=3D dev_net(psd->main_netdev) &&
+	    !psp_has_assoc_dev_in_ns(psd, cur_net))
+		return 0;
=20
 	hdr =3D genlmsg_iput(rsp, info);
 	if (!hdr)
@@ -118,6 +234,22 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff =
*rsp,
 	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
 		goto err_cancel_msg;
=20
+	if (cur_net =3D=3D dev_net(psd->main_netdev)) {
+		/* Primary device - dump assoc list */
+		err =3D psp_nl_fill_assoc_dev_list(psd, rsp, cur_net, NULL);
+		if (err)
+			goto err_cancel_msg;
+	} else {
+		/* In netns: set by-association flag and dump filtered
+		 * assoc list containing only devices in cur_net
+		 */
+		if (nla_put_flag(rsp, PSP_A_DEV_BY_ASSOCIATION))
+			goto err_cancel_msg;
+		err =3D psp_nl_fill_assoc_dev_list(psd, rsp, cur_net, cur_net);
+		if (err)
+			goto err_cancel_msg;
+	}
+
 	genlmsg_end(rsp, hdr);
 	return 0;
=20
@@ -131,8 +263,7 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
 	struct genl_info info;
 	struct sk_buff *ntf;
=20
-	if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
-				PSP_NLGRP_MGMT))
+	if (!psp_nl_has_listeners_any_ns(psd, PSP_NLGRP_MGMT))
 		return;
=20
 	ntf =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -140,13 +271,13 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd=
)
 		return;
=20
 	genl_info_init_ntf(&info, &psp_nl_family, cmd);
+	genl_info_net_set(&info, dev_net(psd->main_netdev));
 	if (psp_nl_dev_fill(psd, ntf, &info)) {
 		nlmsg_free(ntf);
 		return;
 	}
=20
-	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
-				0, PSP_NLGRP_MGMT, GFP_KERNEL);
+	psp_nl_multicast_all_ns(psd, ntf, PSP_NLGRP_MGMT);
 }
=20
 int psp_nl_dev_get_doit(struct sk_buff *req, struct genl_info *info)
@@ -243,8 +374,8 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct g=
enl_info *info)
 int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct psp_dev *psd =3D info->user_ptr[0];
-	struct genl_info ntf_info;
 	struct sk_buff *ntf, *rsp;
+	struct genl_info ntf_info;
 	u8 prev_gen;
 	int err;
=20
@@ -280,8 +411,9 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struc=
t genl_info *info)
 	psd->stats.rotations++;
=20
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
-	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
-				0, PSP_NLGRP_USE, GFP_KERNEL);
+
+	psp_nl_multicast_all_ns(psd, ntf, PSP_NLGRP_USE);
+
 	return psp_nl_reply_send(rsp, info);
=20
 err_free_ntf:
@@ -291,6 +423,129 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, str=
uct genl_info *info)
 	return err;
 }
=20
+int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd =3D info->user_ptr[0];
+	struct psp_assoc_dev *psp_assoc_dev;
+	struct net_device *assoc_dev;
+	u32 assoc_ifindex;
+	struct sk_buff *rsp;
+	struct net *net;
+	int nsid;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
+		return -EINVAL;
+
+	nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
+	net =3D get_net_ns_by_id(genl_info_net(info), nsid);
+	if (!net) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
+		return -EINVAL;
+	}
+
+	psp_assoc_dev =3D kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
+	if (!psp_assoc_dev) {
+		put_net(net);
+		return -ENOMEM;
+	}
+
+	assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
+	assoc_dev =3D netdev_get_by_index(net, assoc_ifindex,
+					&psp_assoc_dev->dev_tracker,
+					GFP_KERNEL);
+	if (!assoc_dev) {
+		put_net(net);
+		kfree(psp_assoc_dev);
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
+		return -ENODEV;
+	}
+
+	/* Check if device is already associated with a PSP device */
+	if (rcu_access_pointer(assoc_dev->psp_dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Device already associated with a PSP device");
+		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
+		put_net(net);
+		kfree(psp_assoc_dev);
+		return -EBUSY;
+	}
+
+	psp_assoc_dev->assoc_dev =3D assoc_dev;
+	rsp =3D psp_nl_reply_new(info);
+	if (!rsp) {
+		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
+		put_net(net);
+		kfree(psp_assoc_dev);
+		return -ENOMEM;
+	}
+
+	rcu_assign_pointer(assoc_dev->psp_dev, psd);
+	list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
+
+	put_net(net);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+}
+
+int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info=
)
+{
+	struct psp_assoc_dev *entry, *found =3D NULL;
+	struct psp_dev *psd =3D info->user_ptr[0];
+	u32 assoc_ifindex;
+	struct sk_buff *rsp;
+	struct net *net;
+	int nsid;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
+		return -EINVAL;
+
+	nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
+	net =3D get_net_ns_by_id(genl_info_net(info), nsid);
+	if (!net) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
+		return -EINVAL;
+	}
+
+	assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
+
+	/* Search the association list by ifindex and netns */
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev->ifindex =3D=3D assoc_ifindex &&
+		    dev_net(entry->assoc_dev) =3D=3D net) {
+			found =3D entry;
+			break;
+		}
+	}
+
+	if (!found) {
+		put_net(net);
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
+		return -ENODEV;
+	}
+
+	rsp =3D psp_nl_reply_new(info);
+	if (!rsp) {
+		put_net(net);
+		return -ENOMEM;
+	}
+
+	/* Remove from the association list */
+	list_del(&found->dev_list);
+	rcu_assign_pointer(found->assoc_dev->psp_dev, NULL);
+	netdev_put(found->assoc_dev, &found->dev_tracker);
+	kfree(found);
+
+	put_net(net);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+}
+
 /* Key etc. */
=20
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
--=20
2.47.3


