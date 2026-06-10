Return-Path: <netdev+bounces-297581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EuI/EhEzKWoNSQMAu9opvQ
	(envelope-from <netdev+bounces-297581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:49:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DB667FC3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=CTqheJCB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297581-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96DA9300DA5E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168633ED5AE;
	Wed, 10 Jun 2026 09:47:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880643BE645;
	Wed, 10 Jun 2026 09:47:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084843; cv=fail; b=EgDIVAZDlO8GwLcTx6dAnFCMeRjBxkV8oTknU97zKN8WMcPbwWVv2dYU9TuJkbFSJNb8fNbsJGt7Qck9HKfCteKaAHZiqYFclKjhZqjXKaga9llber92oiRPNcabaNPC3YvziwWFSPM8Xe93mvVvXk3zEqTmZqMdOxdFhHtSr0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084843; c=relaxed/simple;
	bh=8IaSVnu6Boz7OjezS+zjTaFw33pYFwRQElFHcCSFGuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABmyyNGGcPfjGoJUDhAKs3Kj6WuYjppNUpK0Q6KYHnuSkybCY1w46gfvkAoMP4ONaBFdtkGrj9+xwLURBIJi3YKG1vfIbMhI5JG8IcLXW0GeNFZghDa7Iqd4CC1W+eYHGqvpt1x3YhGS41jodf7FEuYa9Jm56vciOhYgaFMc4Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CTqheJCB; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKwgJlC8qvXXDBHd7rCdec4dWkToGH/AjKiOiSRoXX9F3jOTupUdMhkzzXxtZwBlhP4P7exPCwiNQRUMlzfg/EfhSqy5LcGx0l9QIkwznYwmRmp9Z+kDVROuoVdf75EMGHCZzucbhH+awbJ72QiOBBg+S4THFsqvoHYCDxCsd7k9wvH3mw1ULhDdly4vncXz5VZ5QCDmdyPuwdDkaLjczX6AXl5DdJSouvVAsC7KSA7tePzQuHeVhpd4h9J9M3XZNoaWp/urAzHOC9kLEb9NS1fzW9iRRd3W5En/PsOprzwJle3CJPN0S5SXNe+lzz+yJ75AuDoeFffLk6YwGPIJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNKub5kU7JHuyr6wJUgWj4V34QRV9T161Nm5Fh8gAuw=;
 b=DI59QA3QlCNm77h8uhixEFazGLX4+1pjsqLsPcq4ebWhGVFOVGHdM7MrNSKrHJqJR0H++sxDzm8fAW0w04FX/VlgDfifW50WGcjKV+GbtZMsb2HrVAmT3rlrwXGanzGnEbEIqK1ppzT1iKcUQZVhXF2fO2R6eep+eyZZq/xbQFu+4NjWj5+/BTUplKdOlOMIvnn8I3xQDZ4ZlYi+qKuoNqaotul2f0/TxT3yZFrnEka1sk82Qud6WYp4cKlX2fpy2xmcvRE43v8BSUbB3gctXeUK9xIACsDUemfvAHoelyH+caVeR2U3Ec2DRqmfGc++2Shbscp5YkYcb0xBnjV6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNKub5kU7JHuyr6wJUgWj4V34QRV9T161Nm5Fh8gAuw=;
 b=CTqheJCBvmn0iZHFOsTjS2qzcuaqDU62lPizWPgozgOEkFvpDf8LoWdpb1VsJH3nK/luE4JxGe9Xyg3cYtfHcGnQH1sb6KQPwkUNG435RdG0p3XxPW9+WprzwyiKuzXy+5aEBQ/PEPxg2tgSuKAObyRcuhX8Oj2rzdOrjo/veQYTtxSZ1G84sQzFDG9HzgVYzq+xieRHLu4kEc9ylgaAvgrhlW6U4yvBJhXK2D91W7vgU3EbPUGT8Qhns2ulwv4QfAeR/vlAvVUH30cbQ4V+F86D7uRsZGgfcNZK2EC9CsBHmXBZDHocix9Nl/IjfMbKbXrnOmXpN5nImBpxHS+MZA==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:47:16 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:47:16 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 13/15] net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
