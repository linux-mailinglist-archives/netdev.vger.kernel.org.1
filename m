Return-Path: <netdev+bounces-50105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4837F4A36
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B746CB21108
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11124BAB5;
	Wed, 22 Nov 2023 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bCCKKG1y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589E1B8
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czuhjITOcpKKgrHf1vR7PM0fNpJT36YROaK5CbBMsz1cuRVCQitt6Al6uuEa7Qw19V/ms9BFTARSz+z6bHT0D4YfsYShxiW/yvM1iWQVFc5bA1t1I6j2z8AQixxVA3jd3xGBFDdfIdEkNoZIHOoDbDsZbxsr38WENGd3WQ1VdeTlj8hB2QlrDFWyBe0i04q4zqScBXOk84IEalKn4N3+Xp7sFWJaoJyPUL0F9jTM3F6myYlkdJg69UvXfFPhq2ID9UAzZjlTHuoARi5SpylShZl/o5v/yFf/rb6uOi6ZzQDwnjbln4hK8J9LL/nf/9F8i5fniKgs092Iv6jlBaYIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjZXTN+hqJnDKxG2U2A/SsBT5u6M86yR8e8PFYHavFI=;
 b=F3OtSmXfz0XQ/h/d4tHkPtCQcvoAHWqDjdZr56TDQnryrEo8rvDX1Vhm1RVpq3wqx+8c3izEQn/RW0TCZ4CcylI5ww/VX+iBDT1sqFpctneOgUnPQY9svtOCZgD6jzlqw4elP6skax+wEortHYCAM4ZjmPqInn5R3qlPlk8PIw38IqTE/7l9aUDIBeMQ3ouF3C/Rj9V7sOwjJdP/EjzKoGlooWjd0bvAX4B4otqqb88DikekqKLQrzWL03X2+PysXUB3EehJZoDz7vInTXTjyyk4r5nVDKy3PweOyLrvOGJHqCcY4okljgA2yvDMdxQ7lIjvrdzZKYFMSbLwNm4ZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjZXTN+hqJnDKxG2U2A/SsBT5u6M86yR8e8PFYHavFI=;
 b=bCCKKG1yjAhloklUKHhCgN+h7zP1q55joVA4ZiBHbeO15lHRnjYVZmGLo3pkT+C8xyII8eDOTnET/hDnckQ+TkYMAM2VZbpEvE5xLA36uq3fjkAS05PPzdavXM7K6xKC6o4MsrrumTQgiZ3unV4gFCgr5haaoeWrN0LVNx2R0Sy/9HL+/7BLSuOs8pw4RodcqnysHBH1CFSz+TyZgEe4K2MSfwpgOqzEYpS0kxAlRnGCJgnv4KO6ulKH0kB5nIjXpZ/1orqnxxZG9iecSmiisG0mx8VuLeX8YpZ65xyrKzNDe4in7FJhMUEhtBYNzCIDfG/m4WCTfv33aZLg2faiOg==
Received: from SN7PR04CA0183.namprd04.prod.outlook.com (2603:10b6:806:126::8)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:24:26 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::e1) by SN7PR04CA0183.outlook.office365.com
 (2603:10b6:806:126::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:10 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:09 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 5/5] lib: utils: Have parse_one_of() warn about prefix matches
Date: Wed, 22 Nov 2023 16:23:32 +0100
Message-ID: <f34f1c20dafd61fae337e98ae71a6e8a7889d5eb.1700666420.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da0a5a6-7356-4933-17b0-08dbeb6f1d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	97Hx+WSe4uOEH26C3u4o54S5e5lpwUsaZ0etlYKOwLKoPMd402m/W8xpMutjIRHUUSOfRwLdRs7kzjN5YxTgJ3YT1jdRT/Fs3YLlbByUfv6beHRzcwRw082vYzncGVIXr6l+2RlQ4mTARqi+dESB8StcXH1cD9Z8Oa5JTZKp4c5DWPtvL/UmDRtsl2esPlxl/zTzmp7QPvRNsUtP/D0NtLHsT8IW6ysJV5nbg57a4EHjl7KOSANOC6owWxOPeN3W8i1eHUO82O8bPK5FYY1u/49l3yJyqY+CbZlHVNJYvFOG1NzajCR7A6jlAupegzOgFjG++VMiOzES4sjDn6SKT3bFygGdZJEmJs+gi3F7r5v4No7TKjYGnXOdWloyxZrCQjbftvGij+JJKr0m+NHmkjxaqdxrDjq8FR87BB2wMNpwKi2ZUJlAGBC22MdxB32TftM3+kTYHia/KHPQBKnT8/64EC28RsGNLZFzj6Y466tLQeKkMmDe25BiFOIdqjYHWeOLrTyUJTIXFR2+ClfxRdWaAgwmLfC+IbXojqInwvX8ih7n0J2k/FrLbmikhvp/gSnPr5AnNo2HYOw5MtbSbCrQnvaE5GWXiW/u2Ei+ooRuwd8gDcYUc6mI1i7sTvWaiGVd+73VLw3L5j1k4MGbWYy+KCk5dMxNU0D2/r1R9tgQreRXraUQVIRCEQta+m1vMeUTdNBdWyg+/Ts2fhwN7v/z+pfP5hrfoZJ20tUQM0vRmG3g0C6bPLDTM0ftJKHqwsQVPVCmCBHTWRWv+EKY6qheuuFOWvGhntsz0T6Qceo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(2616005)(107886003)(26005)(82740400003)(83380400001)(426003)(16526019)(40460700003)(336012)(6666004)(478600001)(36860700001)(40480700001)(86362001)(47076005)(5660300002)(8676002)(4326008)(8936002)(41300700001)(2906002)(70586007)(7636003)(54906003)(110136005)(316002)(70206006)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:26.4150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0a5a6-7356-4933-17b0-08dbeb6f1d1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

The function parse_one_of() currently uses matches() for string comparison
under the hood. Extending matches()-based parsers is tricky, because newly
added matches might change the way strings are parsed, if the newly-added
string shares a prefix with a string that is matched later in the code.

Therefore in this patch, add a twist to parse_one_of() that partial prefix
matches yield a warning. This will not disturb standard output or the
overall behavior, but will make it obvious that the usage is discouraged
and prompt users to update their scripts and habits.

An example of output:

    # dcb ets set dev swp1 tc-tsa 0:s
    WARNING: 's' matches 'strict' by prefix.
    Matching by prefix is deprecated in this context, please use the full string.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/utils.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index 9142dc1d..599e859e 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -887,6 +887,23 @@ int matches(const char *prefix, const char *string)
 	return *prefix;
 }
 
+static int matches_warn(const char *prefix, const char *string)
+{
+	int rc;
+
+	rc = matches(prefix, string);
+	if (rc)
+		return rc;
+
+	if (strlen(prefix) != strlen(string))
+		fprintf(stderr,
+			"WARNING: '%s' matches '%s' by prefix.\n"
+			"Matching by prefix is deprecated in this context, please use the full string.\n",
+			prefix, string);
+
+	return 0;
+}
+
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits)
 {
 	const __u32 *a1 = a->data;
@@ -1755,7 +1772,7 @@ __parse_one_of(const char *msg, const char *realval,
 int parse_one_of(const char *msg, const char *realval, const char * const *list,
 		 size_t len, int *p_err)
 {
-	return __parse_one_of(msg, realval, list, len, p_err, matches);
+	return __parse_one_of(msg, realval, list, len, p_err, matches_warn);
 }
 
 int parse_one_of_deprecated(const char *msg, const char *realval,
-- 
2.41.0


