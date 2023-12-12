Return-Path: <netdev+bounces-56400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E554180EBA4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C37C1C20B94
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E95E0D9;
	Tue, 12 Dec 2023 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSe9xvmp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B22D5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBlTvPCEZI+pCOm4GBcIfUzosMW5H+sGLUhyQOD0sHZHMl2XPFDxMNJ4Ipj0W9zcgc58OvTtCh1J8oQhC33oRv+VVKfXuuH0Tzit/E8eqU+aGVycBEZA5//XkomjY1L3rKXGKIcVJODrhCu16oHDN7GAhl/UP8asC7RT3iiiQeKKn1uzRaw9hsAazgIAf8k6niACVQ6+LRbUtkIScahIGsdVe9494JNW6eXyYBSsMb0B193NO03wCwooTD5GgiwaB91bZVqLS8A0GPMNIjQ56oXV/1SihIRhxrj9C3QfFWjHBHQlyi2NnaM4Ov4e0Re2JfOF1puCqZmstdjKBHMX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nsuPQx2DJ8XVChl+UfBumo3d1cNTmFsuTDj2SCrEx0=;
 b=VPsmYjzTZPwBXlsuAFu5CFKCDc8NR28qU0Vh6j15c7mwOQsXKzr0o/fM98LL4sFW06zuDaBnEvnwgXVeeSAiHtSLxEnUhWFpBjoMER62uOB3rOobyL1BP7I/VraLUnUVhigG7MG30aNP+q4Du00VUzZIjqANpo1SK3Cz2f0Q+38EgN1CJ1P/uxF6fSN3Aho5/EgRnDu0S8wg3OUoihG8wDaNg1IUUSKxLJOQyfELMKh6s3BA1D85H8K1qWl5ew8pHDlR+SXEkuWdfF4JhgcOVPlXMDiMxj57w4SXhV3115XfRLShX4rXzGZRMU4g6W37O9fuuxGZaeDjwG0uJ9R3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nsuPQx2DJ8XVChl+UfBumo3d1cNTmFsuTDj2SCrEx0=;
 b=cSe9xvmpFNdjWDHaijLPfpESc6/VGYMYt8E2gPAR1vzzCMqrmoRncXN+GecTO970QGZzMR3QFYZSgkJejJf75DY3VglWMJkmevnF1R/XkVBiuRV7NyVdsIa6O0m3K4OqsCY3VpRk/lptAPDM+qLjsdZOeWIy0ZDUkQ7X52TXfiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:24:10 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 12:24:10 +0000
Date: Tue, 12 Dec 2023 14:24:07 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] dpaa2-switch: print an error when the vlan is
 already configured
Message-ID: <axzzozleqrt3c7zymevveqlpmrdo6pxomxptur4xwzzbqunbga@uuywrb4wesry>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
 <20231204163528.1797565-4-ioana.ciornei@nxp.com>
 <20231205195933.1b1fbf94@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205195933.1b1fbf94@kernel.org>
