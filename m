Return-Path: <netdev+bounces-172691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1FA55B8E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FA13B3824
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55174430;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwPlLa+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51D23CE;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306371; cv=none; b=l9WFtmcBwZ1UkS3bOQD8ifQ39fUXoc82WsqQ5jcrEYVTMUQDvGc9Bgfp9CTYh9JFhU4i4a2/mFess07VewVit4Kd1lkxyvMVkoidloMDShcZ1AEQnCVMVBe21cNVYAO6DeHUJv4SZfcaW20cBbychfhAnSOnYp1TowpriFrGbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306371; c=relaxed/simple;
	bh=6xDLulu1Sw0fKbSpusNVkwccNOkA1alkCpoDdZkwvOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVriBzMpU32bqOqgrwByWgXsSbVlivlaMTfi5z1D3a5flV0MKdOt5HZtZXp4V72lAx3vOv1PodklOa3YDjL2FB3fpjV4HVykILs8WJop0X6+qECzbo8eaVAH3WHvrLlV6PTxJ/qFpcDcQj6nDBBxH4u7aygoU3mjy6+RZGUsz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwPlLa+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4690AC4CEE8;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306371;
	bh=6xDLulu1Sw0fKbSpusNVkwccNOkA1alkCpoDdZkwvOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KwPlLa+5RYyLfS+rHKbHjq99bhgfO7Dah0IL7+1zjtQcCuywfAObcdX3XjVaAy3/j
	 wVJP50f92bnaJkv8BBRpwblYFA9mynEPT26IorJiDwWgj5TrFPXccfANSVT4oin1xX
	 CGjLwJwqQ7X0jOZ7iJCQ9Tmgu7hYnWnP7ui/YXulSuglNkro7OkOxX5WPsGBMuLJxO
	 FNEAUxvRin1KJA8bMhM0k2jgLAJd3ELTAJUzIgeKhdQtO05KRyL9qV2gUaq/u2pd5t
	 yGu/jS0QDEHcuhY4Hql7vhPI5hRF0pOsiLEcrU9QJ2bcPtfE0vVpl8ISJtWSeCqufG
	 Yr+DIW0RIWQlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B09C28B23;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 06 Mar 2025 19:15:22 -0500
Subject: [PATCH net-next v3 1/8] enic: Move function from header file to c
 file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-enic_cleanup_and_ext_cq-v3-1-92bc165344cf@cisco.com>
References: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
In-Reply-To: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741306525; l=7789;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=7kzRarx8eC77ZjdPIWBRrZ2WXck83vihC3q9QHlbccE=;
 b=tLLtE8gsCiC5M79CMwNDJ6MZ2C7/06d7PrPjCmpvAtuKOCtAOcpNxZkWXZmXPkpQms9Y5Zz7P
 v2Z7ofh3g3UALRLQrFaFV3bHptmyEWkiKmcTuXdqaBJkKtUmSYnsC51
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Moves cq_enet_rq_desc_dec from cq_enet_desc.h to enic_rq.c.
This is in preparation for enic extended completion queue
enabling.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 81 -------------------------
 drivers/net/ethernet/cisco/enic/enic_rq.c      | 84 ++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
index d25426470a293989ff472863cc85718e3b1d81d2..6abc134d07032a737c8b3d2987e3c7a4b8191991 100644
--- a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
@@ -88,85 +88,4 @@ struct cq_enet_rq_desc {
 #define CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT         (0x1 << 6)
 #define CQ_ENET_RQ_DESC_FLAGS_FCS_OK                (0x1 << 7)
 
-static inline void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc,
-	u8 *type, u8 *color, u16 *q_number, u16 *completed_index,
-	u8 *ingress_port, u8 *fcoe, u8 *eop, u8 *sop, u8 *rss_type,
-	u8 *csum_not_calc, u32 *rss_hash, u16 *bytes_written, u8 *packet_error,
-	u8 *vlan_stripped, u16 *vlan_tci, u16 *checksum, u8 *fcoe_sof,
-	u8 *fcoe_fc_crc_ok, u8 *fcoe_enc_error, u8 *fcoe_eof,
-	u8 *tcp_udp_csum_ok, u8 *udp, u8 *tcp, u8 *ipv4_csum_ok,
-	u8 *ipv6, u8 *ipv4, u8 *ipv4_fragment, u8 *fcs_ok)
-{
-	u16 completed_index_flags;
-	u16 q_number_rss_type_flags;
-	u16 bytes_written_flags;
-
-	cq_desc_dec((struct cq_desc *)desc, type,
-		color, q_number, completed_index);
-
-	completed_index_flags = le16_to_cpu(desc->completed_index_flags);
-	q_number_rss_type_flags =
-		le16_to_cpu(desc->q_number_rss_type_flags);
-	bytes_written_flags = le16_to_cpu(desc->bytes_written_flags);
-
-	*ingress_port = (completed_index_flags &
-		CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT) ? 1 : 0;
-	*fcoe = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_FCOE) ?
-		1 : 0;
-	*eop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_EOP) ?
-		1 : 0;
-	*sop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_SOP) ?
-		1 : 0;
-
-	*rss_type = (u8)((q_number_rss_type_flags >> CQ_DESC_Q_NUM_BITS) &
-		CQ_ENET_RQ_DESC_RSS_TYPE_MASK);
-	*csum_not_calc = (q_number_rss_type_flags &
-		CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC) ? 1 : 0;
-
-	*rss_hash = le32_to_cpu(desc->rss_hash);
-
-	*bytes_written = bytes_written_flags &
-		CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
-	*packet_error = (bytes_written_flags &
-		CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) ? 1 : 0;
-	*vlan_stripped = (bytes_written_flags &
-		CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED) ? 1 : 0;
-
-	/*
-	 * Tag Control Information(16) = user_priority(3) + cfi(1) + vlan(12)
-	 */
-	*vlan_tci = le16_to_cpu(desc->vlan);
-
-	if (*fcoe) {
-		*fcoe_sof = (u8)(le16_to_cpu(desc->checksum_fcoe) &
-			CQ_ENET_RQ_DESC_FCOE_SOF_MASK);
-		*fcoe_fc_crc_ok = (desc->flags &
-			CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK) ? 1 : 0;
-		*fcoe_enc_error = (desc->flags &
-			CQ_ENET_RQ_DESC_FCOE_ENC_ERROR) ? 1 : 0;
-		*fcoe_eof = (u8)((le16_to_cpu(desc->checksum_fcoe) >>
-			CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT) &
-			CQ_ENET_RQ_DESC_FCOE_EOF_MASK);
-		*checksum = 0;
-	} else {
-		*fcoe_sof = 0;
-		*fcoe_fc_crc_ok = 0;
-		*fcoe_enc_error = 0;
-		*fcoe_eof = 0;
-		*checksum = le16_to_cpu(desc->checksum_fcoe);
-	}
-
-	*tcp_udp_csum_ok =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK) ? 1 : 0;
-	*udp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_UDP) ? 1 : 0;
-	*tcp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP) ? 1 : 0;
-	*ipv4_csum_ok =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK) ? 1 : 0;
-	*ipv6 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV6) ? 1 : 0;
-	*ipv4 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4) ? 1 : 0;
-	*ipv4_fragment =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT) ? 1 : 0;
-	*fcs_ok = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK) ? 1 : 0;
-}
-
 #endif /* _CQ_ENET_DESC_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index e3228ef7988a1ef78e9051d9b1aa67df5191e2ac..7360799326e8bd8ac8f102c3e3b3b4814f66b97f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -101,6 +101,90 @@ static void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash,
 	}
 }
 
