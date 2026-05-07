Return-Path: <netdev+bounces-285288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMEuEkV8/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E44E7BAE
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C80D301D69D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09AD3ACA43;
	Thu,  7 May 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAP8zSvh"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3C306B3B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154484; cv=fail; b=O21wByuNxGiMT58DVUZjVMRjR6Ys3Ma+dvQ+KHTV5GaspBV7mHFhKnj5EEpVGZ+r/oNnP4k/Ae4LDKKLrPqGS+WjkanbiF9fZBX2sVDRRx51xX9c7cnYn1Rye0MCN6YAyvN3k471SeCNzn71trZK2d0xsBjWCMJiC0MpNh8mkRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154484; c=relaxed/simple;
	bh=jPa/MKf/cd7iNPT1N+Z6iJL3JAyP7FuohwsOLK+bjqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uj1L2AoIYa+8Zxxx0pCsrK7/+acgYX3pzClxHNA355zj7MUgyAb3eL6f0k9u4rmqBO49itSBGwXScV+w8WWL0Hm96IO3VPQVlgLrgFPkcY9rL+HvuM86I0gRb3Pz6eHSqUu3Gqob0oX2Bg4eXfUDOhteeFabbu2zz87+CgSQck4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAP8zSvh; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlYXffgdtheC2MKUqc3cjxjSu6Sy2rwwtNH+qeq0xgAPoUpN4c/Uu5BC4y7gGeRbSPcSLg+CWEpQRmtHC13dCDX5jsIvxPbgbPw5TAL0kWsQ71oWYqLUD7YZ9L/cAyKBxKtw/AhIZnpY6HZXlzPUvSNc+iZj+pq5T+/j3NN24MozwsxHVQb3dQgPwea2PtjcxZzwYTZOjcX4Fa19Rh3IxvM6V2kVBwMdEGfZxYF+DDFvaolsIaoVqjJe00EpWugk1cP1ZrJ33SLgE8L3LfBe3FJOZNOjWH3HIf153v9v2tsRDCjlygaUlkruwm2Dve53o13qqhGOsf6x+IV3uibWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uRDw0hpUgHhDzFSWsJJX5qDiYY3v5g0av+Z6Y8VSTo=;
 b=LQJV3uP9/vdodxTVQL0dgyN60yDZAeYady8wm+dzzmFWIZsgmEOhUIZoQTRBIdPcslrCC4f3sX4+zwpafEo7D5t6uvQese/J0Fw0ssMMhvl3VTW73hv2+7pTpyIavESVrY6JCp7rmvDAjNqz68loqzIIg+xyUxHk7Ci3M4TlMnqNGKdxAiB/EkDesjXuGZdO18XX0CHTX45xX6rgxPmhWYXKuKGZImzPAyCDvONtNPi6VBckmsgg9uknf+G+S08bpXR121uXi83gVZXeI1+X23JZ77MjZY1/ZpbjBMJ7D557EU9d57kysU4ZO+ykc5YD/oFfLg+bGeSI1qJAiaOGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uRDw0hpUgHhDzFSWsJJX5qDiYY3v5g0av+Z6Y8VSTo=;
 b=lAP8zSvhvM6+r8mIt3lPTw44UWoYdkuNG6VAQGylZ1IxHl2bFlreTvWPPyb+W7VAYr4WNGPxrFAHrbzQfN59ezEd5aB1Iw7SV4S4dF4kMnx0VZEnqXYIRipOyArU7udWsC/wZoVlpr9h1UYYcqgaiGwBo8ZllX4WQFSpy0nJXhandcW0ZsxL3SmlFUH/8MKHQWcKPodA5t1RxSV6RXm8TTW3iT87zP520hkkjGp17W/9MHblxB552QdmW84o2ehVWesS9BHrfHPLMyKagtxCDGuZ4VpgEFFml3cu4CT1O1yDFo1amsfF41VtBc9R5zy5ZifyvhJ5zCP+by+u4v6DMQ==