Date: Wed, 10 Jun 2026 17:18:42 +0800
Message-Id: <20260610091844.3423693-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: db5a7619-563a-47be-f48c-08dec6d54167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|22082099003|18002099003|921020|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	RmqUGLwWt/ehC7Y1b3fIFI2sjn6x/qZcyFeGXwlmZkwTO99k4/PmsfTuUvMdjJRzm4uHGw3CMmeWpa2nzVOs1xlZKg9FOcxHXtbFpuAq1PvcCRbBWO5cLzt75Kh5FCAUi4x4hp4c5SjCQI/3bVRz2n1UlJkHF1UZ03uLqRq3p9ayBFj0jSqjHu36CDmDkU/3RZ07fJA/8z/KfASHg/VELCYBcoMuGvbdFjDpzm6uOsyEkFTCchiKNrewySOQbQtJ5F3rLiZme1w80iS1QygnzWHzdUb6NZq1YN+nMwQM78xyfDAIBs2QjY/4zgOQl4QBQpD+XSV+9rESM47xUptzHXEURUXMVu/ElSvf2UDjY4nOfhK0jQ85jXWQH+io08FjZF7RxM0uiQUeKb8I3Onx/6auDfV7IJjkzLDqA610q9TQkhhoDYcHiYkmrDCySGpKcqYC0neC76AhIEo3WHjxZre2x02MQXtn2zf5i381ASzU9aO+fGtEHAitqgIC6GLh98vjbfIlUFYq7Hujraa6hjVsdR7MK8wle5tW0/K/FIAOJSQYJ/Gz6hTvV3pBPgD4uK2YPgjGpgMOTtGazu9j8bes+71MLheiOV9ajDbOg5gJv5i/241ZN14EEQxeBNa7schuNXocXgSjpVmPNAoltemdA1xr8NFx/Ea/KlH9YUDfPiqJKvueapURpLV1UYmAZXPhpresQGP7RnEgh56OYmr1V3//PzYeucIwij+gCtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VM7eqM31Y/smmn67g/QMnxjccfhc8vFGYCAKYPeWOf02HYYJ2YaRRyinb5Jj?=
 =?us-ascii?Q?NHzWY7thgn4LQHJYElCvc+oBmP1Fi5+aupM9umd7LtKEF6peDRblD4dNykMg?=
 =?us-ascii?Q?X7wALkjktISliYW9MoDliD2ATOU463xRWaZ69XRrtaUgqjkFo/GhK4UKBPYS?=
 =?us-ascii?Q?zIKMVHv/B+36jvAh7Il+02mFo1M9QLApfF8fK+j3WgAQwWLpybgn+lomZkG0?=
 =?us-ascii?Q?UtBHL7Zd9ADLywR4PIBsFVvG9LFYh/wTkPhgGTvXjdN4YLTJDGegExsbnngY?=
 =?us-ascii?Q?3NwhIgNkHAQDNLnip6iKTH/906zPcRnqzD4hNENDZV3roFWMAzQ+/YLjdZHS?=
 =?us-ascii?Q?eAKM8p8aW4okhEyjekDFwOZKiGo+RbA/C/CZF+6stnoDGwMJE9DIISrkCMaf?=
 =?us-ascii?Q?t+5TuMV+7rNGNQUIQEudrb3EIYB7oynhP6lco/EtlYbsIKtL1E24efR2bA2E?=
 =?us-ascii?Q?8Az6J9+OB7yz/184NRLqt8Ui0xJgL1XiZ1W1W06+xRC1GUMf5FpnemElcpVr?=
 =?us-ascii?Q?NR94rx2txyrXXWgpnmyXY7tUQ8e07RZXIuGOF+xGTzDlEt6EDFCnJMMeM00R?=
 =?us-ascii?Q?veETL6s8W3gEK0CXDGHUY/ne7DayvJdMXmeXmm2O4Jo2sRkhKq86S3W4Bnrq?=
 =?us-ascii?Q?mgbWw1JHjrgIh+4h9onjkmo7z6soW4DGpjHwegDZSNX1MT3/0ez5pY3iexTv?=
 =?us-ascii?Q?vJFHgJYKMujsbVZLg5T+PcnNMWqeJXuX0vihlcrMwL0AsO2FMP+w+MFsGVsj?=
 =?us-ascii?Q?9pJcOZoxmjfHek6ArrJ2boL8aGGm7YjmmSg2btPiDNss6CR10UsA/nwxHhLw?=
 =?us-ascii?Q?Q6HE08egqfsinTUzGKycX2bVWpcBckr6aCJ5e2+164a40WiiDTW68AZGkW44?=
 =?us-ascii?Q?0Fsf66Oa0xTKQygXx0qvdJ2sJqj8ba5RfJglrnV70/BbWlJHt+rrt8D18bel?=
 =?us-ascii?Q?GG2Ol/s90NzMD2pCVYUaQxN6rfe4Dr+As969FLjA9qyL8im0e9nJbVmmKGVJ?=
 =?us-ascii?Q?VGrjOVzXU/X4XnZMpz1hez34xJoiwhalR035sIVEV4VkT69aKIdqwUecsp52?=
 =?us-ascii?Q?K/Ij+l+Dhv+7G2R+EM/gSJe2Iof6wmwNFEBnlsSZrpiZOgiVK0XhEqXElbmf?=
 =?us-ascii?Q?0LXlu6VRYl1v1dywtPJHsCQd48LdRI9DVaaAnznZaZVAKtumHQRqTdLfRX49?=
 =?us-ascii?Q?IRvK3M4dBIRAuSWIwaufKZx8/sNLy8b11lhfKTGFvDf7wCjzMUrQQ4F7a92O?=
 =?us-ascii?Q?vk070pPNCi3Ha+Q9UmscfukSy1R4Qf7eHC5Yu8glU8tz+S2TOnxNDUeScYIJ?=
 =?us-ascii?Q?behm8dEicE9wFJHV5PE6qo+r+UOtDyYy3OROErLuLPppFuNG59IcG0Fvkkl4?=
 =?us-ascii?Q?7+YPoQXX5mIjZaC2ucbWOpd3G4JiA4IrSKAff8xslzeX6Lfs+5tnW+0IxXl+?=
 =?us-ascii?Q?jVIL/9znWSaCHVtdNmCuiqu0zJfX5MuKbQvcE3CYiKn1ZLetg01hH9M8Yny/?=
 =?us-ascii?Q?WrbCVt0l4VkUouNQPwgEuajVakdfVLBxjitMdlTQhhZRpEfqEbgrYif1mA7O?=
 =?us-ascii?Q?LQb/wntJJf8maxBZqfCyr9F1rP+GZ27l0+w2al2ahg25nKHRo+T3fO9hmAND?=
 =?us-ascii?Q?6oydAwaH+5xE04XKwwoq1abGZBVRkQJ1cr2fRqz5PJ2yihuzRJCHF9mqw1fT?=
 =?us-ascii?Q?uB3jhfu9PtL2SWcGCD/uAgQvZrCuFHV4AvN6WHSxqjkhLvvFctHW8I3LBAH5?=
 =?us-ascii?Q?WK9kWs96URbTshwl3Q4qb1Gbf88Sb9LYgEvzM2cDKrYzFmgxQiT/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5a7619-563a-47be-f48c-08dec6d54167
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:16.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxnHChbj93J4dsqqDVidqqNtKic0lPH8Uc1zTKVGLEAvrkLCczhQVcm6PlkJWp94FIdxMBp3RMRlXDqIvmxAobdY9o7R7YZjE1Woi/Lpy1wtDPO8ruhD3Jh0pH5kk+AH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297581-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B19DB667FC3

