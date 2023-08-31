Return-Path: <netdev+bounces-31486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C64678E4BB
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3822281189
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACB111F;
	Thu, 31 Aug 2023 02:28:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8C10FA
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:28:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2106.outbound.protection.outlook.com [40.107.102.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23601BF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 19:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcbgZvfn9fwknR9W2rAs3clXb86VtyjnoDGIZJLPjwtnTQvJRSVhRRH+DzQxqL6Bb4bNbIdmHic/mFyUs4e/iYyWzaNGKxqSVh5jFa7W1rJ/rqJNbIVTqw9qk3GbRjBHMqYluwVEvD7iEU4A1+j0MCHObXBU9IsRwL/RCHHQkUWGZbRGEv893bR52oBjo9RwR239zI7Tq96FCfJWf5aINJD6FQlV27XECesWNT6zzq8t3X86WPur0O/8qaWWTtHTu8R8wxu3U+s/86aBy8Ugtuj6eD/LxpTWHUMpxUAwbQNGHC+T24BAjNsDBr2r4lltbi/gIDoCQH8Thrc5dnL/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J+pYX0gL9aJL/OSDo+w6qBPxjtK7gqbsxkhOLPQI1g=;
 b=iDjLd2Qz4M4+IY1oK65MEbD6yNvPoOvKe8YMkkV8SncnyxV/Y+5UPVt1/Ud4eARlBYB2TjVQPwLfahMb+Sci+DbWnkcg//56mU2VY24T54pUMuWPmaF3gh7/vMQAihztY6iJvb8CsmC4qyzr+c1yt3iuW00dTt/83nbuwI7ingTeUOaNzg6BeAfmyo1p19uf8kWWAuHFufwGehj+JOv5DcEzn9MhV0Vnw2Z2/g0crHG6BkQj5PCXSVedNHcIQCVNXMucMnDpi2omW2j4hT0Hf2sAeenWQ/EaoDwWfSVAJmZ2DTI8RX+2ug5hC4hycfnsO0VqFEmjEPZRTNZdqQXIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J+pYX0gL9aJL/OSDo+w6qBPxjtK7gqbsxkhOLPQI1g=;
 b=RgjdsM/CfKRfFgd2ShtwjkQ/gD1TXeYUaUSizl2XZqzBHTbGavDP0UDg1BvNGyGzZZwIshrbllqC2jo9x+VGbMLeGneIlTA/7dYhjws4w3R/ZJ8LL383gVfS726GpvEHLpmSpYcZlzt2zyDtJAko1cnt9enXEsQwFqlmKCUHQS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20)
 by MW4PR13MB5625.namprd13.prod.outlook.com (2603:10b6:303:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 02:28:36 +0000
Received: from CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::b55e:a0e2:c14f:55ad]) by CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::b55e:a0e2:c14f:55ad%5]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 02:28:36 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: mkubecek@suse.cz
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [PATCH ethtool] rxclass: fix a bug in rmgr when searching for empty slot
Date: Thu, 31 Aug 2023 10:28:06 +0800
Message-Id: <20230831022806.740733-1-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 2.39.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0151.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::8) To CH2PR13MB3702.namprd13.prod.outlook.com
 (2603:10b6:610:a1::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB3702:EE_|MW4PR13MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: df7edebe-2d56-4bed-33f1-08dba9c9fa23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xPsuEyfTH4NYAAETCojuO3bGHqCk3CkZtiOCQcJrosjPWLKlk/N9rlDWGZcC36US5cd8sEjhpwCKSmgAopg6uZMr39LpywKJDrgTy6RulrbAzcvv5SK7wmmFPyxsI2C9sei0/vXuP7G77n1Nb/zdj+GQDjL20NI9EacpO0heMgVUGO1DgnJJM/f/LuivQ1hKYdTWuKbof0N1sOkVTqZ8uo6UEZVdmT5HlnAYJL6abCwYCUvsGOuwGlSGRBDhmY3NTkQMu8ht/19x+Gd0grcWcxsDlrw+JOzew73B1LoxcOHT4hkJnnvTtpK3rrGR6R9Q1t7ENjvuBOyvgmRyrsQIJjfpmmrm0jrBMdjl3GWLvceJu7qNSJUQtLz/auQ5PxTdRP+1YzDGZWzLTnh6KtBD0cQ0NP8h2DCScwDtfDFUIvWqqwcul/qTWjAaBzjnDwHmmy0wOetd1cO8nZp5ZbfHNi8XYFiWlV26fF+xfIFXZNEy5wTgqZHr1aj9csMgIfmHIfKMDZ0P8xEbH/pSQbcB9lUOrvUZ0QGRNkwhypFqerQ+6zk/4vaVgt8ZYLuSjHjxQdq95M06wQi8Eymq1i2hJpBV+VyXH+21dPMcoHwjqi958BPkKG6jiWT+Kmi20DZHT1BPcVIby0BHIODkoas0XkWmNCZa5xkwPQsdiOwpaHcc6XSxj0ntQjwqCWK74iMW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3702.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39840400004)(346002)(366004)(451199024)(186009)(1800799009)(478600001)(36756003)(107886003)(44832011)(26005)(2906002)(41300700001)(5660300002)(8676002)(86362001)(1076003)(6486002)(316002)(2616005)(8936002)(6506007)(6512007)(83380400001)(66574015)(4326008)(6666004)(52116002)(6916009)(38350700002)(54906003)(66946007)(66556008)(38100700002)(66476007)(51383001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmdpeURZVmRJRVVUazBTSU5WNGdDMEpSaVdkdXhHZ1c5bjR5Wmh6TzdYK3Bh?=
 =?utf-8?B?Mm9Ja2FMYTRuWDJYcVBIYW1DTHU3OGJ5NFljNXJtRnNuV1JTTGs2ZkdNTFlT?=
 =?utf-8?B?Z3I3ckVNRzgzaHdleDJPa1BETGZURG1KK1VYdUtCT2ZmQkEzQWcrektyYSt4?=
 =?utf-8?B?ZXZJTmJGUkVBZjkxU0VpVXlrQndhQ0Uxc2szVklKNzFDWG1WWkdldytSY1NT?=
 =?utf-8?B?SllrSGVnb2tjSTdPTkVvcmJGcGJXejBzbEgwbDVJUTV2TFFLOXZiY2lkVUhj?=
 =?utf-8?B?dG1yeGlDRGZLUnljMzZjc0FvT0t0U2VwY3pBRVJKb2pabWpmWHpqbTU1cGRy?=
 =?utf-8?B?am1ydys3NXMyT1JkdllFdmFocmJ1cTFjcVY3V3VqZGpDeGd2djU2empxTzVx?=
 =?utf-8?B?TTNrQlZIM2xPZ2NFZlNlSHd5aGhlRHpEZHZaWHJJcXp3a2xuWlJDdHRpTjFM?=
 =?utf-8?B?MmtrQlBDaERQdW1uRnBNWHVZVHB1TU9TUWRIQXhKeXpRajJXMTZJdEttdjRk?=
 =?utf-8?B?UFcvN2VBNHlaKzZnL0V3UXdWbHA3Ykc1dzZwUkdrazFVTUJkaVNJV1JPSnU4?=
 =?utf-8?B?YnJrNnlXejl4MTBSYXlhVkgvN3R2d2pKeDNyZkxTaEw4TjRWRTBEOUhzbTBF?=
 =?utf-8?B?elRPMUQ2QnZDZllwK09ONmlrbVA3QTVYRG1NR0gwQ0VsTW1JWGk0dDlkcUZG?=
 =?utf-8?B?TWlpeWxlUVZTNkRyeEF3WmNKOHhHQUJBOXI5S3RMT2U1bjB2dDVlYnNJcXcx?=
 =?utf-8?B?ZXBKYS83eStjbzdIN2t0T1lkeXVqUWRuUlN2VEh0MGJQTVpqSTZCZGFIZHNP?=
 =?utf-8?B?ZHdDZWx6TmNIdGlURW5Rc1UzVUE2K0tFTmlZaUVqS3N3Y1dnckd1WWdtaU0x?=
 =?utf-8?B?UUFFZ0hmdldsMUZsMU5VRnJLcy9BSWRsT0d2dm1HaUR3RithR25XU2gwUVN6?=
 =?utf-8?B?STUwcHl3a2FmYXZjbERMY2lqU3BLTG1QSEJJejRoK05sSXpaU1lPSDB1OFJJ?=
 =?utf-8?B?Ym11UmFvZkxqK29VUzJIZStES3VUY281ZUxXaHVkV0dJQnpyVmdjcHNiU1d5?=
 =?utf-8?B?OXdjWlRpU2RYUzRPZUVXUFluT2xCckpuT3NvQWhPMElTWVN0Y25mcVkzc0pP?=
 =?utf-8?B?cmVXZWpReCt3cHI5QTUwWTFjQ2lUVm1Ec0F1aHZ6V2VrL25QdjgvWXd1VUF4?=
 =?utf-8?B?WDl2VDAzRFhwektpaU05bFpDNjgwQnZpb01xQ2VKN2k1cm5TU1RQaEhkWU04?=
 =?utf-8?B?VWZGdEV4QnRGZVdHYmRUQUpPWlpYQ2tpa05adDdqc3NkWElucCt5S3NHUkUw?=
 =?utf-8?B?MTZ0QTNGRjl3ZDY2dUYwM2RKMk5Wc1F2c3dUK3ZONFpRc0l0dXozeVZvaW1r?=
 =?utf-8?B?Q2NVdjRVU1Z0R2tmT0JQUi9oeUhKODRRZDkvdHB2eFlCZjV0K0JkOG56bXlq?=
 =?utf-8?B?ekNKMGx0QWhjRnBmMHFqenJ0VEF5R2ZoRXREREw0NURoSWhXMVJ4MStsVXZh?=
 =?utf-8?B?L2pCb2hJbkFnVUVvdTkrSFZPY2tUVVRBdnd6SkFJWTdFaU9SYVJGUnRqZXFv?=
 =?utf-8?B?WS9NaXdVdEJXLzAzbkd5RzE1MDZUemw5eTd2MUNTK1BBUnZqSjB0b0JteHQr?=
 =?utf-8?B?MmNkZC9VcXNiUDlsTkVGQXpYSEdlVmFZb1MxbGhLOElEZXZ3NXhneCtrdytT?=
 =?utf-8?B?R2twY2dLWXY2TXdIY2xCN0tBbmZWVW4zbERiVlhlTEZjbVQwaEs2WmpCWFBU?=
 =?utf-8?B?djEwRmxzc2o2aUpXTVQvYmZBYTJVbmUxVmEvd3RkY1k3c05yZ2FPdUx6TmlB?=
 =?utf-8?B?OXo4a3BUZnFlbCtWVi8yaUwwcU5uWHV1MkM5WDJNTE14WkJVY3hnNi94Qzkx?=
 =?utf-8?B?TkZqeU5hK0Viek12ZDhkMFZ0YXo3cHFKTFJ0bkdSRjdKb1BvS2JJOUNXTDMv?=
 =?utf-8?B?VUFqcUxBeXNKTVY2ZzBHQktEQ0YvbU1XUFFkMVVaU0didTMvZmRNYko4dXVw?=
 =?utf-8?B?Rks0ZGVMNUpaYnJ5SmNReVhTd2Z6R0wrVUZ0dHFQWWY0QktPMUNLUXpqQVJW?=
 =?utf-8?B?L2hjRlY3cG1kcUo0UUpLMGxPZnBmWTFhUXl3S1NxTnBNaG1CK1BjRS9NSUxt?=
 =?utf-8?B?elcyU2d3RHBiRjZCRFNDQVRjUllabVpxVHdzeDRDaTQrVTNrNXI5cGw0QXY5?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7edebe-2d56-4bed-33f1-08dba9c9fa23
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3702.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 02:28:35.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXSgt7IoH8UDVpWwaPakjrE5G1wQjfguf8mQgZJSPV8xOT8rMgiG3KStzdGqGC6Gn1QgZXN8SNvCDuXNQ/BWS1NfFNMbvCoTW255BhblBUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5625
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
Cc: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
---
 rxclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rxclass.c b/rxclass.c
index 66cf00ba7728..b2471f807d5d 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -446,7 +446,7 @@ static int rmgr_find_empty_slot(struct rmgr_ctrl *rmgr,
 	 * If loc rolls over it should be greater than or equal to rmgr->size
 	 * and as such we know we have reached the end of the list.
 	 */
-	if (!~(rmgr->slot[slot_num] | (~1UL << rmgr->size % BITS_PER_LONG))) {
+	if (!~(rmgr->slot[slot_num] | (~1UL << (rmgr->size - 1) % BITS_PER_LONG))) {
 		loc -= 1 + (loc % BITS_PER_LONG);
 		slot_num--;
 	}
-- 
2.39.3


