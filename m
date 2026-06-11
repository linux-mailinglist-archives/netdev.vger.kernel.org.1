Return-Path: <netdev+bounces-297890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pHGxGRoaKmo6iwMAu9opvQ
	(envelope-from <netdev+bounces-297890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:14:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83D66DC7A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=uu9JAwb3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297890-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297890-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C12302BBEE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39142ED870;
	Thu, 11 Jun 2026 02:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0C2D1F40;
	Thu, 11 Jun 2026 02:12:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143981; cv=fail; b=mf8YQqzLNJjn+dy8qklAoI2jWtk5+lfiGZ1QcYFHcsdtqvUW3sOnQytZgzu3xLuWLZcnkw7J7hnrDCNq6zcTnvfoqnAG4pi8/31ePYs/sRjEH4mLy8I6sf3WrMgmQcFp3dzimqpXIRhAD+Z9b+m6cLjQ0ArFIE5LI5ySNB5WcD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143981; c=relaxed/simple;
	bh=2tEFFiSHRco1qdLetcWApAKK7qIMc8JCz0gb/fvofhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/MwCP2Z/4O2y8W7uEdTuVL9if8/6bpcxBbseQxHfdkAJ/HWX6umavSm/VF5Nc78p9c0RPeNPe/AwbSFbBYoJA0fyg5oCpS62Cp3j55gzcykOG42oz3hL1EKlHhG6utI5UQmRgOymCn9ss8n4XPvsnk32yeiCUo8JrCx9BXiXSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uu9JAwb3; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii3o59EsbSbKsaG7zHUuervHYk39Gbot+9rTD46hZFmWeo2+P2P8VnwNs/WgLm3MGle8UqextrPdhgiCApm/aaSf9w8ZUH1Tm9GT+Ui1M6xkczaD9O9pVjwjXLAj3i1wRwCBKHOOKsrGGTDFZVqEf+/yUkCIUmYbKSlEiUCEuY9P+jE43ev6EOEambMUCzKH1tRul0RiNekjsUn3pqf17DWmWCrq01Ptn++xrOTkBZnVjYAv6TpW//d6whVbEyrlx13f0DL/Nr1SsWp5FWM92AHpNtpr/sM1pyfoozTWimie3xLL+FYtqfTbsFxp6uyR2liA2w/wO7T84gh253ozqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgkD2SbshpG1JGnnzKqXijCgSYGWgQB1oAgsdVs/pO8=;
 b=c4DOFr5amkz8X4yN+sPhKOhQsqi8r7K5XTQLWMplCXDHP26vHO8+wsYWGFic9tXVDNQ7l+IVXsoYBSUPRGy7wyWRJ8P3SO4QUxGVCYwxIKFpgYP+Ns2b3RMfpVgGROtuYQ4IKopFX33c/Lra5J1V0dEKbJ8oYbZbfY7rz+7Fv+CwMGecjgNAS4UhcIAkKRCqzhs2fzKpvx2RYrYzYSxJpGkha8FtHxr1iJWOXyf+lanc2CF+QXieYiyFYS2z28JXVSk6rUcQlt62u5SaCl7Q4hHiJDg/dWoI+CKMVA/AWuY6yJ9CqGHEEhLge0am7ZnYqRsC0rMUw9THRwM7IW+2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgkD2SbshpG1JGnnzKqXijCgSYGWgQB1oAgsdVs/pO8=;
 b=uu9JAwb34LpK5Gfor+Yfbhe9uqsZtJVhXe7buH2qxpMbbCGldUzaHTUji1HR96F6Y+h/LUAd2qFw3xJjPbXIJwCA9ZklwR0BoluItCkjer+ORMA3izvLmrVVTnD6jJfC73A9CNXnNPRWBNwT3tCo0uN2+kF/8xHKFtoWjeiT0vwnCH1J+2yKLv3S4xEjgpORQvXdoMNmHai5u1ndYH1n0/DyssVQ+m5kzJySq8shNAFtGoUvP55a8a49N7sdCGxlp6OW7VMcWeICwx7dKn1Q5hian2vHx40rk4F0l58k1adlUh1MVEWhIA0HhzyfJYi2QgeogtTZe1DUTM2IprBZCg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:53 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 9/9] net: dsa: netc: implement dynamic FDB entry ageing
