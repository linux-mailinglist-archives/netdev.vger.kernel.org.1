Return-Path: <netdev+bounces-58871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F7E8186CE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C51E285097
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E816435;
	Tue, 19 Dec 2023 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FgHnPvIx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B11CAAC
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtRNIadx6dzh9LxEF9EK24JjGmFacWwgNCo1jcg7E7BFJ3+xAjzRnyks5UoWH7cvaSfHRRFaNp18b+me/Yn+mmmQCPrjCoVNRgVxGPUSXOsUgexDoyG/Pwx/U9iYDhvb1DgjCTav3uXEm6emPvwoRv8iEm6e01JQ0aEOxFEmcoKEt6V8qca0GAB43nCtxSdTHi9TBIDsDrkcv0ekiH0G1mWL/4apcBfHk2O+84DJDmCrNrfXCGrfo0/7mXdDd5qbNfOdQPG9UGqZIxdS8jekDywmZDN9wDCDIE1XxuMjK7cCos0BWOtroLbXXiSjkMgTsxl0lug/W3MlEZBXMeblTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtLv8IWeb6S54CaJjfE98lyoVyyGH8tx+KOBcMf69w8=;
 b=NCge/HfyaBUweo9tApZjDQvUBNdw3V8hVUTV2Sk16GEJ2PnDI+TPsrHv8w//NIQV1EEkElCAcHaM64F9PdW+k2yfeXsnw5BVU9DV/JNuMDr4uQgmwGZzrJ7NSbamE+8Hq+lTXnm+fhnOHcTmEMZT1/Zwf2zC08lyCnFZuMogOUErnLGwmWrz0WwNHgRRuIH4Lp1877+3KqHvqo2oz4AbYDFUNQPach7/b1rWwGZcgcssXFGkZh8UrWCUMD+11oOGsqYZBb4tGaXC8I6cbvzHnqusvnMGZ+Cz3lysAmKSmw0+BMaYloUQVSnLRv1v65JALG6uslwDUjYkEH8fVForRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtLv8IWeb6S54CaJjfE98lyoVyyGH8tx+KOBcMf69w8=;
 b=FgHnPvIxGE5ODkDlfdu+GTNPjbCPfkSKzBSKsPjs1171RvGd63NqT5ouQrFAGqHYpJTNXJYB7ZsJ95KIIh0xIXIDErMr4ucrJRq5D8yvD9hztmbw9JkHWpTMAO1LVFmEImzc3d2ggkaVH4tHx5MnwsRtMR3tabwjqJeBG/gZico=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB8786.eurprd04.prod.outlook.com (2603:10a6:20b:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:59:55 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:59:55 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v3 0/8] dpaa2-switch: small improvements
