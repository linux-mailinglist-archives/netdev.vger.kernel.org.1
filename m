Return-Path: <netdev+bounces-297576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMZDMmg2KWrASQMAu9opvQ
	(envelope-from <netdev+bounces-297576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9E668160
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Led1FykE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297576-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954F030AECBD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FA3E4516;
	Wed, 10 Jun 2026 09:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16E298CAF;
	Wed, 10 Jun 2026 09:46:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084820; cv=fail; b=YGY02NN//wAEORmTsztWUj8tUETckDmNg1v7CEQGu/OOgf1mneJ3XXY4CRtBnJzCuEoTqnnZruH65Arlb68t0610GgUYiNX0M5bEkrapgT3avL81iTc56h2kU1fre7IpC4QBfFGiW+rcBf1qp4gHn768etMSa1W9drKlnEq4Jnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084820; c=relaxed/simple;
	bh=OwieVfMf0TCK+XOSHxd5W8rTTvzwhWTKlQMVYkRcj5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVmJujVuMOAsDhElAICfdol7M4pwTOxEU4clYPyKQ34cPtHCY/2Vf9zz1xEHmLXaN0MN1xukqWcjXx9uCuDjLjxM08DOdZQy3vjOuuCg9555IqhsCNQxgkcXp2eQiD2hHhRuPZTTu3OIZGRU7q07D4Vg8iBmhAtb1w41VP+X7Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Led1FykE; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUq6nXYjWXiLo5DqAzU8Lurf7d1GVbna5rEcKJOZTL7Cnc9HLy6TcjWmdk4tikKPjvLzqoIovCg6CUfur187iBWiC3vovVFzSpZrMBN39nVZeCTh+8gCkYJzxllR2Gp+E4BtruYkaw/lXSI7CKveprShfTruLc7wH9S1abFG/tni/Zszf5qlmEQWyul9800+gOdPQw3XPNamnfhZx+93BS0pyGEwMrIZjzt5XScMAES9cHFp9omZ3VJPMP0h9GGmwdwvkQnHJbVyf3gG4fk1phvistldtaIVXKtmB7MfN4sCOUqITZiVT9sEYSQ45lJYAA4ehlI7GrAHRZpRAeCYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/Q4PKyx1e2aGCtEAKP6kxyEa0fv72aV42+VzeC8x+Q=;
 b=WUnQgYNbaNCRFhKI9id77ZPv9mTr6TJT9qo+Qftkz+S33V0xlhY032I4OSDGZogBgHbgUviTdAXEfA+8vyuIpyLaiO9vgpRQd7Cbj34G599ewpuF7oaUPCRENbmWgDKwwSZWULX0CAs1UAIJ6TqipymufeVf7rKHYj3l4cbb12PtX59QGSAJtvlBYr43ZDV57CNuoq/noEsANrPfkXO5uRFI1U8az3dolQVdnGYY05/vWM5pFmUZa9sCGOXALQopPa8+IZeiPMU6hK+g+1gOCKLDYeZXar4CyMgkrFFsMmIcoY+X4Fa+bB0Gjn/l4oUkV01DDm8Rc7RolvP4jFJ/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Q4PKyx1e2aGCtEAKP6kxyEa0fv72aV42+VzeC8x+Q=;
 b=Led1FykE5LTBK83qlTwLki5m25qEbDJb4YNqWhjRIbZza5T8AFEFqTnVpdvngsNYW15s8oR5/MRD+Vt0MggpnR9RDa43/NUlWbTTbQkNghxz49u6JoTRjpdnx62inXB7lRg72Sij0B3h5BvSfcOhtE2g37NKBtQXFw8UA/8MS1yZCmjlBDphKCg0PR1nO1UGRMU2NVov3r+tFgHqVO0FEEheEnUEV/qNOoUa1eUqOVYFVlTNN6IXUjZjFykJxBsBqdoR+YRmtW3kUwUVRj8YP+e3cN+2XGfHQ9ppAg7r2/ZHbDeJbeI9b994Z6L79sslyOYIzx/lsAkpCrYmEd7oYQ==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:53 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:53 +0000
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
Subject: [PATCH v2 net-next 09/15] net: enetc: add MAC address filtering support for VFs of ENETC v4
Date: Wed, 10 Jun 2026 17:18:38 +0800
Message-Id: <20260610091844.3423693-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1ef3f1-e5f0-4d19-6ad7-08dec6d533f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|3023799007|18092099006|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	KjZJDy2gnGWD5lxSSxTgrjKRRTKtHzHKUztWvIJn+t0jq1cX47f5JdXSFA/sVu/yQDzaz7b9YpUPmAoYWJgQH3nvE0DhfFGO4RLekS7MteP9kl+4H0TZ+7fJIu9ll5gRWFPaObO/et4IJdgGKdKVxkrG/CMUc8HDgrSoLl4e2iKtGAvyITbKTZ7UI4a3OAHdTgUlexelEHWIEa9Yuup8qouxze5Iw6OnPToUQ/aA1T/d4lTj5L/xFuZ0jUeH1OLTdCWNIuepXDlhI56Bp3l2F1aObyju2XycQwluby/gh6doS5VO1OYyWGxM8Y7CW8Mx+C+skmt7qzhcxLRkzPlfLUFBPXqaH26zJ+R6bs3olZm+cyJCfwwFGRrmnGEU7GjQ01EKT4LTjfF6fQEPTirrKaGhgpuofeNYQ57ybhC/IMh7htQYVXItj7fscvCd9NjfATMZ9hkVqBMGSmX9vOzPpNSRFt7o7w5LypCuODYn2F412pfoPMcP53kcFz3Z4PbYNO5RXaCXFQwW+zWmUIFY2Cdcq94b4LY2tQShPNb5B/rQagJUBPUHKe50pVFYYCCLeX2F7NPQ/2QpcFsf5dsjKKqMn4rcib4Ge4TLIIu0ttMYfm6rCev4hJ+zR/3Gb5N2tVfI8Zjh3dlJXfsHiYccO4zbZSD7YlzV4uG/K8Q4mhwyxlW93uUZObgSQv1hmfZO+5HmtwmiZeIxzuvRlHki2oQyuVLl5UhFhlsLzbm5fuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(3023799007)(18092099006)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5u4r28W6OtPOOokJsfHq9BQJidLVX5HJ9MfhSuNQxkgGDbfZszbKm0nkXFC?=
 =?us-ascii?Q?MXpdzKdH6ZxqVFslLIaLyPp64itMvGIYP5RlDgkXZmxCy3q2PrkWsCLaOb5q?=
 =?us-ascii?Q?UgRmFZ3wetBRge6V+G8j0Ox9QFZu2LBrG5PsQ8jv2CWOtN/V0NSzZAfNdTK0?=
 =?us-ascii?Q?2/zTy48KCFJsofcoEBoTjzTasejqgxXaosqrNQ/ZTxIKra7s1cuNs97yBWt1?=
 =?us-ascii?Q?ZybKeqPAhFB90wFOkKamd0TUeOvPPV0nG6oqGLYv3D2Voiu94uhQCrGTg/ys?=
 =?us-ascii?Q?nuCyqdDxCw8G/VMQ3dOCRTRQnXrKnYrxFWcNs4HFyYXvByuXioEpCCXlTnFj?=
 =?us-ascii?Q?l2rQJxiZCqjNObm7Wrs5s1vIUpxEpXfmX+p8RYnJCvQOLoq5tt4BCeSjd4ZA?=
 =?us-ascii?Q?zSykja+LjaMm/O9eH2eieNOGWGFNXU9plf858mQPhmhYr1msHSCfCJuEOr4Y?=
 =?us-ascii?Q?VFbpeC+AwtjIZ5c+nDoY6f4MT8O1nh7/ywipspoxY8iwocq9ZcKReUrASwPZ?=
 =?us-ascii?Q?tVl/mtDstVKpGUfAxuNBfhORoj9/HjGNqX1HmQDqsNxLu/sC1gy5i8ydpWqH?=
 =?us-ascii?Q?wyGFx8uxS4RbVEHM/LKVCkK8AFz/3+VmDl20Y0KICHQ2565LEvGefIwL7C9q?=
 =?us-ascii?Q?3HReH0YsmCFM69XSeOFhSam+CdfKakw1kbjMyLJZtna3zPli+nFtnTfomdiB?=
 =?us-ascii?Q?LsMCrH3UE/r+VlAQfRRHHIfvVvqJ5fjHc2YBMMXwG3ycSVzjNnJ/hf4AMc8R?=
 =?us-ascii?Q?Hd2bOnlDpFwCLCAShOvOIu4c1QeIBRJIc6IlPZlxJ70NjSJmyQbfFrYvR2yb?=
 =?us-ascii?Q?GkJErUmPYnbHnULXA2guHEUiIOI5aBRkiGNnAAR60pi1/fp1NTfvfezcgz9t?=
 =?us-ascii?Q?IhBS6mSWLBEAwoaaxZ9dMDbS3KneOfCnqcFhWtnVfRCFeMYok21tizNfv0aD?=
 =?us-ascii?Q?3jvwQTRl4bXG9C5qsq6amnDbM6dEuLRNFi4B1vfyUa273alx+ZPtojWYFpVc?=
 =?us-ascii?Q?EZcBVZzMEWZswWxDKhGQJ8WRd/5aqJ75i3G/Ri50V7oEGb3k+G9zD7TNZk3F?=
 =?us-ascii?Q?jGC6vmZg3w5SiPLgvtwzL1yWWvUQ0M4i1DAFWeGzDBAIYcd+P2pRxtJ0vVxl?=
 =?us-ascii?Q?C/P+gnd6mxTbE9YKpxSSHW0Nja+32mg1+16J+NAAUFnzDBkuORQRQmDEsvGd?=
 =?us-ascii?Q?7PJ+Bx0mbcE0yJySniXGpNannMF0RCpWW0qEWsqb0k4j23D66GoT4XE+ea3Q?=
 =?us-ascii?Q?aPFTq2s0Dx8mYE/2zQLNfB2q0TV+tk3yXnnDlMWwcS5pwrKR98ehEG0CHLc9?=
 =?us-ascii?Q?WXuLKFQF9HYHf3rteKannS1A4YfhfWB0WQq+horKIaWthapxIt1BrN/rF80y?=
 =?us-ascii?Q?+VUVzb9cu3ZpWDwc2/OZsYnRn38RcupQ6d2PVTabandgwe7oEBLz22JjxBtv?=
 =?us-ascii?Q?Pwv05cJ9Sx2hNzJ0ZlEQc4LkzH+GFXsuPMDL87mEKzEx0iqMOVKhSvd2WLzL?=
 =?us-ascii?Q?QNqdHy83lkena2dpRqHmnelZqBffLoCFYqmyQdgDEapCi83bW7Bqsw+fI4qW?=
 =?us-ascii?Q?gN5G67a2KqxLXt69PPOggidgW1wiemUYR9dIjW5wYzs3Ur4R6kH8GCg8sncM?=
 =?us-ascii?Q?yYCr/eGWV1olaKgxmZPqiuKEORNFRwZoLEdET4iWYe+u4TcTfrHPAvbUwwNv?=
 =?us-ascii?Q?jKOHIKuNi6cOT9/vPnFe0NGO+kkpw9kX2cPT8tbma3lBnxqq6lFslnTD09nE?=
 =?us-ascii?Q?N/j8dGOc0k1ENCKBZpgTB2vblv/gNYJUMMJiOg2OmBaim+Dpce/V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1ef3f1-e5f0-4d19-6ad7-08dec6d533f2
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:53.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMXFk5q5k6EhEQYLVTTJE/X46bF1G2z/vLu+VQmO/J9M67IzniCr5i9qp71komZDzQ1TZJLUoTdGiE+ETUH9+1pjqGsaDGPdBzANpTG2j7Wdy6F9UoC8QXXCDKqvCMs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
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
	TAGGED_FROM(0.00)[bounces-297576-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B9E668160

From: Wei Fang <wei.fang@nxp.com>

The ENETC v4 VF hardware supports MAC address filtering, but the
underlying hardware resources (PSIPMMR register and per-SI hash filter
tables) are owned and managed exclusively by the PF driver. Add
VSI-to-PSI mailbox message support so that VFs can request MAC filter
configuration from the PF.

Two new command IDs are introduced under the existing MAC filter message
class (0x20):

1. ENETC_MSG_SET_MAC_HASH_TABLE (cmd_id 3): allows a trusted VF to
program its unicast and/or multicast MAC hash filter table. The PF
validates that the hardware-supported 64-bit table size is requested
before applying the configuration via the per-SI hash filter registers.

2. ENETC_MSG_SET_MAC_PROMISC_MODE (cmd_id 5): allows a VF to enable or
disable unicast/multicast promiscuous mode, and optionally flush the
associated hash filter table. Enabling promiscuous mode requires the VF
to be marked as trusted, since it widens the traffic received by the VF.
Flushing the hash table without enabling promiscuous mode does not
require elevated privilege.

To accommodate independent per-type control, refactor
enetc4_pf_set_si_mac_promisc() to accept an enetc_mac_addr_type enum
and a single enable flag instead of two separate boolean parameters.
This allows callers to set unicast and multicast promiscuous modes in
separate steps.

The PSIPMMR register holds promiscuous mode bits for all SIs and is
modified by both the PF rx_mode workqueue (enetc4_psi_do_set_rx_mode)
and the VF message handler workqueue (enetc_msg_task). Since both
workqueues can run concurrently on SMP systems and
enetc4_pf_set_si_mac_promisc() performs a non-atomic read-modify-write,
protect all accesses to this register with pf->msg_lock to prevent lost
updates.

When a VF loses trusted status via ndo_set_vf_trust(), its unicast hash
filter is cleared and promiscuous mode is disabled to prevent it from
receiving traffic beyond its allowed scope.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  49 ++++--
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  42 +++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 159 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   4 +
 .../freescale/enetc/enetc_pf_common.c         |  19 ++-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +-
 6 files changed, 253 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 77043fa01782..39257d364d4e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -12,11 +12,6 @@
 
 #define ENETC_SI_MAX_RING_NUM	8
 
-#define ENETC_MAC_FILTER_TYPE_UC	BIT(0)
-#define ENETC_MAC_FILTER_TYPE_MC	BIT(1)
-#define ENETC_MAC_FILTER_TYPE_ALL	(ENETC_MAC_FILTER_TYPE_UC | \
-					 ENETC_MAC_FILTER_TYPE_MC)
-
 static void enetc4_get_port_caps(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
@@ -76,19 +71,22 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 }
 
 static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
+					 enum enetc_mac_addr_type type,
+					 bool en)
 {
 	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
 
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
+	if (type == UC) {
+		if (en)
+			val |= PSIPMMR_SI_MAC_UP(si);
+		else
+			val &= ~PSIPMMR_SI_MAC_UP(si);
+	} else if (type == MC) {
+		if (en)
+			val |= PSIPMMR_SI_MAC_MP(si);
+		else
+			val &= ~PSIPMMR_SI_MAC_MP(si);
+	}
 
 	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
 }