Date: Thu, 11 Jun 2026 10:14:58 +0800
Message-Id: <20260611021458.2629145-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA4PR04MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: a81b3486-af23-4485-e1cc-08dec75ef1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|376014|1800799024|56012099006|921020|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2LtBbwBzfc4/6HyvADRV3JYxTazJQK0DMw1X60/i6kNqiOIKBYNC8A6tLEnaUGFkQhPfxfwrWbzSDmm5nkDe423qZivMJXAB8jStxI80p+C2FY+CIVz3iVDfd/bEso9HJSD+Uq+CatyA9QzzG4Y8G6PzhpRISWrVo4CsPdaw20PV5i4SutT2KHWK/+DQ2P5CY76uJQCA8MNsx3XBI3gQq0vSd1Ls3ORwlGqdYHkmSkx37oj7H6hKmc09oTDx8zIRRz75VK1awEAvfwhmpJfNzXjyApv03zefRQeUvm8FHfhz1qQLC36uRRtSW/QCMLPYkeZ6oEZ239+68YwphlW++AllCVo2XOnWWqrMOC+qokuEeat8eZJqPRNw+r4GYISrkXYfl9hLEcYTVI8c/TZ0detv11GR9aL5YNx5co5LMOUNYAqdcGJoYreo2P3JYpWf1A91+qziNajQ+gvJvZzhXgGh7SMRqp9vKAq32Y/52AMULY7YTEsAr1k/sLxaUTHf37xYBxjp2cYTNh8M1Ar9NKfXYzi8tQa9p7rR682cTIUsz2Wyl5sDO/xLSdF3TY99VPxKngiqB+TM2PJKbsv1Gc/M8w5lqJppL7K2d20iz+A1cu4SkOaa5sM7U637nP5WvCDU5sHP6aicM8nwPkAlns6Hpn6OIzCtLNjdHQi/iyXDvTjz67WsDRjJedhFNu7F7zx7hv61vfxtXRJp34RdIUN2EX/89G3aBIwb5a38F1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(921020)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0YPHhcm2zhHEVXOtf7EYUPqTMXug6+VpWQw6ywVLQlD0jcwgHkZTu8hJTZp?=
 =?us-ascii?Q?TtHIxGDBbNQ8qClu/YuwPeHRVeKOD/lkcYjh1iAGYBiw9S+IlAT3q4Dip1OZ?=
 =?us-ascii?Q?ajNkCgdl8iENnOKZe2bcMblLGQynj8IN5ZtMmDzv1awc9TxRtjkk8Js3JFp7?=
 =?us-ascii?Q?LQKz6Y1JRWJtiVwIH3vx2oCgWHXMp/a5OcpSAMhVX0yUTBk3zYR7ptPnTqIL?=
 =?us-ascii?Q?yBg5HjbixQD8oEtdkKUcJXhjN0y2/s3P3uu2gPXnwWdoqOKe9fDmgBMW8QJ+?=
 =?us-ascii?Q?l6yAPgRbbSWediW3VU7BEe4M/nebNUCtHpTo1hQAeQwbBUsBDmsHXyKyGfwN?=
 =?us-ascii?Q?mM2BiDisH1XD4DotEvGORwl+qRpDm9GGp9A3A+kYotwnne9ZIzdA26jAokh3?=
 =?us-ascii?Q?3RKS3mXv4OtlSS2gEYn4uMNdne9HjQvYRMKI6euHn30Go1R4nAJ5s4RtmeKp?=
 =?us-ascii?Q?b8MTDXQ23vugubyoSgORBzaYt7RIdm6jUuiF8ucAbR4ZDMQ8vFei+kioBvYC?=
 =?us-ascii?Q?ajn7d7e6KZvRU1aBT9tJFJPxM2390SxqUb3/0x5TNxNjZepl/6oup9+QQ3F1?=
 =?us-ascii?Q?VBFpLZLEfCbxmd+tMWIf+Fs2xApJzHeABE7JDGvzWI+lsSfbym/bIWS+nhEA?=
 =?us-ascii?Q?UR8JwGBxg0tVBWSLhBtUgBnAqXg/l4o8IbLZ+gcX61KZ5O4S6ifOU/WHYo5G?=
 =?us-ascii?Q?LBZMPngnK38fiZdAHcvZAsuCBtEGG30AkZEZt158OoFlBQPusByHDAe8EY1E?=
 =?us-ascii?Q?1tJD/mEhD/x0rryQDTjsfkKEWtoraPBQb4z3S1qDnwRuHOzvEqZWy/66hkG7?=
 =?us-ascii?Q?84wWuwGLMAicu7oaxI/qT8iNvC+KNPeBQWCcKTCorLc8yjaTBiSEWAKb6G5n?=
 =?us-ascii?Q?2dkAxnV/NiLIY5qUcABuEGYtulR+PmkfOEMJ6uxtRdgnwo9ZreI+VE88LDVD?=
 =?us-ascii?Q?c4iK9QIG0kRWSP6By5ngqnbaa3eTmAS4YYVBrcCzTItB4AqTvkJ3m6jlUMXw?=
 =?us-ascii?Q?cMPD6eoK0nU2o8+LFczUf0yO/Z4ZATGLyAAP4ZTeJIyZDh7rF+oBdUOmaI89?=
 =?us-ascii?Q?k9EimlUA4LWQT9jtjpz21qObwOyH+eZyIKtYS117zTvRaxaJKSShO1ByOEiO?=
 =?us-ascii?Q?WeGuUYrOJdwFXYbL1QsTAmhlOKAiKTe50ktlvkiqu4AD0Q4aZmTaHh+J6VL1?=
 =?us-ascii?Q?Gw/tqlAQRXZL5ND6n42SCUzPxqsoPQHfAVVPcJtBmtT0G/gkOA1HjFZEwWg8?=
 =?us-ascii?Q?LdhU+0bDniQkOVrso7WcCc6wuAvsfZFmfS9jMjeDf7A1aQYNLkI0Vny50NHT?=
 =?us-ascii?Q?ZnGDS/6ON8RV+e+d8KDXLuFqnEf6ukVSJS8B8GSfFsUCo8/Kac/uO8Aw/+x5?=
 =?us-ascii?Q?+2FGN/qSv6+/6Ji3uu/2QcooppEhjEjFoqbPLgKF61N9rK09vSVjEey/tjB7?=
 =?us-ascii?Q?1VrSq5H2zbYjw71VXsGoqjvvfDJExaCcLIRFmO5hCSPiekLCZiWnvXuDK8W2?=
 =?us-ascii?Q?xFjMuhWcVl6qYhJm53LDlSCDpmwIZPt/h0tsD5inhgUwnb94BOxkXyDKam+1?=
 =?us-ascii?Q?hbhg/TTdCqUraychpU1PaFs2u4tlym2iz1nA9SpmkMmjeTme3ZdlqIVsvT3Y?=
 =?us-ascii?Q?5rschW0Dd8ARCrx5Par9iU46QJk1OnqvSkghYldyu0BokvSBTYZrpLNnL5cT?=
 =?us-ascii?Q?ER8R9OiizrsTOrMS/Q/WMA3g84ZX7/h67hMnkt/jYGZOcp6UGW3kkTDLxzOB?=
 =?us-ascii?Q?raYF1kCKCydeAtYcyBHSRhjkxCt2TPxUsE3blX05CWPxF/d2wMTL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81b3486-af23-4485-e1cc-08dec75ef1b4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:53.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4Atwux/mB11HVuHUQtS1SUMP1M76gQ2dcHD+43TJI5QFEXV6wlT84FYAHgW4oHBnQc72qhuq+aZlI8NkAhWYgslcp+jj+jdj74lbP8k3f2rtSQhwXc+VNsy2aLRSDyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297890-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,oss.nxp.com:server fail,NXP1.onmicrosoft.com:server fail,tor.lore.kernel.org:server fail,nxp.com:server fail];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB83D66DC7A

