Return-Path: <netdev+bounces-290604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPU0ATprD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:29:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8DD5ABC57
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C258D302590D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1E3E7BC4;
	Thu, 21 May 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="X9MHGiq/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541633B6F8;
	Thu, 21 May 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395380; cv=fail; b=qCxRNu5gMXznH3V/5+NN10jf03oq1sVEUamTEzGK6hce+9xfs1BQoVhkH+zcSc0KJ+MRHKmjNA8D3IRGDYP2UtPbLnwRjoz0inbe0BhNryNFr7PhS+36vy7Mu53dnXCJHE3ZxW6iI6BqzLGZkj9cZ74P4f5Xpgujv7DIFY3WtFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395380; c=relaxed/simple;
	bh=lcv2/4u9wq+ndC1O6g8k4cCML91MqkD4n/7E8xzkEz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uxYyXss94rAtihenLBGo0ZhoY912rBwM7Y7EfNEHlZ3iFcugQLgiXx1MaCluiZhF796e/+hcIPIPFJZ/g4ahLdz7Hyk1ekk7XtZRdS0SYM/vchBzNEdYE0dLSe3FhYZQN3YvKxjeoqvdgQRNXU1P2LChe4dI7aHuFdP4eiXF8ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=X9MHGiq/; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC59YJasNm/cLzGONkRlY7+XarDuB5xkT/nRyIGzfIfvFYc+vBsuFcnnaZH5HHKIs+/Vbil/+5zi2Q9xYSx/IbFumoiFiX3cOa55wl+k48rex+VDH6d2qNq2vwu1GfYbOrSHwSCSN3Onfd2bQjbHA/SeyGF8NYBCNeWQ0Erkz0u/1kIJAlw56h7CGkBvTOTABbUsvrYj54AEZ+zthG/LbuhSXEyLczFTTZnyk2gXMDzHRE04wJYfzBaU00GhvnJ+h/TNB4m+Gkl/cOhoQUzkQLuPciR6zC0OQLaZr97AVRuAhuvt3dHBZVbG52tz2VVZ2gTNwJ6biISft0mvlGW2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hMihQRdL8k31bZTdyoqHS3UY3Xq/q2IYMLc+S92hR4=;
 b=Cn+x/4WqkCwQcCZQnZgDp+r7/Do7vz/MUFQ2YDcJAJFqmNiUaRUsEAc8EHlYB7Rds+Z7YbMulrc8DhrfroSw3y1otIpko/HXMShp+iUvsRbOTUNimIbvbN3fRWwNSMjhb+lfWt2bmih9u6SwiW8+soeY0coxjE+MS2d8z67Os+ng7EjRjYNvTQdZse3ObEcmG9OnZiZpRC1Bzjcd7hSWl0J0YRMYIKEDzaAoQPM3PpSuLWS1NT51WJAHmt9KurBmdVciU7rLCOP2XbKeoVg9dhpbfiixNW7+z6Waz6DmouBYHVvkTEWLEadit7ziK8q33Xh8Oac8jumXo3S5dIPIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hMihQRdL8k31bZTdyoqHS3UY3Xq/q2IYMLc+S92hR4=;
 b=X9MHGiq/6+vrA/WTnAvc7umnvDE9ty8G/LG0bIYirpu8OT5ceqE55pxaiUEWz2BuOcBtedMtUNcK1UWg0XVWF/JoxWtt+3E9W8AN0N6um4n9BO23SxOw8vekWUPENkHD98ovqKmYzBetxt3dITK4j2egrv0ku5AayXpadXKBdBdwMHAHWyJjLwKUWWdgHqT9hEm8pILdmNke7V+vlYHe4AGPxo+I/NXhsrA7XhFCSwDki/W8iHcDGj3VckBsfzolZMGSwzE+pl9cC2EI/I6v9/8atIQlRFJZmUYpMVNzhhrxKtcmE6RCxq1RXXtwMM9VT+ZaMdPU7wJQ8jhixPMJ0Q==
Received: from CWLP123CA0268.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::14)
 by PAWPR07MB9687.eurprd07.prod.outlook.com (2603:10a6:102:384::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:29:34 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::30) by CWLP123CA0268.outlook.office365.com
 (2603:10a6:400:1d5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:29:33 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 21 May 2026 22:29:33 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id C58544020B7B;
	Thu, 21 May 2026 22:29:32 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id A7CBC1005D6A; Thu, 21 May 2026 22:29:32 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next v2 0/4] mv88e6xxx: Cache scratch config3 of 6352
