Return-Path: <netdev+bounces-31686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE478F8C3
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CC1C20B87
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EB6ABC;
	Fri,  1 Sep 2023 06:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462B28FA
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:53:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2096.outbound.protection.outlook.com [40.107.95.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AADE7E
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 23:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsxFRJaEch6+WoSRsAH7413MLoA7t0Wze/js1GcK7sQPisaGChDF1+sWDZpxuXK3EF7XmtoVHaCmU7mmma68AS/qd7t1I6CizO3XRmWrcbR/6TOzCsfKyBounX4i+UR/ym30LOxfp0YEFISpB4eTzb01Of7fRS/utVCtph648S5QS4jLpzYMztemfpKi1VSWvI8jmeLTRsDpDDX5/fRw4TSUi89JKmYGsa0vhUTmxXq3lYr6IVYUYCvkQ0tV1qQTeU4Fia/+jPQu9uzl5zSuuNzInf3ffWeTdNadWvhh5bU1V6P9bgUycigbyAuUZ9WMWOrwFlhJHJtkN7MiThIfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMZlEtU4CUD455S+oEOLklc5K2U0So64wiPHvqG2T5k=;
 b=Q2yBTdz6/ybRBH4MJD2GBv6PSDIKrZbDiDk1J9UkhiW9yWnyQ25mQJGOzFQLaEVhJpgojQy2FSiA7EKOY0ZHYX3vbWrxHNNcwpjla2rThIayqKautWQFcxuIix/GMjI8XzZCFXJMHBwabjnJ+l/1yO5pmOpVdGTCFF6EfPp320PkevpTE4IVpxzcFoH5v5v1we2S7HbMFf2avXfnGTErv49wBXBjlpNPjou/wZF1LObYogNPjGGO1phIGCW6ldM3nmctRU0Yi3hi2a8PyJPbkgbtINk8zXC954U0ygBeTI+svIMX1ar9JojoaYH2c3Dsecu4XpczOHAzVOgJ7VD/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMZlEtU4CUD455S+oEOLklc5K2U0So64wiPHvqG2T5k=;
 b=CRRXAWpyHvbU5U9rgsIfo2TZJPZWBBcWNAkz6VJ9CXBKeoUH8K2XcJTdcyMT1eLp9fwpeWo7obB0Pw9TAK+oc/kvERh+T+BLurOJos7LYgPf+q5HJANkhzvPUEswrlHpH9DRZ8NnbBtt9pUc+S6XmBoBRd+Zt/Y/rrpG0s+uYmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by CH0PR13MB5139.namprd13.prod.outlook.com (2603:10b6:610:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 06:53:21 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 06:53:21 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: mkubecek@suse.cz
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Alexander Duyck <alexanderduyck@meta.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [PATCH v2 ethtool] rxclass: fix a bug in rmgr when searching for empty slot
Date: Fri,  1 Sep 2023 14:52:03 +0800
Message-Id: <20230901065203.125150-1-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 2.39.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DM6PR13MB3705.namprd13.prod.outlook.com
 (2603:10b6:5:24c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB3705:EE_|CH0PR13MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ca52f-6a9a-4850-a6ac-08dbaab820eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jfEDLbaZivpXoEzrZZIW98OKGv2Xhyh7FQq1PmCwofTXqZ5WrsNTbUSPhF5woV8y+XJfhJszLxoc76W2Ff/sVhN7ERyLHg2LcAX3PdtfNkYt11NVWNS9AGIGLJYYlOrF6sqqXnpoZMVu6lBb0zisf/QXuGzsepe7SNWZhP2Yn+cBHEO7vV/thEpvAgUIE6YGbm4QLs3GZjzb6TmpiQs/Km2GbrFS7ipipgmNV9nDPwMkSFF55nDRZBZxrwwAxQl7+eN4FS7vCfZSCGkLwo6oYfW7ZxWkPNCLszwrckSo+1AA4x32FtYDxg8iQrjiI6Q9Dn1nq8zm3QDyHb+OzZHnhc8JYSPbFEYUa3p4uDStQmbYA26hAFWjoJ9jsZ5+cFdNnhHS/zcokWkVs+Fgdr8POyEDIXOjyrdRDZn/jlnW4P7+guwMsKka4iAN0Jx3CBa1TyLdVf4QAtdDoAhP1y+gDK/2NXzzM7U1dqF3xwEIbsI9b4DPifD9vC3H9rviuzlgqn63MmTzYx5w7JaKESVtKoqJeYTAzermhKPIVaWUj59ETvXKVDCw4Gwpt6PtuNLSorPU32F8/S8CAC5SlmP735V9E40f/tqKVih/caf5PBj02FbE3nuVYpmH6OzNzRwVz2YiNFtPAKbUckChtiBjWsBTSLQ8P9L/XfW15SOmpBuUAjw0SiQsvga693EiO0pN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39840400004)(136003)(376002)(1800799009)(186009)(451199024)(107886003)(26005)(44832011)(5660300002)(1076003)(6666004)(6916009)(316002)(86362001)(83380400001)(52116002)(38100700002)(66946007)(66476007)(38350700002)(54906003)(66556008)(6512007)(478600001)(41300700001)(66574015)(8936002)(8676002)(36756003)(4326008)(2616005)(6506007)(6486002)(2906002)(51383001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTZBSXRzRmdrL0F4SzNlNGJjTnFha21HcEFoaDNzSFRNVkROWEVSRlNGOHFW?=
 =?utf-8?B?c25RZGF0b0dxQTlRUkhWVENLaHV0TVlhWFVSM1FwdzhCN3RXaTBCcEd2MHZX?=
 =?utf-8?B?MjJqeGIyMUJIQlNLYWFDNDNFZzZHc25JZTdMUDJYV0JxYU9yc0hSZVEvK3JE?=
 =?utf-8?B?d0Y0TnhFM0lTeW5lbXRBMnFzNDF0U3BnU1BDMmpxKytldy85NXpTM3Jvc0xB?=
 =?utf-8?B?ck10dzBEc0U2b29yci9zYTZPQlZjNVRKdUpTMk1jWEVIN2hOSmlranNhVTdp?=
 =?utf-8?B?d2NLQ2IvNkRKZ3RReFVabjlCRE9rdXRDeWh3RmFQTTFHQ2dma1J6V2NzWnh0?=
 =?utf-8?B?blZMR1hWQUVZdkFHa1BwdEU1YjJFSmViUGI4bXY2SkFsaGpYR1k1NUZ5enJI?=
 =?utf-8?B?Q0l4Q1hsd3JnUjI1VkdYOXN1cExLYVU3dUIyQXg0czZsM2t2aUFWeXlpOVEv?=
 =?utf-8?B?cmVrRGVNTnM3OW9GSklkMmdPckkrT0RBTDRHTjdXMnlsUnFnTnhKUjdDOTA2?=
 =?utf-8?B?MDZqUDMvbys3bEdadXJPYjRFajlwMnpiNDR4WTUxbzhsYy9ZNDVtVm1Cc2VD?=
 =?utf-8?B?WXVOYUg1S3lXQ0Z6aVVkWUx3bkxUaHdQT21sZ05ESzkzWHhhemcvN2hjbFZo?=
 =?utf-8?B?elZtVEtwTDhyZ3IyL3lqaG0zQXB1MTMwY21vMC9TdU15TS9veTdGNkV4d3Bw?=
 =?utf-8?B?UGo0emdwVlpmb01uOUM4NkpSNnBHSCtyVjVobWgzWjhRSlljMEFDaENLOXZW?=
 =?utf-8?B?bHpGTGhkNWtmVGJsUjRnVW5VUzQ1Sy9GNTVUSHh0N1VRaG1ObC8zZ3pra2t0?=
 =?utf-8?B?UnI4SnNwVlFKUk5xcFpQdnltZ2ExQ0ZaQ2VuMFBQdlZPUkxXV2tCTGdmK3dT?=
 =?utf-8?B?WUlYNUtialQ1ak12SlEvbTJMV05ZWDR4YnJDTjcvZGtQY283TXArN1NXOWk1?=
 =?utf-8?B?SmV3NlFiRzZzcEJKOG5wQm5WeEdldC9aS3VoeVdZSjRxR1ROVGhUMUJFNi8v?=
 =?utf-8?B?MWZ2U2w3Y3lrWkVTKzY5d3p5aHNxU1E1RTUvL1hCS0RUVlNsbTdQaEtFUEZt?=
 =?utf-8?B?NG1vbVpKbE9OVUFTd0JMUFhaeStMSENDRkJLWTBlV2N0ZzlMZVN5c3U5UEZl?=
 =?utf-8?B?ZlNaZlRTc0ZUZzh3MDFFR0ZVTzVPR3N1dXhVM3psK085T3hsanA3WEtndDNJ?=
 =?utf-8?B?Nm9XYm5YblNHeWVCak13SVJ1a2FzS0ZRN2duY1h6dzNTYUZjcHR3TE4wb1lL?=
 =?utf-8?B?YndpMEZmbWd4bUVQbTRKVUVFOXQxY2o0WEVDaE1aWXlMNWw2dHk4RTB5OUJx?=
 =?utf-8?B?eGtINU50R0ZEVGVnOVduSXYyVnJ3bjVicUVsTjdOUTF1aVZ2eGZOSUY5N1Fr?=
 =?utf-8?B?WSt6cmR4Z2ZpSU4xTnQ5Z0NRZ0I4ejZHZHAxRDErTXBVOFMvb3F6bkZCaXd3?=
 =?utf-8?B?bk15RDFhWkZjcGovRlpJaEp1MlpMRUE1Tk8wTytzM1JDOWFGdUlXd0wxNDV5?=
 =?utf-8?B?a2tWemtHZmRZM21JRmZtTnRiZ2dnOU1FcWY2NHNYN1U2RkVvcHpwZXdsV2M3?=
 =?utf-8?B?NEVxV2o3NC82cWRBMlJwZGlQSkFHY1dBbUpjczdFekR2VUNoQVBOWG5kRnVG?=
 =?utf-8?B?cjAvVWtkRkoxK0MwMkJZMUVKT1ZMM1RPZ3NYeThkQ2g5RzJUZHRuY29vUVlJ?=
 =?utf-8?B?bnE1QkJwU2U5VmUxdjFDSGxnK2svQUNlLzMxWW82NFZzTVAvYndabEgwL24y?=
 =?utf-8?B?d1BmbjNtSkhyTDBkOXdCTG9YZHR1OE9vbUo1a0VoN2ZMcTBrdlRQK2hQOHFU?=
 =?utf-8?B?eWViZTN4L2Uzem1wcXkwZ3d5R0lhK1lhM04vZi8zMlREV3VETTBqSDlPcWJO?=
 =?utf-8?B?Umw3TWZObC9qbkVlWmNnazFwOTRzb3dTMkthcmV1OEtjT21EKzBBdmVuZ2lV?=
 =?utf-8?B?OVhPd2lsN09ZKzlSZmxaU3E3R29yRlAyUnF6NW1tMkFTaFB3NHJnZ1pYQjhr?=
 =?utf-8?B?aHhwWDloei90SkFWTG5wNjBhdXh4RkZjVmZiMUZwZWZ3alk5VmZLZ1BhdElR?=
 =?utf-8?B?VUNpZnkyb2VmYVAxdURWbTJRZUVzM3pjci9MdmwwNTJxTUs0K0VUWDdvR0hi?=
 =?utf-8?B?WGtqUCtvVHdDOFZ4aHI0RFVjdTlPYTJmdnZDcURkazk0RTNDTUNTSUpJTTlH?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ca52f-6a9a-4850-a6ac-08dbaab820eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:53:20.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7slS6WI2Tkf/xizNNrPMVi6hFG1CvN68qOY334BgPG+Zcfdk/ud43kAa/BiasHMiUYwdRp3DCsmh41ipS5dJG/d9dKspuDqiJZBuE4yJOoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5139
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When reverse searching the list in rmgr for a free location the last
slot (first slot searched) in the list needs special care as it might
not span the full word length. This is done by building a bit-mask
covering the not-active parts of the last word and using that to judge
if there is a free location in the last word or not. Once that is known
searching in the last slot, or to skip it, can be done by the same
algorithm as for the other slots in the list.

There is a bug in creating the bit-mask for the non-active parts of the
last slot where the 0-indexed nature of bit addressing is not taken into
account when shifting. This leads to a one-off bug, fix it.

Fixes: 8d63f72ccdcb ("Add RX packet classification interface")
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Alexander Duyck <alexanderduyck@meta.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
---
Change since v1:
Use `loc` instead of `rmgr->size - 1` as suggested by Alexander.
---
 rxclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rxclass.c b/rxclass.c
index 66cf00ba7728..f17e3a5124c0 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -446,7 +446,7 @@ static int rmgr_find_empty_slot(struct rmgr_ctrl *rmgr,
 	 * If loc rolls over it should be greater than or equal to rmgr->size
 	 * and as such we know we have reached the end of the list.
 	 */
-	if (!~(rmgr->slot[slot_num] | (~1UL << rmgr->size % BITS_PER_LONG))) {
+	if (!~(rmgr->slot[slot_num] | (~1UL << loc % BITS_PER_LONG))) {
 		loc -= 1 + (loc % BITS_PER_LONG);
 		slot_num--;
 	}
-- 
2.39.3


