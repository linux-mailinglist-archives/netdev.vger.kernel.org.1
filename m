Return-Path: <netdev+bounces-20328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3DB75F15F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5651C20410
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C92E54A;
	Mon, 24 Jul 2023 09:51:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF7EAF3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0A55A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6301xw9oCBEWsQ7kmEBiuIVX8rhB2sqGOrAP3/c8JvdXie1F0XVIuhksI+/Hg7hAqgGgTzqWwmh2TlB6pdtoIzp8hhVgygXRYGt7De9/dApVNsDKOQhZ8N5U2+Zy0qRh4/uleJpPw4Sa4b1VloFi3hbZt3lVhjpi1WGe6P/6SoJcK5/ZWvXZT7wQVcJMxAgKUMcmSFPndbdl69ZzkGj83ORBKYXHMCnBz8ua1J1M/poMNF0SvFFgBZ+Tef/bGc/7N/krGjT79jRkqZ4Xtsl42IO5bg12sFAYXeDzyDGVC+isP3/rih5rfnoNecZwmQsQavqlRyE96QRFjnJ7cTMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPhWVA1wbxobRo4QVLXkLP4gZDZuwS/3TwtbdfZbRZs=;
 b=EqDrEyhl7YdtGz5FX0isH7JdtgSifWghBdhykDM82ywtRKagOzNjuCDU39/7S6FehrXeny/4cLXE2d8i+ZpDaKibx3jUJCIPapwcFLZ6FhOA/OYniPsT8OTYLsmKbdUsAnXdutajUry4wD1alvw5+vCyxrSdi2aPzX3juv/D3FlEwldAXLmWivzmQSHX9L1vE/+sQhr1dtFbh/op/pZqEjSFwvUxH5HLCLtHDUJPL32nmc9/Oxg6Q0TEAOvNiEFDn4iGV+9Lk1HAr8BVdCFqrmKQxxaLCx8C/BKyrE1e4S6aogbifO5WhlZYLQyE/iBgBO/TVfL0PBgZRlzMp+RQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPhWVA1wbxobRo4QVLXkLP4gZDZuwS/3TwtbdfZbRZs=;
 b=Kq2xGxHbdB3lk2ap5Qs3eCMGEQMS76Ay+shZ9sEsp6i3uGQD97vvQK1BmhXR/09wbVcle4Kq1nfJfmu9xsp3PuqZQbhiAKKDMhq5/io1tczUv5XqcPIWpRennfoy4NHGGB5HGU13x3Tc6Uem21eKg1Nx87qJv6594nVA7mwE0X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:23 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:23 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 09/12] nfp: enable multi-PF in application firmware if supported