@@ -107,6 +105,16 @@ static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
 	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
 }
 
+static void enetc4_pf_set_si_mac_hash_filter(struct enetc_hw *hw, int si,
+					     enum enetc_mac_addr_type type,
+					     u64 hash)
+{
+	if (type == UC)
+		enetc4_pf_set_si_uc_hash_filter(hw, si, hash);
+	else if (type == MC)
+		enetc4_pf_set_si_mc_hash_filter(hw, si, hash);
+}
+
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -273,6 +281,8 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+	.set_si_mac_promisc = enetc4_pf_set_si_mac_promisc,
+	.set_si_mac_hash_filter = enetc4_pf_set_si_mac_hash_filter,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
@@ -517,7 +527,14 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	if (pf->total_vfs)
+		mutex_lock(&pf->msg_lock);
+
+	enetc4_pf_set_si_mac_promisc(hw, 0, UC, uc_promisc);
+	enetc4_pf_set_si_mac_promisc(hw, 0, MC, mc_promisc);
+
+	if (pf->total_vfs)
+		mutex_unlock(&pf->msg_lock);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 46446330e222..69657ea2b1c3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -91,6 +91,17 @@
 #define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
 
+#define ENETC_MAC_HASH_TABLE_SIZE_64		0
+#define ENETC_MSG_MAC_HASH_SIZE			GENMASK(5, 0)
+#define ENETC_MSG_MAC_TYPE			GENMASK(7, 6)
+#define  ENETC_MAC_FILTER_TYPE_UC		BIT(0)
+#define  ENETC_MAC_FILTER_TYPE_MC		BIT(1)
+#define  ENETC_MAC_FILTER_TYPE_ALL		(ENETC_MAC_FILTER_TYPE_UC | \
+						 ENETC_MAC_FILTER_TYPE_MC)
+
+#define ENETC_MSG_MAC_FLUSH_MACS		BIT(0)
+#define ENETC_MSG_MAC_PROMISC_MODE		BIT(1)
+
 enum enetc_msg_class_id {
 	/* Class ID for PSI-to-VSI messages */
 	ENETC_MSG_CLASS_ID_CMD_SUCCESS		= 1,
@@ -114,6 +125,8 @@ enum enetc_msg_class_id {
 
 enum enetc_msg_mac_filter_cmd_id {
 	ENETC_MSG_SET_PRIMARY_MAC,
+	ENETC_MSG_SET_MAC_HASH_TABLE		= 3,
+	ENETC_MSG_SET_MAC_PROMISC_MODE		= 5,
 };
 
 enum enetc_msg_ip_revision_cmd_id {
@@ -136,6 +149,9 @@ enum enetc_msg_link_speed_cmd_id {
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
+	ENETC_MF_CLASS_CODE_INVALID_TYPE	= 4,
+	/* Unicast Filter Is Denied */
+	ENETC_MF_CLASS_CODE_UCF_DENY		= 5,
 };
 
 /* Class-specific notifications/codes of link status */
@@ -196,6 +212,32 @@ struct enetc_msg_mac_exact_filter {
 	struct enetc_mac_addr mac[];
 };
 
+/* message format of class_id 0x20 for hash MAC filter.
+ * cmd_id 0x3: set MAC hash table
+ */
+struct enetc_msg_mac_hash_filter {
+	struct enetc_msg_header hdr;
+	/* bit 0 ~ 5: ENETC_MSG_MAC_HASH_SIZE
+	 * bit 6~7: ENETC_MSG_MAC_TYPE
+	 */
+	u8 sz_type;
+	u8 resv[3];
+	u32 hash_tbl[];
+};
+
+/* message format of class_id 0x20 for MAC promiscuous mode.
+ * cmd_id 0x5: set MAC promiscuous mode
+ */
+struct enetc_msg_mac_promisc_mode {
+	struct enetc_msg_header hdr;
+	/* bit 0: ENETC_MSG_MAC_FLUSH_MACS
+	 * bit 1: ENETC_MSG_MAC_PROMISC_MODE
+	 * bit 6~7: ENETC_MSG_MAC_TYPE
+	 */
+	u8 config;
+	u8 resv[15];
+};
+
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index b24903b23a61..abf0f4d9aeac 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -12,6 +12,11 @@
 #define ENETC_PF_MSG_SPEED(s)	(FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					    ENETC_MSG_CLASS_ID_LINK_SPEED) | \
 				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (s)))
+#define ENETC_PF_MSG_INV_LEN	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_INVALID_MSG_LEN)
+#define ENETC_PF_MSG_MF(code)	(FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					    ENETC_MSG_CLASS_ID_MAC_FILTER) | \
+				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (code)))
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -82,10 +87,7 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_MAC);
 		goto vf_state_unlock;
 	}
 
