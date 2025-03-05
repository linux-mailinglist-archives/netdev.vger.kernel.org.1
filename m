Return-Path: <netdev+bounces-171875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA2A4F2FF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815D6188B7DA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE94AEE0;
	Wed,  5 Mar 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5MfFq/u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165614012;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136048; cv=none; b=FKVrfYo+jhY0jPN6afAj6KoF3EfP4ilLuMLVgJWknIeDavqURpZj/z+a8NQYePFJWeUIdRJ8LUQrd9Ci+kPCr/oWt6e+D58d3N0wFd/TMi8bsbuT0jX/BC9OwEB1cXQcSiY2r5MUaqsrKQ3WceQkHY8BEf5AKqMoD3ro35aAcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136048; c=relaxed/simple;
	bh=oo71VY1McPM8/140gIhN/hZPHJcdcpEwgl7m7nF3O78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nN3zq0Vf7q0b7JT81f8kYJwvDqLmw2EmFCLsif4s6TIfE5RHNfO1io9+6FmBbYhYy2nSy4EpxVyDRivRe95eTGEcMxVRM2vx5FXs83B/+wWjQ2lJNXNqLs6u6O8oDwEUtZBvz4OaUDYOTuuV/I8xtTgav1H4Zn2gQTZtg+D4kxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5MfFq/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F582C4CEEC;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136048;
	bh=oo71VY1McPM8/140gIhN/hZPHJcdcpEwgl7m7nF3O78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I5MfFq/uPeHRKlR5gGKnsmaYUEMGXX2xMcDn3mYjncwRoHWSIj8M/QRn6e1JIoWHj
	 Vf35f7UzpKuYPosxieXtMOnIKCloOlpyaK1sDHGbytg8O+7UMfAuwpRJVqWp4i/mM3
	 Pcv44Y3qKeTgIu8OlmDvXGWW5LxVuNOf/pKEtbqVGP1qHXxUvsPgswxTuMJvY+39m0
	 prt46zOKPU1oKAGQgYCl5ggzHTEcBidbS1au8fl8QerLnavrHxjI49ZBrEFxZCexZP
	 BoNm+bxdkUbSeGyXYwNJVjWjoiwlDFNtIlLdvfwJZgsZUt59U2U4zqXYhOXjWEzis7
	 S9Jb/LB+52jaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E35EC282E5;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Tue, 04 Mar 2025 19:56:39 -0500
Subject: [PATCH net-next v2 3/8] enic: enic rq extended cq defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-enic_cleanup_and_ext_cq-v2-3-85804263dad8@cisco.com>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
In-Reply-To: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741136202; l=4129;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=lCdejaRbYIFkRngxAAsLt06YyI38y1e/5BxDAW6GFew=;
 b=Cv62IDZdOC5oDkWlep4VvhsFNStYeftYFvF5z/viJJizmhpIlUX0ZHP/1il7ijLEgoV7SU7wd
 22VLtFLJO/SDNXt7ShjOq49DCz0jFDWFVBfKbvR673VwKLXXoMpXe5e
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Adds the defines for 32 and 64 byte receive queue completion queue
descriptors.
Adds devcmd define to get rq cq descriptor size/s supported by hw.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 56 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h  | 19 +++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
index 6abc134d07032a737c8b3d2987e3c7a4b8191991..809a3f30b87f78285414990a2a42c9a30a8662c6 100644
--- a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
@@ -24,6 +24,23 @@ static inline void cq_enet_wq_desc_dec(struct cq_enet_wq_desc *desc,
 		color, q_number, completed_index);
 }
 
