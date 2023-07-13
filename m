Return-Path: <netdev+bounces-17568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE575210E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE151C210F9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D013ADA;
	Thu, 13 Jul 2023 12:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031413ACE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:18:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE519A6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvy+owPlFDzpbXYoC7JMvMK3qplX3KF+bHBiHAkMQ+NDNq4KEemXHis9VF0RGPtHVo2E7hAnbwM+A3aRWHF3Wk+FF+OZldc1u6OD2NRWuZDTEzZqWWvZxFFU2/gCPJ6oO4r+iAepvw6jpr70gLjG+NOUGpnZ9eoY/M2SJ2Jzlaw0ibzfbBpOgrelcXCg/JLURc1p/g0hS6EHtCj/ogBSpR2pa5mVqWZ3qarC+5jSEao8XMBznpJVvSkk097OwqKM2nryU0lOJJG6j/ONEGQ+Zu0mq/uJENRg/ypkuf0IhXhPknZtwC2yq0EeEK9T8yKrQENhURjkF4In4fEtJJuixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80xNOS/Vm6eI4NKqCoz5kuksYq8a1n7PohmMM/nsNTM=;
 b=Ve2lhcjqWxuwjH/aDEGTXK93+o0MryKdlovubaJGH3oBTCTZD3ZKnV5QmJvlQfwu0oJxXh9Sx4qkVppiIBOaHDZ8O1edOSklhN6Pc3m1c67FdR8z/73oirHbe61Mtbk9vFb/K/gDwPDkHMvNxFIvGv/TnCzbildjb42Eqqi5RPr98XCkUpRP5rPUbIcF7Wx4Kl3tzk2Ll6mNbWT6+8LqiXESN7AlS7B86cWSDWMdGypHGVlmlnDK880x7+juRSG6tFy3NOww22s07iJBMtfqHQpCBmD4XZuTVXO2UBGJ6qAx7fuDS2ASt4qeRA3VU3ZMNdH50Hh5n5fJrExy0mFBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80xNOS/Vm6eI4NKqCoz5kuksYq8a1n7PohmMM/nsNTM=;
 b=M1v8WLib5icGHzfob1+3j+YgBy1b7AAfrxBr3phv/ln3bnaYwUZSA3ijW6kJ1uBl0Y8VGG99Z8UntPtMjQ/rH1X/Mr9fFUa0tliPbHZIz5v2M1VtEhMw0IK8XpAEARJCXYKbQJ5z5o4YTD/11G9gRYDkjTeA0rW22dlJe9EU63Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB4408.namprd13.prod.outlook.com (2603:10b6:a03:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 12:18:40 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 12:18:40 +0000
Date: Thu, 13 Jul 2023 13:18:33 +0100
From: Simon Horman <simon.horman@corigine.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/rmUFPTr2pPhNM@corigine.com>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
 <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
 <ZK/V57+pl36NhknG@corigine.com>
 <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 522668fa-501c-471c-9edb-08db839b4a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVtNa2VgPUMo3o/H/0tpTGQabUZnI93O1Kg8R9f42AK9cPDHE95W360nQI1LlQJAx+2/G5BrA8UG0tqn4+hWgGO7CHmm0EsFY+SGqn+LPCSGHlSXxGF5K4oi9U1fIrvebv2ENwLJakRLukdaZ1KbJl2BOpprSpChclUjS8zMxfhnKVdeWBf1E1uZ6VXd/4Wj6ctbdS8okzBw+/G9ryIwRpqQinpN855PykDedi2Uh/6/ofE6/AD7iamsBT0yrdsVPmFy1EztFPEQIIJ5KpY887Jb5SMZE1TZf1NAZT8WLcgzrvDiKvkDSg0Y1TY+Pe6sOi5Pu7OunN6NW2d6Zm5JSDXMkhv7ebwXnPwW3DiQdTHG+y666gGbnwkazcGf/ZY4Y8CLS6TRmbzVP4ZDzZQv3VesRTG34QP5vUla2RlsfvF+u/DUkZideCITObJIvn7XESZ24WyI7xXhjctDtFMtwds2uws1H+Mw904+7O7MAeeIOXANeVWsZDlqP09KdmceZpN2JcSLIxaOprSwdfrqCjnQx3PX8GviRx8lHIeLkoq8yacugy3C6OcfQGHWfW7SsmggEZmUIcZgzZxZu/8vuEifuGCMDsLS9GtHPNMqduc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39830400003)(396003)(451199021)(7416002)(44832011)(4326008)(6916009)(66556008)(66476007)(66946007)(41300700001)(316002)(2906002)(478600001)(5660300002)(8936002)(8676002)(6666004)(6486002)(6512007)(26005)(6506007)(186003)(36756003)(83380400001)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W7cqeIwo7ti5nk1t8zrDtoIiz3QKl9CWm5NYsVQJV9MPPixlT9Ez3N7anOtD?=
 =?us-ascii?Q?/UN4c+JzrTlj+youoUAKI7wsyiM1FBR8i9b8dXqQ7zF7IdwaQjtoVJo1+4cZ?=
 =?us-ascii?Q?Eq9xmrsCwEp+eZZtSLq2IcuuZoQ2WGLL6Uy+v8h+jFqLTffhLwbxl/cC6ezC?=
 =?us-ascii?Q?YPdLl9beD9Q9GzY8XTukQc7UmbIdW13ZBoVb21o8CzUmNJh8sOFrF2uarkDD?=
 =?us-ascii?Q?bsQ0Rfa1baxgpNT4CBp9BOPTRrH/SPVxVEfoAniA+bswLSh8vH+hI1mUo2X2?=
 =?us-ascii?Q?AZwwGyfq/cEfCtIh3cCkzQAZWJqzNe6Y4PkSH6WmWAgvod20tCJpLarFZ+ft?=
 =?us-ascii?Q?ZIJg5z6kQTQ76Fz8+aXgE9qFq/nV72yzGBZTUitmSJmi+awWLs+HU+UMKHGx?=
 =?us-ascii?Q?uEUTYO8PLD1osY8OTwd+TV+UqIaQwJBrZqf9qhxwtNf/XBbvYZWb86LG48O+?=
 =?us-ascii?Q?T/x9M684V7ukQlMDstDTD4vu9bx1SNwAX8kPv+E1xRrsh92MIQrqtIeUwaKi?=
 =?us-ascii?Q?uqR/t3diIytj3/oOIdFFhEkO3hafCFL/fTjXb/UfZWel6Z6jdSbytGNcj1Nl?=
 =?us-ascii?Q?mAKenDLBuqCRs2zlw7ftZxpDw/fczlC8E0QPNhx+wnLzNR+i1PPp7vKtdQ/d?=
 =?us-ascii?Q?WMuuDBR7rpv+pXT3usDXR1iX3ra/M+C+RYXTHJqX9OTXdZoOOOJkJmqvYPgr?=
 =?us-ascii?Q?ld+6ci2Nx5rUPrXrSCXQ8UC7jIXuYBrpvmeoreSUsZYyQ03qZERo/EmOKFsx?=
 =?us-ascii?Q?ogsu3xJ3VB2GXa2QNYb6ORGhCq1wYuJcuLo4BEXoLCDneE1h+Nb1bNJUf5O5?=
 =?us-ascii?Q?AQqyWk0zPi6IrHvVz0EE2nFF2Q1vNw7LNDaFXtRBzL6S00xwu6bzUwvT+3yb?=
 =?us-ascii?Q?piMcphwLTAAgeB4QPCJwrN0guWKaorh91Lw/pvHmThgawyzL1p3pRwcFbta8?=
 =?us-ascii?Q?utqm6hwIiCTtttbBZrEHQOi3QwULxRr+5fYWHYi9nvHIpbxYKMR1aA3OL2EQ?=
 =?us-ascii?Q?jIwmnj+OId6xntREmBFvf/xKEQfcvWpNazM8Vgj97bfge2fhte5oIezdLcg7?=
 =?us-ascii?Q?V4uJjlY5zaT7/0w18GRbiA3+McW/eP+YS1rCtqNMi3KouQ479Xxo8aEDS+/X?=
 =?us-ascii?Q?eo2ABci3flUX/zLOj1J/w1E3YYt+nNUawLOVKFjYD6LRk3/D+TPv9ZW6cWgp?=
 =?us-ascii?Q?MU5w+lkP8R2bEk3PP+oW+mgEu0aeOIxwRYbRKe6XbBkWJpV51WFOp1w1Wpf8?=
 =?us-ascii?Q?sh0e9DybIUuScrwe9kr4w0Y2ui5G/3V8uxbnOXpU0HDZKntNNW1QooPRxb1Y?=
 =?us-ascii?Q?5ca4y0j9xGkN2Z/BtRmnbX+AOcAxBcNdIJKyiU0BFTaxXtIBc/w7sIoJpRm8?=
 =?us-ascii?Q?soYM7IJWch515zWyX5rUAHv1GYx1atArzHANX1xocH+PF1ik9dJnAFSB5UEL?=
 =?us-ascii?Q?kKH8BkyL6WdOv8jIFGpzBSC9tHD2iGvKqQItSY3gk7ZKB5ha9iKGrWjBJlQ9?=
 =?us-ascii?Q?VDfW8dX8GUYYymLKhqlBQLMno5DvS359t971P7STIe3XGt4cF60U+L8tANDF?=
 =?us-ascii?Q?dOHlxeDnwRa5XKwveP419KbIw42wJJgYwAqbHyNJ2cWC95Zqa4groaCSd+kq?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522668fa-501c-471c-9edb-08db839b4a90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:18:39.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEhA9GPMSOanBlEyI73c0oi2e75u1UhJnoIV3p5HXZ/k1x0xFrIxtKVfXPYEN75RmNfkrUmtiBNUinM+4iM+icqIfnvkQxxphJdJOSo/Lfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:53:42AM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 13, 2023 at 11:45:59AM +0100, Simon Horman wrote:
