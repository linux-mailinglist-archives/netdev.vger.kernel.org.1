Return-Path: <netdev+bounces-60516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D272081FAC7
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE641C20D41
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3131101D9;
	Thu, 28 Dec 2023 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgVh+ARX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F81078A
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaiAjB7B+JtYA8D0ElddKUO5qUCC90VZU7hhrwI6AH0NVxXr1eWTfRVzPcDI0odL+DaX+o9ZS0bGRh83sluzN3+KOlPkbMILE0Nu1gQVNl70BUn/QzlKWyGF5OJwpgFZT87fFdSojTnGDbFqFiQGyGqpRPt6U4pJ61vkLhdZC5PZyFAUFe0QyAk/IYKD7AD8VfK92hagDak0dqBoyufrjx7PLJnZah4LanCtQZ+oKXHv1FO+4io+BsaPVfhP3Sppwc4HS4br1Bos1XRJxZo/NsJ7phYSeH1T273UixFu2ejCzX/LIxERMJGwHjKzeeyo1TZPdfRzI3m7QfCV40qbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t3RvWXp1Qf8AIB05G565WnLz/3qodrX9e2HuDGsaWo=;
 b=dP4/cvOADbsMQRpTBV+4ZccjZoa2k+nVRfA2nGry2meQmoIhLyvIW/KFF6ACB6tqTOkvUiJdIbfXMsPBoVjBS3RWKr14R2jN4Oxq84JIO//rIz/kseZ+lHJ7nUFV6k1NV76e1HPMZIsUT6A7n9al3o0vROXhkIX1ifxecLQKb7XCPOvrqeBMKkGfymTJ4oJnygMaTI7GpXl5AAz0fVgnADpO/6YGYtWBKbU/KhlJPDW9goy6GNmhQOu1Hia4jEi6pqDNCOilhRV9nhlt3DvwvINwyCtYCF/McZzN2FUpXyDoNgXtbh2lhfu0NALBROIkHz8Poc1GP1dFYituMROQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t3RvWXp1Qf8AIB05G565WnLz/3qodrX9e2HuDGsaWo=;
 b=RgVh+ARX/CXgrRpEgHnJFXbUI0SuyOu2482VuP/AvaUAc6k26ar65ikZrlg+PGnW/b/6+OM2Zc3/nubLPgSgFr/pMGcW7+zaAlECUwOy/ZqSjW99aM5Fdy4ytSHzNOAzULWrwYICkyIsbaUQ9dCLnwLwGJEOkFf/j54iVZdjZC2EiTsGrH3H138AY7M7rIPr1zvtpeu1vvl3mmC2AaDDqVfrQ9Gm/crzk08VK1IyT1znjeWDqdgrIcAeJbwB8TpXmNNiLtpgab3MXBFueiYiCuMMo1adTR2baKh3Gtt0CTlYtRtnt72VCyNd6dgn7NCejfWfCV0qyWQ4cWIb0SrFIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Thu, 28 Dec
 2023 19:37:02 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 19:37:02 +0000
Date: Thu, 28 Dec 2023 14:36:58 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 10/10] selftests: dsa: Replace symlinks by
 wrapper script
