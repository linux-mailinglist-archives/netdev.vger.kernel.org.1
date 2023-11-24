Return-Path: <netdev+bounces-50775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C94767F7165
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F7B20F33
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAAF199B7;
	Fri, 24 Nov 2023 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIMyi9iB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5083A5
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 02:28:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpe7IJAp7FMfKX2b126iqNlXPoF2JOE1w+7c/UyPt7pK+1h5c9Ozpv5q/pXjDoWIUjSzzK0gRV4Ged6DO5fkxplLShlSio/984ZDHklUFKGmYdOq5WyRPMcfyM2r7KMy37EbtBkqfqQKinG3Jju8kPbrzGlMg/QbzvmIauCa1vuXD/BBNep92djUf74o1mWTOUpNLOKP60qHz/eyQFFBgCxYQUx2qfVc0eohqZaO14ieBuaGxymLWq3JUf0Nr8Mb2Painb1Hl+uO4Ucvv6JWjicW9OA3ynfyMEIGRdSgCZbyhEbVj6b0YaqRLIpKiCpTU/tKdUAGl3V7QS+tutEaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9FI/rwdFWoXmMtXT1sjC3JYeMvSNQm4vsLF0NYOGug=;
 b=HETe5ErxTzYbGZs5TLlImICsSUemZsman6gyaxiHfCyNNzoCSz0mSjo9YOWCB7Wvc+tT7BeG5McE2R6VJfpk8EZFPP+fO94Dc13gfdgFSbtSKgTKIOksxeIvBowDFSqctrOgETV7ef//xDNAsq+2gqqWjtOyW3NlvPy8vM0lCM94dU4QrwV0vhhGHBVLiT1s++ZY1MokUtctsnSnXAoISGBhXZh7rKvcjwScKOXUaxy68uAr6eh1awAw98LSo8DBGdbLnfwvd53yyWMQKEcOaMJBqhFFA+6YnyfKbCuRWMzGkILxemdzFY41MCQpyXbVjq1DHUCXnDrju7OoDtUHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9FI/rwdFWoXmMtXT1sjC3JYeMvSNQm4vsLF0NYOGug=;
 b=mIMyi9iBl61rIBmPGyXBvTj6cPi86WMlPWVyZ5g1fCHPnzqyN5bGiH2awKh7yv86yyst7dsxAZ7MNUvdlTwhyqd9DKpxNeLca/MeA9pihaAhF0dr7+O3ww1uNUHwLNAG+/BXKPHlLUm0uwW4Kd8O/x7XHy7sCkFGh02Mhsd7zzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Fri, 24 Nov
 2023 10:28:13 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 10:28:13 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 net 0/2] dpaa2-eth: various fixes
