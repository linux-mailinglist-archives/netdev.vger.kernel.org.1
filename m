Return-Path: <netdev+bounces-53121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDF80169E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5FA281DBC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79363F8D7;
	Fri,  1 Dec 2023 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JqNjI5ZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272BD63
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:51 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b83fc26e4cso687599b6e.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470391; x=1702075191; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bL4oF598t1yXkppmSRhednNUWdgvxGfIawldDaBZLzM=;
        b=JqNjI5ZOB42FRGQYKGQ1E8pvi1an8x3rvHEK+8pwAM7ma7W9uh5WeW1mJSNrhiFkPB
         pf9GffQXcTLnmcyzkNMViIYYGQnTCfd2LgF67AsBQuX0yD/4qDcPzfqXaaH6P61YFjwq
         3AysMYOxUFUfFFvZDSs2YCNlnxCa8UKvFHIqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470391; x=1702075191;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL4oF598t1yXkppmSRhednNUWdgvxGfIawldDaBZLzM=;
        b=DAofX35SX3FG9d8FIzVnU6TM/jISiI4S8E6OpZodB6OtosXBsmGONdkFmOWdXedzcX
         Ho2hOCfyMbm9yQ7bnGSeIVtQGXCod/RQkjZoOEjCh7hKJmgvsQBz3oVVzS7SiYaPLuL8
         zcqjcQCJH4/idVROgD8JeLk5Du1f9PtOsKNaEJhpEEtcXdkBVlF+nqHVCdpctNx/m/HB
         BKLm1Hj4mJOX0iaRPKRTjYd1MjHLMEzqMbt00cqOAhYzGJ5ZRqpRp0QTUsd/IO+QUwkb
         xlMuRbyZc3KTyqo1tPm71iH80IWQBZxYFZohWhs2IRvihdzcJ5xN4eD5e/yKyhoO3HSI
         71gA==
X-Gm-Message-State: AOJu0YwyRnf773nb2/R27gFHSw+Xbjx9RnC3y/2whjIRwsZa0OZanZkm
	HuPJdJBHYL7fkkQ9kOcZG1cIZg==
X-Google-Smtp-Source: AGHT+IHOi5Pkp8ZXEcYB+sc+EmFZbAK6ei6uPSayvP93QH4VVz0KUo9bKf60ARD283ovw6jr4UBb0A==
X-Received: by 2002:a05:6808:10c2:b0:3b8:b063:8259 with SMTP id s2-20020a05680810c200b003b8b0638259mr260187ois.91.1701470390302;
        Fri, 01 Dec 2023 14:39:50 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:49 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 02/15] bnxt_en: Update firmware interface to 1.10.3.15
Date: Fri,  1 Dec 2023 14:39:11 -0800
Message-Id: <20231201223924.26955-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000450247060b7a72a9"

--000000000000450247060b7a72a9
Content-Transfer-Encoding: 8bit

This updated interface supports the new 5760X P7 chip family.  It has
the changes to support the new link speeds/modes and other changes
for the basic L2 features.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 521 +++++++++++++-----
 2 files changed, 388 insertions(+), 135 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f22800c1bb77..8a22b2d7ea94 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -18,7 +18,7 @@
  */
 #define DRV_VER_MAJ	1
 #define DRV_VER_MIN	10
