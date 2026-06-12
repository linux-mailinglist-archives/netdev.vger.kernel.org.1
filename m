Return-Path: <netdev+bounces-298799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g12jMeF3LGoIRQQAu9opvQ
	(envelope-from <netdev+bounces-298799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D79E67C81B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:19:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mENl35bK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298799-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEA0F3184EED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A940389100;
	Fri, 12 Jun 2026 21:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB236BCC3;
	Fri, 12 Jun 2026 21:18:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299106; cv=fail; b=d9EuH2JNrMA+kkEpsHm3KlVgomjXidD46ai+JPrqVUNTwmRd99+IN1QJ+cg6tG8c5wcITC8QpdkvyVtYa+ZvCQwS+vr/8d1u1bRF+wl/AJkYBcCNkRvxmE3AoDTVF6GL2DzjxC/co+n3VPJpxfXQ9/+V5BAyKVf1ZVugKusoWN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299106; c=relaxed/simple;
	bh=Yk+wo8eBL50lsIwmgXK+ykvK0m6skPmEru0PxDHYYYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4WvBzFp29bivCDfiPCTjJ3akw1Oj5qjoI95300+9R3+ubgfOd3ClvAVso9VuEXEZt8Axnr+F7Z69T1+ZiNMDLkGGIg5FZMHjI3v6rQevorUx2kW6p9B+GgbDTgMBhu7ppbLsTuYJP9rL/PKznXU5mCXiiUk9/pV79yeo1MuWtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mENl35bK; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuszUT1jMNun+/2vSAZhzvvo7F9bORNpel/O1JXUISw8+Mt83JQgFioA9r9rWZljsf9/qmwPs+7O3Xf+NM5KVdAD+zz7uRCqLaPyWWcEDc1EVe/geHvoxKM28XJhtB7NNeH31AckUd1J5YT1Nis8T6WC4isxooxxYW8q5nQo2NxAL9Zp+j7mfLPW7ER0T2Qt59zqxi3coUsujQ+r5afDQMvJUDecaM9MAk09zFM10Qt05gh5ixSPHqfEmXIbA9uaWetAsnm8qhSpeKKPYZOB8yvS9wih8gh0x6xhEI/oJpnuvV40PjGtN2rKfHmAk6hGUSl7C5/6VQk7wqVXqznJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pry3vLapXn6RakhWlsHR4YsHhWe/0scl/PqZ4CBUU/I=;
 b=LcYBjre5lSOErrTnBEATL2/Y5z/DV1uBL9SHSi/x5D+x34IrnbYLrex7KlL0ZeaGB87YFTEVEqLSZYmtJ8F+sBOSsu05dUmRKmEAyp0/Ff9SIu4jBkpCqWKo/BeOCojZrQiZeivIubEAxzXThu5cSOwZPWmMvhbpM1M5o5xXVfu55CQJG4WITWZGTV7c07P95hExJcB539bCw29iDTH1JkJhF2dRdIfiKrWudcOua9b26itdq6W4ZqRRT021hHFW+0pgOVGvc/PZyIB2ddGIbO6z3dTIfxYzBqgHrJ2gJQF/Xf8bHyCJxMwzSn0xzznw19MYSzhe3/k1N+zXViq4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pry3vLapXn6RakhWlsHR4YsHhWe/0scl/PqZ4CBUU/I=;
 b=mENl35bKf8CLo7duse3T/Mg6G/8fPdgLQ7DxaTBU6ZekZK5UH/Wb2fT8J1m5r7WrhCULA9VznkEXmwgxxAIOTbfVRHa7sANZuHDOUpZlvxRUUVnc7IouEU1OpEriz1anuWUez5g0mAgCqJg7LExrZ5rhxw8jKXyFGYQNoD0qPiVvQIxlb51j8YpJU6BkXAAtbl6i0I5iWuiAlAAqwONOX+CKi3t3emwxQgKOkfT0NhO2N9xatMmFBqcZprB72s2hoEStTsHk+IGBnvQtdk9oDQCqwDs+0dJuoKeZOABHUImzh15i8dC9STBqDeF/77YSHRlt4ihrgAlNyvC+v/25uw==
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 21:18:20 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::37) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 21:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 21:18:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 14:18:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 14:17:59 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12 Jun
 2026 14:17:56 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] io_uring/zcrx: selftests: verify rx_buf_len for large chunks
