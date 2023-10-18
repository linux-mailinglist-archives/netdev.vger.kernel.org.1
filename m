Return-Path: <netdev+bounces-42075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB37CD13F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C298FB20F6C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F710631;
	Wed, 18 Oct 2023 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IWK15Mc8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F65625
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:25:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A5BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 17:25:15 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHmiTs025938
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 17:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=s2048-2021-q4;
 bh=vs2+hoy8D85D3cdxiebJehr5xhvZisFJeOdYC3rbOXo=;
 b=IWK15Mc8IcF07gKGjaaL8Hzgq5bYHUOnuxCH0kdawtso6jsO8yl6OtQEmWDU7LuyhjMg
 6Kt0Jhh5Yl3HC85npc6h2/TtZWUDCknnvDKjlYScEl5ZqhUfafEndtlQZ/VxDmDNiMjY
 dIDwi4iIRvuV3/n3gzA3R0Rah+fnh1HxZv1tjbjX+zTAmo3x6h8eOcEyLkUQtLIux5pC
 XFZ2uS9/qL1C1C11Xkx1U+63Wfa6lTnvTZQXNpK0V89xhfeiQL2mhMn1H5Uk85tdwqQk
 sXBz9K3fQxDy/aQYigp49avuCzTtzLK7fX1sBmpgWWXUsjchrb9EjM3aJkmfqiI/ue+9 Jg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80pubey-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 17:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkH1yCOaV9SvOb4MQF/2/3Kc/d0lopEss/CKJBFzcxbVx//tsJZ8o2jWJW5g7CVFbSKLdVxU1UwMrxmALZSGOWvIfu6UdLg2MjmJmKHXYQfAI9HiMVvPxZc+wlzspGXPqB8JLBxmovRFbmtGnHoCg3U2t1J9FbXI6EVZGZte9lkHvs/11/sdx9takWsbBMYqaPm4oYRaW5n9hliumM0sgtHZ/qArzi/Ukks6/mRLwJpV6K8avY3vmnUcHlDdn/Uo8/FgVVI8w01kFNmEI+xflFro32bCJMzSNRzRKkaSVSeb9DgXisFM/ocaw9wiQJng4rFO32xMrz+ciVKl/Rp/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs2+hoy8D85D3cdxiebJehr5xhvZisFJeOdYC3rbOXo=;
 b=leKYPFi7bHLG97+9qIyXE2fdhEG0lot3Ii3H8lCpzZd3qkPGuvNvi6HEJr8YJpo5ni2iVV2s/nt/idc9sNSuQH07vYFtgr93qOEUrt5ROHuUVz1BjOnR+S9HiGcypIFTo7vcgmFVOIq0PbqIM3QsvC+O3cPPcaT3zrWE2SedogHVXmDE2Q9Ilt25ZUBNRxo5ooIR1Mie8RzUvQnZy+dkhZFgC4wXe5mpyl9du6UYIZjn1TCdQt6Zsh2u7xuRL3ZnRH4FKo1w9tFQAVWdi2OtKeol+zWms/iULsjs79uAXG2nW0xHf0+EVJccHoZvlK8WcIyCU2iHEIK5sJAswvtFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3874.namprd15.prod.outlook.com (2603:10b6:208:272::10)
 by DS7PR15MB5910.namprd15.prod.outlook.com (2603:10b6:8:d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 00:24:49 +0000
Received: from BLAPR15MB3874.namprd15.prod.outlook.com
 ([fe80::fac5:53e:eda8:1401]) by BLAPR15MB3874.namprd15.prod.outlook.com
 ([fe80::fac5:53e:eda8:1401%2]) with mapi id 15.20.6886.037; Wed, 18 Oct 2023
 00:24:48 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Martin Lau <kafai@meta.com>, Jakub Kicinski <kuba@kernel.org>,
        Pavan
 Chebbi <pavan.chebbi@broadcom.com>,
        Andy Gospodarek
	<andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
CC: Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v4] bnxt_en: reset PHC frequency in free-running mode
Thread-Topic: [PATCH net v4] bnxt_en: reset PHC frequency in free-running mode
Thread-Index: AQHaAVheSyoB9HP2lEGrYYLgesHqCrBOr+hP
Date: Wed, 18 Oct 2023 00:24:48 +0000
Message-ID: 
 <BLAPR15MB387451EC7A310DBFF0920A99BCD5A@BLAPR15MB3874.namprd15.prod.outlook.com>