@@ -111,6 +113,139 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	return pf_msg;
 }
 
+static u16 enetc_msg_set_vf_mac_hash_filter(struct enetc_pf *pf, int vf_id,
+					    void *vf_msg)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_mac_hash_filter *msg = vf_msg;
+	struct enetc_hw *hw = &pf->si->hw;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
+	int si_id = vf_id + 1;
+	u64 uc_hash, mc_hash;
+	bool trusted;
+	int type;
+
+	if (!pf->ops->set_si_mac_hash_filter)
+		return ENETC_PF_MSG_NOTSUPP;
+
+	/* Currently, hardware only supports 64 bits table size */
+	if (FIELD_GET(ENETC_MSG_MAC_HASH_SIZE, msg->sz_type) !=
+	    ENETC_MAC_HASH_TABLE_SIZE_64)
+		return ENETC_PF_MSG_NOTSUPP;
+
+	mutex_lock(&vf_state->lock);
+
+	/* For an untrusted VF, unicast MAC hash filtering is not permitted.
+	 * For multicast, the MAC hash filter is strictly limited to a maximum
+	 * of 8 bits to satisfy its basic multicast communication requirements
+	 * while preventing potential network abuse.
+	 */
+	trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->sz_type);
+	switch (type) {
+	case ENETC_MAC_FILTER_TYPE_UC:
+		if (!trusted) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+		pf->ops->set_si_mac_hash_filter(hw, si_id, UC, uc_hash);
+		break;
+	case ENETC_MAC_FILTER_TYPE_MC:
+		mc_hash = (u64)msg->hash_tbl[3] << 32 | msg->hash_tbl[2];
+		if (!trusted && hweight64(mc_hash) > 8) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		pf->ops->set_si_mac_hash_filter(hw, si_id, MC, mc_hash);
+		break;
+	case ENETC_MAC_FILTER_TYPE_ALL:
+		if (!msg->hdr.len) {
+			pf_msg = ENETC_PF_MSG_INV_LEN;
+			goto vf_state_unlock;
+		}
+
+		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+		mc_hash = (u64)msg->hash_tbl[3] << 32 | msg->hash_tbl[2];
+
+		if (!trusted && (hweight64(mc_hash) <= 8)) {
+			pf->ops->set_si_mac_hash_filter(hw, si_id, MC, mc_hash);
+			pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
+			goto vf_state_unlock;
+		}
+
+		if (!trusted) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		pf->ops->set_si_mac_hash_filter(hw, si_id, UC, uc_hash);
+		pf->ops->set_si_mac_hash_filter(hw, si_id, MC, mc_hash);
+		break;
+	default:
+		pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_TYPE);
+	}
+
+vf_state_unlock:
+	mutex_unlock(&vf_state->lock);
+
+	return pf_msg;
+}
+
+static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
+					     void *vf_msg)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_mac_promisc_mode *msg = vf_msg;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
+	struct enetc_hw *hw = &pf->si->hw;
+	bool promisc, flush_macs;
+	int si_id = vf_id + 1;
+	int type;
+
+	if (!pf->ops->set_si_mac_promisc)
+		return ENETC_PF_MSG_NOTSUPP;
+
+	flush_macs = !!(msg->config & ENETC_MSG_MAC_FLUSH_MACS);
+	if (flush_macs && !pf->ops->set_si_mac_hash_filter)
+		return ENETC_PF_MSG_NOTSUPP;
+
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->config);
+	if (!type)
+		return ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_TYPE);
+
+	mutex_lock(&vf_state->lock);
+
+	promisc = !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
+	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
+	mutex_lock(&pf->msg_lock);
+
+	if (type & ENETC_MAC_FILTER_TYPE_UC)
+		pf->ops->set_si_mac_promisc(hw, si_id, UC, promisc);
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC)
+		pf->ops->set_si_mac_promisc(hw, si_id, MC, promisc);
+
+	mutex_unlock(&pf->msg_lock);
+
+	if ((type & ENETC_MAC_FILTER_TYPE_UC) && flush_macs)
+		pf->ops->set_si_mac_hash_filter(hw, si_id, UC, 0);
+
+	if ((type & ENETC_MAC_FILTER_TYPE_MC) && flush_macs)
+		pf->ops->set_si_mac_hash_filter(hw, si_id, MC, 0);
+
+vf_state_unlock:
+	mutex_unlock(&vf_state->lock);
+
+	return pf_msg;
+}
+
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
 				       void *vf_msg)
 {
@@ -119,6 +254,10 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
 	switch (msg_hdr->cmd_id) {
 	case ENETC_MSG_SET_PRIMARY_MAC:
 		return enetc_msg_set_vf_primary_mac_addr(pf, vf_id, vf_msg);
+	case ENETC_MSG_SET_MAC_HASH_TABLE:
+		return enetc_msg_set_vf_mac_hash_filter(pf, vf_id, vf_msg);
+	case ENETC_MSG_SET_MAC_PROMISC_MODE:
+		return enetc_msg_set_vf_mac_promisc_mode(pf, vf_id, vf_msg);
 	default:
 		return ENETC_PF_MSG_NOTSUPP;
 	}
@@ -371,8 +510,7 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	if (msg_size > ENETC_DEFAULT_MSG_SIZE) {
 		dev_err_ratelimited(dev,
 				    "Invalid message size: %u\n", msg_size);
-		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				     ENETC_MSG_CLASS_ID_INVALID_MSG_LEN);
+		*pf_msg = ENETC_PF_MSG_INV_LEN;
 		return;
 	}
 
