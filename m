Return-Path: <netdev+bounces-291301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEmgJ4U5FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:59:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04655CA367
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A6F3023DEA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329637FF57;
	Mon, 25 May 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZPecvSr"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A937FF64
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710300; cv=fail; b=B3pnR42dfMS88fT6VcMmPQsK6uiCaoF2d78IMtpBLYZLcEjR7rS9sBTqUFSug6r7WPBrq/5+mT8uz1KAZFR78cqhWXAvMTK+bUNimb53hJu7PxYfVDNP+vBdVE0EOyjBCnREPemiGxBKHxk01uqf+eZM4vDL192P9KN7Yyh6en0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710300; c=relaxed/simple;
	bh=kAziLnWoAxS9bRUUd2JYIbDfHQhD9vYxv8R5ulo6ue4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdkjnhCxUG8PuKcQ7fTPP3CZfDKmFRyArQLwl1+SySfgczVYcQRRGKIpLLd8HLfuS+No9DiHiF6KDh7XG0S6+cnS1yBny0lmhghKtqJL7ADLevnJXcw1C5UIUMFGwn1rqpcmGuXB0yuUpOAhM8wfKFUFt7k5WJZPDJ0SvSRNpF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZPecvSr; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KU5KvECBvELIZC4sss/4ZdUVGMRR9Hqhe93T+udOZAL56N+wMv16eDlJ+0IF3nCgYxwVkggU/sT8pBCoYQ8iZzUcUv+rYdR0uhPUDLNsEzjff2lg3IS57+rD0WPg3WnaORQ97jt9Xzn7EjdBVxtEanME/WovHqPMD089hFZE/EoCkN2Ec/bFEE4uqqc0Wj4EgkhJQN+V/T2ZLb3LmcX9WY5sj3b6ZxJFfqFflE6LzetxF8blEJZXa65xhpfF+ZxzLy6KOGqQ7Ahd6ExtZBnK9zfux2PO32C4gP/3pduxITWFoiggsr/d0jgBb5t9u9fzQ9SRfPKYGGX2jiLPjyn7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjku5GMIYy0+i4KvKUV+2eb+QnsMAA3sY6mKqehgTHs=;
 b=kZt+8mDN6fgmfzFq0tARjlQaepLjK4ZTfEyNgjksAnbWSOWBNv5lJUYJPY9h7F5UzCtJuqo7mcCxbsmemcGcYER9tdfb/S2HDkvGTu0k1LCmjYEy7kgVLalmEjwpEIF6Vc0SAY7lfBsFlLpof0zRXsoh2uOPczkRIkUOLwR3f4okzyhQju4J+TfQWb8/KH1xJLTb3WOjtrzqge37Piok4t7dtiq8QTM40Cm+Aaiu1VgHAhUtr7S8jMzQxN4tCCBm+w5o+9KRkE8I2PuvtyIUf0rHt1DLxw/PqB+B+vQO+FEiFhCkm6EJMlv+tBloL0Q4cB5t0zapCjVNW7g515e3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjku5GMIYy0+i4KvKUV+2eb+QnsMAA3sY6mKqehgTHs=;
 b=DZPecvSrTc2O8oSddDNUTJ2FeadBBJM+MmTDt4ucgvsxSIqcz43NKYRClJkP0nYMszeS3sW016d158XVHGr9Bfi8/a+tLCMxdzRM138Rfzwwoq1AxixbVfvyDlchizzgZ1jJItSPD5s6jGajCFPTfxPl/jGEI7FTgd/HCeV1bIRDA+OWY0asS08+Ly8+NeSbtBLhNXNWgTezHdjWEWT6mPBKzFI2xNn2mG3Uf8gB8V+L3fF7ZGDK6YjfqFbizfDzR/VE2KV9yBLRPAM8iT0r1TU6wOFs3ArjLEKkF/G4HBveIs4RkYZHxxWdxAsQ1+3JiBCRihsY3G/A+ffpdTWawg==
Received: from SN6PR04CA0084.namprd04.prod.outlook.com (2603:10b6:805:f2::25)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:58:14 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::33) by SN6PR04CA0084.outlook.office365.com
 (2603:10b6:805:f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:58:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:58:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:58:00 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 5/5] ethtool: Add man page and bash completion for 'pages on|off'