References: <20231018001630.1064001-1-vadfed@meta.com>
In-Reply-To: <20231018001630.1064001-1-vadfed@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB3874:EE_|DS7PR15MB5910:EE_
x-ms-office365-filtering-correlation-id: 49803c6c-9c37-420d-9a8b-08dbcf70a370
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o1Y2fn36kOtLXIMqMJOUUS2/mpBjpWtytudgVMqvpkd171AzNM5XVJOMKaw76uOWrKEXtXhk6NVHaDRWFE1QYt0PKCQ3K3mtZtoDQK54Ed1BwjodJSwA83EOXk21RoASZAZAUcfKfb5C+haNGL3eLC2hJdFtxQV7YUlZWacNG0tPj+/YUr73qla0Y9bLJzaW1N09hM25PmxbQq0/eEuX/SM0MjBT1eKU2uOsm5tIh132w7QQ886TT4SH9PEHkHuxAt0YbDlRqkS0QrH38i17lgjnFvVxQH+jeVhv03PnCAnKDTHI5s3MPwHkHD5DNHpqXP9elC8BfV2FGslnhaL8IXCvWCcuqUzGB3a76g21PKW6uUJNMNokXZ16empkDr45vZBlcG+wealff6SDFU2lLurYvUw8e6x4wgoHzIP/fS2hsbw0tfsLWkZVXWbBydpW8AJdBYVI5AExmbqLwDczvhYjFX5PizMuig4bEgJRQot2M/f2g6m9SwWCKYLOOGtE7sXzBw7jLQ839CGZrRf6kiIW5tV32Ud0RWoBlYOXr0XpWDJ7ph4xcLx3hJZ/TsbqVlFfQlnrLH0F3D1TjLR57nssNa1dAdbx/X7Lc7SqguBCos1yUOXYdoooy1VXAZi+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3874.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(66446008)(66476007)(66556008)(64756008)(478600001)(66946007)(110136005)(54906003)(76116006)(91956017)(53546011)(6506007)(7696005)(38070700005)(33656002)(9686003)(316002)(5660300002)(8676002)(52536014)(4326008)(8936002)(2906002)(122000001)(38100700002)(83380400001)(71200400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZlW64jNyMvqg3TwDs6TuoqweYlPIX5xZoBv1Z0JqzI/4yROMgt8O8XWPW+i7?=
 =?us-ascii?Q?eLRlTSUpkJTDakXMM20/UPtPRRum3BqEGXQl0+/O7tIvNrdKX6Sd4r2tf3qQ?=
 =?us-ascii?Q?KLN2sYkM0yNvmlHMcSzc4y5QLbX6aiXWG/ZwToC7zBSl1yydnv0oVahiVnaU?=
 =?us-ascii?Q?xxpUTUTxWlW7Ko+u2dinYBGQ6jWg/EE6+C6vKdQztgKiUOvyK7xMffVCfO30?=
 =?us-ascii?Q?9dfwGAc+zOe4QWtx2sBFxJ0yMCcmB7aXzCgmNG6PhePG8lkivnwPFWCAgpWU?=
 =?us-ascii?Q?Y/Z52D7uZ+gifCVHjrH7sLYqUtioi8L4bZ8T5iytJ+c4wQZqQlP2lXwMKI1i?=
 =?us-ascii?Q?bh+jXn885ajIfnzufg8J4riW+nGzzU/sGvJNNNqo1zs4hRlSGVHZbDUd4blJ?=
 =?us-ascii?Q?czbov/q5dEa5P/Beifd3uSGdDW4JlJVKu1YApDgDVfukhTgmummysIGGgLNw?=
 =?us-ascii?Q?6G8U09si6Z82BKGr85WUDEixrXR+AVdBPIM7evvhc77B45NT6Rki0cMqOoJX?=
 =?us-ascii?Q?eKDvVw9j8OV4GgprNLoqm22p4jN9Q664wlP8H0x7ZC3AsGr0wGrMQbYFllBG?=
 =?us-ascii?Q?ZxutKWdeRvy4VMrUbNzN5B1YwDLwxFGEbjfwZ2JPwz8BMukdB/K8AIPF41sG?=
 =?us-ascii?Q?Ztf7BU1iYt8Gq3tMS45TItrCsrFYQc5RNVDhCdRVhtp8vrhLQmljD5F8vkhV?=
 =?us-ascii?Q?3ThYw3KsOOKtt0pvb/zqT8debFgNDfwB3NBsZ0d0ijVhrVl+cUueLDrylWGd?=
 =?us-ascii?Q?8PFods6vIQQNLvvxr+S2PBN2CuZ82l02LtNnSj5O6Pi4xKBJ9TWC04LDqyXI?=
 =?us-ascii?Q?s4endodbPhOqsY5UW2C8koaeRfqdimp4PeTolt6BDnxpRcdrdaIIo2UObqVZ?=
 =?us-ascii?Q?wUEDYfjUHwek7hfpXXM9jSkS1/gbJFiPVm30ZDXgCv3CwfwfQT1t9fkh74VB?=
 =?us-ascii?Q?ksR3JOLqNZaOAEqDTyISiy5s3Fc+NdIaZAOqXw0N1Na1RGwdHI/nB0uUbnkb?=
 =?us-ascii?Q?QtUFWAr71RZJa6wpQPo0l3BjGmdBglLIBUWQk2A7Ngva6JNahexcDvHD2GLq?=
 =?us-ascii?Q?Twd7MDIK79FdVurw20gOvBJTIaE6olldgtwBxx4iapV4yss6OdQsrfw/yEet?=
 =?us-ascii?Q?qbGBu2UfKAcYpwcqdW/xMDsJvs5olGsd5w4sF78J6+J8Y5ZnLKaYo52/9YmD?=
 =?us-ascii?Q?0Qn3GhlN97qzYSZzeDhvu0ZFI/Z+tEd1D7jlmD52bIqvEREKuqmQazzmNcq/?=
 =?us-ascii?Q?e/bfUo3e1Gakt0yYku1Pi7hbaB9KH3rGb9I10VowTaHcmFjIY/a+6uuMkySS?=
 =?us-ascii?Q?dWUGwsVa3cRJSPBCQ4l/pdqR14gqGMEuFD7rNnD8veCbUvFAhqWh6jKE/KFO?=
 =?us-ascii?Q?2g4ognasO5ZqMMz8wVwfit1+wO7E1UCoha3vOYDVw50aVZ2sz6lwVsvjbdao?=
 =?us-ascii?Q?7MpvsqiAkkmWK5Z9sOR829wBg+2++yD4NQXVj9R5cVvQnz7345AN32xnumzS?=
 =?us-ascii?Q?iEcErLOcDoBdnfgykRUyNrNijQN7HWLJ/bhOFcAei/4hIT3+QShUa7StIUXi?=
 =?us-ascii?Q?5TOqkFUlHLs9NzlOnvF6aI//IdXBBobCz7tV1GwP0sF3UxFvh0yK8tHMzRIh?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3874.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49803c6c-9c37-420d-9a8b-08dbcf70a370
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 00:24:48.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Coc27K5EOk2Ei1k/B6DyLaAabkAfpY+jK6oSwy7JbxcRYGaM+xrd2C5DwUpU+iHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5910
X-Proofpoint-GUID: FEJXQlwL_qKmX3KMRao69fj0qnnjxa-S
X-Proofpoint-ORIG-GUID: FEJXQlwL_qKmX3KMRao69fj0qnnjxa-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please, disregard this patch, it was already applied, I sent again by mistake.
Sorry for the noise.

________________________________________
From: Vadim Fedorenko <vadfed@meta.com>
Sent: 18 October 2023 01:16
To: Martin Lau; Jakub Kicinski; Pavan Chebbi; Andy Gospodarek; Michael Chan
Cc: Vadim Fedorenko; Richard Cochran; Vadim Fedorenko; netdev@vger.kernel.org
Subject: [PATCH net v4] bnxt_en: reset PHC frequency in free-running mode

When using a PHC in shared between multiple hosts, the previous
frequency value may not be reset and could lead to host being unable to
compensate the offset with timecounter adjustments. To avoid such state
reset the hardware frequency of PHC to zero on init. Some refactoring is
needed to make code readable.

Fixes: 85036aee1938 ("bnxt_en: Add a non-real time mode to access NIC clock")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 56 ++++++++++---------
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 808236dc898b..e2e2c986c82b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6990,11 +6990,9 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
                if (flags & FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED)
                        bp->fw_cap |= BNXT_FW_CAP_DCBX_AGENT;
        }
