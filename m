Return-Path: <netdev+bounces-28111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C767C77E3FE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C811C210C7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4C125BA;
	Wed, 16 Aug 2023 14:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F11640D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BD2D47
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JskBCqcUOeP1cTO+EfOJqcH3fi1FDcNRbYgpSCiF3qjBILdSiR55W0A2KguyFILtKiTM3Awfuqk2L0WfHJSJv+q1UPOZlPtIEzbKiP6XXnn7MY5Up/hfzLH3Iy4XWERI1AygnL9XvFYrNRGVhHeoc0LeMVguPBtnC1CyC6SNBF8iR/Ak0niju8GCIiraOcWK6yhdYqq0qb0jxjDrxl7oBtg8PDDWMkVKehNH+cUEhiu6OA/ohrSqqvAZtQHaGpUCPyN6YrPc6ws69Ro06C+nO1YQ1S05yhpEG2C6Pf25nF4Kf9DjKv4FIh64ZQQcEbbOtiAlfbxWqYUpHA2j0LMFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPhWVA1wbxobRo4QVLXkLP4gZDZuwS/3TwtbdfZbRZs=;
 b=lI0UKAIHPFon3CWmfcgWZH3Zu+vDfUL5JU1fM2Wb9N6s21VYTmzyVwIIgb1WIB97tBTiDDyilKqVqk9iOii/i7Q4IkaEp8rjS6dwgwRedo8Qux5LV408rNVb5H4a5i+fpDMQqut93dF3m0GdJW+Wv7Bkstiogaul7u6d4LMoBNp7iZ0MgilskLd0s7HZbsRAD/tj13GWNIFrDaRJ4WqrtE7tOMQzJs7E8L6NA94YozaKy8F1SNzI6kgs5gbdJoLmzaY2ES+icVMl5FgzpESFkPKLLgdaCLkcKpEdI03cGwqF94LVNr6TRQ7VQsRGSwGnw+rLYqip/4e2SyDMiIKxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPhWVA1wbxobRo4QVLXkLP4gZDZuwS/3TwtbdfZbRZs=;
 b=O9snCF4c8U40ous0LXoesp2I05EaGU33gQqBCHwnX7Fk4+gTBm1xgOflbI7qUho6IyOyPRGoLBv0eG2ZWmiJhyratjLc97ichbkwMSH64gbqPqGA/sr7i7PuWDT3odlFIG4HB1G942TSvQlREZ+arwfjZxk6LI231jZWt+i/i5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:28 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:28 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 10/13] nfp: enable multi-PF in application firmware if supported