From: Wei Fang <wei.fang@nxp.com>

The ENETC VF communicates MAC filter changes to the PF driver via a VSI
mailbox interface. The message send path in enetc_msg_vsi_send() polls
for completion with a timeout up to 200ms, which requires a sleepable
context.

The legacy ndo_set_rx_mode callback is invoked with netif_addr_lock_bh
held and BH disabled, making it incompatible with the VSI messaging path.
Implement ndo_set_rx_mode_async instead, which runs from a workqueue with
rtnl_lock held in a fully sleepable context, and receives pre-snapshotted
unicast and multicast address lists from the networking core.

Add enetc_vf_set_mac_promisc() to send a MAC promiscuous mode message to
the PF. The message specifies the filter type (unicast, multicast, or
both) and whether to enable promiscuous mode and clear existing MAC hash
filter.

Add enetc_vf_set_mac_hash_filter() to send a 64-bit Bloom filter hash
table to the PF. Each filter type (UC or MC) contributes two u32 entries
representing the low and high halves of its 64-bit hash bitmap. The
function accepts pre-snapshotted address lists from the framework and
iterates them with netdev_hw_addr_list_for_each(). When IFF_PROMISC is
active, hash filter programming is skipped since promiscuous mode already
accepts all frames.

The ndo_set_rx_mode_async callback selects the appropriate filter
configuration based on the current netdev flags:

 - IFF_PROMISC: enable full promiscuous mode for both unicast and
   multicast
 - IFF_ALLMULTI: enable multicast promiscuous mode, disable unicast
   promiscuous mode, and apply a unicast hash filter
 - otherwise: disable all promiscuous modes and apply both
              unicast and multicast hash filters

