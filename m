Return-Path: <netdev+bounces-254288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHr5EysfemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D7A2E57
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4C1306C2A6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323CA360746;
	Wed, 28 Jan 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VRtbmPby"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D6357A5C;
	Wed, 28 Jan 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610898; cv=fail; b=QnCkavSIvk8exvoBD2ENVtpyuOayt9Gzq8jCSaV/HX2UmuRUAmSiEkm+8G+f3ip2bXMt5TGpHJ3aRHhwT0l34ho7BP+C1Trum17YOkC1FYwfyytlutFM1u86oRsXzQGkcedn2fbJ1zZXVPcoNw+6+OhlhAqJ9nz5XW+4OgfYohA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610898; c=relaxed/simple;
	bh=s1XZncvgOh71GEK9Ajjd7vgKSOe7HtAgxYOsw3C+EyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWOB8rr9mKhfK1iGbgsB3O9HOG7mvoiqxUcUEdQFDfn30nTgd0bwPvbrh/zdNw5ReMEKHAC/iNbujHfCpUrvt9UgSLbFg9rtnlqWMX10fY7D6T/owYngvgUdWk0I7BdmW6C48SyfH9sGLjeE/WH6d2tXJS9uuePiiHRGDfsogY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VRtbmPby; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE51kNivJtkccHxOKSBhkJYS2gOfAdZaQ631CoVFlRZDCzoXGzdH6eE4c+M9ipQLZXg2u9SiHQst1VIghcV9LSzxH10rWDItwgQaYMCMaXHRTlcX3csaFj1tzgl7HKjk+uoi7ppLUQw4UMxo0mT7Ey3SqHRJ5jUeFQ2b/R1XrP/hNYclat3sLBaK84LGRSPYKtdOSI9zhZMwu/gF7FgPNdiNhuJbBIMkKWEdx9w5Whux9BsTDmQwRMmVf49JHPgoAL+7CifKNoNzBgG55c4bdce//aoiR7cduVvmesAJx0fiz6eNQcJs1zzLVk6vp+aWlPBqkrcTRLZuVT3MAmwwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=n6GeKvLOTvoXiH3xy9y9hY4lZiNjTm0wxfBsj1rCjRoWnEst9WqfTpXrIoW64gwMmT2hoohViePMeuY985dvaHZG3bDMRc5CdXcSFZx4zP8uRPGzROrNE8Kob7Z2sGaENrALtWP+sRsGzE7bYig2XC3apUFwwMfAtnFlXPKwpuN7Tv/cDpPmKwsr4bOtJerIb3Difs+Jp+0nLV40vtizLBCu+Kn/sC0rpXQvpTTxHyHzuv7dNRjpchRC69O36wxxCMz9s7AYpYevg3G9LW8y9BkBjZOzin21Qvs1PSvtB3BTnGmxTONyEDJdrqa2mYE1zW+sm7+15J9TkV8XVtu35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=VRtbmPbyOfsPS/c6gH4kNqTO8nyjPu9m8TlrWmQsibt4zVPw4/05Rwwbno0ONZ19/mAI7+KVoBslMeZ4L+w1njWGtPMZTDcoDXMwiL+LwQWTicn1OKrSkYR21Xo3rqvxPZoEghGN9vk04DbC5x9vLrKn8qOHebXsd9PxJLfGuBeGIpje4t/wrqBNjxt2Vbbo88JI8vN/bPo38JMWYXI8enRpAaUeXzFDGWJ4W5K444bkoblCP7WyPhtdFWQ+0VRDhv7iSGp3OSfK6dpZ+OTnx3U+V2nzpWPa0dmKh3z8rXk3sW9SiAidOZ/xFR0MkclW7AQ50408p98Z9lTsdyVLxQ==
Received: from AS4P190CA0047.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::11)
 by VI0PR07MB11796.eurprd07.prod.outlook.com (2603:10a6:800:32d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:34:46 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:656:cafe::a9) by AS4P190CA0047.outlook.office365.com
 (2603:10a6:20b:656::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0
 via Frontend Transport; Wed, 28 Jan 2026 14:34:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 5359A23672;
	Wed, 28 Jan 2026 16:34:44 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 03/15] selftests/net: gro: add self-test for TCP CWR flag
