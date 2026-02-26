Return-Path: <netdev+bounces-261323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKfCJmA6oGmagwQAu9opvQ
	(envelope-from <netdev+bounces-261323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60B1A5A12
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99503301378A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538922A4F8;
	Thu, 26 Feb 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O61Gb5Ac"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DB1D88AC;
	Thu, 26 Feb 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108382; cv=fail; b=dC2wcSenF9xTxlLvkDeHKtsQKWtb0Ux5ZQWBJ9nM31S7LXkmC9CsVDI0YN/ttwDIIa+dWhq4PgAxwQXbaGUDiLudf2m/8TWXb3oamQUN0/2/pxbXi3EAPczmnlbDoPNP1/Vf39RWxBtB7cLdUjQlWjS73x9K58AvOE9QEtA0nro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108382; c=relaxed/simple;
	bh=dN3E1iPGZJJ1b7CPxlWu5+08bPZfkAzBPU4GVLawZqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERo3h4kWUUKD2on950D6lFXuIWJkmBRfebi2+HEk34293eIMYQJUSOeCSJsKz8Vc/XMnOEuUMiHtWdlAyoOOQiV259+0Jr62TZra/lSUw86wgsoGV9/YfREFNfzSKPF/p3DZhsykKceXwTuwd/wHfDcK+/rJxihxK2rgUPFOk0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O61Gb5Ac; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVnrt+m/jyNftRno8c/XccWw0wBEyetDty4jXB7j/b+2Z7S9gc8C7igeeMNNRtKV9v3BIjqENyIGDZOJ861GdF079WZw4oiuNM0Q8Uuj9s1F9/7BQyIcxXLA8GMzPcVHoByA/BZV1Q0m6FpYcBVmw0K/tUJOgIjB5pWk8VtqU4f5Q7ldf6DEdm/Bl6shjQqHYEsdJru1Nu+przY4htNsEh0gueBOltSI7iTcMMJPv0s3mGREGmq+Lb4hWkQyupa5Q++L4ZnXglnkr312DV8XmJ7SJkMMiRiPVQYmmFxVAVcoOaX4e6xrRL+CDzrsIEjm+Kqekh6KQdivkrgWCxYRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky4PjCTWCve2yauhbJ4UoBmmcSL4AhdMK6LSmDT84/c=;
 b=KxFVTMN9SLv0idGf9GULANupeywGMTQ56gw0hC7fhpFwTDV1tJ/JCRE863v4conWVMqV1tw3/R6IkMDCoxWSSCvR7pqPGivCrl6r2dL7HRL3zVhcAn4bAqr4SQLbMGK/wMoHOskwhzNRh09uNW17KJChh5aIpQcg2uGk0jEMFq19lpPj0R4EfmzVfXhr07M2Kgviaikurv/0AlOPGetnvYS3qulxGaD4d1aMKj1oAV4mitF08i0z/GbEQDtEJBXD+A0RvRfPdnsfVRK9u0OMSW7SrY7k+Sy5RcRwXYC3xNtQUkG/hM49Z+InG6BsEe4E1aLgqmjkanLQ/P76zuWtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky4PjCTWCve2yauhbJ4UoBmmcSL4AhdMK6LSmDT84/c=;
 b=O61Gb5AcgFm0TXxVEbd7Z/YKzR/KGUIu2SN/cAa8ch8QOA+srLzYPaHqTPfXQYNKwFdmCvKEtOJK055Gabf7a8bbZE6ouIsZulrMxBWuxbd9AC51UDyt7oWYZSB/spbJ4OUCG/ayrOE3TsdEJXr/PKgIQJGnSgIPe96RDCkiosW901oD1yvxQwP7+UxxfwAoGVyLGY96fsBIVT4hIzoW1mQzT6ArjWru5CwbtCdsEDDbJqqWsUxrIhVqqv+8bFIFTVYciWelxVU/2yjZ5PIYrl5dVbIyrAFQd26stmkPGj7OrU5ASC4QnzsET/NsMupLCncf1oD3hVoJhaCTyZRyHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB8659.eurprd04.prod.outlook.com (2603:10a6:20b:42a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 12:19:37 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:19:37 +0000
Date: Thu, 26 Feb 2026 14:19:33 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
 <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
X-ClientProxiedBy: AM8P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::29) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 865fec6c-8184-40d9-be3f-08de75314f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	xJXzsS9ZGhTxBoE4pqGSPcuAlUoNkuU/fkDnNTndzM9HCgvfTTra5HGfvYYplFInhwpZEei+eTLsIvYWjnmh5YX1v7dqaoMiHHZ+hUR0mpzQWIKPkSvGUCFTF/lPNfZ8Yi/x7iSMF8glwm//6IXWUU3BYvr2AGboVxeyfb5h4Zhiq3ZaC3qjP8py+Ge7ggNOsPCMEBD7Bh0uXT3CfMzQMHFuh2DGN6vr5cOLY7b+6cPjaceIpqL6hVmy0aEJROJW1MpmTFuYTVQt53dIXiGUbDpO9a1dTmlEIoZEuyOm3g5qmkYLX9UTnVG95ruR5ZMHVGVut8632Ysg8eg7CxPn3PAJW6d9lva686HFTeO4zRCLa/8EeGSOH8yQBR5DK/A8BiH8x3g/Zd9Cz6anF5xFBwjtFq3iO/OVsGGkEvEerQzf9viZJR4JyE5zTIbsmXdnOYFtB23dgh0uAS3HD2/BaS9QRhEbZ1dszC5O2tCsOqK8K0rDWCnLaNKvbNNBAltU/p5qm8oxkUiekJRECi2rRiPNqrjuNLzAG+SYIWifC3MNtmZu8LwIw+UEu3zcj4K7n7WGZYNJZi0yf3ucNXlOO69gasu1YyN45KjxoQ0jqgqt60vPhLJe54WYNvqDMBpU8uiKeEmSGNdHZXtwUrHtL1P0mcb9YJNRKur3t5pXtRMHO98uw/WcS1f6Q57XlR8g/+vv3VZVWyf4e/5jw1Vauw9DoA+bFZcM/T5XR8KTmXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsExRBDDZ2URA+jLLtePnurfH3t4QluRt9Pm1ydbprTtg0MxeECUKfBd4xPr?=
 =?us-ascii?Q?8ra4xliXajxoB4mZbRCOpLxpUEjybbl5KPKHzeuJNU5VE9cD5gBkDJ++vF6J?=
 =?us-ascii?Q?Su/SkoAfFPxTPPdydPmkrAWOjPVZmm4u7FFfDxgSVEwqL8Uuo2FEa6qAkNre?=
 =?us-ascii?Q?9PlQzlvRGuwDrz5iirvRzoNe3VPh1AgEiTJjtKt6k4DJNaFbWgJyx194NwN8?=
 =?us-ascii?Q?KHTxR7vqGz1NT43tNpAwwrfEEeqSkf29eTVqFVnAjLn/95MhayW11uKxkJWx?=
 =?us-ascii?Q?Fy02sGVICdSs2OfMs1o3fE22Hxysku/hOpvEIUWblBTo+YAbFqj9L+wIgm/y?=
 =?us-ascii?Q?V+iDro73Y+ClQi7LtrwLmoe0HL3bx27ZLCIUP8X2yuUqaOo/qhjYvZc4PnGM?=
 =?us-ascii?Q?kpYTuiQJgpLaX53tbbxsJU9tX52Bey1WhQILraRjQzGAisSVopkSVKMrIm7g?=
 =?us-ascii?Q?YP7g459118OszK6KQaPV3OTQ+bz2hfxiiIOuBtDFv5yDSDDT1L3BCTelnssq?=
 =?us-ascii?Q?CXQn3h8cmahSGj7MGkTithXYish/DoXZnzdVdwGi0PQrV+vk7hL/ikpoNYfM?=
 =?us-ascii?Q?fJYMz6ucY0fAfqFAdy2cZ1RScUzYyWhrvdGSd9PB+l2yJ4YrlDA5/IHwQAMg?=
 =?us-ascii?Q?zbJtfwaefMsE8ECgBtqhRBgyr7vIuujkR0LaqU9RqD/mCkskuOxVwihWjOd6?=
 =?us-ascii?Q?0tuxOJqFttH/CUNaYJzh5+pNABFdC9X9TVwGCbcs8cjsXdyyWAvV3gws1eSN?=
 =?us-ascii?Q?IyuIuXd4BupteGxzWC6hzSfJyj7MnWtUnLhZQzG2vybR+5cgWwykM5w9JSpI?=
 =?us-ascii?Q?U7FHNoxQhGJz7tqKVFlDCSoye4AL2WgVnWsdh9c3432cjpEjjSAkmCUUxslD?=
 =?us-ascii?Q?D3ujvyqrEKaJK5kRwRQGhTTa18dRpZU+ocBWcwfkNU9ULfyJTQ510j6rkSh2?=
 =?us-ascii?Q?t/+6q0mQB8pGM2GJ4QpcT2nzbQQk2hKnC2s65ZpeeoWfFF65MvgXxi660NjE?=
 =?us-ascii?Q?mETmR6+3oA9vkJEwypo7dy3po+YV1X/2NH+wtHxaZnDS/FPUT7KcaOJtSz0B?=
 =?us-ascii?Q?2xCb5cimukKM7HugzJwO+KuwCbdYQtiPSqPLxS31spRbHcq/48X/lsmfp5Ym?=
 =?us-ascii?Q?dsuqXi3fw9ItpaxtCvBObHCaRSHy+tqy7h8G103IM/MTKk75tBx/xSqJTr/H?=
 =?us-ascii?Q?yIQTmR9T4vYZei5xdWBaIj9G5g6hs784BMBbgIVncfQPUbt2qCz2qGSSBUr1?=
 =?us-ascii?Q?cRoBB64E7CnxirB2p+q1kiziXwd6DCmDUZBO9zAvFz77jMhitqiO2s/XLrpC?=
 =?us-ascii?Q?7/KXVGh87rsoD3NqzWxUApFDlH6AbFtf5R0cbm5Pw5v6b3lGLB2XLOQ4Qp0s?=
 =?us-ascii?Q?/rgRIjT5SVxuyaevf9t2ByuuLKNqmNlV2y6OQ3z+PKJKtPunVpYl1s8850gO?=
 =?us-ascii?Q?NpBCuGrWrChFhcuvYt6Uv5Rm6vG2ka06UELkCM1p5tDTWBI/QlY9OB1bp7XW?=
 =?us-ascii?Q?Ezg5FpxSWYLQ09mtGv2Y7JAbwKJHJqSjYHqED33LsxJRTaauRrkOOKld4xcQ?=
 =?us-ascii?Q?k5d9aTD0KBeilGQmuC5jDDviVohGLUY0ufZ1DWDvoHl31AW5ZTlNgla/Lrps?=
 =?us-ascii?Q?4GAQ1io432kwp1adIoHrm+7f4u/HSYBu+AIz0wtyAFDB5JgOHVUKCoj+WOoe?=
 =?us-ascii?Q?JPVGAOc5S3O2sAh/8U+sCohpIPudAxMPjrKHNjumte7fOCj3SHkzNbyI3cWZ?=
 =?us-ascii?Q?hiN1zGoXuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865fec6c-8184-40d9-be3f-08de75314f03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:19:37.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5YwmNVDGRlyxc1YDtriSTd+n6m95aWAPAhctkZBnh2cyTwB+U2/FKjy9fVcR2tOpQxqkv8bRN9tq8giRk4nvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8659
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261323-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC60B1A5A12
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:03:32AM +0200, Ioana Ciornei wrote:
> On Thu, Feb 26, 2026 at 12:38:58AM +0100, Andrew Lunn wrote:
> > On Wed, Feb 25, 2026 at 05:06:48PM +0200, Ioana Ciornei wrote:
> > > Add a new selftest - ethtool_std_stats.sh - which validates the
> > > eth-ctrl, eth-mac and pause standard statistics exported by an
> > > interface. Not all counters can be validated in software, especially
> > > those that are keeping track of errors. Counters such as
> > > SingleCollisionFrames, FrameCheckSequenceErrors etc are not tested nor
> > > included in this new selftest.
> > 
> > Hi Ioana
> > 
> > Thanks for the test!
> > 
> > Do we actually expect errors when running such a test? How many times
> > have you run this test and seen any of the error counters be anything
> > other than 0?
> 
> No, we don't expect any errors with this test and I didn't see any error
> counters incremenent in the tens of times that I ran the selftest. But,
> to be fair, I was not looking for them thoroughly through testing.
> 
> > 
> > Which do you think is more likely:
> > 
> > 1) A real error happens
> > 
> > 2) Bug in the driver so that it reports a value in the wrong place?
> > 
> 
> I would say that having a driver bug is much likely than, for example,
> having an FCS error.
> 
> > Maybe we should check the error counters are zero? 
> 
> Ok, I will extend the test to check the errors against zero and see how it behaves.
> 

I am back with a bit more information. The counters which were not
checked in this version can be grouped in two categories:

- Error counters such as:

	u64 FrameCheckSequenceErrors;
	u64 AlignmentErrors;
	u64 FramesLostDueToIntMACXmitError;
	u64 CarrierSenseErrors;
	u64 FramesLostDueToIntMACRcvError;
	u64 InRangeLengthErrors;
	u64 OutOfRangeLengthField;
	u64 FrameTooLongErrors;
	u64 FramesAbortedDueToXSColls;

  I did extend the selftest with these ones so that we check them
  against zero. I ran the test hundreds of times and I did not see any
  problems.

- Collision related counters (not really errors):

	u64 SingleCollisionFrames;
	u64 MultipleCollisionFrames;
	u64 FramesWithDeferredXmissions;
	u64 LateCollisions;
	u64 FramesWithExcessiveDeferral;

  With these I don't know what to do. Theoretically, they could be
  non-zero in half-duplex circumstances which means that checking for
  zero would not be entirely accurate.


 Ioana

