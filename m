Return-Path: <netdev+bounces-252003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL6mMNcOcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-252003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:37:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 426865AA43
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B04AA4354D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660B481FC0;
	Wed, 21 Jan 2026 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoWRT90g"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D2466B40
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013891; cv=fail; b=WOTM5hHVCqtmUx3jFF5iUPyVj54mW5E82ewEpMD6byEfAS7Vg5I7Ki6FJHd8TriaXw+R3aT9qIAsnJnQb2WPFsH+jOv5u0xsgArNYhrKWObjOBlrJbNKV28cO9rxYaB31xLtTLYKHs/2/GllkpIwfejzO2farfPMcDTN4URUuKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013891; c=relaxed/simple;
	bh=Khvbdc2YF1ab4IakbASxEk5/JZyXgmVMDOelDUwwWho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOoEKIGQLl10eM+JVi24K9PQ63fsTSOkbypdUlWHy8l5uge1gXMGm1ManH7lyA0UchjOC6+kvXM4Mj8AfYc9mjUUT4F+ptxrW0CkyAzG6pjQqjz3iMp8WXc9FZU/bKBWNtWD0c5z5SCcfVFslux7BnbCBuyIQtTTDZY0FUx08tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoWRT90g; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmhXTStKWrMdUXYZa2Q5C5tJnZKw6wJ3ChAn+paqGtHhQ5sFjjAOxxx+bBCiAc/q8cUrBR/TbHLhfSGmSoQvIKbZV7ii7+87nhGExMgl9eSWoOTqbMnQGOZEhO1rfMepodnDjKmR6zL4tnqD4Yf3HqMQWrZQU2JkcOa5Ap4I2iI5G5uDLL7xcidQcC8Q03HSoSrebM5slBNn3nTe7Cizuy7PEOD/TH5fk0YE7pEhX3icb9u0A3b73M23NyGcoGWBanpl08GEJ4EelxymxyJt7KZjxs9hKZOeHLbwE5EahRA6jVUcfJJusY3cXYDZ8hmYeOBjxiCzTaWf7LaMO82xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j0YMfLFk71r7AZN7kIvQNw6ANOzrAt067CY4fWwhCQ=;
 b=AyowZOT8w9Nx6tkktR7vbu8kMo2BNwI2sHhSHMmhNdiy8t80aue9iSkjAJL0Ixs+tHRKqDreJIY5K67SEQlqKzELsgl4F+JdpZRleqoNfrHnrRonZQmA3dDON4vFBdqhxDKHpFNMd+aRMeuNqHwmT7bvp50wIDiGEKX3HF7vfRfwUL9EPePdtPzOJ4sJef/4U2Vh0IQKHg8mcfIs2BvtE6dnNyRCk4tcSJhoMPC9XbI8pCxF3vSegj5YnXeoXuyakEwOALJHos7J7HRi5zsbScJxLXBbBvr79E3pPEvcRdekHgnSD+5+cOPmaN/HxDyKVQNjQO6KPp3DZ24D4mS/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j0YMfLFk71r7AZN7kIvQNw6ANOzrAt067CY4fWwhCQ=;
 b=RoWRT90gnvgzw19fpMEzcRPl8mdGnOFGuoIBtGGKElIXp0FYJNlGJtI97DHLa0oVYnLyNyiPBDqMESV1XeMFaaJ601AwHin+H3LSeAqfy4Mt8FDj725IvcclPmaTiNz37EB1eWbPlOsvn+eqi1ddfzE6wNbEKzIj/tQteQtxijHP5tBZeZhWCl3rZ2ctSkXlh5EKZguo6FTx7OB8CSXnGI6GCwIQibNuDz6TmPEjyUV6qUDVOPZKTepjPxMofZptYkCnZ9oyCtuL7hFy15sXRG/+FdcpreU9o1mQ8eVcwbdDcO4qj0Y4Z7Qu2jylQ65Vm6F4/aYJ/Lzy/03pD47aew==
Received: from SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::13)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:44:44 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:2d0::4) by SA1P222CA0032.outlook.office365.com
 (2603:10b6:806:2d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 16:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:26 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:19 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 4/8] net: core: neighbour: Process ARP queue later