Date: Tue, 19 Dec 2023 13:59:25 +0200
Message-Id: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::19) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 41020afc-7d36-44a3-3ed7-08dc008a034f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m3vMELc270b9Da44WsU+nuE6ZbHLbvUFw6lJMqx7A+PBXW0vglhEEOJ0iImNETK5W6MQxvdQxCdAxXaz3edop6hmzkkXNUmyvoneCUK3fcXDr6ykOXG4mRBZwmy1BJuycv1InMGc4JJaE3BJMEqbd0tVE9VfXlXfR5Z8f2p1EFtiYepMK6sgm1fWZOSo4GZx/c7K1/hivsWs1XUwVDd6aAsXGPSsmxmBJj0h4c67uYQgnln2aFJRjicF6Ph2timXHvflILc2x3/TCng7J56WRBSPUTAyBbLh5vZdHWBNq1iUwvlxKqc+Fyj31Op9pnRl6xMldcvgWB/N6Em13cc95vXkwnkRR9NZBPyNGyoAR410XYf7YrEuyCJjGxEUxMcvFJjaO63VJF1UedEn453KRfv4ZhIIPkGEJW7Tto9f4EY794m8OZzyPh4IPk6/DRLlD/yuPdfyO2GFTtRvd12DRtJHUDEUoHqheWThz/MOOQFwzbnO6xNLn7N+d5RQ8JPm4iOyYu67O0NoEIpgPbB3H/+QfVLcXKcLdgcxYefcDWkA76cxBtrwXkLi4+LLBsVW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(8676002)(316002)(4326008)(86362001)(8936002)(44832011)(6486002)(478600001)(66476007)(66946007)(66556008)(41300700001)(2906002)(36756003)(5660300002)(38100700002)(6512007)(2616005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhOVgtGd8Vviqkvem3zvfcjUGYf1ntPPipRMGEv+Abk4Ijfm3tQLyOKEgTKD?=
 =?us-ascii?Q?PQ/n4pN0KMKIdEuN0JwqdW7TVvTAMqfmql7MyN4Gx9UKK5fACLcRtDP3JMKR?=
 =?us-ascii?Q?g6sRd8lVXdYO0IYvBUwGnSfBodt5H1QDqC7gMgWMRWOU3c37CHJrjL5O92HI?=
 =?us-ascii?Q?tEAj+6+bwDmDnw9Ei3OX43im2fC3IvtWLUmeIqYiP8MFZscbW5MD1CtKu1Kl?=
 =?us-ascii?Q?AByUKWjnly3M6lxlbXjuWlIdRSfAd15nyN5ftc6efPHU67ZY4RG8cgUPytfj?=
 =?us-ascii?Q?rO1FFMP9HSzBFgz9MyS5Fccue9PrR+eUFtsLqaJY4fHu/enFarnL1b1NAi/o?=
 =?us-ascii?Q?Wuh/fg/R29tVnx2Q7ECsPRyKYbtgbxe5sHtjSeVO9Q6kACo3fXzG0ZGk7mJf?=
 =?us-ascii?Q?TenYfKQrAZsy/yf9cMfeepH1hROzrdvaMwflw6qaF7FlnpUSkePYPdKJ7NsN?=
 =?us-ascii?Q?ZXtej244LU5oU8/qaGyvz1rJq0gCB0UtfwQUs+5rhC/c4Irg6azFOKMr2Wg1?=
 =?us-ascii?Q?BRf/V6ZKljVgL9tICgsKCGEAcPZM2+MAFdUxIAIfvr3N9PO7L0qNTqnHZ/fX?=
 =?us-ascii?Q?oYFXk4fF3PvkRblDXHtmQH86QukkzWBoexsd/8d8L6BHAYj5t6uh5sT1H61z?=
 =?us-ascii?Q?McC716eD3YfuzTnfP4yDaRcdF8ab3fG39FpKV/slGMKT79KCzz222fGRoaep?=
 =?us-ascii?Q?aYKuTF8TbbS5K8+7bsl/ubUYqJWSgVLnoz1MKHHC4S7PIeA5x5JWk3m3viif?=
 =?us-ascii?Q?HOW55mqaNhgs7Hfd0fhsmfVBsfwvbyaY+1NbXJ5RZQgM6V1GDI81bVfqW82X?=
 =?us-ascii?Q?Pc0pn92oMQ7hUY3dk5WJvG6iKx1bbnSO+yTnHbc/MHbr6x86eHWc8P6wM7dv?=
 =?us-ascii?Q?6Jtq9SaT+IlZJVn12bTAbL9SE6Ypn9ldv0dEhVfWhxliH3ZlEbU3dIoQ4VJG?=
 =?us-ascii?Q?lZ+MAT77hLXef9ctB5tDrmDrQjcJHTeJmwJm47M/UoKmXXfyLtO9NXDj65jf?=
 =?us-ascii?Q?2Oco6BfSeUZJ76oRtMPamXjH7E92BhD5EMh0ptJE21sGwn77XEQeT2mN7Jsm?=
 =?us-ascii?Q?JdY1VKDc1ULFpm4W8Cj41fap1HUAIx5zJ1tyYYGCCIya3NYobx+JYj6vz2a/?=
 =?us-ascii?Q?wB5IRcEA/2B1+IKtz7wQOU3PR1xdvNTPdJSyrunAqb43V5qmJ2dDi+j7chUk?=
 =?us-ascii?Q?kryylv0RwMvoLoBbHO+WhAdhQpr/xX6hxMn5TJNgzDlCCv3by8AiQVthK9Jp?=
 =?us-ascii?Q?meRnPW2nRQNRXez8oYyIfSxTYLLWoBlAhezk52AMunePOIO/VNAduXPwsqCv?=
 =?us-ascii?Q?yFyJeOcwB4nJWxRk+Xhpu3JdC+UT5fWRpeVPgACK3dd8I5o1+aU51koTo/LO?=
 =?us-ascii?Q?s8E32zUUbyi1LHVOAIYl1z5cfKI8ZjAM+ZfsQPeMP8ro7GeOFC9anUZWdU3e?=
 =?us-ascii?Q?wo6bpz7cmJuJtQ5vU6iBezlHVYRNkanLjPlEqKQkC7QQABqu6lFpicdWGBMz?=
 =?us-ascii?Q?hZU9Lr4zo7+6GYg42W1jRVv1iqualJkh6Ex03qelN8TabsWXEifznNQZCX1R?=
 =?us-ascii?Q?Yv7Mdb34Bdr5lH9yVME8Z7QlH6kAFDhJfGvLikye?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41020afc-7d36-44a3-3ed7-08dc008a034f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:59:55.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDflsDLDidGYzTOgUhwzfo/U1I2dZPEoKDWk5Clypei7i8JwaYdv7mzXkf+2W2ikEpSeEvAZRVK0o9ZzAYIH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8786

This patch set consists of a series of small improvements on the
dpaa2-switch driver ranging from adding some more verbosity when
encountering errors to reorganizing code to be easily extensible.

Changes in v3:
- 4/8: removed the fixes tag and moved it to the commit message
- 5/8: specified that there is no user-visible effect
- 6/8: removed the initialization of the err variable

Changes in v2:
- No changes to the actual diff, only rephrased some commit messages and
  added more information.


Ioana Ciornei (8):
  dpaa2-switch: set interface MAC address only on endpoint change
  dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
  dpaa2-switch: print an error when the vlan is already configured
  dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
  dpaa2-switch: do not clear any interrupts automatically
  dpaa2-switch: reorganize the [pre]changeupper events
  dpaa2-switch: move a check to the prechangeupper stage
  dpaa2-switch: cleanup the egress flood of an unused FDB

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 132 +++++++++++-------
 1 file changed, 84 insertions(+), 48 deletions(-)

-- 
2.25.1


