Return-Path: <netdev+bounces-59924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2881CB0B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750181F25652
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAD1CFAE;
	Fri, 22 Dec 2023 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KFHbmI6L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523811CA9F
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3MLSAcIDBLDPU3X1BgA+Mn/tS9ihzTIbAlZKnSCmcgPmSk0d6BaUgMmf0+08eDklI8Zde/BrpKBVJ4osDB4mFHihv1OLims3jVu0O/VOx7pjDtRvjVKVMrZFOyb9XsDAFFw04Jq3X1HHXG/VvsRB0IpuW4wNY3Mo5vyUdzysrsRNaCiSmtDV+MBzXWNcBS86upBl4IaOgloLO/3vx3jiQMdX/IUj8rBLETn7DyUHLs+xT3ny//SfTya3v6nLOF6M31HMNHNccljy5ompeXCgvRvHW2XvpRINas7/Eh5lbAnqOGrasJrFCTQMqoinH2BY/Cmb+9/4XNTeDu8aq1CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcvGaD57Jbo4naQ3een4rqsGAGZKL6+yDFz/w0KBgfE=;
 b=QzDVqy9nhnkFIFmnQ2eQqQ0J44jcyG1jZX5WoRrMWXUSTPQNP2KTNgAcs2RY2pqWLEfYFQyiGMpAO9nVXlsSdwL4Y7P1UbYOg7dygWwhLbca2Jit0uzaVwmr/uN8iHPvxg7jLN7lceqq5Z3eBrccttGeoQIt1vFQJmmiySTDjj79buZfAhTL1fN6f5jG4sV75jHaRy+UHeZ9Wp9I7Y7ljoxq+FycuA8icJx4bX9K90sf2fzQLsoBUZ+lRLnA7xI3/jSAb/q7YEoRgIbcNbZE4aJh4iIq2Y1msLRFE6yXGqA1UoXeeJ7NbxFM0OWKwH7ik3VEuCinQ5X6Dklrgktw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvGaD57Jbo4naQ3een4rqsGAGZKL6+yDFz/w0KBgfE=;
 b=KFHbmI6LMNiGLAfK6SCYulM/H1H5Xa4o3IQDb9rHyzQi7Dbf96Pq8YMDCfPoRFpLXWPjY/xhDwaSqaNVUEMWsKnUwOT3wwI32Zwp61qEPuPi2KcPIYNQcwiWOseLX3PBFJ/OfBVBpi8n9lAbWbgXwUim78h427rDArfI2PU+BNFbmMvVK7O7uZ8Hh/Jn0CRgbpNjU/NW4wsua2iuve1cuitZwLg5gkqBzqUXCC89Kwo2Y2UKkPLIMFHOhNyHnHZPrGaM/gZr5OP2g32l7UUuWYNbXcmi0JaagAJ4PF02WWeN1mrmUcqL10gcPi5gv+6aw5pIQeLeQ6Nl9x2+4eggOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:04 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:03 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 03/10] selftests: forwarding: Import top-level lib.sh through absolute path
