Return-Path: <netdev+bounces-255528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PqzDauBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20700C428E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8731730117CE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37F38B982;
	Sat, 31 Jan 2026 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="s/YxcLcN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9F38A9BE;
	Sat, 31 Jan 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898367; cv=fail; b=ZWfKqyhc9n6hJ80eNj6qxjajJqSf2RfmYVsqRwLXe2LY+THFtNFaovDz3PFARVu50zaTyNUq/265blsVikzDSBE0OSN7JGgZIDt8ZtkoKlVUmm7BSagIYdbL2pSZzxX4vydlxzalENQe5PuNBoh5/T8TPBr/MGQP1JjDrGfi7us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898367; c=relaxed/simple;
	bh=2m5OTDUe+eV9l8eby7FWja9/t+PT3tsITAq0dIVqg8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9L34jnYKHiCcTLiGRjP4Cd2c8y4h8kohwrgaz2kMer39j2axjazYSy3/oiZOmwHq5ObpTkyuwOfbRPjNTeu54ATA8HNb3GQz99CHktKul/45AzWZlsQ0JkgJsamzbs0T3qnH+R0z7SjswXZkW55viD2wmIbdWI5ZL9+Z/1Sy0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=s/YxcLcN; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNUoivaP3JUkNoKeKMTpEbGyo58ayuUjMo5CzjsZZ9VEuq7bmx4mdQGuuiIFktuz81mQUudFrdjZyGsAMFtZviM1HTZNTnALB5qzkzu86AYmyQqG5GQglPlG+DnR9N5ATyGbMc/nLmt3Muv4k1/gPaHIHH0eeU0+xNtqIVYhpgOD9lSlRUisUd5enveH1ebZQnG8aKxUQrmQKOnf9psKQyRlIRXtYa8xasZKQrKhdg/qm0mR87FWlVcQnxaXVCDt/JpijKGLgvod5Tv3wTYl/uox94IW6lhrRUbBO2W4A6MyBrJEyenwx10MNvDq4bOSzm3FlWHv/fzsJ1T6AQq24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQt3ymHLq7v+WlWKYyKOI5bEJtnfkyYZ8CBwiPGo4Tw=;
 b=JRtwujQTXbcCp4JkXogNK+q14MsUgU0MUyV2mxf7t1/nA8Don4kSnSYvRuFKYrPhJbhgeqDGJBVM8qXB4f9ixsCQrwRdGHN59zZJDGxyOlvlm5SnrmL7hwzxnLLNLOtPHDUzGhPvjmMXIaviNRw8yP1w/hEtLNSIpWa2jeQTluFwhtxYvdOXLjVH/9nkt62ciJag9uRUygSQKPBZqTMWmyTe9zPqDs4u1VwzNip26gI/JZ5WpQqcuC7xLtdnLe/2eiZyyl2YfX/Q8Oxn8+HY7WqeQ0VSwGjzZ4nZ3jdh1NSbzF3NiExYA1bch5L0NwgcPXhq2PZhOtIXLMoT3vMx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQt3ymHLq7v+WlWKYyKOI5bEJtnfkyYZ8CBwiPGo4Tw=;
 b=s/YxcLcNVCgD+k55czaK3ZSUJPLUVxdqvJYQ8ujbKZdktt9qIbIyuZyxbNEleBaqKxoITGX8Ta+N+754QEKkEqcUsUFR1RvHSjUQHsVhE5FPAV/aiVq1WRvXvn15imPjhP3yIyMBDud+ZrzKV390gs/KL+Qoq7bjHBwV58NLMek4jCVp7S0HVF7f6Zs1aLX7gbwg/b9JMJ7wCHBZuh6Z2dEcMfqdG9pRVNX7CT7jL4PHMqXxWzTRfajzh982TvD8g9mIwXD9EiTlmtCC/YEUbdweZifnmEdvgntxmZd8vrbevRcO1QidL9cbVV4RnEQZ5Lzvxna+s6RM2JOKN9mCvQ==
