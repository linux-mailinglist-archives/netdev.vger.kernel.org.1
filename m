Return-Path: <netdev+bounces-29469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9A783616
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5041C209DF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A314A96;
	Mon, 21 Aug 2023 23:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D246B2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:06:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C252131
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIQJbFfQy8U4fDCTOvGeQ7SmGyIV9PdZuKiAic6Xw4SHH8mnFl/0lPjeIs6xsvfdLWRBEZtakFUyfcntRHoZR+xDxcnUSsWp5meBmrkYJWDVUwpk8XiGLqjmL42HxANmiDPr2OWw64JnABo6XB5jm9nNFejb7MZIB3PIO6WAmrYzJ5C3S2dyQZohqhSw9Ll0SZX/QyLL+A5b1NsgcgqRvm7p0rhepxYAkvNmAgJxMFLtUTYBklg9gKpkjHBtG3STPGujU4BiRFU8+WfmpHcY/nJzLccrtGzEK1/JhkFFkJiq/LE/talFZKzIUZaIhfSTiEp8iu4h4Y3X6BabCHHoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMyZ6ig7LmLfaCI8ETImc4aHebegF1N1O2o9Ws4c2H4=;
 b=aLYGMfM/NoGIjIbl/tWZk5F+N8mYJfBBjtJ2To0We8PF5mIQK+/P8iecBdOek6Ey45iaVuONa0R9XtZQ9yYsVr/96TRYV6Ba/77mdgNVd1avLS097TMW16EvyJIbdb3fTpa7Z3ZI7gSAd+K7xCecKjGfYZ4yzDSzyg4ga8UB59I7vwn2KsF2Oj+f6/ySyK6rvc6eriJ7rrfuWhg8B8j60dYI4XqPGK+g3nQVWLGm5m+GurmfE5Bx4FQSMnFv9vo0quximSUaMGjnpxsx2O3luxEsgwrpxGK9wNY2k3r2s5GliSOpzrnc8b8sS9NajHsofbkE7L1TGspNTtDj+BT3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMyZ6ig7LmLfaCI8ETImc4aHebegF1N1O2o9Ws4c2H4=;
 b=CVyTXdw2OD9RuiNTQwAYgz6IDNEWObUWA12BOuiBBKGKVIX8jJ0RNvBWiafSEHK5MjvzsUFnVK0N1X/+RIWIra/rvpnl54aDFXOzfqQVo0o6fRmnnjHgxD+5Akiex8eTuhZv5HucGt0Z+HSGdw434OGaX3jHIHhecSHhLYGhQ9mV8MpxG964Vz7FnAJ+V0k+JceTG5+7q+G8bBh7xR6cedEMTdsWcf6XViR4FE3zK/9QqDGesT5FWg/GXXF50o3Q4MyhioDj4HNbDMeszw3T/22eVc4YMZ7+i35xPP+17N8TSfKDOq5rEFUibfODDt9AoqJcVb0TXmIWiowfihuHhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:06:54 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:06:53 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeed@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Kenneth Klette Jonassen <kenneth.jonassen@bridgetech.tv>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock
Date: Mon, 21 Aug 2023 16:05:54 -0700
Message-Id: <20230821230554.236210-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6ac429-ad12-4686-a3a6-08dba29b4ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PWqoXL88Vvw0INPIrawClTHPs1+pwzLthkyZ2kkzigSWL5S++ek5kXNb6k9o+wg652ew4pO9vk0ESlZGB1P8vmI56wUFsTLNY0qhMW5x8TARQ9jefF/LvlVwM4Sjq5keRYmOxnWRUYFr3dJjKXMAN2jTWf1u3leETg+51S5NGAC0rQ0qPfptOOWj4pEPIlWXN1cBcjrN1NbT4oK28EWT1TczbIFGZLuyz6Yx4+E2m6aw9VWgNHJOc9Y4rfE+2Agl2ilauMKiJsfV62zsZb2edi9/ZmOM19VR0fCc2GTxzJSwTYDsHw4qmseQFmny9SwXK67pjH0jUoSeT2fqQ0MngI2m+AUYYczh3xWulPHFR66DD/Oi6JSO8MXGk1DIHrs9IGP2QCbnWZU6GhPjCW9yXMgow9iFayeyipOBsFq1EBSzoe7ARinA2rx08Do3TEfy2Xs2EsOKSHaQlCIBHZWU3XtxOuxhySD79Wp2yMnH7QwHfgGFCoPsHw8Q2bC2sZUAPTsVPLaZXM+5pfu9gYoArrAZqwtLiXhrRACZ07LjehQCAG34p6EwHr2eS8b2direhG96q3DfUSvvQfR9GU1ODI8i7jPaXW+nQGkY5Q6NTfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(6486002)(6506007)(38100700002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(107886003)(4326008)(316002)(6512007)(66476007)(54906003)(66556008)(66946007)(6916009)(966005)(478600001)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0D/ObC8ze0IdbbpQ83Vzz4ft03tqZI4DqJLd9erQ456BeejYr2voC68rBvVe?=
 =?us-ascii?Q?HJ50cCnyFFi6K5P4M+5cMM2DhEbORSd8w4ea/+EQunN+Bfl7Ez5zx3zpi8S4?=
 =?us-ascii?Q?Z8sF3gymof/++D9kN/pPLVXRRL0MKMV/zG6XPt653vBe+7CLs6vDkpRaRUDk?=
 =?us-ascii?Q?SjsKItC4ZV2UFomb9TRJn96kvhAjpOJ/DFtt8dwJ4nfd5GMepuZ0+sCFsIuO?=
 =?us-ascii?Q?lbKMuIUkcAkx3AOCPIKGsvz3rAijQNPEysfWKCawLdQK+FTZ/cTDIpf/+pKu?=
 =?us-ascii?Q?bJiZXtHn/rabQlCa+FyVYHMprTNmbLNTXJia7qyifjyjP8l5qRLaMYvB4vY4?=
 =?us-ascii?Q?26j0kJbMlmrxALIvwhe4adX7gUFsDzbbCltw/b7zOOiOJc6Z6lioQQIK3Pet?=
 =?us-ascii?Q?+7OzBnICN3jLtADwkH55/+PhfZh3aSvOpdpEXst9IqPh10MU0UWGzRF7j1Se?=
 =?us-ascii?Q?4iw1aO9J+nN4qgwaOIetQ7rlmIyf4QPZuWjQfSQZUWpqo+eV38eEYlOlEoG3?=
 =?us-ascii?Q?BpqpwJ5k+X1U19PC1CLGHTn7dJX4p3nWyxeBG+a/Co4Bi1DaDE6b2L8mZilh?=
 =?us-ascii?Q?fgxN9DxkzcbM+GnVekLwW97FuCILZMYiY0Vf+QlQN3F2OVEUBA4ZKDUjLTut?=
 =?us-ascii?Q?FJNx/fo69MoHAVyRJV4Jyla7Mc7QrvYd1gaHVKoNNaY8tj2wgR1v4astAdgV?=
 =?us-ascii?Q?ep5g1t0Lh7oNjpAPW6gRx0QV12eEQkJpjOAdIJrelWrvyaMij2nRe6Yv2tQm?=
 =?us-ascii?Q?wd64pncupYpm/F7x3iEO0YNX6vn67sRoHSoI3+7O/oZ+4KIlkakMrNhOI2Km?=
 =?us-ascii?Q?hdFZdWasrn/38js4Z+1qtGe56QGSSnO2iNRxKss45x69ca0jTKpWgKsnCxKT?=
 =?us-ascii?Q?dJ/+lRkEdAUX2xlQB2PI+7Jm0sEHB5ce9cCl7ahppMisxx8SHThwGQ3ot3nd?=
 =?us-ascii?Q?SHCCaUo28h0jqoedSVJwk1mHTUeAsDLgRfMfMS35ot+ohEMhCYGVGL4WNCe1?=
 =?us-ascii?Q?GrkyMlrzk6KnhS0uAZuMY5HDaN8x2pid58egJDK3BhRu0yXxP8PRTUxLavAs?=
 =?us-ascii?Q?9NKeLk1SbzWxqDQ8C7F/w+gAyO6oWIy1IXxCATIbaH310AUZ17FELC/CVtdM?=
 =?us-ascii?Q?aDOTjgVOjElmIpPBExBPs4X78Aq06wVcBgNks4YpFcDKAK+wcDkxX+e1tC0q?=
 =?us-ascii?Q?PkX8KTZUa1bWoEJyIyuRgWo3MOzmDhTGbQsWL9L9TR78CPYtcOtI0t+UIV7h?=
 =?us-ascii?Q?UFNn0sx3meGlarS8KyYxVvkss6IVw9IYzp8FZSQ+XqXCRv+5QOEwFSnDPf8T?=
 =?us-ascii?Q?JhdK9jaP4FYHPtoN3isXaqAaQI523PGRjuDFXj4ozi5MbU+ru5yW1ffKoiy4?=
 =?us-ascii?Q?sSeBQZDExhRfPxXFiEHUblt11He2zMaljLKU/ZFlYSwcrTSi0w91LBJvP5iS?=
 =?us-ascii?Q?iM8/bhdT+eG0xGyLzRaC+Pkog98o5UzcfB/WTI8DC3++25YqaVLoBAOUxlfd?=
 =?us-ascii?Q?3gSVqJhwzYZEFW18y7CvSX/lDWhsuT0RHDHOcKHwuesZKlmHhQu0iZozH6tK?=
 =?us-ascii?Q?EMjSDGt8zjb4o67FtYDti9oP6cIIt6Zlu5IlmLyX4RyETPVApAVT7eWTyrw4?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6ac429-ad12-4686-a3a6-08dba29b4ef8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:06:53.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIRC3drCOpZl0Jp2wIYolwJ00seBjJWgLPLmzWQVbxwcgKvOeie/CmUvQYUSn/Rt0qQx9i97gxXAxipEULQQsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use a dynamic calculation to determine the shift value for the internal
timer cyclecounter that will lead to the highest precision frequency
adjustments. Previously used a constant for the shift value assuming all
devices supported by the driver had a nominal frequency of 1GHz. However,
there are devices that operate at different frequencies. The previous shift
value constant would break the PHC functionality for those devices.

Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---

Notes:
    Devices tested on:
    
      * ConnectX 4
      * ConnectX 4-Lx
      * ConnectX 5
      * ConnectX 6
      * ConnectX 6-Dx
      * ConnectX 7

 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 377372f0578a..aa29f09e8356 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -32,16 +32,13 @@
 
 #include <linux/clocksource.h>
 #include <linux/highmem.h>
+#include <linux/log2.h>
 #include <linux/ptp_clock_kernel.h>
 #include <rdma/mlx5-abi.h>
 #include "lib/eq.h"
 #include "en.h"
 #include "clock.h"
 
-enum {
-	MLX5_CYCLES_SHIFT	= 31
-};
-
 enum {
 	MLX5_PIN_MODE_IN		= 0x0,
 	MLX5_PIN_MODE_OUT		= 0x1,
@@ -93,6 +90,31 @@ static bool mlx5_modify_mtutc_allowed(struct mlx5_core_dev *mdev)
 	return MLX5_CAP_MCAM_FEATURE(mdev, ptpcyc2realtime_modify);
 }
 
+static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
+{
+	/* Optimal shift constant leads to corrections above just 1 scaled ppm.
+	 *
+	 * Two sets of equations are needed to derive the optimal shift
+	 * constant for the cyclecounter.
+	 *
+	 *    dev_freq_khz * 1000 / 2^shift_constant = 1 scaled_ppm
+	 *    ppb = scaled_ppm * 1000 / 2^16
+	 *
+	 * Using the two equations together
+	 *
+	 *    dev_freq_khz * 1000 / 1 scaled_ppm = 2^shift_constant
+	 *    dev_freq_khz * 2^16 / 1 ppb = 2^shift_constant
+	 *    dev_freq_khz = 2^(shift_constant - 16)
+	 *
+	 * then yields
+	 *
+	 *    shift_constant = ilog2(dev_freq_khz) + 16
+	 */
+
+	return min(ilog2(dev_freq_khz) + 16,
+		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
+}
+
 static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
@@ -909,7 +931,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 
 	dev_freq = MLX5_CAP_GEN(mdev, device_frequency_khz);
 	timer->cycles.read = read_internal_timer;
-	timer->cycles.shift = MLX5_CYCLES_SHIFT;
+	timer->cycles.shift = mlx5_ptp_shift_constant(dev_freq);
 	timer->cycles.mult = clocksource_khz2mult(dev_freq,
 						  timer->cycles.shift);
 	timer->nominal_c_mult = timer->cycles.mult;
-- 
2.40.1


