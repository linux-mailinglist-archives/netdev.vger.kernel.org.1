Return-Path: <netdev+bounces-54037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2F805B1B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C912F28195B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC4067E8E;
	Tue,  5 Dec 2023 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/8iOW9a"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78DBA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:26:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGLxGMN8cOHBtepjgEnU1Z6LN0m9r3kx2MDlD5ebfVtypmB2tM64cBha4cmQ4BoFQuSKDHrKGcWEquw56iX+JYHSAHU0FZkMDok0KIjju0jtzmQQIvkA72sX0zIUtIdHWIuT8cHe0mO/5F/i/wyjexcuNzP2Da6Fd/cb9FXLoW5q39/CyTUDFSPine/ht62s7OtI7x2N2EJxyb4NYENYTpUT4IqHD3FVuvkRZXI+uTIzf+5jdbg+VCixQ55J0HdXoZ42Hkoq8YX5+9xgoec1NeVHzoIHXvVyiwUEX0XZfCOUP38/WglSgju8cKkL5Qxi7h4SBDQoi3Q9LwhGEMTB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md3bxOnRXoGzX/MUwh/BDEssXXS33oKjJVdMH9aYX0g=;
 b=cm6tmblpxMdwIoGOq55HGB4TiYTWw35h3dNJlNCJxwWyvEaBB4OToYo75nXItrcUHmGI7WCRhpbegVOr7SofJpRuB44Mx2PE6sPkDqqzTXP5yye+97a6oCcM0dVPP7y1CsCRyh6TDA9EuN1Vx7z9Xe3yAhjtF9q8sIT4xxQxQWUm0KClc3QKBLeGztgCaPoV4boCVSFIEaso9nihDgs0Y/wFmYgYW6hFKqYuc74MieEjltr32Q8VbGybWHX3upZZJvUWs+5jdbBjV6NLcMboaoTR2ZGVAVIoPUnN1HJD7lCvd/H7mfjGk7t7KdEZ8uObTTI2RiEyP1aam7XXscLxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md3bxOnRXoGzX/MUwh/BDEssXXS33oKjJVdMH9aYX0g=;
 b=k/8iOW9aW+ZHoOpx1eYD1iUuIgMfZyhjqg9P2Rz7DXdI3Z5u9VCrUIkAjUHBwn3lCmmKGgKD5jNVO9EYXi9lyHw1/2ZBKOUKvRSjVKnxxLxt3+2QoNbhL5KhQNdZvsZ8Ro+w3CgJCAjvw0ph7osMypfP0GPjqz+NFaf//3DK2tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 17:26:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 17:26:41 +0000
Date: Tue, 5 Dec 2023 19:26:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/6] net: dsa: mv88e6xxx: Create API to read
 a single stat counter