Date: Mon, 24 Jul 2023 11:48:18 +0200
Message-Id: <20230724094821.14295-10-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724094821.14295-1-louis.peens@corigine.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e751475-8c42-4f69-009e-08db8c2b425f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rlBP/4bZHsMznW+jyVjJqunKF0OChDyw6x5W2aPtfBVpus4yD1BO8mDKBwfcmIMqvkuhbSFBqeedKIjB1N0P8A0gpG+T43nu5+YISi8eEcrFrSUse+dMFanhsaiwZgHjd6SWwV0ID1zVlQH4q3Rxz7OW6l8mn3jRVixbEJY1M0XDxiuetbtCs8KqmESUGIk0fkqUAAkIr5yWmd0Ve4S8f40qnnz4NBPhvrxLXjEfoRtjXNtmWvpQS0owmtO2qTx5mJoBw54oey5hgjf4bP1enX8TfMhPCdgRmrKOU2STSYIkna3AKfF4R7EwjZrKlJSz58c87hlp90zd4lbLVQlQccadnaIA8P023kE/+sGxzpN8suvJeKKD4PEE0PJJKnq6amucCxY2ZtCTIu8+buIh/jFtR/v0juzjV41ndD0xSubWB4J8vjXwLQzQknpPTNMHEdzIdaaseUYNBdUyOTP8fqwO5rfC5jIc3ArRvc5GQp9sUP9oTXoJR0yruL7pkhvOubV+VRpaiL1YP795xsIAbtEWUityUJiNnW8sF6r9USM/TDwRRF9rXzF1ZNPuoEqE8krHJ1abGfD1NMkCSnEDYD2wJ9FUisXqitwJJhrzehTzXMiHx7PkwATwH/vLTwZAmBOXUvMpmbwBDREvh5tBciHVcwjx7Du0QjhSTntVU9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09Tem12Y0psaW84Mmh4OFlTMVJ1Qm5wZEtPZUcwYTliK1R5eFd4aEhBY0ZF?=
 =?utf-8?B?dVFvQk1LeDRGdGtMc2RlbExleS9ocnk1V1c0cU9ubkpLS2FCa3Z0ckVmcDM1?=
 =?utf-8?B?dndTZysrY2hFZFhMS1ozcVJaS0drUnJvSHdHUEtBK09TRW1MM0xMOHpXN2Fm?=
 =?utf-8?B?Nyt3c25YWVFwME9xbWljajdnUUlMTHJQWGM5VDRSbG1hR1RDQ2U4YXA1SVZi?=
 =?utf-8?B?OGpybndZaU5LOW9FMjhlYldxaS9XcCtoOFg1aTdCLys0WjUvVWxRS2xkOTd2?=
 =?utf-8?B?anR2NC9xYU5oY1MrSnE5dnkwZ3VDWTZ1bS9hd0xKdHpnZFZZR29peFcxaWJE?=
 =?utf-8?B?QjJ2ZGptYVpnUUNYeXI2UCtMa0w3NjVBajhhMm1aVHJONXJFKzdIQ0hYUjEx?=
 =?utf-8?B?NVA3UVNua1NMTUdaMXJGUVBTZE03bFNycjhWVXQ1Ni9KYkd5UzB5LzMzcEs1?=
 =?utf-8?B?UDkycGEzczNVc1pkZGY2TDlmMVRFK0ovakpsbVdoVzdkM2dWRkFIMnlJUllC?=
 =?utf-8?B?UERRdFNNZHRnaVoyV1dIL01UbjNmOXpXZXZpS1UxdmwvTVZUQjlPTFpWdlRB?=
 =?utf-8?B?WmVFdXc3amFTYVBnb01odGNIL2g4MHRkY09RY1NBNVhQS09iOTRGMisyYmNS?=
 =?utf-8?B?ZGZXNjE4YXBKTFBLQXRUZzg0Sks1VWp3czUvN0RraUZDazlid0FQMWh6bEVZ?=
 =?utf-8?B?NG1yNFdBdnlSL1oxMWZ0SnEwdXlKeTg4bUhBMFVveGptSjNTMng4Vy9KanBm?=
 =?utf-8?B?c0czdEkxT3d1SmxFZzR5eml4YURSdVdFN2RGZ0JEK05iZGVVVmNGNUlKVGJD?=
 =?utf-8?B?SWlrREtIWlk4SjlWN1BLYzR5REUvYmdNbzNSZWdHWWpHTmdjMjZJV29FOUFu?=
 =?utf-8?B?eWZEbk54aklUWGZ2UmxqUngxQ1ZlNGJLSkpzTjBHVXNHRU1COG9SdE0yNThR?=
 =?utf-8?B?ZFBHZjVCOW15UEs2VkZkS0oyNHprNmM5elkyeHk0OGJmQUxNOTVGT0puT2d5?=
 =?utf-8?B?TDE3L1Yycm9KRGhWOXNwRnQyZ0RPUStVeU5QcjNhUlBmODExdldpUk1MR21x?=
 =?utf-8?B?cnk4NGk4ZVhVQ0I2aW1pb3ZLRXZnWjIyMDhyVU1Veno3Z0haVHZrNitBdzFv?=
 =?utf-8?B?ZitXaUlWbVdXNUN4d1VBYldWK2FEcHdpbHpaeUJheU96OTAxdVV3RGswMVFT?=
 =?utf-8?B?VjZDb3hobGRmbTBuMUcwMEIrWThYdTlvK29WZFFTZFVsUmN5STVmaEdQQzk5?=
 =?utf-8?B?UFRBbmRoOEoraEpWbW4xZ1JkM0pkSGlmMTZ4OXFXWDlNYkVxWWFucGJmZXBB?=
 =?utf-8?B?TWZjaDFOREFPM2JneTRyeVBjUDc4N0I1N0xsY2pKcEtNc3VDa1p4bXRYcmFE?=
 =?utf-8?B?YXNuc2RHV3MybU1SK3hMU1ZlS1JNa3I5WjFBNmhicmhzcVpDR0ZNLzVtT0hn?=
 =?utf-8?B?SlBVc0ZteS9ScG1vWjk0SVlQTEtqRm9ScGJQaDg0ZlZma2IyQk1obWNkR2V1?=
 =?utf-8?B?YkxtM0drbURVbEZDYVA2SG5SNU1JSWZ5anhMQTBDa2xpSUNCTXFyekFzL1dI?=
 =?utf-8?B?T0JNSVhtaWZPN2dxMWh4MS9oOThHQTVCWlJ3ZWJwaHhZK3hRRUFCdDV5cHRY?=
 =?utf-8?B?SjU5d2l5VzNoOTY1cThEdDZIRDI4bkYwZ2FVaGJiN0hVeXNFcm5FdklCS3Q1?=
 =?utf-8?B?bTJvTSt2anZqUWhpNDlKWXRzcnc5RldZamMvbm5BTzg2VTRVQ2hpQ25DTVZn?=
 =?utf-8?B?OHpLdmRubmJQZEM5ZE1QRi8vR090bnp3d3lmR1NleWgwTVNKRFJMNi9vRkY3?=
 =?utf-8?B?RUlJc2tQKzYzTkNldDlMRVRXWTE1MHNjVG9yVVFuTy9pSHRYYUNMa2dTYW1x?=
 =?utf-8?B?ckhFYmRpMXF0U1Z0Y0piWlltaE93cDduYXRLRlB0S0wyVHpDdnhrK1dCd1lm?=
 =?utf-8?B?a3g5aWV0WHFGU2tMb1NPVkpGQk1HTXNDR09JNnZUeW9hb0ZsaC9GcFIzTXhT?=
 =?utf-8?B?MmJWTk5qWmxRTU81OUxKeXlKVEhWTmpaejRHWlZBZGUrOHJxTncrUmRScnhx?=
 =?utf-8?B?NHJZWE16bXVISm5ZZnRYNVZ3YmI5bDhSY2hpSWtqOUxvSHIraEtpQVlLbURY?=
 =?utf-8?B?NnoxSU5UUjZObVBRR3F3SXZnRnVwMGl6S20xRGZUcTZlN0pZUmNpeFVRcWN3?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e751475-8c42-4f69-009e-08db8c2b425f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:22.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxRrFFahvf3x9m7KEqDo3GIeNafOsbGENpWyULiTDGuItklaicy3xxYk5lzvkTG7qlTst54UTxAlfleQIVXmDQg8WA9NafRI45ONQdOdDJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