Date: Wed, 21 Jan 2026 17:43:38 +0100
Message-ID: <9ea7159e71430ebdc837ebcc880a76b7e82e52a4.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a7235e-57dd-4e73-cc85-08de590c60a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?olCvXltUZ9jKvMuws0p/4uQCOECSlUW8AyLFXaJz5vE8PQ39GM7dO1s4en4u?=
 =?us-ascii?Q?uwBKnD4fR7CB/YIUhjlgRlp+KQc+MF7oWHcFZxeHa+GtistL0PzoIYdK7dp4?=
 =?us-ascii?Q?HeI9prRS4VpTa7IPzr+YVc6sr1zaItmWgNzSognDvL0CbQoDg5vYqWHAwL8/?=
 =?us-ascii?Q?MtIsEg/ySCIQ1mFiMBw7avZ2oDhRfjTiAdcEiuVpbLljnNgqd6o+QsRaNsus?=
 =?us-ascii?Q?ikqAqKrjhLEDPUUV+Z6z5bvuz7/56decbpDjxXJt/FEqp89Rnc0wNuk6exgz?=
 =?us-ascii?Q?0YbU8XEw3osZnQoysqobJzZH6A4X0FgqaC9FAGZsUuLtNjnUQqBBPysDIvYZ?=
 =?us-ascii?Q?kM2OK7HO6P0QBYw9RQoiEvH+Nc6BZXOKN4gim0D9Fbt7b9MWCwPh8DmcIYlg?=
 =?us-ascii?Q?KgN4Ea3BlJWVNWFJOzkj6NB8HoO47V4r/Uhm4DHCH+U5f/sfY0aZF/Qyv4S1?=
 =?us-ascii?Q?SVDsXe9ObfCKv5Wy5tKQsVxdnZR6jkwUXggpsWCO+dZcjTvzD0V+8NrqwV9M?=
 =?us-ascii?Q?5HmL9j7ewT4vHDlPfnHnT9yuQ9pX0bjcrE4ARYUrTROFaOBtOF2zAjjh0HJE?=
 =?us-ascii?Q?Q8Txv1HMxPfSmN+7/qZD9MHsj+XdJ+eBjVqYI3jX09WtfB8dtJM0eV/YDMOJ?=
 =?us-ascii?Q?0W7IqiH8tKiM8BsjLuDmUyaq9wa5c7vbfrRrSpN0Irrm+b7VviIr8fCzMCwF?=
 =?us-ascii?Q?mqrzpH43SRa0447nr8+elqSZFpQqjsi9e5q7ziLAHnfzFu6m1hIHCCGKTyEh?=
 =?us-ascii?Q?tPhL3S3l55e6NZ0gWyqK07XZxfgkbBFpiX82OeyTYg7IU2HygVLF83qj0/KN?=
 =?us-ascii?Q?XBlMVUhhWHw6b0X7q+gJ6JZLKSlcCLijX8tTQDVYa+Hd1E/YCQZYD4vRNmqo?=
 =?us-ascii?Q?MMZebvE45J3enL8ilMj/tQ2J74E3S/Dysh2MBC6mWwdRtHb7k/WH/KVt6YXx?=
 =?us-ascii?Q?/I2soUQPzsdwjDcjGv8xsTy7tHGbDUi12k+s98XOquRo7Dv3JClnYhhOA5i3?=
 =?us-ascii?Q?34k7KFcru2oTySvfA/oxBgzm/de8Uba333YgTuuihFDtzBvTSMOVHDa6mBC1?=
 =?us-ascii?Q?LjvFVPIoe/dwrKyYu1yDZrUpyhV2gqticuSGUcYXwEaVo2AbUIq7NOk4Qx8h?=
 =?us-ascii?Q?LDE1tVqTReb6D84B4bPOp2PAHvkix1mDaUODBhG6LOmYh3XHoiNv2WDhR/Od?=
 =?us-ascii?Q?sCgEivgujQZ+HMmWjJpIM7GTrBLBuvkmSVv2vGwFiLztKCuoTBvAIjpn3lS1?=
 =?us-ascii?Q?ITXRSh0EtssCS+3Fy1RE/PcrQMDRu++VfrVc0yVlCOg1aGryJLzVzYMOFPDD?=
 =?us-ascii?Q?/QsxUIXVlnZf91CMmqgfnOrYutjxw/deME+oRPi5z+rUefGebwROjDnopHNF?=
 =?us-ascii?Q?rFGg45qkI8dl0MqRTggbZqTffxVv0GnH0PFLb9phoMOAgr4829yYDG9Cez8i?=
 =?us-ascii?Q?OExQZJSXL6vEMl6RYEpo3S4/qshA6yrfmrfYVSbB+wtMH+Emt6C09bIaQjgY?=
 =?us-ascii?Q?tjV4OaCChLi3GypiETSFd+sMsgat8OvoxMqb8CbBTz2/LdebsH5jlbR8cAqH?=
 =?us-ascii?Q?j8h8JO+gY2/f58k+/ppG7FHerMT9oTxctgZI6UJdIgYaZNWnzo+sPC/B/wLc?=
 =?us-ascii?Q?MvvsV5HTH7OrFUJLtV/UY10aycJEtAH1U62Cncez6syUp2trv2tK2EkrlkE+?=
 =?us-ascii?Q?ksXnQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:42.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a7235e-57dd-4e73-cc85-08de590c60a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252003-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 426865AA43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ARP queue processing unlocks the neighbor lock, which can allow another
thread to asynchronously perform a neighbor update and send an out of order
notification. Therefore this needs to be done after the notification is
sent.

Move it just before the end of the critical section. Since
neigh_update_process_arp_queue() unlocks, it does not form a part of the
critical section anymore but it can benefit from the lock being taken. The
intention is to eventually do the RTNL notification before this call.

This motion crosses a call to neigh_update_is_router(), which should not
influence processing of the ARP queue.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b6cb127a5b8e..3d969f0190a1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1369,6 +1369,7 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 			  struct netlink_ext_ack *extack)
 {
 	bool gc_update = false, managed_update = false;
+	bool process_arp_queue = false;
 	int update_isrouter = 0;
 	struct net_device *dev;
 	int err, notify = 0;
@@ -1504,12 +1505,17 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_suspect(neigh);
 
 	if (!(old & NUD_VALID))
-		neigh_update_process_arp_queue(neigh);
+		process_arp_queue = true;
 
 out:
 	if (update_isrouter)
 		neigh_update_is_router(neigh, flags, &notify);
+
+	if (process_arp_queue)
+		neigh_update_process_arp_queue(neigh);
+
 	write_unlock_bh(&neigh->lock);
+
 	if (((new ^ old) & NUD_PERMANENT) || gc_update)
 		neigh_update_gc_list(neigh);
 	if (managed_update)
-- 
2.51.1