Message-ID: <20231205172638.nrat5dzvucm3cq3c@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-3-tobias@waldekranz.com>
X-ClientProxiedBy: AS4P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e65dbb0-9c97-44ff-a44e-08dbf5b75833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XgjqyLotZJJZXG8kZzaP0rdIS0vJY7g7Mmr6MLXty3hTwvb1abwH7nWyAh+zHywu8xQp6T8dE6tzZaT7+hMaEHxE8CA8QYAXzVShm+kmm99/gPZVWcxyXpXHQc0lNL0mW5NZlPNU8z1qW3Igc8Zn4h6HlxAndudBS2M20tnHLKn0pn1jOg//CQxdiaU75F4xS39Plk+fja9HJJzwHBibU6IklmqOHdVoZAOQl7CNgOZa7FIm9GKfWw+AuqXPzDGyLDjq7JPdc788f5BxX9ldENUkx2xlKcSbM0TEuQN8aVE1M28ZO163zPyi/ILJb9PRQ27BreopP9asN3kCwTcSclbitFgX7CSo2mbUPQPviQBYA03HmO8Misv8loWu4daA3zfdBOhiTlr7qUccjDSStkF1OG1szgCBiXwZdKbp5WtG8/rzuAdRQJH3X0sLgB9ki0j7hvydFHXmRjcvBybzTGt6llh6zAXzQhIddlc74hKlGBnnRYlpFwPtZdgNuZVvK7mtoFrlwPhpCrAKTKcATu+hQiTkqwhos66lBBLSYkzvCeQ2zaCuOZued8lr0JA+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66476007)(66556008)(1076003)(316002)(6916009)(9686003)(4326008)(8676002)(8936002)(66946007)(86362001)(6512007)(6506007)(44832011)(33716001)(26005)(2906002)(4744005)(5660300002)(6666004)(38100700002)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogv4ZVVlBJb3z1An1EYG8dDWikpYbaKNcMHmFFBNwmZSDPczB8tdL7iud0Ms?=
 =?us-ascii?Q?zS3oNzuVtgkbpplGkNBpf7nCnR0WEaKAEJkatvqHAUtOTr4vxyEwor+dXTT2?=
 =?us-ascii?Q?YyV0jKZE4QSAUsBFuaWzGDhElQXIRjeHYoVJqgfOLQFyQ5uCKcs1IOuPD1Px?=
 =?us-ascii?Q?x976KxovYcTb2LIf/qObDUbJL5JwcDwVfagEWGbNOsu4A+Pq+kal+WNY05mb?=
 =?us-ascii?Q?Emz1+IISCOM2ey2n090hDW39GposYLOpGjmavxNc/7O3jRVBXmUHGXtF8stv?=
 =?us-ascii?Q?GIYVPOXhB95lj55qmb9fzaXYOGfiJMA5MLtl8ypWduszra+/Kc+ozUVFNG3n?=
 =?us-ascii?Q?+wCGK13hHafaFQc5lp04taddGGwNXQtJECBKYf0YqBIdwwk4WIcmLGoz1uDw?=
 =?us-ascii?Q?qjHd1IkcffOKmAl851/1o1LVc5JqCHnK1MA8hCFHiu/7RIb7WCDM6aNsRnJh?=
 =?us-ascii?Q?Yzk6n16CstfdyKCoRWoKwbAgvDyvlGNXsbtNL0l2K79saUoV00ERocr6L8o+?=
 =?us-ascii?Q?QVjtzhjpPnvsXsMzZSiS3fr/B+muQijuimLOdIY3eGhnfegoQaDasGYaFdna?=
 =?us-ascii?Q?qNyIMO7u9lVe5tJ3yHCluWRnngVRsYiKBCtfZnS08mLoBnQMCklYL1mVz8ay?=
 =?us-ascii?Q?jJcnOX2nbtdiU1mhK0ItjTdZXHeZCFR2FMM6awla0yDYET+PaQ82VjL/8i72?=
 =?us-ascii?Q?ZZtCM1dSOYXzGJJXK6TTrrfmd+1nPpP7dKO3YLtI3LABKfWcHdiX9oLq53dF?=
 =?us-ascii?Q?WRziSVdFsgkR58d8ypvxOUVMSPjR8RAyu4WzGYanknZpja4lnAnDGwbbEE3M?=
 =?us-ascii?Q?M/wBWy572cXELPof0sj5CCbicXiFCRFjtpRvKrw0+H0SVoTYEmHec1j7+8ho?=
 =?us-ascii?Q?TTynqwSBNd2aPj7rl+zn0uau2YS2BaAOhvbEBpcZIvpawdEMc36sEv2vshjI?=
 =?us-ascii?Q?cDNf7rSA2F3sluBstOllgIjyVn5jgRelz/U2f5c33/pQU6ZzjrqO8TYAwAyI?=
 =?us-ascii?Q?i7P0bOZdMIuCcIYasHgWXZIIctxgLr8dFps/71RNnRLxdgpVSFvNatxh6N8A?=
 =?us-ascii?Q?gq5oRa2NmRyv7w9I0QNdVaqK1thk8JYz7qDLVuy6/cEMSealOdWWPHkua/TS?=
 =?us-ascii?Q?kkQnUgUd6kwXBsUI8P74hUyWXgNkmzQPw/qhsAB+0V/zTVLWfXOSsduuq77t?=
 =?us-ascii?Q?morn6sru1HuAgaV0w5TGJyrn7KPKMEskW8TZqxebX5v2fJ8dzr6kkgmLAjP9?=
 =?us-ascii?Q?d34nB8fM3q7dAM/mYWJEs1pSI1M3+xzkRD/J0cg4sKYTQRJqeMSI5Mmo0g6l?=
 =?us-ascii?Q?ngpYoLz4J97IeqPCwahzC4hrwDtlQni5rkc8//XkqwfatAtPB4sZMtw4H65h?=
 =?us-ascii?Q?i6pYldePNhqZxL04O5zcYRA12+fsk+hegqtWZY0926Q8Nneoiyt4TLzFRwaJ?=
 =?us-ascii?Q?x2aJFwxY3CtRExc/2pQqQgjFCCaqKtVqrE6JNpqp9IN8MPQ/EPbuwNNIdxEa?=
 =?us-ascii?Q?A6wdZ3kSQFPscvIA1QFA3s65j0PyIvnKTu3Sc2fhI4ISwoj4qYl3MEHaduvC?=
 =?us-ascii?Q?JChEE03EIFEtiv8yVup/6v6DkV+FH2V78OAJ0SrVEwK9QRDG1YyjSk0pMb+Y?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e65dbb0-9c97-44ff-a44e-08dbf5b75833
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:26:41.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: groCDzvBvcs5N01hZ02ocWnupASczp6iEDeTyM8sYNJctN3xgKuo72lyScYEoA1KCsq/ra8yDGnjo3rj7p4aWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947

On Tue, Dec 05, 2023 at 05:04:14PM +0100, Tobias Waldekranz wrote:
> This change contains no functional change. We simply push the hardware
> specific stats logic to a function reading a single counter, rather
> than the whole set.
> 
> This is a preparatory change for the upcoming standard ethtool
> statistics support (i.e. "eth-mac", "eth-ctrl" etc.).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

