Return-Path: <netdev+bounces-50102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48387F4A33
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B91F21D8A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8934E60F;
	Wed, 22 Nov 2023 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HH+ei9NT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A61B8
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTOx1PAMyydcNzVcboXwnflidP8Mk1LJEHzHGFhzUCg/sY+ZUqg96cR9vyQC/whxzcro6ve7opwe8OYuavImqiTUah0Ybod8vEygF608l45R7u+1Dq6KKl0y+TEo1exGCU/SiGj+SwLc5sJL/QqXo+6Z0uOPmvlci8CYqu7/zjaKHtTP34H8LzTm/q+jiDw3XxdFZe+7Xi1iAak41AraZo+LIZGFLI+oB5G4zvLzXUBuOx6+9uQok8v7k4LD+oPUkfdlxLxgQqFlpZy4wJrf0ADFH6PmP5OXJDQUu/vTkxmtvshCRzOPn3d/hwaIMKaL6TyrounxlGXL22swMJkbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNJmNDBiPHI/wQdUFK82KDN3a6aJLtxdQvDCsuleVLs=;
 b=CO27oDriF95UjiY6I/484zFZozvtn8mwcMwQCuwBBvpbM9jVbPERCYGUxeXY273svpO+Wq+1m2K6lJ1kZZkyf5ZPMe+7KV6HGwDP45PwwbP+sqXODNaDd2yv9m4sbXFQWhyh7g2jAtCaMoGy7T5Z4o5PHysqsDsnc1OhY7IqaEWsm5mpJl5I4WCTJsKcm7gWsZIrk2uv3l4oQ1l1mKn0+KwbQPsbqrEb6Fq4LtsGBSVzgCOWENmOfkpwkht0afwE9x+Qb4DZTIKS1qghjT/IOOSZcMau5V0ElKhhhZWTg6TM7gKQ+2TvlYF9OjrwgY1kbGPX9OXq/qYQXWfQWkES5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNJmNDBiPHI/wQdUFK82KDN3a6aJLtxdQvDCsuleVLs=;
 b=HH+ei9NTMOM+HNzG9Uk8cP426Atish+VOHo3CREsKoTQlp06FJfOotknPEEeghgRbHgp+pHilv8COkOfugdBdQKQYim9PHqipEnAn3jgCP5Bf0iq7ErNU4UfSxWVAFZrNAM2TXm5ueqN7we9TxztJayjVlbwcd/ZoKCxzkHMO8bnuYmEa6JCqFb2O3+Ji6+ZIw36Hm3dmWxKwDBdh/zOvAY30RSboT6jcJ+H2nMWOK/GbX3NTX/X5qO3vJcSFhXbHg5qu4XDiYwPIBxIQ8WypwSUluDyIPbbYT31gSbGK/Xk/Qql8lMwZtqzSaODmTjkdYxZufCRJuQ4DOW45n0eGA==
Received: from BN8PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:94::33)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 15:24:17 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::7f) by BN8PR03CA0020.outlook.office365.com
 (2603:10b6:408:94::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:03 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:01 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Matteo Croce <mcroce@redhat.com>
Subject: [PATCH iproute2-next v2 1/5] lib: utils: Switch matches() to returning int again
Date: Wed, 22 Nov 2023 16:23:28 +0100
Message-ID: <7f3153037fd56a99b25cca45de7a4b8000a41190.1700666420.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM6PR12MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: d2074828-a035-42d3-9831-08dbeb6f1729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dl8ojIrbJ6ETQGgtOk1ggmJ60enVAa8rwXOcbTVgBo/XW9X4AcAgwcvvXuPFhCXtobCtj/DyXbarBRl+Vi5nmMLtgIqENU2fnfS8I6QIIGQLbQanHfAllJig6D/2Adakh7FnC7P34nzJCdlBq96ozvW0SNO9bv/xcqgS3qYH07KBO/AE7xQPcyCZ8DanyK5VXVGCFj/nZwRm/n8wd/fYY/29sbgcGBAdk/6TMPk7Seu0iqejA2KOxk2/S/P61Lnp4SEt5EmTxzdC5QH+oUHKQa/9zcye8IqYBRt2QNSEMIaq3LcaohvZZzoSjaunjy5gLQ+cIJzHdJoyQzYjKEUjLnNtmrsJx8T9lLaXIKP5tdzodkulp/bmZzs5IWMN3Z7VrwL86NFGNrsymVylfr15xbihJXhgkBbbzac3ukGANS2VP891OBIRTOBaj1Kzeqinnc+wB+8n5wexnUDTaB8HJ3emnvIImkaWpjiuxEBy+uu2Rdrq0N1j4EJRSLEUySzOrCdyhv0mv3RxHNrZxTHwRNRsNETVIOeGr24EELj1sJALP0NuknZ0BQOlmWTIzAGQ0KJNlxEdsCfsdOibKcIDSsGrmPb7t6eJl1c3Z31BsKxNcE5BgtJGrrIsGhHBYpKTBRiJ42+jOp7iM56gveUtpjHvtdGgviVxaEdQJUjN3pGwtkvFaSbTjTqgL7ejs/KD/imJiAloqulszxXS5oYzOZ0xnb89Ba8wRhJGM8JVo86ysve4MjlCW22uj4AGTPpY
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(8676002)(4326008)(356005)(8936002)(7636003)(5660300002)(2616005)(478600001)(83380400001)(40480700001)(82740400003)(6666004)(2906002)(54906003)(110136005)(70206006)(70586007)(316002)(41300700001)(36860700001)(40460700003)(336012)(426003)(26005)(36756003)(47076005)(86362001)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:16.4149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2074828-a035-42d3-9831-08dbeb6f1729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910

Since commit 1f420318bda3 ("utils: don't match empty strings as prefixes")
the function has pretended to return a boolean. But every user expects it
to return zero on success and a non-zero value on failure, like strcmp().
Even the function itself actually returns "true" to mean "no match". This
only makes sense if one considers a boolean to be a one-bit unsigned
integer with no inherent meaning, which I do not think is reasonable.

Switch the prototype back to int, and return 1 instead of true.

Cc: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/utils.h | 2 +-
 lib/utils.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index f26ed822..add55bfa 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -198,7 +198,7 @@ int check_ifname(const char *);
 int check_altifname(const char *name);
 int get_ifname(char *, const char *);
 const char *get_ifname_rta(int ifindex, const struct rtattr *rta);
-bool matches(const char *prefix, const char *string);
+int matches(const char *prefix, const char *string);
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits);
 int inet_addr_match_rta(const inet_prefix *m, const struct rtattr *rta);
 
diff --git a/lib/utils.c b/lib/utils.c
index 99ba7a23..1fc42a9a 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -873,18 +873,18 @@ const char *get_ifname_rta(int ifindex, const struct rtattr *rta)
 	return name;
 }
 
-/* Returns false if 'prefix' is a not empty prefix of 'string'.
+/* Returns 0 if 'prefix' is a not empty prefix of 'string', != 0 otherwise.
  */
-bool matches(const char *prefix, const char *string)
+int matches(const char *prefix, const char *string)
 {
 	if (!*prefix)
-		return true;
+		return 1;
 	while (*string && *prefix == *string) {
 		prefix++;
 		string++;
 	}
 
-	return !!*prefix;
+	return *prefix;
 }
 
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits)
-- 
2.41.0