Date: Wed, 16 Aug 2023 16:39:09 +0200
Message-Id: <20230816143912.34540-11-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb1aaea-7db4-42d8-1801-08db9e66bc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4RNNeyBpQHoKpZNla9s6I4A0M2fWHB+AnliW7YLKEcUmKuYHbVltyge7YU0rGNR94w+jUHkufTNM6tAAdEV3LlUKhVYIosenO/hctI7o+Df9ISy9a9Vvb5asgjtidI2qqT6SoeIF/szRHHQHhT+YG5gKH56msw07IKHJHZBWOw60FVUon/AoJVfI2ITd5PQMR/l7TwaJK3KhbQqpIWg3ZrQ8fDlLezJ0tys3TgnnN4LA8hh1m6JOZ+LnvU321wI8Zi0JieNTnxqtDbUiSZAl9A2jPlFmDcNhQcideiq+0RxPgV3AmLeYs7M80rJ7+Th+IBIWQAIoxJYDCUwOYW/+/geb9aMN9GYIo2j2p5TgTECbCGndzdH4u57s2Wosic2BhdDzi/Iaee9wFSsjvzGpQxzLo2NPQutxuEgSMi9uPeD0nvg82KB0TZ0XqoVpq15HN0Zt8oUlfp9HyUoZaKQyTJj7PR4UBD5kQP/9S/lZYH+zeLKVokp4Fvaet7rAfWllDH7fA/0c+WWqFOHJZJQy+/Lpgw5cz81D+vKWGJ0EoURv6i1dq6+/CpV3BD8xi8WWrvuQEhjMFDDoMeVBdedXxacLNErDdNPimrt1rDKzbjl6R3YUvwz0HKqZmFOg5mrm/WXnfkT2zd2DJVmxf4pUZfrMYFhfDf6vOOHo7rkKbE3tjv9PDgb/a/hJtdkiRwtaZvohNtTVl9rURjO/wjKpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3BQQ015YnV5Vm00RVc5RFZveFhsdHZBWXVWM0czejFOeXloYm1QNEI3Wlcx?=
 =?utf-8?B?UnFGSzFYd1dCdTJFNVpxZUE4T00waS9HTyt1VEVhcVpJMCtSYndNRWFuQUtl?=
 =?utf-8?B?eDBtcGRvU1ZHdUphQnNkd1ZQaHk1cmJyVHBuRDB4WHpmWjZtRG13ZG1DWU5q?=
 =?utf-8?B?c2JocGM1bGhIWG8wd3pZUXlYSENZd3BjcTNuUDN6T0ZDTUt5TzgybG1yS0sv?=
 =?utf-8?B?aXQ2REdvZk9wNTZWa3ZYMjFvS242TFd5aUZlcXpjQjJRYlYxb1c2cmx5K3Zz?=
 =?utf-8?B?RkJzYjlrMGxOWjhyMHpibWRFOTVyMTVueEFaZWF3ZmJCWmwxdHQrOURZOHZI?=
 =?utf-8?B?cWVvYlBVWkozOGlodjV6ZzEvYmFSWDZEUFUyYmxvM0lHSWZ1QURaTkJjOXJQ?=
 =?utf-8?B?N1BSZmRpRDBZc0NPcFQ0YklVNm5CZmN3L05DU3RhY2NiQ0lEdFduRW9yTFJi?=
 =?utf-8?B?ZGk2RThQQnA3dlE4dm9sZ3NWbjZkT09GQ1dTejBsVHVkSm9SOCtWUVcramUz?=
 =?utf-8?B?WFMvbGxjNzNBeE8wQVNiQlZFNkJLNDg4cUNHbWRpZm1zSlBEVytlYWdaSXNB?=
 =?utf-8?B?bUd3cEQ1T2xvcm91ZHV0S3FjYkVLM1pjNTV4L0hCMGhHMnZUcFZMZFREbStr?=
 =?utf-8?B?ZENJeHpNbnVHbnVzcUdrc0JRVUU5ZUhOSkdncFJTUk4xd01BN1h3ajhVdlpS?=
 =?utf-8?B?ZVZGaDc1WklqejV5Y01SUHlaQW5PSVE5ZTF1RER2Nk54MVlvUXp1Vk5neGRW?=
 =?utf-8?B?aDQrb2MraVg2blBjeDd0M3kvb2hUSXp0L3hSZjluaHJydFdWTnAyNjY1WW40?=
 =?utf-8?B?dkszdzNHRGpxdGJucUtZQ3dCQTE0RlFWT2sybm1aSEt2ay8yMDdPcmhua0Fz?=
 =?utf-8?B?K0twdGNEVXI1NjRYcG53NERBRW15RlVxdThOZmNPYi9DNFNrWGVZN2dmdi8y?=
 =?utf-8?B?QVBWbzJWK2JCQnJhMmlQak1vRlNQc2NmQ3phK05RRXZkQTZMRGJGcjF2aXht?=
 =?utf-8?B?UXE0SnYwS053ZUdYUHRrSTVsMUxDcmVoSGE4NWNmRllpeVpDT0dvOXd0R3ZN?=
 =?utf-8?B?TTlpb3kvQ3FLRFFRaHJwdTc3MzVDQnFWR1VvcEdUWW0zWExEVU9pbkxEZEdE?=
 =?utf-8?B?eGFnRFE0WEgrZzVDa2pFOUwzU2psb2tsczJoZFJMbTF5NWc1SlhkVDN2VExh?=
 =?utf-8?B?K1l3THR0Y0pYQmdJa0JtckczZzFWNlR1R2cvUzRRWXFpaHowWFVteTNXMWFL?=
 =?utf-8?B?ZndCU3g4STM1dThWVWxRUFp4M3dHMGJxUjdDWU94Wi9DTHV5eDJWL2I5NVZO?=
 =?utf-8?B?ZGJPL2VpVnk3S2JVdGdtSXJxWlhJQkliTWRFS0RWOTRVVXNkeU1KbVFCSDB0?=
 =?utf-8?B?MHRmbEc1OVY4MHo4M0h6MDFybXUxZ0txR2RMNkZNT1l2YUNRMW5OdTNRdVl0?=
 =?utf-8?B?K2crSGpOemU1WUJzNGZ0SW5pY3I5dWNuRWVDZDhUb09QbjkwNmtZV0syS2Fu?=
 =?utf-8?B?QVBoYUk3YmVVM2dSZjM2NlhOUlhiaEc5TmpIdGNKY0RqeGtwOU8xaDZPcDd0?=
 =?utf-8?B?eXRXVHJMK09xOTBHYjkwNldPY3d5WVRrMkVhdzN6MEFIbGMyM2pDbE9tcTZK?=
 =?utf-8?B?M1loNkIzbjVPSEpMUXNBWlJObkxYNlE4NFRPRUxRVFJlQmhmeDR0YXpXQTRG?=
 =?utf-8?B?bVFEQ1U2RkorWkJ6eFJEVHhBWlJ0cGhOcStSSjdhY0R4RC9aYkRoaWJnVmg3?=
 =?utf-8?B?NlIyNXNOcmFINDkzQlBzcFIybWVnV1VYbTRhRmg4NnpmSE0yaFhrMVVUTEJr?=
 =?utf-8?B?Wmd1Tnp1elZUWVhWRkZCbnZ6bmxocWQvNkRpTjkrSG5Bck0wUTMxZnBoU0lG?=
 =?utf-8?B?eXg3ekFIeUZSL1hSZExVTk4vZ05YOXJGWE5yNmY1N2FrMlRJc3pQWWxTYmlq?=
 =?utf-8?B?NzZhSXZiSkVGdUo5M2JiaEhXdlpzV0RXOFJHMENxVEZNdy9lWk9sU2xZM0Zt?=
 =?utf-8?B?VzBKaExobnE0eDlJdVFIeEtwWlJKNi8zRHZyMTBMT3NSeEMvMTQ0MGlNT0NM?=
 =?utf-8?B?NnRaOGt5R1NlR2V0MlFId1Z5SVpsNVRCeFFzdWphVGM5QVhxQkt4cEgrRThu?=
 =?utf-8?B?allTLzMwSUdZWkx5eVM1Z2VFaXpZUW9RbGNJK2dVUW9CWWI4SHpzVis1Q3I3?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb1aaea-7db4-42d8-1801-08db9e66bc33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:28.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG20jZ7Wxe8d+oRUYGSVR5VfIQW92FJS9Da9TAa4DrL/60EJn6m6wIx5K/j/Yqi9lI20F4cfo4AGgEnPov8u3g/WXvn1VpGazyJ6dwXmGy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


