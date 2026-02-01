Return-Path: <netdev+bounces-255639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LXSN4R4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51920C661D
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE956304B5A5
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9D253B42;
	Sun,  1 Feb 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHJRK1KR"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E4242D91;
	Sun,  1 Feb 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961328; cv=fail; b=WHzSUjrCM6hMOozuOwLfLWetQpWBIPYknt3pnx97AVmF2Wad0jU/1nrJeTc9au8MA6ouH5t00G8kQNEj78ATKADlAe0dJG68YeICA1cuo1HoNqoSmMz6k9ALzm45rYPlbMelRcBsB/ECXvOyOKAdWxkzBXTgHeloazr2VDqdGxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961328; c=relaxed/simple;
	bh=ceWZJptu1piLkCfhiwrs5whX/3ZeHgdJY3QiG+H8jzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj2dKhnRhDCNsWbHVywhHJpsJSQ9lza7eyrJrdNyKijQnzXRs5iuVwRvqsO8dwylxSdA79MPBbkgMmULTAgWbB12ThPjuNMnN5KoXbbngpg/1UE26Rr/hSKFoP3Z0xuJEGh1Fyk1WgKcfV/L/qVYUmx1FMT8YkT0CGI7jMmyhwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHJRK1KR; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb5PKhOrTMcco/pU5GyN1XJQFTKpGzS78P0TnwTJrSHDE5mT6jEKIDRrbfm2fWmNK1TBaEyzyl72McQr2s6+LhEbo2L+DHEE9mVDq+bf9KPR7xxCgXwMESwkeZwT5Hsl6mpqcL42Xh0CsCN4rajrn7OuNSmW6OwS1O98XDItmiCyqMRQq7BecH0aivG5Ip8uTusoiJzELH1ZDN/qKRzcj5CBST0S8Nc5duWpRSuAyksSmJC1XQHJkIMQ1mLLYC70v2Eeq68B4GFc4e5wL3ouNNgwrOxK8leTHNETEhq1ryQVVeEbUz8BUnJX1brrakQq5vsLGJmhbgpGNpwjpJxXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f81fxiHNK0t2bLmp+UkmRmHcD8yxx/h+9q8kuVcCMiE=;
 b=pCpmMg0NqoobZ7AiieoipZ3CPGY/u3RRdFbgfO1ug5aYv5D5QcddKa2rEahCSHUqNXIuo+ZZBhNn8WU8vHNCGYh0JTgaskieIH/hYBoht5zt6YMrQEnxCrwLbRKmQDiT7NhRDgV8YDAUE9ecVPdj/l+aL8Zv0GGBlnackXhMjEoJfqow7Yeiutrr5MihRQhAT+LGHc2t3Y1yNACol3Ae7clnRIkNgOaYkBNSs3IBfiEBOR1WAqSkH2AurZHCIg5CY6CNtN7MFIGY3okD4z866soCcgMvQeEPRUnUxg3vw7Ni4Sa8XG1PoSNBNLPknZxdip21lzFtirGyCmzJYqGZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f81fxiHNK0t2bLmp+UkmRmHcD8yxx/h+9q8kuVcCMiE=;
 b=WHJRK1KRNsyfEwhC6dLfv5h9ux1BlRTjYd9kk1yLboUToi7EagZyd8ftYowuqlhIKdCi5t6uQYO7ZzIsRHGsELTB1cZzrfneLENoX7/pHznNuBtvGB43SfCm5Hy/HZ092oKCcUZPV274RXP+DtErcBNGa+vh3RJmXeiFFlyHdak=
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:21 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::69) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Sun, 1
 Feb 2026 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:08 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:07 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 14/22] cxl: Define a driver interface for DPA allocation
