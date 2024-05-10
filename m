Return-Path: <netdev+bounces-95446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12578C24BB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A5C2850D5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB017085C;
	Fri, 10 May 2024 12:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403929CE7;
	Fri, 10 May 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343780; cv=fail; b=SOkPDJqIj2nLDbov3fp/OyzfbmewHjGj0KtLUbG/ByTTNqFoj0ifI8MdcSb3em4pGVGfj+6uNRhnsafrR3qXuL105L6uX8sANf8XXyArVLMqhN1PHUge8DW+UB/nb2b4Ky3tE1rE8DBMzESRA4jbsVu7mpQigInzQtktO7nSC8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343780; c=relaxed/simple;
	bh=qZpKamTB6BInaRBJYxk9wgG/IR8kNCfn1IC1SVsLW5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vg3wdPf5QT+/b3ZZg5TwRvuq1KezPC36uJFFoIc6UHKhPrtJNlLv+WqTaArzpmFPFRNoC7d5Mks3PJi89gejKom/X3FxXLBHrzsElNAV/1eFA4WPHDNeDK7cwLfwFRYyDbyRee8jSPD29QVjZW/Pi4uFfVJ+ia8CkhhrJOhju6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A3OGe3026757;
	Fri, 10 May 2024 12:22:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y16yxrgt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 12:22:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zci9tDNaYoA23/RzCYPCRTlTptzwdf73FYlqw5/CEdHhJLJlZcGNDOtcVokUkXUFNVOloaPc55KFrqh6tKm/pWWXMq0mV3nCAwWDObzlASu6NoiLRGMrEv8G3HrKGyi9FxKqM3nYqHE2xU0p+TgC8NohTBHJlYtTeJx9LHxls+4/6teSXWfyaVIcOLY/KykusvMu1sPwwVQwqwk5jRPZLCisSaoCz3W1GXYi08BPpDLH0Ld8qKoi9aveCoPLQyv8SbJQCh4We6jd+E1Kw1g1oeiKngy7DuhKRYeeaLO6mgAXLJMmTayNgCfYMJ4Y+Ws4yo9o0MxaPt/4O92cvo4vWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYpgx202dGjIZcRANew9cXpvRr5Rp995UOnRRWaHP2g=;
 b=eQUw2ajZKF2BckKmAUXTZAc+XuSFVBzvQiWqm4fGdU9bVWFt7wVob8zxgDR2BEf/RiV5NU7C58Wc+RHUibxutgkxt4H6U3M9bZf16Btgyb8pkwP0RobXdk7ymhBwRibvW8MTKxpVUQT5Yke4exKAQQXt8qVi9PrhNyDsntI/OnnbvLX1wGwQzo96qDixsOeYqxueR7ndAWetrfR+GOSfNn1QEzmuAg0UUFeK5PQO92bCJ28iItAOkLHuQOEl7V294c0krxA14ImHLEPG+VwSZPuez75bDdudJE2fVFNBWwdS2gZIy8QUbouRl0+PetLCcT3H0avcXjGu+2WLM+pGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 12:22:20 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 12:22:20 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net PATCH v5 2/2] net: stmmac: move the EST structure to struct stmmac_priv