@@ -390,6 +528,14 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	}
 
 	memcpy(msg, msg_swbd->vaddr, msg_size);
+	msg_hdr = (struct enetc_msg_header *)msg;
+
+	/* Check message length whether is changed */
+	if (ENETC_MSG_SIZE(msg_hdr->len) != msg_size) {
+		*pf_msg = ENETC_PF_MSG_INV_LEN;
+		goto free_msg;
+	}
+
 	if (!enetc_msg_check_crc16(msg, msg_size)) {
 		dev_err_ratelimited(dev, "VSI to PSI Message CRC16 error\n");
 		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
@@ -400,7 +546,6 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 	/* Default to not supported */
 	*pf_msg = ENETC_PF_MSG_NOTSUPP;
-	msg_hdr = (struct enetc_msg_header *)msg;
 
 	/* Currently, asynchronous actions are not supported */
 	if (FIELD_GET(ENETC_VF_MSG_COOKIE, msg_hdr->cookie)) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 22b98e89e393..57591bd5afab 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -34,6 +34,10 @@ struct enetc_pf_ops {
 	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
 	void (*destroy_pcs)(struct phylink_pcs *pcs);
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+	void (*set_si_mac_promisc)(struct enetc_hw *hw, int si,
+				   enum enetc_mac_addr_type type, bool en);
+	void (*set_si_mac_hash_filter)(struct enetc_hw *hw, int si,
+				       enum enetc_mac_addr_type type, u64 hash);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 85e1efa6a8ce..f0ae69dcc59a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -468,6 +468,7 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_vf_state *vf_state;
 
 	if (vf >= pf->total_vfs)
@@ -476,11 +477,25 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	vf_state = &pf->vf_state[vf];
 	mutex_lock(&vf_state->lock);
 
-	if (setting)
+	if (setting) {
 		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
-	else
+	} else {
 		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
 
+		/* Clear unicast hash filter and disable MAC promiscuous modes
+		 * if the VF is untrusted.
+		 */
+		if (pf->ops->set_si_mac_hash_filter)
+			pf->ops->set_si_mac_hash_filter(hw, vf + 1, UC, 0);
+
+		mutex_lock(&pf->msg_lock);
+		if (pf->ops->set_si_mac_promisc) {
+			pf->ops->set_si_mac_promisc(hw, vf + 1, UC, false);
+			pf->ops->set_si_mac_promisc(hw, vf + 1, MC, false);
+		}
+		mutex_unlock(&pf->msg_lock);
+	}
+
 	mutex_unlock(&vf_state->lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..e4d0e6c1a2e5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -107,8 +107,12 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
 			err = -ETIME;
 			break;
-		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
 		case ENETC_MSG_CLASS_ID_MAC_FILTER:
+			if (FIELD_GET(ENETC_PF_MSG_CLASS_CODE, pf_msg) ==
+			    ENETC_MF_CLASS_CODE_UCF_DENY)
+				return -EACCES;
+			fallthrough;
+		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
 			err = -EINVAL;
 			break;
 		case ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED:
-- 
2.34.1