Date: Fri, 24 Nov 2023 12:28:03 +0200
Message-Id: <20231124102805.587303-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 43089496-1351-421e-1d9f-08dbecd80ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2dn9dHvuVz9w5/scG9RuACYMfakU4amA6ORNH1veT+rLN6ekr/q6rqZZsFIx0VFw24jTOIK5zMQQ4VscoJE+nzlYadjpoCBbNgN44tE4PvBW+8t00Nh7W31lbv5lBxhpdHy7krmnJhCr33b5uahVnKePLOLxeSjA39+53+HZDQ4o+WyOZGxgBx3EekTOt81tqQrEwUY9qmwdW8b5JQ3qkt0RoszemlH4g6O47M7TVT0JW0DJV9+RhfWgb+snsQ81OCZ+YE9JFbSVzZ/XYeWucrdsDlq0XMOtnBs3BxCyijUhApW5QMcEXU2u9pDDLtZl4VuHEgDaflAy3ANn81rRSixibyR6nM00mt1JBkS5TyYgRiu25+lFqHSwOB/4X2FzcJqUbMterMS70hMEyEo1cgIyqX8YUI82P4yyK0Fm2rnQzLekSjkLCUI8akhqJe1R5PrlyS1PvEWE9Ug+vAFEjQd4ijeJgYibAf0BGyBgEDcvUGPpCSbAr2PW1LYlYozGyj86vU9GAlCmid91UqXvPtiZy1syKv2LvIt6WxoNXMVk4XDjO4tQECd7ZKwJ0BoW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66556008)(316002)(5660300002)(66476007)(8676002)(4744005)(44832011)(8936002)(4326008)(2616005)(1076003)(26005)(2906002)(478600001)(6486002)(6666004)(6506007)(83380400001)(66946007)(41300700001)(6512007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FJvQZkfAcE3X9eQmFJJYQLF8lgMuVQNVEteS5yehDkMhNut5Go7H+uLgcL1p?=
 =?us-ascii?Q?lXjyuGuLjPUntTR6FAkY/STi1sRrBornQN5KkE13wukzq64O85dD9h9vWWWY?=
 =?us-ascii?Q?jbzDddX9RrKJQL01NuqSoRJhte49JR4NY8Ju0mFnGs8h+jzXDVO8kNyi3EmS?=
 =?us-ascii?Q?8Htv/zzU7/MES5YbkAWQtwIqzUrsFaYA86n1YMLn/DpKx69hvfUGBgEtAMlD?=
 =?us-ascii?Q?SIM68wWhgztRyo1w7eC33p5hF+rWhqbM9QlUWIW4RlfCdonFalSAYBD8tKQq?=
 =?us-ascii?Q?dfGTVNJnFbhYqaLd0BWk+dJsVE+/gaVAu7Dc/wk6/kkdvSyofvBjF3cAMt+u?=
 =?us-ascii?Q?d4qI3xZPKknJPUnVbsJ0srC9tRrvme5Ry8cZhC+381Iu8FKmYh1K/giPTOrp?=
 =?us-ascii?Q?yRBe5yGX2b3dltTjs6YWhQhqmT/DJw4fWvXuPnDfjOonsA6n1fI3Z/IeVilF?=
 =?us-ascii?Q?BlqYPVL4ISjKlhutRVbWE7mE7E6kxgYLAbd4+CFeVs/FFC4iJnrdPvv5/2Kn?=
 =?us-ascii?Q?04ofylx5bV3kPFA4sBm1SaQxqSOnosMomcu5WluRg09cnk2DEF4AubLmOBK+?=
 =?us-ascii?Q?8w4is1vs+G42lu3T3GzCVK80Zr+DbqFHDgM6JjNAKPxwghHxC+dDGLliA0Sg?=
 =?us-ascii?Q?JqvahFqsracAUIctQPXEE32DfFYtq62DXF882HrODHikeTF7bhwkecEoO+ab?=
 =?us-ascii?Q?POglkZ779alewDD1AQe9kHDZMX5KtUFUDPB7eWgVPJ9P581FaZaIW2oEP8rd?=
 =?us-ascii?Q?uigVQO48j5iJdTjiuL0K1bFkQY+gfQcB7aZQEuboQeKl4bBe8hL3QI7D/yjX?=
 =?us-ascii?Q?iJnCZi3shD1AQvz4JUVyl/1FDsskSmvQ2bPkyjASop5VRkYWLPHVtZ4giqkA?=
 =?us-ascii?Q?b4L7ePJDUNVA3KCvC5TwLS6aA3PlE4Z3WqFpc7Ih3EcwlqswINpJlwiV9JjB?=
 =?us-ascii?Q?8nilOM8jInZthGHz9IG4rffsZi1iWZMNJGYWL3Yx+c4NOZcesn0a9UsENt9h?=
 =?us-ascii?Q?nAXsKsZMyc8otBV5Nxiwohg5mpMdC3piFnxPy7cPmLnat0WyvC8SEdV00P+K?=
 =?us-ascii?Q?HYpxE2j3UlVCHOuAn2ttGxblZ4HLSTWm0vEYXfTbSUOUUaAYOsPm36rDotEK?=
 =?us-ascii?Q?mU/ORw//8jxO5FYsxzmy7AcxcK1wp/KnV055FHUZJe6y5uEp/JbdyMrzAZcd?=
 =?us-ascii?Q?qBtwcV83vmP9nIBnd3H7PgQbuaPM4Clcy7kpbyAKtuVJb+N+ITktHjXef6Sq?=
 =?us-ascii?Q?+ngVzQGYdRSUzBvfXt1ETEWl5IPuV5DovehupddWBZbcjBoidutO3zj6rFxc?=
 =?us-ascii?Q?Ik/wDvJw551yRspZ9WqJpjN811ajXQYD8k0/DDvPyJynnQJRoe0pBlLuLG/g?=
 =?us-ascii?Q?gE02BRNOtvY6SVOTKwGgI77+a1+hKeHubvAdPsRjoRDuf8Gl0IQz/YrSRlaV?=
 =?us-ascii?Q?dpvLEFgzL4cZz2GXg+jmKLBP5imGuc5TEpv9vY4IkdQoc9uYs0ZjUGTRo4Xz?=
 =?us-ascii?Q?GS59ZFpYfBu5ARkLdQmNlUW1v9F+nEtcfVEUiZC5EsAkJOxjy2jkA5+joVzF?=
 =?us-ascii?Q?ZG68nfd87loo3gmk+Lngo9S3uORG98jXvscUcbXO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43089496-1351-421e-1d9f-08dbecd80ff7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:28:12.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPp7dA+m8quWXvY98UXSu7bB24cyH/SzWWedDbHJB7suoAVZaAsZZ90c9+xsTSrEWxoGcnOZxagTpiReVfgSWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

The first patch fixes a memory corruption issue happening between the Tx
and Tx confirmation of a packet by making the Tx alignment at 64bytes
mandatory instead of optional as it was previously.

The second patch fixes the Rx copybreak code path which recycled the
initial data buffer before all processing was done on the packet.

Changes in v2:
- squashed patches #1 and #2

Ioana Ciornei (2):
  dpaa2-eth: increase the needed headroom to account for alignment
  dpaa2-eth: recycle the RX buffer only after all processing done

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 16 ++++++++++------
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.25.1


