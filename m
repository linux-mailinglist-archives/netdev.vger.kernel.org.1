Return-Path: <netdev+bounces-32290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D0793E8C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71581C20AE1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80014107A0;
	Wed,  6 Sep 2023 14:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB29D513
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 14:17:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1910D5
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 07:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMxxAmH+gyob+ddhMaPNYpM7Wmzq64Sqzw8dcDHNiU8eAom94dvKRZAkiNSANdWkd7T2CCdI/mi+847jXpECCSMkOZwJPCswWlb/NLVxMesUAdAZhK1cQIL7TnwhN+hPw3RP2WembAya4I/60As+18xB740kMmOSkNb0IqVGQnXTjBdckuEZ1e75V7OhuzvruE6fEqiGzZBVxKQcSoQaJnitYFV4E/NakmOTNPiq5CbcQ8Su745PIBiCxIu77QvOMnBI+8JlvOKbpUvMJhmtoU9OLAT+Na4hjcR2aj3/4nVosa7Aa8/QbRrIOZw8b4GkGrDVdEPJfXGVYMGkWWknQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L89Q14dWqKTtp9JcyyGN2SFDW+XcFR6hVi3WqsEcRY=;
 b=SNJl9L2hGATInAHAPAUz0qFBgiDoV+F1DLHaDSq9I+Q8pi5R10lpRB6x3e/STBSN5AU2cN7oG9TggP0YP1tmRR9fezq9gC/Y561w5a8hzWpsR0lq+AXBbn9uaF0sxg3wYFJfOBfr0vMC3jCMfAf4/mAEX4UTwbhxYe88kpP9ADsm44fiHKLgw/yPe9gkvtbYiLkHgoI8PobqL+1mq9biYL9xH+IEz2B8Uhlp1ORPR7KSj5nobgWxK/RQqOCTwjIq5fNqNXkIRo0+OmFVLtUQed4T8XJy5DG5ntVAcqXaHbJWqdpO6MOBQhps3Gt4ozZNaoodDHOxO0+C4U85Gzn0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L89Q14dWqKTtp9JcyyGN2SFDW+XcFR6hVi3WqsEcRY=;
 b=B1hlspqUM5ZwPf/J4SwkFOfNg1qWL8keg++pjhvHIAT0gTRUGAKPC5godYSd4UJ+A4JVqqjQS9vvNaPXHFTM5J6gyoIqMyX/xWq0QvsguZPRAjcxPYqDTRrPKbnJ6dLkud0rxxseugeEc2z3IzOJ1Nl6pzr4EwLnloDfnlnW280=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8375.eurprd04.prod.outlook.com (2603:10a6:102:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:16:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:16:55 +0000
Date: Wed, 6 Sep 2023 17:16:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] net: enetc: reimplement RFS/RSS memory clearing as
 PCI quirk
