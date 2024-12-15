Return-Path: <netdev+bounces-151994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C679F24C7
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1DC1885DC0
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5417B502;
	Sun, 15 Dec 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="klcAfcBx"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB73101DE;
	Sun, 15 Dec 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734280492; cv=fail; b=ZDrHUGBd2PTZtHgdL4rHUj5K480AwRmLd0O7Daoco8xmeBYR0fM3mFN8jvbopMioywJtWZBThHZWXHAlvgd+ZPO+WDZeqK0Q9+dn4x5RdIcJaYXJx1zT+v5w1BR04l0khCD+NxJKvFy8BbhsMYyEWRWYktEnAi5OBA4bzhrwTWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734280492; c=relaxed/simple;
	bh=noyQ5T0abW8WM/vCOPFZVNuQMSGqldlEu2Eqm+V+crg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIg11anyuGYqfX1ODl2gGXo+AlfODQDK1RY+kxANJk9dr9l+e4ttJHxoAp4lzZkhoMpwnfhszoj2i1lFy1DT/NpAT0Shb+1DWv5eEfnEqRAX26messCtoV1EXQWNQ0O837PdwpXxw190tJ1SaK9/S4GnowZdsvdql3TobTTdhwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=klcAfcBx; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48]) by mx-outbound20-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 15 Dec 2024 16:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlEcLgmvNHLNaV0E5NrJE58nuKrsJe5sHw6/g3uLoBaDTgGC/Wm3MGYEhXXYR6x+RjRdA/rhuC5eflPqe5MwLMiCOJcGWBznsFtqwtxI50U192Cbi+1fU+ZnFSPoe4GZrFAd0vCSL4IwQ2Jm+hRu2MEouMvmtluGmm4qXobr8phYXU8TeE8LsEY+I0hVPl/PUgF9TUo3CohYJFj1lq6h+90wkNfcxnTiJ8MSbFr4RlNR8rNoT9yrrBWgBUywetyvqYq0EiV20dt1l0rC92nuvJxdNmQ/8m59qPom1AuS3ScfHCKHkj0NzCGhUj32rN6zWwMClTdlpzL3htl3tS5SIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcSPKTWzWDKr0w9EpSo/PTdCsaHd4haggABnV4hy9bg=;
 b=t1Kln8Jn+CNOjfzYPGvejaLYzIu2Svq40j+r3jgHF1iA3us1wrkVyiqX4js8a/P+rq65IW4F8sTy5ZHoY+s+mBGt674lrD4d5BoaNMaKLDgVzrXBQPTcSQFMClDpizA0538hfWMElAtfJ72zSJ0V1bwbNRErej26CeVP8rsYxUAe1D5OHhR8Ok2gbWUX6eplB2qI5HNU6wFuen3+mNrFUoORiYDFvIdqTWzMYrtSTYcqHH7EN468IfmeGFFmbv8A9BW1DUpDf7eC2XD8XOKOBaw8FgHBWWVVqedI7HQ1wQ/1XZzwCVDq5SFd9JubpQq7b/S+S3IyBFmAiEM3F2a0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcSPKTWzWDKr0w9EpSo/PTdCsaHd4haggABnV4hy9bg=;
 b=klcAfcBxz4d/s2JiWgeXS+uIHAKDSLyuHIXyshMWAgwn2sF8W3hJl41p9pyK6wPOijOm+qBj+hn34J+iTnQKRaSZ474hvcZGZBWrP0omBV5EscitEH29H5hwk9bh2RzsjJI3W6Ckat7s/E0btxY6iXoBQjkc3akplvjP6OaWmGdrAHhS7U/o0yF8M48PSGhmyOiN8MJ+uykgFjCuMI2DsmoigDc2jz+RcB6yKxIguCl+b9A2if8tnGGpiMMOwuS8vNlWaD0hsWxpE1gGwMtncEouvW2ePpyt9VwrMTolhNeGl006oWI0r9m0Em/66UzlYvnCTqFN5z4jYefERNHWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 16:34:12 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 16:34:12 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH RFC net 1/2] net: dsa: provide a way to exclude switch ports from VLAN untagging
