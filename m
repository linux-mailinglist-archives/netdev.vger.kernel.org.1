Return-Path: <netdev+bounces-56395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2211080EB44
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97590B20BCD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EA5DF3E;
	Tue, 12 Dec 2023 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWmH4fY3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1016AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:09:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF4y7RFrpblrNx2TpgCPVHU+V0rFysa0b4TrPaCCN4xVNW1nxGw7j3y4KoxGALAijjIFJPL3IdHSkHQjQfYLgKfoN6s5MMeJyhq1pEubsj9cPD6b2k+27ulh80LL49sm8qcKHmSEBIBKRRgr0hQ0ZZ2QtTElKVsGS96icKW63PWgUMG0Rr9EOXQYuJUEnhViYIBr42yEBlzR+niYG7t0+Oa1nu1qWU8mHAyMafX8LBkxwWVfEaRaiLVBxPmimIG2mR/At4IgRLA9Gd7JzssghDxB5tCii1cjSoq5PesJlZIo7Q6lvOpVcTXFExa954RqO4rLZeiJpSbjQWePbkG75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/H8kffvW/Jt1WTvuFyFudf5XiPbfI8X9DF8zQiMhgk=;
 b=E8d2zhqTkrcqw03LRqUWwcr8SzqX2WeMsnBdY2iDYjYys6uTlM91IEfWQoNAhUHXhQPb1hWooszIl7qBwg64KtIDFepI6x8hgFYi9u6ZJQBnLdpAiAC3bqXYIFSe/rMUHuW9tJdfmgb2CyvYZe7N4gvbKgo9XbeJAzv8mWqOPr5u2eBESeBYA13ecMH4HsuXP3cEraJ6sFAy9vbYhNtpHotC5oaDL3nt0/yyspVYJMYfFUtChTuYgIL/BMa5/jEumMDfmmVExP4lDiSSRxKZQSX85GpkcsPBVVUFPPo+AZ1kLOfu8KTnyc2cfb8HeIY5QVpkAPW8ie8ZDows0S/UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/H8kffvW/Jt1WTvuFyFudf5XiPbfI8X9DF8zQiMhgk=;
 b=RWmH4fY3cbkimXBCeDARsg4RS0juODh/xfdSOEM5rruoCt7XFA5MfN9eH5z1zqbFH0Azaxk07XIi0i/S2I62zNtHTCIvPyYYYaBGTpp0HGRl2TvFk8fJ1+ru4Dt/wvItin2K0+neyhZwlnt+mwVyuPWYwleAvlQp6/3tdDO6Ivo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:09:47 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 12:09:47 +0000
Date: Tue, 12 Dec 2023 14:09:43 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] dpaa2-switch: cleanup the egress flood of an unused
 FDB