Received: from DU6P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::28)
 by DBAPR07MB6646.eurprd07.prod.outlook.com (2603:10a6:10:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:25:56 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::5b) by DU6P191CA0029.outlook.office365.com
 (2603:10a6:10:53f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id D96CA238FF;
	Sun,  1 Feb 2026 00:25:54 +0200 (EET)
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
Subject: [PATCH v13 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Sat, 31 Jan 2026 23:25:13 +0100
Message-Id: <20260131222515.8485-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DBAPR07MB6646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2a968e43-58d4-4ba6-923d-08de6117b403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qeK9g9tCDPYggOdW2zwG+t6cvasZkFWHjJUA5JPF1/aeaxDp83MtfydGpmpg?=
 =?us-ascii?Q?eA5orCHUUkIZJp7kujBr1LpjWlnYS7it1ZwudequbJ7doo2CnQjdKkRy/FOC?=
 =?us-ascii?Q?px6MTDu8oPJKqpyjlqhmKyQm/fz5sAKf0ja1659IqhIYHVx8GlXTUuMDGdfM?=
 =?us-ascii?Q?V9rZXd8L+N2RdW1Ow2JPbIm26Xz5/koPXEPBBiOEYRhZsxBOzmNRANK9pr/w?=
 =?us-ascii?Q?Hndi6Cgh4RFhnmEootI/Lebvj8H3TeIMImXprRzKyCudW6k+keMqTd/GQX3D?=
 =?us-ascii?Q?+vUPMttv4BiGgviLkP6522olz+aIL6hhIPOTDSWOR/47YpHZGFgsB+BTkmZQ?=
 =?us-ascii?Q?4adhqUK7zGkmhfk7J2BbszG7f5E5DqQslT/zz1fhLpInvt2QCH3L+nXwDJF2?=
 =?us-ascii?Q?HgSp3vABKUcGFdb/S/hDYZoIWYAmJ7b1zhlX6DmEYJ4yfMgfkDteM4gvTZ86?=
 =?us-ascii?Q?A0s+hNQzE/KOJZYQ00wL9KdfpfZ7DFIkfiDlsRXE73C0XAgTwvlPmIuP3GwK?=
 =?us-ascii?Q?rEIfgIUXgctS+0th6wRNsYF29kKyZeq+/1HXk86tgNZ//ejCEvcK8EAwYXXl?=
 =?us-ascii?Q?eUcedFm/6Iz9q+rtNII33tZBxGm0A2Ab7yPQSdMkDtF6BO0kA9yc5r93zz4o?=
 =?us-ascii?Q?hfmBXdGrJd3rLUQUza4ge7xs9jXFur5bX2KIquoJ1+XBtlPqf28Dw0/KjCuL?=
 =?us-ascii?Q?s2byuvvjPj9sz4UVSeQJsn4JdEGpd+I9xSE1WnzyBGbb+Ni1LkDNm6tg1gKc?=
 =?us-ascii?Q?7h1LcbH0YDl2ILCWT+ZRJiyDsXukNJU33sAE92DvsRzdxzcBzDmT5saaMBHC?=
 =?us-ascii?Q?uCfIU5PoNnPoTjD5fPQhpdsmT8naNZ0Bi5nPR+jyaM4FFF90qUnPQOSwQDEi?=
 =?us-ascii?Q?maXeuSvWrhYMx2m1GaIaYTyeEMg/XqtmCofa7us5/Jwiyt+P3PAJrg11M5x0?=
 =?us-ascii?Q?cb1WSMh5eKhwUU5GJbInJV1bHsVu7wraj1X+vKo6oovPJlLYCLCmIUBfILqn?=
 =?us-ascii?Q?fIYO66yA5nkQ1nr4BOxc6AS0bwIs/bsVbtyG9bcYysvKH8lJECOHxp/h6hRT?=
 =?us-ascii?Q?HsmiX8uuth1/vSdSGQIve7X8DA2Ya+XRf9DkNQqaHOdwt9qBFxAcM4OP1qyF?=
 =?us-ascii?Q?iCm/sc3RFzFvhkyEX8IXMRIwK04kxyDm5vXOsd0Rd85CvxEgSK4HsodJ9lZl?=
 =?us-ascii?Q?hFNKdhNBwlmfvZfRdZ/4aJrHp15GJbcgpApPfxC5yPW2wrpURY1mh1hTCond?=
 =?us-ascii?Q?3FLxm4q8BtLnUSbmQltQSIU+xcSKtc/YplnjE3uz3rBWPiyb2XdVKXWM7i/Z?=
 =?us-ascii?Q?tfgLZceIaeE8W/GH2eiv8v9eTdEUbiYimNiPzSOddgIaj26OsPOAhAVMYr/P?=
 =?us-ascii?Q?+x2U4ROl9+vaivYmCKo/PONb4deebGyjGaSIwytQyurJrBmPgUZIfBfP13BJ?=
 =?us-ascii?Q?78PmQ9azVqyKuHNU+gzv+EW38CSwS0QYU1fNvmcLUlaDT4GqAXGHzDijxmdk?=
 =?us-ascii?Q?kTI4FwvXPNdPSAUu0BlEoSsMGhSXbRm3gk3qErg7cwuutWh6SOoNXGjcU1CS?=
 =?us-ascii?Q?fMcAbCOdhXS0lYdFnbsWBQvLcwuWDcNB82OYL43pURdnXnsr6EVVi1vzwuE3?=
 =?us-ascii?Q?DXoZLh/LQtJf/V2Eaj1644BAKL5+y+1eDy/eHHuc9+t81qGwreyF4E22lBWm?=
 =?us-ascii?Q?3iLdVAgFTH9yss3JBjK5XTiHS6k=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rN/ECJmZyjcVdQ2uQXWDs1645ZEgPe/D7wujn9ZfvG8faIUpDIrNzftZRPpd40X2IavzZvLRhzFCZCtifp0jOHXY52tS/KI3tC2DWWBBIRFlTelYKYoDYpWjWKcEv+7T8L4DNYaFDKVvGegCUEZoI/gWarCSuTQjMDusAJ8XMSgPYkiUUGqDnnv8+36KILUNLcoa4dXhuwBcrK6NaM+jiQxeOoS3WdiK3aatb/9o8HAlaroW0T/F1L8AZTuLTawYfTw/Ns+2G1Ctoqrx2buXIAJBDcjCxA00MbohhJiT2T8KvMeRdMePt/e0A/g9Uw7tPnRkKZtepPZbIBM/HkdRWTqFzHyPVO1S3JlgWG0J/cl2AI31pmuIJWVCQQh1EN/fF7megDvQ2CFG1QuKkbSevn7sB0wzVugzB9Nu903F5oj/rWISPG/skXgWHcZ2QQHZ
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:56.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a968e43-58d4-4ba6-923d-08de6117b403
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6646
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255528-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 20700C428E
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
or ECN_MODE_PENDING. This is done by utilizing available bits from
tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).

Also, an extra 24-bit tcpi_options2 field is identified to represent
newer options and connection features, as all 8 bits of tcpi_options
field have been used.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp_ecn.h    | 11 -----------
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 net/ipv4/tcp.c           |  8 ++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index e01653bbf181..e9a933641636 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -67,12 +67,6 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-/* tp->accecn_fail_mode */
-#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
-#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
-#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
-#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
-
 static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
 {
 	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
@@ -98,11 +92,6 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
-#define TCP_ACCECN_OPT_NOT_SEEN		0x0
-#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
-#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
-#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
-
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dce3113787a7..03772dd4d399 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -226,6 +226,24 @@ enum tcp_ca_state {
 #define TCPF_CA_Loss	(1<<TCP_CA_Loss)
 };
 
+/* Values for tcpi_ecn_mode after negotiation */
+#define TCPI_ECN_MODE_DISABLED		0x0
+#define TCPI_ECN_MODE_RFC3168		0x1
+#define TCPI_ECN_MODE_ACCECN		0x2
+#define TCPI_ECN_MODE_PENDING		0x3
+
+/* Values for accecn_opt_seen */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
+/* Values for accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
 struct tcp_info {
 	__u8	tcpi_state;
 	__u8	tcpi_ca_state;
@@ -316,15 +334,17 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
-	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_received_ce;    /* # of CE marked segments received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
 	__u32	tcpi_delivered_ce_bytes;
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
-	__u16	tcpi_accecn_fail_mode;
-	__u16	tcpi_accecn_opt_seen;
+	__u32	tcpi_ecn_mode:2,
+		tcpi_accecn_opt_seen:2,
+		tcpi_accecn_fail_mode:4,
+		tcpi_options2:24;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6e5bb1ab2962..bfcecdb330e4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4382,6 +4382,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	if (tcp_ecn_disabled(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_DISABLED;
+	else if (tcp_ecn_mode_rfc3168(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_RFC3168;
+	else if (tcp_ecn_mode_accecn(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_ACCECN;
+	else if (tcp_ecn_mode_pending(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_PENDING;
 	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
 	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
-- 
2.34.1


