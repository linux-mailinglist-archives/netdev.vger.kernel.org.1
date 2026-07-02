Return-Path: <netdev+bounces-303954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wAgXIRLbRWp6GAsAu9opvQ
	(envelope-from <netdev+bounces-303954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F01756F33FC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gkD51p5e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303954-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303954-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 363823082469
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98427313277;
	Thu,  2 Jul 2026 03:26:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623A312832;
	Thu,  2 Jul 2026 03:26:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962809; cv=fail; b=Bx5Phj4easZljOtxALCBez2jU5HB7Udio4Hjihb49Y2lYUHXeKyOmC3qSFrnNDRnJYDiagBW//oRcFQ9UMea3Oq4xd1LMQMP5oxnA8oHpWKujToj+YcVeTcDLfQXxcEj9s2zLNsTXdX6XcEszE+3HjbJzfs9FWJu/WKJ24xnPl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962809; c=relaxed/simple;
	bh=xd9oPVqGahj3jugN1BqWxz6b67vxgyOXASR1Dp9Gxtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smPMhX+SS51okdrk4xTwAY9/tuKxB0Ac6zK+ZM73PuBw9TesD/umbcIPsQsA4kMAJTfyERvi0bdXt2sADYmLM9vVUgtPS7IayntrP6ammhSiDyFkgnrLJ8d0pKCm6RHj/CD1faVO6o3op+aepqUnMl2m5R4FxP9gNFC2bYAVxOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gkD51p5e; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOD9lLkiJy2NGgPjaWr5u5CTHj09A6gwYTSMvQYiVgGCLIze8QdRPcB4I1YfL4GS4fRBr4+djNo8Po30sm1PRhdsoqXbzWiqHfac0TiYT9CrYV4isKKUM6bQFpTWPtUTjLQNLFBrW6CyD9Hr3bkzJczGTXLyY6drqDJfzhzt9JvdhXEzCWZQfp7Uuw6S66oKtR6jZO3NE6bpZ5Q46IusxdMZyZQJFLocIlPSeo1oNxnD6ObPKHuFW2/HwkUT4nWozU8DvmaMcLNBQkjRLHZc05cWRJ1EoK6TfbyiAlVtAeq8AfYU+roWtyeZVdLGO4j5F35qQICKxNvQBH5fO6dl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4vGB2gg+iH4NN3NJaXhXlCloSOjTmNor2yla4grRrk=;
 b=Znv9pxZZLe2sbbobcI3Qt4U5XFxVGvz6vOiDb0TTsIGpmGjpfOhiIa0sMXxBQI+6DvJgi16ELcu3nobuJsZEARP3YH0kIs0AQ2Lt1TsizwQO3Rdpc7anodsGdLeqBBT0Kwa1wcf0hgGfmk7WwtjekwRPmI7Eb3e6XG57Ajdj4/YXArrOm1EBHEFtt+jYMTrJ4CoC746JvZ9h9BORvYAnOU/Ub8rSW4AVqS+tZdtqBIYNUYIeG92sJVydLp6Dzsihkpsl8o7td8BNZT/Aq2sNDhbcKj6Rh3j+NJzWHzxowlz1Uw9ASCTEZHptWuc+csbMq9kJeUrgSFWwTAPf2osXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4vGB2gg+iH4NN3NJaXhXlCloSOjTmNor2yla4grRrk=;
 b=gkD51p5e5jMNJa5Qcpr77tadAxxkOGWiVj36vWlGjwMPlGzxlUzEZu5epV/EgGRYUwUu1mKyQcHcEekmCuJhkUN+OBEKMJIWsIAyItyWyuusxywuqs6JuDeJJM8mK5QMSC6SECYV3QJGm2BR91H8UTdXOKFKXRoiQZ8bOZL2hfJonfa8jX+2cK52lPjD9cNhCZ2HG5g7V9ZrGmpTTkIbPXdV0c8PJa9lMysNhyK8XOLeCiD4FL6uxfwHexFfJV5qGHqe7iPyHgVnkqKVQbBYLEZpzn0zo5rxFjIpxrfy2cuVpyQ6CX5YFePY5iDsh8jtnvy6EfwIG8jivO/VyXnhnQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:44 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:44 +0000
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
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Thu,  2 Jul 2026 10:57:13 +0800
Message-Id: <20260702025714.456233-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0276.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d05969-ce99-4aae-83f6-08ded7e9bdc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qsSztug0gDgLLNjfupPcN0wf0ShLuuIjDfSebnAYBEmiQ318TSwVPpm4LwnCdqSKmmWxKblPeiVOLUmKdkz/vGyTwHAgwCZ7U2ajKLfjqU9lukO84555MbXHKDKc6Ek0WrLX+KwGzMVlbYr2M7lhYzg2n8xDINi2yJRep0yHukQQU70NItOov7DClqDx+jf9+MEsDQXjuv1muR4L6WvSmfw5Qx8q9C3rTJOWuUMFwXTJPA6MHIhFK2XHQcgG1dHEvaZFKpy1rxsZ+38q6MyvDFRfRsytp79Lrxjt/EssLnV4O/XM9/B56JpqVgFi3oKy50SND3Z34jp66zX2rbPeJn4O9eUQLmXBEVtbp83FgxmisleGnXxkWQ88BRPJOlmgHZGsVDabeCsMmqDn4dyavJoXXAdHws1tjS4nw2rGwhf89UPlKjIroOz5LAt+h5aLlQyOmwae4CZvVqCc9G2jkLVB9c+SaJWBErImlsFmpzkyEUpm5mYDNxPomkofsTUVG7xZpXZ1HrBdcnBa5m4b0GJ1pTy5FTrf+WAI9KSyZqhSL7yzocm+0Q7VGqIK9mzXOnpWDNGasAuHJatkeFwb6v6ihV9EXW5Z8WLZo6/HgIet3u7gH4/ZDMnZBwPf+Gk1cVkRxNNWNvFM9rpjcqDcg9fgt8hTyyh+kBd8p7JfWMsOun0GEjzGuxbUFzLZJKyeV7CrJOul22Yff6LBy/USBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekO/1BLgctphECUhqTKv7Ky1G5ybH7SVD+llDvS/qlMFYqDAzPJMLK0VAxFN?=
 =?us-ascii?Q?9NGh/ezpfUXMjUXwgj+eJbf+Y0yowcQA65aBWbqDykx1C97z7DXfoi+Y/x2u?=
 =?us-ascii?Q?lFhztgAvgOmDmk+Uim0p1HWoa5ELcUTzV6RdBpjWKGlNDkecoTAxb6cgzzgb?=
 =?us-ascii?Q?BrcIcJL/eeppb/+qPgBIemcog+6tTE/E5M4ShJwOPjK6PmxOkwbflb7kdI6V?=
 =?us-ascii?Q?N4gOxLvk4bJLWGot9if/c3ShZWELlsas4KIpkjzIDjQQyVy/fcNc60wNEYCu?=
 =?us-ascii?Q?Qzm50t8hOuQKfSbI0ZZ3eOa32no8wInssnqtKN6FDsBQG7iUMGxmkK+eC3Bu?=
 =?us-ascii?Q?yw1iIFB1/Cbq041Dl9zWVwjGkQ5bvncNWjLjdhGtwy1qAq6Ba72yS1+Pfqy7?=
 =?us-ascii?Q?Nyx4bRspF+Ve0eRG/3rdvB6Iz2ymVsjSanjqkKoK24w0bDfQNImWN66r6ss6?=
 =?us-ascii?Q?dWc52ETZLvLZdb3iAX72mzh6W57HxRZCPcxxJgkn8MAo3D8KBuCBGQv9FweS?=
 =?us-ascii?Q?Cvydc4Ec0dDzgv/4bk0Jni0084pmTXXQK23zKwh+hmA6Nr1dTy1WiuSP87XO?=
 =?us-ascii?Q?jlZYEDAhvYmxqe0QxSNzVoHTrooYsuYnwiD4RacuG9/AWn1WYLQx4SJIFbN3?=
 =?us-ascii?Q?XtnN55RJy3moEJGmHdzDZnqW19QCCL6/si650rTWmw8JPGeHtuRKLmO4jvwc?=
 =?us-ascii?Q?jzpzu6s5ChiN0bYloWYCPiMJs/Ki7DT+hIZcqctp84PSP0YaDwNvLf+C/Kxs?=
 =?us-ascii?Q?Nh4NjZINGPd5XD1EZOL6FApSQOYkSALlLoVMaNFU12nA0fb4ZcgXXBbfhluY?=
 =?us-ascii?Q?vNS+Em3wSvfJkCEv+0l2AkWIeAv03my7SA59eTGYu98A0gJkv69wak4ePDQz?=
 =?us-ascii?Q?0seHeSxwWoyQttFrTu8xuxBBZnZtspp/lRMc5kyx9MfxoARCOJ6u6RvUO6rm?=
 =?us-ascii?Q?MQ7kvII8CJBawCigal07YpCVZae7+cJ732CY21FJ+j4XXpMkemPScWA6VcGu?=
 =?us-ascii?Q?woE99ju1YdOs59rerY884Jwq8LuCLDxK+fKqrDcEdjEnYzvp3iyDcrhgSwVF?=
 =?us-ascii?Q?RoITP5vAVgiuEccbnobiGL3hv1Zf0GNnz6ypA0nuRLzssd2HpZeKrmqqcu/o?=
 =?us-ascii?Q?XztOZVzdzKMYoECPfqj9EtChZ4zXGc07RN/D86JLxxG/Cy3srk5IpMrwytzz?=
 =?us-ascii?Q?7DyE+szNasdkh7HrqcWSPoXno5h0VANodjDUa6snA5WqH/cTYJD1EeSDM5IL?=
 =?us-ascii?Q?x9a2XCPNM6boTZkfWPTupged/oMc9uH/gehBuxNetplQi+0e8DCL66PTwhzm?=
 =?us-ascii?Q?nxc0iIBpkw9KBQsOkDQKqy+PdFtUd/dDfooKp3wwxQ31bc0mHa0vEC3XRYCq?=
 =?us-ascii?Q?oHw2AjWdmdueRnbNyc9xXbeI6nLHTlMD43dUSKgl26g64SAFeVgM0gCGoseA?=
 =?us-ascii?Q?6sFOp2rrdUA9YDyjXKICDe+3gFFVx6siykSQlbDjc7+2tUh3syZ3v7B5QFEu?=
 =?us-ascii?Q?mhizK6bzCY/LV2zD1U4gsvTO0xbpiNJrfAbv6YsDLoU8T99GmKLe0lLmax0A?=
 =?us-ascii?Q?iw+zyFn60ZBlNaUxr6ks0PeBmAM42PFdirsboGulfmhzoMEVS8CqJN6cweuB?=
 =?us-ascii?Q?KOgsaq2B0Tm9dKCdTHYXYAN1aIC7G6UtU3CSDGpPHcl24q22WFl+yxMLJS4w?=
 =?us-ascii?Q?YkzwsJVrGOAsVdWk6ePTS8fdPEbZ368/eYdYcoFIQZrThSVrRexKhE+ZhHDB?=
 =?us-ascii?Q?lAU2VNDJ5ydaoe1+ELqjEJIWQXmDolkoaGucfA8KqRVHIr0ppglG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d05969-ce99-4aae-83f6-08ded7e9bdc3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:44.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/AqRuf4i9kRTUlICIvhhJZ0aMibM9lXP9AcCxCj8nB07+94KBBsYl5j7AEIod71IXviuuMh6xN30LEj7Lag6SDKT4m6s27kGls90w8H3v6ADUrqQ+cXdyWshQbACn2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303954-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F01756F33FC

From: Wei Fang <wei.fang@nxp.com>

The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
queue count, which forces the TX and RX queue counts to be equal and
uses a compile-time constant rather than the actual hardware capability.

After enetc_get_si_caps() is called, si->num_tx_rings and
si->num_rx_rings reflect the actual number of rings assigned to the VF
by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
to the VF is less than 8.

Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
counts are set independently based on the real hardware values, avoiding
unnecessary queue structure allocation when the VF has fewer rings than
ENETC_MAX_NUM_TXQS.

Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
allocated to VFs, the size of the int_vector array in struct
enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
need to be modified.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..3df515a6e333 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,8 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	ndev = alloc_etherdev_mqs(sizeof(*priv), si->num_tx_rings,
+				  si->num_rx_rings);
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1


