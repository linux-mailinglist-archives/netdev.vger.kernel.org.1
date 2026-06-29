Return-Path: <netdev+bounces-302584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cv42I65ZQmre5AkAu9opvQ
	(envelope-from <netdev+bounces-302584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:40:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6E6D9886
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:40:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=SSxujqLR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302584-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53F7E30A0637
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0C4028E9;
	Mon, 29 Jun 2026 11:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4703B960B;
	Mon, 29 Jun 2026 11:23:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732229; cv=fail; b=ah6HSF8AJ3L4xOWDMaos11k8vyc8tWB+MotB60YebXpL+z6H5bLgKY6PJu+Rzx/Bwr+gu6d8FomqOQa2+VyB+45iOC5eq/hNkYlh4UjSqz99Re66KQSJkOuc3uIuul1Jm6SsPMN7xmT4md3EBtXmJ7JPdAgwdfsQ+ozcIzZ0A4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732229; c=relaxed/simple;
	bh=ERBXj7l0Zy6dmlyMO6N7zKS4oiOXtP+o2cKxVQtZZ3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cm+XqSWxF1Huozz4jIdogMIUfk+OF9xL/vdBpzTRMDnghHnqfZJ6yjg1VMbdTOxhldGzdkFbrVFhT82zbq7mWgWRaHQHbDQ0Mdcv9RtEn1yoXN+4pWYE5O9NXDDvURg798x0vhQq0Z5N5iF2OtCL99GCJ7ZFE9g4qYf/UJJxmnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SSxujqLR; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5t6ypO1+BDgyAH516oxB/IgNwv/TOWipHX0HehTic4XOliYlrnnHO/ZkM1AVFyisUMqx3STIyF3n6wL+VIMUmvnUw+IXcbEEVw9B9FBMWAHOORZBRzTp8dG1/CZqKqyoqFPz4AVaR5Rpj4zqrUiWxnHHgSWOQJ0H1S+xVWZt+2lZ5wiWKcQUUZEPGawMGkxcSXxJBHC3aNDejJJKwYDKTXG/nVq+2WchZyty+8FLnXokLkeQumF2PwPCpuP5nSj+7LWFdrBk+Eh6lMDTAG1UpK478bgtn09+E+1hozLf9xPT+H/4c5oCrsXStmOF0f90VZ2FmJ5I86rX/XkMifKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tei1siDEpG27sZiiBBF5XSim44iTsrwgoBYh0d3IlKs=;
 b=PC5DW+lj7eTYuNM1GGlf3GSD0GQEQefq1Nhwx4trifdmBEqQhOvr4xv5z6lK3CgzIj1bRoebfIpYLmmSI4BxYJGSfD1JPRcuxaTMFpjpoZizScmv5SP1TL1cDfUM6NqyA6xkQpIg7s84CqUbtBFdyoa7xT/7gwVbxYYJtBX068ck4XOpKOTwuOCV6gmzRWr7Kg//Y2gOQ3LIJJe2mSNkCC5rytauRQFGNOGA4HH+K3ezmP7q+ctChorobVXm2y5DIjgh3NnNyEzl0pdx9XKXli48rpi4Dofq927Q8PhUsTMLSNN3WDDxuqhWJu1y7oV+h6IpkJA+uaDkoEA2kNWkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tei1siDEpG27sZiiBBF5XSim44iTsrwgoBYh0d3IlKs=;
 b=SSxujqLRvL4uyZrqr0zyFdS/A4TVsxER+VaSX6OECo68vXEyZKWrR7/3NscpZ+ekkvq9+zNd1KOP5yCJNFfXKmQqFcfY1n6xVJB98wPOuCslQzc3l6aRDEmjzbr5/2cVhXL12FXglHjfRMXW8viDjgN7NBNRVlRqYtHwSWEkb/pgFWNwamFtykDIv3c2LzYb9GRDs3IpJxYGQlk3t7C6endo3mRurwp6OufSOQYKNbBBZbiDYMJzsQtSwy6AGCqzyGk85nRfi3I1e3j4jFYXowSkaouY6Uns6tlKtrVQwIqxT//JTLqkh01ZpX1DiR7g95CjyE8AzKBMVxjr0Xz+BA==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:45 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:45 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/13] dpaa2-switch: offload FDBs added on an upper bond device
Date: Mon, 29 Jun 2026 14:23:06 +0300
Message-Id: <20260629112309.154328-11-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: d840c70e-6057-49c2-e6ed-08ded5d0e1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OgQUn0v+ZoMLWcp1sEqpX+TGF3LKqWsb+gvNYg1VwEt6bBeG8uIRjMCORLQmpbKZJBcZE/hWOFuqgROqFasE/S8u7nDNZ1r1jLEufCXVyMceQ+TYFlDF4gg64iEJFQDpKZKnCtuzK6dS8Qmzrqk4/SD5z5mSzu0pkqS3+7y8Q5yLO7zdQlNkvTNePjYL0wPNqnBuTcN85qAC28bdMUrpnE4lo1PusvPAblKoC9H4fPl85YTQIK3MqHmJ76yDtLdpJs0CO0Onq4jS9Ox4vamBg5jX1hnPvl8czFQAKiqCXrQiBhHwxVM2HLgWnhhQbs24yJBfg1GAOGHIQy6LM+EQ0WMMBw8y8j2ds1/5Rco1zLQ95lpvG9QmZnI6Piu9O6rSd39PrqQRQXh3nO+ZX2dF7j0tYRhn9Ksqj7h5H5TQmLjahNpQxlOh+b46PHjkzkFRrxa2Uc1JBlEFheYjgLzplD75QOWmPDZU3Xo9R6AyzLsyq3PPDq48mSupiGubpkP37jUCJARHy/k8axdlAEDtmu7XIWwXDenNdLNTeVv279eKdkAy+KZexDFQvyCbi2GzYtPKBSffXbmyRbLAGtmXMFqwc2Mv6Y9XyZS+YamXPOOy8ROljH0Y73ruO6gemlpADa13+LBha/VXMLED32NXeVI4b3Gns1k0RuWAMaUy6E8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCsqZT3E5/YNjAp15h49KvhEDg7Ou3FaKJGtNoW8J/w4yDd/ey1GJx8gb4Qw?=
 =?us-ascii?Q?Yeh2Y3fQ02zxztMkhOBp2tcvlqy0BQirN4J1kVAaw98gAs/FFNbNEgdLxhah?=
 =?us-ascii?Q?9Q5o/o20imrQCzwRWo0yY4WmwV3jBiTUMA5MNl/GoPhpJ13rU6306cLNyJqm?=
 =?us-ascii?Q?3ApWBH8mNm8OcEeUUiTyWF2R6qXK3YCC0sHni6tM+2Lmtt+Cq2LX7wBqvMzD?=
 =?us-ascii?Q?2C//QbIkzRF4qzXIdyRxdY4TZGmZ4AtF9qAHeUL6gL3rlYzyVAUcoFpAAN9I?=
 =?us-ascii?Q?5iKbZXG46hSyCYbmUSOcru2oyqQM51v3DGRwVjmIroIDyNJhRPA6qKaccWne?=
 =?us-ascii?Q?ELA8frShk5Of7T1a7ezZ8ogmERz6FiiI0Fwdi0lMso4vKfE2xTmB+87m9fdO?=
 =?us-ascii?Q?k7a99yAvcB9eMh9iSWXMn55oaeHVw1GEg6zuK+z6O3GIBaQhqwStadnU/GjT?=
 =?us-ascii?Q?PkCFWEVw+7wiqcNw+vUS+RexZkJ7R+YtP4t/DIO9FAHovWRr1LStljlkp7w0?=
 =?us-ascii?Q?D9tKKuMbUHB6gI6TBQIrY0zEeI98iCd042GlLznOjGSDCodK2qJZ/Ccat2cZ?=
 =?us-ascii?Q?isyAEdw02LsoWqHWZRRUKOtcv9iiQ9f1Ui2TkAUxlLLgr9T+SYAh0sj7aLzR?=
 =?us-ascii?Q?4JVJAoCR7AaslYrdIh1iwJuuffXiE4r1F3Q5VAHAJBm9ROcsQFlimQ72YzBc?=
 =?us-ascii?Q?pSESWnZHSjOmpRDRekRSVlZYmu7/aiQsKZBpS3KFbARueveKHkkfdrWdLDpr?=
 =?us-ascii?Q?Ra1d0tpg99WePA8LrGfl0IBz+iUrJ+vbIfzIQmteObrG8TZc61YXfOMgYSK4?=
 =?us-ascii?Q?pRl2DuECvQTS3busii1jKCCNRJ5IuVNGOfAMsDeEnSDlNkb95ecq66OFKeE1?=
 =?us-ascii?Q?Xigrx2UWQZ2Z98UDzZyDIvy8aecQH89dZrik59rrztrTMglQvW763rBH0s/m?=
 =?us-ascii?Q?shm8QVwAslBlhiPa/pr3gfNKf2B9BX7tmrgtStcayid4If43M/WFPestdx1n?=
 =?us-ascii?Q?upC/lFPCS6CBTfSJPp0jn4lBOvjzo2SyKWcN2voVxVToqGPqIpVws9vw6qe6?=
 =?us-ascii?Q?U3FHp254MZa1jhV1TGrSudnsM2q4TmMNop/i6bXwQlKIIqytMohjZSoNNTa1?=
 =?us-ascii?Q?+RnGmqt71rLk+Cz/kszvKPTL5ADEd4zBnolZXtl1LCt17rdVGcxyEAPZ+r1a?=
 =?us-ascii?Q?ZIECG972JKPnSdBlDkWAgAa4CphsqgfSh3XIIQf0FaWMIEzC1TinvrQbfxdE?=
 =?us-ascii?Q?G9oYZkeb1StTTM05L7iw0r9S5E6v3mZv4cWHcdmPzq/dXv01D+49Rl4h9i2B?=
 =?us-ascii?Q?TwgKmxSRM3CeeYTHpQ2zex6WkbS7lhEVWwBvtdeDEG6JBB4BUMy31+OXoEWf?=
 =?us-ascii?Q?eXqV0VMhkwKN+/S3Fi9Ac72OCZKlYLEHldWgvo5weSYUh+eFy4687qajcLL0?=
 =?us-ascii?Q?y117CFQZzkjoTgDfqfEQd0HdRWFEGb9BbcN5uMteJlIKyMPkttcdrmbfPpG8?=
 =?us-ascii?Q?5gC3JVxr6eC0KBCmBqMIwa1muy9sftcANTtqyjJqW9oKZHPXPTcRlRZkU4Fv?=
 =?us-ascii?Q?4riJJeKiOG2CbzmRTpd0c9rxXXoZeOlxvvXHeMMHyYmKq3WPe7F8cmWWoERS?=
 =?us-ascii?Q?c3x9GCqoEvkD0YUBj1FNKtS2Z/+SnZcVFek7fzPAhPXhKjPkiPHHYyiZRR5M?=
 =?us-ascii?Q?jecK7q1Kp/GUZmYGj5OuuKBN1O7PvZBWKALbw88xzL7KDMw0ZI4wNZhxPeID?=
 =?us-ascii?Q?a/CZsa/nEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d840c70e-6057-49c2-e6ed-08ded5d0e1bb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:45.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMxiGIhmsexjfjOd6ER7lqio8uEA0U1jXK+VllPCDvb0/wgS6hfurL/THONdK7eOzuazxm8g+4DeNdh2TQfn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302584-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FB6E6D9886

This patch adds support for offloading FDB entries added on upper bond
devices.

First of all, the call to switchdev_bridge_port_offload() is updated so
that the notifier blocks needed for FDB events replay are available to
the bridge core.

Using switchdev_handle_*() helpers is also necessary because each FDB
event needs to be fanned out to any DPAA2 switch lower device. This
triggers another change in the return type used by the
dpaa2_switch_port_fdb_event() - from notifier types to regular errno
types.

Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
events is updated so that the newly dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
a bond device. This will allow us to manage refcounting on FDB entries
which are added on the upper bond devices.

The DPAA2 switch uses shared-VLAN learning which means that the vid
parameter is not used when adding an FDB entry to HW. The current
behavior when dealing with FDB entries with the same MAC address but
different VLANs is to add the entry to HW every time while removal will
get done on the first 'bridge fdb del' command issued by the user.

The same behavior is kept also for FDBs added on bond devices by keeping
the refcount on the {vid, addr} pair while the HW operation disregards
entirely the vid parameter.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- Migrate FDBs in case the primary interface of a LAG changes.
- Use lag->primary instead of determining each time the primary
interface of a LAG device

Changes in v3:
- Update dpaa2_switch_foreign_dev_check() so that we check if there is
any port in the same switch as dev which offloads foreign_dev in case
this is a bridge port.
- Add mutex_destroy on the per LAG fdb_lock
- Make sure that all FDB events were processed on the workqueue on the
.remove() path.
- Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
possible, even if the HW deletion would fail
- Access the port_priv->lag field only through the proper rcu accessors.

Changes in v2:
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 227 ++++++++++++++++--
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  24 ++
 2 files changed, 225 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 949a7241a00f..307b3b7a1bfb 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -25,6 +25,9 @@
 
 #define DEFAULT_VLAN_ID			1
 
+static struct notifier_block dpaa2_switch_port_switchdev_nb;
+static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
+
 static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
 {
 	return port_priv->fdb->fdb_id;
@@ -585,6 +588,81 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
 		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
 }
 
+static struct dpaa2_mac_addr *
+dpaa2_switch_mac_addr_find(struct list_head *addr_list,
+			   const unsigned char *addr, u16 vid)
+{
+	struct dpaa2_mac_addr *a;
+
+	list_for_each_entry(a, addr_list, list)
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
+			return a;
+
+	return NULL;
+}
+
+static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
+				    const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv = lag->primary;
+	struct dpaa2_mac_addr *a;
+	int err = 0;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = dpaa2_switch_port_fdb_add(port_priv, addr);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &lag->fdbs);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+
+	return err;
+}
+
+static void dpaa2_switch_lag_fdb_del(struct dpaa2_switch_lag *lag,
+				     const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv = lag->primary;
+	struct dpaa2_mac_addr *a;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (!a)
+		goto out;
+
+	if (!refcount_dec_and_test(&a->refcount))
+		goto out;
+
+	list_del(&a->list);
+	kfree(a);
+
+	dpaa2_switch_port_fdb_del(port_priv, addr);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1533,6 +1611,33 @@ bool dpaa2_switch_port_dev_check(const struct net_device *netdev)
 	return netdev->netdev_ops == &dpaa2_switch_port_ops;
 }
 
