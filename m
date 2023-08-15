Return-Path: <netdev+bounces-27570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C377C6DA
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DDE28131F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3BA933;
	Tue, 15 Aug 2023 04:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AEAA932
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:57:25 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842F127
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7658752ce2fso310379485a.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692075440; x=1692680240;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sGmqjEbyAW3QWCO3NPA1cNrT39WM3CW/jep0RN+m/o=;
        b=Lg6p37aTInGOEqn6wN/5DbQ8VlGxsbbZjnoG+xuCyPigd8473Rc13QPsKdhn2nLwBl
         cIAImm+uzGTuBwNhlQrKAG1xv17rcxDIvjXJj2ex03MXLZuBpkx1K3ii+vnmfLBECurI
         YBqvgjsRCLiTy7H35w7vQgCs4QJxn4LWS8Iyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075440; x=1692680240;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sGmqjEbyAW3QWCO3NPA1cNrT39WM3CW/jep0RN+m/o=;
        b=hzL//zP6APsva4ha9MlRUuiN+J8v8O6fjXfBM0P6D4a/3R+FOdLZEpueQ+H3uwLMjy
         +rkVNiTYU/alBwHpiSxVfmIIjyvQQeDTd90+WEK7xKPjw84AIeUR+WWfceKCs29pyNdi
         1Bys7pewpD0JepxrYonoHmJwArv1F4t8P96H/noQxRu80SiEViZYe3zm1O7+M0BI9nlS
         0j1CgxMzg4nl+swWQTB3j6fSCB8Zo93ANEwERs8BkIZqCBX5Mg6RfMh2MAcPW1eojLBD
         UHTNymiBLFZ+4ZATCqv1CX9aHRnSRYq/wzzMudPg4ytcG//+g3ceoEC2XzL1KyE8tQn7
         LiSg==
X-Gm-Message-State: AOJu0YxrK5190ainrdxGAT4LHtiw4jphNaM4tT1N4p+mM1tiwGaMh7t4
	jyUZOPzpgbDYG5YdhFtRgWHv6g==
X-Google-Smtp-Source: AGHT+IE+XnvuKLgHm1Gybr1U9wJEj7bDH9e7eynEcs4faAhLCX6OB+wNts8iBeptUqvmmzjGkkgrKw==
X-Received: by 2002:a05:620a:2453:b0:767:47dd:15f with SMTP id h19-20020a05620a245300b0076747dd015fmr15136614qkn.15.1692075439933;
        Mon, 14 Aug 2023 21:57:19 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k28-20020a05620a143c00b00767cbd5e942sm3516575qkj.72.2023.08.14.21.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:57:19 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Michael Chan <michael.chan@broadocm.com>
Subject: [PATCH net-next 07/12] bnxt_en: Update firmware interface to 1.10.2.171
Date: Mon, 14 Aug 2023 21:56:53 -0700
Message-Id: <20230815045658.80494-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230815045658.80494-1-michael.chan@broadcom.com>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000090d7a00602ef03c9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000090d7a00602ef03c9
Content-Transfer-Encoding: 8bit

The main changes are the additional thermal thresholds in
hwrm_temp_monitor_query_output and the new async event to
report thermal errors.

Signed-off-by: Michael Chan <michael.chan@broadocm.com>
the new async event
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 545 ++++++++++++------
 1 file changed, 367 insertions(+), 178 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index f178ed9899a9..893979d69275 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -2,7 +2,7 @@
  *
  * Copyright (c) 2014-2016 Broadcom Corporation
  * Copyright (c) 2014-2018 Broadcom Limited
