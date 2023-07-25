Return-Path: <netdev+bounces-20905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F356761DC4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6078F1C20949
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40723BFA;
	Tue, 25 Jul 2023 15:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C46200C6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:55:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1542109
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYwlknvXXBjDgVgLckijDCRiavOXttDia8clPT/SzKn3zZSSgdh2EMwSVu3nAqZ0wZV0XQwn73AuIhzeFOxVe36suR2pZ483u8cSZFbVxgRQdGF5QJijgUTSZbL0Idp3R60DKUKic9xLFZzuK2/IYp8J9KrB+DrJadrE5s8E0Mkc3VDQ4KncAvSVECY10TUneKNVfIGQYmLMgtxsqsTjt5wwJVgTGuUsvOCkZ4accuxX3ZsSBzKOdMXUnC2hFMEpgad1OyEMLw72uIOcz4WAHmQKS9j+/LSN6fci0fbE2DB7Il2/Iy76rExco/renqKlHgrOCaeeBfBwWk/VFdnnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7bVzvz0nbx+BvXQMHWkHCyt/X5FqI2NKgLYWfuKzD4=;
 b=b+ZNvRAuehVttAoRglD1XYvRdMRm5Axl2gC8K1dJUvGPwrIaPd+BmcoideAPe0bIXy/fFT+JLy4c/s/ttGxmDrTsN2MKJuZfd6gnk+aoKbhzw2dd40j61grHfmqXYU1lm7IBdo23lKrJg6KUHbpdeMn3EaQRLACIXBqqiyroxbUk+KBeoQnE37JjEGdlxz6x+VRpV3KxLAEcSWGzwR/D/e0Ziop1ZI7NHvRw54wpEvwT7QJg0RXnL0mEO/xrnQY+KeUEuh47jW44Eavnfi3zYJLnrMsflSpNiE6eTB+QdZqFg6blVZREEEVzfBu/pXlM7Zl1sqJDea7FcKT5FqbdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7bVzvz0nbx+BvXQMHWkHCyt/X5FqI2NKgLYWfuKzD4=;
 b=LVC3iikwqfnoYB361ip8aBt8EF5T8hnhp3t531E9lWTlHjDwpsbiDrJoo/Tk0lqi9Ze/6HTJxuddZ90B5NkYxXtqaa9Bu2FYXal7XqZcMfnaCTpf1uKvOL1C0KAfJu+tOdkmBixZI+UgTNR9wxHQ9qAo6Q2lqYotz0mlbwPh7X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5159.namprd13.prod.outlook.com (2603:10b6:8:3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 15:55:26 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:55:25 +0000
Date: Tue, 25 Jul 2023 17:55:19 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Daniel Mack <daniel.mack@holoplot.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com
Subject: Re: [PATCH] net: dsa: mv88e6xxx: use distinct FIDs for each bridge
Message-ID: <ZL/wZ88jfSfqfAX2@corigine.com>
References: <20230724101059.2228381-1-daniel.mack@holoplot.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724101059.2228381-1-daniel.mack@holoplot.com>
X-ClientProxiedBy: AM0PR04CA0139.eurprd04.prod.outlook.com
 (2603:10a6:208:55::44) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4409d3f2-5f17-4daa-a663-08db8d278f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MPWDFU8wSbBiLfQ1jfRo0g7yD/JpEiFxFBSghVprPAKjVhuhYUNXr4uqgcYd6fKckftiVshVoEzCrAk3PSxk7L9MSZKGTc3UP32sa65N6k1zdl5TjMz4DTZaQVUFfa6N4blScScZMwxIKguMN93cWvzZQ+J+8ZtTOZu5O/PYEsdoHJVIqNdBDCvrE6rU2wcPnfFFvNI6qW9kRsZMlbSQCuSHipUrVNCNDI/2iTAee/F2cuY75qbqR6gMP9Jku8IQHTJvgbgXtaYHdj6BloycydodaeJ8y5e+Po0VmcMOW/tsAs7exRZs0xPJsAlIiZRvgU7nvSL/4qpf7VJ/dIAuNCPfCmfhxjGLM7FeaPlJZoI62JvTRC1x0rydqRXM9R7UXtGRAr6vRAoa0aVYso9OZQbfdik6f4GkZA5gDNGQnuQNhnYTYNiZr9TDcLrEglAcViNwOc7Gw6g2LCybifvQBemV2/ICu/OwMasrxhqGgZtkdoC60r/M0yU9YsgFpnTfJeHXts9PBxDUkRaUrW/sqjnrVPLA/XyucWo9Z5wDgLvntP9Gn7bCTas3/CZwVxaL24xNzj1iw4k06se5pDgDQcWmUzINJMEDtPq3fxEHfuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39830400003)(366004)(396003)(451199021)(6666004)(6486002)(6512007)(38100700002)(41300700001)(478600001)(8676002)(5660300002)(66476007)(8936002)(66556008)(6916009)(66946007)(4326008)(316002)(2616005)(186003)(6506007)(86362001)(558084003)(44832011)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaQsJR8AArHcEiTOcmP8WevlB3YwcGiZqWGKxAgjmkdZYINiCGjGcVlVqf4b?=
 =?us-ascii?Q?0tj/hMma7FJVuiQr1Jg4w5IGBaaP01mtfEuTBqIvg/Wf5T88K4CpYcuoNn0t?=
 =?us-ascii?Q?PM78Q3N1QE9k+lZybXmj9UrGyZlv6p8vO0VVuYa3xKcA+Cy+0sKPCfzKhtWy?=
 =?us-ascii?Q?ziCaHm7ukvb7VVwMt/9HR+2TLhIUOg4hD0S6FSgKmheiYYvJIcy79By2Hzqu?=
 =?us-ascii?Q?89R8DIBDDBK5rQwQpnhUJYyEzwW8TjywOhHufK7Sf/Si32rtzSRwX56gYyKj?=
 =?us-ascii?Q?7Stxy0mBcrZBl1M1uejnesq0HHNqqdOw0+G4hTFAqbmrs0Hz6sHGVsvm89vF?=
 =?us-ascii?Q?m5kPKjn1vPB6uO/10qrU0502UaEriZGvNoux+yub2QX2eUMxznxMpkR4zERs?=
 =?us-ascii?Q?jlJZ+y1yvzUdQCV9trn282OCph0E6h5KpbFYzYlUP4Kd+W/m07O5HY2WF7AJ?=
 =?us-ascii?Q?nBGwtHbwEILc6x3zLUHY1sPpMXdTqC5MN63Z4FySKFVSulrc4Cb4rXANknjE?=
 =?us-ascii?Q?9KWUgnJuFhdEDpQvvazNd2T9cvyZjAJRhq6/nZsmt6yYHUogJDDqHbWZDUdg?=
 =?us-ascii?Q?AofHhXkGglTXK7r2IbJRd6ugfOf3k5ctRJnNRzD09bYcHEs+LnftwU8sMKpK?=
 =?us-ascii?Q?ZzkoG2aY3eSVZsK/Jk6tYhPH6p7mnpgezqbDzRG8akG0GFtbGPrNkFgx/E9b?=
 =?us-ascii?Q?0AzMt2njghx/qus90iyL4i/rQFEJDRLWd2d3sYxAUUQ7FxfIEC/sHcC6Ru21?=
 =?us-ascii?Q?mT5i9oLb3ZNh7oSNfs2QC1upNOiZF8AtIkdwXww+LqPsHc5L7qUEfjJWMMOy?=
 =?us-ascii?Q?WWkkjJ8E+SsomsnkQYZBfJWiziwyJlx4DRYA6E6hwkIqDAVhjSDKOnsJV0g/?=
 =?us-ascii?Q?+tKqliE+ISWsdtJvKtJQxhzJXYhTdSVJLSUcnK7OJDRJVffPl5Ln3GpMgKs4?=
 =?us-ascii?Q?4ZWrRPpLsu7rZPcMO1JHacrWTYV/gsq2M0+OWL4ZbZO7QUbihA8eTOMsrRC5?=
 =?us-ascii?Q?GJyKND3XXDIcIWU4SOSC57CkNb+IlnA0m9F2DrV2194kUhnu20dmQPMoNBAT?=
 =?us-ascii?Q?E9QssIt4QRA0CpOP9s57k60nXG+mkDhwOFoJgKf+Sk2SZdlTwGixhnAjNUYi?=
 =?us-ascii?Q?nLCSUBUZkemUz+dApu9J8+x26nszXVK4LhJQ3qBusqrWRvmJWiXG2Rtk+zv2?=
 =?us-ascii?Q?kygIF7S0pdi8vZTejt7awIrvyPnkN9qGNI4Wgqjjho34Rtm3H/HGMJfuXwJ2?=
 =?us-ascii?Q?BN0lQNt+3WEiCJvzZBbAfkBatRpTRwHpMIwcCgFJY9nQaMcLBiFkwPhjaMQP?=
 =?us-ascii?Q?sJsFWsMrGeAJsMdULCp+BN0VypsdsTZFkNCa196j6uAbGGDzQZEnJF68Fk3R?=
 =?us-ascii?Q?kweH1Ms6yYPX9lSw9+q/w6I/b8o+g2qSmDYAWyLSE6GM14y7TA5aSWVax7y1?=
 =?us-ascii?Q?N3hqQi3PY2+VOdazkvdjOXhQbY42T22cbCWkatc/0ci4SqW5n4GgeNRjNOVo?=
 =?us-ascii?Q?oTP2LXSKxhZxrYY53dUR8bh55+BpyAmaMHCLEkWgtbye/v8Dn8vg05ijK/XY?=
 =?us-ascii?Q?xxD9HXaUwuuTO5EEke5Zz8u8VjrzMsyH8pk6UP9ASa7GXpxYsGj48t2KEJu/?=
 =?us-ascii?Q?ObjrOip/jyvr8YMwEFdlapbVhT8Tl1hjjMBk5g+O5KcJqPSg8f61l8LU9acI?=
 =?us-ascii?Q?/KP7hw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4409d3f2-5f17-4daa-a663-08db8d278f6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:55:25.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqqN3Ptk6hAXA4V0h5EH3NL9fOijuobZTJWMEcBYjw0g6/zJgss0J2L7nMAodbXt5us0M3pb5Voo2U0P08OVWWqTbfC1ZHuiHZSc4jqJ9iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5159
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 12:10:59PM +0200, Daniel Mack wrote:
> Allow setups with overlapping VLAN IDs in different bridges by settting

nit: settting -> setting

...

