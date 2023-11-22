Return-Path: <netdev+bounces-50106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A917F4A37
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F428163E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA445102E;
	Wed, 22 Nov 2023 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hELlRShM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7665109
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGtJMY/C3hSjq2stFTj3Flul2N2Z3xp+VgIpSv8hHNGEl8ad10ISw+qH5Wwnq/6fFQ6XMEx8Mhoki0ru1C8a3OIMwfrCQqK3oOCvWXl8wFqeoMwoZoMyNe/VH8yDiiseHZU7Sk5Q07QS0s+jZEkGgaJvHcDbWI3mogMiLMEaSopZZpyt14sEXehIzffT7FIipdRE0XmjNsB+CBz97ZwHnqOIFOvyyGuJO/mxBIFqD/sHmS6+NPWIZiTpkz8YsDyjvCsrzRv+9D9Q1AtKMylnN0BlF697xlA/lTKWWBUexnIAM5UnMbQBiVOx4F87F9SflQ1dAiDqqWmp4/t1MWFu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8LEGbILjbVg7D/UJVghPhn3ty5smDN7HpQYNqJu/K8=;
 b=ayLR81ya+on80ad2LOn0MvFoezgAHYCC+zliMwp9TBW4KuNSQQ9oxVFPfBlekkzMz8fef3uzXBqYp3/JH2cWbsl3ryuChZMNpG6N4IAfxr41QaURHuR4MFQk71zPe93zDXTFpNCaL4t3pbTKiW+Xp/cugxyjgXV84Sf8ilfnByRgds0EX1ybcOw8VPpZJCmF8lt2x5ZHqp0fcq+32eUK2XPczJLtipJ3c2JezyALxx6vddHXkiEK7C3bI2ZWF6vTxpDPHDa8OWvouxJKdwEYHtxHoQo9l6rvgZUN42IG91kLe/XYPzy2p24TxZ1eoVqZqPKNbHV7/Z+dzXU2TlasbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8LEGbILjbVg7D/UJVghPhn3ty5smDN7HpQYNqJu/K8=;
 b=hELlRShMXjrx2wIv1brZI9Br2mfqq1GQFb9y9tb5N6XB7MxAx5QwiNYmQ54VfEcID1BWtyhV/pt8lk4Sun4e5Ba49DL8D1IJH5ZzMwhrkto0cIbAleOjaWGIZyMJOYY2A5KLJqlorMj19m0pV547KSgqkVjE4zIWdi7G2eHvZ7dYVD7WDtTguk+2HTvjysdnpxNgsDm27Mvynlk03bNwcKMpwln4OGj4//lZPHrggV//kS9j2U1MEGgqF6NnGaISjKxaV1qTgXQK9z/tS7P4ubQWqWqqTDQ42uF9/eWkyo9D5opKkNsFekU61pAq8RHJUGNs8G0Przspiwzw6QhUzA==
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:24:24 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::b8) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:08 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:07 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 4/5] lib: utils: Introduce parse_one_of_deprecated()
Date: Wed, 22 Nov 2023 16:23:31 +0100
Message-ID: <e438d36f77cd6e2c6bda3f17e56d225104653893.1700666420.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7d4827-207a-4e8f-7793-08dbeb6f1b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bp+5so+B0DpQoEDOCl6DJNOn+KpWpqRPR2b4vF9HcrBtJSRONiepEtogwDSk0wEPd31+Kd1cu3w1ISpvIvhAD0UUoJrlp66QOyDNBqhkDt+q7OeVLtHlSm9uyL5eRAHWQFNzl4unXxFWe7wxK3AmiWcq8zRfO1El/DNjVO3xQFn/uDO5R56HGukMxJjTF9LOjrfAznEv8vSrXwpJUTfFNjRZZumP11bWvR49K/fKAN3HPGRd5A7cT6UELwV9NSeW4NdTA52qPFWSgVGPYplLODiBpgelHT6L1HqYGDuHY2k4b3mY6nT35lxLiuNGr5AjNvIZmk5P+ogS8l9X3oFqg6kb8+SbLgbr/PR26lexa/63czR0UsnsYHCyYXPQK+OF3WMC7T1m19kzdJvRCIv/kb8foVpLRjJNC7Y9Jh9no967RGSRzFzAyAuNfiqdyjLohU0/kRmTz6Rs3WjeuDqOEBgHa9gtVrJmsEPX+OiQtvbto1M34vEx9qgI4KrwaZPIuCNGUOotrjXScj3VjzPUQZo2F2/j4NuQ7ouzCpQs7+2tBWfVUz6S6r0E9X34nx18ToWg0GSdKv1r5+6eOKdO/ejW/8CI6vxn39FH7N9bLjCxph1utFghS41OOvqIKLwY2EsEPHnIpjdeflIFzDv/rbyd5/w9//eYeWXqcWd9q5lGcstXAixPKMpKgh6/t5DV3d3z193akDcT8ggKLiOkiWEL5M89QBcTUxBzHG1E+ihVEzqASe9pxyGsbGiHaW5E
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(83380400001)(478600001)(36756003)(70586007)(70206006)(110136005)(2616005)(40460700003)(426003)(336012)(54906003)(316002)(82740400003)(7636003)(356005)(40480700001)(4326008)(36860700001)(8676002)(8936002)(5660300002)(6666004)(47076005)(16526019)(26005)(86362001)(107886003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:23.8983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7d4827-207a-4e8f-7793-08dbeb6f1b9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

The function parse_one_of() currently uses matches() for string comparison
under the hood. Extending matches()-based parsers is tricky, because newly
added matches might change the way strings are parsed, if the newly-added
string shares a prefix with a string that is matched later in the code.

In this patch, introduce a new function, parse_one_of_deprecated(). This
will be currently synonymous with parse_one_of(), however the latter will
change behavior in the next patch.

Use the new function for parsing of the macsec "validate" option. The
reason is that the valid strings for that option are "disabled", "check"
and "strict". It is not hard to see how "disabled" could be misspelled as
"disable", and be baked in some script in this form.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/utils.h | 3 +++
 ip/ipmacsec.c   | 6 ++++--
 lib/utils.c     | 7 +++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index add55bfa..9ba129b8 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -342,6 +342,9 @@ int do_batch(const char *name, bool force,
 
 int parse_one_of(const char *msg, const char *realval, const char * const *list,
 		 size_t len, int *p_err);
+int parse_one_of_deprecated(const char *msg, const char *realval,
+			    const char * const *list,
+			    size_t len, int *p_err);
 bool parse_on_off(const char *msg, const char *realval, int *p_err);
 
 int parse_mapping_num_all(__u32 *keyp, const char *key);
diff --git a/ip/ipmacsec.c b/ip/ipmacsec.c
index 476a6d1d..fc4c8631 100644
--- a/ip/ipmacsec.c
+++ b/ip/ipmacsec.c
@@ -1457,8 +1457,10 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("expected replay window size", *argv);
 		} else if (strcmp(*argv, "validate") == 0) {
 			NEXT_ARG();
-			validate = parse_one_of("validate", *argv, validate_str,
-						ARRAY_SIZE(validate_str), &ret);
+			validate = parse_one_of_deprecated("validate", *argv,
+							   validate_str,
+							   ARRAY_SIZE(validate_str),
+							   &ret);
 			if (ret != 0)
 				return ret;
 			addattr8(n, MACSEC_BUFLEN,
diff --git a/lib/utils.c b/lib/utils.c
index f1ca3852..9142dc1d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1758,6 +1758,13 @@ int parse_one_of(const char *msg, const char *realval, const char * const *list,
 	return __parse_one_of(msg, realval, list, len, p_err, matches);
 }
 
+int parse_one_of_deprecated(const char *msg, const char *realval,
+			    const char * const *list,
+			    size_t len, int *p_err)
+{
+	return __parse_one_of(msg, realval, list, len, p_err, matches);
+}
+
 bool parse_on_off(const char *msg, const char *realval, int *p_err)
 {
 	static const char * const values_on_off[] = { "off", "on" };
-- 
2.41.0


