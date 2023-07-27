Return-Path: <netdev+bounces-21894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF676529B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F69F1C20949
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365015AE4;
	Thu, 27 Jul 2023 11:38:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E2156C8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:38:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2110.outbound.protection.outlook.com [40.107.244.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86140135
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtQ2PQ8QJIKdvIH3P/6UNLWPHeDIgxo8KjeNB+lPiFR71RKWXvKf7slwg1AGxAMLPdtgE1j88CHFxukkGLoOa13BGKKF0Z/ZrYwiABXGvG1NeIMRHPDieGEgsi6FYAI9AXL4N80meLgAjxBjlOkcJG2tYQPFvpSr4Uqzp3LrpIlvEtEPH3RXWo8Pre8FOz3Fq6FBjsqpz0MwWXeSUGM/Q7gosSjwjhHGSJ4kGZ3TBQE11bMwJ1BSgkqBmRyN8DV/12SzIJZ1P7TSPlzpRnFAI5gIuN3PPkbvhcWZKRMs1u5UmXEXOiHogyLmjMXLPoNEMn2qpbqdIl3HTPfjxUCEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h34wVkWGmZXf+9CRSA+EAp4s9p38k/t8bAMnuoHmtxA=;
 b=L2NC23QKxJowPum5TMYJRO+jpvm/Y1QC5cdkaapnwfVTnV0NC2TmTAliSgDJS++TEGKmRcTLooyLq/a9tafxzWQWdjRkG8MiF3dp2wyMVbcGD9ThxBmLjq+J/6TnBf52YAFc7iENUoxNLm9i2C3w63+Bfpdj+jkSBivVxKKNvcOm+/aRo3dZHQr8LXAySfxX85cfdOsJevxK6dS0D/yLDsibq0R3YYgR3nwE1LCZt8VnFavvamL0Ov039jdVCR7F6o2qdtaOGAMGkuNa9tl57ryFnw/sodhQzemj8BKGqiZzdboxWq4NdUQ4TZ0Dsh3fCZR6HgB+6/5gLgIr398bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h34wVkWGmZXf+9CRSA+EAp4s9p38k/t8bAMnuoHmtxA=;
 b=JJpF/nI5DtnlaGEFRZjQVU63S98xPxnFXo1e3isb8Kdr80jy01LM4owuS9cam+BiWLpriJl+Wq6hEkGtWJMHS8yKs7x2tNpJmiRYJivD4vkR57y6H6jbFrvySKezvkR86Pgo+PTahaszDkmob3PT8BhjUd12nrbq5r3Ruo3QhJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3751.namprd13.prod.outlook.com (2603:10b6:610:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:38:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:38:08 +0000
Date: Thu, 27 Jul 2023 13:38:02 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH net] MAINTAINERS: stmmac: retire Giuseppe Cavallaro
Message-ID: <ZMJXGoEkFrHBhQl/@corigine.com>
References: <20230726151120.1649474-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726151120.1649474-1-kuba@kernel.org>
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3751:EE_
X-MS-Office365-Filtering-Correlation-Id: c04f4a82-611b-4109-6b6f-08db8e95f335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xjaHBV5mMjKIPqljQcf37x07HZ3e3PUcapW0lvTFJ12l33Y4hG2XrlvYmIS6bWEW/iew86DktHX7g1j2aON3wmTcl7zVPv1PEl+56vaFgbIX4LjSx0nolhzaFRztLWZFhiuRAwlx5b36m/D8DGLTk9nNHtnxWu02vllJ181HK+iVmeME8NKDg6y1r55TLeaLjbqJdnkkJQTZl+tD1cEFXlMK7jcX42ORyP/JOYP7/9fGmygJpul8WF9Xy4dTGJKgm+zCifETRRyiSZGtPycirOBZB3rq7Xn/qtDE3U7mDedyG1S+HY5sf4r8YXLwJ12i+s6/zhyNK9QS9J6n4FhKUpgwkPoTgco6iZwFz83PTw77NvrFpBGMkeHJjWLgc/OpWhizyK9UR3GrSgfWwoywCVuoSLfagnO2lQljS5rdFRVTMjH7XnHM+lYcURxBhf0H7rbQrq5+7pGoiHNucnVzXJ507kxMkFkIjbm4yq2b7C8dTTu/ZTuXwwmc/Y67Sjg83NmfGX1HGvWJDiN8243GOD5pBn6itKRquuyGARU9kI8JkyvgwpuCNblYu7bfIH/t91ptyehITtvOCAtVqIDdmqm/i3YJCBOdT2rwnLl969Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39830400003)(346002)(451199021)(6666004)(6486002)(478600001)(6512007)(6506007)(38100700002)(66556008)(66946007)(4326008)(66476007)(6916009)(186003)(54906003)(2616005)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(4744005)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0wRmdhZUQgZ5jzJ6THrPrBHFLM1hyIcF3X4FsplmIfTjfPxjK/2p/eRIkd+?=
 =?us-ascii?Q?ATfwGdOa0GJJU/ppcZX7U4a7K/iqDTzhpJAB2pv7ezKypArrpe3Kdd63FeMw?=
 =?us-ascii?Q?Xapj4hMhCycBHnVn8iQ+8Q+xLjNMU0fxpSCtq2JmQXz3YZ+y5ogX+1GbaX03?=
 =?us-ascii?Q?EY70dPcI0No/E3fSW8EQSlN5gLd5Mx4eKLsQaxrFH7FhxEpZ36hH14MqvXW0?=
 =?us-ascii?Q?fLZ5qXpLd9hi6THsAB0AXWIAKCUGqvbQOcrNV1FgNbCit66iOZUHpUeeo8e9?=
 =?us-ascii?Q?pgA4CT6UeLkrEweCaMb+e8o+dHWI83ytoldZgBqEAUTRCoqABjtM/0QOryUb?=
 =?us-ascii?Q?4PUtt6S/XKZoEYITzJMEVGQg0oG+c6VZCyPqAHzDJThIvFWCVjpsPIxWx8jg?=
 =?us-ascii?Q?oW7HmZU/dlhQ663XvpUgs72ywva/TgYqJHEWdww59jExzA/3hMK5BwMqa3Na?=
 =?us-ascii?Q?8GrTNlt1xRua8rK+84Bf8/+yRqbTuadfjCCVDPleCjUAzKhQ3wca8FtTPzME?=
 =?us-ascii?Q?o37UjFF10QJC6uUA6UJWawotPddmY+sc2TDX6igRhCOlNYEe1rHwHAbpuJzX?=
 =?us-ascii?Q?PR/nBkc0aYJqDHwNVr+F1UYd0qf3U6h3pa6a0D8Wm7SmpzbJpu7Zb9MqYBBk?=
 =?us-ascii?Q?cTKlbr9aTvbBqvb9/Aar7tnkrTVQyyQLDVB8NdxyoFMFAtnAcQuqXTo+FvK5?=
 =?us-ascii?Q?Rky7M9nghC4QqkFaTtsTe6T1ORlaurA1H7Kje3Loy8D2VEqp38DYda/IZr3M?=
 =?us-ascii?Q?V/XWP7+oxYRHT6Et7YwbO+fc8QdQtbvX0ceaiqxd7T1bkaKlkQ1wYzY8OVLk?=
 =?us-ascii?Q?PQV3jc1ixHDCC4q7Ru0viIpgreKf54T+Z38+T+vJJiH7ebgi0AF9dmC/xz4h?=
 =?us-ascii?Q?89L/9DJkteEENAmzByZqI/z6LeFXZUPK5FarBUvEtn/mu15xy7DR3s5/Bi3Y?=
 =?us-ascii?Q?CDX1StT/o2B08vpOULLxPHzoOmK07Nz2KvBz7iDWNJ3gyDJJy8LzYRTSMs59?=
 =?us-ascii?Q?jUoakUetpdw0ybene1Nl8xj+6JKtnsfxzCdoa1KXidLiBVkbuMk/Q1NZ6//0?=
 =?us-ascii?Q?VVDO96sXuZKZfNKAzAhfHkcTzGCdCCdnOVy7Zk69ftkCgQEEv+DJvXFOpmx2?=
 =?us-ascii?Q?jQUdGrMskevxMDQ9Wywx3xVSelcLjsxDSNELz8pOO/1K7GqexinQx74KcAAX?=
 =?us-ascii?Q?epdCyVeEut7fTpjLKIhgvdCsKgLg8Y0EJY05CwPld7SYpdGjL41UpbN2hK9L?=
 =?us-ascii?Q?nZNCKlUO333lvouV5lu7b4S9Hr1JJYDJIB0GFQ875i8oCTFA5QlkD2k/i0JT?=
 =?us-ascii?Q?ZeVTT/WhPnsR24TUX7jVnGEwqgwrJE2uDve5HIhaew4iV+zPDFKJ/YQvBKIE?=
 =?us-ascii?Q?pvUlabeoXUde9YVlyk06hhhJ8aXxt+b8BZOBZ1t3rMxlOABrK9bVVCu74uaG?=
 =?us-ascii?Q?Z6V4imDYkAVfGunJQaBLfn1msS8f1V0+wp4gpm+yUSS9Ic+ZjLAjzeE945x8?=
 =?us-ascii?Q?Qvhe/SOsVhxQjO5HIs8wPX0OkQax2NYKJ751/2VCbf0TemecUoCiaSI5vby/?=
 =?us-ascii?Q?w3RzuTwC2eCTfhuKAxlLw83dHN/yI0x7jS5m4p4qcFA8vlr5pbThMS2bzV56?=
 =?us-ascii?Q?u7Zr9q8LArL7OjXug6CsAuosw87rh1SF03y3hXG1ryoEM4FhIOFMe+QqSTpD?=
 =?us-ascii?Q?PtrX8g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04f4a82-611b-4109-6b6f-08db8e95f335
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:38:08.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYpCgDK7WXQyXug9phNwjlyFjvRd9QrOy1zw0qnlWToJFLYsSDg18VDULkN1sn+ctSB+bSLZY3xQlDQXDfvzi8Qtm9S0b7pFscPKwdK2/iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3751
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 08:11:20AM -0700, Jakub Kicinski wrote:
> I tried to get stmmac maintainers to be more active by agreeing with
> them off-list on a review rotation. I pinged Peppe 3 times over 2 weeks
> during his "shift month", no reviews are flowing.
> 
> All the contributions are much appreciated! But stmmac is quite
> active, we need participating maintainers :(
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


