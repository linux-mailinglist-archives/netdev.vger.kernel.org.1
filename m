Return-Path: <netdev+bounces-59923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020081CB0A
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFE9286383
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485AC1CA96;
	Fri, 22 Dec 2023 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jniYahYe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C01A71D
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzQdC/prs4rS1f2d6eQXjYy6ALfTbGPCnf3lo2iYIElXvo9cdbLhlfC3U6PP3+76xBMS50rqDqaNTQEdfxjhlicEXdMjDqSScWxt3Y3GZRtz7bgAW9ZhCIBlZqaeUSH0Lmdtw9tzs/5fmxAGliOiY2JGKBHwXjkaVxBf9ikxxk+PiMrOKd/TtHt7Uy2CXlZAielbjrmxyHnzZzZaVBp47QpR1U3oULBo6y+q2j4kHHsE9CR4b8rQJP9xq+IgNWen6RqjFYfoI8Bba2BikT4oU9EtFDx99VTlm/ekSHCPv6hV4tTYvJ0qtprbiRvnnpdiF+OK6PaJ3qFhkrty3Ui2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzQTiPKzwaijdYL8MQrIQLvPG9WnirSXavTTovLJ/lo=;
 b=Y90HND/BU/NyZz7+B2MqyQ2MzDWOCvcELolfjhJNksXWK/nAbhzm+S4+3E29Le/X4/pJxI5aIynSeXjJDHkdlukDlDl/CRCIwypXMAavR+SPqIRVK6XRMHPqhku72PfILg5nXFFlC28GtVN7Cr9hoYSfp57+oCoat+ZyRBx7W8FVj6xWA7NKVTz8gH3dXs1B5JrITtIV88bIu1RsR1kBm3AzM9U5dpY8mn6etV9w4cGqr/0AMWV26E6HkEzOblbcE9Qh9xXdrPW1uPrc5oJrbFVb7UwYqxDp0zbajd+TGHYH36ioaVdqLqMXDz3NQF4QL9GEvF92d6wB4VVmxt+2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzQTiPKzwaijdYL8MQrIQLvPG9WnirSXavTTovLJ/lo=;
 b=jniYahYekmBObAZiCQqMiHDxMtyv9T7zs/xW2jwrprrAA3wujKmyrHe8YcCaY4fINFJCx3aGAth9aFnnaFFaRrUNvB2RFb0xpsEYCAN56rnxr1ny9ztlR1HzjZJrxoHHas0rV/SFH9c14DUy2yiQRpeW2FvdVurCLiX8x+kxVTYMFG9CUm0in78nyJHp8wDXTobQGdYnN6oOTkm10JmXKvhA0NSf8r/7PA2fJnKB4mu+TDtpWSUn/DPNCMb7ycPuT3kqsJo+D8inhbHumZpybEgbrA8uT4+3Uny4i7wHcmsan04R51A6hv/lQNo1whW3SNEoIiLpYxQVelR4qCrz5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:02 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:02 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 02/10] selftests: forwarding: Remove executable bits from lib.sh