Date: Fri, 10 May 2024 20:21:55 +0800
Message-Id: <20240510122155.3394723-3-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
References: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|IA1PR11MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 559cb3e2-b546-42bf-bc32-08dc70ebd6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|1800799015|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E+cnYRooJjQPjvQhSFcfX5VGxIlpRnqwqKec9QR8O1moDtp6V7RV/CED6Ac/?=
 =?us-ascii?Q?cIm8NfOIYydLRyY7upuny1p+na/XlbS0npr0N/8PXSWhRy9QaAZSU4hmGdEL?=
 =?us-ascii?Q?PNZoIiPMrGvueZEUCVkEGOxw7ZPRtPpR3tu+rXQm82jpUnEBGaY7HAfg8ALY?=
 =?us-ascii?Q?GSxDh++ohOmEHrInMtNU9qYBW1CPH1HcH/HcZKQg/gZt5aqQZB69vHlcYHn2?=
 =?us-ascii?Q?rAl3a0qeuDrqdEHMqPmmQXytCCr+rOY2q36EYMDsvvR91H+eJ1wc/Vk+6rMj?=
 =?us-ascii?Q?k4OaMo3R+sYc6hAT5lrGxG2AeZgT/oHgcrjq8WlF8wJK3moo/Fp4ngfd7r6B?=
 =?us-ascii?Q?43/ezRqVgUKuiVfyqcVPxBbB4QxnLcMZ9JEW5cX/DFOeKKk/GqM42LOleMgp?=
 =?us-ascii?Q?2vgXLwjW2yqXnXb/u+B9IRoJhEvcLtrTJ4eoeb7l18ja/RnS6AW4+ruQEH1H?=
 =?us-ascii?Q?/qyf3cKWEKGX3yWZbqXMZHe9ezQtXY16VxFLZ6BedhMbZg7mFBoWRHmGhIXQ?=
 =?us-ascii?Q?dBPECono3tb29rv/takX6vOtc0wKlJ5dx+jB1f+UG/UTU48cicpt4EDuGmN6?=
 =?us-ascii?Q?IkZOlAtu4VEf9DNZ7ef4k8S7ZDYgZwEQefY/ya6RWJaV7bMLMb3a4CFyltCT?=
 =?us-ascii?Q?Sh0Fb5pk4T5gpJ4t239vOTRr/oQ8jjywhlxj1uaGurksUXLVyov/pyXCDMe1?=
 =?us-ascii?Q?4ZlizcqS2O1LmwEFzunmnOeFz4BJrMF8p39WDlIXYMpsSU9X6ABLaeN5yC8p?=
 =?us-ascii?Q?OfaJEcVJViQhskACLW2COMbVAf5LhTx8QWIobLriJnTL6buPtA/ANXSwRZ5I?=
 =?us-ascii?Q?wX7elGQVC2+sDtt9Ac7hXTW2osXFhE+EVCNPPA+gmLm68tVZh0fiZI/0s5oJ?=
 =?us-ascii?Q?zXnqYOkZHJmioxiNT4u8e7mXed0+f8mO9c9P133hInR58fFdx2e/IcyIeW/5?=
 =?us-ascii?Q?NTbEzqd5m11Mg749bXZ00dEwKF7IyiGvzls8ne4tL5g6XntvpE63HOrrLIji?=
 =?us-ascii?Q?BgXlg5uzuIEIk95RvbYWvbrhWqDMAVCdx8l/LM/ppaW3O874jOHb7y4Ayr7F?=
 =?us-ascii?Q?+g5EQtIjEPczfLh50fWl6D8xUDXF/rqSG49xIPB9gKhJCxANRKxV3UFgkxY/?=
 =?us-ascii?Q?MiMat9DAYQ1BTq4GjklBGLGufqb6/R+w9lGBXBN96h3JqTtamZ1vX1yunCG4?=
 =?us-ascii?Q?E4zWY+QcEe2yKNn8xo5coge6qcn4JpOb/ekgXNhyeZCSyGKwA+aCGKAZuIH/?=
 =?us-ascii?Q?O4SWcwTW9xuStxY9DPHav7wf2f3IecQuTQpX0B8P6Zyyj4SfsmhEfEcsltZU?=
 =?us-ascii?Q?oqyQjhMqGbsKAz9waCkQ+if2wW7iIImfofscmvdxa5seR2xhFahw8qWmM7fJ?=
 =?us-ascii?Q?FTSvUMo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sn6wC1MLrsNebxt0HSC4/lbrrbfJz+whsDjn0aJteul95gelyetPAGabngf6?=
 =?us-ascii?Q?hLE7R5RFQN44/KaYIFj2kkuztFTo2+lMnPrmvBKKxaZ37bB/BQwiqrirL6V0?=
 =?us-ascii?Q?P9vIIFJfb51XMyA0V3Aotl9SpHqBgrRejxvGlGjmmdtfpxu51VvKOOpSNlDU?=
 =?us-ascii?Q?ScGgkSVlIbDQFfkE2/yc23XLqxYjgaObSWkDee/ARWSpF9hNs6S+PUFS2/ce?=
 =?us-ascii?Q?5v7mkxe47vIaFCAN8MB+gCv0ZTwh4uXTz8db6Sk+pzvrsKefyptHjBCGAXnP?=
 =?us-ascii?Q?sEOI6Fnuz1TY5npbbz3sKWriK6D78meJjo7AU+rR3qfExJFYnH3ILRqnp0/Y?=
 =?us-ascii?Q?dG7cK5WcKx8Sso303tQYkkbpQ98YGwAUIh/V8zHQFIL5If/mDLC/lSEGOMEi?=
 =?us-ascii?Q?j3EkfnAcx5RsjSZL6XODknaOdrx56wQAWiNM64tzlVdPV4eNLNIEiZgOXKfu?=
 =?us-ascii?Q?XUML7b2mX+6kqReKR5PKlPy7Z6IxabQKl5umL0N0//tgrLPtrXD5hUHHujCw?=
 =?us-ascii?Q?LwwlcJMGHbZHRyWWhcbf1HQDOBfdc8RjxUsESEKvKI4gFpLypkx5732nxXfO?=
 =?us-ascii?Q?3oGRmJ25V3D3y6q6HSykTGfTsr1qhvzjFpA0OG8G3RS+g7mq8hfFKaMVHZAE?=
 =?us-ascii?Q?osPHeBZxJydDniMo8qni9n1Q8SEJfsx4N01QzzxagzU/tRuoTEn0O3qnumgZ?=
 =?us-ascii?Q?ZWkUvYGZeDBS0pk52P1Kqnw14FqV+cx0+CiOVJfRqbzaP3Y0zwu73HzyWYhn?=
 =?us-ascii?Q?MhnSpr4+MTDJN7glc2rw11UktBIUoVligsfO5IHqtPhBMGKxhs0Byq/2KW30?=
 =?us-ascii?Q?b6bikQ/BxaKBiRgi17Y74JsXUYSEQzVDrd1XO6X4tuhpdaNWlJkFKnO+Eqw3?=
 =?us-ascii?Q?HJJCq69WEacTfTk79ip7xPImizMgK0OOQMw0LF6EmRb2KfP7euIh56IlcPmy?=
 =?us-ascii?Q?uWnr7j/14fvHcYWjtb77oB5lgqvWCGMg5ezbTC5FYwXX8PoJnEt6UgGFYEZR?=
 =?us-ascii?Q?CiVjm/mjNgVZxukKwlsuyBVvlmtACq249Vz1LVYXMJjl6C7gOijbq56bNJAq?=
 =?us-ascii?Q?Ri/3vNz6XruJItirzSQDZA/yvgGnwiRja8LBuE/hub6l1ieqx2jSf8OSfu8F?=
 =?us-ascii?Q?IBq4ytbjbdj0bfF4R0ydjvLDVwbiCp5B0q16h6jL49xbn6EGnDgTippJ0lJg?=
 =?us-ascii?Q?ZplDdeZ65pzGiPUzvlflZiFFe0KtIexS3rKVmmruEB1VCwHV2izdmOZiyoIj?=
 =?us-ascii?Q?mY9ZYguRhxP+hbs5D1llDVsnBI1D2dIxE9y5b2A6vAGjWN5SUJCkbgljwbgS?=
 =?us-ascii?Q?lMfwlwu1P/kUIJ3rF6eE7pZqRF5f2Fj+2W9ICfy258lbOLaTNt4eXud47v/k?=
 =?us-ascii?Q?ozU/g7P+Fe4JhqFlkVmAHYA03XiR/ytfNMv6PKIQqKiQZEPnCgJ+Hs+598+o?=
 =?us-ascii?Q?u/Z0Ga8BPALJEmLBBlLmG71EeHHvlEW6+ww8oFnS9fB/rIyQsdsZzpMTxUZG?=
 =?us-ascii?Q?V2eAibksKYZ3DE9tfZPN8mQTGrbcpLSIvJ9ZcaXAXClYatiBqd26OrFuvM2p?=
 =?us-ascii?Q?vZHyrYrcKuErif1EsUCSyPWIsaCU74kWBrY/tDQ5Uu+VP03H7KzgtexBQ1rH?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559cb3e2-b546-42bf-bc32-08dc70ebd6d1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 12:22:20.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKMlVfwknQuZbGUyiNW5VuSBVdGD3gaokGJeFzCx9cq1TobM7N7RXlYE6/d/vD1MrB+4vMsFz6fC4p1JBL83MmvckmLFbCLIBr8UlU4m1MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-Proofpoint-GUID: j42DzXbMPnpGQuqt39y0lKePZCCs3ywa
