Return-Path: <netdev+bounces-295682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x8PHJPN5ImpkYAEAu9opvQ
	(envelope-from <netdev+bounces-295682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:25:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B402645F20
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="SzewL/Jd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295682-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295682-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADC203015C35
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0B477981;
	Fri,  5 Jun 2026 07:23:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23705477982;
	Fri,  5 Jun 2026 07:22:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644181; cv=fail; b=SPUtVXDVloM7qSaVHgqAzA75FzdktY4POME5Y3mm8PJ2uLLArYyh3SspjUIvGKokxsj0MqPkoPaWBJaoOtwy0/+tdOrTBxMbLv+T/Ex9hkp+3PHz4hpu0c576XwmbY0Y9W0OKn1Y0TI+NC/TxCIg8Umk5DXTobyi5dD6BmaM1wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644181; c=relaxed/simple;
	bh=F/Q3/VnF80p8yo65apXsKiH3n0V9mMz9yqnFU8o7bQg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ntz9f2aVUARjizEShzb0mTTwITRzCRv0fH2altPqCUbeziFiwRHv9eBjOQ+Qo37YTaOhvlJ8eQNGSita2GaBoaYl0wywcQ6zlGCQofSZ6dP0z4a7gTeWKk35Ucjk6i6fDD4+1ey9Xub3s2LBMCpPH5ezPOZUTl7yePlbEbVHTHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SzewL/Jd; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVDcZx+Jsh3T2JHsjkQf4WNEMbQhUYGCMeR3LgiQjx8MeukHr/T6pqLXTvFoVZNDVO/RZ0nBRb8ZfNFzZ+aVsJRoZg1zOeIGyX3Ps4R0pLBO87hfZZTsP80+KIkzuPyZHiJqFy2sWBXNy7oYGG5wxVynLMTn2/LHUAE8XuS9nAmvci/+striaASoCaq5dLnR4rRkuGBCq/Jgeji52yDTNUnTMggKX9b6zlr0+TFZ3uj7nN4AbcHNzufmJ58g1TDM6Q0dWRTjS1AF7DddJn+B0tTI4mNhN73AQtDjSSykMu9LvTBfvCwGSjo7YLc96Ruwep3JIKMbOrXoYl0cdnNx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR/gbiC5/r/WYrcT7mCaMMk6E8099fDtDY1mwNC4wcs=;
 b=KBAfT+lYWWPj5x4pyG7vE6ywol/qI65NMklzlsKeRBJmUgNesXC2GjpB7OQyXPW6XKepy5gS9joqALz1LsdFwJtn79cqAXKF93TX5e2bEzBgDpoT0LTltSPhj4sFL6cdjedx8rySjxYkLa6FoJHHQn9QqOLXXZDlygLdVPMeRabaIlj0aMKtQRD34xmxLzRX0uVMT3aTTFE29rLRP5SFlDrrZqoKPL9bYCqEidPHMIV4imM8W1HZ3CPkxHIAodRkiOQ4ARXURFYQJNqpaaTMUMA7lYuWgLAhdxYlckeLK58p0us8nxRfptN+uWWQQB9FPsxXbw9kYLSrElBseWMMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR/gbiC5/r/WYrcT7mCaMMk6E8099fDtDY1mwNC4wcs=;
 b=SzewL/JdYC4mCfcmkTqjcsRlggnpdwHjsYwvU74tz3P09DaldpU20uVXFMpM6JfmV5DrIsMwcVyUVy92kdf3kwa1XPsteAaGAbT82uYOYIdA0BqUS6bLFHhgyo2peiwTop0gJ4bFrpl+QivA+PR/oGkdPQCqN1H4kerk1xUOBasgXstzI44f1FP8yRYtjyjbHLJOxe0fX33vCpHy9Apr+bFmiJ5xEbcQ1dBHIFZ6h8Deqhd206YoHM4hCSEyALHgsjmrWa41Hxe9VtplFdcafu0ulyO4c7cDxHmiD1ScroK+C/bEwkNP6A19v5ceD1EPo+QVZBAhAkXLyOegZhWOhA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:22:56 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:22:56 +0000
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
Subject: [PATCH net-next 00/15] net: enetc: SR-IOV improvements and ENETC v4 VF support
Date: Fri,  5 Jun 2026 14:55:35 +0800
Message-Id: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c55dc81-3b5c-4b3f-5f08-08dec2d3434f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|921020|18002099003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	ciqwE8nayr8EeddTCv7L6E3KrmJx1PMCn8MujoICo3jNQFmTNY3lrpS7FLva93zmA87B6qbgkcnQZgE63VPt+7lNjk1zjcGmt25y/3QCK28c3QkDInk7gpPgQI2r1cOIqmbPxiOao5wkVUQJDK9tO91tuf4VG9BwKSTSIaO8XdlcgsepkYcU736M/+ok0yJO+5HG0rlv+am7n6aBSoTMIDILnIU8Bdl2yDIR/L8CKol660p22jdMz0HR175JuYsiSybXDDMpoLWAkEoikCVJsvEK9D3ppewNWxV9hQwe8Y3s4sUnDQPQjsxPutO6+uY0rFDfHFHYl7Wl2XvWDgQiQ0rXcH/tArp/OgGmPh9PIDMSIPLjbGZa3OGskzvXULGr6wJitA5878ysc9EbZWyoePsXD0pCX67aEPLw1SpO1FOuEHAidv4fwLAKS4FfkpysbvYm1eF3E+RGjtxbUNn0fZvtq3WJg64XXWmiFCjZwgDQWHB5P+TJM6mdS6caouA2uUzvYcGuK2rbX7ZTNkSOjr37PTk2m91gF/bZG01du9AVAN1khuP7u6RJALqm1MD9ZsQxLp+DUDnPa0iRtCn+XO598q1k3VgVc6fhsmdkOIFIgGz0SgQ0Xp1SuojInl8vhJlKh/taj9GLaesEixN4WFE+z/ElhajDMYZ3ifrWOuysAq5uDrllUbz6rD9nC4fObOM+3hPvz9CUnF2MFMyIiXXXdyp5u+ISlJyaK70P6ww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(921020)(18002099003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IItCcmPuCZ/2O9vNyBc+ODqiEpkK7yD8mBCOGy+P6Gn1SKFy8Uhy9b3S1+tN?=
 =?us-ascii?Q?n0eH/ESfBZ92ouLXEREJgrEebRS5AvARg/F6g3eol0HpXFwKieyK7HCuAk3L?=
 =?us-ascii?Q?ymVfbdDXALdJGS6Fr/bh3zNZmsPpUpLZOi4n/N+UIYety95n3BnDL060mbhi?=
 =?us-ascii?Q?SzyTgM5OIUEfQMIEfQxtS++dfyhb7rlh7NHuCuVNkyLz+5nI4mrazttOIuKE?=
 =?us-ascii?Q?n08aB4t6/lId/aR2kAQTY9gvqz+i5pH4UOjfYwSV/GvvXKDkr0bC9iaAwTFf?=
 =?us-ascii?Q?FJUQzdQusCLVC50039ltOAfREveYdGMork1u8fgWoCs6w3kb56wYITXOB4vY?=
 =?us-ascii?Q?0n+jOwom25DYHw8fBFg8WFlKNZbURllSbsmShx4MmoSfoPW3kINueLjQ9pA3?=
 =?us-ascii?Q?NuWFcY3KDf47RcExDB8CPW2OgEsSwQ9VkGdVriRkEP2OEgPP32fTXnnPvbKY?=
 =?us-ascii?Q?Xa2h4Kh/nu/Zx0JUhtRO6cfoIMbGvj7hG8LCL0vuo0/r66R2oLlrq3rKH4tg?=
 =?us-ascii?Q?FTVBkT18l+hMkNUH3fo1P1Pvk50+GMPLJBPIOzt/jwPKwzVeWXtHLp0Xa7Ts?=
 =?us-ascii?Q?1lVeGexyIVpzwjomrCQOUlqc1jdmgMKoqcGLYpM9xXadvQYx04xK1ywC2uyQ?=
 =?us-ascii?Q?kvL/CA6fLG6dZR05MyO8Xp8GS6HCiBUKxIdkoWTPsNNC5RqPw5he4eVu+ERS?=
 =?us-ascii?Q?6z+nl+5JriFQcrQ4FrYgoAH1KKaH8U/UsvAM5sMPXReqfzFlG3LK7BHfmKev?=
 =?us-ascii?Q?CibnBiyB0vSs81Xchv6yGgaq2xJd5ANAYO31PhONevbAeZf1BWtJ2xSop2tz?=
 =?us-ascii?Q?WcNgRWJrOC1AEJ4oHBYMEbeZHNWD4saOdOdEyTLE7wU4yqbrxQQI6J2Qsf7e?=
 =?us-ascii?Q?KNGmeSuQPglFk50qNXxYrUMu23LCa5FqjLBcPafOQoUeaQNUG5+nqy1Ctiro?=
 =?us-ascii?Q?349UwGW/3l+eSOxmZNnCrvyrOmqVTnLeRqU+H7fawOJ6kmQGuhPtxYi3Cfcs?=
 =?us-ascii?Q?Si2+U1BwUDDQdxbQF7u59n/gdI3RQLRqXYRo0cZ0gw6kaa+EXesZUP1XaJQ4?=
 =?us-ascii?Q?dzOFYmHBNws8Mz72kDF9ja1QsuqRLy2Imx6nAw8UqXpg0hqOb4GzAgnHVuYS?=
 =?us-ascii?Q?SHJ3maKNwq/l1fOlAIUfYNdwcCQ/TvjFNNG5CIQDuaDs0x3q0t5lD9S0EH+A?=
 =?us-ascii?Q?FlmDElvpGEGTWWp4s84QHBrxdji/WN1wuX8rGcfmV0OrbSM8mkcb+I1N5usO?=
 =?us-ascii?Q?9a1zl/hrja+QrGM6XCL5Gamy3kWPZsUJE3IWa9n0QgkI5561IYT6aU/dJdlg?=
 =?us-ascii?Q?To+6jpPjABdnMYFWmabDp7Og2twHhIbponCCIHNijM5tbfENNOKdalzD0JPf?=
 =?us-ascii?Q?3I1urlX8lViWJ2NecFGiMEtyoX1Divj8uf+R6iIcT1gmjW4/hQ8vmbqfom/0?=
 =?us-ascii?Q?rd9lZ8OGVL7b/RzBpPE6ASBBwR3gLpz4WBQZbciwvD3q9Bsw2LQ4y9cF/fho?=
 =?us-ascii?Q?TPx0nWWWh2qe0//BUUKV++azAfjrlzF/ZL/R5swtZGWlbteg7bOB7nFk+XEj?=
 =?us-ascii?Q?jlBDm84890AZUN3XawbfkXMXJHmYmjPIsrv8uD5teaWUStLBZ1DuyGndpMR/?=
 =?us-ascii?Q?F87DelPb27voxEfocArxLnYZ/M4LEIhnjCtGF3ggDEoKYzO70J2KQgDqXlMR?=
 =?us-ascii?Q?3jPs6IspNPQtgiqt3DWDbO3veYfODgKdPoXO4LGJ1ihibds+mt/x1H55ewqW?=
 =?us-ascii?Q?1FtdrvpXiWBLqz/Buwyt48ZPackxbKwrLNCnDoAhdcJGpjkeUyhQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c55dc81-3b5c-4b3f-5f08-08dec2d3434f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:22:55.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4uOvpWAt2bhKuZCo7O/2GQ4BK2IgHLoVTl1rC6AOz9TXfiBGQ+J89flxRqqRWbY/34BCJE7zfBk5DFibm32TE/ncvmimQNLiRxrTQ//QtJ62Me5PUgKnF1J5L7sYSLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295682-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,oss.nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B402645F20

From: Wei Fang <wei.fang@nxp.com>

This series enhances SR-IOV support for ENETC v1 and adds VF support
for ENETC v4. For ENETC v1, the trusted VF management and per-VF
configuration query via ndo_get_vf_config() are added. For ENETC v4,
preliminary VF support is introduced for i.MX94 and i.MX95 platforms.

On the PF side, the series introduces trust level management and MAC
address assignment for VFs, and implements ndo_get_vf_config() so that
userspace tools such as 'ip link show' can query the current per-VF
configuration. The PSI-to-VSI messaging infrastructure is extended to
handle link status and link speed queries from VFs, enabling DPDK-owned
VFs to obtain accurate link information from the PF.

On the VF side, MAC address filtering is implemented via the VSI-to-PSI
mailbox, supporting both unicast/multicast hash filters and promiscuous
mode control. Since the ndo_set_rx_mode callback is invoked with BH
disabled and is incompatible with the mailbox polling path,
ndo_set_rx_mode_async is used instead. Link status notifications are also
supported: the VF registers with the PF and receives PSI-to-VSI messages
on every PF link transition, keeping the VF carrier state in sync without
polling.

VF Function Level Reset is handled explicitly to restore the PF-managed
MAC promiscuous policy after each reset, since the hardware default after
FLR enables promiscuous mode regardless of the policy set by the PF
driver.

Several preparatory refactors are included to share infrastructure
between the PF and VF drivers, such as moving msg_task and mac_filter
from struct enetc_pf into the common struct enetc_si.

Claudiu Manoil (1):
  net: enetc: add trusted VF support

Wei Fang (14):
  net: enetc: move msg_task and msg_int_name to struct enetc_si
  net: enetc: add link status message support to PF driver
  net: enetc: add link speed message support to PF driver
  net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
  net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
  net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
  net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
  net: enetc: add MAC address filtering support for VFs of ENETC v4
  net: enetc: simplify and rename PSIIER enable/disable helpers
  net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
  net: enetc: add VF support for i.MX94 and i.MX95
  net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
  net: enetc: add PSI-to-VSI link status notification support for VF
  net: enetc: add ndo_get_vf_config() support

 drivers/net/ethernet/freescale/enetc/Kconfig  |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  26 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  10 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  81 +++-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   6 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  25 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  86 ++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 459 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  60 +--
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  21 +-
 .../freescale/enetc/enetc_pf_common.c         |  98 ++++
 .../freescale/enetc/enetc_pf_common.h         |  13 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 325 ++++++++++++-
 14 files changed, 1119 insertions(+), 93 deletions(-)

-- 
2.34.1