X-ClientProxiedBy: PA7P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::16) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: bac90f10-bdbf-4bc5-1cb6-08dbfb0d3e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OS4sVo7i5Qn7jsECNybsvJP2zYIrwVB3i0zIaJO/1xCAcDvm8DfDE1CSRkHe8lISCVv6mFu+no19cVLQ1OaUouTTRWqVra8f6Y0udpK5FJwt96NklZbFAD+zZeZPCY4k8LFIB9JmRh53iosAiJioeJf8MTK4bT1PFWr0nBQFkIc68lIk+7epLjqSRx0DbNfaKoeQJGjBmiAjsuC3exxE0HexCu8qNdQ8OeIDXcoj5Rlqv/rsZazk6VL/fESrX5VrVRit0sVCcvM6xUT3t76Zd99+87Q9+AlhmUZdfy0R7JYvyrVs9ECsPZQRVrxOMlY0yuOBQLaqRFKI6PZLjMv8EV1Wrx9JZYb3GWATpb3LhxCfk0oXFYVIttgyy+enTxGQdCaCeHLdartGrhICLh7OVoS1bxT1bK21bbDVWyssZh167Pdj8prKcRRwBwT60noQijqRha63F3XW4ComcsnV813Vmt/f13NV13eUg+2l7kX1qPVoT68r4lUSpd+iOzXf8y8bnkUos0jGDTGWPs8Fg5LMjqA7/x+rVxYGSr7DmKf5Zxv6Xx0TOxa+MEHK9v5Y7phpfwcKcyFg8QR3CwIY84nI/mF1oVvFDY1bjfhSCXAMIIc0rBQAYyppuoyZf9fb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(6512007)(9686003)(66946007)(4326008)(5660300002)(41300700001)(8936002)(44832011)(8676002)(4744005)(2906002)(6486002)(6666004)(33716001)(478600001)(26005)(316002)(66556008)(6916009)(66476007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YV4Qw9hfroQIJlBsmtnWUove73WoPhRzXaqKAIghkecymlI80ZXRH+DU6Ihk?=
 =?us-ascii?Q?I9VAmaeXdEu5m5ZEMxnXC8h+yTODS/kLR0Sm9DQeuVrn8tsgLIxg1lGcDsLM?=
 =?us-ascii?Q?sS1fssddfAS/Tq8ppMww9lDv5ht3rAT2vtKe4sGOYV0Wg3Ym8G0+9hivJCMm?=
 =?us-ascii?Q?Kpx6hr+XfiUG1DK0K8UtTKzPwnAioFPckDpAk1tpAT31ysPJd8OwbZGVtXhq?=
 =?us-ascii?Q?SZKSXxQGG+EGEeKkWFRw2AEQjbNC95Z3ayG5HaZfseHOrVMt3Y1SwoQ1Aba1?=
 =?us-ascii?Q?NVMaTC53Ih2u3/5VZa4Ag63QSmzIUzVU0mL+zJJYU+6/xglWM9oViAUqsLhS?=
 =?us-ascii?Q?VnTNN35/tEFiDt44Zq/gETSWF676KFyqcoGEN52BcHf1qBrEawvcLv86Uha8?=
 =?us-ascii?Q?7QwpqzCRZXFMnW5cCwgp58+R9YPn9fiEepSK73w4qRCEBARzq9tzKsufudqc?=
 =?us-ascii?Q?AsWUw+Xx5yNHGlELe/gSQr3FqLS/gwz95dPP4UzqdpAa3UxJOC6W2Q0SJdf+?=
 =?us-ascii?Q?UjRuJJXxCONL/ziuzAom37E446ORKXfL7NT/zEKwRvqcTHkvpT+IYRJpt5GO?=
 =?us-ascii?Q?2OHp5qzaqSEh8jLuQnH8epOLDcjmtZr97+dRyyeb3Nua0Zvz53xMT4GSO7WK?=
 =?us-ascii?Q?cwRJwZ63kprU06CKUnCjxsmphf/mPaJMF9Hn66n03mDL6VV/oIhjdB55pLTW?=
 =?us-ascii?Q?/aVOIoEmUd++nGE1aZugTIB7t53gQElLxV6DB3D/vgeFvCwwF2zg/PuH0cGk?=
 =?us-ascii?Q?sz+xkHLldRP/V3iRVUkOlU4tHwYsiiIpWIHW76lAT6uZ/tHkuQHe82jpdt8X?=
 =?us-ascii?Q?LvAkG7zns9DDZb9VdXvZm7zpu92kynbJgwgn1mwHeLR1/0zIvyFTHmsRPmdY?=
 =?us-ascii?Q?4CA8kNQjVED0cFlCLjzfIvGFyc9cRsD1phyTF2Tzoc79/viLGY1Qpz6YIPVp?=
 =?us-ascii?Q?X9fyGRUbwHEle2GzC466Pk2kAH+FiFUDUBSvwzxbmosKpyfQb0LPg3Yn3Vxl?=
 =?us-ascii?Q?RBMBAndFYWM4DORXzteIbY1DOySmMNYCUA1lK1c1ckVj26xCNI1jLmjl2eLB?=
 =?us-ascii?Q?UGYPxXJDeXcNcmvPzEAyWuedXmsXqW4HPrYh1aBV5t4TW5ZSwKbAbz4eNcU6?=
 =?us-ascii?Q?DK8M6YzPDYTqu3wFay+57T0seDh2+dPaUgQzDnh4219LjDlpRMgaU2tUU0Zz?=
 =?us-ascii?Q?eCVomQgfzgflJgaocOitDwmwfeXFQ6LmKG22cqlZYvRVCCYgIdcV66Ec41Ua?=
 =?us-ascii?Q?GTJGnHgv+54tgeELqk1yBHZGY2nSVBkVPMJzUUxOTX4byNJzm8UDxlrc4ICt?=
 =?us-ascii?Q?hcJVRsXvC3qxaZNG9eIE9U/N9iHWoNzfhuTbK9+O9xjgLwzo3F/bCmMe+mqf?=
 =?us-ascii?Q?xBLB4lyjpzIMfTLj7tgfs18x0JH9ysNSHoSptI9NVorNbdNAZh5APtqP8Qdl?=
 =?us-ascii?Q?CBK/3dQ7u2dlzIbQufJpRtxTvoeSc6pgfTymdAea7KwB6J2M1PafUIkBCdIl?=
 =?us-ascii?Q?v1DxlijJKmZXWsdWo0swHkacaTxUE1CW4B65bG0kIAkLZ+CzrVw0+twJmHJD?=
 =?us-ascii?Q?0ueMdO7MFbJIWtrvjpp4NBxjZ4Lt5CyTIq9vUTDd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac90f10-bdbf-4bc5-1cb6-08dbfb0d3e68
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:24:10.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKcTdsb/FCf5od5i+2xtEoXOQQS+K0TajbRkCyDjFJB6MCWUU0cPiqj2rXYpINJ1TugfZ26Sr98dTDDlfIsdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118

On Tue, Dec 05, 2023 at 07:59:33PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Dec 2023 18:35:23 +0200 Ioana Ciornei wrote:
> > Print a netdev error when we hit a case in which a specific VLAN is
> > already configured on the port.
> 
> Would be nice to cover the "why" - I'm a bit curious what difference
> upgrading from warn to err makes. Is it just for consistency with the
> newly added case?

Yes, it's more about consistency with the newly added print. I just
chose the err instead of warn because we actually error out in that case,
we don't just print a warning and continue.

