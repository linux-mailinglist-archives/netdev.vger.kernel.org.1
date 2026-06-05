Return-Path: <netdev+bounces-295683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kH2yC7N7Imr7YAEAu9opvQ
	(envelope-from <netdev+bounces-295683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0F64602F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Gv9HSCFS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295683-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44CB309EBD6
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DD6478E52;
	Fri,  5 Jun 2026 07:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056147884C;
	Fri,  5 Jun 2026 07:23:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644186; cv=fail; b=lhVENkEPAG99JU7LaCc5RYKpOMpgFHT/u10ZTHTRxVe4TpxqaiMOAkvX/jLQapD9JfZ4WnbOXbE04CyBlItbUPEDzNQbRMXT5GUxnmKi5UCE9oPf9KSLl3agAq5T4e2q46Zd4puFe8ljUkeVJPRGg00UaSHhjHop+nJaAJTLRMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644186; c=relaxed/simple;
	bh=NYAPbb2fzNMBXftf6hVC60LPB2qwBgl4IaeaKEOpe94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZS0Z6s4o1sgBQb9bBWT7qg8ZmNNEg/zfjqu1qZIS7cKDLvIhctBS6iGcvMjvJX9vVLCbJ2piMhR5cm/0sWjRcHApT6D63CxnuInQnWQToD1eicilK66NoY2zFNOgVPQ1Cuqe0hzYjZWCO4UdHPXPRFMaB4GIwnNQnKZLpq/g1nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Gv9HSCFS; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoIjP47C7DWSu5IsoBx48jwmKQr+v39MDGHHTxa//IW/W0UvrKa9r4sRFe7OlOfqIMjCn6ayXSXDqHsmyAX6laXfplvtLvXEMSXIJwTOsaCR/x4hUYMmhbw3MB/byi/emF2vqXsd64J2eclvhQ43CvyyXi4H5ZrPYENrE/lQI+ZHBoyh+Ky/eKV/BBzUbOWgWCyzW/vvT+5ZQlg27ISka2RzbZeswdtwooDnaSfJpjq9S1ywHVTx8hxM3aYt9UJgxJ5n56T1qmXxOyyUrCrth8A+k0YVu4Bad7+n8athIcWJqVM6+uUqf4NphEWtVy8ov2F+petI9NuULIDvI++dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxvee9Cn2vscr6aNT0kFV/ijwTndizV1M89FaVt5fco=;
 b=fHon2UVWh2OKNXAAEUM+SmqNfCFaM5J39i2aIHZvOKOvUl1UU66qc1wd/9vlzhQYLhcRnHZqMIO7DkHc6OvquWIJKCZMCM3JvvErCt0wRPh7JKXh7ceao36uXxESnkJtbSiyUYTj4cZLs1TPRO8nNw1BT70is8J/2WqgKGWive/o7rLvwkG85VJJ/ituZ5Xza1IuFt7g98wNjfhpA6pXjgjcS7hH2xeQr4CSXUJnEhbas6SosxURfFW4uR1ue3v4cgOev9OdsWK9GQmJi70GP2JjTTa9sW2dbuozYBhFnepNIHe+tcLm59QAm+s9brW8F7y1U5l4U6iHAnL03txARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxvee9Cn2vscr6aNT0kFV/ijwTndizV1M89FaVt5fco=;
 b=Gv9HSCFShOXu/0nNQbOVL9YYhyKhuzY6UwQo1eTRn2d5bw6FqIOkstjH+i62A0oCJ7bGUClCP0EZlel0EZZFPGdhZlvap/5FVTWrqPMRR+V74Aut3ZHJ0c1xcVXlulaEu3Wy/NMvGP8PvP2UyMymojWZOr9cW+Px1Af/t2E9lZgFfPIjy5MXHOsihTws8D1yFsqFH2u/ycdYU9rblbMVH/GBlwk+RHTwmJJ+PSrWfoK28iaj8piRDiMtq7d1XxVQ//5gym+F16Tq3kSWFRJ/aE2oYVJma3mcYyskyUD66nb+6LlN9OBz7al7c2eIIldzQCvzVsj+vjI0Forh0ZOGIw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:01 +0000
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
Subject: [PATCH net-next 01/15] net: enetc: add trusted VF support
Date: Fri,  5 Jun 2026 14:55:36 +0800
Message-Id: <20260605065550.3038579-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fede7d3-7324-4761-0d43-08dec2d346b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|3023799007|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	JjWEY8WbeT5n9vgMw5pAlXV6vnairfQ4E1dOfcm2GYSy+cci+f+N7aVLWYbXvhMFvIf6kEf6ZVbiKXplgSFsmJI8fkUa2vP7m7mAOmmMP8ogasvnw2dcznpj8cd/5S9YX1Ctjz3bXJh6gX+cxq6K5IpbwtnbUhuir7bSpMHtFmBwMi2ufvhytX0MNbG9qoB/sFdhQhCEP2J70X8osAXZ53PSkHodVjF+sOhFuuqbdomaQill9pQN6MkcGiQa+eDN+xMWRI3PQDm5CfkvDRZSC7f+cxP83TwlKc4CgmoTL/tfZsjBVEb7sp0CoT5DwmHX1n4ijRwKFkXdd8jStHhOtoK05ul31r1OhUAlsD+C5pAEmJLlpSSKV/66t+PYlnwjGTW4Ry9XoPREQD2T9lcRWZrbNNEl0odfiIpB0iNOVxK39BRVop5Dbt+2EySt001dJFhaU9vSILoMvgVnTYEDemEGn3Zje8KnkqWxPAouoSYBfgscUCQbADOQilAI2MzzpCA/4pOR6sylpzbqry/C8z3XdLb1EkeeWETQwFfL58FGPf4YXT5uSMhnc5GcJ0wzxSgqZQwND1+2DGOxZu9iuelCmYnkLFEm65y1kjrgzs77avFFm1q+hgW4PEN0kYvBRrI93nPEgYHIjr/pW4unn9LjT85mWWYwP2LIuEt3jv7M0Y8yQSnbVrUkTe7XZcTx37u1PVCK+vz1V1zC4OZ7Bd0dZUBE0M3zxc3Pmq+/58k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(3023799007)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CPZLCusppTeVQudxCCg6E3s9VuYEmkc0f9B8c2wtOlw8pbrlnpPmCEBdJTT?=
 =?us-ascii?Q?HAwV6Smg91F/NgIequA3FPskBaPfcrYOiI/jHc0DMvxUFO3Ly3CLJYQpzwHm?=
 =?us-ascii?Q?GMwoRBe7UJom9PUx4pxI6XZLBeEABhTRHf4h6GZ5b2l7jIYrl70jyWaMY/7f?=
 =?us-ascii?Q?VIW8ymBadI+EUahiqOwXuAwuRV+NDXYQaE/ijGaenaebY/88sfnay25t9NeE?=
 =?us-ascii?Q?W0RobYxUFaVMxcjAJKpF03xRCi3ddMzD9Y0neA0aDjTWzdcfdrEToQexijAo?=
 =?us-ascii?Q?kMzjv0UpKX/4CWRjngcWX6nJIxr+atjEVDM6073BR8kWGGhUmmxiEEnxWF64?=
 =?us-ascii?Q?yIZ45sKZ7jI7Kp2pnEPJMFkNtQ1TKf6R4xSpCn7w+3YySILxCXWJ0iDj2r1h?=
 =?us-ascii?Q?oVy75LaQHZuR9vDlJ2vUSY4Gzvb09XezF8QR/SUbzRNkV5Sh4EueSJF5mffs?=
 =?us-ascii?Q?pPZiWcC6HLr+zCKoJ0mFsJfEbtHGu17ZR0ECo8oeMmGnCks5ZdD+eOp+Tmjp?=
 =?us-ascii?Q?iBMZsi2Sir6C35sr/3G3hmhtusM0OBbvAeJfvmqNSJn4XxeDeQ04FPY3xQjA?=
 =?us-ascii?Q?UqxvxYCeaNXaG5t8XcbBShpUFhZNpXJToWVccac1wokoJgYWZSa7yJ4GOy17?=
 =?us-ascii?Q?gLWEMm8fY4fDOcolEKBxvf3S8+ODfq8pH4hO/9wsfYF1v2cUNgl1EWNrsl6e?=
 =?us-ascii?Q?s63jkFn522PEpmqy/EiD2oDCVzn1F+wdjNpxmJCUEJ8NI6HPzSz/bh3d4q6K?=
 =?us-ascii?Q?O3FbBXX4ZS/kd1kKD/zqKqOVw0j0FTVgf6EoHR7/ZjYX/rMqyjWEn2jfZbo1?=
 =?us-ascii?Q?0S8dfUJbYzJLzS2R3ru6v9xCeQNAh3EJRM6a9a6ujVuORups6SjukESuqKM7?=
 =?us-ascii?Q?Y8GtLptdemX17YBx+1rtJw957eVMI8xks8U6vWYKSdIPuXJCXQeS1Z/Wpwun?=
 =?us-ascii?Q?Xt4CnCcV9qwEVBYTrUeVKpDXW/fintvxtB7bqM5rD9EeoHcAh3iZlbHu/o9H?=
 =?us-ascii?Q?smW9mTv433N22f5tsjtfaQ8uePnDpI8FrEev1j00og4mdnAQ2E1gztXsZQPc?=
 =?us-ascii?Q?2f31rzrp6M34wB/vcRkxgIoIWbbLu4nIYQVBkeFUfXHTPzBvI/6/uQsCFaEY?=
 =?us-ascii?Q?Dz4u+i57cs4gp2+rulO7dZx9buk/rvVhwcebgemE7WRxLIkKZF0ULlKGSdkq?=
 =?us-ascii?Q?3r9Xwsot3A8Ayg8M3cyp03kPGhMcpUHG+C+D4U3HMU96ZDghEn+btiRtCPFZ?=
 =?us-ascii?Q?bHOWet4iroBtmlMBLD0ykihVFyM98tzUYNHA6LlI4cUoX9esDiceCjH6jloW?=
 =?us-ascii?Q?uui3CLB3rdSnoxReUHIcq1xdnz1b8QLVWgIJYQdh7BS02LOuZNzN7Fu6ogMp?=
 =?us-ascii?Q?yz94+rnHxZBmWmkj8bdVlbG/qQNZacwE3nY4xhbh4l5s+VQug0mWMQQSh3TH?=
 =?us-ascii?Q?VVHMFd+0Wi2nsfJeQhDqNdVX0W+XjEVodiue8ahlNIFl88TziMhU6/DqTsOQ?=
 =?us-ascii?Q?x8uJ+V9pRNASyrWTHvojwmHu8M8czP+UVdjn5u26qcfvtNLmn16KBh5aWxL/?=
 =?us-ascii?Q?FgJD0AmCyNtQFgp3QU7ACXdFASx8RATo4JtIVQYf+Iy0wsTvsd0pVaSHOrRB?=
 =?us-ascii?Q?R854f8qwENVkFDZYh58W1k9mvkdNYvZtzgiT1+ILnpNXqdTZDmP280djScAF?=
 =?us-ascii?Q?Dh14loj31RCrHrKFZrEVaIjA3x0+rDncinJfOrpO4jpU2aqJi4X5i3hLHgfv?=
 =?us-ascii?Q?YzpuaG33mp9d2NvDs5LmYpY8+SxYIGk9lPQb2HHdMmdnm3VmJ3+1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fede7d3-7324-4761-0d43-08dec2d346b1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:01.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 590HYucm/HicD+sNvQA36qOdprhLkXu8a+PAUCdLnoohqs+iSGPqjCdjeKwxdzGxc2H9Zia5buvL8BYgMuqrxegrbEdNvt0csPZgpp/OCtFF7X0iY3hc8cIWsFKgdZ/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295683-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72A0F64602F

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Some mailbox messages require a higher privilege level to be executed
on behalf of the requesting VF. Introduce a trusted VF flag
(ENETC_VF_FLAG_TRUSTED) and wire up the ndo_set_vf_trust callback via
enetc_pf_set_vf_trust(), which is shared between the enetc and enetc4
PF drivers.

The first message gated on trust is the VF primary MAC address change.
An untrusted VF that attempts to set its own MAC address will receive a
ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware will not
be programmed.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 30 +++++++++++++------
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 23 ++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 6 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4e771f852358..ee52ff929576 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -570,6 +570,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index edc1277bb586..156333ef26bf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -7,6 +7,8 @@
 					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
 #define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
+#define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -61,31 +63,41 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
 	struct enetc_msg_mac_exact_filter *msg = vf_msg;
 	struct device *dev = &pf->si->pdev->dev;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
 	char *addr = msg->mac[0].addr;
 
+	mutex_lock(&vf_state->lock);
+
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				   ENETC_MF_CLASS_CODE_INVALID_MAC));
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
+			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		goto vf_state_unlock;
 	}
 
-	mutex_lock(&vf_state->lock);
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
-		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		goto vf_state_unlock;
 	}
 
 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
+
+vf_state_unlock:
 	mutex_unlock(&vf_state->lock);
 
-	return ENETC_PF_MSG_SUCCESS;
+	return pf_msg;
 }
 
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..8957e74314d1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -540,6 +540,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 	.ndo_set_vf_vlan	= enetc_pf_set_vf_vlan,
 	.ndo_set_vf_spoofchk	= enetc_pf_set_vf_spoofchk,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..eb977da2be71 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -9,6 +9,7 @@
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
+	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 };
 
 struct enetc_vf_state {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..44c546b77d3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -462,5 +462,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
 
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (setting)
+		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..5bf7c20aba42 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,7 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


