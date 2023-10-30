Return-Path: <netdev+bounces-45261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDD7DBBFD
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BE9281375
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225015EB0;
	Mon, 30 Oct 2023 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="KZb8szLv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8902B67E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:43:00 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2124.outbound.protection.outlook.com [40.107.247.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE0CC
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic8I81jY22HmVDxbYwc/WqDxZc6PwlKhRZDWx6dp3DZSUva+DpWgdZBjs2ZLE08S4Jt3fRRbB8QUVFwN9FUC7+H8jjxNqG0S2tvSQKcK86+tHL63cVcYkftfSyoOGj1AWNmtAyn5N2WQSrVILk5ygOMV+tL81GNSB1yEGmW/NL5IGNKOIN8ycMNcOerm/byss8ofYRNNqVjBJIpY8nIJy9t1jDslZVgUsJgP5C/HVuBTi8yxbdkNbQTzYPi9iUx9ZNlrd9NCboDUXEjtSQriNSq42C+9k0O2y4z21TTuuQVjhDiixqXdRK6ou61tS7AZWzvuotl+jLQ68dkJIbokiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blz5+dAGj8ly2hYXhVCum8+QnEGYbC1AG8Mh3Y4hJus=;
 b=ATeYGHd8EQ48nDoVGqpeRmucFS0YAQOi30qpPce5YgkMNXpluadMbBCbmn7ik+LrAC9quNrk0XNl3pk1ObA4shI0mZGd3AlnGee3oxit9kZhOVBl3sI6PAf4S7I8M+9oF8/0ySW/rVxdOt2oFTebgOJ1WwNKvnWTuX1urfOc8Z+1WTdg2DrrgKNxWxA+k/yiTxvxevbnRF6NcogpASwRLzPeQPGBO1ERxIIMfwTdv45synZIY7SenPW5p4eK6oahjTMo3uByqvspRkWmSDXOl5xE1pan1buTmkWosbTi4U2pIZwVi23Q4aJyzeR4dwmH8vZ90rYg8env5W+MaHPC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blz5+dAGj8ly2hYXhVCum8+QnEGYbC1AG8Mh3Y4hJus=;
 b=KZb8szLvg7jC0Y+Hamhz9u7GiIzCrrEbnWxAaaUxwPtUMD0ahRQc9WusVMCqkhmm12Yuqk1FXTir+47JwZdIv/9UFdSzhlMIPG0PHg1Qx7uDpzYF/dnwYw9hOcdk/PKHlaVy0i0JwvPiQ8dh3jnbKn1AZjgFcF/K23BSRlJLbj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM4PR05MB3506.eurprd05.prod.outlook.com (2603:10a6:205:3::26)
 by PAVPR05MB10158.eurprd05.prod.outlook.com (2603:10a6:102:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:42:56 +0000
Received: from AM4PR05MB3506.eurprd05.prod.outlook.com
 ([fe80::3443:3414:3900:1cc]) by AM4PR05MB3506.eurprd05.prod.outlook.com
 ([fe80::3443:3414:3900:1cc%4]) with mapi id 15.20.6933.023; Mon, 30 Oct 2023
 14:42:56 +0000
Date: Mon, 30 Oct 2023 15:42:52 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	hawk@kernel.org, lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, 
	mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <r3kkmihygodvoo5pa6mvdtwqrzik3dh6su32lerkficokzt4s7@w23lpg2edugf>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
 <ZTiu0Itkhbb8OqS7@hera>
 <20231025075341.GA2950466@unreal>
 <j2viq53y3m7z6lj6tkzqxijtavtdfsdnenl2yt2pl4jkqupm6w@aautqnvca6w3>
 <20231030142355.GB5885@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030142355.GB5885@unreal>
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AM4PR05MB3506.eurprd05.prod.outlook.com
 (2603:10a6:205:3::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR05MB3506:EE_|PAVPR05MB10158:EE_
X-MS-Office365-Filtering-Correlation-Id: 307014b5-d0b5-4eae-c725-08dbd956811a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IgXQ3NuxH9CboL9jHeYNPCGvTALY1ClSWFccdhD3OD8+YisJV11Yr0n5v6cmOBngN5+T5ZGqXs0b8vd2S/pz9hu409ZEYjK6VzvS1GLevNaZxl1Af0KQKK/XfK9ttpQMv1lsamZLrjs1z2DSb8JKSs0YhDmGdEyXH2s7UeYF3HnH5xuwlfgPQOzp2pgF6+idexAjPH3Rrkl5S4iOcH/HBuLjsDLbYm8k/fDpv03r2VPX1Ym/7yJ0GjhdvA2/Ko+yKD+b63FPlWelGLlcw9UfCSSagdK5nuNP3RWl2M53Ajh0KBUxqnYZvKW4S0sn4mn1eTNZZwYErhpZMb9+BvKpzQPdHT0EuGFjUVGp0zlQwaQ5JhwJNmhKNVcVpHH5GmsA22hz3dueV1/Dy+vsgoa9bPvNaYEVeqy/yJwgYvQBfJCTlsT8nLr3gWq/MxUUoP7q4lEj46E0PfqywOaJdp3mp7zn1eJBcTr5KxKbnJ4wdVlgR6ogHHnE6t2YSuXkLFIx6brk5At1Oll6Gjmjob3Xkznd79uBKzM95FGFrj5nvjxD4Dfe3nEwGXa6Soe89bNT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR05MB3506.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(376002)(346002)(396003)(366004)(64100799003)(186009)(451199024)(1800799009)(478600001)(66946007)(316002)(4326008)(6916009)(41300700001)(54906003)(66476007)(44832011)(26005)(66556008)(8936002)(8676002)(2906002)(5660300002)(6486002)(86362001)(6506007)(6666004)(9686003)(6512007)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ET9TNN6mgDphbbxSIc47p989fmjq9LlIxYDQ2yCPw5jMCpiNcp/+Qe/d1lN?=
 =?us-ascii?Q?29VZIz1yitO2Mwf1Hv4rPYlXVnXpzIyrc2T9NhiHqpvqx6XmmROAVSclRRaZ?=
 =?us-ascii?Q?WEHVT0CZ9BUrC0HMq7+YhI6G8bSLlF+YC2Zga/m6Vfj0KST+oj7DnWjfLxs5?=
 =?us-ascii?Q?RoEVjAYhfilm7aCaHAWIaxEnMncvgr+f/QZkkzyWx4M/RsdeBpuYCVL0gobm?=
 =?us-ascii?Q?bOOL7woPv7DxmSnucaR0ciOVQaqIUYVKU1HpqHh35Bc+1jJoBov0DSCwQgPj?=
 =?us-ascii?Q?yok7Geo3cfWf1cWZrGwGLgJD59eGy3IVs8kEsWiQHpPjQIYcW5cxieHMejx3?=
 =?us-ascii?Q?uhukGUPt2KqxQL4hc1nij8+NSh3LNJrhGaiYFvLoercZlGucAPFJhnA+Mxpf?=
 =?us-ascii?Q?a0/jofa3H8RFy1jnNFhVwVuLY5iAoI1xsd14QqCxEYgweNAIZ2QVCpew5g2K?=
 =?us-ascii?Q?AZ9pKBmFYyDEznK0UxaALZiRMT2Z+FVkbDcCCMRkYPGzoMe5KpF4edPba7Yu?=
 =?us-ascii?Q?KxQu/WyPW7bO2VM6gHB6fvDYVA4sHJoPgO/zngdWDdH1ZYgMTGjt8hQ+n6L+?=
 =?us-ascii?Q?rjxX/Sm6lZoAeVzs/hWIkxKVAVtH8MH1g2YI4xuyORHPIzFFXbafueUG+KrH?=
 =?us-ascii?Q?iGmE8l2YHrLCdPURbkJ88wljYDV6EzTaFqdQNxoR23925EEfiinu0D78rAWb?=
 =?us-ascii?Q?AcsxeyT/vh8HX6ltJEV2jceoYBkO3r/K7CzhkoE83FeyjHwh0vkLEG1UiuLW?=
 =?us-ascii?Q?mCHCVlFqs4KNLM+qayRWUyhGStyPIZnnfHp//uDXMnEv7fE6lktJjxbN+uW3?=
 =?us-ascii?Q?27WzZw9K6DYDmf8yBa1x46RkM6QAMi7zkct53RBwHvyxwKfEXRrDqpc/Jyfn?=
 =?us-ascii?Q?l68BdoK2DxQ5FkXFH5ZNKmMEExz6zrIyfnYW3hdMqkt4/MPRCHiMfzA8qC3e?=
 =?us-ascii?Q?hxbBQgo2kebm/3UBSpDssRF60KBDRzXBMcboA2y+ymeAG5xiZb1hWgSm2AqF?=
 =?us-ascii?Q?mga/uSur1BaqZnbxpMIj04ZqoA67wTFbFZEI0UWU1XNuitGg2fBHQMGcQLMy?=
 =?us-ascii?Q?nf33rNwvCiWHNUc5VZBfSH/8lPVsL5czG6OG0tKM5CPXs1+yhMKu69cd9J+2?=
 =?us-ascii?Q?2mYG+DXJU7VfKigsp77/Xy6Ht0z4hmn5t2rSHSp9bi4sKJi60liK31GgELAG?=
 =?us-ascii?Q?TcQHv8cPOdipf1BUpHUQkWfd1mawwNppzgXIgOUTNhmgZnjfFHP2Q/cwJ82x?=
 =?us-ascii?Q?fpp/3U5Ea5XNrOvwr98gQ1fc7FqQ43MXGnIt6NS9ausN/BFw0ULfKlXS6011?=
 =?us-ascii?Q?12X8LYOdOv7LoxZM8e2Kg+H6QkKZhxlchoutFQ0/Dr81o5zSNGw6KzG8P4Pp?=
 =?us-ascii?Q?Zfyc2mwpC4cLRDx9t40+ccTDwM9xs3Ke2U2WvUCRUapRWZn3SRwL4EAAtKEB?=
 =?us-ascii?Q?58jHL/UI57g6acfztIObkQyqXQvqVsJT9GoGEkuOmuzLgGKTJBrKQGJLhRCA?=
 =?us-ascii?Q?tDpxSkuJGJeVM5RDDIRBBn8XFvgvHI1Sn3QEPs7FtHNBLdDTidgjqHzu0Ehe?=
 =?us-ascii?Q?tBZUYGoRyRRX+jqNqfkKsXCk2bxHBzNNd/P7zIuaYXIua4ELjNGJn38mH31/?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 307014b5-d0b5-4eae-c725-08dbd956811a
X-MS-Exchange-CrossTenant-AuthSource: AM4PR05MB3506.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:42:56.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGKkg0x5AwtRZHsVzQSNVdSGXYSEK0DQZfpyzsogpKIhAO8H26Mnfb9OwnZBvbU393j1ssihMo3zMMPxXZGs+3fLUZzZ3//Klu4OaFq7NUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10158

On Mon, Oct 30, 2023 at 04:23:55PM +0200, Leon Romanovsky wrote:
> On Mon, Oct 30, 2023 at 10:39:18AM +0100, Sven Auhagen wrote:
> > On Wed, Oct 25, 2023 at 10:53:41AM +0300, Leon Romanovsky wrote:
> > > On Wed, Oct 25, 2023 at 08:59:44AM +0300, Ilias Apalodimas wrote:
> > > > Hi Jakub,
> > > > 
> > > > On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> > > > > On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > > > > > If the page_pool variable is null while passing it to
> > > > > > the page_pool_get_stats function we receive a kernel error.
> > > > > >
> > > > > > Check if the page_pool variable is at least valid.
> > > > >
> > > > > IMHO this seems insufficient, the driver still has to check if PP
> > > > > was instantiated when the strings are queried. My weak preference
> > > > > would be to stick to v1 and have the driver check all the conditions.
> > > > > But if nobody else feels this way, it's fine :)
> > > > 
> > > > I don't disagree, but OTOH it would be sane for the API not to crash if
> > > > something invalid is passed. 
> > > 
> > > In-kernel API assumes that in-kernel callers know how to use it.
> > > 
> > > > Maybe the best approach would be to keep the
> > > > driver checks, which are saner, but add the page pool code as well with a
> > > > printable error indicating a driver bug?
> > > 
> > > It is no different from adding extra checks to prevent drivers from random calls
> > > with random parameters to well defined API.
> > > 
> > > Thanks
> > 
> > I can see the point for both arguments so I think we should definitely
> > keep the driver check.
> > 
> > Is there a consensus on what to do on the page pool side?
> > Do you want me to keep the additional page pool check to prevent
> > a kernel crash?
> 
> I don't want to see bloat of checks in kernel API. They hide issues and
> not prevent them.
> 
> > I mean the mvneta change was also implemented with this problem
> > and it leads to serious side effects without an additional check.
> > Especially if the page pool ethtool stats is implemented in more
> > drivers in the future and the implementations are not 100% correct,
> > it will crash the kernel.
> 
> Like many other driver mistakes.
> 
> Thanks

Understood, thanks.
I will resubmit with the initial patch that has only
the driver fix in it.

Best
Sven

> 
> > 
> > Best
> > Sven
> > 
> > > 
> > > > 
> > > > Thanks
> > > > /Ilias
> > > > 

