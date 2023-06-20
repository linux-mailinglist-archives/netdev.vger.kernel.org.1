Return-Path: <netdev+bounces-12296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12373706F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC73D1C20C71
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23A174DA;
	Tue, 20 Jun 2023 15:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082F171D2
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:29:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2108.outbound.protection.outlook.com [40.107.92.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E9A4
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSnrbzg4LwQIM59pAgrf22aXXA9DNxWKc6SmG4+CKP1DP201Ipd9W2BO0KZbvTGJDOjdk6qxKTngJpfwAiSYz/ty4jI10GSB3R22jczgY1ck8AXCWObV7+JXj917eIoIiGMERsGm05PblhYAKpRYmK6oBe96HfYfAzAH+Ab/4Jnw+PkgUSjY1x8BduuMPAfKYN3xAEwf1BZHsBPlSmWNhhC0s6IcTuJagSb4+MQdkA8eOdyQicB6FJO2UMJdITuxVNHVJ1p8PyTx3z0mD9+6NW02AGHbaQI50yZr9t/e0xmNPEWjIGi7Cp0zV+iLcNno27YlRhLleaGRhFYsiqmslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfrIvoX+564nFWrWpWoMa1QuvAqu4NkTo+3axFJr2mc=;
 b=KTyqmj2ygYT+G+POVFgxUwRr+QBmPcJYm6nv4c/sxjWfRzLKRa2e88m9xVUoNSFAO+ui/tVWRk6UIM3g6CvFkAHwHtk37bh/C9W//2laQMEx19OOnd2KQCdnpgzJkFw3Bodpgc/2w61FRFNFB60ezeS/nXC74qyDwl7qhg6Uk965GGaVoJAb01Wnby58OoNh6KbQ/AGBNkYWW8eF/uqKmKybQ+rdr3ovRNVhY7Z1ix369ugJt8ZBZ3OtpmZzlYTc8ukXhXGl6T4pVipfCTZWK+PH3/C28lxmP/5PGcHgpXrVr6ThrV4+FkmvbBwywUyxyvbqLRQs1mnS51spws2NrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfrIvoX+564nFWrWpWoMa1QuvAqu4NkTo+3axFJr2mc=;
 b=u7rgULBlAaRWRNYwjsgQ1OCPBm0oa6kfJCi7ZE40I7bX7agszpk8ZrY7f/Yu+MvpCs9yhTl5Mm+W2z4jaVGTR7SQ93YYuYfvV8yHXCtOzQ7G5aZHf3lb4GJFvuFGEeg5/JU6KJx4eGq7MJ903rCbosMbXZPOGUd7Blcetkw0cNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3894.namprd13.prod.outlook.com (2603:10b6:610:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 15:29:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:29:17 +0000
Date: Tue, 20 Jun 2023 17:29:10 +0200
From: Simon Horman <simon.horman@corigine.com>
To: darinzon@amazon.com
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 net-next] net: ena: Fix rst format issues in readme
Message-ID: <ZJHFxoYGuavJPtSl@corigine.com>
References: <20230620133544.32584-1-darinzon@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620133544.32584-1-darinzon@amazon.com>
X-ClientProxiedBy: AM3PR07CA0096.eurprd07.prod.outlook.com
 (2603:10a6:207:6::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3894:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b04e33-c7bc-40cc-f2eb-08db71a31c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHgDL+qSMPzcBj0jADjIb6/W9PJUTMlUmE5TYB2V3/zQ9BjhyhOHi8dd+37C/DrrefnmJLyoiuh66UmpGyX9xENfPcwudZHn+E/5j8VCxhZOqC4pAzaF8ps2e1EcYzmotOQySLNKeFhiaw85KACQpntINY/QCr+btdRq3VaY5d/somf/csHn3jRcFy163pTdFI/SlEYlGEGkuFwgP2VqHEsUfCCHP/X0R3UdFdmASRtLD7H+Gohacz4Yq5Vz9NVbTP7lcAXadFgOpyMCk7fRYlyZU+tV2V8zC0t05quQ4/6y8b8XG+KrOYWVB/e+X6NAwd2GKgG8NRtcfeReSglYj3mMQ6Uc1FGQNBDiEEG4zRg+ZA/rSy7Jq6uq+KJ3jRMj1NOBhtLgAOtXxJ6JhooOH9fwbKZnTVzQE7Xs7Jqt3oVLPbJyQ1cOTZkxLFqUEyOhpDEaO4wUxq0SMagUgjdREIwFQ9fWEJwjfLPNTjrCxFXAO+WVSa83MtPlMbqC0ZkI5ZjPuJtNnozfO9hdSDvOr6eRoOzcb5XqqXnCqAn680HCuDzJolBH7bVknftLrrKuTLKnBPwxWRPqqIP2ew+vZYk/yqMODX3dw74PrvnRahU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(966005)(6486002)(478600001)(2616005)(6666004)(83380400001)(54906003)(6512007)(6506007)(186003)(2906002)(4744005)(44832011)(7416002)(5660300002)(36756003)(38100700002)(4326008)(66556008)(66946007)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fESmCMjaFchnRNOuTABhr/IV5nqyoBG9YjmAVVF0V7+ZcVyNHPHjFeJQtQGJ?=
 =?us-ascii?Q?hW5O3IvnSkSy2JULS5UKP9PmlkqNICF6RfWVcveA3OQnk1ZOicfWYyoBpsGY?=
 =?us-ascii?Q?4Bh28uK4cg7VqzCKb4Nt7XU4Y+wGu7YshpmX9SmNXdttf9p3DV7RBLEN9kLF?=
 =?us-ascii?Q?PEsAhvJXAf83Wv5w0w0aEK0QC9PNbqxEqpdtjVVZNKMB/rtr6p9aBfr+heT5?=
 =?us-ascii?Q?lxbCVi4srcM/lxUxiZ8/OqRoH3vPE7N5bMqJrFVJpeUp3iy8sqBc9+1Hg7m8?=
 =?us-ascii?Q?0hu38958Vm4iPBEjRtsiJWfF3FCl+qrlv4Ni9Rp1zQGsNwO9p0OIIFGPgNW7?=
 =?us-ascii?Q?49vaQJe6l9bKELViqCe8g8gWms721FtYJLFbFg0weqWXFJ5zWQVZBkR0RrmP?=
 =?us-ascii?Q?UV39kB6FTAoW7UCyXiZYM9pimtriQ9azIWSE7XTXr3X44m4e1azQ5zx2pKF1?=
 =?us-ascii?Q?SwTSbRQrud54HSW5vJirYM87PUjhvb5EBonGyt6eLJs17k83RKoM9NboFDlC?=
 =?us-ascii?Q?vpJGkSVuCA4C9ZLFlXt1I9krwJiJnU2XzMv8BoLfMZCqpmY5+lR7O1snk7kY?=
 =?us-ascii?Q?ab+IjLl0kevEuTspArD1MCsaplBOjV5QH+rgYTbpdLQWlT0N8JAeoyCzz0XL?=
 =?us-ascii?Q?EmYVp1rOQq6yoPRCEM3IxFAc4aWUyWYa/36Nhu1NDMre6pp3q1wPJL9l9iiz?=
 =?us-ascii?Q?mWNZcMNgzHXMdt/x8m1nxytXSIPSJudGsTh2QaQDiTFaoAbYaQJCjXgE9W99?=
 =?us-ascii?Q?hFNoItLGeFQmzFsDHrTPazMAU9BsIBMAo3qN3u1Nh/QNrritsLRh4K3GjR9y?=
 =?us-ascii?Q?YXgol7Q+8kfxMT+xYAyvwwhCEyzhvf75nzbA8oksErB2iS4Fh6I0wzvW88GY?=
 =?us-ascii?Q?DWs8+tjXyq6opcgPB9o9NvOvvUVU9e4MWObOh4WGG3wWcKhaady0ptXtL0vV?=
 =?us-ascii?Q?Sm1UwLjCu5DfpkNEKYn2Ohe5sDx4DMdq4pg+54nMXH08CKWSOqJPgc3Me9hb?=
 =?us-ascii?Q?v7e2b31gs8fVbvSGfFNzHEwqQQDA0DFBeq13tZdc7H6QfbwCi6AFKqbPYhDZ?=
 =?us-ascii?Q?6dxV5xgNMbD9UsEHrh2xKN9Gvp+USWS49MHIamyIsnGCeNb/aWEGnfsXlVQH?=
 =?us-ascii?Q?83pALeNGAfsX6wFni1fWVMTp38SssmA351HmtbqxnQ0t98O0qnAB5/IMFmwR?=
 =?us-ascii?Q?3wu79u7C5gFiW8YP0j/S07J9yoZ0hBH/IHdgN+DX/Qb/AaWuoDLTpVLXwXFM?=
 =?us-ascii?Q?bAZN8dChCsXonQSWP1mHufXNgCtviSL/UIH0A8cCYId0qvdZALy1FB0cmTK6?=
 =?us-ascii?Q?I1MFMClqfPDykvOlcZNR8q0Xo930oha+bA/0/wg/DZx7DsquiSUioDhQUDhZ?=
 =?us-ascii?Q?BTAP10DrSjhKkV0HIMYrZx5oI2e0s4xWIhiyRTpZOSOqWvGBM+lQ94hUsrOc?=
 =?us-ascii?Q?I+yJR7fFia7GPFuU4OuwVWgkHrqROphvz+QPiUw6xp3WQ9Q0FTsgLL0MWzve?=
 =?us-ascii?Q?eP+1NAhoJEqt3cJrl8vvNk4lX7H7W95GdI8aBY9GCaG51xH+JmTMoYNpbWuL?=
 =?us-ascii?Q?VI+rrXq7F/anTpgum28f+Wil06tGPn3bxAHAs/aForhStgstfEVA9NEMZjz9?=
 =?us-ascii?Q?3fTMkQw0UknNvJw4Gr+FO6zzY7DbmOjGHHkmC/pzHh2eoPdPse+jWdwXC8I3?=
 =?us-ascii?Q?8cdNmw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b04e33-c7bc-40cc-f2eb-08db71a31c54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:29:17.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgrgril5EUw2ohi0/Dh2aXWve/psaVuZm4lklPV7x/obgp9GWqiKJFxUAKd67/r02+Sh4NP7KenmBIsgRTzpoF39I9TiFBKo+86iYk/MXsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3894
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 01:35:44PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patch fixes a warning in the ena documentation
> file identified by the kernel automatic tools.
> The patch also adds a missing newline between
> sections.
> 
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306171804.U7E92zoE-lkp@intel.com/

Reviewed-by: Simon Horman <simon.horman@corigine.com>


