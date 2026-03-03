Return-Path: <netdev+bounces-263219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLlyB37qpmnjZgAAu9opvQ
	(envelope-from <netdev+bounces-263219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:04:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 877951F1035
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F4932103AE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949D35DA71;
	Tue,  3 Mar 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="koYSZ+QC"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6335773F;
	Tue,  3 Mar 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546030; cv=fail; b=d7VIG7JCD0L3SfULPt/utGZIPU/iK7V59Dn975V1plgEEK+3oQbGJ5ReTSwFQe1cI4gQSr+XbtTNkD4MQ0ERZQ99BuflBiuB3mjMQ3mAtmuxOW5xoflloGLLcFKp2703gN5EMTEt5DRyct96F7FR1uEzqXiKQWe/2KQos5KukVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546030; c=relaxed/simple;
	bh=8c6fS41FLXhzqV18dTpG5uJIEuOhALU3484z7OB2O0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DtzJQzzuFE/kKwYidUBWnL0YTiimgIBjlS6bkEf4wjHELUuaZ8pg/kw5ZlGa0S1B+HvOmq1Ekk98a+nZki/CLpoouYQO2ocY722GyVYQrVBLZNyt6e2Ojvz4bh9qxd2JeOdX0m4KHnNAFXmkIPdqpWxDNnyCoDcrJ8HJkJNvIYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=koYSZ+QC; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQIP0ZSWdOG5rNf1QYB/+A6e0viY5SljMxR0BqOwiydTqcckERzZwy8s++FEHiRZqFGAvcE0rQUGL+E3ayfLvYqWLKgfe6Fis9cH1h9EZS1bpUULvk1TjqR2FYhMQP74qbFVAKfohJkazz7O2Tv9VV6LKoiBx2P0ug5ZvseCX7JuR3tcQTEkP6v6a7QlyNGD5z4XAopVR0wgs7pqDYTo0+tiHrMoGaY9uyUutS33GvAhyLE0aqZ6e4UNuEO1WSIhnLBIz1Swpvwrc3Hk+49s5uu1xd19WhnsKcYlgNToJRNC7sO1w4nB+JOG7I6ZMvuzJZKuHL6qaZUK+QY5nIm9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vepFM0pr91zFKaVjq0cF4nADlyrwNJIbcNtyCzR3QAo=;
 b=ukFX44EmIkWjzbxDJzs6FqJEdMG0sx2k4OBSqfVQvGbWpZ4c4Evzq8sxny/h08DDPOR21akCR/SugTdGWRwwA+Mp+N7/v3Tw3xCSUdNcDtOVbc19t3nidcZpZCkODGEPRc1AlVobs3Hunr5gjV4PLtEVKoSyjeji8eBJAyqg82nR2Vv/csAOFbODRbcOKOU5OHdm8szfQ7btBrk+YRfYz8FE+vEYqCZqRBnRt8WoTXtS6Phs8cYkpdc7EVkiVlNFxoFz8Rf4WISw7x5Qo79e2wdT+rSXbePINdERt6Jl+rNbT4cG0i700a0TGUVcKes7MBYoyes89/oelvdRF2Ai+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vepFM0pr91zFKaVjq0cF4nADlyrwNJIbcNtyCzR3QAo=;
 b=koYSZ+QCB6w4fPyrASKG4lp6fu6ZGjBX+bjF6tz5dpDvty4WNIVY3gDjdjjZLnMT8DGGuGY674M3UOBE2evx7YNviOMW/O7V0LLcUIAj0U2cLeYJw9X4VmKJXMbnNoXK/jlzwYGYyisXq59B7JOxUpNf9rq3g+G3DPZEVp4FnKm1q3j6SaGI7dp5tdJ5ydevXgdstkNFUkBnfdita7i4cUBXrPEgE3HepqFQdpL5cvdBtShyqKE0N39urVllebYJawwh49vvm6bL4vtcaVPYthCl90JIhlBtxdHs0Bi7e3J8Sqzsn/0QriMPUt/cJbOBbIWtTLyPwfVQ+kw64+h9jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by MRWPR04MB12277.eurprd04.prod.outlook.com (2603:10a6:501:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:53:45 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:53:45 +0000
Date: Tue, 3 Mar 2026 15:53:41 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <me@pmachata.org>, Petr Machata <petrm@nvidia.com>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <qnq4vqznmwbgl6auacr7lkpwpzcwh2w26de22pidxhpy676f73@45s2xdpczvsd>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <20260226182223.5eb1b10f@kernel.org>
 <87ms0ufc0p.fsf@nvidia.com>
 <20260227164348.63afcc43@kernel.org>
 <877brxf272.fsf@nvidia.com>
 <7hct7o4rzgygef536al6if2jl45p32ad3tdswyqf25uu5wy5re@2ltu2ems47q7>
 <20260302160743.124531f8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160743.124531f8@kernel.org>
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|MRWPR04MB12277:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe30ff4-4c6a-4b1f-1e5b-08de792c4923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	SlcjjwbfvvELKp8JPgJ8BmS/3WLfIkXc9/lLEHkeZUPzslQt/T6zELEqPZyxbN36efDjwYAE2dcU5atwqjmxdG00Hl1cHnoUzeZEXuXUCf8nyzY9Tfp/DCmT7AT8OorOoxpYd/0iaSAi+kheZvEFypwCbWkPQhozbTleW4MgQZHvXs+sXdxN1xY3TQiusOaJv05i9OKf7gaM+MrhQQGaptt3x75UxoGaN+CJsRkWlnnhu65Hl/wGy5j7DiO43FFmgQQ0dWCEZvkCEyqwL8XXCKLtTOvGCANdCAXU+vgdozh6ZyvIl2gTXbqorLepZypo7Zci/0trjkOYE/YNZQS64Hv9Tsn/HhO8dYhI9sPk9hxZuLKAiHP7t9udnvuNwBYA//ixQce60I48zGRmgj1iKrl2m/0Enebhc++UV3dVW6hTyuXN+laScc5pfIPAZw4Rl2+HgKpA2GpEA35/0ISiQLBvjfiLB1Es4+RCCLp19W1IARjd/NS1Q8ycaKVZVwM4YpAYsUSJCp+0GJgDofM4odwG9KySek/1NwEa0Wm3p08brkDUCFKksAHdh+kC+Grcy7EURVp3en7i4A9Am+sIehGQvUCPYrs+j9SIYzo6y4TsLeDNJY2277LTm/l6yDyb7Hla8JHjwBDkU2YxwJflhCRQRj2MU2KOCpT0Ln55qIOGZtuRsXPRbwT1NY70PyQyhEHsjaVMg8uFlnv5cXIez+Xhsd4bY3AsxPgMOfPEO+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PkwU7AhMXEkJtDVnQf8blFx6lqoFBNufCIzJMmDPMwK11q0hYIt3XYGxYIcA?=
 =?us-ascii?Q?XQcXmhiZ6j1DonOPfITHJ4Tkse8YG4N+egNQXIdAMWVrP3GbFJbRtVjJN52l?=
 =?us-ascii?Q?zGJNOxKNH30iDBA4Tcjkv6mRXMAUKNAR6D77yPse0JHuRGjY4qJMB9Wl/Xqc?=
 =?us-ascii?Q?QeAsOy8JcxCNrjre9wsTtyfLJj7woOLNUU3wMibycOvmGtvS6stZUtBgVFUj?=
 =?us-ascii?Q?fZdsEus4V9HxNuVRXGHTkY630tBylumFXFDy94ERsCBxRWX3TNFe7bhTH7+c?=
 =?us-ascii?Q?rTXTzc7AD8h6J8QUFnqNMyZ9TE0jdIg16qhvaiO0nxSmf5qe1OV9FulHKmO9?=
 =?us-ascii?Q?YWf/++I/orponpViLZ5A9x7354JZCz9TLDQe6PKjCOIVUjWJv8sltQmsKMVG?=
 =?us-ascii?Q?ykRy8Bj6aUPBeAXHn4pJjYwUzwlB68RP/j4Og7CXX/hW4kLXKEJstFhz6pvj?=
 =?us-ascii?Q?RQtXF9JJMhOSg9obk90zb+C7IPilCQm51j5J0J7REgu3lros1FrWsu01MKHI?=
 =?us-ascii?Q?JOsxzGIuRR8jBXs6N/Ol/XDl04hytn4lIvPI9iU6aTZt2tYbbb07ZjnQd78A?=
 =?us-ascii?Q?LoLhQ8eP36s01VI6p1RwGc010LDO8RNxnDu07YMwU8sd+b4U+fPatoojOmcG?=
 =?us-ascii?Q?IFnsBQudWAEsrQrmBHLDY+7iwCaSs0DU+nsTRtxSrvrQ6QY1dORBxXH6KN1+?=
 =?us-ascii?Q?LE2AXui0UKlnRp5jUG2WNiaipkaTBOHo5lY3SOWDyTMwTdp4beKemutLIZgj?=
 =?us-ascii?Q?niKV7V/lXTvYcjxPGlsrrP6eDS2gmHbSrclZlMNxsA5X+Uf83gAhD7rGyV6R?=
 =?us-ascii?Q?I3dOk3+AuMfMAvloIJT5+s6yB18HMqZ4PRln3v0NkjOD9CyHbj5HRCJwBF9F?=
 =?us-ascii?Q?O04gF3ZqKBRP5b/QWytgXXPVT1oCaYoGR+RbS0nY7jQq03remBVtSKM+vHUt?=
 =?us-ascii?Q?V/JRn1L/cZEP83nTR86u0zCRNfaIzr1G6rXwygk9bUJoILUWapLDhNa5kT5p?=
 =?us-ascii?Q?A46OXXyW8azJe0H9bZaa6UnUW/VJOpJmyCDkE5v/mPFlNqdodrOzE2gbhfox?=
 =?us-ascii?Q?lXS6rXAOxewNNphHtmvBGTCSJSI4XAYTL8e7FrgIcGGCSppQlXoPsfd5tFki?=
 =?us-ascii?Q?wEAM7Xn3mc/zurwgd5kzFyPhUWisHKUcaybIrSTWsqHwman5kz9xloGsHgWg?=
 =?us-ascii?Q?JkBv37uuP8hqUiaFalKXy6nGqdvEkl6hDH6nlc3cJF/OL8xMvqGI6Fpqry9C?=
 =?us-ascii?Q?ijzs7ppGhq6Ef6TGRuqjWUwJiqCLjRmKSbpHUbeulv7THRW8X5+Gx84CMLyc?=
 =?us-ascii?Q?VMDFir3LTyFBiMlBqL+gF9KxKycpEZuKj7wDoKeNp1XwGpX0HH7n73SlbOw/?=
 =?us-ascii?Q?DgccQEsaSCBNJAGIR7Vjg26wo5UBFnq+GfScnkAPDUOSuSBNSYi83hCm9NoS?=
 =?us-ascii?Q?bMCXCv83qMl0M1XZ/y/1dhd++FKM8H586jwtaWXbSwAwTMJFxZ5TtGcUpyB1?=
 =?us-ascii?Q?kYgqyuQnDEIBiG/0lOYyknuI3u787dnH/xWAOtCwsRJKp8pE18AxEd3BLcNH?=
 =?us-ascii?Q?oFe1ZCWEJ46I408e1SMeW2Zyvf9BGl5LTTTK+d9JOL8H3uJuvA6kwmWFGBqt?=
 =?us-ascii?Q?h/nOhagmjNiUONPxAY48UKb221thJkbpNG3D2in0HwOKOPNHujLapqgnE4JV?=
 =?us-ascii?Q?INadMXxde2Z2ndFf8D8w3gJxWBToF4uAU4PC1U8pnRRYDXNfcElJS5G6tqUR?=
 =?us-ascii?Q?/6HB4nk70w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe30ff4-4c6a-4b1f-1e5b-08de792c4923
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:53:45.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmVw4GMaYzoK+eqnCsEw9RhSZ8KCdYlvHSbc3o5zxs9ohcQH5euVZczsuFkum3Mwq31jZaajrofEolkIScasDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12277
X-Rspamd-Queue-Id: 877951F1035
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
	TAGGED_FROM(0.00)[bounces-263219-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,ethtool_rmon.sh:url]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 04:07:43PM -0800, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 14:11:21 +0200 Ioana Ciornei wrote:
> > > I agree that adherence to the drivers/net/README protocol is valuable to
> > > some users and would be good to uphold if reasonable in a given tests.
> > > If that's what you have in mind.
> > > 
> > > There are going to be tests where it's not a great fit, but I think that
> > > of those NUM_NETIFS=2 tests that we currently have, maybe
> > > ethtool_extended_state has a good reason to be obstinate, because it
> > > sets up negotiations and needs an extra unplugged netdevice.  
> > 
> > I would add here even ethtool_rmon.sh and this new test that I
> 
> I think I already told you that ethool_rmon predates the NIC tests
> and bringing it up in this discussion is irrelevant.
> 
> > submitted. If you are running with a traffic generator on another board
> > then you can no longer check that the counter's value is as expected
> > (with a 1% tolerance), you can only check the lower bound.
> 
> 1% tolerance is impractical for any CI with high test count.
> The test will be flaky. And I really doubt that the 1% tolerance
> is really necessary to catch most bugs. We're not trying to validate
> silicon here.
> 
> > Additionally, if you are using the same single port also for control
> > traffic towards the remote traffic generator, then you surely cannot
> > reliably check that counters that should not be incremented are indeed
> > not incremented.
> 
> I both told you in this conversation how to check the counters,
> and written some existing tests for counters.

Judging by your response it's clear to me that you wanted to transmit
something that didn't actually get to me. I am afraid that it's not
clear to me what exactly is your feedback and what do you expect as a
next step.

What I did get:
- The new test should work with a single netdevice (and a remote
  endpoint for traffic generation).
- The test should not check for any upper bound for the ethtool counter
  value.
- The test is expected to follow drivers/net/README.rst.

Does this mean that your feedback is to convert the bash variant that I
submitted into a python one which uses lib.py?

If this is your intention, what is the plan for the rmon statistics (or
any drivers/net/hw/ bash tests that pre-date the README)? Do you see
those eventually getting converted to lib.py? I am merely asking so that
I know if I should convert them or they are to be left as is.

If I got this all wrong, I'm sorry.

