Return-Path: <netdev+bounces-95444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A68C24B7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B94D1F254F5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24816F0CE;
	Fri, 10 May 2024 12:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268111DA4E;
	Fri, 10 May 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343770; cv=fail; b=SFJrWOLn3xGIE7m7iq588jwFPgpqJb0pfGUqBVLiXy65UmMB0xUAqTayi13naLMmfft893ZAaa+leQF/f2/MIrqHLVmbm2ahYC0oPuDYDRo39afzGCJtYyK8H0piS3IvxDotb5Dx1nH9f2TiB2W+MCr7zhS7GB5OVKW+tpWC+i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343770; c=relaxed/simple;
	bh=myTPI3T4iIuq0WYeqD0ZvsgUNvubA0zI9CgV8frJqZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OVbMDOnlChrq0wtDoY3XThF3W5BVGFw4x72iQSUfkl2tj9v7EtyKx5j+cpw46Csmfh94ed2na0qtMN7Cz8ud7tr53mk/ntdHjcQ5lyecx7JffE95VCVCm/dW3bxoto5UrhP8Nlpe1BEWOclUvLPUBCrRQclnTXiUOAwKPWVQWh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A9mmGV014204;
	Fri, 10 May 2024 05:22:16 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y16w7ggxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqM6Atv7iJ4IfGCMmlHOjB4bAc2MaVIfOmx18e9XxesTVUNrCQeAvxbhdymsZrsfUQt0Z8/njDeUotBhJcnQwKwVJ7PnSZyEVc/xlD+psab30xRanvXovbOHb7fh3OvvB3y+VTV8DBnxOUrNhnBtEg796R7p/egiUo2PoZSOMq+OqPNyJy4Gkbu9uVFOyqEs7SnKkkgnTO+XyZUMp3E3oZMaUZWBstdDmITNiSfz4ltFL26fA1ZnNc7/W0BJyyyJc39aZbSQWmCaSlTxgpTyuxHC958Y3x3vJLf+jXasqSaVch9ViHwgp1TUlVgnoBXInV00w52i5InpwPyDMtWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUkN7xSFakwpoWcy2VncwIf5BPqFqbVwZP6pQPbmel8=;
 b=cV3I1EXqg5HxfT2gV9udexPux+QXSal3z7bIJiyhhrHYEB+DKJhNEa04aN+uxgowYaqxUXrM6CZfhkRyhxH+kdJKURw41jFcPkgqe9KmIi5jA1nqa4y2QCMFN2oEnMeIdKkZn/YbqB0OVM5hSlWmQ6xtzN+lQWpTFOiNR4y03nYwaTolcxFb2gH8HZk0SXOZfQ4jVuq64nIIAhsByPFvXY3KCc/wxMK2XnaRl6FtFVRCGzk45MwP/2slzCqRIkfeSNTyotbzOIiuvbJOx3P0gyuonC6DEgQVlAMubuSahAFSLVhZ2TF5D8VQtM1pP05zMH1Q1agRDrYEVKaBNQabIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 12:22:12 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 12:22:12 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net PATCH v5 0/2] Move EST lock and EST structure to struct stmmac_priv 
