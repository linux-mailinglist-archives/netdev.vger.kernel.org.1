Return-Path: <netdev+bounces-258966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xipIMEHDk2lV8QEAu9opvQ
	(envelope-from <netdev+bounces-258966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F712148656
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75721300D614
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3221146C;
	Tue, 17 Feb 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aXuFt9Eh"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5FEEC0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771291453; cv=fail; b=VBdYD6XCTPd+vyH3AxDdidetC/SkcjCuXR+4Ok5J1YE1vKz1UpLHK2GLpUMatqhBejuFFVEUhP7IMuQ6shuVo30r4Cyv5aaThJ8hfqi7Gn7HIRdPlh4ZQhEsN8NaEVp5RYLI9vKPog26LIsR1BvsUjLg8WKvoMLPCjJhuWk6vD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771291453; c=relaxed/simple;
	bh=OUzD9pPVPHXUaE3vFg2fHvvY6Vhsu4OuOpEn+UrBhAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RdcnnLKrGwP4zUXTGRHnIXRsE+DRO8DVFkJGHEABAjIuHB9YqTphbSU7xZNoD6s9vawhdC36/lU9EqnP5bogZK7loC7kq5xpopoxKVokIOuRfkT6AWNRGfOf1e9TnRutL/A+G6HoNDxH82a1Xa/vZM8ZiV+zDGl7pHYLsSfgeps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aXuFt9Eh; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlkRzKBwz4A5n8dI/feSdEB0fh0JeU6+yMMMwrRGr88n5aqbihf5XlDmQmlzy0CoT/DRy8KZA5WQEIPdqLH1QuKpsz4AGmEiA4EkC654qrJY4eLQswuQSjfRGrG2e3dHYx1bXP2xltjaje585SkNeV8b0CA+U0l34m8zFJP381xBav0KJ+IyWNIoi/J0AjOa0y+YUTxXqsTA1g5LHg4p/jh49ioglVs8xznnFv8a2IDjIXcncE2ptm00ZQCwDFvbYr4kZ3MuhJhje8sZDYNrF8a5jWkSjRp8Zs1+YJi1yLiYKhT/5xO22M7O0gQZL/eIFImwedOxM8OuTrA817yvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSXSZqPsnVU7Y/6YWt1sCnxKdQX+9f83diCwfUOWUYE=;
 b=mcM3/8RVUQXVK8OEzcRjXjdEVNez4++7euK4PcRZrFolJ5FrEiX0agFetbNUAf7521TiKN1AK3EXLIlufocVC9g1nzy+aedS8iiSGt289sgjJ9mnL2+xUhv0vv29f+11QnvP0QoWSU902upZ3+sTTTaHeu9c09KKiSFMvGLy0S57AHw/o0GhxjUUtXULIOYkebD1OxbaeEE+d4u8VjtnFvNiOkbweDCwyTaCWS9s03xKnjVq1CdYEelS4vGHDDFrkwt7dMuJlubtw3p538kIWqJUNvyVdt7SZECTKBpuhzGNjEUj0IXy1mRV7kjKDZDFoAj9+fXtCo7eMXulCezo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSXSZqPsnVU7Y/6YWt1sCnxKdQX+9f83diCwfUOWUYE=;
 b=aXuFt9EhOdT0wDthSJYBJ3sOyy2fsChCOOv8O8yTpSNBVgsqAl3ZaXhQvLGj9Epcp9S7ZiO5agmDddSAxtMhiTgqKa/RvDBcmIiXbXkkruQF/h41T8z/mTNyZ3tD3+l1VfP+c8LtDDkzzV+u2fXIxHuMTVl5uMmFh7u/gfi65ok=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 01:24:04 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::ac) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via Frontend Transport; Tue,
 17 Feb 2026 01:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 01:24:03 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 19:24:02 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v3 0/2] xsk: Fixes for AF_XDP fragment handling