+static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
+					   const struct net_device *foreign_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port;
+	int i;
+
+	if (netif_is_bridge_master(foreign_dev))
+		if (port_priv->fdb->bridge_dev == foreign_dev)
+			return false;
+
+	if (netif_is_bridge_port(foreign_dev)) {
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+			other_port = ethsw->ports[i];
+
+			if (!other_port)
+				continue;
+			if (dpaa2_switch_port_offloads_bridge_port(other_port,
+								   foreign_dev))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 {
 	struct fsl_mc_device *dpsw_port_dev, *dpmac_dev;
@@ -2100,8 +2205,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
-	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
-					    NULL, NULL, false, extack);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, port_priv,
+					    &dpaa2_switch_port_switchdev_nb,
+					    &dpaa2_switch_port_switchdev_blocking_nb,
+					    false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2143,7 +2250,9 @@ static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 	if (!brport_dev)
 		return;
 
-	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
+	switchdev_bridge_port_unoffload(brport_dev, port_priv,
+					&dpaa2_switch_port_switchdev_nb,
+					&dpaa2_switch_port_switchdev_blocking_nb);
 
 	/* Make sure that any FDB add/del operations are completed before the
 	 * bridge layout changes
@@ -2425,9 +2534,10 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
 				    struct ethsw_core *ethsw)
 {
 	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
-	struct ethsw_port_priv *primary, *new_primary = NULL;
-	struct ethsw_port_priv *port_priv = NULL;
+	struct ethsw_port_priv *primary, *port_priv;
+	struct ethsw_port_priv *new_primary = NULL;
 	struct dpsw_lag_cfg cfg = {0};
+	struct dpaa2_mac_addr *a;
 	u8 num_ifs = 0;
 	int err, i;
 
@@ -2454,7 +2564,6 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
 	/* Build the interface list, always placing the primary first */
 	if (primary)
 		cfg.if_id[num_ifs++] = primary->idx;
-
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		port_priv = ethsw->ports[i];
 		if (port_priv == primary)
@@ -2477,11 +2586,32 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
 		lag->in_use = false;
 	}
 