Date: Wed, 28 Jan 2026 15:34:23 +0100
Message-Id: <20260128143435.15708-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|VI0PR07MB11796:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 132dbabe-7cb4-4d34-9085-08de5e7a6221
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LsFT6YInx4pmDugjs+0lpitvwYdga0Egv4uxzF1jKQfmCtqzy6QdYU89xE2R?=
 =?us-ascii?Q?pV97AHqZCqxTEPCp01inLU8SolT1u74akRNZXO6qu7Ur2IQdTXXbVS8gD6ok?=
 =?us-ascii?Q?eCNyjBKMYvs8gLzXVmKpEoLb3tYpiQh6s8VAJWct3Vv6klXU8NzHBomMeuoK?=
 =?us-ascii?Q?esAGUVZVsjVVsb9e9uVR1ZkjVLoRO95Gj5jhoc1UrDMZROet8WmlD3kApU6c?=
 =?us-ascii?Q?nS3H4Ebd1ydbAWz/3FtP+hMMA0HbqhdfWXAuRQCLl10WJAWbqLnmAt7DSSkD?=
 =?us-ascii?Q?FbnLhnsIMpx5rZpjdGfKmhP+qzQB0g4bRZs2Vr0k9B5ZzQ45vP8g7YSPyXR4?=
 =?us-ascii?Q?ChDjXBC6XmN0+jEt92hzRs3Rb2Kvtg73UgecjBdSbdDdfr86iaCaR8fXiNMb?=
 =?us-ascii?Q?8w1sxlH7mayROhrhjUfyLNwaob+Da+x5KeTCS/4yLtmkI3LRsZcKh/hLCDZ/?=
 =?us-ascii?Q?3Zs9K9aqtxe3zeUq3x0nxKiVjhQsCUkFA3prCKPLFkRp1JlFSdCM5umgdEgM?=
 =?us-ascii?Q?XAkVFf21FZ5pvCree0CtiKaqlsXBR6aYPTy43Vo5fOiLlLnaEkL87yy+q/BB?=
 =?us-ascii?Q?9ZTBorxs4I7ACB2FtcW8RHSEj9rZWvojF0AXpZO5qgAszBMqcfO2JEfgJr2D?=
 =?us-ascii?Q?kysAtTDdDmMZlRsK/5U+fns5eazQcL1v21j/xIEWKJ2WZBHCP3iKIsKA0gAD?=
 =?us-ascii?Q?jVfrC9eiD0IaWmG6YjkPUMuCYjDvhkIWm18vohI7KEku6iOLHlvacPi2P3FY?=
 =?us-ascii?Q?pFmSBC+Hk8mH8yqt9K/I2oeCm7aFYN9fLjqbdHnAooaVZnbWxzNNme0U2K/X?=
 =?us-ascii?Q?Pih7paDkJWlve+hgkq+Uh04n25WnVg7GsxuINQv+uhOMXkaWlc7PtAn6U92p?=
 =?us-ascii?Q?bzk9JXNp57z0TPCOBYV/5pbRtz0gYBYe51iREr5zBK1iatkJfmOPATh7Ze2S?=
 =?us-ascii?Q?XF0WlJnIKLivdcdrI24IFvVRqSQqkH2l5mRzogE4YamLCUsDpXqxclJfaNHJ?=
 =?us-ascii?Q?swe8Q0NGMhPboQ/UL8zKr1bmH5i1tf3TTU7A2j78sedGxHMIHRyl9hrmwEj9?=
 =?us-ascii?Q?E7ZO9FfEVoA0jJzh3Z3u7hfizZkeUdBF/g0cKnwuaAhUPZC5HL0PcY3PpF7V?=
 =?us-ascii?Q?vQb/PPAu+tUKFOQU6dB/+sgJibU/64X+xmM7BM4Af0q+boac3aLP7BQLqazD?=
 =?us-ascii?Q?91jexHnlQoEQ7Tpl6yVqOd4+9rR1jgd1il3e+8XUW+zcUMnf5lrJHSrGUckZ?=
 =?us-ascii?Q?7oEcRR72D/dokqTL7cCQ04dmXFcxiGKSTp7XhAqqTJp+Xc0huzq6YOWg8Ews?=
 =?us-ascii?Q?dZfm+i+Z2qDA/IVXHYfjEM97ElW9P5I91O4NRrIJ7M2oHO5T2BTe5lGbxrQI?=
 =?us-ascii?Q?5qjgm0eA5xWLKqsJao6MDr+p7no1aigJ3e5x3t8VmX0H57Ek1CTYa8dTpThA?=
 =?us-ascii?Q?DUXnWEaGBTPX20EqVdvxbJXSqwzp/8yPUXqiriKydeyTa6iZNq7JUUABRmUC?=
 =?us-ascii?Q?PddGaVY87lxpBzaFpEBy14LjfxoBsGjfgO2OaaDn2Zws69VPVq7PpGr+oVQr?=
 =?us-ascii?Q?tRrNOO+2Re05tuxjJImP1rr4GXcxU7awocQeuhvcuz6xyjYtj2Y1/yrta5ah?=
 =?us-ascii?Q?ai3mTbDstSv4yFbfO4NjkcXll7mz/WqSpLI343ELAkmhLF0JQSdZlOIy3Z1+?=
 =?us-ascii?Q?abfloMtUks9eGlcOWPPMdvP36v8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 pYATgHsD6aHWLzLhbDQchLH4sifMO0+UJ+qzQy3AVOpGmIf0FoZdWCVYlUnK1/BHNtH2X7TG8wztd2V+KOs27elqWxSASdsG/WXvquiL7nws9lZxCxwl7t0BKQUdFhVpTSCUvFET+DuS+m4NtZhlIw1qXFn00dOseTbCuOnl55bc4NndcJvwWZifhDoU/2TuB0nwXUdOLCmnG0hg6cOenxmc+W/xSVNgWO/warPtzJ7U77XFrjOiCKIwu3ZWRjJhgO+yqeA5RXg8Dgp4v7sb8imd656qB/MnkOZPSLUcexit4LE/qxTfeJm4gzjemNpaH5vi7z604huxg+5tpsD4U9GmSfQbVYGTFOx33qT8x+oi3RGEapm9/qLQBvUyKZFCW39X8Tm1ZqPMnS0PAHQ4pWMmKfuBO9fN4nudlwQ3MsA8mp7LYv6F4Wn9iRsCljNg
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:45.7860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132dbabe-7cb4-4d34-9085-08de5e7a6221
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254288-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A88D7A2E57
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v9:
- Add missing comma

v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	/* Create and configure packets with flags
+	 */
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..cbc1b19dbc91 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