Date: Fri, 22 Dec 2023 08:58:28 -0500
Message-ID: <20231222135836.992841-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::37)
 To MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: f851dd06-ec08-46f4-53e5-08dc02f64ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PypQqe/0rzeTHxTn8UgKThOvW3BECECab9Dd66qGPS6TUI/VSeWrJMkiKX+OWrPm4Ky9qOOVVPEGuBu9xz1YYiNra/fmSY9DRElNmopA7kFMDYf94CpXznpxfmQgckwClKuETT9ll4XBd7M1IASdUGCFy3mPJ7lhhFGal2x92tEJyczEsqEKcB6gEmKFR9GOEyBwRdozZ/xHHNeKg1YW9YFzkNAwj3F0HTf4JudDgybnkkgG/MVns9ALJc/vh25Z7zAofWppvIa1ayunKqrDGrsDzGt+pACb6jlLZms1ZYk8ethBQ+7C7ZsT1rRMPAj7b5griRJ5dauUbP+zi4rvJqDhcN9fOb+CEkXBTN1rvJFA8ILr1DQWAzq/nvHvGVUSY+tJmwrz1QRp1341r+UnXEB3Th1244UnLpEnzCB/yImFDnPWDuoQ3vzCeDuA5ajWhgi1V1rZP4TsoqP5ptX3lyZOeoJuscEUHw8MgHxVGTUQ7UvPV0JjB3x7FZUdYIREeOex+xNXgNGoidBkwxVNZA+pU/DM3sPIH9SJuws2alhw8h3n+qcigtASgMAOP2uh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loTXFL6Y1oShyeOI9umW3w+SHQqVb7/EOpKu9b5+Xrql6YYT/rJBpacUDf38?=
 =?us-ascii?Q?P0LmSeJeotnmnxlzZ2kO3v/mKWaZ0gusseKvRvmIOpsGDbJqKwP6v2D68t/y?=
 =?us-ascii?Q?l7vegsn/Zi+p0rT1G8sGrmyIMUL0AuK6mdRvqVV1OC9MpBHI9papeTTO4R1t?=
 =?us-ascii?Q?cNzRDUXJ7kpaza7mDBfDXCSVrtluNie6itP2sjgzmq7jP7+Z2HZy6SoOUljf?=
 =?us-ascii?Q?sgB9UdOvaQ/+dfsg/SmfK/KUf9BRvg8Yw97ztN/HuShbHkq11MoV8L7DQGcM?=
 =?us-ascii?Q?O1jEeIz8hFhH25jHF39Owyd+QK6tXjH6PUOS8vt2W7y1vuCCTHT6j4nv0eCr?=
 =?us-ascii?Q?JQ1QcxJSs9Y6svBM9V2Ppcz/5TUdmfGzHqml0QZuwdmhbNdh+Pkum/bMHne5?=
 =?us-ascii?Q?IyO+HaMYH+pGxh1HTGEYkBoGv/8KEDaOoCCkYtPs3/HRQtNjhOQdCZhasCeZ?=
 =?us-ascii?Q?n09UlED9k+60vUAQ9dRJBFksKqsli0H7zBowk4uHHtXofn6v/oLoxO61/nZb?=
 =?us-ascii?Q?zZbyCDKOdQ7aMlqABfdo2ZcyFaRbgQe9uwQj3vY1z/2cNRVEwCwx9WkP6+Wp?=
 =?us-ascii?Q?nu9dUA+cAHaXr1fVH5lL0HZZ7bAGJRzkeJ1OMYqYUaDwR+g5Ukm0iwjG01y1?=
 =?us-ascii?Q?/ogYL6niFONf8JwECZRuduAx/dI7g78XI5pU/JpcS9rFR/ssNX+qo7uN+FBr?=
 =?us-ascii?Q?frkdIyYkXemg/+r2Iku/1ThV73h3xznqMtl//+oZInJY6WDw2NwDTmvNi1cD?=
 =?us-ascii?Q?4dBEs13cxhy09vKpGFVvlapkuL634yCVI3qmgckaJ6Zo/wdStFLnUimM5dyA?=
 =?us-ascii?Q?RGleW+qW6DNCD9O6cDhKMIiv0/lgZHjpmFCBetfv3yPcPBqwpmJMjaTuZrr1?=
 =?us-ascii?Q?wTweHI3+udisUxwTrc2zLu6Z2skpsU7Jo3azVbjB4PbC34k+Nb3TxJT1IpC4?=
 =?us-ascii?Q?RuYqvLsC2p42NMcxfBgqBfOT+ulNyrWU5RCCgfO2ISXtKypT06q1l2gqz9dn?=
 =?us-ascii?Q?gK/YNfPHD2DllX1tRrksTNS6JCjVtsNv7a3r4JFizEuX+jPuVveHBgMJLRgf?=
 =?us-ascii?Q?HJEgHtD+m89nrznkZzHE+Qr6hlZwXoI3ZeTYd8ipvCfRniTC8CXZhEgKJcgK?=
 =?us-ascii?Q?N5RwNHqoYnPBytebiUx1DvJmPHIw+Y4td0gfZep5/BOrS0mPwEJNIDvrm1ba?=
 =?us-ascii?Q?RhqLm7HQpefWzBJCcLNojw24+bqn37YWxgQjtOYR8vEJ1Sllb62Ta1sfWjAX?=
 =?us-ascii?Q?byu7/EDFiLn1Z4LFBrdFYvSkSu/8u15LhPgNQjlDKYDKL9NjFcHPX0+4VJYs?=
 =?us-ascii?Q?KHrIeafDTq23J4vQgBfCrM4pA1mcocMENVookiZeQLj5dbMvJ2dDHoEbx4qw?=
 =?us-ascii?Q?dyYgx+7f9BQtGoE/XMDvHR+fhQL6QYqkq7Gl22+v5vRhFEgokeDA1puEOSHi?=
 =?us-ascii?Q?hznJa798AIxOFJQf3RyPAFCa0rpiSGGTj55wNhE3kojyDDcd7eu98nsJm77p?=
 =?us-ascii?Q?VBamuglBQ3jCJqNG9ZqcEWIW8kHcJ+wLoUZ9ca0W7mIDk2D9b5eSr+rE96hv?=
 =?us-ascii?Q?wH6P+iJKK2NSDN9rd5PKF4HUWyR7YpfvTJygP6P5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f851dd06-ec08-46f4-53e5-08dc02f64ac1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:02.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOTLmURtMJKqU2kOgTO1oWvTdAvIXegxwy68CclgguHI8vqRB7c7UyNTPFVidcUi0R0eyyZqO/2IV4f+hx/xmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

The lib.sh script is meant to be sourced from other scripts, not executed
directly. Therefore, remove the executable bits from lib.sh's permissions.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
old mode 100755
new mode 100644
-- 
2.43.0


