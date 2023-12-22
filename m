Return-Path: <netdev+bounces-59925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030081CB0C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBE1F231FF
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6771CA9F;
	Fri, 22 Dec 2023 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxAHDhRI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF51CFB7
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU/B+MvCfnuhqMTUjxLwEyP+NocY/zGxNLztLa8u8jZCMvFZJvVfG3oHPzFcFxxJ8sPjnXVMAhxE/QABWe0oxH4vn2uxlRY/15QMuMt4Lwxb2T8MmHtZOmVCnFCouquzOKhMQSZAacHNdv9gfqoP69j4NYPg5jFUx20GY3BRx3bRoQK6tkihpgHJAHUSSexiRm/bByXbf1qngfj6MWod/IB15CvkWI7un0bOZ+RhsJvvylBIjy8vFYejc+YDloAEjtIndIupR1odygGVKR3OWNqf+rhDoQItd+29LpCtLVXow0Yf9SJRxXWI2GVqOQc5QqOKhGt6VnvCQYW6RhnwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WtVqHP76gMAjlS8NJdNpYx7ZC5yPiSoGjifWH9K0Ms=;
 b=dja/AN3gp0nsGQAp0PpYgJJG5nX4sAXBISBXIG/ZMOCscs6fG2ykBTJoIezDzH18wtwVjM48XjFacW2PP7rEK7w0IPEY3HwG/eE6+1bXac2BHIDk+vnaMFd1ALyVVNRf0UZryWZadrVbGETNF7diPuh2qxEdRxEZkOK27LxfiK2QtQnGXJyOOYV8HcrMesUtQCcEnkR3twYY7M2NN+rK2GQXw1gA3baGLyAFVrEkG1dj0jLyTJndvG+P3pkg0rj4Ji0rbSOUtZ2qQUYUj8c+BOzM9eQlEiKzh3oaxOkCUykeaAq4uCry4T6OhrGfarUDfbNlX9lf647A+vbP8Armqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WtVqHP76gMAjlS8NJdNpYx7ZC5yPiSoGjifWH9K0Ms=;
 b=mxAHDhRIgmlYdxd3IXjhaqkZz9DcfxOmpkWwQ9DPMBpjd1OM1WqCNKBFAmn3R34UeSszHkFOYSsi6sGxAx7Yt0anG3zfNnA/YHy23wplP/eaFw8ZmjqJboZOCrFvm1Oup6Q3zILLz2GlsyGlNcMbwCbIov4Ag12eDK1+NwpNn9myjjGfGU4i+b6cKiBFQCzwnNorZdHU5HJQAkDG816ojU9JUTujD/zVxMvnumK4XJnJTDx1JmlZMO+NujFaMK/wgcsBTq5mestiR8SHgOY7XGj6/EXa/0ymDD59dGWWruWA1kWKjzzbV5+VLkUYmuuN8Imv2yFYTaGOzlh77rIyMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:05 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:05 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 04/10] selftests: forwarding: Simplify forwarding.config import logic