Date: Sun, 15 Dec 2024 17:33:33 +0100
Message-ID: <20241215163334.615427-2-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215163334.615427-1-robert.hodaszi@digi.com>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: c939d207-af05-4441-fe2f-08dd1d264ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8p5qMO7C5EsOFGlPFMq5nC51el0d8UWh0fC8S+TMQyO/H5Y/TtsmjPOFaGLR?=
 =?us-ascii?Q?hemuPSx2SCi85SBqquWUFH2f90qppOU3BiSqxT2i3uAJMScurKzSU8mZcPh5?=
 =?us-ascii?Q?rOG44Mj/y7foQW29ecbbESVRuA2QAG3i13NlOTMnBvZcWB9ysyJgxfdc9dOw?=
 =?us-ascii?Q?eNHyTYyyfI5zMI13JGnvE3LKaoUwFe7YF8UhFhZFgjwymjzAQJVOw7wSS1QW?=
 =?us-ascii?Q?f2+bRqyqEEW7Ks8L5+0LAkXiLk/7AecHRaKORDhVSJiW57MRKNZDA8vmEvuN?=
 =?us-ascii?Q?siUN8u5Jl6TGgJDPLbr9DrWcDYYCGuLkfwd35RKbLnDGOuc9U/xfQETqK/ik?=
 =?us-ascii?Q?NH5Ib3uTLS8M9xso/sigvmolWXogYG3zUK6ceenV7cHEQfUBTNJ1pVAXKIvg?=
 =?us-ascii?Q?6LLTyQPOkfYpNpRb04QwOKEzzXgApQ+Kg1r2iBzCWc2gL8y1CvVa3QHhL1Y3?=
 =?us-ascii?Q?p3WnoI25G8q5WsBP3FCO1/8ZCEJ/wKAkT8IR73JK/6vjdjamemZMcOA/fyZ4?=
 =?us-ascii?Q?YUCHfvjrUNOi6ijlRx11B4N4ynB5T1HMPi+3t6F4ijcCLNSOHdS5k/LGwIQP?=
 =?us-ascii?Q?HWrIHRF0ySlKUvp48oVjv4wPaFaSYIlVFzMQi8yKLEt8vPSbJ1dDBZTYwXUn?=
 =?us-ascii?Q?Io2GIuUYCROHi682dH8VjRNYSv0L7X84OdTpx1Nb8TrNw+XDXiV6SJgb9JeO?=
 =?us-ascii?Q?AHeLXMV1harZZZMCk+stuGvZ23KlFKoXXFivPqEipHY4geC5VBmLaTuWD5TX?=
 =?us-ascii?Q?jcAklO9E9CkRyX7no2f6F41nYdTzgUYJELLeu0D/o9BpMyZlMRoeKYkqWBwq?=
 =?us-ascii?Q?+XJz5c/tbNDk/0jqJjB88f9kfXXlTXf+Kl/fBCJsWEQH2s29bBMp020FqyW4?=
 =?us-ascii?Q?SDK2YXEAc8tvqmDa0qzrw9iqh4xBZgCtOnzEZZlRugff17ThriwzQW6pOwWi?=
 =?us-ascii?Q?OVRobatFX2vcfyfn2jGg13SR2lfbmIlw0OtNE0KgQwtywD8nQvCeIqfXcuCA?=
 =?us-ascii?Q?WdjFaoWV/stRAOJk1ZPUa//VJKhcnkK5cvVoGCJQZHZuPfMmWtongCTW+vs2?=
 =?us-ascii?Q?RDhfBUvGm4EhBGbbM8T7nw8de7oKf5g/RekbC7iZy3wxr/zuBmEd1sAWosYH?=
 =?us-ascii?Q?LL4RB8xEGvcp4x4qr/OBiL4ziw9GjQfD0qD5N/346V7bgd0IvWfW2/FP3uNw?=
 =?us-ascii?Q?vn4m/ofPPGHAYwNRe8aSa0KuryDPB7Dj83iZjiDkeBnTNWWT7VMeJYXB1Kto?=
 =?us-ascii?Q?MPhIaMdUpUoPlqkByTLY657wSQB8zapF7e79N9cXGoQqYk+1kQMGHUJHStI2?=
 =?us-ascii?Q?EvBxbOY9E9UQTTNW9Kj09PFLrNsdx9nJjklbd6n8YYz/08S/aV/AamFUQXQp?=
 =?us-ascii?Q?MKkiTmKp8wx+/3j3aBIuk2E0A2DVFNDPBa4BomQW9Se8VKWrQSlfiM+cZZ7d?=
 =?us-ascii?Q?nAd7WHMbTcG/84OnPRm59d5yYUW/5WUy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QyNhdNjlG7YvhZwM6aObyzjePgihiuHKIVFXnpAteFLAU5m+7mDE29jkXd0m?=
 =?us-ascii?Q?Ng0ZMyjbnP4wJJ6CkxxF56VsIqiTagSAvC1kIyQNTyV+wVYuiJnZ2jSferkY?=
 =?us-ascii?Q?wCBA4b1BBhzOMCtqvk9nQeXDBBZySVTyZDTd/7S/n/MhGhTw4oQBawWCWDQM?=
 =?us-ascii?Q?ybIfpDUHqJ2hlNrUMC2I4rIrpIpR3MU2vC4k2keVCJMGOTdnk9yoFySE3g52?=
 =?us-ascii?Q?rRLgfB91FREkGfuAqQ/fBaxgZZEmV719s8IuTsgvluE5v+1T8rgPLhE8L0BZ?=
 =?us-ascii?Q?FnZdUnmRuJoqQShyde8l+kBwhBFUam+s8gO9No1+154t2G0CnbwPhTenlK+q?=
 =?us-ascii?Q?s3uYAtPohIC25OK0iRffnltDBRpBoPeKrnCbdBkQc8vMyS2nho5wR6Arb2OE?=
 =?us-ascii?Q?UPHEFNrxa6tiSK9FLc7RH7J6TuVpd4ZyuRQSIS8TP38vYDAbQY9ECstpr9Jn?=
 =?us-ascii?Q?Cs4pvVVMxkQd3hQx9NtPL32JDP1DMoowMp7SgpFRKlea2pg8kRZezZRi1BgB?=
 =?us-ascii?Q?Um6iPJgpSUffj70UHtVnPovJvIgLf28BNroURmHt6j8Q6UigHdCN8AdQv1UN?=
 =?us-ascii?Q?Yi321FXiD2MfxnoMqitaGKUpaxzy0HsuD1DCQhQJfGWrmOUgRoDOT1lIiKWC?=
 =?us-ascii?Q?nq+Hz/+rrnhHW6Z39VJDS5XvEXLTbUsGn5M+eqDB7qOntiXKTiOYIYmtvxNG?=
 =?us-ascii?Q?HMyrxhKlA5eGQGjz8HkUyx5rQAFCWOVmml5W3PpoZX0ADfKNq/+F0GkypR8f?=
 =?us-ascii?Q?llU4Gi8HDxfDVXSvf7AoCYK+vtMgFKnnjSTQvNUVWGNvDSKRj12CRnWOkkQM?=
 =?us-ascii?Q?KIASwTeGjies6PNzuY0xP5TyrF5eh/6CdLHzfYPu6qODSGffgXYnvUToMI00?=
 =?us-ascii?Q?DzEVlXkxvCDTsRyylsSiP631WnGAIC6BSPxY22cTEZPQZ2OX/JdVHwdokzo5?=
 =?us-ascii?Q?0fTK4lsU8j69kXHTFibZ0WwFOdrvVg8VYfekDvHakWuC22Bfitn10VYvUikw?=
 =?us-ascii?Q?8dcYCwLqgeW2icJ9MwkbV0+VVD3BLDOwxkxHqtvDLn2X5jrn6fXXGzghF6Gn?=
 =?us-ascii?Q?zBw6dIcoENTVE27hj3JMV3DxnmhP5Kdv51YfwJmDPqAxvnvc3EIqe6t6rJXL?=
 =?us-ascii?Q?MazO7vEiIjJO4H2jQzvMMExJELgjLNsAy6zVysWmD8wvVyiY5PyRXW+mXpxe?=
 =?us-ascii?Q?hRJyRw+9rF7y22udrqb4KSL8RTo33GWCiFH5bwdd6BWHDSigooS2Q61WFJUs?=
 =?us-ascii?Q?pCHeKKY7ewwBsCxAqy1NFJ7Zuym4nrJIVgBccfvxTajwMW5dHWYDHxbljiXh?=
 =?us-ascii?Q?I9Fd007TsW+5qK80j6jeC7emK702sD4hq6lhZFi1lzFdt977NLLMnK7sdpw6?=
 =?us-ascii?Q?eOeDpZn49H8uuhbz5wGfi8CLwCtnjcNskcpyQ0zr0KtfvSEX1eFLwMewBvdU?=
 =?us-ascii?Q?zwmsJl6Z2bDw4K27ifcisuI+8N/Ctork/39n4Td8QFweX5djFyy1mot6wwL4?=
 =?us-ascii?Q?S6rI653Nz6lh9huCHGY4RDKrrJ5SirRMYMay5zPfGCqFwuwY/Wn3Ylxt8knt?=
 =?us-ascii?Q?ONxRBXbdR3T8nWigA2kApk1KyPzRCnMnZBl4dUAG?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c939d207-af05-4441-fe2f-08dd1d264ed8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 16:34:12.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9nF5twY/pC9D7FrS0t/IMv2F6uGkYNFwZCF8EZpqcjF6I3gOwofzpgaOJ+GfJHHkt5INHytZTv2eQkD9qrcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-BESS-ID: 1734280449-105299-13407-1828-2
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.73.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWxpZAVgZQ0DjVMM3MyMgk1d
	DAwNgwyTzNxNLC0CAp0TTZ0MgoycBcqTYWAIVrWzdBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261133 [from 
	cloudscan19-218.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Even if a switch driver sets 'untag_vlan_aware_bridge_pvid' or
'untag_bridge_pvid', it may not enable tagging on one or more ports
(VLAN-unaware port). Without a way to exclude these ports,
dsa_software_vlan_untag() untags packets it shouldn't, and so it
corrupts the packet.

That happens currently with the felix driver. The driver always sets
'untag_vlan_aware_bridge_pvid', but enables inner tags
(push_inner_tag=1) only when VLAN-filtering is enabled.

To exclude a port from untagging, set dp->not_tagged=1. The inverse
logic is to keep backward compatibility, and avoid the need to
potentially change currently working users.

Fixes: f1288fd7293b ("net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
 include/net/dsa.h | 7 +++++++
 net/dsa/tag.h     | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 72ae65e7246a..99b1267f0c46 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -289,6 +289,13 @@ struct dsa_port {
 
 	u8			setup:1;
 
+	/* Use this to mark a switch port as "untagged", to avoid
+	 * dsa_software_vlan_untag() do a VLAN untagging on it if
+	 * ds->untag_bridge_pvid or ds->untag_vlan_aware_bridge_pvid is set to
+	 * true
+	 */
+	u8			not_tagged:1;
+
 	struct device_node	*dn;
 	unsigned int		ageing_time;
 
diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index d5707870906b..c3d76a49b1c6 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -155,6 +155,10 @@ static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
 	if (!br)
 		return skb;
 
+	/* This switch port is not tagged, no need for untagging */
+	if (dp->not_tagged)
+		return skb;
+
 	/* Move VLAN tag from data to hwaccel */
 	if (!skb_vlan_tag_present(skb)) {
 		skb = skb_vlan_untag(skb);
-- 
2.43.0


