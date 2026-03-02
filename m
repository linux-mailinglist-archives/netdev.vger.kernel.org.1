Return-Path: <netdev+bounces-262639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dGciAHh+pWl1CgYAu9opvQ
	(envelope-from <netdev+bounces-262639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435D1D8194
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2655030087B9
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F7365A16;
	Mon,  2 Mar 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eqVNV+CX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311C35A38C;
	Mon,  2 Mar 2026 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453490; cv=fail; b=Cj5drG0mVz4lTYCpg2u0bwbLncJx95+xukbTLZ0uKZGTC5dPBy8dqsTnBudt0IybGzoozCiargCgkcUo5oVWL2V8dYS+d/g1MwDWr4+2OvehoJW+BW2JQkigHS3atElXgKcGUMEolE9wyvM6QPSC/PnU899/YWbGYr62dR3mDSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453490; c=relaxed/simple;
	bh=VhSW8yOHGaPOsvYVPOJ6lMFkJMsW874BgCRNasXaxng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P60loTO2WT/o4I9Zd/e23NkwOLxvvnacMANlbcbyQEy3kWwLERc0zfohFtu1B0G8W5yuENDK+/rM4c0WxNc/4b51sxJahdPwxRxQiZlj5sf/i12GUpUPQ/0xjBqqeq7zRlSw3rEGTT+oyIBfzynlodBo/+GejNvmc3YdJZAWxaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eqVNV+CX; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCX1Lir+WEnbVYa9qyrrEQXnTfdedUULHz4bo3aNT7CQ7UtmaXJjo1SloejbJz0KZv7501aYKhn9PEI5hs9Z7gwzuujzBseoNdL0tOfZ9noNlwT1T93oPU+eo6II88sW/RP1bkOIGMFY00lr7iNSQhl8/3FMsU1VhIWt+6O8DFIkxkgYZP61LsJEpA3lJ9vxM2Evy7Lq/d99q1BGbflQhRsOQ77GTw/B/e5Dvb2K45AA+63wRFXAVnTxDTJjFGNby+gzKWnSsTrFE3R3NWajX4Uklnqom9s7prwSFn3wcYU4lDvHe4AhXGQ5BKb7IJDfTkTylSTTY5OObi1XrOvHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLkMS8q9aiYsRQVWCg7/psv3htnWVPQFdChZ2fxPNKU=;
 b=rNlXMYVMZx1jFkAYgL5yL1NMESXxExLc5Ugu/H3FVheBa9+WrUTU9x1cwYFV+p7kmeA4wsNYHm48BmeH3PI8rWLH5Wx+rEavM9emZY42+EjWSIsoCNEemcF7s3UXfgT7XO7SUtE+1SlRr51dcnB79DSgwGKn9Dt+NDGVEi+yt470a6P0lDq4K/+Y6ou43oj6jk1VRiGYjmmEOCSQUqb+n9tXl9MdMAqRTU45z1vk5W7mseswqALkdVwUBZRqTX9GltMKgMW7kHzVSQa+mWSwJUjKMe7/4QFunT2xuRXshcR8+21SEO7Or2mqnSH+wuu2Q2bi/LtyXY23qTxjq3uktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLkMS8q9aiYsRQVWCg7/psv3htnWVPQFdChZ2fxPNKU=;
 b=eqVNV+CXOzqyCxtIlb8541Th0NdoMcZIsZzxmVBIv5YD+9rOM/eK2lURPgbh8Pa5S/ejh024TDILTtOcSRpbSLYm4S19+YIyrBTK9k3Dzxa7DtUn3jUKDPCZvUnmEKnxigG3cHwlErrtVGo2LHhgNlrI+EFO/XbsWmcmDr3IPThnQ1wcHyA4/kycJxswq8KVIRB47kjQq5ZOKvpsJvtcjjqklccbEuzjzspjQ60M7iPmNi51vOO6VtCyvLF7/Na86/viAy4KnDqSsz/mla2vC1IFIeOgBfGgmU0Oua/ATzULsbBb27n4MJZ8I6iD8T+IaZ7uIdgz9IdVl758q4hCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GVXPR04MB10826.eurprd04.prod.outlook.com (2603:10a6:150:226::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 12:11:25 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 12:11:25 +0000
Date: Mon, 2 Mar 2026 14:11:21 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <me@pmachata.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <7hct7o4rzgygef536al6if2jl45p32ad3tdswyqf25uu5wy5re@2ltu2ems47q7>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <20260226182223.5eb1b10f@kernel.org>
 <87ms0ufc0p.fsf@nvidia.com>
 <20260227164348.63afcc43@kernel.org>
 <877brxf272.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877brxf272.fsf@nvidia.com>
X-ClientProxiedBy: AS4PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GVXPR04MB10826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6215fb-879b-4feb-383d-08de7854d33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	ClEm14WHchtrfd9NYVT+fdktLgokFDJI5EyIVficJD8nZjyZ2AaaA4Ce6CjaNSCnVTrdi7uoq7brAaUqPm7HyYlRmoJPm+wGBF5jMMbddDF2ilT28OlWuN+rsxbOoUYsdL6BVn1PjvKEmPrmhKlb0+Qx03K4kfTC0dZYmuOSMGncYDbj30HsBSFHhV48SytUhG2c70+yCKU40uwSAjNAyiahz+ajzcd7bSi7g73RWivwWhOcSemigkPEgqeDmMA0DC8vP2DijJdsDBKrzwbZK/aQPrfEV3oZUkRTWCoPDL8ECl/nZ5+VvJm2ClVbFKUvJ/+FqxWTZHjEFOHNmEJW1gL3dvmvZ3kYUevf/HA8AZaw9vt8YomKWzZDCa8g1evmSsQJx01KK7kyUSus37s6o0KNVZDe09czWNdMUmitTmWOulEr05toqKsxGOfwofganvmb4PFllnpYl3v8NYOIxqOPiOSwkoE9itBLhkxN8Q0Jx1xFFCBLB6AKNdULEHdH9fzugz/mfZPq3icf644QBKkuiJA/A77k9VME7d/S4AbS9/oRQptG6mbf7X9r2yzBcA5jNhVHl8NealTEGRJ0lLAZ0HVoeUkeHbxJZWI66wxvGF8psy0JPVYBXv9PLyYhMAmOoMwq1d6gSZl2YdON+2+b5raWGrBBYQvNe0ONo/6zA0m4zJtC5F57TdenPidnMtnYZVRHC9LFCuboyX+m68Qpga+jOykSpbtOF8gVGcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j7zvduMRIU6yjirad5BhTx/Mb9FPJmyna6ca2WuoPrny5Ep/sDD7l3Oxddn/?=
 =?us-ascii?Q?iTndZ2eGEXp1JnM5DTDI+8cvq0HUa2tA6UFqBZNBfgUxm0Ztp8mm8Ct+Bnd+?=
 =?us-ascii?Q?QfRQL1ajSBAN9TPObhbBfjmUmC5glphz5hvOhfy0YQu9WIhVa/S4/0ExIepx?=
 =?us-ascii?Q?kvv1/aWmtkQ1RvzRCxJkhxAnHV5RYB9AKZlA0IzVR75PEk7ZRG5QnwRVEnt3?=
 =?us-ascii?Q?C6/Z/nZ8XwX9xkSJd/QclotDtq1udtpP9l4HynZzO24EcWNVD9zSBqAbUB91?=
 =?us-ascii?Q?KTLPlgF30JntORGzwTrWoegV9kEUIxG6QOb/K6zDII1KXVT35cvP4mPepB1a?=
 =?us-ascii?Q?U0UjqhddoWDxYiy/klHtoONzg2mgy1GE5TXlLcQRXQDI2GYsj37bxo9kO2e1?=
 =?us-ascii?Q?onYljgV+I1bRg+aQBRvhNtIrEo3hqlmJGJPLgvskwiwnz75g5e61r4INu5X+?=
 =?us-ascii?Q?zz63Iw0B5KbcT27lIM4qviFQJhPvN+21H2jarsq1zyz0fuRifjqk0vy8fFjO?=
 =?us-ascii?Q?QuOiwrrPGrbMVafHR6fiIvVIU6zfG2ttiKBjeE7GF3auGynwHdih14oy33My?=
 =?us-ascii?Q?bBllABDGcdPQkUzhgKYhifuhyZ7IQXPQaccutEYvfI8a0lIkrv/ZC4Okups5?=
 =?us-ascii?Q?kxi1P/56W3SeZrv8wME+9bCc22ipAQVjimo5q2YT4iZBUjC9vF6ZVovCBQ1u?=
 =?us-ascii?Q?C90mJQg8QRiPG6cd/EpEfWUsIElzcA8Qa7hmGbzDCJVtCwU4a0ociTtX9MUr?=
 =?us-ascii?Q?IJeUWtfYYjCGo8HLU/BvQbPN5Grh7ySmDH39NcfH9Rmzs6UNhYLXYg7guBsz?=
 =?us-ascii?Q?eQYp2M6VSPsWOsrk06t2OJDo48VAmFzS/4xzIdQKWFnVyMTJk7SNLG6gFVvy?=
 =?us-ascii?Q?4uhVa/7qgWCiqtgGw2jBhhftt8I4+LJXIk3y/6A/fo7DLMC1iAEuC5rRaOE/?=
 =?us-ascii?Q?YoZRft2M92fTI872H++o2htPc3BJrVgnQ6p04xKhkoxFIlRAm9YnPUiLOM2t?=
 =?us-ascii?Q?ACziB1r8CK1DG0y4ELFByrPGwpuz9ioAUOSEK6kjaTbRw03cDifXE4lygGT/?=
 =?us-ascii?Q?+5gKcDeEJ5kYbbqwo5ztWpcK/BiCTq1GfTblSnHYgrjM3cA/j0MiuzN+gQ+7?=
 =?us-ascii?Q?9in02U3nWDMDBBWbzwGhzod1QnvHbGOxhc93tLK9sw18fkvX3MXJuBe34Roe?=
 =?us-ascii?Q?ZH++4Xsu8oRkkFSotD0FJnG+l0nNeEADMMp/HgZymMltLYcSAFoU/SadHGvd?=
 =?us-ascii?Q?5JACL9n7ZjpDP0jdByTQI4Ikwp3eLISdUc1uzyL0yZjSD05uC36VjP0frKjA?=
 =?us-ascii?Q?7te/S6yMqMU7zvbXcBhrWR6raXmlbfDVGxJ6ayssT9v3Vk7NMzrgMDGf1qI5?=
 =?us-ascii?Q?WcNuoRZvTYzYJCHs4kHuS5N2rtfEdfaSs2XE3ynZI58jrbhn4vBmsjx/+/Re?=
 =?us-ascii?Q?mffPaHqr0RLNiNtoOG6pyoM6xs2lErPb+yY4WGFvM3CLYFNO5p2mFvqFFJlD?=
 =?us-ascii?Q?pv4hfBIaX3upO/8rPjJq5wzC2w7MQYzO30UAxP/X3Sq347qxk0b4dVqzPjWr?=
 =?us-ascii?Q?Fi4VEuow+O4GbFcn8HqBj161s90+Ckid9iNvi2lmK9eErf+5L4MDc8qeb+VW?=
 =?us-ascii?Q?DtpXqbzqp+J4vAaZS95rTO4KstN5S69s2OPTgCCfSh9anZ83o1A1U0tNB2OC?=
 =?us-ascii?Q?oXBDPPNOgNnm6XjuCUjPqbnUXxa/Sgp4qATpGNTnfoYb8JAV1acGFovl613z?=
 =?us-ascii?Q?wu2FgY/Mtg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6215fb-879b-4feb-383d-08de7854d33b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:11:25.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1RJSrHfLOXFSTfS014Vf9j1byOnI59wye1bE+QF9H+hnp2Xd1/xx4xPOMJYPLsPv6Mrh1CAWIy8Ru39ldM8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262639-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3435D1D8194
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:11:26AM +0100, Petr Machata wrote:
> 
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Fri, 27 Feb 2026 14:53:06 +0100 Petr Machata wrote:
> >> Jakub Kicinski <kuba@kernel.org> writes:
> >> > On Wed, 25 Feb 2026 17:06:48 +0200 Ioana Ciornei wrote:  
> >> >> +ALL_TESTS="
> >> >> +	test_eth_ctrl_stats
> >> >> +	test_eth_mac_stats
> >> >> +	test_pause_stats
> >> >> +"
> >> >> +STABLE_MAC_ADDRS=yes
> >> >> +NUM_NETIFS=2
> >> >> +lib_dir=$(dirname "$0")
> >> >> +# shellcheck source=./../../../net/forwarding/lib.sh
> >> >> +source "$lib_dir"/../../../net/forwarding/lib.sh  
> >> >
> >> > Argh, at some point we should probably decide whether we have 
> >> > a preference on which "library" / set of env vars we use under 
> >> > drivers/net/hw. Adding Petr to CC.  
> >> 
> >> I think the expectation is that by default, tests written in Bash are
> >> run on one machine without remotes.
> >
> > I think we need to define the guidance by properties of the test, not
> > the machine? Of course _tests_ which don't need a traffic source can
> 
> Oh yeah, I'm just stating that's how it currently is and how we got here.
> 
> > simply consume the NETIF evn variable, so its trivial to write them in
> > any language without much library support. But for tests which need
> > traffic input we need a different distinction than "does the author
> > care about single-interface machines", so to speak?
> 
> I agree that adherence to the drivers/net/README protocol is valuable to
> some users and would be good to uphold if reasonable in a given tests.
> If that's what you have in mind.
> 
> There are going to be tests where it's not a great fit, but I think that
> of those NUM_NETIFS=2 tests that we currently have, maybe
> ethtool_extended_state has a good reason to be obstinate, because it
> sets up negotiations and needs an extra unplugged netdevice.

I would add here even ethtool_rmon.sh and this new test that I
submitted. If you are running with a traffic generator on another board
then you can no longer check that the counter's value is as expected
(with a 1% tolerance), you can only check the lower bound.

Additionally, if you are using the same single port also for control
traffic towards the remote traffic generator, then you surely cannot
reliably check that counters that should not be incremented are indeed
not incremented.

This means that some tests will not benefit at all from working with a
remote link partner, it will make them weaker.

Ioana

