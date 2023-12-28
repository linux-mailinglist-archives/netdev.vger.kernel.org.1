Return-Path: <netdev+bounces-60518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A213481FB39
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 21:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CE28603E
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A690101EF;
	Thu, 28 Dec 2023 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/hArb2i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFB10794
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNiCIK2MR/HPrhnfgm1R3kr51P10Ya0X2WhjAOta3I5hfi1wY9iloRfjxnSTFlsQ3vtPtNfH8lJHwn2vLhMSNkHgJWy472u+t10xsmtRn0PExka3rkETy26ng1ASmRnEozZqGgDK3BmODdNR/0HbPMVzca6mFiuS1wmeQDAdWgxhbGDAkXseJZh2GBX+NSWeBnMu9QUPUEa3uI13M5twylyPld/cmKSvjqfde4tRbO8rlBCtO/F+HPY0/eEOQt4kOWSz34sAtl169iZbMk6s31/HBXomYE4H50fUedDGYjnyreBKmnAbXeYhw9PbkzEfLi6ksKtYJaUOyK1VNmRF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vizxIwGyyoD7mYIGeetCAMOAXY5nDL8axUd/+c3qCgA=;
 b=g2pjUVxckoUxPfsiOlKOxPPgfDQT5Wjcl/dJki0OKLnUqOrp/yx7/Jn38m8XopBkMH7NGI4nFre5NBgvQGQJ8H9y+OoQns6PTWK3o58gAA5Us5Wh/UqyZWJnAv6ASr7nyJSbJQxDCIKBveeEcm/GXAAOkz9p0coDgANa2/iq6a+W8BmoFU2pdt8h/FHBN7RY4O91V9TZXOXZh9n/saSzULm7076FJDziD7np608Rok6Yf8gLtKIi/2DeXuUvtoXswv2RHMDo/wP6Eqo3sh3wphYuXVYXgGeMqm4eqtmBQ+poXumfsNSNBJU2RuTLPiP9g2K7eBR17NL0zJhfnvZ5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vizxIwGyyoD7mYIGeetCAMOAXY5nDL8axUd/+c3qCgA=;
 b=T/hArb2iVyerF4lzVMjJVQZSGXH226KX4nfSwuzzXJZfydMqCViwzCCaI6X/iccHE2u3GE2JJ7hwFoK7bJh8J8AB21J2lG7bp1msf3hPZTXIAN7KoV5Cvzn1md5W2QgRY/2irJAxyMlknJqWecNLxV/Q+bBRXcFI8KoOQVSDxPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8737.eurprd04.prod.outlook.com (2603:10a6:20b:42a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 20:38:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 20:38:51 +0000
Date: Thu, 28 Dec 2023 22:38:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 05/10] selftests: Introduce Makefile
 variable to list shared bash scripts