X-Proofpoint-ORIG-GUID: j42DzXbMPnpGQuqt39y0lKePZCCs3ywa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100088

Move the EST structure to struct stmmac_priv, because the
EST configs don't look like platform config, but EST is
enabled in runtime with the settings retrieved for the TC
TAPRIO feature also in runtime. So it's better to have the
EST-data preserved in the driver private data instead of
the platform data storage.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 +++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 40 +++++++++----------
 include/linux/stmmac.h                        |  1 -
 5 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 64b21c83e2b8..e05a775b463e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -263,6 +263,7 @@ struct stmmac_priv {
 	struct plat_stmmacenet_data *plat;
 	/* Protect est parameters */
 	struct mutex est_lock;
+	struct stmmac_est *est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c6fb14b5555..0eafd609bf53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->plat->est && priv->plat->est->enable &&
-		    priv->plat->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
+		if (priv->est && priv->est->enable &&
+		    priv->est->max_sdu[queue] &&
+		    xdp_desc.len > priv->est->max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    skb->len > priv->plat->est->max_sdu[queue]){
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    skb->len > priv->est->max_sdu[queue]){
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		goto max_sdu_err;
 	}
@@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    xdpf->len > priv->plat->est->max_sdu[queue]) {
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    xdpf->len > priv->est->max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 0c5aab6dd7a7..a6b1de9a251d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -68,11 +68,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->plat->est && priv->plat->est->enable) {
+	if (priv->est && priv->est->enable) {
 		est_rst = true;
 		mutex_lock(&priv->est_lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 	}
@@ -90,19 +90,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->plat->est->btr_reserve[0];
-		time.tv_sec = priv->plat->est->btr_reserve[1];
+		time.tv_nsec = priv->est->btr_reserve[0];
+		time.tv_sec = priv->est->btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
-			     priv->plat->est->ctr[0];
+		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
+			     priv->est->ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->plat->est->btr[0] = (u32)time.tv_nsec;
-		priv->plat->est->btr[1] = (u32)time.tv_sec;
-		priv->plat->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->btr[0] = (u32)time.tv_nsec;
+		priv->est->btr[1] = (u32)time.tv_sec;
+		priv->est->enable = true;
+		ret = stmmac_est_configure(priv, priv, priv->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 620c16e9be3a..222540b55480 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 				     struct tc_taprio_qopt_offload *qopt)
 {
-	struct plat_stmmacenet_data *plat = priv->plat;
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
 	u32 offset, count, i, j;
 
@@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
-	struct plat_stmmacenet_data *plat = priv->plat;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
 	bool fpe = false;
@@ -998,24 +996,24 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!plat->est) {
-		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
 					 GFP_KERNEL);
-		if (!plat->est)
+		if (!priv->est)
 			return -ENOMEM;
 
 		mutex_init(&priv->est_lock);
 	} else {
 		mutex_lock(&priv->est_lock);
-		memset(plat->est, 0, sizeof(*plat->est));
+		memset(priv->est, 0, sizeof(*priv->est));
 		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
 	mutex_lock(&priv->est_lock);
-	priv->plat->est->gcl_size = size;
-	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	priv->est->gcl_size = size;
+	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
@@ -1044,7 +1042,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
 	mutex_lock(&priv->est_lock);
@@ -1054,18 +1052,18 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->plat->est->btr[0] = (u32)time.tv_nsec;
-	priv->plat->est->btr[1] = (u32)time.tv_sec;
+	priv->est->btr[0] = (u32)time.tv_nsec;
+	priv->est->btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->plat->est->ctr[1] = (u32)ctr;
+	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est->ctr[1] = (u32)ctr;
 
-	priv->plat->est->ter = qopt->cycle_time_extension;
+	priv->est->ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
@@ -1079,7 +1077,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	 */
 	priv->plat->fpe_cfg->enable = fpe;
 
-	ret = stmmac_est_configure(priv, priv, priv->plat->est,
+	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
@@ -1097,10 +1095,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->plat->est) {
+	if (priv->est) {
 		mutex_lock(&priv->est_lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
 		/* Reset taprio status */
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c0d74f97fd18..8aa255485a35 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -245,7 +245,6 @@ struct plat_stmmacenet_data {
 	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
-	struct stmmac_est *est;
 	struct stmmac_fpe_cfg *fpe_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
-- 
2.25.1