Set IFF_UNICAST_FLT in priv_flags for ENETC v4 VFs so the network stack
does not fall back to full promiscuous mode unnecessarily when unicast
address filtering is supported by the hardware.

This feature applies to ENETC v4 hardware only. ENETC v1 (LS1028A) does
not support VF-PF MAC filter messaging and the callback returns early
for such devices.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 4bc48a5f6869..dc9a0f74a2e3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -213,6 +213,122 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
+static int enetc_vf_set_mac_promisc(struct enetc_ndev_priv *priv,
+				    int type, bool en)
+{
+	struct enetc_msg_mac_promisc_mode *msg;
+	struct enetc_msg_swbd msg_swbd;
+
+	if (!(type & ENETC_MAC_FILTER_TYPE_ALL))
+		return -EINVAL;
+
+	msg_swbd.size = ALIGN(sizeof(*msg), ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_promisc_mode *)msg_swbd.vaddr;
+	msg->config = FIELD_PREP(ENETC_MSG_MAC_TYPE,
+				 type & ENETC_MAC_FILTER_TYPE_ALL);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_PROMISC_MODE, en);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_FLUSH_MACS, en);
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_PROMISC_MODE, 0, 0);
+
+	return enetc_msg_vsi_send(priv->si, &msg_swbd);
+}
+
+static int enetc_vf_set_mac_hash_filter(struct enetc_ndev_priv *priv,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc)
+{
+	struct enetc_msg_mac_hash_filter *msg;
+	struct net_device *ndev = priv->ndev;
+	struct enetc_mac_filter *mac_filter;
+	struct enetc_msg_swbd msg_swbd;
+	struct enetc_si *si = priv->si;
+	struct netdev_hw_addr *ha;
+	u32 msg_size, tbl_cnt;
+	int mac_filter_type;
+	u64 hash_val;
+	int i = 0;
+
+	if (ndev->flags & IFF_PROMISC)
+		return 0;
+
+	if (ndev->flags & IFF_ALLMULTI) {
+		tbl_cnt = 2;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_UC;
+	} else {
+		tbl_cnt = 4;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_ALL;
+	}
+
+	msg_size = struct_size(msg, hash_tbl, tbl_cnt);
+	msg_swbd.size = ALIGN(msg_size, ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_hash_filter *)msg_swbd.vaddr;
+	msg->sz_type = FIELD_PREP(ENETC_MSG_MAC_TYPE, mac_filter_type);
+	msg->sz_type |= FIELD_PREP(ENETC_MSG_MAC_HASH_SIZE,
+				   ENETC_MAC_HASH_TABLE_SIZE_64);
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_UC) {
+		mac_filter = &si->mac_filter[UC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, uc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		memcpy(&hash_val, mac_filter->mac_hash_table,
+		       sizeof(hash_val));
+		msg->hash_tbl[i++] = hash_val & GENMASK(31, 0);
+		msg->hash_tbl[i++] = hash_val >> 32;
+	}
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_MC) {
+		mac_filter = &si->mac_filter[MC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, mc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		memcpy(&hash_val, mac_filter->mac_hash_table,
+		       sizeof(hash_val));
+		msg->hash_tbl[i++] = hash_val & GENMASK(31, 0);
+		msg->hash_tbl[i++] = hash_val >> 32;
+	}
+
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_HASH_TABLE, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static void enetc_vf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+
+	if (is_enetc_rev1(si))
+		return;
+
+	if (ndev->flags & IFF_PROMISC) {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_ALL, true);
+	} else if (ndev->flags & IFF_ALLMULTI) {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_MC, true);
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_UC, false);
+	} else {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_ALL, false);
+	}
+
+	enetc_vf_set_mac_hash_filter(priv, uc, mc);
+}
+
 /* Probing/ Init */
 static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
@@ -225,6 +341,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_setup_tc		= enetc_vf_setup_tc,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_rx_mode_async	= enetc_vf_set_rx_mode,
 };
 
 static void enetc_vf_get_revision(struct enetc_si *si)
@@ -280,6 +397,9 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	if (!is_enetc_rev1(si))
+		ndev->priv_flags |= IFF_UNICAST_FLT;
+
 	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
 		ndev->features |= NETIF_F_RXHASH;
-- 
2.34.1