Date: Tue, 17 Feb 2026 01:22:12 +0000
Message-ID: <20260217012346.22468-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d6675b-3684-4ce5-e04a-08de6dc33cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1PnQGhkkdUKpGnFBLOLEuxmIXZVJnidNKA19PkJezh//s2bNYzfWeNqA5vG?=
 =?us-ascii?Q?IFyowDriWtzlz0x1IPl6sSFOkoEUzRsy5bEo24aQseuMtbe/8yJSBoqEc8Qv?=
 =?us-ascii?Q?gab4pcCB4vyk4g8M//A38Zg1Ef6nQquHRSdBkmzNihvAkcGw4n0Jp0KRnPR1?=
 =?us-ascii?Q?mwfOQCVuL0686ZPpRzkTmlWjK7v1miznM5GW/m2WZl2urNPtkpk3mOsj+6ms?=
 =?us-ascii?Q?koTm7ADrnbeotlqvT0KjvQYufBmBgfd7WDoJoC6OKuE0JTfhdYyBNz9NIG5t?=
 =?us-ascii?Q?CtmaJSHdOLRlEs4eDCNKixuzTVgKkT/J92nNyDIUk7JOwibLOF4/h7rhvwcy?=
 =?us-ascii?Q?26TEYyPyQeJJHO+yxsECeztGUi3VujiKLx8vHyiRqX+U45u5SwF+8SfUCcmr?=
 =?us-ascii?Q?RESaqNAEfu0Oo3dJK8GH5D8vg1hijPZqmgr2TngJRlyTy1LK/gddzw2fewXM?=
 =?us-ascii?Q?QpOu1mHwd+lcRlkw1f1HIrZPbzriAkMMnGvc2RVAiVzSW0YZIxUekBp5Ttik?=
 =?us-ascii?Q?/nlMRva8KiL+vR6JiDgNI2u0ohdgvFOSP4fvsS4EzWe3q9E9AGfGO5NxMXLS?=
 =?us-ascii?Q?ofAru4iLDTsyawB6IfweRgie4BCu7Si/E/7niNicbMVge+0Zyqi1rbs24ksO?=
 =?us-ascii?Q?TQp7nlpTNqoIMsJGzib8H069NuWskNAjq2Y/deLUgNwOen8EFQEOXN1RQWfy?=
 =?us-ascii?Q?0XOu9PZUu3stIVa9w4Jsaw7AcSjOxMkrU/bicvqpHS86ArDQIrG7ZM58GXg2?=
 =?us-ascii?Q?svftEECs82PmdKpziIk7toh5LSkOWOd0GFyff8pYobX6FE24dhZ+uJRZ/gjX?=
 =?us-ascii?Q?7J2wrqZgjvoZKqEM6L/ACkKWxG6fApffihh2e07TLL4MKe5pY+rvACMs1qsn?=
 =?us-ascii?Q?mIT+Tb57D0AUj150mOE5ujFc3/BccopIAS5ScJffYmo7IytukFKEXde7T/ia?=
 =?us-ascii?Q?oPnM5tmneCBXAujscur2+XW3dEMWQsgXvvZiVPXri4FeCcQl8KXY24HEDPvR?=
 =?us-ascii?Q?fzPbepTbep7Jzlvc5KzjPza3fpouZk4g+q9dYZ6XOtUksR6Wu9lfLXSDTlWw?=
 =?us-ascii?Q?30dh66/yFyY+BV4TOEcXpnyZ9FREQ0I0sri3wC3N1+CudwXyn7Kb94oyMxr1?=
 =?us-ascii?Q?Yy6Mn4F7d/elGslYdxvDbR/10d5xzQY/fcQlNEYAfo4AhrCrThU7MA4Oiv74?=
 =?us-ascii?Q?9WGtZCfrs1TSOjzSAqckDQN4cU1h0GZUQZOAq+/Iv5+ugbcR3E7wDLdV5ON8?=
 =?us-ascii?Q?zYxgNhcMQtJpOvxmz48lEWl1tydd6G3FeWqkz5xND2mxT+JnDW689tO9FIk1?=
 =?us-ascii?Q?GyIBXGJv1kkSv6p+d/4yFBkPySmDk1UihTiOH5/a+YHLHPGlIBH/J4f5vU7n?=
 =?us-ascii?Q?33TdaFr/PDCXIdJn0iA5tfPdw3fxC1cQXe4394RUpiw5BzaR2mcQ8Llgb09w?=
 =?us-ascii?Q?OGEvN/jBCHpeossSm586tqcOlBWMBcfy2WdZ1ma6z5eCPWPJZFIEfFhnmx3v?=
 =?us-ascii?Q?CY4Z/lMqFMg8I2luFUSjknyaLjM/GmUMZlEmfV2tibSlWJxBquKWDbwTXSHt?=
 =?us-ascii?Q?jaLykJexk/L5+IgHT9tRo3nl1r6/EKknGHpQxAM95v+ITo6xlv0irWsefRnu?=
 =?us-ascii?Q?U9QDcN0e/X/szPKs1p/zYLeVCQDvDxxFuFYiImxRxe2TF8NFlZgmKsdOWjnh?=
 =?us-ascii?Q?0CM42g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GwyLHjNd4+OuPH2EFYgMWzugseoOmDR/twnb9rEZG11sWyEWFCbe5VvYtt6Zd1FatlqYBQ6mC2xvlHPdrygjFwRUCr4TJVzw12P5YC0EUDvjd2nHxE2TNt+EG/0YQkkMwz+BpAFLhOIM98zEauxwKrfysSaSl42aWgocnkf0VbJrng2o0viyTS8tMGcGNIMtUaLt0QRInCFluYDJ15IwOI9pQd27WOkL0JCAX8194e8ScFet8naIWyLuC8ekXo7RyrdLfT1qpx6x5fKKTUPRJdUvvsDwn+41xw906oM8mw7feSw29/SO6ZXXlqLp7u6+CJ3XlnkYk1fHHSwXft+RljTVJrJrEc9+k9cZHoJqQDSJU9RWroC6lOGSIjW6fmnVXcBxTFEYRSdcnj8ykeWEcPXatlHKRdKKf538p3h7N9wA9X2fNDeSNOQPlDHG02oQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:24:03.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d6675b-3684-4ce5-e04a-08de6dc33cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F712148656