+/*
+ * Defines and Capabilities for CMD_CQ_ENTRY_SIZE_SET
+ */
+#define VNIC_RQ_ALL (~0ULL)
+
+#define VNIC_RQ_CQ_ENTRY_SIZE_16 0
+#define VNIC_RQ_CQ_ENTRY_SIZE_32 1
+#define VNIC_RQ_CQ_ENTRY_SIZE_64 2
+
+#define VNIC_RQ_CQ_ENTRY_SIZE_16_CAPABLE BIT(VNIC_RQ_CQ_ENTRY_SIZE_16)
+#define VNIC_RQ_CQ_ENTRY_SIZE_32_CAPABLE BIT(VNIC_RQ_CQ_ENTRY_SIZE_32)
+#define VNIC_RQ_CQ_ENTRY_SIZE_64_CAPABLE BIT(VNIC_RQ_CQ_ENTRY_SIZE_64)
+
+#define VNIC_RQ_CQ_ENTRY_SIZE_ALL_BIT  (VNIC_RQ_CQ_ENTRY_SIZE_16_CAPABLE | \
+					VNIC_RQ_CQ_ENTRY_SIZE_32_CAPABLE | \
+					VNIC_RQ_CQ_ENTRY_SIZE_64_CAPABLE)
+
 /* Completion queue descriptor: Ethernet receive queue, 16B */
 struct cq_enet_rq_desc {
 	__le16 completed_index_flags;
@@ -36,6 +53,45 @@ struct cq_enet_rq_desc {
 	u8 type_color;
 };
 
+/* Completion queue descriptor: Ethernet receive queue, 32B */
+struct cq_enet_rq_desc_32 {
+	__le16 completed_index_flags;
+	__le16 q_number_rss_type_flags;
+	__le32 rss_hash;
+	__le16 bytes_written_flags;
+	__le16 vlan;
+	__le16 checksum_fcoe;
+	u8 flags;
+	u8 fetch_index_flags;
+	__le32 time_stamp;
+	__le16 time_stamp2;
+	__le16 pie_info;
+	__le32 pie_info2;
+	__le16 pie_info3;
+	u8 pie_info4;
+	u8 type_color;
+};
+
+/* Completion queue descriptor: Ethernet receive queue, 64B */
+struct cq_enet_rq_desc_64 {
+	__le16 completed_index_flags;
+	__le16 q_number_rss_type_flags;
+	__le32 rss_hash;
+	__le16 bytes_written_flags;
+	__le16 vlan;
+	__le16 checksum_fcoe;
+	u8 flags;
+	u8 fetch_index_flags;
+	__le32 time_stamp;
+	__le16 time_stamp2;
+	__le16 pie_info;
+	__le32 pie_info2;
+	__le16 pie_info3;
+	u8 pie_info4;
+	u8 reserved[32];
+	u8 type_color;
+};
+
 #define CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT          (0x1 << 12)
 #define CQ_ENET_RQ_DESC_FLAGS_FCOE                  (0x1 << 13)
 #define CQ_ENET_RQ_DESC_FLAGS_EOP                   (0x1 << 14)
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index db56d778877a73b0ef2adf59120cbc57999732ee..605ef17f967e4a7d62738b776bf4dbfdf172ba2a 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -436,6 +436,25 @@ enum vnic_devcmd_cmd {
 	 * in: (u16) a2 = unsigned short int port information
 	 */
 	CMD_OVERLAY_OFFLOAD_CFG = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 73),
+
+	/*
+	 * Set extended CQ field in MREGS of RQ (or all RQs)
+	 * for given vNIC
+	 * in: (u64) a0 = RQ selection (VNIC_RQ_ALL for all RQs)
+	 *     (u32) a1 = CQ entry size
+	 *         VNIC_RQ_CQ_ENTRY_SIZE_16 --> 16 bytes
+	 *         VNIC_RQ_CQ_ENTRY_SIZE_32 --> 32 bytes
+	 *         VNIC_RQ_CQ_ENTRY_SIZE_64 --> 64 bytes
+	 *
+	 * Capability query:
+	 * out: (u32) a0 = errno, 0:valid cmd
+	 *      (u32) a1 = value consisting of supported entries
+	 *         bit 0: 16 bytes
+	 *         bit 1: 32 bytes
+	 *         bit 2: 64 bytes
+	 */
+	CMD_CQ_ENTRY_SIZE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 90),
+
 };
 
 /* CMD_ENABLE2 flags */

-- 
2.48.1



