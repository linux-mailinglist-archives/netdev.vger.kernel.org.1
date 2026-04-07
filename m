Return-Path: <netdev+bounces-275916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATTNtzK1GmHxgcAu9opvQ
	(envelope-from <netdev+bounces-275916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B633ABCAE
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 889163004D14
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310639B96E;
	Tue,  7 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VQXtGHIB"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C738C403;
	Tue,  7 Apr 2026 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553243; cv=fail; b=hcS+iD2chqaZ7uWsDpdC65yXpNj3GW4rVIZWxbL9mrxkyK1NIsAgxaaTv7jQf8rO6YIg1uRuvL87THsE4v9beGRnRO1NcnUbpok8NGEIaSrIE4Yi+zO7XeeM2eY++krNE4UKkqC8XqcFzroAmT6PVPg7eF+Uum1a4O28Bgxdxxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553243; c=relaxed/simple;
	bh=TACs+THAZi0Qethy7G1VoCU65ef7b0lshjRGOB77yEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ms5JXHDQKzXVoZkqbffdjt7+gHiAUcIqmVl/XI6lP5Yxbs3uptFQdHiVGLqd2YBpRA5St/hUnLAI8fKOvPOXY0sJyoZwq024QWJ+IBuvf4bhGZ7aJJWVd7ftLsiNX7jrXH2dvtxh4YpKPQJvwuFQ+T+XWUr+jg3Lg9HPAVI0U9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VQXtGHIB; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blBHXlYMWW003PfaSULOALi/ae8rLwxEybLnJMejaH20BfA9Js2ELVBGlVTSxj5dOwma9e8i6iAo/EzchMFhjow44UD53W8b7azGq8IcZm+2CfFG+QpyMXKZMgOasWJJvtJ6qKzdJlLdW43bLQvB4unilqFDfodhLwApo3FuErf/uzp+mPgf2Q3vU7J3R2GT1trHYuvPMSp8mu8kTyszLIaZg0ezMPyG8+rnXilqR0ZObULeJFO2D7EBLND7/PkC3eiDRgMHQilIkVDsjSdxs9uGMj7jAgQrLoEJZKfZU8tddOa0x8jnWThqDVV9yVDkRfCugAENHbjfkNKLfy1DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0vAnya4HiEcCaFhC6j5dnqz2+bOuV61/jAtT9TIZek=;
 b=eVSpEK+vhUPnoTWFyoSzXCkAh9u/kiYjppdW2/oWQhuPwl/vGULR84rv62qMgxJMLkQ9PfoXiYSV7Qh0fdVTQVY+I82XFuUym+vZOw/KEkNMbzM8j7YC8AbSaIzkeHdSkbWee3suLYL5rUPQxS7a5m72MW5vxeDLspoj82kgJtkib6zCG6JtyzeaSXi0L7sV6Pxw7VfA+IzCBzM+/hfnOAyxun/QWF0ief/vr3axW5CamM9GuV+TwYbQydy3o4Ah6vvK0QeNyZ4cKMivSsD8fj4dDz2fk1PMv/WBb/zLpZyLbt1uLd8FivacARw7+VHP5JLAi/Dc51q4hHjjZHV73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0vAnya4HiEcCaFhC6j5dnqz2+bOuV61/jAtT9TIZek=;
 b=VQXtGHIB0EIpuoZOq2sMhF47W4d5O3ErQF7/9zY+j55csJZVsYpUp5iNwa/Q8tC6N5NTKLs7beKjpUhZHewD8dh8rOL0x8qiqW3BEUqbOMN4qOiTpLYEa16uASocyTSG6nQeifor9WCOsO20/WLGQEmip2euNloqhRG3Vaju34DgqiH9UIkD80V0nVjVUDYTEnrE14JYUZ+DUls9vzmP2eb+8QM9GDNU2ZYvyKWn1CsphlJ5dTrMs4jP6Khn+G94w4Dxjvs2AP/G58w5cyfBmInbrnF5bGKc5TgJuWddA2t0/DPRtaO8E+UYzmwKZcls+yh6gezJhgPCNJS0Swq+2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by GVXPR04MB10070.eurprd04.prod.outlook.com
 (2603:10a6:150:11d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 09:13:56 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:13:56 +0000
Date: Tue, 7 Apr 2026 12:13:52 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	petrm@nvidia.com, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: lib: rewrite processing
 of command line arguments
Message-ID: <ksjhdqzwgbdp5z5jcjo2z2r3hnu5m4aceyvzfn42nfmternd3b@kigdy3xrzqfs>
References: <20260403141912.3825693-1-ioana.ciornei@nxp.com>
 <20260406153150.GI395680@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406153150.GI395680@kernel.org>
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|GVXPR04MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: 66501e72-cdcc-46cf-d2ad-08de9485ff13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kRvHr4eq7pLVqlB3Wstn8IfsBLVPgA4aMYaQf4MrhzPso9aaV0QwpyhocyJUwm/CsovUvhvnJEfm5nn38+0Tlib7rjFipJJ2zYdH1UZzoYuacBve8OddN6nmviqKu3nuzYxDnZeeS6Io1v9rLt0shMS8ycPO7CwRGyMaAgSwnmis94oT7nc7Bo2+ZB0pVjD3kMnQnJWtOIadorbLWifhkxKcbYlDuwPrUj5j0bzk72l1jL00lucMaXijc7mUr6WP5lp5M6LCjWGJ9LFM2CzLWTfHNkFEG0BUd0Zqd9TwK8by5NFK3Wt++glmT9wrxDJvSZhp+z533hXq//uhqQ3H47VMUkeTOvrqmKa27SeeLV64dSQsTP6v0IRp5PpKtDKLRP8dd5NybYlwqvQkb04e3CSOFlpzsioS8meBrEib96K3YSjwsrm1yVZUQqsisLczj2816n1mUwv4bELXtYH5NbVLsk12rwZDrNdXebU33K1lfRWMuWrCsyrwvDg2/tcFjpgYbwzRRsxy10/Cwaf17jKQZ5fv/g+JoKaXM1g4ubHX3hbLjbIjRwtU7RuYAJq9GCiNOZ+15NqPi/tdzgAPpq5E5yejHHeLUwBo3EeqsVaFHerO5fOTxbbQ3EJe7sIZEfo77veW9kogPLhBfJBd27qb6uJ9/jjSpPEbCT8AodwazT/F2SDKaaznRZaRLy/IffQ30TIfXezKDF8F2cfvFlALRC3bxYZ48KP+6LzCKgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAGwlpdz7V/tah7rdnJhkrMvqBi4STXK1zi9sfTZqjyOKimhKEw4cji+o63o?=
 =?us-ascii?Q?cH7ex2e9aakIP3D2K6gpFUYajLSPRB2BXCHiDdtq26KhQwwEeqbyn8vHHbuE?=
 =?us-ascii?Q?lIrxH4nzIfBqRKBbAuFrN66IZtMxaYjxY59vferYySHX9g5bpnG6GyJsvNB6?=
 =?us-ascii?Q?25ic+rLOGcsmkr6njV9s4iY1bAfsMa7dGJ8m8PrqRjpEXIH2vnyWJLbinfDk?=
 =?us-ascii?Q?/7bVGtXCMGjuiyRjDjPJZHnxATX95UXGWDfaqJxI5WGZiXdjK5gps+IB9kp+?=
 =?us-ascii?Q?TifnRJN0jtwclrLYT1L2Bz1SulieoyZsg7aLq1vmWZ+Q4TVnGQ8yqjl8el6c?=
 =?us-ascii?Q?5BvGkWF99yliAAQr1EyucFEjqEzk4cZXyAJOxrJFot+cpmFNUdam16DwkP5e?=
 =?us-ascii?Q?8uVHwYoofaQpWIicyd62TkfzcvdwQkvTgRU5iXhD1uzIxzgLTRfWLvmHJ9zw?=
 =?us-ascii?Q?9FriN4wKMQZrsp8TIA/x1GIZR57320SxgO4qo1o8RDPGw5X11U8nU61NzoXE?=
 =?us-ascii?Q?ZHRW7vMaMonpjkWCX82CsNaN+O4WqxF8A6Npi+RFwN8hffVzMtTa2MPSFGsJ?=
 =?us-ascii?Q?4J6KFzVBxBCohxNgxhisw8V1krJMUs6UC49CmGv0XBCE5Hc42HqRUrS8BN+0?=
 =?us-ascii?Q?jIqhrovWDPI22hdU+AoOSgDtUuze85bSwzAeDRaKrLNOxdMnRPMoD42P8Fhq?=
 =?us-ascii?Q?M4CKPl4iJgLwsW/G10+epya+cIgcAz4g8Si7hViIjmtr+kfm5ydxZw1p//3C?=
 =?us-ascii?Q?GmRPJZGw2zi/k0t/jUg24qXyRaXd3YmljDLSt6QBmGDpcfwXU9wE2wkt0F9g?=
 =?us-ascii?Q?YAvVlqcRNuc5Leung2Ps0Yyw+hb965sgl48qbGO2MZ7u4KVprcry22hF6hKO?=
 =?us-ascii?Q?AwoA+NBIVn/Atx6h76md3SeUgRvR/Dhq5B6F6Ht5zdz8xbkHjYfPn5eyCta0?=
 =?us-ascii?Q?fEHvckIvGBnkuyhLdxRZTBUG9eC8r6ksf5x0Cqrd3CqShGncsq2O+RMTSC+T?=
 =?us-ascii?Q?5kl/0c+D90+DxAu+HILzvGkDs1wqBF1jmb05yDSGaDkKEG4+Yn+LbvG6Yjky?=
 =?us-ascii?Q?SyH4/BUYRJz7nh8bg2MOrT+5HkLgrIsKXXOMAL7QJ3kCQhrSGODujeGXkGEi?=
 =?us-ascii?Q?YFcPUGGOu1RNJzDZpYYCp6R7ArX/vM7AOhn+AzvvmNAUVoEbKz85c+ePZUA9?=
 =?us-ascii?Q?jXiRG6x3DoKeF/OwyZwzz5CIY+hTvERLJw3+Yh4eiA32dD8VA/pvp068jEU/?=
 =?us-ascii?Q?F5F4H+fPJ6gf2Y86XY4Q/GnnGbbCVY67HytYBQh9B7uzk2rmujiJQ3BzdyDV?=
 =?us-ascii?Q?X3svYfDsz1WuuubitujncAGA7VixEV+Zs/f4pKIw/tVlyZ3EIXWC7aL/dqed?=
 =?us-ascii?Q?WCafE+SfGfdfBRKm05GgguzJ6u0jRKO7YjR9xrofzkOKkDy1BZ0P1hwawU2D?=
 =?us-ascii?Q?By8VeO3BQPMHT0XtXbbSH2ibeXXZXQF088TP9DCZaMtD8Kv70xtuSclsA/QL?=
 =?us-ascii?Q?yaKRESlaDuF7KdcKigrPvdLrp2qM0klWkzROV9+VBVraA1e0f7H73kR18I6e?=
 =?us-ascii?Q?AtA3QUBmIN0EMfwCbmeN1huyya/QLVg7FPFZYO93aIjsDUPXf0U4uErSimmB?=
 =?us-ascii?Q?/5oEqwQ2FaVoKwckJ/nmsDv8bWy2XwTQ0V0gm/aTu/cx+MqJGqjGvB2lUIx5?=
 =?us-ascii?Q?5EY8aEcKHV27hc7VW3W0JiKwSlzb+o1pe23os8e5+mBd0nze4rZv3KjBhOps?=
 =?us-ascii?Q?cGY8l87ZBA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66501e72-cdcc-46cf-d2ad-08de9485ff13
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:13:56.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcjx2QtFfNBMfuZxoDanceYZfs/Ozv1AMcfa7MAT9ODVGXf5nidO41+4r1RZz7aWemXKBqe6pdKjOCPM8boXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10070
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275916-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nxp.com:dkim,nxp.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 88B633ABCAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 04:31:50PM +0100, Simon Horman wrote:
> On Fri, Apr 03, 2026 at 05:19:12PM +0300, Ioana Ciornei wrote:
> > The piece of code which processes the command line arguments and
> > populates NETIFS based on them is really unobvious. Rewrite it so that
> > the intention is clear and the code is easy to follow.
> > 
> > Suggested-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 22 +++++++++----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index d8cc4c64148d..922cdaf2ceb9 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -466,18 +466,18 @@ if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
> >  	NETIFS[p2]="$remote_netif"
> >  	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
> >  else
> > -	count=0
> 
> AI generated review on Sashiko.dev suggests that initialising count should
> be retained to ensure correct behaviour in the (unlikely) case that count
> is already set (to a non-zero value) in the environment.
> 
> And this seems like a good idea to me.

Ok. Will add this in v2.