X-Rspamd-Action: no action

This series fixes two issues in AF_XDP zero-copy fragment handling:

Patch 1 fixes a buffer leak caused by incorrect list node handling after
commit b692bf9a7543. The list_node field is now reused for both the xskb
pool list and the buffer free list. Using list_del() instead of
list_del_init() causes list_empty() checks in xp_free() to fail, preventing
buffers from being added to the free list.

Patch 2 fixes partial packet delivery to userspace. In the zero-copy path,
if the Rx queue fills up while enqueuing fragments, the remaining fragments
are dropped, causing the application to receive incomplete packets. The fix
ensures the Rx queue has sufficient space for all fragments before starting
to enqueue them.

v3 changes:
 - Patch 1: Carried Acked-by tags from v1 on patch 1
 - Patch 2:
   * Check for free space only for the multi-buffer case, this preserves
     single buffer performance (Maciej)
   * Fix return without freeing buffer when sufficient space for all
     fragments is not available

v2 changes:
 - Fix indentation issue reported by kernel test robot [1]

[1] https://lore.kernel.org/oe-kbuild-all/202602051720.YfZO23pZ-lkp@intel.com/




Nikhil P. Rao (2):
  xsk: Fix fragment node deletion to prevent buffer leak
  xsk: Fix zero-copy AF_XDP fragment drop

 include/net/xdp_sock_drv.h |  6 +++---
 net/xdp/xsk.c              | 24 +++++++++++++++---------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0


