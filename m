Return-Path: <netdev+bounces-273157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN7BA7NtymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E135B176
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E323006B35
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE53CAE93;
	Mon, 30 Mar 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lg3NDHIA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96033CB2DC;
	Mon, 30 Mar 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873728; cv=fail; b=d027fqRVn+2Vi6FHNs7DfWKbgFIs4eakM5Dr2MfZYsKlHmFtdnxlrEFCTf6JZUaYHV92Zp9YbLFvkJ6qtDQYjDZm2OpyMwYQGWV1Q+Zrc8ADZQOmog+HNZ94ShqAmKYbwYODmS1MkIqP7M5H4RAYtpDPGCmVUJIEG0Av9z1d2Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873728; c=relaxed/simple;
	bh=ENeATLTfVN7US2xxJaqe3ZEyGuyicAsy3YvS9dO7t88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kunpZXwRgpLTcJD91tMiG3TOHBLDJLV033AvQWDu2FgesMIXfMONVGv+iCw+rbodRvlWBaSYp25IXukW2OrDeq5TbJHGXdFvpVviH8RzTgEwl6CVcFh7toAlNlkCvEobEl8NkYYRcHWZBJfK0IzE6m8p1lSLOxQV6Jb9JQ6+qNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lg3NDHIA; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyJBEQ8oQEDsSxE/EEpZOO6XHspfz/S2AjCzqWK3gtO8XVeC9EzyOXNIE2iyeBc7q0qMnsksJfiz2OxeDCyDUXME+VoioEQjXWDrm2PRUp7o8Y+FYuMaqOfvcJy28Ui3xsX8/v/QGXLpO9Edlj3Cqv3XiONriwn690SbkLK1/Vt+A/EE1M6IIMGLWjtacvwf9LixrSHKkOvrj4PeRu02CZzq3k60o/zdiWIY4y3d8d2YLOOHaFF9kMgDcF3UuZ16CJAMwNiov2Kepf6bsMpM5QuhGnFPcnk+ttvesm9ekEBjT+3BbsDQwxoQEyDH8B/e0PHpikADYB45Sh+LHI616Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsx5ABNqAI/Vd9Jl/6WgocPdhQuL8AmJswXxrY/9oUo=;
 b=VxjlcJj09RH0xZibp4qIbBitBF66XL+oK2XiWzC8HKHNTaXggZLFcQcKQm68mWu346jrUiOTqD4c1iWF+wYPaS4PoNadDpbit1BQ7JMOXcYHaTf3efzJG14f2piIGtvUZpjaZC3u2pAWVoZ5WxYTvDYf2g6owPG5QYcPzCIy04GRWgBCBWsR684hHLnaGKsVddnkKHJzEesxqIhPlkz3UA+ObrodkY9vCht8upcK3k5NO1gDwv8EjkIkWpmLp861szmdYfA6TSBu8CQw7/O4rS3u6yNKMrxR6sptE4/XJ6aLo7lh2S3QwrNi2HDn+ghDj5MHorNj/KwL/voV6XapZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsx5ABNqAI/Vd9Jl/6WgocPdhQuL8AmJswXxrY/9oUo=;
 b=Lg3NDHIA3gqge2I/ZqAWd8nwKpI9JEhkJhgnZxOwDR3NNXqYpB1Mv+Uc3iEGbrIjrguoJWXqBGzr9Sc2yJVBqUTUPEpBhZH9V1B4HHh7/l1g+fjNZxsja/fvcZCZHy8Oo44dmfQ7UUykKZdFziP0bgvohokEV36yVqICSYVXKljF2ca2/QIwmFMYVqnmdhLijbtgE4usLHEy/wz4Vl5XBFXuOmqKEZD0mKv1ipLC/P5WJhqZ1p58MofupaB7S6/Viuo9PtU4TgPOVT/nkjd9RW956YMWu/z4eTZXdAnSe+BGYef3+jxPAM9dlxeyc4y9rvIzjDl6Q2UuYJ2bgbvkNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:28:44 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 12:28:44 +0000
Date: Mon, 30 Mar 2026 15:28:40 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] selftests: net: extend lib.sh to parse
 drivers/net/net.config
Message-ID: <q6yqcidktv5qt6hy7pt4pgnofw6co37qxml6nq2vslixqjhuhk@jbdg6sebvowd>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-4-ioana.ciornei@nxp.com>
 <87wlyt4juu.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlyt4juu.fsf@nvidia.com>
