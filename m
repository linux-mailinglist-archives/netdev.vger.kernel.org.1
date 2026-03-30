Return-Path: <netdev+bounces-273131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMWsGJRcymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C821B35A1E0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A10A6306A88A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0C3C871D;
	Mon, 30 Mar 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gNhGM1Xx"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6A3C3440;
	Mon, 30 Mar 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869128; cv=fail; b=Pc0pUHMOCWCL8bFiu6eS1iQ+2ULhaX1cdJCSKfxRLtpF0U1ten91laWB/sIrsQwsAJsTB+JDztHV0rXl90R5jEg/MTx4BpJNs3wcR0D2zhxPD4PXNv4pO4CdnKezujpGLVsDsmmoXHYjRBEEqiea4Bq83gKFimSoxPfYvisYdNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869128; c=relaxed/simple;
	bh=kZ2Ka5IewB4d6tsyd0ujlTAD+UZKVUG0+6JmqE5c6cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ngf52tyW7V2i4VluXHyOeAgrFaCClPOcWZxASjNRlnjDe5Bqkncm1tILbleFgFb4J5bL5imeo4hG1XntEram1JF7ifUUjGnOyf5gjsN+91/kN/k6Yq3869I3Iiv1hoAhM8513QD3KLLPD4Y8rrM8P44jz/B3myPiXKChUNeuJ2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gNhGM1Xx; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3DlNd9gXcb7kyn+tdjFNgfwPVLBf+H8E2NwbCOuYqnxu5CTNJTOB/5J5MONVIG55Z1sPNZxH7ZnBVo1UiIb4TVSXYuWUnLS5gU5Q/jKYYzKcPdUtZubEbMGRLzbYAupHllcp++CXamJMSbXMXG30X3Xc3NSmES22SPzMK/26vhJCNDC29AdvCrjGn/2c0WA40A5ZJ9ZR1lSf+Ppw3oTb59KF70kjYyTBzCXYoKOglQXy2DMEqDItnf1FO1fUsipnjN8xzF0AVFuElCgeed0VVC2jvrx6btDnmQjglhOpiPfNjOfFafFUFGQS5AKTbP7ifuf4tLVqeIDOh68Pa65Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgUgB9xmTGBiP+2RpVgzYSYzzRnJtwcku6cOKIg0uhA=;
 b=GlcsRu6OsRJ9Fhk2orCQ831YpoGYuCv/5Khazv56rarjps5sOP9ACbpierTaycoBKrASal/pam0i/PMArWrgCPJw8jYe0yk6ISGKVz9WUWeCyCDoGz2tYROi/JDNfetj2H2zxL7/kohAMZ0yG59xFftGkvvigKCgirrsm2iCYfKhrRggQWYtM0JoIh2KvH/MsotpkQgiVEwWV7RgM9uN2Nh0yEngxPkk8Ih1rwaNwlpQQ3oS1FpTMT/rBv/Hxq/mVub5lOrqYONiVsGkbuAR86lG85ruphM3wF9kLRXOlFf3Di8zQ4aF2eCOBUuvv5unTOc4yAOj9QkjRc9V2WTmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgUgB9xmTGBiP+2RpVgzYSYzzRnJtwcku6cOKIg0uhA=;
 b=gNhGM1XxYYvEDGswiS+IBfVUtKUFf6oykfhKihzOjpXJyiR1rptjRz09G6oOwO4r7N3MmYJM9vZXxWo+wT4WP7Z2hme3dzek/kprmFXTxTUxQaca8aKs34OkN9gq2UgTVdwzjAV6iVhS+Cm8gn0M++sRrzSVaOfoNTDdf7iyjQfWcph4pJE+/7x9SEfeQYIs/y7tnyo+Wa8OC/I9p7jpVgepIEelu84ZnPUm0d4Z8aWQWOpFLNe5uqv83EB3i/EzFB/WFHAkcGdTdeeq6zTO/t82P0It5UTPSzbOmTDf4aAq0j0Kf+KB+z6Eh0qlt3JWYFBRBaqIPPe6L9oqFy/tdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:12:00 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:12:00 +0000