For backward compatibility concern, the new application firmware
is designed to support both single-PF setup and multi-PF setup.
Thus driver should inform application firmware which setup current
is. This should be done as early as possible since the setup may
affect some configurations exposed by firmware.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |   1 +
 .../net/ethernet/netronome/nfp/nfp_net_main.c | 129 ++++++++++++++----
 2 files changed, 100 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index 3e63f6d6a563..d6b127f13ed3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -268,6 +268,7 @@
 #define   NFP_NET_CFG_CTRL_PKT_TYPE	  (0x1 << 0) /* Pkttype offload */
 #define   NFP_NET_CFG_CTRL_IPSEC	  (0x1 << 1) /* IPsec offload */
 #define   NFP_NET_CFG_CTRL_MCAST_FILTER	  (0x1 << 2) /* Multicast Filter */
+#define   NFP_NET_CFG_CTRL_MULTI_PF	  (0x1 << 5) /* Multi PF */
 #define   NFP_NET_CFG_CTRL_FREELIST_EN	  (0x1 << 6) /* Freelist enable flag bit */
 
 #define NFP_NET_CFG_CAP_WORD1		0x00a4
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index 98e155d79eb8..f6f4fea0a791 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -684,15 +684,108 @@ int nfp_net_refresh_eth_port(struct nfp_port *port)
 	return ret;
 }
 