Date: Fri, 22 Dec 2023 08:58:29 -0500
Message-ID: <20231222135836.992841-4-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::40)
 To MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: aff6ced0-0d10-40ec-e3ca-08dc02f64bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i9l6Km/1I9yZkTG5BHsjry4P+omt3D0LSD5xH/ahUsAHWDiRgYy9sCLMrgIgYt8rdFKShC4q+ir0Bnw/n2ofSEt5VtE4LPrxtsmODGjkHBBfulf9YbHAJKd1NYWi+6ki/HFCRiN1yGBRbzKaXsli0kFu8PbcgUVx7iUzlyYUmTwQh2ksd8U/iF+U7g1zMrS+nfIthGfmOrAQDiUT95VjHCAaP74XWiFSS9BN1omWcx5vTLXxmZUxOXl8ok0H7/Kbf9FudCqiRGXP23EANmXR6ISMthuXBJxErjxcQdeMqTVxvOnHIJehvohoLaeiKG84psLmkBRPxojBaANgkNWhZDi3Z5okbo95TQ/EAJ0qP7In/2t7DHuk/StYiVup8Jvx4S3TuFDG5omm75oOliXIttLdAQ9MSdwGi9pafixNwXhyn/cnpD23o0ju7tDPPSARDIR6DHdhpDGeJ6WwOaUKeVaMfssQEFvqLNV2KhEoJXj5sc1ghsRTX1S0xRvkfN2pCb66aQFeLnw0awJdldrtGTeY3BpA563P6n8tHuamtnIlBlpf1vGWiQAKQglTipOx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hXfcVR3ADa4FKQmf2MGFDhwWb+DPkOnywSrQwPhlJxemh/1n1Ykiz70xRKjJ?=
 =?us-ascii?Q?ia8H0lQLMPtYmRTRQovDrbnksbwlE8uMeQOL8DatEWU7FNiFTJb/Z5TFr2/I?=
 =?us-ascii?Q?6RIX7VYTf94ORdTOyI9sGa4VD/TkL6dalsMq/CM4quK/WS3PbwO8kdzA0xlW?=
 =?us-ascii?Q?J8Dk30Rn8sF1LxGzZktohz/UEpUfZmRpOPVTuywZ1sXW1/9IMnkhH+kzaSXk?=
 =?us-ascii?Q?lj7YUzZn2+LX+BBpoLJ14VATTHdls3cGsMLkmO7iQZUvJ6ccjcnXTBpJ9nv0?=
 =?us-ascii?Q?FXg1xnBYQmNLfZXaXQTBf/mjICFoorvmoastDF28GlwN1kmigDA1k0yTGFAf?=
 =?us-ascii?Q?35Z5ci6WRngdjf4ygo2HTS0EuMatQTpKpZ63dZmQyhFqpR9sCk2wAIlGsoQv?=
 =?us-ascii?Q?fxsFeV5ED0qp2GzwkTSOc3yFcKQBZHAMomOTK02YAHcc8ifzT8U5ckIuybLv?=
 =?us-ascii?Q?Ry0TK12MYWITTWy+uuPE7XyD3tlX8JOZCYYFWDx5Xi5OcwL4cFb16rpelRy1?=
 =?us-ascii?Q?o1xq3syfXyCmPKOq34akZAWSlabkJr6G0wmiCUeyCUQE/oVoU8dU0DbTUB0A?=
 =?us-ascii?Q?Yo+GT3sTqmfi6KYOlB7UAhAJEzkZ9tE55G6VBSGIubJ2ZKePfCP0rIs2xP5u?=
 =?us-ascii?Q?W5eD/gSPgGE5ep0vMigOMw6oPd8GnUBqdLwoG9U19za7Jp0SFoq+uH/mBCbh?=
 =?us-ascii?Q?wNv32ECHCC+McZ3qhHMQq/dLBP778oQaYwv3B6K2CATwrDGQuw/IrpTOBn1O?=
 =?us-ascii?Q?0cuhm4ENFqWnHx54IwyRRttE6SDzf8rKqiEwUXI8eKev3Fe4RLzRmSedWYC5?=
 =?us-ascii?Q?yxskn2U8CHsCqTusRLfz4CJcNto6NUqCStf9tKIlPOmIjKEdr7cSk/ylsOh4?=
 =?us-ascii?Q?oUf69lmllPz5XU0h0jy1K3R1RAhVOqjS2N4Nusv/sf9/v2Knle2MTldJbTTK?=
 =?us-ascii?Q?P8IM3cVi2Ymj9QuRCL4K9/5rLzG7McxjQMwj82yEpMxt4ddydD5PKevPek/Y?=
 =?us-ascii?Q?GSjpM0G5Aa2o0uwYdbkpE6FFIuggTK6L6ffMN2Ho9GT6XKDOgkpr+a6GQ6RH?=
 =?us-ascii?Q?+RBElrK2kfRiJMvibhFiueEpIZfUNtDsQKlzYtmubmJ9OQw3+MhtutLMihn1?=
 =?us-ascii?Q?Z0XBp5R7knbeDcrDhUzxdnuj09sDWq0GTvLnQx/8YMPzK8n78xUlcgJGyOqI?=
 =?us-ascii?Q?0UktzFlvXE1aPVp1arvFEnQ0gB+BsmA+YWhrNDu3ctzfrRl30mxGwvjX40xQ?=
 =?us-ascii?Q?+RAHni+zattDM25LDz9hZGWXaCLy77sh/CZ8OOV5lUjBUG1vHKmAJwR37i11?=
 =?us-ascii?Q?GFYjcSucqZb/OMDIq2DVaKj+dTrROcOYr12ERUE+xb8s+KEvVAE9cNYqBChO?=
 =?us-ascii?Q?rjr7LKPFY5IKNYO5rB3nASwzurU/mrlWFFB7VevnQRTQwLNQqPA53XEghRrm?=
 =?us-ascii?Q?2NUmt3aSm4e6BPiD3vOt6PdbF05HPEd9++zWwHZdaI3ZATL5DucfJ6h7LAzB?=
 =?us-ascii?Q?U7U/VwuAKcct1M+8ykGQ8MV3tEEvwJqlfTQPxg9Ukc1SJsylTCfphFo6YAWJ?=
 =?us-ascii?Q?lKzAWQiPP4aJ+dU+T1Vouf66sRrdDmJjrGqSzrWz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff6ced0-0d10-40ec-e3ca-08dc02f64bd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:03.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjXwov2alkCqZoK9kRaxijr2iSYwpQ/wKgXNOCI3PyoeDnTg64r8JJhC/RBbMFQDdJToi/E8rb2s/2x8qUMKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

From: Petr Machata <petrm@nvidia.com>

The commit cited below moved code from net/forwarding/lib.sh to net/lib.sh,
and had the former source the latter. This causes issues with selftests
from directories other than net/forwarding/, in particular drivers/net/...
For those files, the line "source ../lib.sh" would look for lib.sh in the
directory above the script file's one, which is incorrect.

Instead, use $BASH_SOURCE and dirname to determine which directory the
forwarding/lib.sh resides in, and use that to find net/lib.sh.

Some selftests (namely drivers/net/bonding) use a symbolic link to
forwarding/lib.sh, and source that instead. Therefore pass $BASH_SOURCE
through readlink to resolve to the ultimate file.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e3740163c384..f9e32152f23d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,9 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
-source ../lib.sh
+libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+source "$libdir"/../lib.sh
+
 ##############################################################################
 # Sanity checks
 
-- 
2.43.0