> > On Thu, Jul 13, 2023 at 11:35:05AM +0100, Russell King (Oracle) wrote:
> > > On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> > > > On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > > > > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > > > > it sometimes does not take effect immediately. This will cause
> > > > > mv3310_reset() to time out, which will fail the config initialization.
> > > > > So add to poll PHY power up.
> > > > > 
> > > > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > > 
> > > > Hi Jiawen Wu,
> > > > 
> > > > should this have the following?
> > > > 
> > > > Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")
> > > 
> > > What is that commit? It doesn't appear to be in Linus' tree, it doesn't
> > > appear to be in the net tree, nor the net-next tree.
> > 
> > Hi Russell,
> > 
> > Sorry, it is bogus. Some sort of cut and paste error on my side
> > that pulled in the local commit of an unrelated patch.
> > 
> > What I should have said is:
> > 
> > Fixes: 8f48c2ac85ed ("net: marvell10g: soft-reset the PHY when coming out of low power")
> 
> Thanks, but I don't think that's appropriate either.
> 
> The commit adds a software reset after clearing the power down bit, but
> that doesn't have anything to do with mv3310_reset().
> 
> There are two places that mv3310_reset() is called, mv3310_config_mdix()
> and mv3310_set_edpd(). One of them is in the probe function, after we
> have powered up the PHY.
> 
> I think we need much more information from the reporter before we can
> guess which commit is a problem, if any.

Sure, it was just a suggestion from my side.

> When does the reset time out?
> What is the code path that we see mv3310_reset() timing out?
> Does the problem happen while resuming or probing?
> How soon after clearing the power down bit is mv3310_reset() called?