Date: Fri, 10 May 2024 20:21:53 +0800
Message-Id: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: c10a1ce1-748a-4a3d-5f49-08dc70ebd1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|1800799015|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dJh2BZf3XuoJ3WLR4zvn5QqRT1JMwQ5gReC6sgxSO7/Rce3MJDZf4QXhEs9N?=
 =?us-ascii?Q?zOLAYCHfMKvBO5h9bGi61QHMEfO7ltVkgDn4Xc3ki7w16PiniRrp6K5pUxCU?=
 =?us-ascii?Q?MspNYzmq7Pq6BjMAMK8fGwvXWx+hLNdsx8nTxciJEis9keFYEqf9PhYlZYr4?=
 =?us-ascii?Q?qh5RYViq0QSzUrHMlDI4fYwcrqBqPbkLzilQjP5zA+8YlIu/iIndRodUIlA0?=
 =?us-ascii?Q?VnjMZJBglx0Zb5VVE2/IRDxuSM+CnfZacRIsutkBGukOOR8YyXot0fWRYDIZ?=
 =?us-ascii?Q?vZ0pf9ra5rpznhT3+l/7Ngcw+SwhbT/EXTJihapyY3nPPYl9rmSsENeTvSEo?=
 =?us-ascii?Q?1TEjYlPIYa9rUR1WPf+WTE+Dxo7VA5O2W/C+um9iOkTQ9Cn0vQeYLukrXwqU?=
 =?us-ascii?Q?3yHtrQW3Icga3OrUDsGRV9zKxqEXiRMUnGZUINYSPwc7oqu047sf6zA3XPaG?=
 =?us-ascii?Q?VnMYT9qokU3pjbsWPVI2YQSt2WdIvuHC8WfXuqpkPFDQqMRmc09IfDuMbjBu?=
 =?us-ascii?Q?ADxGkbjTsHGGGsiWV7DA5ST2t4DL8pDLlRZuJUyzb/oaaubRWdQ6IeKueQWg?=
 =?us-ascii?Q?nTQkWsr3dGUob2Tjxto8jong3K/sA8nc0+bk131NYKwir+UH4dmNAPQeK15A?=
 =?us-ascii?Q?QNKE9L9WS9D6LnMpNi+CK2TpU442SBRzv+IuDQBJfJ5t54XlWBWxaSJWNeVU?=
 =?us-ascii?Q?AldLVhh7YC0V6NSb1UUSoSsf1gjOZQPwB/dEMtHG1vxIjJXmOcnHpFroUlSw?=
 =?us-ascii?Q?u5xq7+vzDdi6kTiuQ+6EiFmuaor+SlCMxVvX+rPEd+GHVxfNfIeAACuLDrJB?=
 =?us-ascii?Q?3PIcUGlBRgwACCEE7iEg0M7F7OIFzXhymNThDZrwQpJUM6hl0QTCPhn/TSgt?=
 =?us-ascii?Q?tu9MI+mW/XRUf8rTq5GTtJcYp78zxMBIfCuGEiGuToeB0YzuQeKIy0maDIPb?=
 =?us-ascii?Q?mvU/RSKWJS92Vy4sh4+VAPQacd7ScDdwv22nLk76oEAA52OM71P2TfdlZqz+?=
 =?us-ascii?Q?NfYcpYoud4yL0/n7G4GtFMuAiizQCfbakZdHOze7IpknudNJsNXrYu2ThWg0?=
 =?us-ascii?Q?s7rNteSWaqCwfcd0XUmmZB2igUOe4f/jY29isoSSPlG/TPSrpGVdKgM3G6xO?=
 =?us-ascii?Q?9NcTfOd4fe304jWbqyxItDl/bufpDBOMBAmSLKiYsw2eCNc8A32ukW6KxH8t?=
 =?us-ascii?Q?WGlADehjRyujnsbx6FzBMzAfssKTNxwypTuo4NJnnhZQmymmA8U1B4FgCJ4g?=
 =?us-ascii?Q?CgU6B2w9LwW445LKcBkTZbWp48ZLNfb/J6g/BzZYrwtEYA23Hf/S0zZzcw8R?=
 =?us-ascii?Q?P/w7GgdLcvS3Y3ryR4LkMaf3EZc8Ee5d3m5N7VM1JVK/2c93+W0Vl7ZOSeTB?=
 =?us-ascii?Q?dsiliqA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1kJV31CsPsAGNVyxDWZS5bp9MQ0/tFHnNYThQv4XBHWdPWlGJPo2TTnCjzVf?=
 =?us-ascii?Q?fJCgkZayKPxrypxcIILDgaZ0uBwWqJaVAhfd3LxZ+TY8rEdO1X003motYq3U?=
 =?us-ascii?Q?njJ3kuDroWWG9+1yXlsnt/8H2Ltmq822PjvQYDSxx1VEiZc1awTExUKAKKX3?=
 =?us-ascii?Q?GBNj5SpD7mxsZaOM+kkAlCOOWi6THq+LvFjz6L10U8KGxEycaDzR3emxm8ZE?=
 =?us-ascii?Q?3OVgGDqxU9zFZlJFI5vncelbqnzTLtVkfbjkA0iLFFe+62HhQfk0B5fBZ7dx?=
 =?us-ascii?Q?Thg+DSE9fmg1twgFVGDSH3WDEaCVXJqLtNuoIniylCJKnRwtyZsc3K4QfVLm?=
 =?us-ascii?Q?2WVG+NehXe1tYtZT6m7ZSVU+i6QLWHmSF5t1a57zkLkoqfPxi9j5RUFIZ5YY?=
 =?us-ascii?Q?8n9YfvsbT1OeeQWio/XfD8sq8vjw/tF1lblmNHoAfe9lcooBpARliIQooHxy?=
 =?us-ascii?Q?H1Lu1kyguAdWLmstBGcA4y/vYfDXyVRzBomelEqMaTlfl40vCjkkd0MZIpEj?=
 =?us-ascii?Q?yw3sSn+E9NfSxCDm0uf79imd1UvvCvP6zEdfwBk/uwqjPTRvFiwFN6y8ejE/?=
 =?us-ascii?Q?Co03rNB9gnc3Yp9vAAz+EgLTuOu9Mt+q0IfRfIgP/FjuuaP1CEnYCPIDkzGM?=
 =?us-ascii?Q?ebWeXolejK166cuemjflSNnWTPFmyQjTAg8Lnqss/LaqwOB5QgRsHoujboYc?=
 =?us-ascii?Q?7KXBLvlaove8JINBqVgTQn39AczgeGRrlR0y9XPMUbL5tVybLnidEKzmNaeg?=
 =?us-ascii?Q?+w0uTQSPG8UbxKfn6GjcHwm0VtvsEi6l45nTGrnfaqxjIMB3vadFEOx+E6+9?=
 =?us-ascii?Q?xzWWwa9cSE/tyUKw6RFarQs83oBJjQ6B+LM02MSnPLOWkX26Ki6QcQTm5k4v?=
 =?us-ascii?Q?0sLJahuJlGYwUzUoeryolYbIOwceb+5nFssfMZzCzt+xRdaXAyVUTwzdFO2t?=
 =?us-ascii?Q?qCKLmhYw0X69R88leUjfeyYWEYmQ122LyD/DB3JSPxMEwPEBB5jbn1ugtzsR?=
 =?us-ascii?Q?9gBPTGc93fL7cVpaES8yyIegYm2Qt4VKFkxBL0kwY4ZbcQ533ajYz5jjKPwa?=
 =?us-ascii?Q?IM+c7/sFWQeAZRbq7arj7vU9h026a2l/rvyHsB+xeXkZH5DORFYF1G04deam?=
 =?us-ascii?Q?xNP7BTlAedGdqf5e35h0o1fhSZlMLbr/eZw8oRBUeulaFUcfHR6+g6euPCv9?=
 =?us-ascii?Q?SnN0pdPPA6MPoquT8cAPWsZCoJrRW2JHyfREZkpkCQQQcJ+4DDW+mYJ7GCaN?=
 =?us-ascii?Q?iSYTJe3Y0lOhg7iTDc6lNmFxL8VK9j0TzL2HSq147VkXUGMeDoP3WiQJQsg5?=
 =?us-ascii?Q?E5tSUyZ+ggbjeA6CgbTPzMyxj7nRQcI9ukmI5GcBifhfc5HXfs7dPl3QaPdl?=
 =?us-ascii?Q?qCkpl3CfrAeSvYgcWfp5wU/+9WgXqk4Pdfiul9B37gXEAdx3jrybIykJzwJa?=
 =?us-ascii?Q?+WBW8bHCMKnBXT9clMBxqi3gIjkT16avdGVEcdbdVtNVPI+zZrHjUfKhNpEn?=
 =?us-ascii?Q?nIMmRuCjYbrkllQVu4XpKzd7hMaZ479NKo2xCMOJwu1EsAzscWXvUESr+yVl?=
 =?us-ascii?Q?j7DCN88MKvnckd8jlldBoJ5cB/aSQHNoLiyQZ2sboaq9Vzr6XGPIiGkh9mA/?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a1ce1-748a-4a3d-5f49-08dc70ebd1ee
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 12:22:12.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mit8+9gRHHhTkvUfCsGgBdRyKVLlzsBNuYTZl/9B9u2rHgOv4edQ9mFTclSYFcNx8qVzZTUODHMOjvYnbeJjZVxLc5vzKfBAPP2uR8KbyTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-Proofpoint-GUID: qveKmqpsfOP_yFjW8VfgBIdkRg4wzMfz
X-Proofpoint-ORIG-GUID: qveKmqpsfOP_yFjW8VfgBIdkRg4wzMfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100088

1. Pulling the mutex protecting the EST structure out to avoid
    clearing it during reinit/memset of the EST structure,and
    reacquire the mutex lock when doing this initialization. 

2. Moving the EST structure to a more logical location

v1 -> v2:
  - move the lock to struct plat_stmmacenet_data
v2 -> v3:
  - Add require the mutex lock for reinitialization
v3 -> v4
  - Move est and est lock to stmmac_priv as suggested by Serge
v4 -> v5
  - Submit it into two patches and add the Fixes tag

Xiaolei Wang (2):
  net: stmmac: move the EST lock to struct stmmac_priv
  net: stmmac: move the EST structure to struct stmmac_priv

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 +++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 58 +++++++++----------
 include/linux/stmmac.h                        |  2 -
 5 files changed, 56 insertions(+), 55 deletions(-)

-- 
2.25.1