+/**
+ * nfp_net_pre_init() - Some necessary check and configuration
+ * in firmware before fully utilizing it.
+ * @pf: NFP PF handler
+ * @stride: queue stride
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int nfp_net_pre_init(struct nfp_pf *pf, int *stride)
+{
+	struct nfp_net_fw_version fw_ver;
+	struct nfp_cpp_area *area;
+	u8 __iomem *ctrl_bar;
+	int err = 0;
+
+	ctrl_bar = nfp_pf_map_rtsym(pf, NULL, "_pf%d_net_bar0", NFP_PF_CSR_SLICE_SIZE, &area);
+	if (IS_ERR(ctrl_bar)) {
+		nfp_err(pf->cpp, "Failed to find data vNIC memory symbol\n");
+		return PTR_ERR(ctrl_bar);
+	}
+
+	nfp_net_get_fw_version(&fw_ver, ctrl_bar);
+	if (fw_ver.extend & NFP_NET_CFG_VERSION_RESERVED_MASK ||
+	    fw_ver.class != NFP_NET_CFG_VERSION_CLASS_GENERIC) {
+		nfp_err(pf->cpp, "Unknown Firmware ABI %d.%d.%d.%d\n",
+			fw_ver.extend, fw_ver.class,
+			fw_ver.major, fw_ver.minor);
+		err = -EINVAL;
+		goto end;
+	}
+
+	/* Determine stride */
+	if (nfp_net_fw_ver_eq(&fw_ver, 0, 0, 0, 1)) {
+		*stride = 2;
+		nfp_warn(pf->cpp, "OBSOLETE Firmware detected - VF isolation not available\n");
+	} else {
+		switch (fw_ver.major) {
+		case 1 ... 5:
+			*stride = 4;
+			break;
+		default:
+			nfp_err(pf->cpp, "Unsupported Firmware ABI %d.%d.%d.%d\n",
+				fw_ver.extend, fw_ver.class,
+				fw_ver.major, fw_ver.minor);
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+	if (!pf->multi_pf.en)
+		goto end;
+
+	/* Enable multi-PF. */
+	if (readl(ctrl_bar + NFP_NET_CFG_CAP_WORD1) & NFP_NET_CFG_CTRL_MULTI_PF) {
+		unsigned long long addr;
+		u32 cfg_q, cpp_id, ret;
+		unsigned long timeout;
+
+		writel(NFP_NET_CFG_CTRL_MULTI_PF, ctrl_bar + NFP_NET_CFG_CTRL_WORD1);
+		writel(NFP_NET_CFG_UPDATE_GEN, ctrl_bar + NFP_NET_CFG_UPDATE);
+
+		/* Config queue is next to txq. */
+		cfg_q = readl(ctrl_bar + NFP_NET_CFG_START_TXQ) + 1;
+		addr = nfp_qcp_queue_offset(pf->dev_info, cfg_q) + NFP_QCP_QUEUE_ADD_WPTR;
+		cpp_id = NFP_CPP_ISLAND_ID(0, NFP_CPP_ACTION_RW, 0, 0);
+		err = nfp_cpp_writel(pf->cpp, cpp_id, addr, 1);
+		if (err)
+			goto end;
+
+		timeout = jiffies + HZ * NFP_NET_POLL_TIMEOUT;
+		while ((ret = readl(ctrl_bar + NFP_NET_CFG_UPDATE))) {
+			if (ret & NFP_NET_CFG_UPDATE_ERR) {
+				nfp_err(pf->cpp, "Enable multi-PF failed\n");
+				err = -EIO;
+				break;
+			}
+
+			usleep_range(250, 500);
+			if (time_is_before_eq_jiffies(timeout)) {
+				nfp_err(pf->cpp, "Enable multi-PF timeout\n");
+				err = -ETIMEDOUT;
+				break;
+			}
+		};
+	} else {
+		nfp_err(pf->cpp, "Loaded firmware doesn't support multi-PF\n");
+		err = -EINVAL;
+	}
+
+end:
+	nfp_cpp_area_release_free(area);
+	return err;
+}
+
 /*
  * PCI device functions
  */
 int nfp_net_pci_probe(struct nfp_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
-	struct nfp_net_fw_version fw_ver;
 	u8 __iomem *ctrl_bar, *qc_bar;
-	int stride;
+	int stride = 0;
 	int err;
 
 	INIT_WORK(&pf->port_refresh_work, nfp_net_refresh_vnics);
@@ -703,6 +796,10 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 		return -EINVAL;
 	}
 
+	err = nfp_net_pre_init(pf, &stride);
+	if (err)
+		return err;
+
 	pf->max_data_vnics = nfp_net_pf_get_num_ports(pf);
 	if ((int)pf->max_data_vnics < 0)
 		return pf->max_data_vnics;
@@ -723,34 +820,6 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 		goto err_unmap;
 	}
 
-	nfp_net_get_fw_version(&fw_ver, ctrl_bar);
-	if (fw_ver.extend & NFP_NET_CFG_VERSION_RESERVED_MASK ||
-	    fw_ver.class != NFP_NET_CFG_VERSION_CLASS_GENERIC) {
-		nfp_err(pf->cpp, "Unknown Firmware ABI %d.%d.%d.%d\n",
-			fw_ver.extend, fw_ver.class,
-			fw_ver.major, fw_ver.minor);
-		err = -EINVAL;
-		goto err_unmap;
-	}
-
-	/* Determine stride */
-	if (nfp_net_fw_ver_eq(&fw_ver, 0, 0, 0, 1)) {
-		stride = 2;
-		nfp_warn(pf->cpp, "OBSOLETE Firmware detected - VF isolation not available\n");
-	} else {
-		switch (fw_ver.major) {
-		case 1 ... 5:
-			stride = 4;
-			break;
-		default:
-			nfp_err(pf->cpp, "Unsupported Firmware ABI %d.%d.%d.%d\n",
-				fw_ver.extend, fw_ver.class,
-				fw_ver.major, fw_ver.minor);
-			err = -EINVAL;
-			goto err_unmap;
-		}
-	}
-
 	err = nfp_net_pf_app_init(pf, qc_bar, stride);
 	if (err)
 		goto err_unmap;
-- 
2.34.1


