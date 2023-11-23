Return-Path: <netdev+bounces-50429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EA7F5C55
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182F8B20F84
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918C21106;
	Thu, 23 Nov 2023 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrBJHrnY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529219D
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho+cHLChuwUNypt56V4PJXAA7ak1GgTu6yMDQv9m/ifE9iFcc03uE2b8TN9mdXJ/l0HmWs37RoEzXwYq4MiIo6DY4zt0K1B7y6aoyhnRtbtRpZLYvInOBdi1gOgpvSwk6N4G/ySawER5GVRD99VvK/VAelpf0udKK0EwUrLic3eylxLUC3s/QOAxps5YcemjCO1uDYkonb//gBe3lz65sjMZSMSPa/L5XgVHef7B7tr8PeR5hSih9aIc0zV6wJQg+qPYqciFf5HKk2da5GPDWo+kDOxYlOcnEDVwdhkLtLYUaKC8tjk8XSjv7jznGJK2nL9ZOj+Gaa259D8WAN9j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYyCxCxS3P3+z8MUR4aj+J02D/4+PKwCHFihgGphUWU=;
 b=OLaaStGKAb4YjFGJ3HKN0t1jo8r3v0Xp6nR/eVyN6ENLBSzMrxKcBcxs41d03g9IbYhX653QZuFnMBpXED8KqIf1LavT+uOKjzVVL34LznRV7v/sZTJNPLuTLclH4TbC285C/SrW4rbyBs9apBTCWF1o/85luUQHRSUoLpdfy69fEZVqw5kvIOr0g1puaUt4J+V/G+nSOBM5X2YfYJvLUgLI2UN6oi09OgKi5UZ7RxweSK1j7VPvWNbZ07Cpmb388Lm9qPhpZnwbztzDeEwTjOcoHQcxo1sLs+KYk0Ry6+ukPiaWZDnVhu8h8U3IVWhbJyBNp6WTCdD0FXgN4tHUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYyCxCxS3P3+z8MUR4aj+J02D/4+PKwCHFihgGphUWU=;
 b=ZrBJHrnYtpiARyMoNNRerOM7jW9KyyrEBxY61xIhRIidjHxBTZ8fbynvLqfrD40kW3m5JEgDweUoMSHGzPXZiyRczgh3A29njWcl44X39bT5RzVzStOPOwST9iZ4Fjwfw2td6++oPkiUrMzdBQgthMPbIh0jsj5v9Hl5Emtv11M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB8787.eurprd04.prod.outlook.com (2603:10a6:20b:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Thu, 23 Nov
 2023 10:32:05 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:32:05 +0000
Date: Thu, 23 Nov 2023 12:32:02 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/3] dpaa2-eth: various fixes
Message-ID: <20231123103202.3mfz23335sfegh55@LXL00007.wbi.nxp.com>
References: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
 <ZV5OzJ70dW1WxeyQ@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV5OzJ70dW1WxeyQ@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8531f0bf-1ecb-4f5f-5582-08dbec0f6fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1sZGH31ABfCHUPKrPEbRp6JHSgJtMlTAOfsVnxvyQU7QNbSNeZQum3o7oBvfPRhf4cYzIMb2pGFgMO8ANn5L3jYqtpecrp9lwu6U+nIRSizXsqLZkJVNB2Z3s1XwjatmBBtBVgJcjlXwLnliSB4eKii+hkGGFWtcVSFz+0W/N8apZBATD6a4Zv5+kdlJZSj2Fl084ssM0wnj0oofQUHn0AUeGR5w8FgZY4AtIJsOPo/Tth7OiGyCoSszYsxEd/1YsIRUx4nY0yFDevXt16ncl6DCXeX2+rwa7TNogl9fWmmxkePdstxR/eWcm2HMUXbKoypMCmG+ZSRFywAK1Z0mPQ51uOenlQLxvzzkb7F0J5jj2DAjqefMC42LDqWPA6a6zP0krLkjeJlvjqGgNUfnLlGEuuORYpCSRhCPfwomUxqXtmAn5Hhr1AE8SSVsA1kB+sRjb8INy/P2fn5E9Ms01sf46Biev3QNg4IZ/i3yxmGtPouWzkJ/TsuuYRwEzO0waGv1/hmoFnlBgZiwn0h09N4/jyOOmIrl6ppgEJj52zW9nvwcyLXp5KmWEXphaKc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4326008)(66946007)(66556008)(66476007)(6916009)(8676002)(8936002)(316002)(6506007)(6666004)(6512007)(478600001)(6486002)(2906002)(41300700001)(4744005)(5660300002)(44832011)(86362001)(38100700002)(83380400001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0gSehGm0tqc7AU/IVEmTuh63FBwtGU0ZMLDK81A29G2ErvuVeH1DrD4dFud?=
 =?us-ascii?Q?VUcr2jGGYfcvGbG1Dw9mfjJFHl4se+McHY8tUUeL+21+tnjPWKW3kTuhMBkA?=
 =?us-ascii?Q?1v1U3tn2y68oEza+BpwggcrNuCd8PwdTmtfzD+G59VgzZwfaoODcoIMa+ETu?=
 =?us-ascii?Q?kNhPLN3VRRuWMVomt/eK3jIou/6WUeab4nai5eavC8fjZpBIhXzwbAcMShc1?=
 =?us-ascii?Q?GYpJJE2FUtPO8UE3M/QnC+k82kqAtLGJGffplmWdg4FyoD8+eGT1e8nnS7sO?=
 =?us-ascii?Q?UG6H6tV6BOesq2Dhxy3ssZsa9FJRC24Kio3fhkGoL8X0kjSSBqHerGZy9jPz?=
 =?us-ascii?Q?mKqF23+WMPLMvCB2jm2nqgDij7jEEwbfUTJSUukTHiodau6KYzuJdA8b9W0C?=
 =?us-ascii?Q?WRaYzAm8JkYAJwrVROHPV2GcQieuIzLFLSkCqLHQoLGji/d3SlgvtRDTMUjx?=
 =?us-ascii?Q?HfHttSRaTqZxxjtcfIyTALGb2cICyOAMLpDYSOmvNcpyZSvz4M2L/9Wo6tpN?=
 =?us-ascii?Q?9ddR4XKbbgm6TbKmXY6Ez0tSIsr0UsI1v+06dB3Q6V/5IQgbM6YRNnXk92Ab?=
 =?us-ascii?Q?tpuTodjI0pdQZqPO7nwCY/3FNdHhfadqcI7uAWbaOOGXcog8BX5P8sSXQVfS?=
 =?us-ascii?Q?hwcWwgArRD31lazCggxyhhK70LybvRGcRbyud7HIyL9QEE6lmjIYRrEAcRKG?=
 =?us-ascii?Q?48mx5+dbGxnXRflZDK5FSVdm+Pgu41pmSl1ZvUT0h9/n4A0hnznGR1pDyK/S?=
 =?us-ascii?Q?z45iEsklrR7Fder2b+y6fAB1T4gJcwoZqJG/t8WVJhWrrbLDwdpYAx7ogtMy?=
 =?us-ascii?Q?Z+k4Bb0kLekSTlnka0EbZ/RY6D5/P+KSVrJW+JwGkZwnqzfHgR1QoShdu5Xp?=
 =?us-ascii?Q?zcv0J19r1ivzKlScT7vKVdy80e9wuJKC0i7FyXXLAOVSV3/xLHJc/uMFucTY?=
 =?us-ascii?Q?lv9L6QSmsoOA3hvDkQXe/gTmg4EDC4+k6xWC7RnsqGlY0rjDk4yuP7s+Bx4L?=
 =?us-ascii?Q?cC+mCHvoVshminzj8WIFlzqSLjgHfGZWR2iYvPTTlgm7hh8kkVg91VQJUqIO?=
 =?us-ascii?Q?pBhzimycy14fmdvmzDmxpC4Su0EJboS5d8P6BEezOhDnhFFOln5FUL5KxqFK?=
 =?us-ascii?Q?C6NfWtm4BVffkP04RtLSKzkYrM2gY3DhuenKKOh5Irlc+t6hN7hVM2L3Rioi?=
 =?us-ascii?Q?Q/AskV3SLd1qRosiVMkhsCOMHrhdh6/w36xbnG92u1ZXYljniQhvIAoLQM7X?=
 =?us-ascii?Q?d/tOceaUl6hBSRVVbPc/38emTKZUX/4UByZaKKs564b/4ZVrh7xr+/10LFQU?=
 =?us-ascii?Q?/Jt1bNL0fnKNxHN84A9TnQhDt/cJNVOBLtxa5F4Q3zVGFHf0onRY6jnuwX9d?=
 =?us-ascii?Q?SZwaVqaYOSduGtcvI4yEn6Hk7xC53wwAAc2q0QaZ0fnrQ2EOFJAjvgC0Oppa?=
 =?us-ascii?Q?WIaGIjxxNbE0buxiK3hWVW6cETDmLftV9HO3htsVxc1+lhZk7yngXf+7XpMg?=
 =?us-ascii?Q?o7mjl7AI/1trkJmyKPZ1e3TG0ruI2UiUqS4uYFiJql8KeI9KVpeJDbSfqO8F?=
 =?us-ascii?Q?n485vNOWaitS4NQs5A36xeFMRtNZKJp8hVTg87q6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8531f0bf-1ecb-4f5f-5582-08dbec0f6fff
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:32:05.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpvowbGFIKE/JNEktEjV+v68DfEMPdQj0gSqGDl8nl4yQtSY3n8IggKk0ACs6ecxIC4Xu8COxGHdkLAJdqsX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8787

On Wed, Nov 22, 2023 at 07:56:12PM +0100, Larysa Zaremba wrote:
> On Wed, Nov 22, 2023 at 05:51:14PM +0200, Ioana Ciornei wrote:
> > The first two patches fix a memory corruption issue happening between
> > the Tx and Tx confirmation of a packet by making the Tx alignment at
> > 64bytes mandatory instead of optional as it was previously.
> > 
> > The third patch fixes the Rx copybreak code path which recycled the
> > initial data buffer before all processing was done on the packet.
> >
> 
> I think patches 1&2 should form a single patch, because they are supposed to be 
> backported to older stable kernels and this is hard to do, if one of patches 
> lacks "Fixes" tag. At the same time, they clearly complement each other.

Ok, I will squash the two patches and submit again.