Message-ID: <ZY3OWvnuzk59TU2K@d3>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231227201129.rvux4i5pklo5v5ie@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227201129.rvux4i5pklo5v5ie@skbuf>
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: dc543bc4-9665-4d74-0915-08dc07dc5d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pz2Mplw4WUlQ3srE+3Sc6EFXXJ+NQpgWQswFofKnmR66IYTTamk67h06BieXizxyOGDwcJZj5sW1CjK8PfAO5XV7Ub402P1+Evom7fXIXDWulsrsc7q3hczGyB2Wc/BRdJi+yNkxp+AxP2mnIbaAVgdn428oLuPTohD9FcZrKlQSlpLhJhdMsp66rWM7p9LqZwiAyASx4mI4K6MTyjZRRXPnB5Y5uZLz6mrNsbnDiJY8IbTSg8mWxNJK2lhKXj4snp+6ZmYKDBjHAnFjBar5DF+cTxzqy6aeEcLu5QAJoDC1m03f0srUlfFDDQmDS45nCUxhgqCsN7fv7BwCl0c3m5MQUc97lgFzHMIdAGe1BTciCdekztKVAeVCdEXj5lbUtK86GxVCltcwfPDmzde83RXeZdGvbMEiykhoaGx6yGyuxO6Egw3WppLg4NbvsiCXb1ACjpKMk4ERcT+mrYphBHHhAPkWG/QAZPCoGcLQfVi6k/nuzxdICgs+qzRuwQ5imdBbWHwtf7mmPJiy9bVxkR6D8TmuanP97BqRMp8/MYMQJCodKWsE3rOTQDwCJB1n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(26005)(38100700002)(33716001)(8676002)(8936002)(316002)(2906002)(478600001)(4326008)(4001150100001)(5660300002)(54906003)(66476007)(53546011)(6506007)(6512007)(9686003)(6916009)(66946007)(66556008)(6486002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bMOarI5AWTEvr1bhcKe8dRza1ZlxCZxWDkPwtXsY9lI/CQj8Dx6PIMw4AYMo?=
 =?us-ascii?Q?d1Hgx61gWaQN+27ltgW1dMBstbO2cWi6AOEAmoRVRdZSF9V6/JQoAO2mWXCp?=
 =?us-ascii?Q?Ov+1BoNFg6ekoTwysPwJQDXzBx/ufmt9lpHEMXGI81ugFfeRmHq7ys6R9aPC?=
 =?us-ascii?Q?VcJZaxq3S4Kaq5LHfLu+njbNo7+rah6dDjbN6e33swC53mVeqrJWQiqNVbnP?=
 =?us-ascii?Q?aGGGdDjap2Z3rv/NDkZclQa8m1iu1IQDfpo2VGe2NbtSvs4PFulMYQztM8Af?=
 =?us-ascii?Q?yMUZ7Nj7K85D4OmYfihO8H9DpBg3e0fewMXmMC81TLYdk/sScbvBTPbSraYc?=
 =?us-ascii?Q?xJnFHDaTjIr0I1Y5yCn4+BvHfRzPP+3HD/WzLAzOBuzjSJPNX2DsO/6k+ixJ?=
 =?us-ascii?Q?Wtf56CX19ohV9EkO3Kzyio5EGfgBSK85wtf0z5yE5LweguKOUrAe6j7MF9+k?=
 =?us-ascii?Q?4sA4aCuiYvoOeB6TomLBI248KbTgY2iDC783nCqYBWmVLp8ZUaFp7SlOGxrP?=
 =?us-ascii?Q?h8ljaw+lgHNLnWjXyiTKUeIxof4iP1YzxDD6uoi5RqiH/Cq7QpyUOub12ILD?=
 =?us-ascii?Q?+ow4oo0QA2+L1aQm6jXKODfAwwOOeYECGPQA1lo3630OKgoCnYMc1keIJIxM?=
 =?us-ascii?Q?lUZU+TuvIiALSI4B01xAjixW5jyj8ft7+Uf7xChb9Vf+Q7tFuaO8crQ+Ofkl?=
 =?us-ascii?Q?760OpOqd7/4vwTtB1S3yS9Rlca8y7h0Kz2mwYbNzfStFu9iobp03FB5HRpzE?=
 =?us-ascii?Q?mBBuPHte4coj8WAWOz4MfDb6472C2mt6ruvTEoYxVR5ux95r5egUFHa/lUGF?=
 =?us-ascii?Q?TBz0S0ioCHccon7LgbalZzfO7/TYk/Zv9gQXqGWkMU5cUvp1SpqcPSqPgTe8?=
 =?us-ascii?Q?k2wPpK1zdY9aKn6qftxgCRBwSIvgtafhhgqbA1nLlAtFJ1lj4z5quRZJfcnm?=
 =?us-ascii?Q?/Ibj+UgdoqqDnfqGNbXAiOwpCIEYULkpQ048adtuRpucnY1kbcjD9SKG0v3M?=
 =?us-ascii?Q?n9thLsEZZN3732qAuxYvrJQNExKy92u/WwzcOdKPIJJqc5E16iKmXdePnaJb?=
 =?us-ascii?Q?JUjISOQU9CV87bToUZaz14nOmEAhRQToYrIKQYDamRQ1VQd9GeF8nHYpaO+e?=
 =?us-ascii?Q?AuEdyXbfeCDiFRwNQrXh9nmDvHnXo+/wU1mbZgdgFqvdWbH38U2GMASznMH5?=
 =?us-ascii?Q?kWRP9h2jy3wwmyVr5bA7Y1ysVaI96IZu98xC22a/WWHj7x0VGE+wbFcZ30uQ?=
 =?us-ascii?Q?zA6ZkJopQeO2Pgyigq5PQaFvH+ifOtYItBUu0MXyiin66IUNwzd+cetTMTEv?=
 =?us-ascii?Q?Aw63n9hxw8uMvzzIFKB95wt5E1rjeEccl9a/5xuov6VSuoy9j+5e1JxJKiig?=
 =?us-ascii?Q?fNAqfjpmal/lQxVb7xUyAZQk8+ManwD3KpNhd1cbPlhAFzl3+MYQhU31CVkq?=
 =?us-ascii?Q?7HUV+7z1zgU7yZdphs6OUr7gD/5UogGanADra0W26takMp72v72BmLQmNU3/?=
 =?us-ascii?Q?53s5azlTSWUFqljZHL9msdxLYk7WHS5ppC4nkQCO6WTM4h/+htZbSsV76Aqs?=
 =?us-ascii?Q?5NoXGYpXCudafnK9UWOiGStg9ccfYqcWpx+jSRdF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc543bc4-9665-4d74-0915-08dc07dc5d59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 19:37:02.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o3nvDue0tl5IRbeH1dx5sqIJQRbHow3g1QRQaLY3G8ccqEkpRW1dA02+gg6J/Yb3D7iXnPn27jGR+qiynsAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

On 2023-12-27 22:11 +0200, Vladimir Oltean wrote:
> On Fri, Dec 22, 2023 at 08:58:36AM -0500, Benjamin Poirier wrote:
> > diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> > new file mode 100755
> > index 000000000000..4106c0a102ea
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> > @@ -0,0 +1,9 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
> > +testname=$(basename "${BASH_SOURCE[0]}")
> > +
> > +source "$libdir"/forwarding.config
> > +cd "$libdir"/../../../net/forwarding/ || exit 1
> > +source "./$testname" "$@"
> 
> Thanks for working on this. I don't dislike the solution. Just one
> question.  Can "run_net_forwarding_test.sh" be one day moved from
> tools/testing/selftests/drivers/net/dsa/ without duplicating it,
> should anyone else need the same setup?

Yes, it's possible. I didn't think about it before but I tested the
approach below. It applies over the changes I just sent in my previous
mail about patch 5.

Thank you for your review and suggestions.

diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index cd6817fe5be6..5ff77c851642 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -12,10 +12,10 @@ TEST_PROGS = bridge_locked_port.sh \
 	test_bridge_fdb_stress.sh
 
 TEST_FILES := \
-	run_net_forwarding_test.sh \
 	forwarding.config
 
 TEST_INCLUDES := \
+	run_net_forwarding_test.sh \
 	../../../net/forwarding/bridge_locked_port.sh \
 	../../../net/forwarding/bridge_mdb.sh \
 	../../../net/forwarding/bridge_mld.sh \
@@ -25,6 +25,7 @@ TEST_INCLUDES := \
 	../../../net/forwarding/lib.sh \
 	../../../net/forwarding/local_termination.sh \
 	../../../net/forwarding/no_forwarding.sh \
+	../../../net/forwarding/run_net_forwarding_test.sh \
 	../../../net/forwarding/tc_actions.sh \
 	../../../net/forwarding/tc_common.sh \
 	../../../net/lib.sh
diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
deleted file mode 100755
index 4106c0a102ea..000000000000
--- a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
-testname=$(basename "${BASH_SOURCE[0]}")
-
-source "$libdir"/forwarding.config
-cd "$libdir"/../../../net/forwarding/ || exit 1
-source "./$testname" "$@"
diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
new file mode 120000
index 000000000000..2e7e656349e6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
@@ -0,0 +1 @@
+../../../net/forwarding/run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/net/forwarding/run_net_forwarding_test.sh b/tools/testing/selftests/net/forwarding/run_net_forwarding_test.sh
new file mode 100755
index 000000000000..cfddadb57fe7
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/run_net_forwarding_test.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+linkdir=$(readlink -f "$(dirname "$0")")
+libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+testname=$(basename "${BASH_SOURCE[0]}")
+
+source "$linkdir"/forwarding.config
+cd "$libdir" || exit 1
+source "./$testname" "$@"