+static void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
+				u8 *color, u16 *q_number, u16 *completed_index,
+				u8 *ingress_port, u8 *fcoe, u8 *eop, u8 *sop,
+				u8 *rss_type, u8 *csum_not_calc, u32 *rss_hash,
+				u16 *bytes_written, u8 *packet_error,
+				u8 *vlan_stripped, u16 *vlan_tci,
+				u16 *checksum, u8 *fcoe_sof,
+				u8 *fcoe_fc_crc_ok, u8 *fcoe_enc_error,
+				u8 *fcoe_eof, u8 *tcp_udp_csum_ok, u8 *udp,
+				u8 *tcp, u8 *ipv4_csum_ok, u8 *ipv6, u8 *ipv4,
+				u8 *ipv4_fragment, u8 *fcs_ok)
+{
+	u16 completed_index_flags;
+	u16 q_number_rss_type_flags;
+	u16 bytes_written_flags;
+
+	cq_desc_dec((struct cq_desc *)desc, type,
+		    color, q_number, completed_index);
+
+	completed_index_flags = le16_to_cpu(desc->completed_index_flags);
+	q_number_rss_type_flags =
+		le16_to_cpu(desc->q_number_rss_type_flags);
+	bytes_written_flags = le16_to_cpu(desc->bytes_written_flags);
+
+	*ingress_port = (completed_index_flags &
+		CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT) ? 1 : 0;
+	*fcoe = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_FCOE) ?
+		1 : 0;
+	*eop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_EOP) ?
+		1 : 0;
+	*sop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_SOP) ?
+		1 : 0;
+
+	*rss_type = (u8)((q_number_rss_type_flags >> CQ_DESC_Q_NUM_BITS) &
+		CQ_ENET_RQ_DESC_RSS_TYPE_MASK);
+	*csum_not_calc = (q_number_rss_type_flags &
+		CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC) ? 1 : 0;
+
+	*rss_hash = le32_to_cpu(desc->rss_hash);
+
+	*bytes_written = bytes_written_flags &
+		CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
+	*packet_error = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) ? 1 : 0;
+	*vlan_stripped = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED) ? 1 : 0;
+
+	/*
+	 * Tag Control Information(16) = user_priority(3) + cfi(1) + vlan(12)
+	 */
+	*vlan_tci = le16_to_cpu(desc->vlan);
+
+	if (*fcoe) {
+		*fcoe_sof = (u8)(le16_to_cpu(desc->checksum_fcoe) &
+			CQ_ENET_RQ_DESC_FCOE_SOF_MASK);
+		*fcoe_fc_crc_ok = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK) ? 1 : 0;
+		*fcoe_enc_error = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_ENC_ERROR) ? 1 : 0;
+		*fcoe_eof = (u8)((le16_to_cpu(desc->checksum_fcoe) >>
+			CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT) &
+			CQ_ENET_RQ_DESC_FCOE_EOF_MASK);
+		*checksum = 0;
+	} else {
+		*fcoe_sof = 0;
+		*fcoe_fc_crc_ok = 0;
+		*fcoe_enc_error = 0;
+		*fcoe_eof = 0;
+		*checksum = le16_to_cpu(desc->checksum_fcoe);
+	}
+
+	*tcp_udp_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK) ? 1 : 0;
+	*udp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_UDP) ? 1 : 0;
+	*tcp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP) ? 1 : 0;
+	*ipv4_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK) ? 1 : 0;
+	*ipv6 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV6) ? 1 : 0;
+	*ipv4 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4) ? 1 : 0;
+	*ipv4_fragment =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT) ? 1 : 0;
+	*fcs_ok = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK) ? 1 : 0;
+}
+
 static bool enic_rq_pkt_error(struct vnic_rq *vrq, u8 packet_error, u8 fcs_ok,
 			      u16 bytes_written)
 {

-- 
2.48.1