Received: from BN9PR03CA0307.namprd03.prod.outlook.com (2603:10b6:408:112::12)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:47:57 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::d6) by BN9PR03CA0307.outlook.office365.com
 (2603:10b6:408:112::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 11:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:47:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:43 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:41 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for module EEROM hex dump
Date: Thu, 7 May 2026 14:47:16 +0300
Message-ID: <20260507114721.3409128-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 636a8de6-b51f-4829-a84c-08deac2e7b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	cIXihY0hsRcrBkPIlJ8cyyH6FmI4kjWTceP0wS1fbGjp1vLfrLOO3kJtsDPNJy3+ZAzu4hA2xbIXUkSEdvGDvnOhrqNqBugP7jesbE7rMba2f+AEKY5kQxHmnFPsUKTAHpKoiMjVVu6n2+QdTQGNGOxs6zGyMkIyjaFQUPuEoCHt6eeFwgOuJch41O1QqvlGLUlwo3YoHEJc12wvC8C2Ho1auORC+TRQZM+9UrADCqDydED2sA9SbGMRF8oC5v6tMQISPhMBoZzXkmYumq3/s/kVR73Vv3aH8JO+LmJ1agpO1fqOR7JVCht5cQUglRkDbDlNDHHO/973tOwJefhUDVmj9TkOLmrqfLc6rx8aeaHJYJpJJ0jk087etvgKpV/W+3A5CcHBF1v40o7jcUH9OHuqJMY7CK3/HLIh9F/Z96y7e62ZIb7S7pRXtDZ7YGIR/aTYuyioxX/DkSAXW4H/l8IrSCkglqtkviw954pWHqUvx/0zmfyS8pSEYUX6ARvRi/5KvkUKSktq8pv3ek5WhrkUWeSKio7lFHvXpPhzAoggneleT0swnR0MTetBhyYJYAKkk6LKw0o0CoXbd7xm2LqW1WDDdk9xqnxZeSnOoFg44TttzINV8Ng8xABYXAm0tclCqhmf+ugieVUVXe7b6rE6V8Kr22qwVz/z1nNfwSY7URqPhi2G6UXY55TQXFaZwJ5b9Au/VKFffyT/SZPwert+cZPj2ikQPui2VEU/o+I=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XbWHzYpa7esd75fUQeCIJpGl24lmvKcl36knKS/k6HASRKHG1uvuWc6wzk0y51PkcxGP3hrMCpsHdoIMuAFUJHHoALrI7PzrQ6UECjntWGHruTIlLuJrfLOqG5flv9TbTfz+jBYeAgRuL5MH1vzzc758JvGIQpm9e4TMCr1Jev5hMhxRggaH4amEwQ18rBOiB1kZ6RRpQul3UupLiMt6zIkGZVTMVYH+Ii2/rHrXVGMrqXzA0SRysvmLmOEWr7pF7gp9ufJ++g/36CAGE8zgC1tqrKA4rw4tID2xLuath80+bUORLtP0m4/cm8BssPpPbLcEjGofrN5oCkRCzaQZyAKUaMPOVOKsj/NHpyWRAu9tkBjuAtH8uicuQ7jFtlk4lIhWJwmOmaBIyIZB6WyCrXVCZPi3eFvOZstBCEvvFfx1OIywiXxuHDFM99uNivq/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:47:57.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636a8de6-b51f-4829-a84c-08deac2e7b9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
X-Rspamd-Queue-Id: A41E44E7BAE
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,8.in:url,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

The existing 'ethtool -m' command can dump module EEPROM data either as
a parsed pretty-print or as a raw/hex dump. The pretty-printer reads
multiple pages per module type, but decodes only specific fields from them.

In practice, both outputs are often needed together for offline debugging:
the pretty-print to identify the module type and decoded fields, and the
hex dump for fields the pretty-printer does not decode. However, there is
no single command that provides the raw hex dump of all relevant pages,
organized by page boundary. This is especially problematic for CMIS
transceivers where the existing hex dump does not provide Upper Pages
beyond Page 02h, let alone banked pages.

This series adds 'pages on|off' sub-option to 'hex on|off' for
'ethtool -m':
$ ethtool -m hex on pages on

That produces a hex dump organized by page, matching exactly the pages read
by the pretty-printer for each module type.

Each page is preceded by a header identifying the page number and, for
banked modules, the bank number. For SFP, where the two memory regions
are separate I2C addresses rather than pages, the header shows the I2C
address instead.

Output example (values zeroed to omit vendor-specific identifiers):

$ ethtool -m swp61 hex on pages on
Page: 0x0

Offset          Values
------          ------
0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Page: 0x0

Offset          Values
------          ------
0x0080:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0090:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Danielle Ratson (5):
  module-common: Add module_dump_eeprom_page_hex() helper
  sfpid: Refactor sff8079_show_all_nl() to separate page retrieval from
    display
  module: Add per-type EEPROM page hex dump functions
  netlink: module-eeprom: Add 'hex on pages on' option for
    page-organized hex dump
  ethtool: Add man page and bash completion for 'pages on|off'

 cmis.c                        | 49 +++++++++++++++++++++++----
 cmis.h                        |  2 +-
 ethtool.8.in                  | 14 ++++++++
 ethtool.c                     |  1 +
 internal.h                    |  4 +--
 module-common.c               | 16 +++++++++
 module-common.h               |  3 ++
 netlink/module-eeprom.c       | 43 ++++++++++++++++++++----
 qsfp.c                        | 48 +++++++++++++++++++++++----
 sfpid.c                       | 62 +++++++++++++++++++++++++----------
 shell-completion/bash/ethtool |  2 ++
 11 files changed, 202 insertions(+), 42 deletions(-)

-- 
2.51.0


