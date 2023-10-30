Return-Path: <netdev+bounces-45200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419987DB63E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 10:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E547A281397
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F0DDA1;
	Mon, 30 Oct 2023 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="EoIbZ5oE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4320EC
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:39:28 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2115.outbound.protection.outlook.com [40.107.15.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D1C1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 02:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3qxF3m/0iE1332A5MbpGTt7Y7a4anugeEJF3KPQvaZC1pFWyveHu/OBr815muWUTWT6TO8gpuyy377tgVT+s4OyV0drTElu/yNSCN7ROATjBy9HkZgoFM7+eCJjDPMuGxc9CUBNliCzF32S6LaVV/t2p1em9Amnf/iMgVd6TQRYiSGA7GSnZgeCBHbWyAFa/zzS8oYGNx61qTclxf/Q+Wb4RNOptl3mwh4z/uYN1vWIvYPZxXenP/lGW97u6qQGkigXNONfwCrOV8j2GLuX5AgTePtfetXLLEj/0UF0xp0WheR/3+gvShRIUBCGG4QcfdOy4JWHAYzU84ooym613w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN+K1fKYwrShzZBw1tuYiaVZrZ9t3hQw/aOE0/Y0mx8=;
 b=GZWdvvT/CQy7tpxbhmTRpgKwCSml6zaDNdnLTmMP4VNTBxU2OEqy3FcY/qBJVIqbl4CnMpQLK5HbwCuV9I8YCngAr2HJwMoZU2L2+K+ebO8SJACV88F12JHUAspo//8iN+Hc29Bg+rGNSM/VQcBK4Duv8+egNBROfW4oe9gFtnWMV6cjTbrw7k8zOYllu1VzdXhswUJDLu+0iObinzMs1WzJyt/8EmWB7wT1zBH76fQTPRVxsIOq83BPY20ffLTEsZGES42jpG7AddDh3KQ8YV97awikSaP76Weat1ZpsjxSwqJjqBw8TaPpuiHHZpE1GNtZwTyV9jcSwv9/bR922g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN+K1fKYwrShzZBw1tuYiaVZrZ9t3hQw/aOE0/Y0mx8=;
 b=EoIbZ5oEax/RL1iEIzMqBJKkfdT6svn2a3hzemZZzb7ZddkoTkU2U9yQ9RgF+w67wQ3ViPE2P3qzMktmkGiIXlhjxokq4TBw0FMq6aCZnfjxAD6dyasiig7kmT+u9Bx+HEwntZE7YssZ5cm6hS7yrF6voypoxxgzZcWXPa7+9dU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM4PR05MB3506.eurprd05.prod.outlook.com (2603:10a6:205:3::26)
 by PAWPR05MB10691.eurprd05.prod.outlook.com (2603:10a6:102:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 09:39:24 +0000
Received: from AM4PR05MB3506.eurprd05.prod.outlook.com
 ([fe80::3443:3414:3900:1cc]) by AM4PR05MB3506.eurprd05.prod.outlook.com
 ([fe80::3443:3414:3900:1cc%4]) with mapi id 15.20.6933.023; Mon, 30 Oct 2023
 09:39:23 +0000
Date: Mon, 30 Oct 2023 10:39:18 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	hawk@kernel.org, lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, 
	mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <j2viq53y3m7z6lj6tkzqxijtavtdfsdnenl2yt2pl4jkqupm6w@aautqnvca6w3>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
 <ZTiu0Itkhbb8OqS7@hera>
 <20231025075341.GA2950466@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025075341.GA2950466@unreal>
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To AM4PR05MB3506.eurprd05.prod.outlook.com
 (2603:10a6:205:3::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR05MB3506:EE_|PAWPR05MB10691:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef3d6aa-d2a3-4da2-4d48-08dbd92c194c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Er8eSb0n+JzxZlcKJqh6q7AhgM+GJEWZUeU8TFzdqu9fh3h3gi+wGJz2Iq+CHgsCtddhGcaDXgUffm2ZD9C3VLB5TLW7kPyZOWF45/8M0RQOKteTbCqRC/SFlDAe0OJm4vbedZkDEAuOSDP+TjAWcB1INqvZyb9FSz3PBVBBnbjiT0C5L2NF3xgMJ1NB2An25GhZ+EwiXvbkSRqBHntrzIebXxcU9fWFfAYVreaf/oss7jFV+D8LP+e7pq4syD8SHfHj7R3UZKuSYZGljinrUJjNvsiWEmlsVvm/VCXRZM9CxbFvWXg4OlqnsEq8I1T4PimigqIA0RBtTsiMwFnY3LnstFwjZTRCBq2UJP9EXMRXtC4JKOMBDwYdEpArJG8RxJCCA/W5Y1sPwkaDucmi72SRtJLYAgcI0qybMWZGp7YbcRDOkp1rGUazG8W7/7fiL7UisBXx1rh4RCExQpRA1z8t2UaWDJcall4740TP5lh5oJtem07e55vLT+Z+qe7YmxqGzbQyMvjI/a/NttNaZweNDwLy9jMahLheKOhB/QZmVRHw3KVoNwmqsULaZKQK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR05MB3506.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(136003)(39830400003)(346002)(64100799003)(186009)(1800799009)(451199024)(6506007)(6666004)(6512007)(9686003)(6486002)(478600001)(26005)(2906002)(5660300002)(33716001)(66946007)(41300700001)(54906003)(66556008)(6916009)(66476007)(4326008)(44832011)(8936002)(8676002)(316002)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oM4/+P13EwerbxDDF9Y5QP0DJ4PJXUIclinMVfqKjdUKfWLsPqcaa6qiNRTL?=
 =?us-ascii?Q?7rlCqT4p6Klxl7PSzdZ6FcEhRcJ5DvsE/S+KuQU3ZNa3P/UbLx7EjL6Al661?=
 =?us-ascii?Q?WZtCUP2tznGW7ijnUUa8n9gtacjjnv72WPfY4edHeTUcpXVsERvdakMG78L/?=
 =?us-ascii?Q?fv+KLCNUR0lraYa1dDsYT2SHeJi8itjdSHq8djKqct5HrpJ9CKsrBrkrHeN/?=
 =?us-ascii?Q?DAFOMwyfTxyKehSqCGXf2D7ZPoE7MQVrD+KQ6mAacU4fxLU/Xsdx2ASpfp1k?=
 =?us-ascii?Q?kaMhGY9ejGvCqaX2g9kog9xdJNW3QHff1scaY+n7c4UmY5mo0klqp2mf5zqp?=
 =?us-ascii?Q?vWIMSXbJc/46CjHMr2AlfuiqAwvDA5Xrq/2Q0ctyk9CZAnENFC4VtAzfg/Kb?=
 =?us-ascii?Q?idFC5MDbPJ0bU1jZhbXE/xJQNaPBcnrKqO3CQhD7Kh6WiIRf+c6QjN3eiRCi?=
 =?us-ascii?Q?Wi87QKd0qOw8sfilXnwVNjK8L2kd5vTtrE3ExiBgcIuWLdnG9o4fx2LMZTr0?=
 =?us-ascii?Q?ay456pPWG9Wfof/FBPwmQANmUl6bjYXrnBgRULR+ktVzNoc2XBUDgCyYyrTi?=
 =?us-ascii?Q?41aLeqsnbe+pjBpNDRoLGjX/k2I2caT2twAJPJnKHb+nA7pm2rzf1jZvleFS?=
 =?us-ascii?Q?GusbuSgo9EGprxH8ikUCPzV9KfNdT/JVn4dOO7QFN8tlbA8iQlNKrGm/ANuz?=
 =?us-ascii?Q?6ekRvbeKKyhZgVDPdMK8F5rsJXmzmlbOhTF9nXlraMvlVOrGP+RIoaG1iZp6?=
 =?us-ascii?Q?mSDPFeJvgH4sQ/UcaepXE96ww0/Wevyk40EPjmF6k9Y77/0TpSaVKochqOAV?=
 =?us-ascii?Q?YChMqmeMb7TxEA9+xGIUAFhTGEQTtEtdBnrOduGrPy8/mtm2PTGGYbbNDwio?=
 =?us-ascii?Q?61b9CRkXF7NgXt4N+sj4OaAc7wV7A7yjVKWIifiokrN4XNts4wczyXUVFAzU?=
 =?us-ascii?Q?eKVzfE/HM8aGWclGH+mRffiny45PCWgTxdr+Wk6vfhfJh7WaRojWrmmrTVZp?=
 =?us-ascii?Q?2OFaYmKDtBVLbat5m6b0E1hLXOePvfS1aZ3pJSc3OHiEscwxlwyF7oKSdp6Z?=
 =?us-ascii?Q?faf0UOxX7tk+ZwSplxdRf7E2qLurI5gEc4DfwhZXEM2LWyhdOf4u1eS1Rn31?=
 =?us-ascii?Q?bUTRFwXwWcnrgZu2tZAA0W0KS3Xx+foQZumVlBoaz5zUXn0T63Pf2ExMGfJc?=
 =?us-ascii?Q?P9nPmzPzi2IVRA8b5xawEXCk7Tm8WdX0VRXmRGR2+OGMP1Y7P8cVJRK4hscv?=
 =?us-ascii?Q?yME9GTsqGbwgq4OBMoSwM2aoqjaaaKjLTkG9YzVlu249I3OXor3vhoefPqV5?=
 =?us-ascii?Q?CPalAhtR5otTa67i/kLt3+pN5ADBZDDxBOjFHB93JilbEMbn94OXUpVzCfcj?=
 =?us-ascii?Q?K6O6p+TdLhNPJl25FCx6oeGBgaRMss8zZgHTj/eslqQ8eOEsxPxRlLg5m6lX?=
 =?us-ascii?Q?SbVqGQp0QH2xelwLnMc0UOTT2BsnQbZ3f8tFLp4JwvPm+3MB+QImEVI3jQzj?=
 =?us-ascii?Q?cK/tkStYKNazbXQGAMPlFOU2X5g9eVWiDYEHIx1G8PsPgK1xYnnjdvBpCSqW?=
 =?us-ascii?Q?3eGr9rtbY6jovXAT2XDsVpkKHb6uejiO6EkYv9aGeih8fqduRf2vOqmORYUK?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef3d6aa-d2a3-4da2-4d48-08dbd92c194c
X-MS-Exchange-CrossTenant-AuthSource: AM4PR05MB3506.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:39:23.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L9CraCG254E2dLPlFbLorsywHRTic25f3fKHmGO11a9ogqPp/32P5Z6Wq0uyWH0a4tvXym5ga0XWcmDFVA717hTfyhdVkZCFsQJLXkScQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10691

On Wed, Oct 25, 2023 at 10:53:41AM +0300, Leon Romanovsky wrote:
> On Wed, Oct 25, 2023 at 08:59:44AM +0300, Ilias Apalodimas wrote:
> > Hi Jakub,
> > 
> > On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> > > On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > > > If the page_pool variable is null while passing it to
> > > > the page_pool_get_stats function we receive a kernel error.
> > > >
> > > > Check if the page_pool variable is at least valid.
> > >
> > > IMHO this seems insufficient, the driver still has to check if PP
> > > was instantiated when the strings are queried. My weak preference
> > > would be to stick to v1 and have the driver check all the conditions.
> > > But if nobody else feels this way, it's fine :)
> > 
> > I don't disagree, but OTOH it would be sane for the API not to crash if
> > something invalid is passed. 
> 
> In-kernel API assumes that in-kernel callers know how to use it.
> 
> > Maybe the best approach would be to keep the
> > driver checks, which are saner, but add the page pool code as well with a
> > printable error indicating a driver bug?
> 
> It is no different from adding extra checks to prevent drivers from random calls
> with random parameters to well defined API.
> 
> Thanks

I can see the point for both arguments so I think we should definitely
keep the driver check.

Is there a consensus on what to do on the page pool side?
Do you want me to keep the additional page pool check to prevent
a kernel crash?
I mean the mvneta change was also implemented with this problem
and it leads to serious side effects without an additional check.
Especially if the page pool ethtool stats is implemented in more
drivers in the future and the implementations are not 100% correct,
it will crash the kernel.

Best
Sven

> 
> > 
> > Thanks
> > /Ilias
> > 