+	/* When the primary changes, migrate the FDB entries from the old
+	 * primary to the new one: remove them before reconfiguring the LAG in
+	 * hardware and re-add them on the new primary afterwards. We do not
+	 * touch any refcounting since the intention is to change the HW entry,
+	 * not the parallel software tracking.
+	 */
+	if (new_primary) {
+		mutex_lock(&lag->fdb_lock);
+		list_for_each_entry(a, &lag->fdbs, list)
+			dpaa2_switch_port_fdb_del(lag->primary, a->addr);
+		mutex_unlock(&lag->fdb_lock);
+	}
+
 	err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
 	if (err)
 		return err;
 
 	if (new_primary) {
+		mutex_lock(&lag->fdb_lock);
+		list_for_each_entry(a, &lag->fdbs, list) {
+			err = dpaa2_switch_port_fdb_add(new_primary, a->addr);
+			if (err)
+				netdev_err(new_primary->netdev, "Unable to migrate FDB\n");
+		}
+		mutex_unlock(&lag->fdb_lock);
+
 		synchronize_net();
 		lag->primary = new_primary;
 	}
@@ -2763,67 +2893,97 @@ struct ethsw_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
 	struct net_device *dev;
+	struct net_device *orig_dev;
 	unsigned long event;
+	u16 vid;
 };
 
 static void dpaa2_switch_event_work(struct work_struct *work)
 {
 	struct ethsw_switchdev_event_work *switchdev_work =
 		container_of(work, struct ethsw_switchdev_event_work, work);
+	struct net_device *orig_dev = switchdev_work->orig_dev;
 	struct net_device *dev = switchdev_work->dev;
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct switchdev_notifier_fdb_info *fdb_info;
+	struct dpaa2_switch_lag *lag;
 	int err;
 
 	fdb_info = &switchdev_work->fdb_info;
 
+	/* The lag structures are freed only from dpaa2_switch_remove(), which
+	 * first flushes this workqueue, so the pointer stays valid for the
+	 * lifetime of the work item. Only the dereference needs the RCU
+	 * read-side lock; the FDB helpers below can sleep and must run outside
+	 * of it.
+	 */
+	rcu_read_lock();
+	lag = rcu_dereference(port_priv->lag);
+	rcu_read_unlock();
+
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
-						fdb_info->addr);
+		if (lag)
+			err = dpaa2_switch_lag_fdb_add(lag, fdb_info->addr,
+						       switchdev_work->vid);
+		else
+			err = dpaa2_switch_port_fdb_add(port_priv,
+							fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
-		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
+		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, orig_dev,
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
+		if (lag)
+			dpaa2_switch_lag_fdb_del(lag, fdb_info->addr,
+						 switchdev_work->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, fdb_info->addr);
 		break;
 	}
 
 	kfree(switchdev_work->fdb_info.addr);
 	kfree(switchdev_work);
 	dev_put(dev);