- * Copyright (c) 2018-2022 Broadcom Inc.
+ * Copyright (c) 2018-2023 Broadcom Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -191,6 +191,11 @@ struct cmd_nums {
 	#define HWRM_QUEUE_VLANPRI2PRI_CFG                0x85UL
 	#define HWRM_QUEUE_GLOBAL_CFG                     0x86UL
 	#define HWRM_QUEUE_GLOBAL_QCFG                    0x87UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_QCFG      0x88UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG       0x89UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG      0x8aUL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG       0x8bUL
+	#define HWRM_QUEUE_QCAPS                          0x8cUL
 	#define HWRM_CFA_L2_FILTER_ALLOC                  0x90UL
 	#define HWRM_CFA_L2_FILTER_FREE                   0x91UL
 	#define HWRM_CFA_L2_FILTER_CFG                    0x92UL
@@ -315,6 +320,7 @@ struct cmd_nums {
 	#define HWRM_CFA_LAG_GROUP_MEMBER_UNRGTR          0x127UL
 	#define HWRM_CFA_TLS_FILTER_ALLOC                 0x128UL
 	#define HWRM_CFA_TLS_FILTER_FREE                  0x129UL
+	#define HWRM_CFA_RELEASE_AFM_FUNC                 0x12aUL
 	#define HWRM_ENGINE_CKV_STATUS                    0x12eUL
 	#define HWRM_ENGINE_CKV_CKEK_ADD                  0x12fUL
 	#define HWRM_ENGINE_CKV_CKEK_DELETE               0x130UL
@@ -383,6 +389,9 @@ struct cmd_nums {
 	#define HWRM_FUNC_DBR_RECOVERY_COMPLETED          0x1aaUL
 	#define HWRM_FUNC_SYNCE_CFG                       0x1abUL
 	#define HWRM_FUNC_SYNCE_QCFG                      0x1acUL
+	#define HWRM_FUNC_KEY_CTX_FREE                    0x1adUL
+	#define HWRM_FUNC_LAG_MODE_CFG                    0x1aeUL
+	#define HWRM_FUNC_LAG_MODE_QCFG                   0x1afUL
 	#define HWRM_SELFTEST_QLIST                       0x200UL
 	#define HWRM_SELFTEST_EXEC                        0x201UL
 	#define HWRM_SELFTEST_IRQ                         0x202UL
@@ -408,10 +417,10 @@ struct cmd_nums {
 	#define HWRM_MFG_SELFTEST_QLIST                   0x216UL
 	#define HWRM_MFG_SELFTEST_EXEC                    0x217UL
 	#define HWRM_STAT_GENERIC_QSTATS                  0x218UL
+	#define HWRM_MFG_PRVSN_EXPORT_CERT                0x219UL
 	#define HWRM_TF                                   0x2bcUL
 	#define HWRM_TF_VERSION_GET                       0x2bdUL
 	#define HWRM_TF_SESSION_OPEN                      0x2c6UL
-	#define HWRM_TF_SESSION_ATTACH                    0x2c7UL
 	#define HWRM_TF_SESSION_REGISTER                  0x2c8UL
 	#define HWRM_TF_SESSION_UNREGISTER                0x2c9UL
 	#define HWRM_TF_SESSION_CLOSE                     0x2caUL
@@ -426,14 +435,6 @@ struct cmd_nums {
 	#define HWRM_TF_TBL_TYPE_GET                      0x2daUL
 	#define HWRM_TF_TBL_TYPE_SET                      0x2dbUL
 	#define HWRM_TF_TBL_TYPE_BULK_GET                 0x2dcUL
-	#define HWRM_TF_CTXT_MEM_ALLOC                    0x2e2UL
-	#define HWRM_TF_CTXT_MEM_FREE                     0x2e3UL
-	#define HWRM_TF_CTXT_MEM_RGTR                     0x2e4UL
-	#define HWRM_TF_CTXT_MEM_UNRGTR                   0x2e5UL
-	#define HWRM_TF_EXT_EM_QCAPS                      0x2e6UL
-	#define HWRM_TF_EXT_EM_OP                         0x2e7UL
-	#define HWRM_TF_EXT_EM_CFG                        0x2e8UL
-	#define HWRM_TF_EXT_EM_QCFG                       0x2e9UL
 	#define HWRM_TF_EM_INSERT                         0x2eaUL
 	#define HWRM_TF_EM_DELETE                         0x2ebUL
 	#define HWRM_TF_EM_HASH_INSERT                    0x2ecUL
@@ -465,6 +466,14 @@ struct cmd_nums {
 	#define HWRM_TFC_IDX_TBL_GET                      0x390UL
 	#define HWRM_TFC_IDX_TBL_FREE                     0x391UL
 	#define HWRM_TFC_GLOBAL_ID_ALLOC                  0x392UL
+	#define HWRM_TFC_TCAM_SET                         0x393UL
+	#define HWRM_TFC_TCAM_GET                         0x394UL
+	#define HWRM_TFC_TCAM_ALLOC                       0x395UL
+	#define HWRM_TFC_TCAM_ALLOC_SET                   0x396UL
+	#define HWRM_TFC_TCAM_FREE                        0x397UL
+	#define HWRM_TFC_IF_TBL_SET                       0x398UL
+	#define HWRM_TFC_IF_TBL_GET                       0x399UL
+	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
 	#define HWRM_SV                                   0x400UL
 	#define HWRM_DBG_READ_DIRECT                      0xff10UL
 	#define HWRM_DBG_READ_INDIRECT                    0xff11UL
@@ -494,6 +503,8 @@ struct cmd_nums {
 	#define HWRM_DBG_USEQ_RUN                         0xff29UL
 	#define HWRM_DBG_USEQ_DELIVERY_REQ                0xff2aUL
 	#define HWRM_DBG_USEQ_RESP_HDR                    0xff2bUL
+	#define HWRM_NVM_GET_VPD_FIELD_INFO               0xffeaUL
+	#define HWRM_NVM_SET_VPD_FIELD_INFO               0xffebUL
 	#define HWRM_NVM_DEFRAG                           0xffecUL
 	#define HWRM_NVM_REQ_ARBITRATION                  0xffedUL
 	#define HWRM_NVM_FACTORY_DEFAULTS                 0xffeeUL
@@ -540,6 +551,7 @@ struct ret_codes {
 	#define HWRM_ERR_CODE_BUSY                         0x10UL
 	#define HWRM_ERR_CODE_RESOURCE_LOCKED              0x11UL
 	#define HWRM_ERR_CODE_PF_UNAVAILABLE               0x12UL
+	#define HWRM_ERR_CODE_ENTITY_NOT_PRESENT           0x13UL
 	#define HWRM_ERR_CODE_TLV_ENCAPSULATED_RESPONSE    0x8000UL
 	#define HWRM_ERR_CODE_UNKNOWN_ERR                  0xfffeUL
 	#define HWRM_ERR_CODE_CMD_NOT_SUPPORTED            0xffffUL
@@ -571,8 +583,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 2
-#define HWRM_VERSION_RSVD 118
-#define HWRM_VERSION_STR "1.10.2.118"
+#define HWRM_VERSION_RSVD 171
+#define HWRM_VERSION_STR "1.10.2.171"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -761,51 +773,53 @@ struct hwrm_async_event_cmpl {
 	#define ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT  0x2eUL
 	#define ASYNC_EVENT_CMPL_TYPE_LAST             ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT
 	__le16	event_id;
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE         0x0UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_MTU_CHANGE            0x1UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE          0x2UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE          0x3UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_CONN_NOT_ALLOWED      0x4UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_NOT_ALLOWED 0x5UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE      0x6UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE        0x7UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_RESET_NOTIFY               0x8UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_RECOVERY             0x9UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_RING_MONITOR_MSG           0xaUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_UNLOAD           0x10UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_LOAD             0x11UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_FLR_PROC_CMPLT        0x12UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_UNLOAD             0x20UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_LOAD               0x21UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_FLR                     0x30UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_MAC_ADDR_CHANGE         0x31UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_VF_COMM_STATUS_CHANGE   0x32UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_CFG_CHANGE              0x33UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LLFC_PFC_CHANGE            0x34UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFAULT_VNIC_CHANGE        0x35UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_FLOW_AGED               0x36UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DEBUG_NOTIFICATION         0x37UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_REQ        0x38UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_DONE       0x39UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_TCP_FLAG_ACTION_CHANGE     0x3aUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_FLOW_ACTIVE            0x3bUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CFG_CHANGE             0x3cUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_DEFAULT_VNIC_CHANGE  0x3dUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_LINK_STATUS_CHANGE   0x3eUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_QUIESCE_DONE               0x3fUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFERRED_RESPONSE          0x40UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PFC_WATCHDOG_CFG_CHANGE    0x41UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_ECHO_REQUEST               0x42UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE                 0x43UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_PPS_TIMESTAMP              0x44UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT               0x45UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_THRESHOLD  0x46UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_RSS_CHANGE                 0x47UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_NQ_UPDATE  0x48UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID          0x49UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG               0xfeUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                 0xffUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                      ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE              0x0UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_MTU_CHANGE                 0x1UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE               0x2UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE               0x3UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_CONN_NOT_ALLOWED           0x4UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_NOT_ALLOWED      0x5UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE           0x6UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE             0x7UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RESET_NOTIFY                    0x8UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_RECOVERY                  0x9UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RING_MONITOR_MSG                0xaUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_UNLOAD                0x10UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_DRVR_LOAD                  0x11UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FUNC_FLR_PROC_CMPLT             0x12UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_UNLOAD                  0x20UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_DRVR_LOAD                    0x21UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_FLR                          0x30UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_MAC_ADDR_CHANGE              0x31UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PF_VF_COMM_STATUS_CHANGE        0x32UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_CFG_CHANGE                   0x33UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LLFC_PFC_CHANGE                 0x34UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFAULT_VNIC_CHANGE             0x35UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_FLOW_AGED                    0x36UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEBUG_NOTIFICATION              0x37UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_REQ             0x38UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CACHE_FLUSH_DONE            0x39UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TCP_FLAG_ACTION_CHANGE          0x3aUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_FLOW_ACTIVE                 0x3bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_EEM_CFG_CHANGE                  0x3cUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_DEFAULT_VNIC_CHANGE       0x3dUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_TFLIB_LINK_STATUS_CHANGE        0x3eUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_QUIESCE_DONE                    0x3fUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DEFERRED_RESPONSE               0x40UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PFC_WATCHDOG_CFG_CHANGE         0x41UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ECHO_REQUEST                    0x42UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE                      0x43UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PPS_TIMESTAMP                   0x44UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT                    0x45UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_THRESHOLD       0x46UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_RSS_CHANGE                      0x47UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DOORBELL_PACING_NQ_UPDATE       0x48UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_DOORBELL_RECOVERY_READ_ERROR 0x49UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_CTX_ERROR                       0x4aUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x4bUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG                    0xfeUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                      0xffUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                           ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
 	__le32	event_data2;
 	u8	opaque_v;
 	#define ASYNC_EVENT_CMPL_V          0x1UL
@@ -1011,6 +1025,7 @@ struct hwrm_async_event_cmpl_vf_cfg_change {
 	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_DFLT_MAC_ADDR_CHANGE      0x4UL
 	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_DFLT_VLAN_CHANGE          0x8UL
 	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_TRUSTED_VF_CFG_CHANGE     0x10UL
+	#define ASYNC_EVENT_CMPL_VF_CFG_CHANGE_EVENT_DATA1_TF_OWNERSHIP_RELEASE      0x20UL
 };
 
 /* hwrm_async_event_cmpl_default_vnic_change (size:128b/16B) */
@@ -1402,6 +1417,45 @@ struct hwrm_async_event_cmpl_error_report_doorbell_drop_threshold {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DOORBELL_DROP_THRESHOLD_EVENT_DATA1_EPOCH_SFT                         8
 };
 
+/* hwrm_async_event_cmpl_error_report_thermal (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_thermal {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK  0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_SFT   0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_MASK 0xff00UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_SFT 8
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_MASK          0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_SFT           0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_THERMAL_EVENT   0x5UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_LAST           ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_ERROR_TYPE_THERMAL_EVENT
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_MASK      0x700UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SFT       8
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN        (0x0UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL    (0x1UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL       (0x2UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN    (0x3UL << 8)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_LAST       ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR           0x800UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_DECREASING  (0x0UL << 11)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING  (0x1UL << 11)
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_LAST       ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING
+};
+
 /* hwrm_func_reset_input (size:192b/24B) */
 struct hwrm_func_reset_input {
 	__le16	req_type;
@@ -1502,7 +1556,7 @@ struct hwrm_func_vf_free_output {
 	u8	valid;
 };
 
-/* hwrm_func_vf_cfg_input (size:448b/56B) */
+/* hwrm_func_vf_cfg_input (size:576b/72B) */
 struct hwrm_func_vf_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -1510,20 +1564,22 @@ struct hwrm_func_vf_cfg_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le32	enables;
-	#define FUNC_VF_CFG_REQ_ENABLES_MTU                  0x1UL
-	#define FUNC_VF_CFG_REQ_ENABLES_GUEST_VLAN           0x2UL
-	#define FUNC_VF_CFG_REQ_ENABLES_ASYNC_EVENT_CR       0x4UL
-	#define FUNC_VF_CFG_REQ_ENABLES_DFLT_MAC_ADDR        0x8UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS      0x10UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS       0x20UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_TX_RINGS         0x40UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS         0x80UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_L2_CTXS          0x100UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS            0x200UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS        0x400UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_HW_RING_GRPS     0x800UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_TX_KEY_CTXS      0x1000UL
-	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RX_KEY_CTXS      0x2000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_MTU                      0x1UL
+	#define FUNC_VF_CFG_REQ_ENABLES_GUEST_VLAN               0x2UL
+	#define FUNC_VF_CFG_REQ_ENABLES_ASYNC_EVENT_CR           0x4UL
+	#define FUNC_VF_CFG_REQ_ENABLES_DFLT_MAC_ADDR            0x8UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS          0x10UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS           0x20UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_TX_RINGS             0x40UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS             0x80UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_L2_CTXS              0x100UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS                0x200UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS            0x400UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_HW_RING_GRPS         0x800UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_KTLS_TX_KEY_CTXS     0x1000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_KTLS_RX_KEY_CTXS     0x2000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_QUIC_TX_KEY_CTXS     0x4000UL
+	#define FUNC_VF_CFG_REQ_ENABLES_NUM_QUIC_RX_KEY_CTXS     0x8000UL
 	__le16	mtu;
 	__le16	guest_vlan;
 	__le16	async_event_cr;
@@ -1547,8 +1603,12 @@ struct hwrm_func_vf_cfg_input {
 	__le16	num_vnics;
 	__le16	num_stat_ctxs;
 	__le16	num_hw_ring_grps;
-	__le16	num_tx_key_ctxs;
-	__le16	num_rx_key_ctxs;
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
+	__le16	num_msix;
+	u8	unused[2];
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
 };
 
 /* hwrm_func_vf_cfg_output (size:128b/16B) */
@@ -1572,7 +1632,7 @@ struct hwrm_func_qcaps_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcaps_output (size:768b/96B) */
+/* hwrm_func_qcaps_output (size:896b/112B) */
 struct hwrm_func_qcaps_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -1686,6 +1746,11 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SYNCE_SUPPORTED                      0x80UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED              0x100UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED             0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_HW_LAG_SUPPORTED                     0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ON_CHIP_CTX_SUPPORTED                0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_STEERING_TAG_SUPPORTED               0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ENHANCED_VF_SCALE_SUPPORTED          0x2000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_KEY_XID_PARTITION_SUPPORTED          0x4000UL
 	__le16	tunnel_disable_flag;
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_VXLAN      0x1UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NGE        0x2UL
@@ -1695,7 +1760,15 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_IPINIP     0x20UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_MPLS       0x40UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_PPPOE      0x80UL
+	u8	key_xid_partition_cap;
+	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_TKC          0x1UL
+	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_RKC          0x2UL
+	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_QUIC_TKC     0x4UL
+	#define FUNC_QCAPS_RESP_KEY_XID_PARTITION_CAP_QUIC_RKC     0x8UL
 	u8	unused_1;
+	u8	device_serial_number[8];
+	__le16	ctxs_per_partition;
+	u8	unused_2[5];
 	u8	valid;
 };
 
@@ -1710,7 +1783,7 @@ struct hwrm_func_qcfg_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcfg_output (size:896b/112B) */
+/* hwrm_func_qcfg_output (size:1024b/128B) */
 struct hwrm_func_qcfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -1870,19 +1943,24 @@ struct hwrm_func_qcfg_output {
 	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
 	#define FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_QCFG_RESP_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100
 	__le16	host_mtu;
-	__le16	alloc_tx_key_ctxs;
-	__le16	alloc_rx_key_ctxs;
+	u8	unused_3[2];
+	u8	unused_4[2];
 	u8	port_kdnet_mode;
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_DISABLED 0x0UL
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED  0x1UL
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_LAST    FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED
 	u8	kdnet_pcie_function;
 	__le16	port_kdnet_fid;
-	u8	unused_3;
+	u8	unused_5[2];
+	__le32	alloc_tx_key_ctxs;
+	__le32	alloc_rx_key_ctxs;
+	u8	lag_id;
+	u8	parif;
+	u8	unused_6[5];
 	u8	valid;
 };
 
-/* hwrm_func_cfg_input (size:960b/120B) */
+/* hwrm_func_cfg_input (size:1088b/136B) */
 struct hwrm_func_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -2061,8 +2139,7 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_LAST         FUNC_CFG_REQ_PARTITION_MAX_BW_BW_VALUE_UNIT_PERCENT1_100
 	__be16	tpid;
 	__le16	host_mtu;
-	__le16	num_tx_key_ctxs;
-	__le16	num_rx_key_ctxs;
+	u8	unused_0[4];
 	__le32	enables2;
 	#define FUNC_CFG_REQ_ENABLES2_KDNET            0x1UL
 	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE     0x2UL
@@ -2083,7 +2160,12 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_2MB   0x9UL
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_4MB   0xaUL
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_LAST FUNC_CFG_REQ_DB_PAGE_SIZE_4MB
-	u8	unused_0[6];
+	u8	unused_1[2];
+	__le32	num_ktls_tx_key_ctxs;
+	__le32	num_ktls_rx_key_ctxs;
+	__le32	num_quic_tx_key_ctxs;
+	__le32	num_quic_rx_key_ctxs;
+	__le32	unused_2;
 };
 
 /* hwrm_func_cfg_output (size:128b/16B) */
@@ -2390,7 +2472,11 @@ struct hwrm_func_drv_qver_input {
 	__le64	resp_addr;
 	__le32	reserved;
 	__le16	fid;
-	u8	unused_0[2];
+	u8	driver_type;
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_L2   0x0UL
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_ROCE 0x1UL
+	#define FUNC_DRV_QVER_REQ_DRIVER_TYPE_LAST FUNC_DRV_QVER_REQ_DRIVER_TYPE_ROCE
+	u8	unused_0;
 };
 
 /* hwrm_func_drv_qver_output (size:256b/32B) */
@@ -2435,7 +2521,7 @@ struct hwrm_func_resource_qcaps_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_resource_qcaps_output (size:512b/64B) */
+/* hwrm_func_resource_qcaps_output (size:704b/88B) */
 struct hwrm_func_resource_qcaps_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -2467,15 +2553,20 @@ struct hwrm_func_resource_qcaps_output {
 	__le16	max_tx_scheduler_inputs;
 	__le16	flags;
 	#define FUNC_RESOURCE_QCAPS_RESP_FLAGS_MIN_GUARANTEED     0x1UL
-	__le16	min_tx_key_ctxs;
-	__le16	max_tx_key_ctxs;
-	__le16	min_rx_key_ctxs;
-	__le16	max_rx_key_ctxs;
-	u8	unused_0[5];
+	__le16	min_msix;
+	__le32	min_ktls_tx_key_ctxs;
+	__le32	max_ktls_tx_key_ctxs;
+	__le32	min_ktls_rx_key_ctxs;
+	__le32	max_ktls_rx_key_ctxs;
+	__le32	min_quic_tx_key_ctxs;
+	__le32	max_quic_tx_key_ctxs;
+	__le32	min_quic_rx_key_ctxs;
+	__le32	max_quic_rx_key_ctxs;
+	u8	unused_0[3];
 	u8	valid;
 };
 
-/* hwrm_func_vf_resource_cfg_input (size:512b/64B) */
+/* hwrm_func_vf_resource_cfg_input (size:704b/88B) */
 struct hwrm_func_vf_resource_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -2502,14 +2593,18 @@ struct hwrm_func_vf_resource_cfg_input {
 	__le16	max_hw_ring_grps;
 	__le16	flags;
 	#define FUNC_VF_RESOURCE_CFG_REQ_FLAGS_MIN_GUARANTEED     0x1UL
-	__le16	min_tx_key_ctxs;
-	__le16	max_tx_key_ctxs;
-	__le16	min_rx_key_ctxs;
-	__le16	max_rx_key_ctxs;
-	u8	unused_0[2];
-};
-
-/* hwrm_func_vf_resource_cfg_output (size:256b/32B) */
+	__le16	min_msix;
+	__le32	min_ktls_tx_key_ctxs;
+	__le32	max_ktls_tx_key_ctxs;
+	__le32	min_ktls_rx_key_ctxs;
+	__le32	max_ktls_rx_key_ctxs;
+	__le32	min_quic_tx_key_ctxs;
+	__le32	max_quic_tx_key_ctxs;
+	__le32	min_quic_rx_key_ctxs;
+	__le32	max_quic_rx_key_ctxs;
+};
+
+/* hwrm_func_vf_resource_cfg_output (size:320b/40B) */
 struct hwrm_func_vf_resource_cfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -2523,9 +2618,9 @@ struct hwrm_func_vf_resource_cfg_output {
 	__le16	reserved_vnics;
 	__le16	reserved_stat_ctx;
 	__le16	reserved_hw_ring_grps;
-	__le16	reserved_tx_key_ctxs;
-	__le16	reserved_rx_key_ctxs;
-	u8	unused_0[3];
+	__le32	reserved_tx_key_ctxs;
+	__le32	reserved_rx_key_ctxs;
+	u8	unused_0[7];
 	u8	valid;
 };
 
@@ -2592,7 +2687,8 @@ struct hwrm_func_backing_store_qcaps_output {
 	__le16	rkc_entry_size;
 	__le32	tkc_max_entries;
 	__le32	rkc_max_entries;
-	u8	rsvd1[7];
+	__le16	fast_qpmd_qp_num_entries;
+	u8	rsvd1[5];
 	u8	valid;
 };
 
@@ -2630,27 +2726,28 @@ struct hwrm_func_backing_store_cfg_input {
 	#define FUNC_BACKING_STORE_CFG_REQ_FLAGS_PREBOOT_MODE               0x1UL
 	#define FUNC_BACKING_STORE_CFG_REQ_FLAGS_MRAV_RESERVATION_SPLIT     0x2UL
 	__le32	enables;
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP             0x1UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ            0x2UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ             0x4UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC           0x8UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT           0x10UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP         0x20UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING0      0x40UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING1      0x80UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING2      0x100UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING3      0x200UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING4      0x400UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING5      0x800UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING6      0x1000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING7      0x2000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV           0x4000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM            0x8000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING8      0x10000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING9      0x20000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING10     0x40000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TKC            0x80000UL
-	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_RKC            0x100000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP               0x1UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ              0x2UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ               0x4UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC             0x8UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT             0x10UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP           0x20UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING0        0x40UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING1        0x80UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING2        0x100UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING3        0x200UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING4        0x400UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING5        0x800UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING6        0x1000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING7        0x2000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV             0x4000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM              0x8000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING8        0x10000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING9        0x20000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_RING10       0x40000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_TKC              0x80000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_RKC              0x100000UL
+	#define FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD     0x200000UL
 	u8	qpc_pg_size_qpc_lvl;
 	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_MASK      0xfUL
 	#define FUNC_BACKING_STORE_CFG_REQ_QPC_LVL_SFT       0
@@ -3047,7 +3144,7 @@ struct hwrm_func_backing_store_cfg_input {
 	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_8M   (0x4UL << 4)
 	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_1G   (0x5UL << 4)
 	#define FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_LAST   FUNC_BACKING_STORE_CFG_REQ_RKC_PG_SIZE_PG_1G
-	u8	rsvd[2];
+	__le16	qp_num_fast_qpmd_entries;
 };
 
 /* hwrm_func_backing_store_cfg_output (size:128b/16B) */
@@ -3477,6 +3574,8 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QUIC_TKC      0x1aUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QUIC_RKC      0x1bUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_XID_PARTITION 0x1dUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID       0xffffUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3546,6 +3645,8 @@ struct hwrm_func_backing_store_qcfg_v2_input {
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_TKC      0x1aUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_RKC      0x1bUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_XID_PARTITION 0x1dUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID       0xffffUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3559,22 +3660,24 @@ struct hwrm_func_backing_store_qcfg_v2_output {
 	__le16	seq_id;
 	__le16	resp_len;
 	__le16	type;
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QP          0x0UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRQ         0x1UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CQ          0x2UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_VNIC        0x3UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_STAT        0x4UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SP_TQM_RING 0x5UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING 0x6UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV        0xeUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM         0xfUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TKC         0x13UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RKC         0x14UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING 0x15UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_TKC    0x1aUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_RKC    0x1bUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID     0xffffUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST       FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QP            0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRQ           0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CQ            0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_VNIC          0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_STAT          0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SP_TQM_RING   0x5UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING   0x6UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV          0xeUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM           0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TKC           0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RKC           0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING   0x15UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_TKC      0x1aUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_RKC      0x1bUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_XID_PARTITION 0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID       0xffffUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST         FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
 	__le16	instance;
 	__le32	flags;
 	__le64	page_dir;
@@ -3609,7 +3712,8 @@ struct hwrm_func_backing_store_qcfg_v2_output {
 struct qpc_split_entries {
 	__le32	qp_num_l2_entries;
 	__le32	qp_num_qp1_entries;
-	__le32	rsvd[2];
+	__le32	qp_num_fast_qpmd_entries;
+	__le32	rsvd;
 };
 
 /* srq_split_entries (size:128b/16B) */
@@ -3666,6 +3770,8 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_TKC      0x1aUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_RKC      0x1bUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION 0x1dUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID       0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
 	u8	rsvd[6];
@@ -3696,13 +3802,16 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ_DB_SHADOW  0x19UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QUIC_TKC      0x1aUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QUIC_RKC      0x1bUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_XID_PARTITION 0x1dUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID       0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST         FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
 	__le16	entry_size;
 	__le32	flags;
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT      0x1UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID                0x2UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_DRIVER_MANAGED_MEMORY     0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT            0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID                      0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_DRIVER_MANAGED_MEMORY           0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ROCE_QP_PSEUDO_STATIC_ALLOC     0x8UL
 	__le32	instance_bit_map;
 	u8	ctx_init_value;
 	u8	ctx_init_offset;
@@ -3712,7 +3821,13 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	__le32	min_num_entries;
 	__le16	next_valid_type;
 	u8	subtype_valid_cnt;
-	u8	rsvd2;
+	u8	exact_cnt_bit_map;
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_0_EXACT     0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_1_EXACT     0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_2_EXACT     0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_SPLIT_ENTRY_3_EXACT     0x8UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_UNUSED_MASK             0xf0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_EXACT_CNT_BIT_MAP_UNUSED_SFT              4
 	__le32	split_entry_0;
 	__le32	split_entry_1;
 	__le32	split_entry_2;
@@ -4545,7 +4660,7 @@ struct tx_port_stats_ext {
 	__le64	pfc_pri7_tx_transitions;
 };
 
-/* rx_port_stats_ext (size:3776b/472B) */
+/* rx_port_stats_ext (size:3904b/488B) */
 struct rx_port_stats_ext {
 	__le64	link_down_events;
 	__le64	continuous_pause_events;
@@ -4606,6 +4721,8 @@ struct rx_port_stats_ext {
 	__le64	rx_discard_packets_cos7;
 	__le64	rx_fec_corrected_blocks;
 	__le64	rx_fec_uncorrectable_blocks;
+	__le64	rx_filter_miss;
+	__le64	rx_fec_symbol_err;
 };
 
 /* hwrm_port_qstats_ext_input (size:320b/40B) */
@@ -6038,6 +6155,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE                  0x10UL
 	#define VNIC_CFG_REQ_FLAGS_RSS_DFLT_CR_MODE                     0x20UL
 	#define VNIC_CFG_REQ_FLAGS_ROCE_MIRRORING_CAPABLE_VNIC_MODE     0x40UL
+	#define VNIC_CFG_REQ_FLAGS_PORTCOS_MAPPING_MODE                 0x80UL
 	__le32	enables;
 	#define VNIC_CFG_REQ_ENABLES_DFLT_RING_GRP            0x1UL
 	#define VNIC_CFG_REQ_ENABLES_RSS_RULE                 0x2UL
@@ -6127,12 +6245,16 @@ struct hwrm_vnic_qcaps_output {
 	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV6_CAP               0x800000UL
 	#define VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP              0x1000000UL
 	#define VNIC_QCAPS_RESP_FLAGS_OUTERMOST_RSS_TRUSTED_VF_CAP            0x2000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_PORTCOS_MAPPING_MODE                    0x4000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_RSS_PROF_TCAM_MODE_ENABLED              0x8000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_VNIC_RSS_HASH_MODE_CAP                  0x10000000UL
+	#define VNIC_QCAPS_RESP_FLAGS_HW_TUNNEL_TPA_CAP                       0x20000000UL
 	__le16	max_aggs_supported;
 	u8	unused_1[5];
 	u8	valid;
 };
 
-/* hwrm_vnic_tpa_cfg_input (size:320b/40B) */
+/* hwrm_vnic_tpa_cfg_input (size:384b/48B) */
 struct hwrm_vnic_tpa_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -6154,6 +6276,7 @@ struct hwrm_vnic_tpa_cfg_input {
 	#define VNIC_TPA_CFG_REQ_ENABLES_MAX_AGGS          0x2UL
 	#define VNIC_TPA_CFG_REQ_ENABLES_MAX_AGG_TIMER     0x4UL
 	#define VNIC_TPA_CFG_REQ_ENABLES_MIN_AGG_LEN       0x8UL
+	#define VNIC_TPA_CFG_REQ_ENABLES_TNL_TPA_EN        0x10UL
 	__le16	vnic_id;
 	__le16	max_agg_segs;
 	#define VNIC_TPA_CFG_REQ_MAX_AGG_SEGS_1   0x0UL
@@ -6173,6 +6296,25 @@ struct hwrm_vnic_tpa_cfg_input {
 	u8	unused_0[2];
 	__le32	max_agg_timer;
 	__le32	min_agg_len;
+	__le32	tnl_tpa_en_bitmap;
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN           0x1UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GENEVE          0x2UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_NVGRE           0x4UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE             0x8UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV4            0x10UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV6            0x20UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_GPE       0x40UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_CUST1     0x80UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE_CUST1       0x100UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR1           0x200UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR2           0x400UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR3           0x800UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR4           0x1000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR5           0x2000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR6           0x4000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR7           0x8000UL
+	#define VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_UPAR8           0x10000UL
+	u8	unused_1[4];
 };
 
 /* hwrm_vnic_tpa_cfg_output (size:128b/16B) */
@@ -6228,7 +6370,25 @@ struct hwrm_vnic_tpa_qcfg_output {
 	#define VNIC_TPA_QCFG_RESP_MAX_AGGS_LAST VNIC_TPA_QCFG_RESP_MAX_AGGS_MAX
 	__le32	max_agg_timer;
 	__le32	min_agg_len;
-	u8	unused_0[7];
+	__le32	tnl_tpa_en_bitmap;
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN           0x1UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GENEVE          0x2UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_NVGRE           0x4UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GRE             0x8UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_IPV4            0x10UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_IPV6            0x20UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN_GPE       0x40UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_VXLAN_CUST1     0x80UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_GRE_CUST1       0x100UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR1           0x200UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR2           0x400UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR3           0x800UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR4           0x1000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR5           0x2000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR6           0x4000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR7           0x8000UL
+	#define VNIC_TPA_QCFG_RESP_TNL_TPA_EN_BITMAP_UPAR8           0x10000UL
+	u8	unused_0[3];
 	u8	valid;
 };
 
@@ -6263,8 +6423,9 @@ struct hwrm_vnic_rss_cfg_input {
 	__le64	hash_key_tbl_addr;
 	__le16	rss_ctx_idx;
 	u8	flags;
-	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_INCLUDE     0x1UL
-	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_EXCLUDE     0x2UL
+	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_INCLUDE               0x1UL
+	#define VNIC_RSS_CFG_REQ_FLAGS_HASH_TYPE_EXCLUDE               0x2UL
+	#define VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT     0x4UL
 	u8	ring_select_mode;
 	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_TOEPLITZ          0x0UL
 	#define VNIC_RSS_CFG_REQ_RING_SELECT_MODE_XOR               0x1UL
@@ -6426,14 +6587,15 @@ struct hwrm_ring_alloc_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le32	enables;
-	#define RING_ALLOC_REQ_ENABLES_RING_ARB_CFG          0x2UL
-	#define RING_ALLOC_REQ_ENABLES_STAT_CTX_ID_VALID     0x8UL
-	#define RING_ALLOC_REQ_ENABLES_MAX_BW_VALID          0x20UL
-	#define RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID      0x40UL
-	#define RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID      0x80UL
-	#define RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID     0x100UL
-	#define RING_ALLOC_REQ_ENABLES_SCHQ_ID               0x200UL
-	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE        0x400UL
+	#define RING_ALLOC_REQ_ENABLES_RING_ARB_CFG           0x2UL
+	#define RING_ALLOC_REQ_ENABLES_STAT_CTX_ID_VALID      0x8UL
+	#define RING_ALLOC_REQ_ENABLES_MAX_BW_VALID           0x20UL
+	#define RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID       0x40UL
+	#define RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID       0x80UL
+	#define RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID      0x100UL
+	#define RING_ALLOC_REQ_ENABLES_SCHQ_ID                0x200UL
+	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE         0x400UL
+	#define RING_ALLOC_REQ_ENABLES_STEERING_TAG_VALID     0x800UL
 	u8	ring_type;
 	#define RING_ALLOC_REQ_RING_TYPE_L2_CMPL   0x0UL
 	#define RING_ALLOC_REQ_RING_TYPE_TX        0x1UL
@@ -6487,7 +6649,7 @@ struct hwrm_ring_alloc_input {
 	#define RING_ALLOC_REQ_RING_ARB_CFG_RSVD_SFT             4
 	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_PARAM_MASK 0xff00UL
 	#define RING_ALLOC_REQ_RING_ARB_CFG_ARB_POLICY_PARAM_SFT 8
-	__le16	unused_3;
+	__le16	steering_tag;
 	__le32	reserved3;
 	__le32	stat_ctx_id;
 	__le32	reserved4;
@@ -6863,6 +7025,7 @@ struct hwrm_cfa_l2_filter_alloc_input {
 	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
 	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
 	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
 	#define CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_L2_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
 	u8	unused_4;
@@ -7045,6 +7208,7 @@ struct hwrm_cfa_tunnel_filter_alloc_input {
 	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
 	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
 	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
 	#define CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_TUNNEL_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
 	u8	tunnel_flags;
@@ -7179,7 +7343,8 @@ struct hwrm_cfa_encap_record_alloc_input {
 	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_IPGRE_V1     0xaUL
 	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_L2_ETYPE     0xbUL
 	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_VXLAN_GPE_V6 0xcUL
-	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_LAST        CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_VXLAN_GPE_V6
+	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_VXLAN_GPE    0x10UL
+	#define CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_LAST        CFA_ENCAP_RECORD_ALLOC_REQ_ENCAP_TYPE_VXLAN_GPE
 	u8	unused_0[3];
 	__le32	encap_data[20];
 };
@@ -7284,6 +7449,7 @@ struct hwrm_cfa_ntuple_filter_alloc_input {
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
 	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
 	u8	pri_hint;
@@ -7431,6 +7597,7 @@ struct hwrm_cfa_decap_filter_alloc_input {
 	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
 	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
 	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
 	#define CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_DECAP_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
 	u8	unused_0;
@@ -7574,6 +7741,7 @@ struct hwrm_cfa_flow_alloc_input {
 	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
 	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
 	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
 	#define CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_FLOW_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
 };
@@ -7999,8 +8167,11 @@ struct hwrm_tunnel_dst_port_query_input {
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ECPRI
-	u8	unused_0[7];
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_SRV6         0xfUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE
+	u8	tunnel_next_proto;
+	u8	unused_0[6];
 };
 
 /* hwrm_tunnel_dst_port_query_output (size:128b/16B) */
@@ -8040,10 +8211,12 @@ struct hwrm_tunnel_dst_port_alloc_input {
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI
-	u8	unused_0;
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6         0xfUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE
+	u8	tunnel_next_proto;
 	__be16	tunnel_dst_port_val;
-	u8	unused_1[4];
+	u8	unused_0[4];
 };
 
 /* hwrm_tunnel_dst_port_alloc_output (size:128b/16B) */
@@ -8087,10 +8260,12 @@ struct hwrm_tunnel_dst_port_free_input {
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI
-	u8	unused_0;
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6         0xfUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE
+	u8	tunnel_next_proto;
 	__le16	tunnel_dst_port_id;
-	u8	unused_1[4];
+	u8	unused_0[4];
 };
 
 /* hwrm_tunnel_dst_port_free_output (size:128b/16B) */
@@ -8158,7 +8333,7 @@ struct ctx_hw_stats_ext {
 	__le64	rx_tpa_events;
 };
 
-/* hwrm_stat_ctx_alloc_input (size:256b/32B) */
+/* hwrm_stat_ctx_alloc_input (size:320b/40B) */
 struct hwrm_stat_ctx_alloc_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -8171,6 +8346,10 @@ struct hwrm_stat_ctx_alloc_input {
 	#define STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE     0x1UL
 	u8	unused_0;
 	__le16	stats_dma_length;
+	__le16	flags;
+	#define STAT_CTX_ALLOC_REQ_FLAGS_STEERING_TAG_VALID     0x1UL
+	__le16	steering_tag;
+	__le32	unused_1;
 };
 
 /* hwrm_stat_ctx_alloc_output (size:128b/16B) */
@@ -8378,7 +8557,7 @@ struct hwrm_stat_generic_qstats_output {
 	u8	valid;
 };
 
-/* generic_sw_hw_stats (size:1216b/152B) */
+/* generic_sw_hw_stats (size:1408b/176B) */
 struct generic_sw_hw_stats {
 	__le64	pcie_statistics_tx_tlp;
 	__le64	pcie_statistics_rx_tlp;
@@ -8399,6 +8578,9 @@ struct generic_sw_hw_stats {
 	__le64	cache_miss_count_cfcs;
 	__le64	cache_miss_count_cfcc;
 	__le64	cache_miss_count_cfcm;
+	__le64	hw_db_recov_dbs_dropped;
+	__le64	hw_db_recov_drops_serviced;
+	__le64	hw_db_recov_dbs_recovered;
 };
 
 /* hwrm_fw_reset_input (size:192b/24B) */
@@ -8822,7 +9004,7 @@ struct hwrm_temp_monitor_query_input {
 	__le64	resp_addr;
 };
 
-/* hwrm_temp_monitor_query_output (size:128b/16B) */
+/* hwrm_temp_monitor_query_output (size:192b/24B) */
 struct hwrm_temp_monitor_query_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -8832,14 +9014,20 @@ struct hwrm_temp_monitor_query_output {
 	u8	phy_temp;
 	u8	om_temp;
 	u8	flags;
-	#define TEMP_MONITOR_QUERY_RESP_FLAGS_TEMP_NOT_AVAILABLE            0x1UL
-	#define TEMP_MONITOR_QUERY_RESP_FLAGS_PHY_TEMP_NOT_AVAILABLE        0x2UL
-	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_NOT_PRESENT                0x4UL
-	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_TEMP_NOT_AVAILABLE         0x8UL
-	#define TEMP_MONITOR_QUERY_RESP_FLAGS_EXT_TEMP_FIELDS_AVAILABLE     0x10UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_TEMP_NOT_AVAILABLE             0x1UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_PHY_TEMP_NOT_AVAILABLE         0x2UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_NOT_PRESENT                 0x4UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_OM_TEMP_NOT_AVAILABLE          0x8UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_EXT_TEMP_FIELDS_AVAILABLE      0x10UL
+	#define TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE     0x20UL
 	u8	temp2;
 	u8	phy_temp2;
 	u8	om_temp2;
+	u8	warn_threshold;
+	u8	critical_threshold;
+	u8	fatal_threshold;
+	u8	shutdown_threshold;
+	u8	unused_0[4];
 	u8	valid;
 };
 
@@ -9263,7 +9451,8 @@ struct hwrm_dbg_ring_info_get_output {
 	__le32	producer_index;
 	__le32	consumer_index;
 	__le32	cag_vector_ctrl;
-	u8	unused_0[3];
+	__le16	st_tag;
+	u8	unused_0;
 	u8	valid;
 };
 
-- 
2.30.1


--00000000000090d7a00602ef03c9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILIrMpkqZZ0ig+CuzUITzJTQyiMFe/wA
5qA58u7cPKLmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NTA0NTcyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBGujVPD1xAjjWZl+1+/EF5ua9y6lQswsMQd+7LikeURDsXy26m
wNCCUzZSXHf7l484an8WHNRv5vKKRk2S/YPAxzayTocbW3Xjqc/Zb714SViAvT5srTL8Ld+nkits
fBdxPkqnOobFuHqlxDS1wmcdkGHRKvlynph48xQx6p7YmVvEd2fciCZ6icfSV9HlpjtOAipT0LdR
tCdDniHCZunvHBkXhJeg7cMHDvP+pkCPCmpIL0jcW0kx5PxHqEdHvWqx48+U4F+VovseIoVoGd9f
yXQRcrsyN4SzorxyBCuLdNHfOomUDIpEliSayaNMOI4IW7AByLJb00zU4u2JVx8f
--00000000000090d7a00602ef03c9--