Message-ID: <20230906141652.a4dschg2jbobzcoj@skbuf>
References: <582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain>
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: aa04c17c-5970-4c8d-b0b3-08dbaee3eca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s52zl3XneTyqZ8WNlapMrOMekl6YKosLh/B1bcRGzFYGMgzBP2ReDEv0erIBb7p+fdvBdOC7mI+R1tg93veBJfwccaRBq9tAi2SA2J7xWoBnUmRsSuPVN4XhRR1yLHgWTnnctXtEzLRGs17q8QO/FR1y4iYiMJPpHWeX63A1UvnztNCP2g+8biB8mnnwCzZYkHDahX56qoOaYHD+Sd0EPgLWCt4/7yoE+tJggClQRhMaHdlrXFHUnN59bIfBpnR0nX36M0jdfg+cyQIpv9egSvk0mkl0DH2HEwtgsa7HSvOzaagaf3yQMANo0EBfE0PmEBZpSLOnx2LjFAKb1Ef3AuMWsDAMbguWjuBHDjSj92XeUqEjwNRxxyfUn+IRdsUbfb5nyYkpa9isT+2B+sNl+q5SDtgIEYiDYRosyK1b3CR+vVXPr+LwlrE5bbyc+9HcycpzcavScCbmUFX0Qa9C5gWvxXbMWAoFG9wKJ6VeWY9KDXN+qMszDnQ29YEi/uvtJIDGbHEMUZ6ZMQiIBDs2tAEJovFme7TfJdDHz6hA1nsMWnBWeCnKax16F9yqMHEV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(41300700001)(38100700002)(33716001)(86362001)(6666004)(83380400001)(478600001)(1076003)(26005)(6512007)(9686003)(6486002)(6506007)(66946007)(66476007)(6916009)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cv4uK4xyGWNE7ztLWz4eBLFuI6NlMARk4j0sq5tG7btiMuv2IfY8k96+6MbE?=
 =?us-ascii?Q?yN0zz/JF8Pu0Bi+MQ/QQ4dTrp028TVTG4k/FNILmst5UMkoeAuWO3kuUBuW0?=
 =?us-ascii?Q?sQxIHs2Drlc4SUcnRnfGixykrVXL9RFNpVT4t9o+Ek3wAC9Xj2ZXmQT25EC9?=
 =?us-ascii?Q?kmCVLYVQZtXAU+4kGttx9RTUpljhYOPs7MqcIVC+sy4nABIoxSCK4D3ESXqa?=
 =?us-ascii?Q?130E1DzkCEXHGvdStbKZBdGTOWf0mg6eiT9J3auHmseKK8ErIaF/yGg7sFOn?=
 =?us-ascii?Q?ik3NjdJe0DLsXEeYick9wfsHJXldzgUUbjdRetK8/e0+OCRToJGK7O3knnEK?=
 =?us-ascii?Q?889hDbpNZDtMkjom2y7PV5ZqhkwUafBxKBpr36ls7KBLM86KlHhNRQSTG6T0?=
 =?us-ascii?Q?zrq2PJZM5Z2j6hcCrXvRNh57PwRwO/Is+MRrHL8IjUjeMF4LzTItdPofB1+S?=
 =?us-ascii?Q?YvKyA+J2dGCwqUCeo2045Mc9wPMQ7CwCrnveL2xeCbKbRsKJWl+c2JshcevA?=
 =?us-ascii?Q?N4s1ES/hbuX+4mAjtC5kn7RGNz3Jkr547a9WelZJyNtOzwLSYuD5J0viUhbI?=
 =?us-ascii?Q?MPefCxjT0bgWBv+mMDnPM4L2EU4Gl79qMlSF9w+Dk9TQvH9whTTBhSxgIRCy?=
 =?us-ascii?Q?KBeaLAxci4OSAz64ssy694i8/+uatEQfLab5+Z3NRZsY3GaCjy7i9Sc9lfYF?=
 =?us-ascii?Q?7pd5kwvOx4svNlEE2gGAzLjPoMHMmn83uQXntq54f82gehEXyYvCnE79zjzX?=
 =?us-ascii?Q?5Q7S/TKUS7l5FJcIUVFTH/hq9EDYrkeFWMS/4QAlaN973t7zkNxgbAWhmJDn?=
 =?us-ascii?Q?DLmQEWx6m7EyvTvZQhEY5bAhLIKsw9TBdrRopaPT0FEP9JcFJsNQSMlO7gK0?=
 =?us-ascii?Q?AUZql+QfrzKGaMd2bs25ThLhWZGTzydOKiAQ9/aiOuTqmTNT5J97tsly4U6r?=
 =?us-ascii?Q?M4SopyBq+H1Vz3uqEISD16YSQ9rqFs1gT+sMlf0Ra//Ht9yIV/+Q8Oi3r0rF?=
 =?us-ascii?Q?4RaRH0fByKIRrXsAdVWLhq8aAF/aCR/QfwG7FJpM39VqHReUNf2WRykzAN4k?=
 =?us-ascii?Q?GMwZ0Q4yaMFH39UhOA6d6UhNCL9zlVIi9pyX8kQe5IfZpUzkaBHGZiq4VEdw?=
 =?us-ascii?Q?lIytfMf4VR9t70AIP58DRZk7cwv4M34JDr072FyquFHmj1DdNk40h++lGjuo?=
 =?us-ascii?Q?hpt2Ik3g0i6Hukwm++XBVgSHAwRduxVHV+t5AEMJw8k38cy8FOGy7yVsgW2y?=
 =?us-ascii?Q?AbDID90qq1q97FumgZGvrGAlnzgySyjtnHm5EmCYwnkGG9HWX1ovtA4Vu9kV?=
 =?us-ascii?Q?WFcazFBLc2PH+uHWdzrrvn7LyxXt3oANsGKmUABXMS9kCnX3eC7u7F0pjmvT?=
 =?us-ascii?Q?XkXScS8IjYR75xhZMzziimEho2EtLdvZIZ0zperJ+kkvgkVeP5xg7uE3F/3j?=
 =?us-ascii?Q?oJtfN7a2EzaZ0X3dwrq21lFvAxMRARoI4rq5kUwgZCEIb3oBq2yAlT+YHGpB?=
 =?us-ascii?Q?X8UkdgencTTQMaBHR/JACP4u4H9lNQACfJIKxU2+8XCpYgeoiPShYNUBrzjn?=
 =?us-ascii?Q?/L6rTHG2Lm/d5VHlmyZ9dE3in9AE4uAVvrUAC9ZGTD68JxLZ2ErUU160QSrJ?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa04c17c-5970-4c8d-b0b3-08dbaee3eca1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:16:55.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfjk87NUrx/LS7Dsfpf32+mzNqqnXMoq2cwBR1LiOOUW7+5qcimP6jwjp+TkozPRvndiiM03feGEHdbE75mjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 02:48:20PM +0300, Dan Carpenter wrote:
> Hello Vladimir Oltean,
> 
> The patch f0168042a212: "net: enetc: reimplement RFS/RSS memory
> clearing as PCI quirk" from Aug 3, 2023 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/net/ethernet/freescale/enetc/enetc_pf.c:1405 enetc_fixup_clear_rss_rfs()
> 	warn: 'si' is an error pointer or valid
> 
> drivers/net/ethernet/freescale/enetc/enetc_pf.c
>     1393 static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
>     1394 {
>     1395         struct device_node *node = pdev->dev.of_node;
>     1396         struct enetc_si *si;
>     1397 
>     1398         /* Only apply quirk for disabled functions. For the ones
>     1399          * that are enabled, enetc_pf_probe() will apply it.
>     1400          */
>     1401         if (node && of_device_is_available(node))
>     1402                 return;
>     1403 
>     1404         si = enetc_psi_create(pdev);
> --> 1405         if (si)
> 
> I guess this should be if (!IS_ERR(si)) {?
> 
>     1406                 enetc_psi_destroy(pdev);
>     1407 }
> 
> regards,
> dan carpenter

Thanks. I've submitted a patch based on this suggestion
(Message-ID: 20230906141609.247579-1-vladimir.oltean@nxp.com).