+	dev_put(orig_dev);
 }
 
-static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
-				       unsigned long event, void *ptr)
+static int
+dpaa2_switch_port_fdb_event(struct net_device *dev,
+			    struct net_device *orig_dev,
+			    unsigned long event, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
 {
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
-	struct switchdev_notifier_fdb_info *fdb_info = ptr;
-	struct ethsw_core *ethsw;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!dpaa2_switch_port_dev_check(dev))
-		return NOTIFY_DONE;
-	ethsw = port_priv->ethsw_data;
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	/* For the moment, do nothing with entries towards foreign devices */
+	if (dpaa2_switch_foreign_dev_check(dev, orig_dev))
+		return 0;
 
 	if (!fdb_info->added_by_user || fdb_info->is_local)
-		return NOTIFY_DONE;
+		return 0;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
-		return NOTIFY_BAD;
+		return -ENOMEM;
 
 	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
 	switchdev_work->dev = dev;
 	switchdev_work->event = event;
+	switchdev_work->orig_dev = orig_dev;
+	switchdev_work->vid = fdb_info->vid;
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		memcpy(&switchdev_work->fdb_info, ptr,
+		memcpy(&switchdev_work->fdb_info, fdb_info,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
 		if (!switchdev_work->fdb_info.addr)
@@ -2834,19 +2994,20 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 
 		/* Take a reference on the device to avoid being freed. */
 		dev_hold(dev);
+		dev_hold(orig_dev);
 		break;
 	default:
 		kfree(switchdev_work);
-		return NOTIFY_DONE;
+		return 0;
 	}
 
 	queue_work(ethsw->workqueue, &switchdev_work->work);
 
-	return NOTIFY_DONE;
+	return 0;
 
 err_addr_alloc:
 	kfree(switchdev_work);
-	return NOTIFY_BAD;
+	return -ENOMEM;
 }
 
 /* Called under rcu_read_lock() */
@@ -2854,13 +3015,18 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 				   unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+		err = switchdev_handle_fdb_event_to_device(dev, event, ptr,
+							   dpaa2_switch_port_dev_check,
+							   dpaa2_switch_foreign_dev_check,
+							   dpaa2_switch_port_fdb_event);
+		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
 	}
