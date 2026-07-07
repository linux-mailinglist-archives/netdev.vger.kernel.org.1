Return-Path: <netdev+bounces-305282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h9lUACiZTGp3mwEAu9opvQ
	(envelope-from <netdev+bounces-305282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79491717D5F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:13:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=ciXDFwze;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305282-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46C923034E76
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870139989B;
	Tue,  7 Jul 2026 06:13:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DB3955ED;
	Tue,  7 Jul 2026 06:13:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404799; cv=fail; b=oyC4HBOuRK4WGtVCnrGGsK1Eno1zvyUL1ZRozHHYRC9DtLzBhtt6CgDlOZFmE+FkcRfLLeDwotYiTut6vfJK13NJgSW6eI1W9OqJx5z9vAdP8urAKVsJBe97Q15BWJmkPA7PFO+8CyBCQUTDqwcsA5CTlmHg0591Mc2Lvmr6KbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404799; c=relaxed/simple;
	bh=aLUEqtV30DdjjunYoGhIf5N9C9FcP5HbUkO5fmpV+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+D299S0jNvGt8+oz9We5hDkenptsMM8C2+n6gq/PrgXSIifTeeKdTcSm98q5poHMfhsWouh4YaumNAfS/ks72U4mWdC+m5M0s6O8qrc8hHZBfxcRsI2vZDUbuptcuy+OC87xbmM1vClmEtPvP1dIFsqGyNpLUb89ObDP5LzqxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ciXDFwze; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvNUvEWhTWCYtY62hcyQ+4CXkTpuq6jf2bN9cjRWJKls8Lu6PGwJn1Uk22bGwjFKcY4hFEJw9efRrcY9YTVbi3R5PwrvfPtWgWrEjQN9Jv0SKKyUzn6knDTioFEBJBq6RoUCk/dS5h2Qs0nfNHBKEDG0pO4MurwVyyvQou64Pf+m0iojGHFMPrk0Fpj1+iKI5GZ33BsKQmr/20GdXhiKmZirgd1YZJK7mw3JG+E1nEoPMNzetTyF2yR3ZIk4LCER/CRXfnufryg8yOiU7UNiNIJpbfS/8BZ7X+0OoK39LY+boiO9EKmGE8fdVf76OH5nQ22StAMZ3Dbx2tLexoTIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR1wLZjrMZ++1kyBD4e57sSNMlAB4gbKtToiL3P7lOQ=;
 b=a4+Ix3FERPdijwYXrqVDKBoQ5yFyJh8+Nt+SywVnytuSsP96WscGhzh539zc1JHXOKAidUt88GKQ1Ew7aRxGoGubbz3f/O5uCzgrdrcSNPj/dizBj7/syhnRpAUxefGyTS8OI5fDyAoZ4+cxTIRIyHCn9GAPMWlfRAthtLE+ea3zeQ9+oNSimJizeHbSnGd4+9KvnjVdbNUmziXyolkZzwRPD7p4GnJRlEfBQVtI5gP+8pMJUdMOqvwLmsaIPRP8hlpRdppruS9pjLShhbZiRX1YpUPsT49JfRBTxGI8lglBbKBCSL5GYrO2i44cTNI2+1Ugz4LiKHGl8dOKE03cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR1wLZjrMZ++1kyBD4e57sSNMlAB4gbKtToiL3P7lOQ=;
 b=ciXDFwzet6A1FO7ac1FLAZRR8lEhWlNsEpKB/RQlRPV60ncUCujhPxugnZA6UFSHXE67uuQ17OsF9JDXn1i8+fJ8AezQOUO6krx6or8SLJ+DOEhVvzkBRQ/y/JOcXfqlwg2jhIs8vBu4L1JiWPYaq4Pciep6Cax/lbuP3taXX8rOS7dqiMY53b+N44xA/uvpchb8WM2J1262p1vvm6iHwQ1g+2dVlnniIFbK12RtXIjOX9OTuSyugEprH0m5TeavxwEGCKd/W5Fi+9b3YbIgofLCA0f4y14odGJBka53sdSQ7eCL4oahudDqb5BvjlkM70Q1ZzmLIuoNRB+FBfBdkg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB6598.namprd03.prod.outlook.com (2603:10b6:a03:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:13:09 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:13:09 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Mon,  6 Jul 2026 23:13:05 -0700
Message-ID: <20260707061305.27580-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e30f1c2-4b45-4cc5-d5ff-08dedbeed13f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|3023799007|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	3TqYb7ebRLHjJ9DMhjUrfeR0bWvqOmA7HTQq0aaYUqsc4TM9YBWPf+zJZmrosuxEa0lFN06RljuMh7wb0oEzSc4kcNUE+ToE48Euwx5lgvpcfNDZFRrKHH7SL9qm45xHR08a0lqZZdsbe/FE2djoicHLnqn36PfFWOOjeuXUvytovAWw+tfQous16mYUgG8Oive2gxvKG5UwaRiwUzP0abY7bLbNvYJPlPUWgiJNTzeDA7PSW38i86T6B6NNmZhHjorNmOtnIyDNT6H/4v6bA1FQTUEjW4OLTXgBriGFQSxp8zx/s+K5KxalzlTAG5jgAB9IW589eDLUwR4URacmZiBMq1T/Cx+9IhWja7RHS96jnCMmfmnrxL8ccCCIYFnWmhDh2DQeanNo1msmrKyQ3M+nwhFjPhdyxed3JfXAi/GEl1nyVVry1kDBLYR9dylxG2LFAEzCF92VaPz1EJnF/qHBcjhNZCLL6wCXPoS71V6qzTB3M3+PtNtRsH+rGrxq75Vx+oCo1Srm1rg1ttaXRsg34VjTY4ZvOg/Msw3lyQO94M6I6s5g6QVvXtfVedibYUTdFUXCyIMa+hh01MNYCwJ8SwRl9SlKxisUDI6wxSaLKhx+nqX6EJSyQtRPJB4dkhehamziFI15XgfZ1jvsb+R3SZwgYHSjUqXBZ4aQQZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LuhgQtYBF4FZKjfb6j4ncJul26Jarj6cc3F0y+pHA12j/E2MxVJqM+6egDf?=
 =?us-ascii?Q?8HknJkM/NyYO5hCYO1TK9Gs9ydW4B6K2o22E1vCWq4JNpxrS2EoUqpELlCab?=
 =?us-ascii?Q?u+P4rvLEl3kxuAPIfdCdS3+8KpLILc7THmcOWjeDheaxBEreEX0B7h4n3Th6?=
 =?us-ascii?Q?PKZMbzv6HJhtYU/u6RyiXVopboRtYflFEYTTjy3unSlwlrLY2Ut0DUyR2SOU?=
 =?us-ascii?Q?Jly85E5RfXNjSPDiIn9cNpA4bwLC7fkfEVxYOfgRL06MdMHI5qrKH643Eiv6?=
 =?us-ascii?Q?MxmO4eKKYSDcUzOcASwYdgyrsa3rVhTP2vv9LUcARgEXw0SYRkHw4KLhQrd3?=
 =?us-ascii?Q?7pKPBYaF5lEqO47GmAMmVjLHLppS28jK3QirY1su+1ZKS/k1pVWnlG1a5Ls8?=
 =?us-ascii?Q?GSgR5S3/9c2NT10snBZJ7D8FkSba1+R2JcfJdtgiLqv2APbrifI7W5jWfith?=
 =?us-ascii?Q?/VYI5LanjF5Nr5ypqj4a5UoQBeh9pXZvLfndakxDTtxpJdetdhSS44L8GMEm?=
 =?us-ascii?Q?LFlYgMQBl8Eb8+BIKiJxifFh+Lu13oCYnQs2WZBBJZSeijz1IpEMdpMOeB7J?=
 =?us-ascii?Q?VQthetbbWrKUBAdux5DP+A8CpY53iawyI96NKuxqlxZofe4VNn/eTLYRhRvL?=
 =?us-ascii?Q?rxElfL8SazPqu3/fSuJ88NLgUJ61vHfQsplwLPhVKZV+X4aDnMIVXwGX6LJr?=
 =?us-ascii?Q?8cJuqk23zsyhhlLgHoJYkR2cjyqb+SAjMm3ftMxh47NONZrZ0ynrrvVINK4P?=
 =?us-ascii?Q?HDsO3QJ771Hv/eYlw934T1gaQ0t9+Giih0djeE8Lq4RZlIz+zoSXa5v+FIWJ?=
 =?us-ascii?Q?SK6aSCLc/spf1AQ9HakSVAvKzcAIOieARAQBBMiUPUaMkfa9tYetS++EkoQD?=
 =?us-ascii?Q?gSlEw9W5yHIt3M+zieTPu6l0YHt6k+zkHdKX1Psl+SrNxddD2rBPJTap/Wy2?=
 =?us-ascii?Q?RzHMO8xuPleymp7+Uvmjkfh0ZzqfJCe7677S7vfsUbikDqwjf+7yX0I7qa4Z?=
 =?us-ascii?Q?1/8+XiTf2SSs3+9URKuYzmIYyUef48URzNo534OmIFkMRRU0m+2cSxyzH2V7?=
 =?us-ascii?Q?MLjTrZ2edjUr25xoep0R9MmubQyttJg+XbhYYkjPq2F9O0T24knG7dLkoGaG?=
 =?us-ascii?Q?mkT5ZNBDkCk6ivVP77Nxwm6w4Fq0Q/Nu39YIdKZOUi2/J1ilr8eo70iBBmJI?=
 =?us-ascii?Q?8wHDIEogxwp1UfdWMzm9y7y6JAZcSJ4CFMNGSTIUmKGE+e7uWSMvXlkI4gIi?=
 =?us-ascii?Q?NsnwV9S4lyDNT/E4Lxt72V3xcBQ0WNnym2erTAwQMYoqhMyALYXqhkUDm47N?=
 =?us-ascii?Q?aH2TIPxasmUrtPtVOOdDZOLoLFF42+0EyaADrWZryFn43p+Fi146Pkb6pBUB?=
 =?us-ascii?Q?CvaksbGcYOpnJu09rO62hXo2CYAkosRqwtSsC86Wr4o9qJA+Qpd+wYiNg01n?=
 =?us-ascii?Q?GCjb56SX96UrDaU/prWyi0juwEPPwLPJUvA7Od6jWqN1lT6qLRuY7j1uNzho?=
 =?us-ascii?Q?AxpTlLQnBBn/wSD6ogwlHnIIBXjTjunKPOVHrd1YCKbRAsPMFR3TpT9pP+pZ?=
 =?us-ascii?Q?tXwFCs5JdFubKgsZWU4jACxdYERmZ3W25Gk15FyQPDsQelMs6UhSMXXEfLdQ?=
 =?us-ascii?Q?7RgI33xl07zhjIkhS1oQyL7EZejNq1vAgvGfg2zkGy5+ZtqGxtiIc3ToQgte?=
 =?us-ascii?Q?coaB/WeKhBvdt5K1ZwbewcJPpiDdKUU0QBT+zaI4gXRwOt5mJGR3OzetmGpi?=
 =?us-ascii?Q?Ypme9v1T9mk6tCHANR9rnn77W21dOh+beCZjfv3SudjemiKhqRNsegN3ShKH?=
X-MS-Exchange-AntiSpam-MessageData-1: CN5WWT2xhxaQEA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e30f1c2-4b45-4cc5-d5ff-08dedbeed13f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:13:09.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8OFb8opH2A4Esx6uDes+5XQnJQntngCYaDK0UcU9gNA/CVeMi5HgiEvkrmKonNZywrAulP49EdLoVXTNOvx5YFlpJ6ArVpM4zxu7ZS/JIQ9aVgZo9y+pfUxk4zdj4LJWIEX9/i4bK3z7dJn3EyOqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6598
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79491717D5F

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays, so the MAC interface selector
must be configured for GMII while the PHY is configured without delays.

Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
and detect it in probe to force GMII for the MAC interface selector and
strip the delay bits from phy_interface so the PHY is not configured to
add delays already provided by the FPGA converter.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..bf591a68502f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -69,12 +69,13 @@ struct socfpga_dwmac {
 	void __iomem *tse_pcs_base;
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
+	phy_interface_t mac_interface;
 	const struct socfpga_dwmac_ops *ops;
 };
 
 static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	return dwmac->plat_dat->phy_interface;
+	return dwmac->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -650,6 +651,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	dwmac->mac_interface = plat_dat->phy_interface;
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "altr,socfpga-stmmac-agilex5-tsn")) {
+		dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
+		if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+	}
+
 	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
@@ -674,6 +684,7 @@ static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
 	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
-- 
2.43.7