Date: Fri, 22 Dec 2023 08:58:30 -0500
Message-ID: <20231222135836.992841-5-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::12) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d280cb-319f-4f07-c65e-08dc02f64cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ht5H0a4eWUBUC4TT0IjYP6DM6UWNvaEHt1sUtUCSs2TJAiBGTl4eNMJ2QAavEkXyPJKjdiwdUwg3ftQmwCzq0YUEytHhp2OP5WWjsr174BT8Tmx2HRM3Z8wzcLwYs7fVqVNQScHACKHC1IATUI/VyrAfI6C4UjfwLKVY9eb4/PeykijAsP/0qozdSmjqQLzKvOot5BzZacpavsZp85sRbrTqf7isr9YPn5rVcFS9eMfr7AWqHPoL5h1VN+NkxPNs30JgxH0eZRZV17j0BKYytbPOEFRe5NUwAlC2PYoASC8F2B3D1m//zee3GC3BHReuUngo1odc5vz4UxwNqJN6HVo3+HWC6OOCTuaR0yhRV3s7YxceV9Pt6xS2BE3jOYphrmw885b2Tw5/3YQUYmwk+aPkSMwi2TZW8M9YpscUFjq4tm4PDHt0550Gtf9pLiKWtTOJ1Efgkwg/qmOIrd0pSAMFEDAY7iXOaTO6+xQuai7zYQbQ74FZeoI11j0/7mlpK99DuXUDgiGda3cVV1wcebvHX3uMQLbq6WntJsa05yi6w8P8Zauuak8pcUBKSP2Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDH+R+dm8KbZSyQQavvZ9pt/8UeFpiQVHpldg8UEy7ELtBwVtzsf/aYKW6/v?=
 =?us-ascii?Q?iW8W6E7adYOI8CyaJ3ukaHzpxzRD0ZS8Zort5V/ZzY3StdLwLRUxMRVRJxDu?=
 =?us-ascii?Q?Q4utTE1VP3gccpwjwe364e1olJSmGZL7ZDgME4fkxWQCih40SeXE9oi8/QO2?=
 =?us-ascii?Q?Pe0Zx9kt8EP4VgueaVglcJlGxoLG3eWFAe/0MWW5gAQ/C4N+Hu6UAyGXo0oR?=
 =?us-ascii?Q?sAnL55YC5uxFPKLnt83dfsGsIJlydPrYm4VtKrtSEbI2M6eGFIrYLWX9VBtQ?=
 =?us-ascii?Q?zZCC5jpNZK/egaii8Llnmf9mBJHQPlsKEs2yar2d6lz9e9NEgazWuWVkzQiL?=
 =?us-ascii?Q?0RPavYNWMnGoTwXjOUYrc8L0Z4bJ2NcvMmlgQYepz3y1BHpyFSahtE7koe3n?=
 =?us-ascii?Q?s5nVgBvl11EBV3IiF6Oe82727bdIv7YhVKS/EZZHeo3tv+SPJ1aJs033vJ9v?=
 =?us-ascii?Q?Tce28a6haxq6OVE5tySrIBvdfYS/wh9Gqmlxseu/vWtXjKqCk43zXr0jCHFp?=
 =?us-ascii?Q?5zwFxTO+m/7LWsFF+Gb9XXk/RObFi+K2g8MglDndpHMB2MPzp7APyFsrHGwR?=
 =?us-ascii?Q?WVq7rxJwXquhaEIg7kSBfySeD8QyxDvGfDJcv09pQjafQg1SVuHCVAqvRuxZ?=
 =?us-ascii?Q?LKd6o1KXUaOhNdBRNaYvkTOL51/svAN0Cfdtu9HOdvahSDX7wfBBb++xWsOj?=
 =?us-ascii?Q?HfATxCNIYjW4zP2U76xVD3zf6JXuM8YMV2N/Tw5j+1MBfd1ZgBFUwTXhH15n?=
 =?us-ascii?Q?Q2AxuyijHAQSLVzwRp61Ex/peMw2uDauRjcTI/gS5xIbJ8B0jPdU3rHz0qqH?=
 =?us-ascii?Q?lwTo4kQb2sjdsjwbgu4eeFQdYEQaQFA+tbyIeskiXrdp4pQ+IxffO7XvJewH?=
 =?us-ascii?Q?uRuhZHWBZzcYTWqLLFDRuSvfmpA1JHOc0ldGoVysW7oHEYXbPFHhXNOL7aI3?=
 =?us-ascii?Q?XQmYTAWjOC6qbasoWRqgZwBfusoqR2CbOpHSWwNYPAOhyEkbhs2krZBZRVZ4?=
 =?us-ascii?Q?1PUNVjn7oDDzZnNZ34eYIdnnVRXcL6jePqtJx+sQBW894M9WpmafKc/rrepX?=
 =?us-ascii?Q?F62UfBBdRRkeOLsIkpgOiR79kmkvuDbIJ64xoJ0inLEtDluqeQa/VIZKjDCb?=
 =?us-ascii?Q?Ko/c3TUWKi/41Ea7Gll6sViDdib3lUBBw6+L4MDuz2tBjQdX+qJ0Z4ZKKhwD?=
 =?us-ascii?Q?/J3GJuQ1E5RqJ8iDKjlmQCqtIYqEhVF0PySY+1p7OEsZLeV0mLaYwiBmtSlA?=
 =?us-ascii?Q?U9h4ACH9P0ACEvDwyHQWJO5B8XWiGUjtCDkUEoO2jKFpApeyBCPZJNAq2xeg?=
 =?us-ascii?Q?B1J7xz8RxeOaU8qBflOrP1Z+VwwG3Q8ids0J+1kljMhqsrqgvvy7OpwyAB5T?=
 =?us-ascii?Q?euXaPIM+MlCz94dC/til1XY5rpttp/4qNI0xwU0BqfICA9Y5fMZtn8FyJTGt?=
 =?us-ascii?Q?kCZU5kGMJ6BZTeQBgj21ZPokS+AVCBerNaRk4TKc2EXnneZZFAKODYZvvQN0?=
 =?us-ascii?Q?Vfm3lncnu08n9pxHnQznNif3vHrkTJSrlLkZjUqSNPalKKEX8vguDlJasPP6?=
 =?us-ascii?Q?DudCqnGSVa4+Oq6ECHPSocyLPjmn1SZ72sOpyypP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d280cb-319f-4f07-c65e-08dc02f64cba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:05.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myXXbWvQ5vNN13/EomoQJyfbYTdOECz5a4wNELJZicVAUky1Qj1lh8TqZTz/4U0XPrddnTr3O31bEqhWvgba3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

The first condition removed by this patch reimplements functionality that
is part of `dirname`:
$ dirname ""
.

Use the libdir variable introduced in the previous patch to import
forwarding.config without duplicating functionality.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index f9e32152f23d..481d9b655a40 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -29,16 +29,12 @@ STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
 TROUTE6=${TROUTE6:=traceroute6}
 
-relative_path="${BASH_SOURCE%/*}"
-if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
-	relative_path="."
-fi
-
-if [[ -f $relative_path/forwarding.config ]]; then
-	source "$relative_path/forwarding.config"
-fi
-
 libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+
+if [ -f "$libdir"/forwarding.config ]; then
+       source "$libdir"/forwarding.config
+fi
+
 source "$libdir"/../lib.sh
 
 ##############################################################################
-- 
2.43.0


