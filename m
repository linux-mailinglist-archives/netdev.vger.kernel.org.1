Return-Path: <netdev+bounces-296982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeHABTXSJ2qP2wIAu9opvQ
	(envelope-from <netdev+bounces-296982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:43:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D065DE82
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:43:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=njNJAgcU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296982-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296982-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E48E9300BB93
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938663403E5;
	Tue,  9 Jun 2026 08:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037830E84E;
	Tue,  9 Jun 2026 08:43:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994610; cv=fail; b=tvc5m5SFQ84e/3ZVO/sCEXtCRIrwPJ2Fq6O26uWyzfVwHuJHkBNpLbazkon4te5SuCa+ctmHNUGJLB/Css388Wm3BNF065SkIn3qJ/IjMiLEBJe2LwOGyqyBmULvHuSqQkHRrjMvF8SOT52jgJcPjRPWfIGvtdMTQ6U0dRPujR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994610; c=relaxed/simple;
	bh=JxBTpxReV6BWnUsPXPfEKSxRmPtH5uaQiIuuaBhz71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DXfo2ewojjLOXgq1+YorwsnO3n3cbt6hQV+rSAPD8GMmWLp5xtNbRdsljtAzjUey94jUOz9CTiyAf4SRXLypEoxKM1JevX+9fLwwL7D9oDhX2NdNNiWH/MFuosdV8+cnK34p4rJlFmrIGvGhH8Oc1pHoss23X9b4wNetcyGW9Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=njNJAgcU; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CagMfmKiLCI850WZ5FsH+Jwr5P1pg5JEbJvbgew1FlNGPCAm5BnrahPLgnRhe3CDhFqBTKnOuqTmXaOz1N2qbo+jxcI/I1dYL1APzZQlziKsOtU0xpbymrTPMHP5JD749HjdVT/Dtf/lI4CtY9XG1VPyz7GJmjFRIu1KSUIGPbGER5dTY5nIItAG2vGCPDCQHRhs1whhHl7jtm8+m06OL6fyZwO4hn+YkubanhwboDsQCDKvOHGC1OnfL0dXIE4antIrHJNN2aVb3buaG2gjBFJjbjtibvZ1CesXTKAw99L3wMYpLVWUh2/Itd1Aueuz5h2Sdl7fkflW3WOEHEviOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJPQOt45YOfVs2iHo/thRMW2m69muw0AeMtHePL31bI=;
 b=ZBCVTM8+phkg9YeflRvEjyQ2g4HBJUL9vp1L/huE1/mwAl6YDgH6H87h2c42AJw7uxI2CCOEzpDYrIue4ZzjkZ9kW3EPXrF5Ml98X/n09j78j/86AwOYTE8Ii2585jC1iqYDqc2mDqfuNUZ9i6lEEu/6rJvkvLciaxUgghb3zODfZwQtXZXZcp1QavDI26yq4WQEyR82XgqjFr7i51kZ5B6PtFH8u/9yEibQF8WPG4JNznmMlHdrWSLfEFshtt4VhdpI8ZTq3297YyxHK7laN7bPkF/IborIn7/XZKYhXjS3GK3sH6YtjEAC8GzRzGENn9HCQy0kqMPRtzKpA0bD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJPQOt45YOfVs2iHo/thRMW2m69muw0AeMtHePL31bI=;
 b=njNJAgcUzhePLrSbY4CKitItPYcIO/0XeK4IHQdmlZnvp8xjnJBkntRR6dP6MlSoFPFKkGX8uM14PI1T5QX/Cf+7ic9/5hHcUqpx5z+fttHSzk4FESHgaAzxcF4vrWYNsUAsqpzOynGR2LEQioSQZM80nKpKY2WKG40CjDJXnjMU9ka0Q11i1svCYP2f2MzkfaZ19EXsb1/KYUUL/OTluDFvq+0Sb5RP0YFIpad8MDwaJwzThMUPc35DNBAVpZTVEHqcW6+cOpJula/OpwO1Yda2mUhnamQ+nBuhjm7SMVKlL031H/UfBV7D3NdTvO3QvPt1AhwiIANXmfQJOWZhWg==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM9PR04MB8907.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 9 Jun
 2026 08:43:26 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:43:26 +0000
Date: Tue, 9 Jun 2026 11:43:22 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG
 offload
Message-ID: <drqze6rs2qc27vl6mhoq35iepplrr7qqldnt27q7nx74g77jt2@4mhmiisz6kxb>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
 <20260606021047.4124576-1-kuba@kernel.org>
 <7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
 <20260608134533.1c913041@kernel.org>
 <20260608134620.3ff18124@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608134620.3ff18124@kernel.org>
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM9PR04MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b959b50-8514-44ab-dec4-08dec6032c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AQjA3ziC4dVx2huOFmGp7vF1+NWUBQWiQeamPiRFF1ZpIM0po4vSkY3JWHhZImZ8dh5lnzCGqZ9JA69+5G5Ku7WwIt9Ao3/rOiNY4hUKeHJggRsdhpTuxrVTVH+CQGjdDGW9ojrTz0Cy7W2k3rrid4GLCvycEmdeH9Rx147H3YcLqMr5bMZ7fAMXu1QNTR+hvloyJWmUKeTTIOfAWb7xlegV9GWEMqzufsLVbFYCONtsgI5yw2K6azVuHw7Eb+AxwqVFVFR7cCmyDlTKr28X6NPI8Yea+E7ksAsjI55b45EW/2YvBM1Capk5Z7Qq6e3dMS+XMM5eZPwuP4/Qdx05eEdHHqxjuPlX4gC7c48QEt3dJmZd7UYIiUOG7L74mn/ojep4J2YLnNK4z+Lwbotyn8FgSqwFzZ1Shl0wO0KwxdVNF5wWUBlzHoZig1vP5CBfywqiTvQk0XhxA2O1XtLUDQLiOErh1wHrdy/8di2Jv6iSJlgSfmFiDC1TcdwGEQ/sL3MsG9UFto365XGwxu1hKGNd6iJLNmdKuldGx0e48Jpn25dqNoOtXigeWqHwUeeXccn8oEXTjtLiIU17Q7GgleCvWpPutrer1RTDnN8KHJSaDfWmDiBo5MPph5C32/Uh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xTJpgeXyjEOKUCePykMJ4pOJA79clX0aKO/bRwe+57KfzpjKFhsiIQ28ioF?=
 =?us-ascii?Q?MhpuwfL4b2E4kNY5VwlKsfqPNR8tRlkxmlhx0PMWdTniFSg8xMCJBQcZo5wx?=
 =?us-ascii?Q?NXAqSOrv0F3PzDj8Mihf//qRHItY5Sx0RD7P5WlaOc0jeQqhlOjF3IRbmBDA?=
 =?us-ascii?Q?e4vAT1PcxjBGJX8MWwJVaxpKB262Iwu2yRiJuiUrGyPVI+eDGE2Pb+z3q/cT?=
 =?us-ascii?Q?T3a/sPbOv4tYYZ1IzYTHp2g/h6olRvCm0q2SLZ0d6GrWAPxlkPxO4n3YmThn?=
 =?us-ascii?Q?gvjib+dNQLfr9+ipybIGaiRnVZpl7EtNdoNoYdxm+RzDSkXGG/UOmnNYHTUF?=
 =?us-ascii?Q?uRctf6Zvhg3ic4qaCmcZYWpaiFnHsUQZ/0jg/JIzK03C4chfiCZ8Yo8rSyfo?=
 =?us-ascii?Q?8jgSexC+zUARKOSRhn/0bHEqb7WHPwP7DnMUndeGLzddQ7O7MoM4jEhAwRyw?=
 =?us-ascii?Q?wtIlfQsu/JTksEilLdaoHlcqL74rjG5cVOma7e0WtBgy+GJE9jOo7XvZ7PVo?=
 =?us-ascii?Q?nUqWq3yEjP/ohsM88KcLblCs7HGg8MZprRkZYwqvS9BHMdelNUwvcy5UPFcb?=
 =?us-ascii?Q?h4dHWX2/ijHduf09VBtApwsFn2fngBA3CsFwR7K/3qBIHDD2nEFw0OhYwpcm?=
 =?us-ascii?Q?pB8SM/cxNbORC6guztlvwfUboNhQLe3e4+hT6x2nRd5JnOTb5Gns5YR8iHUI?=
 =?us-ascii?Q?R644aRPTufvwx09hO1Fmfxzso0iLoyYI7zdwsVF1ZL76YlroyVnsvvlF5Gvl?=
 =?us-ascii?Q?UfzbAVgHvpcvg4dSe4oI+yS31Ypw9puU4CDLqoa2dbqjko5q4Yjpqig43nyO?=
 =?us-ascii?Q?lbJl4WnvWFxdvhWzPWKZ1gv9+wrQCsTH65NURwZlHIGQGirRfFuxMA8yp6oK?=
 =?us-ascii?Q?VgKQp33d5CEVF57WzWXq13NxXVGBbpTUS6JyhN3XEp/k5onb4NQwNVWpkH94?=
 =?us-ascii?Q?JB+dq0WyRIeH7HX+jDog7hpHEq9UM/29ltMX93JX7p1Ff1zn9sxOag+6DbJ0?=
 =?us-ascii?Q?Sh879FmxcyPPPS2FbYwJDTJWtPVYtWQBfQUfpaJxx/7ROY8pYX52ismoSpP6?=
 =?us-ascii?Q?GxMEQTW5dMyUle4Q85hBAjFzDINwxCEfcnn3CI4HkV7YyUb4wquCB5UQvMk7?=
 =?us-ascii?Q?Xp0xRtAao3N8YGGFj56Pg+F8EOCJ76x5XFpRkS4hZj3AlckjOz2kR3oRwg/P?=
 =?us-ascii?Q?JlJSGbIEf7o8vjjn40dp0pRpJMKSxZ0gWm+j1KAFTtzKt+SnyW6vGs3UJIg7?=
 =?us-ascii?Q?wAWlSinn50gjNXkzQE0YR2KDAT4V4MlUkWcvaoW+k/9PNVDs7h59TOSfJq6r?=
 =?us-ascii?Q?OV/R+oO7db7d/6g5vrNBWARgcXamHA37YP1toAfP71kVCdHtvpzTHJxpeznI?=
 =?us-ascii?Q?FYL5iRLB9HTrJ8RJC3aT8p7XqV0/nvwPIqF1pwTiTETWa33hvv+gNBrknOB9?=
 =?us-ascii?Q?cM9ymjJWqds7TDBKtd2t50RD+7zwUL5Zm50J4neNJQYgJah4r2lOWAfoiJhC?=
 =?us-ascii?Q?ROfcpWd2Xh8CJtJDXw7ogh7SHU507RUwOUI9GOp3fFB8xKCq7VvZVn8TVXA5?=
 =?us-ascii?Q?Z/51wj5qqPaf2UAEDep+X+Gx50srpL9bpWE4vhOaMDnLUaTfso+8E+jktu+e?=
 =?us-ascii?Q?92V8Vslx+t2iUc/kyTOyAStWkgGPrWTeh2WNR7ewaRQdvMr96OZtzn71S/Cj?=
 =?us-ascii?Q?urs+oBc5lBX1iUD9YsqIURKgK32IXwkJOyi4hMcbXOLD7otRxMYTClshBQlF?=
 =?us-ascii?Q?pkY8SYx9SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b959b50-8514-44ab-dec4-08dec6032c3a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:43:26.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89R7daqUmVepJlLId8WwJH1PrUkuJOcDubS7wkdWiSMOlbqIt91aHx3XsQIjOCnkJT/juV6GiV6KnvcoPOaZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F2D065DE82

On Mon, Jun 08, 2026 at 01:46:20PM -0700, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 13:45:33 -0700 Jakub Kicinski wrote:
> > On Mon, 8 Jun 2026 12:14:07 +0300 Ioana Ciornei wrote:
> > > Please let me know how I should proceed.  
> > 
> > TBH I saw ~30 bugs and assumed that at least one of them must be real.
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> > and
> > https://sashiko.dev/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> > 
> > LMK if all are actually false positives. If not just ignore the silly
> > ones. 
> 
> Well, I say "just ignore" - sometimes the AI being confused means that
> code is hard to understand, even for humans. So I should have say
> "exercise some judgment", I guess.

Not all of them are false positives. I will address those that make
sense in a v4 and note in the list of changes what I didn't address and
why.

