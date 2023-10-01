Return-Path: <netdev+bounces-37253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477C7B4738
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C8FC4B20987
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D263A4;
	Sun,  1 Oct 2023 11:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9C5699
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 11:40:26 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2103.outbound.protection.outlook.com [40.107.20.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907ED3
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 04:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZubulcV9bEMqsMEgBWBg/wvuD81sicRnyibeI8j0c+SKLzi0ID+1RUwIhb8+TaSTjFqRKl+7abqno08KL4+7Cykry3NmSqtNDFHzZBBWFAMIUUQFyptWi7XSgHf/RLycognxpR5ju5Vwc4D2pzVbXGbNkJb1X60wU6kexP/UFkmPkGlDUGnc4Drk0SB5YNuHTYqQQTMZaDAoz50Rh3qZ1CstRYZMAmKxKw824CzoXKpOCECcgBPjASbB7STo2YuNoNjt3yRCxZgod3DRGVGWMF6SoZErj1zmAuECB6rdc6gUNDWNHaz5OC9wDtTbvsgm2nkDBUiLr68r2aRPrW2xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvujkdmkpMPIH2BNp7fDd+/FNwXoJXSjURzpgtxvD14=;
 b=Fi1d9kJ3i61rUnuuAso7U8/fTLx6dhPNDktuPAP6oOPfaWj3zJsL64VvzhdHUKcMQYV9t0CtrDdQ1781+famDqRKFN4KnZj1PEK17gvrjOE4KnnIADV4gfg9sjEv8zMe+DxfiHXAvJYLgbddKCIbjg73H/S2QgpSe9l0PaW2ostEfX/ic/CN4rUtz6spzy3TlgWGKfgWKg2I6rhUsS1VrRfvpIBzui8FtCG/NE+PCExodXARK4ynfVa6/+PVTAIh74FNLZ5AKmZCxI0a7NTkPxKTongIB2xLYGXzFpJddFvsmfCYYdfoO9BSxU2a8Pgigq3b3PKGh7R0IFYwea3owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvujkdmkpMPIH2BNp7fDd+/FNwXoJXSjURzpgtxvD14=;
 b=PhGOYWqpsq+d4LyofbyAuUv0bINPzxDjNTo0oFINlfJ9G6p5ZI0J7shg4FAZDO6KstMFAgl19/Wigu4YFsEeqHDj1X87zMaiDLimOuxut50ec9YeH3/ncBU/9TSwQ9QOKN7W9HcmR/ccx8yc61Yt87f+ugfbWLUJhOmLloOw6PY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DU0PR05MB9679.eurprd05.prod.outlook.com (2603:10a6:10:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 11:40:21 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 11:40:21 +0000
Date: Sun, 1 Oct 2023 13:40:12 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: [PATCH v2 0/2] net: page_pool: check page pool ethtool stats
Message-ID: <ecs2aa664r2tequ6qfdu5vlfd7mi4czco76izt4dkmdzzdu5bn@jt3gk6i355lh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DU0PR05MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: a83f25e3-fc59-453d-2b46-08dbc273316d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xp8BxvnPOUC/P38oPAMALYiDre8o1N3Ks5pQjmC0Vz1Y2B8QXUs9pAQCNJEl/lrL3ab36RVgWKnrB+OxKj4d0I7VFJJU1zaJGZ+4eKVKdw6Ol2BNZfIljw/ZGrgbpF4TdGNUOW4JtWOhICj4EAiSzHdvz7gnP7je7wnDkRImSy5JKhOhaEOtxbaORgmJKALFVdd5A73s5TpmZRvyltEUbB7rd1TYjcF4tt3kSmArAce+ViYTydl7Wy/8fLYO35+cmhtoQQw2LfxA+f0Rm/vC8cPuVZMoesDJeTNfTUVqJXf6wWoN7NOcHOMIBYW8YU/0peycvZFlDWDXFmp2W8NBDuhsyVsZOhC2Zhfi8smImQ9gccR5zG0LTmhKBMtCo44d0lua3UHfb91u0Zh0ZXFi/J/AC1g8S/i/3HWWpUVQ8IeZyxWKKGUrydms5HIQSlSQRXoTdhAO7A9KnKm5SqflmJIWLLJ/r/9bXS+51Xdk8Vd8mpw1ZtCJT7sIUmzJBgzJgB5pbV4+EkkX84MKp8ck3kmHTTsHsseNhgNv9TqwyhJ+0QeXbjgmgyqHPKXZ9JE8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(39830400003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(66946007)(5660300002)(66556008)(66476007)(41300700001)(44832011)(6916009)(8936002)(316002)(8676002)(2906002)(4744005)(38100700002)(33716001)(478600001)(26005)(86362001)(83380400001)(6512007)(6506007)(6666004)(9686003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Cqf/C9W7RM3VZKwERG7Fm1KMC/cTtipb6kmM6K4q5fNFXFl/tMJQQ1L94Sq?=
 =?us-ascii?Q?CJGG6oQeb7hWtM5l501yb3Jn3e6jnxfJEOqolU9/487c5/d4ECivsFhbnnTr?=
 =?us-ascii?Q?cSA6najZRHBEZ90qb/AkNY2vxl1ubK63tjvyeNOr6iuEDwGSnpkioIndgsRe?=
 =?us-ascii?Q?RUmYYHHVMJeGe4UNscFJPAzrrtIXuQH27TUIa/B066pNHp92e9/FJKyHwzyH?=
 =?us-ascii?Q?gNvfqonwwmCKkJAgXtXL9tHC8pUoOEXVtlcffXNx/ppSE6kUo1bS0IMWMSFS?=
 =?us-ascii?Q?Ab64+DO/UX+1efpOyPGQraVjBgcRTHuBrzF6mrGtgVw8Y8LYVzfWc0Xaen8J?=
 =?us-ascii?Q?OqaQBSb3z3XU2Nc3gNd/JyfDh0/4kb8y5J5DRCUEaSMEttbVXT7kOIAgGUj4?=
 =?us-ascii?Q?mq9tYuQl08Ku8Yk90R1FM+ZN0u/rlBaS0AQ3sc1lnJ9APvLWcBpIhRchg+BD?=
 =?us-ascii?Q?B5J6EHfJwP1tYIf0VkhmXFLPUueqX0DgsykeKB5OD18OIch24ORvjw0EtdW3?=
 =?us-ascii?Q?JZ88XBdq21oQ+AZr8P9lkudtONfi6iof2M5zQ6kj0NepsihtVf66bhbzn2+w?=
 =?us-ascii?Q?i7mU2+CE3SGN5qgRcmmqTsiSB6xytPfcRXujYtwmr7r8jW5CLnSnvYdGPzTz?=
 =?us-ascii?Q?eNncza8I28zSLprccoEwvhhupyTdbZXqzM1fp4xKYN+EB9Fq+Y5u/KV8Jk+B?=
 =?us-ascii?Q?aYcQzxMNN5ufNsxPAHnnkQ/YAj+xwIBMzlLpo+t1BEdXG2QlWV24RB75nN2B?=
 =?us-ascii?Q?x/3WXQQotoDWBbJrQ9PFpPAP2jpaUNFl4fLW4rMKptscHRRj354Yjl0Jh0P+?=
 =?us-ascii?Q?Hs3xJo/3Lrq73O/LrdtJsDcH7q1VX8ud0CTiYSVvCGsapRV80VI9b1yVAKLz?=
 =?us-ascii?Q?6irQD+IZtNuO5F+EJPMXTsu25Nfg/bCmk7qK7diamppSEzdGoGDLj8mrnAZD?=
 =?us-ascii?Q?BQbhZ5hQ+kyII7D2wwV2BIVKh4NKxnW7yvoXRuw49Uc5KiesvINnOGhIiU+L?=
 =?us-ascii?Q?0OH93udKg3sJL4BX7SSMQas8kwG6Ib1QK6G1G8D4hmtkXKtFBHyMBolVE928?=
 =?us-ascii?Q?IG7+nzufUwz89RvxzmrnP2KIRSqybIslF+gDM/qHQYtDchpkz74cc+G6jQeN?=
 =?us-ascii?Q?tuM6Azmuh+mk7ykEZUGJizMUhfarY/swKXN4HqXLe3VkJq9kbLjYeJYbtE4b?=
 =?us-ascii?Q?pUSKOcDzzcz3e0Ldn+NXitXxMNWiJ5zFQVtUPRV8I4KAKhPwj3cKC6xhLJhh?=
 =?us-ascii?Q?BSgZFuwGO4KbppSVMRJmb9PGivCMzah7BDLSZA3v7ImHTvU3HxEP+f84+6kL?=
 =?us-ascii?Q?Nk8YqPb/0jdLumI4g61GcQZwA+5/ybvBW5ES3z9tQ47Oej+qXo7rhA02V4hU?=
 =?us-ascii?Q?IiB7FnP/iIaNkDfMEJU6gvV5ecQ3pfd24jjbR0sXRk4m3ZKEYTznj99ltDU6?=
 =?us-ascii?Q?UTEZa0BD9XXPWkDB5ECqRRB62yCJcrVaA8xIqkEeBgApWNKY1pTaCjeWHDBN?=
 =?us-ascii?Q?q/veX5GUyQFFcLe0TezMON1DIcavAV+EhY1dUBYFWgdlrWSlGYzqqxo9ZnnR?=
 =?us-ascii?Q?wajmtUwAafaU4GIfM8AF579NGlh8jDeMEMcpKLdtj7tFewFRGptjAap2zzrH?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a83f25e3-fc59-453d-2b46-08dbc273316d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 11:40:21.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkwqTzEaxBsTiZeBISsdjmEvsmYYdt9cRfztAB3j9TD9p2SuHbDZLEKLJ9vYjAhPAntgCtfJ92uFglx829RXcxIWq9eQ0hoWZEQJ5HyCS9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9679
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series fixes up an error when an invalid
page pool is send to the page pool ethtool stats function.

It also fixes cases in the mvneta driver where no page pool
is used and allocated.

Change from v1:
	* Add cover letter
	* Move the page pool check in mvneta to the ethtool stats
	  function

Sven Auhagen (2):
  net: page_pool: check page pool ethtool stats
  net: mvneta: fix calls to page_pool_get_stats

 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++++++------
 net/core/page_pool.c                  |  3 +++
 2 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.42.0