Date: Thu, 21 May 2026 22:29:20 +0200
Message-ID: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|PAWPR07MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4774e771-699c-461b-0f70-08deb777ab72
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pw5RIYHvjIL2DYoNZb1Ez8kdFYA99ZiD0hLCCeyhE/BsLVDeASyYB8VJF/DMqavwhOa0QC1lysQ+QzpdLgX0+6lcM8IHc6GAdAzHZzT3jFoIA7/a2vTREpnUrEFk1SuN24P17KjYG6IFU7uUZ6vYDyMWPTUPC0mJNQFY6I/MTYeD5HBVEGdfmfmpxuxt+A5J6569/AvU4DBbhLQbduBqI1DaiQI5YoR6YVKA5SU0vWCqodLR4hxP6vtdQH5qZ97XJhql8qsvJzdjvQiK1DZzxLSZMQ7VdEpBblvowcM7QWVxWbwvno90AHZp1Lg7ATFIcqguIiIttvDU6YvtAN6WkssAbh7osIEtlZhAWmHeq9eGVNftCbdqEcjzC4jGfjczWP8py5IbNrQEZASb3mkn/ZeFM5Pdvgtk4PUQGtu9WvJjOoKg2Yh6DoKkDitioAI1Jem6c7L8ypY53FbBivfBWefDAfDVmUrJcnGuZj2FpKfkbB9d9YSHb26lGHcee0QTId/QklGAkUslxu3i0hX9bWIIMfu3BdFrJ1LIjTBpCHUawFEa90/GPokTeBNto6s1LRBUHcs2yLdkvr+mK6Vb+sbLo+1/fkFpd3mG+Q59KCUu7r4/f7jRipVssvs63nOnbmsCR9FSfvfraeZVA6eIqfkzjAO3u2OB9gdN2CAQDpY+070q3zkcYk5kqp0dZgKF
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2er14lIbgeXZ5JFyvrqB8Rs8MwpDy/5CqkCOBaoDkdRyJJTx2jvlZUUDx0za1IwiSI7QTbyDqP4xu513MSn7+ezZenowVW59QhpYIh8aOPj6D0WWm0dG9rM930EUdaFjVcf8AmXTdT7kFLyPE+Hfkip61Vzm0FCciXohw/eVUdL1I6EPl5Vv2Gcx6iw+OlQJwVAKJh7S56cLD7xB97UJXux/+iyBkM5A2phampNqaTS8XDu2LTYhfeVJsQTQdbkSnmhh5kzMXMcXQL04gHAz+bTjWlUHSgXBr3OupAdcNxPnz/Y4ISTa87QdBxgWqCcaOuTrWYv4v0csVHSLaQnvY7djYaX0miX/VWEph+ud+cOx4/PdYdf5QjkDcFK2zEZCAvinx+pgtWs7iTKpguKEJbDso8r7JeVOsALYuO9/R3FcwDtVEUV5LF8LJz3pT/gv
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:29:33.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4774e771-699c-461b-0f70-08deb777ab72
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9687
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	TAGGED_FROM(0.00)[bounces-290604-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D8DD5ABC57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mv88e6352 scratch register in Global Control 2 set of registers
returns which port is attached to SERDES. This value is a pin
strapping value and is set after the switch is released from reset.
Thus, it can be cached during chip setup instead of reading the
register everytime when SERDES check is needed.

The series consist of 4 parts:
1. Add new mv88e6352_reset function as ops->reset
2. Cache the register value in this reset function
3. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
value.
4. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.

---
v2 changes:
  - Fix the documentation of the return value for the new function
  mv88e6352_g2_cache_global_scratch_config3
as addressed by Jakub Kicinski

v1 link:
https://lore.kernel.org/netdev/20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com/

Changes after RFC:
  - Separate the patch into 4 different patches
  - Move caching step into chip->info->ops->reset function
as suggested by Andrew.

RFC link:
https://lore.kernel.org/netdev/20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com/

---
Fidan Aliyeva (4):
  mv88e6xxx: Add mv88e6352_reset for 6352 family
  mv88e6xxx: Cache scratch config3 of 6352
  mv88e6xxx: Use cached config3 in 6352 has_serdes
  mv88e6xxx: Remove locks for 6352's has_serdes

 drivers/net/dsa/mv88e6xxx/chip.c            | 25 ++++++++++----
 drivers/net/dsa/mv88e6xxx/chip.h            |  3 ++
 drivers/net/dsa/mv88e6xxx/global2.h         |  1 +
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 38 ++++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/pcs-6352.c        |  2 --
 drivers/net/dsa/mv88e6xxx/serdes.c          |  2 --
 6 files changed, 51 insertions(+), 20 deletions(-)

--
2.36.0