X-ClientProxiedBy: AM4PR0302CA0018.eurprd03.prod.outlook.com
 (2603:10a6:205:2::31) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6393e785-f2a5-4ed3-7755-08de8e57e212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JMwD6i7El3YZZqnMM+P1ctK4xfDVtFWeA7KJEEBL4FRp5qBEhauuhRrIZfRJIcyGps1qaPjcLjB84Zas6yQB1Kz5mgS6dsoJCwgGCatHfDTqyVrI1YSh4RS+qkN8g8VYgp4Vzu1jyyAM3I6kPAoElo/y1ugFOI5W5sl+wF1bCUZFlKeftf8cNQzHU+PkVBah0wE+2vx5V4BColO8+m0uJG5mJjJOsDdnTZM7tYI2AWZfjdxlx+FoY4O/r2tIT4ZOzJg3YQ9PrPNhRT/J5Nb1t52708ivPxYbPkCQdtdY7gpMEJYd8b1XsabJYuwKbRYNI4VT+hkZfQM+NUDP2s58hZGIGM9YucSdECI9XyCOVFIsN6x561FeOJY3Hpw5Qpj/zs02X+kQ8bngyw60kFzRPXMke+sx7UL8Og1MNkJFq3fAbF4/Hc7rCib8nYWk3Y1rkkKLKNmmagHatx41dd/m3CVOZnXpmaoftvDcseWX431HKy3hwLwU4RISRc6FSnZ3KT+V8jd8UPJUSiIzemD2A2C4Bh9qTkSzC+EPYjVn+00nzGgLcZZdTB+rJHRAa4+R7ZFgPugJJXjRZa9JP9GlexmeVfLpDNzG4S+euKZkDaGqKHAGLwkDLuWV0YJBlBQrbeczii30pd5S/6MuJW1wA2s9Clx+s6wersYKhPrINhtiQJZOKa0sT81VMLNukuod4Qq+EZ9FfbYQ57ZbF0hZJKwPoKjjOFyKXMwtehKMHlM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivP1xWddOD8r/thizGP1l+yB3O5gse10aKWJOSl2Id3tXxmrPPqgoA1kV7Ri?=
 =?us-ascii?Q?ckU+X71VsdXiFo8AKNfwYSuEATXsIwCNUL/KkPAqDv9mOJu2u8NKMa3mQ5ez?=
 =?us-ascii?Q?YQyJF1DioJ6YDWf0RltO0IOWSiiY3zqlyL2hiXNGgEe+zcvSq1GY+5ar06bF?=
 =?us-ascii?Q?ZaH1Ei1YMKQ1Y+9uuWLQwlU8qFBbm6jVy0F4updNVxs5g9VUmxceCFCQwBtm?=
 =?us-ascii?Q?/8cq+3oR7BjhkTo8dXrslYRVUVa8UxuoM7X70/X9Sfw8bS7mewl0CFSGBeK2?=
 =?us-ascii?Q?Be4zOgbbtgTvkGF46tiBX5Fc+2PPUjd7R7hHS21Z5JDPNnga+9yi9A03Qj1q?=
 =?us-ascii?Q?MfO5mnKGDzlvcv3w1qrN3yg1bmDiO8KD1WnbibZNnhVkySAn0zIlp6fvw7pw?=
 =?us-ascii?Q?wHyL/OiLGdlWspsf+nFl66MpNhJexyz+HNZsNXgM4oVYmswQlvLCZd8v7Gov?=
 =?us-ascii?Q?3iNEEZKe5KAEphc6Gqhx3o86PcodE8i4qPQeE0Y4n2JETrCCVOQRAbm4oqmA?=
 =?us-ascii?Q?GX8vTNLqg5YusimFGv+0prDVdiog26ERPmDcxlO3/oOzSxuPViPoPsA6joEM?=
 =?us-ascii?Q?tWrCtWHIpYHJE2Yyfr7KYCTnGmLpPid+cj3vIJ+3q1N4BDUdwYmOOgAZoswC?=
 =?us-ascii?Q?pChTB36QCWGDrtTg0NU0hIRcGJPfGCJB3ZJskEVFAiWZy/NfDnXMUGONkjwo?=
 =?us-ascii?Q?msyp9CLy2CPlqEKI/PexVPDusk5CEUFHK+43n/tpdcwVCDFnm81MdHBSv3Og?=
 =?us-ascii?Q?Uul1loB1E+JD2JOlKRperPYsY6DuRAr9hjW2DydbtAMU5gLI20I5bUtzRIOY?=
 =?us-ascii?Q?qji65uH0K9qAjndgZD5/ePwfXSzH54QkQCc2VdUev+bfY/dVkA15viuCgg6V?=
 =?us-ascii?Q?ujTvWf/4zCHpgDqnFEj1wdUqJZYrZZzVm8tjDY6W23Q8Ov828W7aOLvkw49q?=
 =?us-ascii?Q?L7ArdR5JVLTGApnlLxxCw1uXGOQQxbv/o22vPkMQmWXpRcvul4uRvwhQSkNq?=
 =?us-ascii?Q?NwSjf0earKP4qBBaHA2qf6g5eqCcz3x2LLuOGPIjlZkOs47kzEA2u4BipDKG?=
 =?us-ascii?Q?HuDXtczJclK65OaKTsJ/6gvV9S9QxYVbp+a2nd8R66JR8liXtuszTAUcCr+T?=
 =?us-ascii?Q?507H/FeywB3REEXNN7rDcmX/gUia3NAfjC45Orxx20XBNKBUXp0FeOk3GP6c?=
 =?us-ascii?Q?gpx9Hq2PokBqFBOe8Gni/gZOI7Exabw7pZV3h9lN5TIW+GYTP8oG99ECFcjV?=
 =?us-ascii?Q?jdUxMxuDqLrtkRVb/Yblio87surF/DyUnbJzGPPPiyJQ4l8qnGKu+8jDsLvX?=
 =?us-ascii?Q?M+jBmG7TBP1vAKk64OLx5ymOfiw/6MzhRq4dqirWHk46J52AZ0rDA73R9R0V?=
 =?us-ascii?Q?89emkvdNBNty7iF5mvXCErGnh7V427CYVNr23ZQFtqIJ6m8bGt1OYQn+ePkF?=
 =?us-ascii?Q?wjldtsM2eL+uETqa4MJAtCHmvNilIc5m7UoyusFOqObFW4Dh2+yvx40H5RRv?=
 =?us-ascii?Q?aVtgs1Uj6Wik+z7L2tmxwJ6UJujI0zVoc8RhEsVhXa9bfrw4ENgmNEFSkdQg?=
 =?us-ascii?Q?QUN++j6SYpuYhnC5dsysNau0c6cbUwfeHZW5/8QdEI1AQVlETlpezssAxAZ2?=
 =?us-ascii?Q?QHA9YdtL42x0/VX2VIWzWnnPpGBGBkB5QRlUeICmSPyd7JAazJy92EHs5JbR?=
 =?us-ascii?Q?ijfSi1cOdoPhoMyUflcz1zM4fx+7VS0JmfaqAgR/EnO5EU0acYXajulOC/bz?=
 =?us-ascii?Q?TWjUOYpRYQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6393e785-f2a5-4ed3-7755-08de8e57e212
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:28:44.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVOiUZBkwb9kFK9NCJMDJ2e4+G+f7RIq7a/l/IL33NodD5ogvuj4U6eEGEW2PxGhz5dgVc5crYylblBc1LIsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
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
	TAGGED_FROM(0.00)[bounces-273157-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,lib.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 641E135B176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:28:49PM +0200, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Extend lib.sh so that it's able to parse driver/net/net.config and
> > environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
> > in drivers/net/README.rst.
> >
> > In order to make the transition towards running with a single local
> > interface smoother for the bash networking driver tests, beside sourcing
> > the net.config file also translate the new env variables into the old
> > style based on the NETIFS array. Since the NETIFS array only holds the
> > network interface names, also add a new array - TARGETS - which keeps
> > track of the target on which a specific interfaces resides - local,
> > netns or accesible through an ssh command.
> >
> > For example, a net.config which looks like below:
> >
> > 	NETIF=eth0
> > 	LOCAL_V4=192.168.1.1
> > 	REMOTE_V4=192.168.1.2
> > 	REMOTE_TYPE=ssh
> > 	REMOTE_ARGS=root@192.168.1.2
> >
> > will generate the NETIFS and TARGETS arrays with the following data.
> >
> > 	NETIFS[p1]="eth0"
> > 	NETIFS[p2]="eth2"
> >
> > 	TARGETS[eth0]="local:"
> > 	TARGETS[eth2]="ssh:root@192.168.1.2"
> >
> > The above will be true if on the remote target, the interface which has
> > the 192.168.1.2 address is named eth2.
> >
> > Since the TARGETS array is indexed by the network interface name,
> > document a new restriction README.rst which states that the remote
> > interface cannot have the same name as the local one.
> >
> > Also keep the old way of populating the NETIFS variable based on the
> > command line arguments. This will be invoked in case NETIF is not
> > defined.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v4:
> > - reword the entry in README.rst to mention that the different interface
> >   names is only a bash restriction and the python infrastructure does
> >   not have the same problem.
> > - only declare the TARGETS array when necessary
> 
> I guess you mean at the point where it's necessary, instead of it being
> a user API. Right now TARGETS is defined always, and I think that's
> better than having it only defined sometimes.

Yes.

(...)

> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 3009ce00c5dc..93b865681840 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -3,6 +3,7 @@
> >  
> >  ##############################################################################
> >  # Topology description. p1 looped back to p2, p3 to p4 and so on.
> > +#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
> 
> The shellcheck line should be moved elsewhere. The comment is related to
> NETIFS, and it's weird there's a shellcheck declaration between a
> comment and the thing it's commenting.

Ok.

> 
> >  declare -A NETIFS=(
> >      [p1]=veth0
> > @@ -85,6 +86,9 @@ declare -A NETIFS=(
> >  # e.g. a low-power board.
> >  : "${KSFT_MACHINE_SLOW:=no}"
> >  
> > +# Whether the test is conforming to the requirements and usage described in
> > +# drivers/net/README.rst.
> > +: "${DRIVER_TEST_CONFORMANT:=no}"
> 
> Not sure this makes sense as user API either honestly. Given the
> differences between requirements of the two test types I can't imagine a
> non-conformant test would be runnable like that. The actual line is OK,
> but it should be moved probably above the if check, so as not to
> indicate it's usable as a user API.

Ok, will move it before the if statement.

(...)
> > +
> > +	NETIFS[p2]="$remote_netif"
> > +	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
> > +else
> > +	count=0
> 
> This leg is missing declare -A TARGETS.
> 
> Since both legs need to declare it, why not move it up above the if?

Ok, will declare it above the if.

Thanks!
Ioana

