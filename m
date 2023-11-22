Return-Path: <netdev+bounces-50103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BF7F4A34
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE018B211A1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3C4EB4B;
	Wed, 22 Nov 2023 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5bt9FiZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A68C18D
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipyXvCVw45aOC2iU5jgxwwlfeDjUMpkFpivm7DJoXqNPgsLBza/kyEDULe7/AzmQDjnyZM4dHjawI+tJ24oL9AQfpbu0Mi3rmfcr6KE7MB+4KDCGyflY7j2hdI3fOAncn46HJpxs96E80K8UWjs13Nvw5SQAhOJPHAmurKtTZZ/izOTmbt6yegm5jndjtSdq2YdXQNkVN40SGbjv2WJSxtgW0oxOiVkqegRSGD4aGcFly4+ZjEy0Y5/hIg6HAzOAlla7PeosdQODZQJDcDe2lIup61fHI6/1zLChXv5sv0NCP9U7dEJo4Qmdl83TzDv/8BCsfQivyDH2ikAjjasUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI7/j2jtaySb19OSdFOuKYYrINuIIdlypMpFhTKQlxI=;
 b=e8Wj+tp/VR6PTKk11UMhLLwNEfNDIoR6D0rqgFULXn+/xGPgTsphxCrry91WKtcPyoMggxf9TAZcrfMQbwFdcAvqy+iA0MPPH2m+756SE8Zg1tnh+kpfKodDCvk4pPefj8OSnwy6pntWPufCNYN4MgY7s/+zFGc6IocBm4BYKambWw63i/SQeSz/OPKoMjK4bB9D0PZzURvJzhcNJ7uIsWhFOLBY10wzYqN8RCzmlpgV8Z+ePPvHk5AZP6x/yXEUfWe1BfhKp6pccPfmLPQVQ+WNamcf5IXdWk1kXT9YNl45RvYQCRe8G8A/8Un32YOKQSwNntFxmu/908xv3K626Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI7/j2jtaySb19OSdFOuKYYrINuIIdlypMpFhTKQlxI=;
 b=s5bt9FiZLP/uYkAUf1yGdnP+KGbdzlN7Mk7q6Adnb475a9B2JE+JBzH40I7xhL633NHDa1EucGjIZ2HjEC4/shLzlmBZeIBi3vXkjgR6klOFI2bWjG2QklJuHhuB7jOHSi8O7BCRc3ngDddBLgyWzEhCtnS/g+y46s7EEE8WMXOrmdWtSE6JMbbNfaFoV6ijYlYmRZuwXYAUQG/bPGh0YAbVVJVrP1gL5MWb6sdUlSSI7fe5FSCY3LnMKotQPl3SniIHLKE424Gn2q9m5weeO3mvMeOtREOjKKRzzhV1VNA5bMrMJg8rgantdYK5GBo97SE0sOLfPsIvdWPR3yHz5w==
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 15:24:18 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::3c) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:05 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:03 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 2/5] lib: utils: Generalize parse_one_of()
Date: Wed, 22 Nov 2023 16:23:29 +0100
Message-ID: <901baed98bf9e9fe28611f3e473f22ef7d186d94.1700666420.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700666420.git.petrm@nvidia.com>
References: <cover.1700666420.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: a74cf85b-ccc8-4dbe-8cac-08dbeb6f188e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZ94Awu0OMhlZgGUebnOKd/A+IaPWj8JSeTYobyPflxzjznrQUGFIaoqmdXu6p7qXxX9HCvNXU+gWWGmMH5KwN6M7tnTeOhcPYqhcIZe1aCPkxD60f+6HA5JSm6/wI6E8Fec4zzvXHSyjwS13PaqRFPm3IgToBL4IVTOeT0wXiKLmIhtGTyMUg7Dehv6AMzWABbHMrEyt3muxd5/iu+b5ak9a4H75esjKG825z3hm8dmzB9Tc9pduKPwsk+He+giWVgUgzgK/RzEhwrv9QHQDp/iVOVN+XlHiDx0UQn9sC+HTDhyxgUyDtKlYicW4fL2vGzEvVUlvwfWML2NZL7xqrUe9Ey8RWn/9wH7GZN2Vu4drAwRsvRAFw53DU12/n1dZkS7hXOl6PKdDEGmNPLe7+EJ0AEsGAY7Gp3Z6rlV0P9pRe3iOWwvHGt9INUka/4wkXwz0IUcLBwJ7I1FAPGTrBTv8El8Ln0jtHd++9vCEwLIujDNe5iH7XYzBPgljUTDkF22rI3LBnnz1OH69RYRrjqMFFrjfS9EJVNktlnvF5dXzzB2+32AXRk8DacDcuMCQY8dpPNGCiztwCgkoqoL/IRCz+Z+kUkY5FULixfBABeUjGtLZvNiVILFsi8zPnRgh1mEN8oe9vDYbVazRsJq2kBpkZoLu72eNSrxB4elxFwNBGpZ0LZtlY/4zR1rpVKz2okD3i4VxckQwwP45ttgdbyRIMhzyfvcHNKYOY3qD1E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(5660300002)(86362001)(40460700003)(2906002)(47076005)(7636003)(356005)(40480700001)(107886003)(16526019)(2616005)(6666004)(426003)(478600001)(83380400001)(336012)(82740400003)(4326008)(8676002)(316002)(8936002)(26005)(70586007)(36860700001)(110136005)(54906003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:18.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74cf85b-ccc8-4dbe-8cac-08dbeb6f188e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

The following patch will change the way parse_one_of() and parse_on_off()
parse the strings they are given. To prepare for this change, extract from
parse_one_of() the functional core, which express in terms of a
configurable matcher, a pointer to a function that does the string
comparison. Then rewrite parse_one_of() and parse_on_off() as wrappers that
just pass matches() as the matcher, thereby maintaining the same behavior
as they currently have.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/utils.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 1fc42a9a..5c91aaa9 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1729,13 +1729,15 @@ int do_batch(const char *name, bool force,
 	return ret;
 }
 
-int parse_one_of(const char *msg, const char *realval, const char * const *list,
-		 size_t len, int *p_err)
+static int
+__parse_one_of(const char *msg, const char *realval,
+	       const char * const *list, size_t len, int *p_err,
+	       int (*matcher)(const char *, const char *))
 {
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (list[i] && matches(realval, list[i]) == 0) {
+		if (list[i] && matcher(realval, list[i]) == 0) {
 			*p_err = 0;
 			return i;
 		}
@@ -1750,11 +1752,18 @@ int parse_one_of(const char *msg, const char *realval, const char * const *list,
 	return 0;
 }
 
+int parse_one_of(const char *msg, const char *realval, const char * const *list,
+		 size_t len, int *p_err)
+{
+	return __parse_one_of(msg, realval, list, len, p_err, matches);
+}
+
 bool parse_on_off(const char *msg, const char *realval, int *p_err)
 {
 	static const char * const values_on_off[] = { "off", "on" };
 
-	return parse_one_of(msg, realval, values_on_off, ARRAY_SIZE(values_on_off), p_err);
+	return __parse_one_of(msg, realval, values_on_off,
+			      ARRAY_SIZE(values_on_off), p_err, matches);
 }
 
 int parse_mapping_gen(int *argcp, char ***argvp,
-- 
2.41.0