Date: Mon, 30 Mar 2026 14:11:43 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Message-ID: <usxkovboo5jt6vu2jvbwpnsltvewjil27xizt3jjhggu5o4td3@2cgex6op4mzc>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326120342.6429fbdc@kernel.org>
 <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
 <20260327172454.6b9bc8f3@kernel.org>
 <87a4vp61m4.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4vp61m4.fsf@nvidia.com>
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: e511083d-f4b7-4a7c-f85d-08de8e4d2a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gcZmtErnezOW8XdK8t+2nTb9MDWN3mPvv8A194UNQ2byzIkt0Q6lsAiHvNTtw16gUeX3PsCGQxnPm7RxUV+RBNfL0V7Q7/lynJ/5blHrr30yeGwhFK5djfSHiZBvNBbg4JG2izzFt+11JGcG9+m07J5QoTPhe7h2C2kWvQDtY+T1QETGwzpmwRW47AlAuq7ctnngBbHgYaxHrPzjXKO2QEETZ/J5eyrUUjUYEvq7JRkrqgHrR/hceycbKVjOAo2skKsGXONyJYLurRZl77CL//YSJtNOhh9hdi+46//wvX67BwLj7zCikCOxrpsO1zqm91q7nCF94wnesfXJYrNPcTMhsvLBHQaRLv0qGLjvAZyRhpXRW40iVmXMoIiHcoKLVYgRhat8c5Wf90VYfRwRdyh6tgvNonnk2cejWfYVo4IOMJy72By5eiCS55GK1KrnNjkwWbIJkGH3z4aYL0D57t1wZ3qQ2vjtAiYQzHt0iNXZDzIuUS+RuFnrzAC9Kn5pLmUzrjDBLrO7ZL6OSgkohqLcdk4aBKi6pTQpEbAqDfyYyxSIbzXZTTWyRf8gYlgNad+FOZ/TfkZ7l81z98mQ241QvGRLbh+wMneTWuVo37g9EAb9u5uUXh86HRmjoQowpVBNxKVmKiywqHDPMaVG5PtL3rBjyV+ALhwXwcQK2oozC5ZqWIygNn6VTFlqf2TX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryK50KatMq4q/FFADJ7+Mb+S2ia/L1raS+ZBEyjUsOPeLtmXEJHbq4HUkt4M?=
 =?us-ascii?Q?KpXgjiiVJtP2EKitpdJMYBcpANbss7QwL9DoAdsA8lg8xvKK3uYFLOZkIJt3?=
 =?us-ascii?Q?rNWRPAoi6IoNuXdqb7e/xyv3Bd+SE7vfDjqprlks8qDZoWRvvX5vVLHM16Ef?=
 =?us-ascii?Q?KxJBw0hSXzJrXuvmf6PFn0AdL2itRVGqjwDZzAs6DtlhII+1kNvm9qUTid2b?=
 =?us-ascii?Q?63pAN+sLlwj4Di64zC6YltjEzCojlaiKChuMs5XVhsIfVz9YthDFpaAuqH01?=
 =?us-ascii?Q?1b+XVYT+d83PsFElRXAJNKCHJ32j7UgBvjx06L7PnMsDrHTpcxKU1Bs7EDva?=
 =?us-ascii?Q?050BMhuR3M/82rIVTMaK/bTWJvc/OvNWPPIsQdxewMNguluSXzwEwgVaOdqD?=
 =?us-ascii?Q?5nVSUsa0D5pdObNXrPaiQmk5AX74duRsIlvk0/i8C/7OwdOSMaofJYrkyhco?=
 =?us-ascii?Q?tVDmkBsZX0qtkYf11qL380OiCccUK4890JZET0h8bbOt5KrQTj5s17qCu7tB?=
 =?us-ascii?Q?hL4J3+Ct3AoNIxsroRNIH7Uvyz+OWrQHWs51k+ZB2HHP/P1ItSRv8LYPXJgI?=
 =?us-ascii?Q?4h+wgR/oLWcK9dQdmgSFQoStnXVdMC/tb9yzUuLy06VJSXyMZRfwjHIDQ7a1?=
 =?us-ascii?Q?g2HAbjmO5h3KPXVzZY6nJE851u50dzFKgodQje2qj8g6WuM7gZuBEutDyeTT?=
 =?us-ascii?Q?ggNJLJvscTwardkqgyh1qyJaSSgPDQV8Ro3x+efgDR8UGvFqNo+bgb0HczL5?=
 =?us-ascii?Q?GK7NHrLBmttSIWiXTJjLxEmNjkzL2VQ4Z7l6CHlYm+/T/s8CsvQK6NX0khe7?=
 =?us-ascii?Q?/pekn6tGC2n8ykAshoLq/JD2JLnDzsxgDqy4F0Lz214oKtLyCUUGTpH55pgm?=
 =?us-ascii?Q?3hYT50exWWZSEUF7feQSSc/wdDxH2uznuoUSe01i3MVt4WRascGguUGM4Qzf?=
 =?us-ascii?Q?P4VuUsD11VLaZMXqU3h6Ppjgy6StY3SqJdYGt9Kf6HBIyvZwx2ZE7uxPwQPJ?=
 =?us-ascii?Q?FldilQ9p0rTkACTgunURbESNd7SXdhQNVXbVmB8+Y+KvXLmj67MaNXFmAQj3?=
 =?us-ascii?Q?7prfNre8T28D7QnLoVak60/Kkk3gy1ajEMxoi2T8F6FjPH/n1Z8m7B4Ob75z?=
 =?us-ascii?Q?uxonL/PgG5LSCyWOYffCIPSTV4T7ldp6vRPJgDgtQS7NzUri61SlY6RCSxmn?=
 =?us-ascii?Q?VuLVurrCcJoTuIU113eSH/HnpJZu1weUqqN+7WEiraopMVsuiL3Da06C8udq?=
 =?us-ascii?Q?BMF7hHlO4/+2Tp8y7D9PPMt99OtdKQ7Z2DXQAWi8i1x2gRbnrpZpL/JAwKVf?=
 =?us-ascii?Q?yAsVOrRhmNmiX6qhl9sOi3EHyms58D9zGeNR+tzvEWNKuUdPSy/SOvje+Hr2?=
 =?us-ascii?Q?3b0IwYglRElfDMgtkVgD8bogveieyBAgngnA8hi0hzSV9T2eOHxnX1eP1ZkL?=
 =?us-ascii?Q?CqQ6YWGN25b03bOEgi0D6+HNt2aXPvEJROvdO2UthPvhN5jeD0ACeyhvjHM8?=
 =?us-ascii?Q?Ch//AkkxHmrdVb3EPhAmkLMYnw4/6GmhlOHroK5jpX+JiDZ4fEQho7++rZBc?=
 =?us-ascii?Q?LmSMaCmHytE19YHkHpyO3KpD79F68ZQR3TsxiYY1Ed4pLUlatCIdOCvIHSzU?=
 =?us-ascii?Q?zzGtEGkWWicZAKqkTvcNopU7aeLCRLsoVmB9z2gOztP40pg6gQaCflJNKhiA?=
 =?us-ascii?Q?ycbC4GyrGX392OLeGX+f5FfPMhMq9AQu/HVcJTmFYS1aG4KlFB8sGEIexgMh?=
 =?us-ascii?Q?/3RUuT0eiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e511083d-f4b7-4a7c-f85d-08de8e4d2a11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:12:00.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXRvyiw0o8gkqCSO8zlZpNB8ssuZbEHgSFCNVY911rVlwrD61iEiSx2BSsf+cwjhI/VADe3wQAaBFTxxy98VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273131-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,nxp.com:dkim,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,local_termination.sh:url]