@@ -3785,6 +3951,9 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	dev = &sw_dev->dev;
 	ethsw = dev_get_drvdata(dev);
 
+	/* Make sure that all events were handled before we kfree anything */
+	flush_workqueue(ethsw->workqueue);
+
 	dpaa2_switch_teardown_irqs(sw_dev);
 
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
@@ -3798,8 +3967,10 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	for (i = 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
 		netif_napi_del(&ethsw->fq[i].napi);
 
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		dpaa2_switch_remove_port(ethsw, i);
+		mutex_destroy(&ethsw->lags[i].fdb_lock);
+	}
 
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
@@ -3951,6 +4122,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		ethsw->lags[i].ethsw = ethsw;
 		ethsw->lags[i].id = i + 1;
 		ethsw->lags[i].in_use = 0;
+		mutex_init(&ethsw->lags[i].fdb_lock);
+		INIT_LIST_HEAD(&ethsw->lags[i].fdbs);
 	}
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
@@ -3999,6 +4172,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		mutex_destroy(&ethsw->lags[i].fdb_lock);
 	kfree(ethsw->lags);
 err_free_filter:
 	kfree(ethsw->filter_blocks);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index c98bddd7e359..e8bc1469cbf7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -100,6 +100,13 @@ struct dpaa2_switch_fq {
 	u32 fqid;
 };
 
+struct dpaa2_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
 struct dpaa2_switch_fdb {
 	struct net_device	*bridge_dev;
 	u16			fdb_id;
@@ -112,6 +119,9 @@ struct dpaa2_switch_lag {
 	bool			in_use;
 	u8			id;
 	struct ethsw_port_priv	*primary;
+	/* Protects the list of fdbs installed on this LAG */
+	struct mutex		fdb_lock;
+	struct list_head	fdbs;
 };
 
 struct dpaa2_switch_acl_entry {
@@ -287,4 +297,18 @@ int dpaa2_switch_block_offload_mirror(struct dpaa2_switch_filter_block *block,
 
 int dpaa2_switch_block_unoffload_mirror(struct dpaa2_switch_filter_block *block,
 					struct ethsw_port_priv *port_priv);
+
+static inline bool
+dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
+				       const struct net_device *dev)
+{
+	struct dpaa2_switch_lag *lag = rcu_dereference_rtnl(port_priv->lag);
+
+	if (lag && lag->bond_dev == dev)
+		return true;
+	if (port_priv->netdev == dev)
+		return true;
+	return false;
+}
+
 #endif	/* __ETHSW_H */
-- 
2.25.1