Message-ID: <6ipoutbyuvlgj33k3ytmrrrtlikabpu7mc3ysv5wemfjgv6o27@wjrdfhg3vwvg>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
 <20231204163528.1797565-9-ioana.ciornei@nxp.com>
 <20231205200455.2292acf6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205200455.2292acf6@kernel.org>
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 942cbae4-e361-4851-f7be-08dbfb0b3b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mKxecF5WF6qGvfvPr33z/6OdYm8ZSCesPJbuNHhDT6KzF5xgnr9QuD7bmGEjXSAOJ77VHAh1WzA/P1HEq+bQH2yxrpYUoWVQ972w7nYLFgs5KF8p3hXfaS9zBLgSk8/7/pZGYIoYNrqndZXT2DEkS1YzfBZ9djkAxMUXQzuNPFGf5yfsuvaJImd5hmHYGQ5jCxM1XvCPe2v4N1uGCLmzL6Bl0C+uFlZH7LVwkBb/xzcgDQv8rQFN2xrFIzIxx2vu5YBa4jINE3OUEgU6OfDL+SgqOolXl7WREvhbtRnVVS/CXVXxgXdbL+3PCUOwnnjLaJpL7FQIV1QZJE7VS0nW1XeEvBVWWYQkDiLPzyXP2oWNZFIwDXc8Ui4BA6GWT7+lbd+ZMbWbvDJ6W/eWKN4+czw5odtVB42qk4P1aM6LFkuxXn1JN4r6w5uMPDsA30btqR7+wGooDpzMEh1w61E3hOJiNgwhg/6EilTMwce05SU7Moyo8p+oJsT1H+rnCdzx4Fu3YDR8XJF5Q68yJA1ri3RJb34Ag2Gavz8QOQUwJRxKcXUhYZJ4pAQQCodLNV1H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(6512007)(9686003)(26005)(4744005)(4326008)(5660300002)(8676002)(44832011)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(33716001)(38100700002)(66476007)(66556008)(66946007)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oj+AJqmcNLY+3yCTgzH1+KSmX8eULGqjYyCAmjkefbHiCkTnlgiGRl6A2MG/?=
 =?us-ascii?Q?6z3FXQAPDWNTXZavHkCWuTnbFxl6DIOZIRSP6EOaXBdeEE9r5w0VugUVuNpW?=
 =?us-ascii?Q?YqZOa3SGXW2bx/Gh/aGEAurACNnYPyQpWvgk3Cci6kSIRuFkpg2GVMmass/G?=
 =?us-ascii?Q?QMECuJ60OlAiZ9a4jy0qgmPqTBVioHaff5ISLkMYAGzKm7EwTwyj792Z7frQ?=
 =?us-ascii?Q?M5druoZMaoUkiHaldQQefAA0pucaNbt90VROIZsCoxVxBkb4qrScm57LCEUb?=
 =?us-ascii?Q?Y8W3tWZMiKPY+2GAUL3CmXKjlFEfpNY4I6cYZx09Pw3Qag/P8vkHXu977h9v?=
 =?us-ascii?Q?VPeQ4MA1akfhZIKXYILfrpj6Xedyr2qbSXPu5eUDGm0E1ckC1sMl+tVyu6Lv?=
 =?us-ascii?Q?IMfPZiGDCKSN4LLXEY+JZhDoHbMzI3fN8vWdIdnQDhQ5RCfnpzYjcIkPrkQi?=
 =?us-ascii?Q?6Q6FQzDCCIQGcElSJKizugS9lHr/ONX0YZv04AZHiotKHf5TWBquPNXH3kKS?=
 =?us-ascii?Q?WMvVYlU+apF6dOjA+NhRidnU3HhkRZdC7DpOsONWyxKt4nywh4g/0ju5kip7?=
 =?us-ascii?Q?ybRjTie9mIE7RPz/HrzDSKk0r2QaJ/gcHm+xcYb2IwqaxUFHk6A9vxzuOjZO?=
 =?us-ascii?Q?gOxmA53oYHHv6omv+1RKXdHWhthy4h8dcaeSW8atU79WjdIx9+tS+DzSoGSR?=
 =?us-ascii?Q?5koXk4yCaHjzkdWnKevqRRF7w8rQ7WPXOWh2XKw6zkSaP7dpbcd/Al82eRof?=
 =?us-ascii?Q?lK53dXNx9TGr9wxg1ynWg3UDyPR16wULhsg6NYSayCo2RpAGK4gFBrh49pUz?=
 =?us-ascii?Q?6t1hfNftWfNhB3pShLFQI/p/pwfLLya2vFpgeyFR3/Tfl2z6FPzmSTDz9i5+?=
 =?us-ascii?Q?marlrpB2e0N4ZvwpRs35z4MaHSyHZUidA/gpFGPwzwaoAKfc02z6eoCiGMsw?=
 =?us-ascii?Q?DFQ3Vw7JMsilP0xj7o+ePFwpkddAt4m9xqVuhH3uJUaQl3iRpg16/9BFXr0p?=
 =?us-ascii?Q?UHmyFXokdewVzu9YI/rvkk1V2UDC5yXCZ1gSdKGbjhDm1BkCYsEtjqVu+S4w?=
 =?us-ascii?Q?6fHQb8BgFuQKFyNrvXOg6IOqrsoO4da4hn3hgof/CryFpfKc3YVe1ZtTBP8g?=
 =?us-ascii?Q?0xHEazru7YYeD72u1wJbTz5It7YjgYOun5LOwGtKTBxQQjJogwXYqCKb3s6d?=
 =?us-ascii?Q?dwk/G/2dWw/PLzCIVxVXU+Ji2BVsxXJLr6LB3EPOVVbZrfmrEoCtIMOfYk2k?=
 =?us-ascii?Q?C2nhlHdRUVI32HyToasyQmJMt6harysoo/fRDoi+y8lKjr/PIVJUbe6niqSC?=
 =?us-ascii?Q?2YaxpNMsRWUeMiBw5gJhfy0fJRbDETBcDZcCyjtbVqDIQOTyUz3u+GpWiydH?=
 =?us-ascii?Q?T63CTQp6muFOj/UYuUwUHAaUUYrI1MaRnGOLDCM9ag1RhvXAyxDPSaKAGAX0?=
 =?us-ascii?Q?dIUAuVL7aYjzLpUNf5pF4sCYMixdLJl6c9YB7tRRlBO/WBDgwHjWlUp+wnwk?=
 =?us-ascii?Q?oH2viKAHG0PUfHUbGDXiuQBA+ATjpUFSM4nDh/8+ZdxR3qQ90kp0yeUb6ADm?=
 =?us-ascii?Q?Lqt7coLwuW/C4rZiZcPepAlzN0u9tjKqrTDF4WjD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942cbae4-e361-4851-f7be-08dbfb0b3b7b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:09:46.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2dkSS5Pe5wtobAmSqHfig6/RFNJiXM67dGmwSqn7X4uNVhMadu7T7Q+PjkcYXay39vFo9Yq7jBMLxDbPHTjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

On Tue, Dec 05, 2023 at 08:04:55PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Dec 2023 18:35:28 +0200 Ioana Ciornei wrote:
> > In case a switch interface is joining a bridge, its FDB might change. In
> > case this happens, we have to recreate the egress flood setup of the FDB
> > that we just left. For this to happen, keep track of the old FDB and
> > just call dpaa2_switch_fdb_set_egress_flood() on it.
> 
> Is this not a fix? FWIW the commit message is a bit hard to parse,
> rephrasing would help..

This is not actually fixing up an issue which can be seen but maybe it's
better to just have it through the net tree. I will split the patch set
and send some of them through net.

I'll rephrase the commit message and add a bit more information.

