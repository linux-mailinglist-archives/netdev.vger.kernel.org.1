Return-Path: <netdev+bounces-261382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0kgWN5BWoGn4iQQAu9opvQ
	(envelope-from <netdev+bounces-261382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:20:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319D1A7644
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9898A3048757
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC03B52F5;
	Thu, 26 Feb 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PKHHh8Fu"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32D37417F;
	Thu, 26 Feb 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115514; cv=fail; b=n+5wDzJox/lmKv30+VLgEXXTTxUA4qveyQIUcRf5tkkVl+FjJQOOVNPao3T7ZnO+qAGVCyvBhI5oU8TmoCDcolAViTqIjAvfif5sL7lIPfFDCptOlvR/Cz3E74B8TxYelyLAym5WPqeqI5nL161IoPnThTRC1yIqpN3hf0Eo72w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115514; c=relaxed/simple;
	bh=bwmmL7u6RneMIao/14UfAhqnLhIweSCzCAOX48UdxWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZ5g2t3+SMj9xnileWv+K59po5WEHcopEnMPIjr0uAHJQF/rBiM73Ssvm/J4hUmX1VQ/KWecXKW5w1rM22YR6dQdJVTykPTJ4OL9Msja8PGrXRDHhCBlqtGX8IbZJir/qQMF3d0ZpeJwL4QkqcMOLyS9V0//mu/vCNJW5yww1VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PKHHh8Fu; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBqrC7IecP4wpS+4Batpg0aguzAiT+U4evRZJt6omJ4yCeAfXdVjeu7/zFYeWrg4+IM9JW218mL9T89hRSBC3b0vF2e2pIasC58QyjTEm7V7lIXCDn5FbcQAnIsc2QbBE/QYTCn2erFEYcEZX5dANdsRkYSewyQPm8FY/iToUNV0rd6JPeo1kbSxB/biMhEosi14PkLsJElxs7H4hq2gQJX5z/NDKjLK6k/R1k4CunHIbEaGvLxC7V4z+e1UOz9R1yC72RPwfI0GjOLWr0zLqJgGb/iibQtQ2aTszUBpCvtCAMQmrh7LSRDuR5vYLbMFwABiWf3hC9JmskiZ+PgPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=162g34PkRBU0Y7mSUEB98y0UD9rIv4cGpU+OO7Qbw9w=;
 b=NDVJKZjZyly2fU+0fkqPj1/ZV/8QXM3TMpriFsPxylUdT3ajvThxTp7j47cWBFw0e2Vy8MJCGrRpr2dEzHYu9w3gMPmJ+Q7JdK9TfoENGMItpXTKiRb+DdjoA1gD+iKCZHOikGjW085BGeUosR+9mdcM4zuI3shP2kWN3DjiLJg1a7IiR6TPJtwsl8seZJ9b/k/Ml/ibBOyyyugwEBpYvaF5TyTnjcGLKwanaZJwyZu81BXDBkyHkOfYHgdi64hzhvVrfd6E2pEi249d701VOEYTPLVG/vdBzI5EVYwgeJufrG5pL75nPVu1jS6pGgPqzKxkOUrycyCK2EbboK42+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=162g34PkRBU0Y7mSUEB98y0UD9rIv4cGpU+OO7Qbw9w=;
 b=PKHHh8FuqPwdUMXiIZHFBmO0eOnaBFxPKYboOUvBK8qFPpBkP1NfkuiRZxowfL0GHLiXEToH3xiOCP+dcDjjvQu6Q/iaMgJRDVspxwVVJTypeLFzNzS1ytsR0O42hZTwbQOdfZxfBsTpcU8V+KEI77YXi637Mh2x8WbAVb0JxpZs1pFjyLxTX2cZrFkXwhv5cIrAxnP5glAAbvYYtnCYfsz4EiGddaK2MK0lfOCd+HjOgyG/DUxKCUx3VkxakJ2i4A7H3rkqL6yRwktLnocOJsRnri3gDzga03M0y+RLLKHT3NJ3CQqkGGZe3RdwU963V8ojVmZWHukfWFTyeSLh6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 14:18:25 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 14:18:25 +0000
Date: Thu, 26 Feb 2026 16:18:21 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
 <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
 <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
 <031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
X-ClientProxiedBy: AS4P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::12) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: e16d6b83-6067-491b-44d8-08de7541e79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	oCkGOaZE8TphL5J14WFK5PBSZBX4f5MldogSRf3yTVC3YMmxV0kz37g0jpug7qFL4tZjh6hgy0de/xU9tJdFn+clnYRstesJqcvKDFNx7yUQO4snfMi4ksB9KehwV0YO7C0lxdR9I4sYanFgqHwYtiv47hE6a0juWgAkSfpKel63pFkOEmoseKZKJS5ol9+fnezj7+jQdP0yRvLKxQKAiVJS2HsEH62XuSa4l4h9nRr3r58N2E1F2WBI0rBTRyMVC81rGETbz6N0fDBgjvFNTGyUwHdt5avmMOx2kHlAB7qey49Wp23sAsPs64NJ67QAG5C/jUC6WckMd7tuZHGkIAgIwKLVIMs4bakLE9QDIG//HitjxTfgqbeBOcu67qtbcoJjHWbT7HKtIa59XXttIl8APaDK/HgPWMj4jgsUdixzSZwGq4NnPendUHkgrXJMubU7RgJHaU4chKYBLbXkaRpR4ZlWE0IjbsxNuitBlhOuT9jPfhkv1mNiYohqo02JCm95UlXGxEDtbGnOIY767L/6EML/j1OUmkZwia4MpwhpXbTjol1lVrbdm1aeaVymLnp9Y43yp3OKvFyEDkMk6Kav/z6Bs7dhLvtDJcO4hNQCa0xsVSvK0AMTNj/DpQCRkm6ci98JfpxTZo4wHe+D/JQ8E0YCUGm9CxqiUdmzPUtGiaNND/PhlJgy54lyt8qV7xyiE9p1qlQB/WwvCFTwZYUVp0Fh5jhq4vEKzJYwx9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PRidVQKc16B9BK6E38vTSkkzP26vQ+7oEj0BH7ue7hOdlXrbwVcEFZqcLBET?=
 =?us-ascii?Q?+akpCanfpynIDWltHWWJzhgtWNLSLhwgIqOa6QxRQT5XE9wh7dDFkD/tTbJB?=
 =?us-ascii?Q?srWhFwtKQ0HLYBHDtvDMOT/SUJI+okLVU/Hlw0fQ1tbo1kppvldK4HFh8yO0?=
 =?us-ascii?Q?BBG9Smnh2mgVbY1Zi8CA1qV/5YDUI7EhwqvvLhER7flmyIPgov/IitlLFZxX?=
 =?us-ascii?Q?I9VaRGEuuP4vPC8RERwcDo2b0RV/uff2SpXsRrW2gJr85uy7Gr370U474fvX?=
 =?us-ascii?Q?wfNYA4xd7kiQ6DSETN2kH7wkT4d99xaKdVSAZlvZRu9GAfbQt9P925pz6YLm?=
 =?us-ascii?Q?+8r/XfgJu2a8pEX1tMbPIui9njKeXgIaX9nEg7pORFLOopUKhHGhtcgptwKz?=
 =?us-ascii?Q?l2qewrhRaRuL/HpcaHEaALT75HwTucmsyaFwOAj/v223jDiePOF27DUedq0V?=
 =?us-ascii?Q?g9Ac1Vo/iU4mS1v432wIg5o2YmSZnuTV5J0VlOxXcdQ5xLm1RGFf/oQCMnVm?=
 =?us-ascii?Q?BwKCKhRa1oHlAFDeytbB7ljHrFLwvS1Hy/kdcWQnWDURfM6tSeY4Bz+oJo0u?=
 =?us-ascii?Q?LbGpnGIifDL63zY4byH9RiwUcUZFDLCDoOVYvDYBtzKR1q6X5yokijd8cex+?=
 =?us-ascii?Q?kwivzZNd3PJLL89TLVeHW79BPgvrgJUfZKzMi9rHHT5T2LnkezGlgPfN9W4S?=
 =?us-ascii?Q?j9pJSXK0G2QwAC+ZBES2UtRNjXyGJTIDTrp5PAvOuQM46yn/aqLNm23r7KIE?=
 =?us-ascii?Q?MIqXJoTI95d4ZNWUIGXtVCxWkVtTD5CRQM5YfxbyfXTvnpEMCVNYOMsqPj0K?=
 =?us-ascii?Q?yoORdwJlLeRHXyZ279u2Zd12PAOthhlOh0G5ct5p4AuoYJFseYvclqz9Hajz?=
 =?us-ascii?Q?zm7sDJd7X7if5taeFQKpPWpilz39CAjDa+h9l3TJGSdgKTnuXR9eoaJc2MPN?=
 =?us-ascii?Q?p/LloLDnNuhchDfQs+jlPNB/3FUnEZuMT9kYWH6GMCr2fNQjUaKerBXmej+h?=
 =?us-ascii?Q?UpLVN52CTg7DOzXebaw8VB4D7hW3xp/2y9I51450UCUWH4lw57CvXp9ISdqZ?=
 =?us-ascii?Q?07O4JtqHlis5+28chQR2FrsFrc1DnwiSds8mIZwD7itT43+2P6/4jYUcYlS4?=
 =?us-ascii?Q?QMj2DTodP/MeFjIpfxHtE7yokHJeu0cZwveN/M2ETB2fBl2FtNJU98J5P0KO?=
 =?us-ascii?Q?mOM4pqthSUqhS/KgztiyR9gMUFqB0ZvMaCawG7asD2SphMXQXT9Tkoy0ZzpI?=
 =?us-ascii?Q?BT7PQcV0RsYnV724CpO+B2s8UwU74mlGKUBs4XTX0OcMOFF/gZ0ZwOmvZpcz?=
 =?us-ascii?Q?hkfAJK6udlVvoU2+wCBeFnX/j+Aoo6F3TzgDRPjfk7CMboSi1EoKAK7KwiEq?=
 =?us-ascii?Q?pDDizlBsGXaZDYsU4ZVl2u1i+qwxCraRKhogp/U2wVDnHRrDWQnbxiwf6Xua?=
 =?us-ascii?Q?sXkINAAkTSc0740zAPxujX7GCw/auHyvKciZzMx2epetOGUeYRrv5I8ht/ZG?=
 =?us-ascii?Q?oBpFkI4X+y1fNJIqpEL/oA7kILXROP+9ocTIN7e9oXfYEgYf3wcUUiZ9aRuC?=
 =?us-ascii?Q?3FQNQvQdEAzIQKWiwXmElMkWaCez08KHEaU77pAbtMZuzwl6o92sj460thl1?=
 =?us-ascii?Q?MZF+n6tOv8rRtYQvrbB7dXBGKtF75Jkv0yHCNany3fFwN/yxtKz+tR3d8eOr?=
 =?us-ascii?Q?kH3Hf51D5sj34r3wTyrO6vVuW8H+P63o7pjmbQLPIz3Tuek19Nqf4/JJqodM?=
 =?us-ascii?Q?qLwCvcGWAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16d6b83-6067-491b-44d8-08de7541e79d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:18:25.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wVFPIvbDAiQ72eU6lbwp1Ykn9tdAF4pfMWSw9fk552S6hJrqHudUfN5U/Jh2rPBC2odTTGsTSvwWnEc3IP58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-261382-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 7319D1A7644
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:31:26PM +0100, Andrew Lunn wrote:
> > I am back with a bit more information. The counters which were not
> > checked in this version can be grouped in two categories:
> > 
> > - Error counters such as:
> > 
> > 	u64 FrameCheckSequenceErrors;
> > 	u64 AlignmentErrors;
> > 	u64 FramesLostDueToIntMACXmitError;
> > 	u64 CarrierSenseErrors;
> > 	u64 FramesLostDueToIntMACRcvError;
> > 	u64 InRangeLengthErrors;
> > 	u64 OutOfRangeLengthField;
> > 	u64 FrameTooLongErrors;
> > 	u64 FramesAbortedDueToXSColls;
> > 
> >   I did extend the selftest with these ones so that we check them
> >   against zero. I ran the test hundreds of times and I did not see any
> >   problems.
> 
> Great.
> 
> > 
> > - Collision related counters (not really errors):
> > 
> > 	u64 SingleCollisionFrames;
> > 	u64 MultipleCollisionFrames;
> > 	u64 FramesWithDeferredXmissions;
> > 	u64 LateCollisions;
> > 	u64 FramesWithExcessiveDeferral;
> > 
> >   With these I don't know what to do. Theoretically, they could be
> >   non-zero in half-duplex circumstances which means that checking for
> >   zero would not be entirely accurate.
> 
> How about, fail the test if any are greater than 1% of the number of
> packets transmitted/received? My _guess_ is, if you have 1% packet
> loss, networking is not going to be happy anyway. It probably means
> you have one end doing Half duplex and the other Full. That is a
> typical configuration error you see causing collisions. Not that i've
> actually seen this for maybe a decade!
> 
> Failing the test, with a comment about checking duplex configuration,
> seems sensible.

Seems reasonable. Thanks for the help!