-#define DRV_VER_UPD	2
+#define DRV_VER_UPD	3
 
 #include <linux/ethtool.h>
 #include <linux/interrupt.h>
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index d5fad5a3cdd1..e957abd704db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -40,6 +40,8 @@ struct hwrm_resp_hdr {
 #define TLV_TYPE_ROCE_SP_COMMAND                 0x3UL
 #define TLV_TYPE_QUERY_ROCE_CC_GEN1              0x4UL
 #define TLV_TYPE_MODIFY_ROCE_CC_GEN1             0x5UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN2              0x6UL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN2             0x7UL
 #define TLV_TYPE_ENGINE_CKV_ALIAS_ECC_PUBLIC_KEY 0x8001UL
 #define TLV_TYPE_ENGINE_CKV_IV                   0x8003UL
 #define TLV_TYPE_ENGINE_CKV_AUTH_TAG             0x8004UL
@@ -196,6 +198,9 @@ struct cmd_nums {
 	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG      0x8aUL
 	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG       0x8bUL
 	#define HWRM_QUEUE_QCAPS                          0x8cUL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_QCFG       0x8dUL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_CFG        0x8eUL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_QCFG       0x8fUL
 	#define HWRM_CFA_L2_FILTER_ALLOC                  0x90UL
 	#define HWRM_CFA_L2_FILTER_FREE                   0x91UL
 	#define HWRM_CFA_L2_FILTER_CFG                    0x92UL
@@ -214,6 +219,7 @@ struct cmd_nums {
 	#define HWRM_TUNNEL_DST_PORT_QUERY                0xa0UL
 	#define HWRM_TUNNEL_DST_PORT_ALLOC                0xa1UL
 	#define HWRM_TUNNEL_DST_PORT_FREE                 0xa2UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_CFG        0xa3UL
 	#define HWRM_STAT_CTX_ENG_QUERY                   0xafUL
 	#define HWRM_STAT_CTX_ALLOC                       0xb0UL
 	#define HWRM_STAT_CTX_FREE                        0xb1UL
@@ -261,6 +267,7 @@ struct cmd_nums {
 	#define HWRM_PORT_EP_TX_CFG                       0xdbUL
 	#define HWRM_PORT_CFG                             0xdcUL
 	#define HWRM_PORT_QCFG                            0xddUL
+	#define HWRM_PORT_MAC_QCAPS                       0xdfUL
 	#define HWRM_TEMP_MONITOR_QUERY                   0xe0UL
 	#define HWRM_REG_POWER_QUERY                      0xe1UL
 	#define HWRM_CORE_FREQUENCY_QUERY                 0xe2UL
@@ -392,6 +399,10 @@ struct cmd_nums {
 	#define HWRM_FUNC_KEY_CTX_FREE                    0x1adUL
 	#define HWRM_FUNC_LAG_MODE_CFG                    0x1aeUL
 	#define HWRM_FUNC_LAG_MODE_QCFG                   0x1afUL
+	#define HWRM_FUNC_LAG_CREATE                      0x1b0UL
+	#define HWRM_FUNC_LAG_UPDATE                      0x1b1UL
+	#define HWRM_FUNC_LAG_FREE                        0x1b2UL
+	#define HWRM_FUNC_LAG_QCFG                        0x1b3UL
 	#define HWRM_SELFTEST_QLIST                       0x200UL
 	#define HWRM_SELFTEST_EXEC                        0x201UL
 	#define HWRM_SELFTEST_IRQ                         0x202UL
@@ -406,9 +417,9 @@ struct cmd_nums {
 	#define HWRM_MFG_FRU_EEPROM_READ                  0x20bUL
 	#define HWRM_MFG_SOC_IMAGE                        0x20cUL
 	#define HWRM_MFG_SOC_QSTATUS                      0x20dUL
-	#define HWRM_MFG_PARAM_SEEPROM_SYNC               0x20eUL
-	#define HWRM_MFG_PARAM_SEEPROM_READ               0x20fUL
-	#define HWRM_MFG_PARAM_SEEPROM_HEALTH             0x210UL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_FINALIZE     0x20eUL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_READ         0x20fUL
+	#define HWRM_MFG_PARAM_CRITICAL_DATA_HEALTH       0x210UL
 	#define HWRM_MFG_PRVSN_EXPORT_CSR                 0x211UL
 	#define HWRM_MFG_PRVSN_IMPORT_CERT                0x212UL
 	#define HWRM_MFG_PRVSN_GET_STATE                  0x213UL
@@ -418,6 +429,16 @@ struct cmd_nums {
 	#define HWRM_MFG_SELFTEST_EXEC                    0x217UL
 	#define HWRM_STAT_GENERIC_QSTATS                  0x218UL
 	#define HWRM_MFG_PRVSN_EXPORT_CERT                0x219UL
+	#define HWRM_STAT_DB_ERROR_QSTATS                 0x21aUL
+	#define HWRM_UDCC_QCAPS                           0x258UL
+	#define HWRM_UDCC_CFG                             0x259UL
+	#define HWRM_UDCC_QCFG                            0x25aUL
+	#define HWRM_UDCC_SESSION_CFG                     0x25bUL
+	#define HWRM_UDCC_SESSION_QCFG                    0x25cUL
+	#define HWRM_UDCC_SESSION_QUERY                   0x25dUL
+	#define HWRM_UDCC_COMP_CFG                        0x25eUL
+	#define HWRM_UDCC_COMP_QCFG                       0x25fUL
+	#define HWRM_UDCC_COMP_QUERY                      0x260UL
 	#define HWRM_TF                                   0x2bcUL
 	#define HWRM_TF_VERSION_GET                       0x2bdUL
 	#define HWRM_TF_SESSION_OPEN                      0x2c6UL
@@ -582,9 +603,9 @@ struct hwrm_err_output {
 #define HWRM_TARGET_ID_TOOLS 0xFFFD
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
-#define HWRM_VERSION_UPDATE 2
-#define HWRM_VERSION_RSVD 171
-#define HWRM_VERSION_STR "1.10.2.171"
+#define HWRM_VERSION_UPDATE 3
+#define HWRM_VERSION_RSVD 15
+#define HWRM_VERSION_STR "1.10.3.15"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -816,7 +837,8 @@ struct hwrm_async_event_cmpl {
 	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_NQ_UPDATE       0x48UL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_DOORBELL_RECOVERY_READ_ERROR 0x49UL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_CTX_ERROR                       0x4aUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x4bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_UDCC_SESSION_CHANGE             0x4bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x4cUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG                    0xfeUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                      0xffUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                           ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
@@ -1632,7 +1654,7 @@ struct hwrm_func_qcaps_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcaps_output (size:896b/112B) */
+/* hwrm_func_qcaps_output (size:1088b/136B) */
 struct hwrm_func_qcaps_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -1736,21 +1758,29 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_MPC_CHNLS_CAP_PRIMATE     0x10UL
 	__le16	max_key_ctxs_alloc;
 	__le32	flags_ext2;
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED     0x1UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_QUIC_SUPPORTED                       0x2UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KDNET_SUPPORTED                      0x4UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED             0x8UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_DBR_DROP_RECOVERY_SUPPORTED       0x10UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_GENERIC_STATS_SUPPORTED              0x20UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDP_GSO_SUPPORTED                    0x40UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SYNCE_SUPPORTED                      0x80UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED              0x100UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED             0x200UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_HW_LAG_SUPPORTED                     0x400UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ON_CHIP_CTX_SUPPORTED                0x800UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_STEERING_TAG_SUPPORTED               0x1000UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ENHANCED_VF_SCALE_SUPPORTED          0x2000UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KEY_XID_PARTITION_SUPPORTED          0x4000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED      0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_QUIC_SUPPORTED                        0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KDNET_SUPPORTED                       0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED              0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_DBR_DROP_RECOVERY_SUPPORTED        0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_GENERIC_STATS_SUPPORTED               0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDP_GSO_SUPPORTED                     0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SYNCE_SUPPORTED                       0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED               0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED              0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_HW_LAG_SUPPORTED                      0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ON_CHIP_CTX_SUPPORTED                 0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_STEERING_TAG_SUPPORTED                0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ENHANCED_VF_SCALE_SUPPORTED           0x2000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KEY_XID_PARTITION_SUPPORTED           0x4000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_CONCURRENT_KTLS_QUIC_SUPPORTED        0x8000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_CROSS_TC_CAP_SUPPORTED           0x10000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_PER_TC_CAP_SUPPORTED             0x20000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SCHQ_PER_TC_RESERVATION_SUPPORTED     0x40000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DB_ERROR_STATS_SUPPORTED              0x80000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED       0x100000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDCC_SUPPORTED                        0x200000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TIMED_TX_SO_TXTIME_SUPPORTED          0x400000UL
 	__le16	tunnel_disable_flag;
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_VXLAN      0x1UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NGE        0x2UL
@@ -1760,15 +1790,21 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_IPINIP     0x20UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_MPLS       0x40UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_PPPOE      0x80UL
-	u8	key_xid_partition_cap;
-	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_TKC          0x1UL
-	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_RKC          0x2UL
-	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_QUIC_TKC     0x4UL
-	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_QUIC_RKC     0x8UL
-	u8	unused_1;
+	__le16	xid_partition_cap;
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_KTLS_TKC     0x1UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_KTLS_RKC     0x2UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_QUIC_TKC     0x4UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_QUIC_RKC     0x8UL
 	u8	device_serial_number[8];
 	__le16	ctxs_per_partition;
-	u8	unused_2[5];
+	u8	unused_2[2];
+	__le32	roce_vf_max_av;
+	__le32	roce_vf_max_cq;
+	__le32	roce_vf_max_mrw;
+	__le32	roce_vf_max_qp;
+	__le32	roce_vf_max_srq;
+	__le32	roce_vf_max_gid;
+	u8	unused_3[3];
 	u8	valid;
 };
 
@@ -1783,7 +1819,7 @@ struct hwrm_func_qcfg_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcfg_output (size:1024b/128B) */
+/* hwrm_func_qcfg_output (size:1280b/160B) */
 struct hwrm_func_qcfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -1892,7 +1928,7 @@ struct hwrm_func_qcfg_output {
 	__le16	alloc_msix;
 	__le16	registered_vfs;
 	__le16	l2_doorbell_bar_size_kb;
-	u8	unused_1;
+	u8	active_endpoints;
 	u8	always_1;
 	__le32	reset_addr_poll;
 	__le16	legacy_l2_db_size_kb;
@@ -1952,15 +1988,26 @@ struct hwrm_func_qcfg_output {
 	u8	kdnet_pcie_function;
 	__le16	port_kdnet_fid;
 	u8	unused_5[2];
-	__le32	alloc_tx_key_ctxs;
-	__le32	alloc_rx_key_ctxs;
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
 	u8	lag_id;
 	u8	parif;
-	u8	unused_6[5];
+	u8	fw_lag_id;
+	u8	unused_6;
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
+	__le32	roce_max_av_per_vf;
+	__le32	roce_max_cq_per_vf;
+	__le32	roce_max_mrw_per_vf;
+	__le32	roce_max_qp_per_vf;
+	__le32	roce_max_srq_per_vf;
+	__le32	roce_max_gid_per_vf;
+	__le16	xid_partition_cfg;
+	u8	unused_7;
 	u8	valid;
 };
 
-/* hwrm_func_cfg_input (size:1088b/136B) */
+/* hwrm_func_cfg_input (size:1280b/160B) */
 struct hwrm_func_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -1996,7 +2043,6 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_FLAGS_PPP_PUSH_MODE_DISABLE          0x10000000UL
 	#define FUNC_CFG_REQ_FLAGS_BD_METADATA_ENABLE             0x20000000UL
 	#define FUNC_CFG_REQ_FLAGS_BD_METADATA_DISABLE            0x40000000UL
-	#define FUNC_CFG_REQ_FLAGS_KEY_CTX_ASSETS_TEST            0x80000000UL
 	__le32	enables;
 	#define FUNC_CFG_REQ_ENABLES_ADMIN_MTU                0x1UL
 	#define FUNC_CFG_REQ_ENABLES_MRU                      0x2UL
@@ -2028,8 +2074,8 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_ENABLES_PARTITION_MAX_BW         0x8000000UL
 	#define FUNC_CFG_REQ_ENABLES_TPID                     0x10000000UL
 	#define FUNC_CFG_REQ_ENABLES_HOST_MTU                 0x20000000UL
-	#define FUNC_CFG_REQ_ENABLES_TX_KEY_CTXS              0x40000000UL
-	#define FUNC_CFG_REQ_ENABLES_RX_KEY_CTXS              0x80000000UL
+	#define FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS         0x40000000UL
+	#define FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS         0x80000000UL
 	__le16	admin_mtu;
 	__le16	mru;
 	__le16	num_rsscos_ctxs;
@@ -2139,10 +2185,21 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100
 	__be16	tpid;
 	__le16	host_mtu;
-	u8	unused_0[4];
+	__le32	flags2;
+	#define FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST     0x1UL
+	#define FUNC_CFG_REQ_FLAGS2_QUIC_KEY_CTX_ASSETS_TEST     0x2UL
 	__le32	enables2;
-	#define FUNC_CFG_REQ_ENABLES2_KDNET            0x1UL
-	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE     0x2UL
+	#define FUNC_CFG_REQ_ENABLES2_KDNET                   0x1UL
+	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE            0x2UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_TX_KEY_CTXS        0x4UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_RX_KEY_CTXS        0x8UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF      0x10UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_CQ_PER_VF      0x20UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_MRW_PER_VF     0x40UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_QP_PER_VF      0x80UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_SRQ_PER_VF     0x100UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF     0x200UL
+	#define FUNC_CFG_REQ_ENABLES2_XID_PARTITION_CFG       0x400UL
 	u8	port_kdnet_mode;
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_DISABLED 0x0UL
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_ENABLED  0x1UL
@@ -2165,7 +2222,18 @@ struct hwrm_func_cfg_input {
 	__le32	num_ktls_rx_key_ctxs;
 	__le32	num_quic_tx_key_ctxs;
 	__le32	num_quic_rx_key_ctxs;
-	__le32	unused_2;
+	__le32	roce_max_av_per_vf;
+	__le32	roce_max_cq_per_vf;
+	__le32	roce_max_mrw_per_vf;
+	__le32	roce_max_qp_per_vf;
+	__le32	roce_max_srq_per_vf;
+	__le32	roce_max_gid_per_vf;
+	__le16	xid_partition_cfg;
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_KTLS_TKC     0x1UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_KTLS_RKC     0x2UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_QUIC_TKC     0x4UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_QUIC_RKC     0x8UL
+	__le16	unused_2;
 };
 
 /* hwrm_func_cfg_output (size:128b/16B) */
@@ -2604,7 +2672,7 @@ struct hwrm_func_vf_resource_cfg_input {
 	__le32	max_quic_rx_key_ctxs;
 };
 
-/* hwrm_func_vf_resource_cfg_output (size:320b/40B) */
+/* hwrm_func_vf_resource_cfg_output (size:384b/48B) */
 struct hwrm_func_vf_resource_cfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -2618,8 +2686,10 @@ struct hwrm_func_vf_resource_cfg_output {
 	__le16	reserved_vnics;
 	__le16	reserved_stat_ctx;
 	__le16	reserved_hw_ring_grps;
-	__le32	reserved_tx_key_ctxs;
-	__le32	reserved_rx_key_ctxs;
+	__le32	reserved_ktls_tx_key_ctxs;
+	__le32	reserved_ktls_rx_key_ctxs;
+	__le32	reserved_quic_tx_key_ctxs;
+	__le32	reserved_quic_rx_key_ctxs;
 	u8	unused_0[7];
 	u8	valid;
 };
@@ -3441,7 +3511,8 @@ struct hwrm_func_ptp_cfg_input {
 	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_4K   0x1UL
 	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_8K   0x2UL
 	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_10M  0x3UL
-	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_LAST FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_10M
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_25M  0x4UL
+	#define FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_LAST FUNC_PTP_CFG_REQ_PTP_FREQ_ADJ_DLL_PHASE_25M
 	u8	unused_0[3];
 	__le32	ptp_freq_adj_ext_period;
 	__le32	ptp_freq_adj_ext_up;
@@ -3627,28 +3698,28 @@ struct hwrm_func_backing_store_qcfg_v2_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le16	type;
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QP            0x0UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ           0x1UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ            0x2UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_VNIC          0x3UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_STAT          0x4UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SP_TQM_RING   0x5UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_FP_TQM_RING   0x6UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MRAV          0xeUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TKC           0x13UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RKC           0x14UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ_DB_SHADOW 0x18UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_TKC      0x1aUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_RKC      0x1bUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_XID_PARTITION 0x1dUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID       0xffffUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QP                  0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ                 0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ                  0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_VNIC                0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_STAT                0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SP_TQM_RING         0x5UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_FP_TQM_RING         0x6UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MRAV                0xeUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TIM                 0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TKC                 0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RKC                 0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MP_TQM_RING         0x15UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SQ_DB_SHADOW        0x16UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RQ_DB_SHADOW        0x17UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ_DB_SHADOW       0x18UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ_DB_SHADOW        0x19UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_TKC            0x1aUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_RKC            0x1bUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TBL_SCOPE           0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_XID_PARTITION_TABLE 0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID             0xffffUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
 	u8	rsvd[4];
 };
@@ -3744,6 +3815,15 @@ struct mrav_split_entries {
 	__le32	rsvd2[2];
 };
 
+/* ts_split_entries (size:128b/16B) */
+struct ts_split_entries {
+	__le32	region_num_entries;
+	u8	tsid;
+	u8	lkup_static_bkt_cnt_exp[2];
+	u8	rsvd;
+	__le32	rsvd2[2];
+};
+
 /* hwrm_func_backing_store_qcaps_v2_input (size:192b/24B) */
 struct hwrm_func_backing_store_qcaps_v2_input {
 	__le16	req_type;
@@ -3761,8 +3841,8 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TKC           0x13UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RKC           0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_KTLS_TKC      0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_KTLS_RKC      0x14UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING   0x15UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
@@ -3793,8 +3873,8 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TKC           0x13UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RKC           0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_KTLS_TKC      0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_KTLS_RKC      0x14UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MP_TQM_RING   0x15UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ_DB_SHADOW  0x16UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RQ_DB_SHADOW  0x17UL
@@ -3838,56 +3918,55 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 
 /* hwrm_func_dbr_pacing_qcfg_input (size:128b/16B) */
 struct hwrm_func_dbr_pacing_qcfg_input {
-	__le16  req_type;
-	__le16  cmpl_ring;
-	__le16  seq_id;
-	__le16  target_id;
-	__le64  resp_addr;
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
 };
 
 /* hwrm_func_dbr_pacing_qcfg_output (size:512b/64B) */
 struct hwrm_func_dbr_pacing_qcfg_output {
-	__le16  error_code;
-	__le16  req_type;
-	__le16  seq_id;
-	__le16  resp_len;
-	u8      flags;
-#define FUNC_DBR_PACING_QCFG_RESP_FLAGS_DBR_NQ_EVENT_ENABLED     0x1UL
-	u8      unused_0[7];
-	__le32  dbr_stat_db_fifo_reg;
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK    0x3UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_SFT     0
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_PCIE_CFG  0x0UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC       0x1UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR0      0x2UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1      0x3UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_LAST     \
-		FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_MASK          0xfffffffcUL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SFT           2
-	__le32  dbr_stat_db_fifo_reg_watermark_mask;
-	u8      dbr_stat_db_fifo_reg_watermark_shift;
-	u8      unused_1[3];
-	__le32  dbr_stat_db_fifo_reg_fifo_room_mask;
-	u8      dbr_stat_db_fifo_reg_fifo_room_shift;
-	u8      unused_2[3];
-	__le32  dbr_throttling_aeq_arm_reg;
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_MASK    0x3UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_SFT     0
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_PCIE_CFG  0x0UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_GRC       0x1UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR0      0x2UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1      0x3UL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_LAST	\
-		FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_MASK          0xfffffffcUL
-#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SFT           2
-	u8      dbr_throttling_aeq_arm_reg_val;
-	u8      unused_3[7];
-	__le32  primary_nq_id;
-	__le32  pacing_threshold;
-	u8      unused_4[7];
-	u8      valid;
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define FUNC_DBR_PACING_QCFG_RESP_FLAGS_DBR_NQ_EVENT_ENABLED     0x1UL
+	u8	unused_0[7];
+	__le32	dbr_stat_db_fifo_reg;
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK    0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_SFT     0
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC       0x1UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR0      0x2UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1      0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_LAST     FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_MASK          0xfffffffcUL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SFT           2
+	__le32	dbr_stat_db_fifo_reg_watermark_mask;
+	u8	dbr_stat_db_fifo_reg_watermark_shift;
+	u8	unused_1[3];
+	__le32	dbr_stat_db_fifo_reg_fifo_room_mask;
+	u8	dbr_stat_db_fifo_reg_fifo_room_shift;
+	u8	unused_2[3];
+	__le32	dbr_throttling_aeq_arm_reg;
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_MASK    0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_SFT     0
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_GRC       0x1UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR0      0x2UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1      0x3UL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_LAST     FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_MASK          0xfffffffcUL
+	#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SFT           2
+	u8	dbr_throttling_aeq_arm_reg_val;
+	u8	unused_3[3];
+	__le32	dbr_stat_db_max_fifo_depth;
+	__le32	primary_nq_id;
+	__le32	pacing_threshold;
+	u8	unused_4[7];
+	u8	valid;
 };
 
 /* hwrm_func_drv_if_change_input (size:192b/24B) */
@@ -3915,7 +3994,7 @@ struct hwrm_func_drv_if_change_output {
 	u8	valid;
 };
 
-/* hwrm_port_phy_cfg_input (size:448b/56B) */
+/* hwrm_port_phy_cfg_input (size:512b/64B) */
 struct hwrm_port_phy_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -3960,6 +4039,8 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_ENABLES_TX_LPI_TIMER                  0x400UL
 	#define PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED         0x800UL
 	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_PAM4_LINK_SPEED_MASK     0x1000UL
+	#define PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2            0x2000UL
+	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK        0x4000UL
 	__le16	port_id;
 	__le16	force_link_speed;
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100MB 0x1UL
@@ -3990,7 +4071,9 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_TX                0x1UL
 	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_RX                0x2UL
 	#define PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE     0x4UL
-	u8	unused_0;
+	u8	mgmt_flag;
+	#define PORT_PHY_CFG_REQ_MGMT_FLAG_LINK_RELEASE     0x1UL
+	#define PORT_PHY_CFG_REQ_MGMT_FLAG_MGMT_VALID       0x80UL
 	__le16	auto_link_speed;
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_100MB 0x1UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEED_1GB   0xaUL
@@ -4054,7 +4137,36 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_50G      0x1UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_100G     0x2UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_PAM4_SPEED_MASK_200G     0x4UL
-	u8	unused_2[2];
+	__le16	force_link_speeds2;
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_1GB            0xaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_10GB           0x64UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_25GB           0xfaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_40GB           0x190UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB           0x1f4UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB          0x3e8UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB_PAM4_56   0x1f5UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_56  0x3e9UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_56  0x7d1UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_56  0xfa1UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112 0x3eaUL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112
+	__le16	auto_link_speeds2_mask;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_1GB                0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_10GB               0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_25GB               0x4UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_40GB               0x8UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_50GB               0x10UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB              0x20UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_112     0x1000UL
+	u8	unused_2[6];
 };
 
 /* hwrm_port_phy_cfg_output (size:128b/16B) */
@@ -4104,7 +4216,8 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_SFT                 0
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ                   0x0UL
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4                  0x1UL
-	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST                 PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112              0x2UL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST                 PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK                 0xf0UL
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_SFT                  4
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE        (0x0UL << 4)
@@ -4127,6 +4240,7 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_50GB  0x1f4UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_100GB 0x3e8UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_200GB 0x7d0UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_400GB 0xfa0UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_10MB  0xffffUL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_LINK_SPEED_10MB
 	u8	duplex_cfg;
@@ -4270,7 +4384,23 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2     0x25UL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2     0x26UL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2     0x27UL
-	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR      0x28UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR      0x29UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR      0x2aUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER      0x2bUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR2     0x2cUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR2     0x2dUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR2     0x2eUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER2     0x2fUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR8     0x30UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR8     0x31UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR8     0x32UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER8     0x33UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR4     0x34UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4     0x35UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4     0x36UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4     0x37UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4
 	u8	media_type;
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN 0x0UL
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP      0x1UL
@@ -4366,6 +4496,7 @@ struct hwrm_port_phy_qcfg_output {
 	u8	option_flags;
 	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_MEDIA_AUTO_DETECT     0x1UL
 	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN     0x2UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SPEEDS2_SUPPORTED     0x4UL
 	char	phy_vendor_name[16];
 	char	phy_vendor_partnumber[16];
 	__le16	support_pam4_speeds;
@@ -4387,7 +4518,53 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_200GB     0x4UL
 	u8	link_down_reason;
 	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF     0x1UL
-	u8	unused_0[7];
+	__le16	support_speeds2;
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_1GB                0x1UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_10GB               0x2UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_25GB               0x4UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_40GB               0x8UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB               0x10UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB              0x20UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_800GB_PAM4_112     0x2000UL
+	__le16	force_link_speeds2;
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_1GB            0xaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_10GB           0x64UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_25GB           0xfaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_40GB           0x190UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_50GB           0x1f4UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB          0x3e8UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_50GB_PAM4_56   0x1f5UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB_PAM4_56  0x3e9UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_56  0x7d1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_56  0xfa1UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_100GB_PAM4_112 0x3eaUL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+	__le16	auto_link_speeds2;
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_1GB                0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_10GB               0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_25GB               0x4UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_40GB               0x8UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_50GB               0x10UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB              0x20UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_800GB_PAM4_112     0x2000UL
+	u8	active_lanes;
 	u8	valid;
 };
 
@@ -4426,6 +4603,7 @@ struct hwrm_port_mac_cfg_input {
 	#define PORT_MAC_CFG_REQ_ENABLES_COS_FIELD_CFG                  0x100UL
 	#define PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB               0x200UL
 	#define PORT_MAC_CFG_REQ_ENABLES_PTP_ADJ_PHASE                  0x400UL
+	#define PORT_MAC_CFG_REQ_ENABLES_PTP_LOAD_CONTROL               0x800UL
 	__le16	port_id;
 	u8	ipg;
 	u8	lpbk;
@@ -4459,7 +4637,12 @@ struct hwrm_port_mac_cfg_input {
 	#define PORT_MAC_CFG_REQ_COS_FIELD_CFG_DEFAULT_COS_SFT           5
 	u8	unused_0[3];
 	__le32	ptp_freq_adj_ppb;
-	u8	unused_1[4];
+	u8	unused_1[3];
+	u8	ptp_load_control;
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_NONE      0x0UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_IMMEDIATE 0x1UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_PPS_EVENT 0x2UL
+	#define PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_LAST     PORT_MAC_CFG_REQ_PTP_LOAD_CONTROL_PPS_EVENT
 	__le64	ptp_adj_phase;
 };
 
@@ -4504,6 +4687,7 @@ struct hwrm_port_mac_ptp_qcfg_output {
 	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_HWRM_ACCESS                         0x8UL
 	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_PARTIAL_DIRECT_ACCESS_REF_CLOCK     0x10UL
 	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_RTC_CONFIGURED                      0x20UL
+	#define PORT_MAC_PTP_QCFG_RESP_FLAGS_64B_PHC_TIME                        0x40UL
 	u8	unused_0[3];
 	__le32	rx_ts_reg_off_lower;
 	__le32	rx_ts_reg_off_upper;
@@ -4968,7 +5152,7 @@ struct hwrm_port_phy_qcaps_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_port_phy_qcaps_output (size:256b/32B) */
+/* hwrm_port_phy_qcaps_output (size:320b/40B) */
 struct hwrm_port_phy_qcaps_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -5051,7 +5235,40 @@ struct hwrm_port_phy_qcaps_output {
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED       0x1UL
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED         0x2UL
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED     0x4UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED       0x8UL
 	u8	internal_port_cnt;
+	u8	unused_0;
+	__le16	supported_speeds2_force_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_1GB                0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_10GB               0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_25GB               0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_40GB               0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_50GB               0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB              0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_FORCE_MODE_800GB_PAM4_112     0x2000UL
+	__le16	supported_speeds2_auto_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_1GB                0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_10GB               0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_25GB               0x4UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_40GB               0x8UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_50GB               0x10UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB              0x20UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_50GB_PAM4_56       0x40UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB_PAM4_56      0x80UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_200GB_PAM4_56      0x100UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_400GB_PAM4_56      0x200UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_100GB_PAM4_112     0x400UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_200GB_PAM4_112     0x800UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_800GB_PAM4_112     0x2000UL
+	u8	unused_1[3];
 	u8	valid;
 };
 
@@ -5472,6 +5689,30 @@ struct hwrm_port_led_qcaps_output {
 	u8	valid;
 };
 
+/* hwrm_port_mac_qcaps_input (size:192b/24B) */
+struct hwrm_port_mac_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
+};
+
+/* hwrm_port_mac_qcaps_output (size:128b/16B) */
+struct hwrm_port_mac_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	flags;
+	#define PORT_MAC_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED     0x1UL
+	#define PORT_MAC_QCAPS_RESP_FLAGS_REMOTE_LPBK_SUPPORTED        0x2UL
+	u8	unused_0[6];
+	u8	valid;
+};
+
 /* hwrm_queue_qportcfg_input (size:192b/24B) */
 struct hwrm_queue_qportcfg_input {
 	__le16	req_type;
@@ -7488,7 +7729,7 @@ struct hwrm_cfa_ntuple_filter_alloc_input {
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_RSVD    0xffUL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_LAST   CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_RSVD
 	__le16	dst_id;
-	__le16	mirror_vnic_id;
+	__le16	rfs_ring_tbl_idx;
 	u8	tunnel_type;
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NONTUNNEL    0x0UL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN        0x1UL
@@ -8201,6 +8442,7 @@ struct hwrm_cfa_adv_flow_mgnt_qcaps_output {
 	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_NO_L2CTX_SUPPORTED               0x40000UL
 	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NIC_FLOW_STATS_SUPPORTED                     0x80000UL
 	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_EXT_IP_PROTO_SUPPORTED        0x100000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V3_SUPPORTED                0x200000UL
 	u8	unused_0[3];
 	u8	valid;
 };
@@ -8223,7 +8465,8 @@ struct hwrm_tunnel_dst_port_query_input {
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ECPRI        0xeUL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE
 	u8	tunnel_next_proto;
 	u8	unused_0[6];
 };
@@ -8245,7 +8488,10 @@ struct hwrm_tunnel_dst_port_query_output {
 	#define TUNNEL_DST_PORT_QUERY_RESP_UPAR_IN_USE_UPAR5     0x20UL
 	#define TUNNEL_DST_PORT_QUERY_RESP_UPAR_IN_USE_UPAR6     0x40UL
 	#define TUNNEL_DST_PORT_QUERY_RESP_UPAR_IN_USE_UPAR7     0x80UL
-	u8	unused_0[2];
+	u8	status;
+	#define TUNNEL_DST_PORT_QUERY_RESP_STATUS_CHIP_LEVEL     0x1UL
+	#define TUNNEL_DST_PORT_QUERY_RESP_STATUS_FUNC_LEVEL     0x2UL
+	u8	unused_0;
 	u8	valid;
 };
 
@@ -8267,7 +8513,8 @@ struct hwrm_tunnel_dst_port_alloc_input {
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI        0xeUL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE
 	u8	tunnel_next_proto;
 	__be16	tunnel_dst_port_val;
 	u8	unused_0[4];
@@ -8284,7 +8531,8 @@ struct hwrm_tunnel_dst_port_alloc_output {
 	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_SUCCESS         0x0UL
 	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ALLOCATED   0x1UL
 	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_NO_RESOURCE 0x2UL
-	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_LAST           TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_NO_RESOURCE
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ENABLED     0x3UL
+	#define TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_LAST           TUNNEL_DST_PORT_ALLOC_RESP_ERROR_INFO_ERR_ENABLED
 	u8	upar_in_use;
 	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR0     0x1UL
 	#define TUNNEL_DST_PORT_ALLOC_RESP_UPAR_IN_USE_UPAR1     0x2UL
@@ -8316,7 +8564,8 @@ struct hwrm_tunnel_dst_port_free_input {
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI        0xeUL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE
 	u8	tunnel_next_proto;
 	__le16	tunnel_dst_port_id;
 	u8	unused_0[4];
@@ -9717,7 +9966,7 @@ struct hwrm_nvm_get_dev_info_input {
 	__le64	resp_addr;
 };
 
-/* hwrm_nvm_get_dev_info_output (size:640b/80B) */
+/* hwrm_nvm_get_dev_info_output (size:704b/88B) */
 struct hwrm_nvm_get_dev_info_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -9747,6 +9996,10 @@ struct hwrm_nvm_get_dev_info_output {
 	__le16	roce_fw_minor;
 	__le16	roce_fw_build;
 	__le16	roce_fw_patch;
+	__le16	netctrl_fw_major;
+	__le16	netctrl_fw_minor;
+	__le16	netctrl_fw_build;
+	__le16	netctrl_fw_patch;
 	u8	unused_0[7];
 	u8	valid;
 };
-- 
2.30.1


--000000000000450247060b7a72a9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOnLXKbRgD4rVN8iCw/zOHo+i3e7+TAb
5W5AwHYDq7KwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAsCbrWnO81deXNfjbRxuZ0FYDdRbzrHWfKzS0CJUC3tPmM3AYE
z4k9Iqbb+8mG0JcyL2GKp927xSL+DsFeJFLnOgPVIoF1neInJMXYIrG50tlK/dr10ZpMh/L4MPIA
xuX0J/T9O1yqhSyZJKHJa7nbs7bgIlwcAfk0S4ITmTM+/U4Gwole0B9m3TMSRlTDZB1clb0e8Ssw
QuTnOXtLwCuxOUKYpZ9aq58zC2nXg3C0tVyaN2ZxTDQMSKcrhUnptNittHtvpZmKMhwjVe8FwjJE
JdqWn9hJFu5jeEiOO9TYFMb3Fo0518F24mF077UYHc4AY5jMGbNBg5vwUtXzyUAH
--000000000000450247060b7a72a9--