Date: Sat, 13 Jun 2026 00:17:04 +0300
Message-ID: <20260612211709.1456966-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612211709.1456966-2-dtatulea@nvidia.com>
References: <20260612211709.1456966-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a3bf3d-378d-4d79-1539-08dec8c82022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	6tSJHX2yQJiBRlsTCEwBVpPL13sG09vj3mO3h6Lc+aekXOJJ6pYglVfGa6YKqHzAw7NdN5wB9qIlqqn6ZjZFx5ptnX51oy69Pzf5TQ/PIIlYS+w47CjQxoLKPkokmhzNiFlAv3odN1x4j2FlCklr1kvOwQMxvIxcrfGlqADHx8dwQmhNTBZd6fdCJd3n1gJSigmrMkOL3KkGbqfUmL0TD+oRXyoSBWkcC703dwZ2jqRLsgX1XcWYXIn5aTzaFI241p5UqcPCsEBQSiRGyCokgUWomwCl5Pp71adRH6T28n8Os5SVh0zj8nFJdsYUhwXeOJTI6MFI4iyFkVLXvCETZpVYOP4Fl466wowvIqdDg4N4x/+R78DK1eCQM8MlIZzfKtk7wAU0NrUEZ9An+86/ayE/CidmwKuyFK28PaNHINJrmOC1p2A0CdVFubwHGZmCPqKaV2n17ycnvuilejVaJXNwDXsPpJhFRlz/T2mq+dEYa0eNqhDPy09ulqbu1XG407xCdFLkNJZ2l24b8wEyPHhw1z5efQwoVeu78LDJxcZwJFu5jQbSXKXxoPyLNPGKnS5LlNnnheN4cUB6ohnKbb494uDVRAuXlGdPzjTFMN2q+d9H1Nj/Rc4w1Ng6C3u0vNrM8vuxlREfBJrkuks9WCcK/tbbkMZi9KBcGr/Mz25yJdHktBPJanoidTjnWNDGKNU9LxEeoE7yy3rlJE/wf4MfXflDLa+Txn/QT+5a+gY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pOLa4WAwy56vDF7BvbgjoepAkErbbc6JeTB4wXlOO9m9clJ3WVDO+axJF/UzImwlkBRRsFw+XE0wJirBrAnp1jeF7+//CbZjQLjKpo9J4JuwVjzwAs/dHGSHyvM3bEoiFJpr7epO/m66WJ+pIwKb9mt6Jqz5PY91x79UaQGIoNjR9IdBtT3iCwNl7wltipM8OrqVRuYYtwOCS8E6J0wZUNncYnQaDT0eUzSMzTmi7+VrgJQCYHzvoZGLKcGAk+Ih0VH1S3k0wkQwvHYdlhsXmW1e1Isr5AWMTKYGlxHFxYUdUtL5GQ+V6fMsY//YSukdsD5MHv41Z2hsB+f8dWUga2x++QEKw+IEM/Iwjw6/YQGlWxEu0w8KFlhP1ieUE3YEirBSO+wDnDN4+DwXP8M0xXP2mEq5SCbHSbnQH1bzyZMmNhwaRDzZfWHtdcLOMYkv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:18:19.0048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a3bf3d-378d-4d79-1539-08dec8c82022
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:dtatulea@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298799-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D79E67C81B

Check the newly added rx_buf_len page_pool field for io_uring
in the existing large-chunks test after the receiver is up.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index d72b76ba0835..b7a225fe4bea 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import re
+import resource
 import time
 from os import path
 from lib.py import ksft_run, ksft_exit, KsftSkipEx, ksft_variants, KsftNamedVariant
@@ -41,6 +42,23 @@ def set_flow_rule_rss(cfg, rss_ctx_id):
     return int(values)
 
 
+def check_iou_rx_buf_len(cfg, expected_rx_buf_len):
+    """Check the io-uring memory provider exposes the expected rx_buf_len."""
+    q = cfg.netnl.queue_get({'ifindex': cfg.ifindex, 'type': 'rx', 'id': cfg.target})
+    napi_id = q['napi-id']
+    pools = cfg.netnl.page_pool_get({}, dump=True)
+    pools = [p for p in pools if p.get('napi-id') == napi_id
+             and 'io-uring' in p]
+    if len(pools) != 1:
+        raise Exception(f"Expected 1 io-uring page pool, found {len(pools)}")
+    rx_buf_len = pools[0]['io-uring'].get('rx-buf-len')
+    if rx_buf_len is None:
+        raise KsftSkipEx("io-uring 'rx-buf-len' attribute not supported")
+    if rx_buf_len != expected_rx_buf_len:
+        raise Exception(f'Expected io-uring rx-buf-len {expected_rx_buf_len}, '
+                        f'got {rx_buf_len}')
+
+
 def single(cfg):
     channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
     channels = channels['combined-count']
@@ -156,7 +174,10 @@ def test_zcrx_large_chunks(cfg) -> None:
             defer(lambda: open(hp_file, 'w', encoding='utf-8').write(str(nr_hugepages)))
 
     single(cfg)
-    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target} -x 2"
+    page_size = resource.getpagesize()
+    nr_pages = 2
+    rx_buf_len = nr_pages * page_size
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target} -x {nr_pages}"
     tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
 
     probe = cmd(rx_cmd + " -d", fail=False)
@@ -166,6 +187,9 @@ def test_zcrx_large_chunks(cfg) -> None:
     mp_clear_wait(cfg)
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp")
+
+        check_iou_rx_buf_len(cfg, rx_buf_len)
+
         cmd(tx_cmd, host=cfg.remote)
 
 
-- 
2.54.0