-       if (BNXT_PF(bp) && (flags & FUNC_QCFG_RESP_FLAGS_MULTI_HOST)) {
+       if (BNXT_PF(bp) && (flags & FUNC_QCFG_RESP_FLAGS_MULTI_HOST))
                bp->flags |= BNXT_FLAG_MULTI_HOST;
-               if (bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
-                       bp->fw_cap &= ~BNXT_FW_CAP_PTP_RTC;
-       }
+
        if (flags & FUNC_QCFG_RESP_FLAGS_RING_MONITOR_ENABLED)
                bp->fw_cap |= BNXT_FW_CAP_RING_MONITOR;

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dcb09fbe4007..c0628ac1b798 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2000,6 +2000,8 @@ struct bnxt {
        u32                     fw_dbg_cap;

 #define BNXT_NEW_RM(bp)                ((bp)->fw_cap & BNXT_FW_CAP_NEW_RM)
+#define BNXT_PTP_USE_RTC(bp)   (!BNXT_MH(bp) && \
+                                ((bp)->fw_cap & BNXT_FW_CAP_PTP_RTC))
        u32                     hwrm_spec_code;
        u16                     hwrm_cmd_seq;
        u16                     hwrm_cmd_kong_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 4ec8bba18cdd..a3a3978a4d1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -63,7 +63,7 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
                                                ptp_info);
        u64 ns = timespec64_to_ns(ts);