Message-ID: <20231228203848.ypx5iomfk4u36wyc@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231227194356.7g3aec3kujnk2qo2@skbuf>
 <20231227194700.zqhod5nbn6bibub3@skbuf>
 <ZY3MRl5Jtb08YotB@d3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY3MRl5Jtb08YotB@d3>
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5233a6ed-194c-4aa2-9cf5-08dc07e50025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lWrVcAx2toSTZlM1B5rtfBdCTIO6EwCc1n5lRUawwEPcOMNstmWOrG+uHbfmpZ9WgdpkyyBMmlPqd/DCTWd/cjJxEErkhCvvdPnCTZddeZmLa6E3xaTF+mEM4J99BRx1xpA6MKQGSQtckjmx+tA2vuaVx44j488/mXuj5mqmfqPOwS7QPZ2Jf+ZwDJflqtd6GUvpONTBTdA3e+6wOgSa9hOA9pqEHD1KKHdylFzuRnfM1DvuXBeoVP2pPbgnTf08qdL5adXjDLfzacEM9pzaXCOXMTOKHrPJ+Hy1ZO8/jQm87YjcK2ZVQnyGvlB5giTf7deZknnE+2iXrYCeN7jat0KHkntadcIqBDpFZJyLniaF/5UREhnWcBTHveZAWp69ZtxGRBSiJYbfnwJx8gMgdLX8KJnmZpsy375HKe5FZl+LhFhd07OutPfKKrrlfi6jl5XQt2oVA8u+tpPDibojYBSZrgxfiZjK+p038XsLhS4xjWsbglCa4xRBM7r0sIu+lk5jMt/RcnUFZ2IFogXT52YNMyrpsl1AKxyCBwUe31V5dW6gU+5ENON59JZg4EHo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(86362001)(26005)(6506007)(6512007)(9686003)(54906003)(4326008)(6916009)(8936002)(8676002)(66476007)(6666004)(316002)(6486002)(478600001)(66946007)(66556008)(1076003)(33716001)(41300700001)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/jkN0P1s1UZTSpjeQXxbXWBcvVIob6iBbZyA/kmNUvFxqoWZ83cEsv/WrnT?=
 =?us-ascii?Q?6KqNtPOOfTb8xMa4Ro9hgL8Sk30lTlTQyg9ociMjdB4OWuHSAFubd+K7fP+q?=
 =?us-ascii?Q?Ayb6eMXAsJQlgpryJwso32KyHamTloP/oiQqBopb5L5BXbMIW9K/LJlPv+k6?=
 =?us-ascii?Q?P+xmDXFXTZArSnFRtcEZjZxnQ/F3X0+bu1QJM9qF+uuNNlLvXyo6NZ0fb6DS?=
 =?us-ascii?Q?o28lvTAlY3K9TyKLKw8js9+Uuxnw/G5tCbs3tujPtJKwYeG9SjTekGQ6NfT2?=
 =?us-ascii?Q?myb8OwY5OoddE2g2jf/xKTVJHnhzJBrfQIeWNc/WssSuTzJTwLw+tvF0vwia?=
 =?us-ascii?Q?RSSe48LmcjGhhoe+x7wOogTzNxbsCA2IZNkiqmsddtEIReUsMxOEl6VcyoHs?=
 =?us-ascii?Q?dJoI3rgy/ktJby/xR4dx/O1GRY0EihYn0KujgV28+KMXzVFK3xwWKR7f22Sl?=
 =?us-ascii?Q?dp29SeEKnGGZm331xgROmmAUJjipUmzdc49UFPbvUoz2yx0e1z/e7WZ0sjaN?=
 =?us-ascii?Q?ajbPS5oJX1BKmDf0aC6qioBlCzDysB3pzZ/iwPOQiHckMymqRiKsTrsxmr58?=
 =?us-ascii?Q?FYUhuiD6fU0dgjfYpKiE/FffzcV6QY/+Vaez+SbooEWmhiIrt3tsmiRXMVoF?=
 =?us-ascii?Q?OZpzYcZYgoCyvhFs2ENjneU2SdE70RrhJg9eZAKSnW9B2M926MlYViGNGm73?=
 =?us-ascii?Q?JpkM/jVn4tCk2VmQfnhFxN3OLiDH1Wv3edVY0EgQ0k5xqQmsKK1lbMtj4trL?=
 =?us-ascii?Q?Rv6zLiFI1DTkNUWXh0BEzO/W9KOhveKSNRi7S3MOXmIfodcsy3tFPlTfCQsG?=
 =?us-ascii?Q?Ba02+Cz0fno2ssU6TInn+JKt5uU37VGop503OWMGlqPyL6CaPmYTRDuLJbSR?=
 =?us-ascii?Q?dHHt4oAzi8haKeTyhXdHMrYyo1zoLOj/ZaXIQMivj3ixgWWmLct2jKQjPW2v?=
 =?us-ascii?Q?wbINm4g4gacc+aHKLQ5CpWqSNqdviXEWdI5yvfeYkTbGGlqBOP5J6FOVEHee?=
 =?us-ascii?Q?N39zB1ynOfw2HyUQnB7LRJdIzrOy5Vgm3HtD+IqcXfQAZ431mrtXEiLD2bPZ?=
 =?us-ascii?Q?S1otVZhh8EY+8iPYxDiyLvT5gtck4xz68eHxOHAzSUFOM6oroQHKqBMxR93Q?=
 =?us-ascii?Q?8/YPcMm640QOZ3+1UAv/KdpHTWc6B8iH84l23aDdFDSvpJ5wBYwWvxW6CRDP?=
 =?us-ascii?Q?c+4csjqg4KB+EPOUEjHdYaqlIvZnv0Nj6HmQJu3KkEC/NQNKPIueN6P5481r?=
 =?us-ascii?Q?BOheqVXkE4dP12Lzhl8dAIMFz0JHmrMNCCDsqEeDUSOeA1mL/OOnEWXBoNWZ?=
 =?us-ascii?Q?t8I9LiVMWVteMB0d63CfJHeIg2Cfh/qoxFJpw7RkXWgHzpqlGI09ZS0+C+z6?=
 =?us-ascii?Q?Z7Vh4tMsHw7E3fTFK8advYSUU9PZWVJIjQ4Uho13x73iS//+RwVIRtDlSnT/?=
 =?us-ascii?Q?pNW9ETqp+KfrFBg3yF1cECRLTUype3N89umEYXwGNs0CB79Balx1PyqSRt9l?=
 =?us-ascii?Q?CyyQ/4T6MTjJvlujQ3yI5FsWEsRjIDQavFFfm9y63n0U5OfMAqr7YCSziAev?=
 =?us-ascii?Q?/LnFiusp6sh1jafCPBhqjrz2zM7JdRKcRaJgg6iXUXBUV29SXd1gFeAtPczt?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5233a6ed-194c-4aa2-9cf5-08dc07e50025
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 20:38:51.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+klBM+iO7/bnbRU8IBVrXWfI0xr8Gs1l5DDgIgRHQcxG32R7RGyEGflApdgz6tyLCgNN/pZhN+Ww0QZKhxwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8737

On Thu, Dec 28, 2023 at 02:28:06PM -0500, Benjamin Poirier wrote:
> I agree with your point about consistency. I have changed TEST_INCLUDES
> to take paths relative to PWD. The implementation is more complicated
> since the paths have to be converted to the old values anyways for
> `rsync -R` but it works. I pasted the overall diff below and it'll be
> part of the next version of the series.
> 
> > 
> > To solve the inconsistency, can it be used like this everywhere?
> > 
> > TEST_INCLUDES := \
> > 	$(SRC_PATH)/net/lib.sh
> 
> After the changes, it's possible to list files using SRC_PATH but I
> didn't do it. Since the point is to make TEST_INCLUDES be more like
> TEST_PROGS, TEST_FILES, ..., I used relative paths.
> For example in net/forwarding/Makefile:
> TEST_INCLUDES := \
> 	../lib.sh

I thought you wanted to avoid the cascade of ../../../ which is confusing,
so I recommended $(SRC_PATH) as a way to avoid that by using absolute
paths instead - which makes it easier to track down the include file
being sourced.

My inconsistency issue was with TEST_INCLUDES being relative to a
different directory than the rest. With that being addressed,
I don't think that using absolute paths for some files would be
inconsistent in a similar way. But I don't mind too much either way.
Feel free to keep the ../../../ scheme.