Date: Sun, 1 Feb 2026 15:54:30 +0000
Message-ID: <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a29d45-faaa-4078-79d3-08de61aa4de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fD+GBlFkkfJQGepdpPwE7/iyL6QLfvPZbZHBzDkoGAXZ4LEZk8nJgcfX9vRG?=
 =?us-ascii?Q?t8Ifxn1UHmIQfroCAfsVihtVMcr69GBBYPitELtYLYxJR3Plx/QSYj4OIOhX?=
 =?us-ascii?Q?vvBVPBT1bH8AGC6GjTh4rcBsiHArWU076QLNsgLO40uBDNPE3cis+ohcZTzY?=
 =?us-ascii?Q?pQHuJQ8mDAeKy6HjMmRe0si4FZ3jscPRd+n1vd+dhGpBnzZSkA8mGmPhJ9pT?=
 =?us-ascii?Q?euV+ZXfsvo5Qmdv2SXjigTv0ptPPNRmqnIeKXDrkRm3XHJESlFAGeO18I94z?=
 =?us-ascii?Q?07raTMOTsAv5RgQw+KBlFA1yc4j8cIrddGFCRvWtCvU6BXoVOYo+bH0vx3EZ?=
 =?us-ascii?Q?H25BnYX+CHfVA16I8J21+3pUFRxDY8ZeUkGOGnvBlUVz26dTrH2QFh3XYr26?=
 =?us-ascii?Q?cyJovYMhcweywSUk6xphRM1dfzvXpSwDgPmExnxMUa+Q6aZc6e7ffb3/dej4?=
 =?us-ascii?Q?FDb0LWYC2epiXuU+AgY7Xw6jHUneKhry0WtYEt1W1Ur03BU+IX36yS0Eyc4o?=
 =?us-ascii?Q?wI6914hQOaGJoCyXVizzDqC4DgaMWXmKGl7wlfLPC+PfDuq8J7qU/2xycUN9?=
 =?us-ascii?Q?wOwa82SioRpJziKtJfixohbxUWRYcov1N6Je9GxPsFP1Lbp/nY35k+RdbHZA?=
 =?us-ascii?Q?MXGqYhcpomvKH4wcX71SVcTmIGQ9v2Yu8RRVfvYJ3ElukCmr2Z0oQrfIZMHK?=
 =?us-ascii?Q?gW8xfQWIemu6frUKPEmfGNnJLO0igdjNR3IAfOTTqtadD5cpP3Tsi6yXXl4e?=
 =?us-ascii?Q?P1ePXCRsWT9MyHSerRjS0zg6VJdra/ag9DfXej+zYf8Y5X8Wq8ebQPsayJrv?=
 =?us-ascii?Q?7aX5di743VfsJS42qzsjWysMpxV/1gE82xZlReOitlmZUGeiUKNiGNDqq4gn?=
 =?us-ascii?Q?NV5WpY5mciLc34xYA5NrgtxXP/KSTIAcnG47uha3Cl/HlKXdmVDgzL+uDOda?=
 =?us-ascii?Q?CetqGncTL0w4GCfItqt8Adkl8++rNkoXf1FV6WcE2nkt3RPSfbeFrqF4th4q?=
 =?us-ascii?Q?T6f2OHE5iBGyDYIONgNqUgCTWz70MJmekQZoZZbI53cMsvJNqYm1JX7+P7bA?=
 =?us-ascii?Q?1/w7hpP96L+W+qtXK0B59vb8BlFbAFLAMAFgjGy/FHe8Jz0mjogZUKWAJrb6?=
 =?us-ascii?Q?jHK0S/3CR/tZMXELWWBQxVxSo3vzMWAlYBXA38al0KKzHwgbs5qsFkzgRz3a?=
 =?us-ascii?Q?XoYtnCXxgDTykHnltGHIi17hgD3034tfoQUfbzYdAGP9KcWV+Eq1pmDIfALW?=
 =?us-ascii?Q?Ok6aLVMXB9jbAAiMMT5F1QUoeNrMWaVeedZ6iF2wl46PG9ky1YHH0yY3npTd?=
 =?us-ascii?Q?NW3hzq8FSoLGjQBQt2u+IrKuBBYI+WiNfM3plnIDiDX4ME/7yvtPoClIkz5B?=
 =?us-ascii?Q?ScpRPssOLrKy4x9XRCc7XkhmS5Amm1S514mka9dIFHbTDg1cXRw+4GTKwZBt?=
 =?us-ascii?Q?tTtdLtAd6jqeyQjhH1T8aS7Rwfemp3QIA5H0gHu2glxhCo1vbzHBHKlwMK4s?=
 =?us-ascii?Q?rQacjqiqJwsla6Golt0zKT8BBPXBV6o0yg2E0etEjdLnS+oHeSx8ZSTfSI5W?=
 =?us-ascii?Q?NNcV/cMmkHt7Iaky0MnA35VRQ9qE/RFKv87q0MM34FgW5+5+c+cSNwfGpB1w?=
 =?us-ascii?Q?cOqWerDpiYhAaUM1Muy8e/Pi5rijs3yQ53zkeVm7l3MJwqoJMOVds7qLh2zs?=
 =?us-ascii?Q?7OCwrYnBBg7/XaqlPvy+gghUbyY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uYaEGK4oBNB2A+LJwWtfS/zS78mfuaJ6VzfXv+muGVDMw58L5jPKRDJkeD/07ZGVwwtLIYMYWSEQM85EL7q4zpiIWHlKF+YNbefRhYFkuT2iPEECRSDVez1PEXhNobUNfhNuVLJNuILz2fYYKI9eLc04Eik8zntV2djl4H50Ed/5VhiVCUJJ6N+nsQHme62hHD23nm186wSrvnZN/QeiHxVwzVIwir91lYeFg/07Pf69LB9MJEbBgNKECp84aEpzK5iLzbiQ9xB3krWg71APeaW9FQtMzHuE1ALvhaLJ10fbeqmIseqkptMAJXAypXPgZ8MTAo4siTSC5cHpNJOxdml45C8O2oj8OhKr7+N8fWeOLiF44iHUTYXFNv6l9ikxj7wN4aWyA6DiYsJHcULUsjJ6rR8kPQ2QroVlKvZO07KH9AmltXJ9RPf8tA/zWVey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:21.2193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a29d45-faaa-4078-79d3-08de61aa4de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255639-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 51920C661D
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace().

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 90 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a172ce4e9b19..d60a697f12cc 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
 	return resource_contains(res, &_addr);
 }
 
+/**
+ * cxl_dpa_free - release DPA (Device Physical Address)
+ * @cxled: endpoint decoder linked to the DPA
+ *
+ * Returns 0 or error.
+ */
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
@@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int find_free_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	return cxled->cxld.id == (port->hdm_end + 1);
+}
+
+static struct cxl_endpoint_decoder *
+cxl_find_free_decoder(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	dev = device_find_child(&endpoint->dev, NULL,
+				find_free_decoder);
+	if (!dev)
+		return NULL;
+
+	return to_cxl_endpoint_decoder(dev);
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @mode: CXL partition mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
+ * an errno encoded pointer on failure.
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but which could not be fully
+ * available due to HPA constraints.
+ *
+ * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc)
+{
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
+		cxl_find_free_decoder(cxlmd);
+
+	if (!cxled)
+		return ERR_PTR(-ENODEV);
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d1b010e5e1d0..2b1f7d687a0e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -667,6 +667,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 783ad570a6eb..4802371db00e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -276,4 +277,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