From: Wei Fang <wei.fang@nxp.com>

The NETC switch does not age out dynamic FDB entries automatically.
Without software management, stale entries persist after topology
changes and cause incorrect forwarding.

Add a delayed work that periodically removes entries that have not been
refreshed within the specified cycles. The effective ageing time is:

  ageing_time = fdbt_ageing_delay * 100

Default values are 3s interval and 100 cycles (300s total), matching
the IEEE 802.1Q default ageing time. The work starts when the first
port joins a bridge (tracked via br_cnt) and is cancelled when the
last port leaves. All FDB operations are serialized under fdbt_lock.

Implement .set_ageing_time() to allow the bridge layer to reconfigure
ageing parameters on demand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 67 ++++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  7 ++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index b375dba9fff0..77077352c1a5 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -447,6 +447,25 @@ static void netc_free_ntmp_user(struct netc_switch *priv)
 	netc_free_ntmp_bitmaps(priv);
 }
 
+static void netc_clean_fdbt_ageing_entries(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct netc_switch *priv;
+
+	priv = container_of(dwork, struct netc_switch, fdbt_ageing_work);
+
+	/* Update the activity element in FDB table */
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_update_activity_element(&priv->ntmp);
+	/* Delete the ageing entries after the activity element is updated */
+	ntmp_fdbt_delete_ageing_entries(&priv->ntmp, NETC_FDBT_AGEING_THRESH);
+	mutex_unlock(&priv->fdbt_lock);
+
+	if (atomic_read(&priv->br_cnt))
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+}
+
 static void netc_switch_dos_default_config(struct netc_switch *priv)
 {
 	struct netc_switch_regs *regs = &priv->regs;
@@ -872,6 +891,10 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	priv->fdbt_ageing_delay = NETC_FDBT_AGEING_DELAY;
+	atomic_set(&priv->br_cnt, 0);
+	INIT_DELAYED_WORK(&priv->fdbt_ageing_work,
+			  netc_clean_fdbt_ageing_entries);
 	INIT_HLIST_HEAD(&priv->vlan_list);
 	mutex_init(&priv->vft_lock);
 
@@ -936,6 +959,7 @@ static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
@@ -1970,6 +1994,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	int err;
 
@@ -1997,6 +2022,10 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 out:
 	netc_port_remove_host_flood(np, np->host_flood);
 
+	if (atomic_inc_return(&priv->br_cnt) == 1)
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+
 	return 0;
 
 disable_mlo:
@@ -2023,6 +2052,7 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct net_device *ndev = np->dp->user;
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	bool mc, uc;
 
@@ -2030,6 +2060,9 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
 	np->pvid = NETC_STANDALONE_PVID;
 
+	if (atomic_dec_and_test(&priv->br_cnt))
+		cancel_delayed_work_sync(&priv->fdbt_ageing_work);
+
 	netc_port_remove_dynamic_entries(np);
 	uc = ndev->flags & IFF_PROMISC;
 	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
@@ -2066,6 +2099,37 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
+static int netc_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct netc_switch *priv = ds->priv;
+	unsigned long delay_jiffies;
+
+	/* The dynamic FDB entry is deleted when its activity counter reaches
+	 * NETC_FDBT_AGEING_THRESH (100). Each delayed_work tick increments
+	 * the counter by 1 if the entry is inactive.
+	 *
+	 * Therefore:
+	 *   msecs (ms)    = NETC_FDBT_AGEING_THRESH * delay_ms (ms)
+	 *   delay_ms      = msecs / NETC_FDBT_AGEING_THRESH
+	 *   delay_jiffies = (delay_ms / 1000) * HZ
+	 *                 = (msecs * HZ) / (1000 * NETC_FDBT_AGEING_THRESH)
+	 *
+	 * Use DIV_ROUND_CLOSEST_ULL to perform a single nearest-jiffy
+	 * rounding, avoiding the two-step rounding error of the intermediate
+	 * delay_ms approach.
+	 *   Maximum error = +/-0.5 jiffy * 100 = +/-50000/HZ ms.
+	 */
+	delay_jiffies = DIV_ROUND_CLOSEST_ULL((u64)msecs * HZ,
+					      1000 * NETC_FDBT_AGEING_THRESH);
+	WRITE_ONCE(priv->fdbt_ageing_delay, delay_jiffies);
+
+	if (atomic_read(&priv->br_cnt))
+		mod_delayed_work(system_percpu_wq, &priv->fdbt_ageing_work,
+				 READ_ONCE(priv->fdbt_ageing_delay));
+
+	return 0;
+}
+
 static void netc_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
@@ -2357,6 +2421,7 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_vlan_del			= netc_port_vlan_del,
 	.port_bridge_join		= netc_port_bridge_join,
 	.port_bridge_leave		= netc_port_bridge_leave,
+	.set_ageing_time		= netc_set_ageing_time,
 	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
@@ -2406,6 +2471,8 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = priv->info->num_ports - 1;
+	ds->ageing_time_min = 1000;
+	ds->ageing_time_max = U32_MAX;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 982c8d3a3fbf..305f2a92e2f9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -50,6 +50,9 @@
 /* PAUSE refresh threshold: send refresh when timer reaches this value */
 #define NETC_PAUSE_THRESH		0x7FFF
 
+#define NETC_FDBT_AGEING_DELAY		(3 * HZ)
+#define NETC_FDBT_AGEING_THRESH		100
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -124,6 +127,10 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct delayed_work fdbt_ageing_work;
+	/* (fdbt_ageing_delay * NETC_FDBT_AGEING_THRESH) is ageing time */
+	unsigned long fdbt_ageing_delay;
+	atomic_t br_cnt;
 	struct hlist_head vlan_list;
 	struct mutex vft_lock; /* VLAN filter table lock */
 
-- 
2.34.1


