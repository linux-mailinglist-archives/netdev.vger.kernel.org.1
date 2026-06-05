Return-Path: <netdev+bounces-295691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id er1sD5N7ImrqYAEAu9opvQ
	(envelope-from <netdev+bounces-295691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BA646013
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=kX9Oo14h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295691-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295691-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C6F30F08D1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A047D921;
	Fri,  5 Jun 2026 07:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A66477E2E;
	Fri,  5 Jun 2026 07:23:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644236; cv=fail; b=u8OR4lU2ZzK2K3qh4KbLd1T6aUGTwraCIK+nCXND4nggFekjq3Kzid7FNQai2yFhDIuqclPfQkNbDTguUHRiX54npPk5XPNkPoTdpnr5elLOQ5XSpwXIsCJhuPSH1lSiiSPwfPgsOupHLzI4AopmrFGMnAyY1YmYUmiDGT9Iw5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644236; c=relaxed/simple;
	bh=Bgxjbp59wyW890Hxk2sEtw13oXEHZWmm/gfHoK+1ou8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0cfRpP2/VdB5MVRrMNfEvHUm+m+5E1ntsN9/v0OxC6DmwLICcTE9KZWOV3lBLlhXSHeWDOfoWoe4MLjT39Hnno5FIoyE1twe6bc/+uNXYXfq0TpLB4DNIEKScXpdIEP9Y5FFss7NiGV/wSNEGGEtKFi5MTCtrf1wUoMWc6L0EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kX9Oo14h; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyWQ1tGuUmb8gr7k98bm+f1neyxCpMfM3YJbKH8EqGqT0gRxF36XkK0dtQ6IfqdnKGw70cWk+8weWo/iCQoumjG/Y0cX7YdKHaP16MI0Zg4EpPEkfPHfqVYQIlrcVNpcAKeKRDLIVoDuXpyleW/W4jlhrAcjAKkut4/Qlcgyc0Xx8H+WG1uJTePVpUXGeGPYFSd9XOWUcgIKFjRzSWeTwsG5KuDa17XytmUB3jPKTmJFfCWNvMvrXkPsMr+TyQWdVABhYfXUgcz8T6sBtZ2ULUTpN9Vp4byzC1PSSmBTfXWbKGJiPUAoRqRToeRhP+f7IWc0NzYaYP40tJn5Akq3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alshFPKEMYxEfSFWQbKcSM8KF+u2bO1BochBwRj4uio=;
 b=Q3JxJVYuNIdQLm1JmiHPHr6sPVkyfMk/xgl10wZrQBvMNR2e3g3AF1G0ckh3GRa0/jC2Bk+g4leUR3ZJjvOb6SOEQCo4/169SYlnnC2N79LxptF3he1L+eitGPZhDtd8NJ2Sg8xv54XkfFHFPHFMNkc9hL23Qwe9W0ap8omG4znwvi0eZLDGLSo0QBkjFwRB8vc8gzSQ60pJ5Z7YUq8wMyvTWXTgt/HkhkObBwUEBHxxOdUt7kWvFUaYIvTEkHArBFUJFmd1QLuPgCDX0NDwcST2OTG6cCJQi+v7Uc+DPhaa/AnG7OOePYjGqzIb/czvZcDUQZLu/4wz9PgLySsF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alshFPKEMYxEfSFWQbKcSM8KF+u2bO1BochBwRj4uio=;
 b=kX9Oo14h23LzZ9akHx6n6thQyfxfJU8GKdcVeAbz0mEg4IbGLKGKoP9BE+tJjIL9MdFHJ/8GkSxeafoedHHRC9fs8V1usgq8vo0wJ6KWIvK76telLr/eu3kiyb879Gc750qN7liYRm+PQnbcKSUfObTqKMCBNDVH1Z7BJ30xIVaZH+5K7C1t2NZfGqRRHlLsTXGMnzjfcOi8XNdTrrw+AOKxYFoTfqSyh7BN129KB/zAUcKbqdBB8gPGUX2eDK3XkDd/Q/B/7IIRkNP1pATvCjaYo5qaPRWzWUtaEvxPRuekIOqX1wJmQUayE43I42oLvvekbEu4+GqIcVKBWJH8xQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:51 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:51 +0000
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
Subject: [PATCH net-next 09/15] net: enetc: add MAC address filtering support for VFs of ENETC v4
Date: Fri,  5 Jun 2026 14:55:44 +0800
Message-Id: <20260605065550.3038579-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8e556d-a420-4f5e-86b7-08dec2d3647b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|3023799007|22082099003|6133799003|11063799006|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	FpewTY3P1cxWgaNPAfwtRhKWrJgpKS4Pez92OQeFsnBIbh7VjjthJHQ2JPhNKncNEyvB3f+zOTy9gnNLPN39EY/mA4vzTaGbYRZnkgxL1YgkTbfjenRwBP1bZOgNf66vEqxHNcj73YNe/Hgt01p41L7r2lJPgBHSDLxJGpfspMV7+kfuXCgSe3j1m2SLJ1IurG7VKIFE7vG6izP0lC1/Hu0IXWqwoPgXmQx8pkqgP1XcvLV4PqEm9vH+pdb3bt1OWB82nDh1+xm71JmU7zUAxVrZXS9G4vwVUGOUxvIoGVBZjr6AdQgjoc+2m7jfxOUfO3cIRid5uf20PZ2gTpE8lz1H1TxDPNepaknKaV+Z7lzt9ZNzk48GiDrF+zI4psfJvlAVDmzrN4gsmNDbJFb7v2qzKUHVVvMDyhRPPslR3mxIFaVPendJuErkfkbPvha5UqkyG+UW8bQFs4vPTIjFa8pze6+Ak0invPhZ9lzoE4LFnuauqsho2XLskEUDh+acFlKtyLhRus+jcL+rcEB33FfEOvr4S14lbHR5bnBlStynYc8ZzPnrFHU0KeLicKJz/J/2GzsRsPUBBLEIlQT/Zf/cwvr/pSlcnLFmOsOEGje5JDoY+uycCAEz4sWOJxTeESZEbQjQMSIETe5Fbsrl/Zzlwg/MOVXgLNMrYwn/0SxNbw88eBTt3xJfvOLIGZfjzhtKIcAQ1nhrFGG9G/lKhUN3A4sexkoswPHvogsSlgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(3023799007)(22082099003)(6133799003)(11063799006)(18002099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qLefucw3TnpLMji0lLVntcOPO8Mp9imosO4gBmRt3KC7+OY23QM+puOBEokl?=
 =?us-ascii?Q?GwdU82R/NeTANKmp1/hMohdIt7505I20nb6C1zAPdhsCFugsjugTbVOVuaMM?=
 =?us-ascii?Q?WJVuXoLAjPiK77TipQSxLapRkWTabkN7pY+veSMkwdKms9dahvKMhbPgLTr1?=
 =?us-ascii?Q?nUzD5mm308De/yTrTV4x+UfKn7u0e3kq4OwGLfM9/YisE9kgWNIy4dKJtkMK?=
 =?us-ascii?Q?3FjlsaPVXWBggPPh6UOH/mE/0kIK/6VDk00KlzG4slA90mgFI/rnF3ut+dHV?=
 =?us-ascii?Q?k5wjScEYfeWt9lCCd+WhIRV3pbffhC4XE3Z5ghN1XQuwTity96BSN/mMPdSl?=
 =?us-ascii?Q?GRu3ydtuJfk/6ME3UOG5q9yvw/uIyli4i+h5SdgqAew2QuLTJra+ZpVuCk4c?=
 =?us-ascii?Q?SKFsjPXcfCY6QGGrwNoyZSlHkhbena3xVcmEg+ncpgQMr5Ulci5bsVlzxqn3?=
 =?us-ascii?Q?seMcZsqWe+fr1Btv88k5vkc0pYwGY2wopcjKaeaSx1yJgcrIYbXMoj0ZjFgB?=
 =?us-ascii?Q?w1xke0CkstAm1yZVd4TSQBc4Y00B2dq5a0vgBq8TcXW2Jg2oEeYFSeL/O9jP?=
 =?us-ascii?Q?VuxU62Gg7pNhehMuhguDtg/82ZVCEuLFcf2oehfX8CMUzNbwPI3JBMMXvdof?=
 =?us-ascii?Q?X6atgUnvRT/qqdvW+8CHm5//FtQI2ZQn0I2xMvJ4QH6jpiDXIl+E8/Jd2RdW?=
 =?us-ascii?Q?2l7w0lFM6lx50xdNigBbHtQ7cf3dZy8LK3zQN7bvlMZCZg+Cs9rdMPLjJP7k?=
 =?us-ascii?Q?ZtlcKAQ0eGQnWhERNbIUfIos2qIf8M5UaReoJMn35f+o8h1W7RhRGRaMAwlE?=
 =?us-ascii?Q?P85XKQi22b3hgAaE45xwYdziiclYxV2GKCcepeSCzPOuwJT3FWeDoeSadbPT?=
 =?us-ascii?Q?hpgLC7FGKuUdFZkwl9Qqe12oppLnhVwx8eYm/kAULCD72g9dY60F4SWs9Mp1?=
 =?us-ascii?Q?IYAkV3I7SLPnQfZhazu2e4k8RdZZ47iuYITFH9hY/6Ls6QKpJlN0fGNScRTn?=
 =?us-ascii?Q?A7611hicQMlmzuv8sYvEJn8YOAse9A/J/tZsQJAss53f2O3XYpSPL2lkGeJZ?=
 =?us-ascii?Q?GKNBHeJCFAaNkw5BZsW6yz+ODCzRDbBhmx+fft+U0JteIMkvd/vLZa4+B7ls?=
 =?us-ascii?Q?7dMBXkbb87Kzaq9ArI/tMGyd1IzHexXm4kIru3KGnhoYzSYuEPlTe5zqYsDu?=
 =?us-ascii?Q?62gQvOY5I1b2OtvelmfhQsqsb+5uSJxxVzAbLyXqZN26qimii8c9Dg5iKCY/?=
 =?us-ascii?Q?r/PLrC6tOJKxwxKSE1EmRpUGA+QFwDKBFM0KWWHnK10a4Kdl7pbu11+jdd6n?=
 =?us-ascii?Q?VTpeAITF95fO00Rd5u/ArzRlLOGfzdVQfks6xkcVc71NZ7IVvUBBv0xwI49N?=
 =?us-ascii?Q?DzHHTuAEjETPOWG8vlYMqte/LMjCHHR3SbtjJunRRXXt+dr1hYPeNKUaydRS?=
 =?us-ascii?Q?cZROji161W2KBNol6+9EdNRX2yL+Oc7GnBSBK4Ko6wVS3/tFESCoj5AOeWPn?=
 =?us-ascii?Q?/ey7ZRnGUUj5R6323Vc6e71uozdnzDhfC3bumeyxCO/PneWQfG1SYkfyGaQz?=
 =?us-ascii?Q?otlPhdCWsyYU5CgbAL9XH1KUUt5JIdl1jdlZzkhG5KATH+WOzpetdA9cscyc?=
 =?us-ascii?Q?deajc1J177scsWHL0bO/Jnq5d9pLVuJdhQz7Uv0ussyZAOjoFK+d1uj73XzS?=
 =?us-ascii?Q?/aCthYLPe4ktFopCTNNjWkkMKe6dkx+JzAHx+VZ1dld475F+VhAKcuCPeY01?=
 =?us-ascii?Q?DsxqWakjILSW94okpOKnnh8wzhlU2jAmXvyDziioFhBp9WAJ5ZiA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e556d-a420-4f5e-86b7-08dec2d3647b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:51.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvFrTEJmLaH4+OAVD/14pMw0ATVxB0ax5rWhifEs9T0TfjWfVL9HRrCxv4YY/1ZxwSpqqRiGNBXrShB8VG1tIon4dPL/g7HTgT1bVl4w4+nMhJXaqPQXSPsyaBnqXp0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295691-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A46BA646013

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

When a VF loses trusted status via ndo_set_vf_trust(), its unicast and
multicast MAC hash filters are cleared and promiscuous mode is disabled
to prevent it from receiving traffic beyond its allowed scope.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  40 +++++--
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  39 ++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 113 ++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   4 +
 .../freescale/enetc/enetc_pf_common.c         |  21 +++-
 5 files changed, 204 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f6920ded9f7e..2e081a59154e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -76,19 +76,22 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
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
@@ -107,6 +110,16 @@ static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
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
@@ -273,6 +286,8 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+	.set_si_mac_promisc = enetc4_pf_set_si_mac_promisc,
+	.set_si_mac_hash_filter = enetc4_pf_set_si_mac_hash_filter,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
@@ -513,7 +528,10 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	mutex_lock(&pf->msg_lock);
+	enetc4_pf_set_si_mac_promisc(hw, 0, UC, uc_promisc);
+	enetc4_pf_set_si_mac_promisc(hw, 0, MC, mc_promisc);
+	mutex_unlock(&pf->msg_lock);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 44c8196accaa..9e23499e290f 100644
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
@@ -195,6 +208,32 @@ struct enetc_msg_mac_exact_filter {
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
index 49c1ca14735c..7dcb1dcdec84 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -101,6 +101,115 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
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
+	u64 hash_tbl;
+	int type;
+
+	mutex_lock(&vf_state->lock);
+
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
+	if (!pf->ops->set_si_mac_hash_filter) {
+		pf_msg = ENETC_PF_MSG_NOTSUPP;
+		goto vf_state_unlock;
+	}
+
+	/* Currently, hardware only supports 64 bits table size */
+	if (FIELD_GET(ENETC_MSG_MAC_HASH_SIZE, msg->sz_type) !=
+	    ENETC_MAC_HASH_TABLE_SIZE_64) {
+		pf_msg = ENETC_PF_MSG_NOTSUPP;
+		goto vf_state_unlock;
+	}
+
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->sz_type);
+	hash_tbl = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+	if (type == ENETC_MAC_FILTER_TYPE_UC) {
+		pf->ops->set_si_mac_hash_filter(hw, si_id, UC, hash_tbl);
+	} else if (type == ENETC_MAC_FILTER_TYPE_MC) {
+		pf->ops->set_si_mac_hash_filter(hw, si_id, MC, hash_tbl);
+	} else if (type == ENETC_MAC_FILTER_TYPE_ALL) {
+		if (!msg->hdr.len) {
+			pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+					    ENETC_MSG_CLASS_ID_INVALID_MSG_LEN);
+			goto vf_state_unlock;
+		}
+
+		pf->ops->set_si_mac_hash_filter(hw, si_id, UC, hash_tbl);
+		hash_tbl = (u64)msg->hash_tbl[3] << 32 | msg->hash_tbl[2];
+		pf->ops->set_si_mac_hash_filter(hw, si_id, MC, hash_tbl);
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
+	mutex_lock(&vf_state->lock);
+	if (msg->config & ENETC_MSG_MAC_PROMISC_MODE) {
+		if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+	}
+
+	if (!pf->ops->set_si_mac_promisc) {
+		pf_msg = ENETC_PF_MSG_NOTSUPP;
+		goto vf_state_unlock;
+	}
+
+	flush_macs = !!(msg->config & ENETC_MSG_MAC_FLUSH_MACS);
+	if (flush_macs && !pf->ops->set_si_mac_hash_filter) {
+		pf_msg = ENETC_PF_MSG_NOTSUPP;
+		goto vf_state_unlock;
+	}
+
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->config);
+	promisc = !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
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
@@ -109,6 +218,10 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
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
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index b90a3d24d854..7ca85731d6cc 100644
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
index 85e1efa6a8ce..66a9a734d18e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -468,6 +468,7 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_vf_state *vf_state;
 
 	if (vf >= pf->total_vfs)
@@ -476,11 +477,27 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	vf_state = &pf->vf_state[vf];
 	mutex_lock(&vf_state->lock);
 
-	if (setting)
+	if (setting) {
 		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
-	else
+	} else {
 		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
 
+		/* Clear MAC hash filters and disable MAC promiscuous modes
+		 * if the VF is untrusted.
+		 */
+		if (pf->ops->set_si_mac_hash_filter) {
+			pf->ops->set_si_mac_hash_filter(hw, vf + 1, UC, 0);
+			pf->ops->set_si_mac_hash_filter(hw, vf + 1, MC, 0);
+		}
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
-- 
2.34.1