Date: Mon, 25 May 2026 14:57:34 +0300
Message-ID: <ea6c51ce65e89e819c1c7be01f97c79a1f127281.1779694603.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779694603.git.danieller@nvidia.com>
References: <cover.1779694603.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 353c4e8d-0b19-43b6-1c33-08deba54e6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	FiwK4uA90y2t13JPLj5Cmd62T20qT7FvS+puVJ0tAOEgcwApzasDD/fkBYzOwSvp9N4m6xZ2b+wgKXzxq9lgOkDM4krzXrvXMTSvBHn8bDGBKu0meUwQ9bEf0P4xB7WlzZCrg9+sqzMsQMBuONJRgjRVRr+39TER5iSvKcmyoKb8Tf+shgA0uMJ0i8Pk5Cb3hJpWV952As+p4g6EWRzqxWYrm5ald+xrQMTd9MpFog5T9AJ2szA6ESy/6rbQbxmm1FfsEcupPoH1bPlAzonDwnV9S0v4C49761Mz6RMjfJqM7wan4eGuenubGK7qFCE8hsX8KrjrDflzp/hT4vW1gTV67gJr99FmNkKjwSQIQNCEGmK4OfuKqdvYRCvhdFRDXEnbWPsUWCj1FE3zm2B8THO2QaJc0bJ/QKSTZYp5oF04hDH5+zHw2hvG6Uqs0Q3DTW9AQokOFg1MYXOigg1xE4QgNdqj8c2wdDpHuDPr5tHVxHQ/dDmW365Gr+lHoMpwWEion5xxEJifSLtIF1aa6ogJwjMtIOclMmHPjE+bXFq1iBho+Zd/9JDjjEs78wnlYCsq4tJ0BhtDZuxs3ryImG8sSjoZ9J3Zx70EvueYqjbPo6ifjvPp7PM2WmYh2dpEA7kWfX2b1HMZqGQ0+6lkX431Ievj3V8PLvpZEPeZ6++Rhw9UAOhFlzPPON4UARiQMr9/+6UkWdzO87UafugDuTQmWiqb5Nc2SRjqEEQsRa0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HtTzWJ6vXl6pmVrZXYV6wQ2ox4rmehhMZpxU0kUyuPEGTQaJHZPkq/GiaeN+ExJQ8QOx+d/Gb8RLHhDa0OFH+0AqmfQH2VpkJA4ssUXdeZ0GAcypVDpvfkjokBVunKfbTXCZlCVNqDJcCz83i1GbiOu3qO90DVtzi7oRYpDNKyToBGB2dsROK9jHH9QNGwtytQstkN74qKCD5x0p9bPnmi6mqKDf6pJWhVqJsV60XY2Y8k+KdMEUKfNN4Q7LetezS5H6uBWOPYIh3h4v93ZmmPe3gz2p9mIuHuFBJN9eRuSOs0E3pWlSybqVMTMghlDIDziss4lsoMwklEf8DZrBYDMX0e9Iwz0lnSS8/oZBRjNvppsuVtuYCwaBg5lZCA6WRV/bnYs0JXw9leTchoqrl9H/RC0U0BcfBd+eERFoVUrhTAcMThm7vHtwhOVriy3F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:14.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353c4e8d-0b19-43b6-1c33-08deba54e6de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,8.in:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F04655CA367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add 'pages on|off' to the bash completion for ethtool -m and the
ethtool man page.

The man page documents that 'pages on' requires 'hex on', describes the
per-page header format, and notes that it cannot be combined with
offset, length, page, bank or i2c parameters.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Drop "length" from the documented JSON field list; add a note
    	  that the "data" array length equals the memory block length.
    
    v2:
    	* Document the JSON output format.

 ethtool.8.in                  | 19 +++++++++++++++++++
 shell-completion/bash/ethtool |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 32b971a..3173287 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -403,6 +403,7 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .B2 raw on off
 .B2 hex on off
+.B2 pages on off
 .BN offset
 .BN length
 .BN page
@@ -1431,6 +1432,24 @@ allowed. In such a case
 and
 .I length
 parameters are treated relatively to EEPROM page boundaries.
+When
+.B hex on pages on
+is specified, dumps all relevant EEPROM pages in hex, organized by page.
+Each page is preceded by a header identifying the page number. For banked pages,
+the bank number is also shown, and for SFP modules, the I2C address is also
+shown, as different parts of the EEPROM memory map are accessible via different
+I2C addresses. The set of pages dumped matches what the pretty-printer reads for
+each module type. This option cannot be combined with
+.I offset, length, page, bank
+or
+.I i2c
+parameters. When combined with
+.BI \-\-json ,
+the output is a JSON object with a "pages" array. Each element is an
+object with the fields "bank", "page", "offset", "i2c_address" and "data",
+emitted unconditionally regardless of module type. "data" is an array of
+lowercase hex strings, one per byte; its length is the length of the
+memory block.
 .TP
 .B \-\-show\-priv\-flags
 Queries the specified network device for its private flags.  The
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index 57c39c4..7a319a9 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -671,11 +671,13 @@ _ethtool_module_info()
 		[hex]=1
 		[length]=1
 		[offset]=1
+		[pages]=1
 		[raw]=1
 	)
 
 	case "$prev" in
 		hex|\
+		pages|\
 		raw)
 			COMPREPLY=( $( compgen -W 'on off' -- "$cur" ) )
 			return ;;
-- 
2.51.0