-       if (ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
+       if (BNXT_PTP_USE_RTC(ptp->bp))
                return bnxt_ptp_cfg_settime(ptp->bp, ns);

        spin_lock_bh(&ptp->ptp_lock);
@@ -196,7 +196,7 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
        struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
                                                ptp_info);

-       if (ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
+       if (BNXT_PTP_USE_RTC(ptp->bp))
                return bnxt_ptp_adjphc(ptp, delta);

        spin_lock_bh(&ptp->ptp_lock);
@@ -205,34 +205,39 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
        return 0;
 }

+static int bnxt_ptp_adjfine_rtc(struct bnxt *bp, long scaled_ppm)
+{
+       s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
+       struct hwrm_port_mac_cfg_input *req;
+       int rc;
+
+       rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG);
+       if (rc)
+               return rc;
+
+       req->ptp_freq_adj_ppb = cpu_to_le32(ppb);
+       req->enables = cpu_to_le32(PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB);
+       rc = hwrm_req_send(bp, req);
+       if (rc)
+               netdev_err(bp->dev,
+                          "ptp adjfine failed. rc = %d\n", rc);
+       return rc;
+}
+
 static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 {
        struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
                                                ptp_info);
-       struct hwrm_port_mac_cfg_input *req;
        struct bnxt *bp = ptp->bp;
-       int rc = 0;

-       if (!(ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)) {
-               spin_lock_bh(&ptp->ptp_lock);
-               timecounter_read(&ptp->tc);
-               ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-               spin_unlock_bh(&ptp->ptp_lock);
-       } else {
-               s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
-
-               rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG);
-               if (rc)
-                       return rc;
+       if (BNXT_PTP_USE_RTC(bp))
+               return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);

-               req->ptp_freq_adj_ppb = cpu_to_le32(ppb);
-               req->enables = cpu_to_le32(PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB);
-               rc = hwrm_req_send(ptp->bp, req);
-               if (rc)
-                       netdev_err(ptp->bp->dev,
-                                  "ptp adjfine failed. rc = %d\n", rc);
-       }
-       return rc;
+       spin_lock_bh(&ptp->ptp_lock);
+       timecounter_read(&ptp->tc);
+       ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
+       spin_unlock_bh(&ptp->ptp_lock);
+       return 0;
 }

 void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
@@ -879,7 +884,7 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
        u64 ns;
        int rc;

-       if (!bp->ptp_cfg || !(bp->fw_cap & BNXT_FW_CAP_PTP_RTC))
+       if (!bp->ptp_cfg || !BNXT_PTP_USE_RTC(bp))
                return -ENODEV;

        if (!phc_cfg) {
@@ -932,13 +937,14 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
        atomic_set(&ptp->tx_avail, BNXT_MAX_TX_TS);
        spin_lock_init(&ptp->ptp_lock);

-       if (bp->fw_cap & BNXT_FW_CAP_PTP_RTC) {
+       if (BNXT_PTP_USE_RTC(bp)) {
                bnxt_ptp_timecounter_init(bp, false);
                rc = bnxt_ptp_init_rtc(bp, phc_cfg);
                if (rc)
                        goto out;
        } else {
                bnxt_ptp_timecounter_init(bp, true);
+               bnxt_ptp_adjfine_rtc(bp, 0);
        }

        ptp->ptp_info = bnxt_ptp_caps;
--
2.34.1