X-Rspamd-Queue-Id: C821B35A1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 12:38:54PM +0200, Petr Machata wrote:
> 
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Fri, 27 Mar 2026 09:32:22 +0200 Ioana Ciornei wrote:
> >> On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
> >> > On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:  
> >> > > This patch set aims to add the necessary support so that bash written
> >> > > selftests are also able to easily run with a remote traffic generator
> >> > > system, either be it in another netns or one accessible through ssh.
> >> > > 
> >> > > This patch set is a result of the discussion from v1:
> >> > > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
> >> > > Even though the python infrastructure is already established, some
> >> > > things are easier in bash and it would be a shame to leave behind the
> >> > > bash tests that we already have.  
> >> > 
> >> > I think this introduces a bunch of regressions, eg:
> >> > 
> >> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
> >> > 
> >> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout  
> >> 
> >> I cannot reproduce this unfortunately. For example, local_termination.sh
> >> gives me the following result with the exact patches that I submitted.
> >> Any idea on what might be the difference?
> >
> > Hm, the system that runs this on our end is:
> >
> > # cat /etc/redhat-release 
> > Fedora release 43 (Forty Three)
> >
> > And it has this added on top of default install:
> >
> > # cat /etc/systemd/network/99-default.link
> > [Match]
> > OriginalName=*
> >
> > [Link]
> > NamePolicy=keep kernel database onboard slot path
> > AlternativeNamesPolicy=database onboard slot path mac
> > MACAddressPolicy=none
> 
> The observed issues are consistent with TARGETS being defined, but not
> an array:
> 
> $ declare -A T
> $ T=([a.100]=b)
> $ U=foo
> $ if declare -p T &>/dev/null; then echo "${T[a.100]}"; else echo fail; fi
> b
> $ if declare -p U &>/dev/null; then echo "${U[a.100]}"; else echo fail; fi
> bash: a.100: syntax error: invalid arithmetic operator (error token is ".100")

Totally agree, that's what it looks like.

On the other hand, I don't see any other use of the TARGETS variable in
tools/testing/selftests. The only way I can trigger that kind of error
is by setting and exporting TARGETS before running the test.

 root@localhost:~/ksft-net-drv# export TARGETS=test
 root@localhost:~/ksft-net-drv# ./run_kselftest.sh -t drivers/net/netconsole:netcons_resume.sh
 [ 1895.134633] kselftest: Running tests in drivers/net/netconsole
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net/netconsole: netcons_resume.sh
 # Running with bind mode: ifname
 # /root/ksft-net-drv/drivers/net/lib/sh/../../../../net/lib.sh: line 707: eni497np1: unbound variable
 not ok 1 selftests: drivers/net/netconsole: netcons_resume.sh # exit=1

So this means that TARGETS is used by the netdev testing
infrastructure, I presume.

Anyhow, I can change the variable name to avoid this. Something like
NETIF_TARGETS?


