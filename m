Return-Path: <netdev+bounces-21373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0B763678
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8847A1C212D1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767DAD41;
	Wed, 26 Jul 2023 12:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C0CA71
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:38:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB322129
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkRW0+GYJQRmPgTnvyKuBfWn0HgdJqa7le0XtyaERZJfstrWd+s7/BB4eckVrK19rl5oy/XfsU8ooQWFnIkRMu13eC4oH/kNuRPCzvKN1DzY5U+/U0KgTnzPTuNGbeDFzgGN4ONTjnBUi5J7xxXaLY6NQ4eVa9IZuWsDrDw/x8jaQeMe0kvtC+UdymuAdMNCYoeNSctBY7/lGS1jV0l9riRCogfxo1a77KnQjOVBzZBpqt1ryRZhBKgbgWBRFNAoekLclwm6DpUz5HTMhg0nMWbjsfpoIGYTf+4Psf5phhMV698ojOpmmT/hBgSQUsC2R+7f2fiM+zR08+4XT/mwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRvQxQRG3v2k/gNQHdbXyEzgtSoIt0U3RD8ZJ/IuAbg=;
 b=SZCh+kcvPecbn4aRgY7FNbR5K3i8JtjHL0FERHxZVjCS+8o1oC1+QGt8dKLBXUwH0z0RHvDcRyik8X5+8zlKLFdTJsysx0+/cm9CuK6l7vIB4ONR4Rehd7maj1295zTOSyPTNBvuGEszTFSpVr9JoqidMGK4+Ph+z8is4iMVIg0PwsuhmGZo8DXJ7gMV0Dh3w4+OBIXG21IXXktOWff+Xihjlx321t7gcHsMwzdwvk0fiwjagWaVqCA8887iYxNPWdW7FxxLCZ5/RuPCpUGm3RzSkcOC8h9uLlmsCZu5jIleaa7wV/YRf2ZxM3d+5jc3uzv0SCsvLa8WDU5i8EPniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRvQxQRG3v2k/gNQHdbXyEzgtSoIt0U3RD8ZJ/IuAbg=;
 b=JzoCoI+ewVrHEzu1/1BpmZI1YGqEkrweppbClW9bNJYkNxktyImrr/M2kpcekcahvBM5j+cVosjJzOrpdA0a/FKAqqTuwyYiop+lGca9fs0zdhcae2WIXa0OPJGpJqgJH64qt6f4rTP+2ygyVaV8MbEjvPKsYlN7M859uT8rfOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:38:35 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:38:35 +0000
Date: Wed, 26 Jul 2023 14:38:29 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <ZMETxe6sXMRvJZ/3@corigine.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725162205.27526-1-donald.hunter@gmail.com>
X-ClientProxiedBy: AS4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5495e76c-c307-40aa-d96b-08db8dd53a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QpV19/jd+1t9kqDtOtyJIttm14NPqutJQsHQ3Yfus5INKA8Gl1umCjDNA1gdbeeU1YQZqmc+4oRHYzSIvESEYH/jRDt3A/whWehTn64ayFSgWoGwrLe6RMNfwuhwuDIEJK5AUYWq1V6GrzRUvCDogV58jQP1xon7IOP4LLTK3h3moyrJxIBFE9C+KWIPBEa/JB0fa0zfPjGqPoK6id+bHMZqQik63KGlePbzZ3ngwWt9qjari47kALQJ3wHxPkETgbo7jggUPULeykT6X6xEF2izd2yWhgg8ci8oVZMEFTOKrVNgFsMyGEc5jTwoATUCbXWAtLXy1KROj8qQdEQmfPjtS8Cs+ipkkR5NfQVD65M0y0+oAw4gxWg8IEzmDF/01SYTsIzVikQ6D+XgY7wdXmBnhtTUq+VFPZWGUFMt3yL2DE/XD7QTGmoTvKkMdlyqXY2o/M3tsQd986XENOA5Ov303EegI5pYx4Rzip/9P7eQdMu0EPaesysO9jXrTMvM9eRklJEQuLunryF/fwk5vSXMoR5/wycPn83FTL1ZjB9BbnNToLmtql2+DpIfWsAbt3ABYZ1oUa+iek8WOx7Aaszmt4mNcQyXzPP/OuITI1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(6506007)(6512007)(966005)(6916009)(4326008)(54906003)(66946007)(66556008)(66476007)(186003)(38100700002)(2616005)(44832011)(5660300002)(8676002)(8936002)(2906002)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRL85yOI9pXxoiJv8o54FU84vNqwg8M4rIAFbSioaNzdiGopxkjCtCfn+CzT?=
 =?us-ascii?Q?vRn14ks4Hqbac/YYnY/TB2chpoFMkX4UONAWNXVYsJBStcI22Vz9EN0wWn0Z?=
 =?us-ascii?Q?fPLGS5joeVTL5GD21pcDY7ptM3zaKImgoP4WzWz9T6yO9Nre8aSN5rlIbqcw?=
 =?us-ascii?Q?EgxJRyu8dDJQaPjnmAfYEhF9uRBkLb4aTTskzqhJgNqxjYR7674eVOhtlvDD?=
 =?us-ascii?Q?MArgdtbbcWBvmV8TwDuZg6ubanFjAxVTt1+yLju5AIjEjySMAHHFYYWEakx8?=
 =?us-ascii?Q?6kr3oo6WaL55Od3IDSutgQnmUB24JNbYUU1XWXkDMkz3mLv13aZkBN+bYx6x?=
 =?us-ascii?Q?XpNmhVVnYgI9Q+ePT+1XGWPi/+7d20VseE48Uawjh7oJFALUp1rDKiTattGv?=
 =?us-ascii?Q?LUaBzrrNFlnVyH/37qPBwQwzc17U9mI1qPndou25Wgb2+xh8E+WJrl1J/0w6?=
 =?us-ascii?Q?6QfBIEfx3g8Oe/bjnrxlE/P/i4pI2fwUIZC8+7ppomYjPsyr063cdv8TcokN?=
 =?us-ascii?Q?9k0KkMt6GxoyJfUucMuIEX2AoV1co/ecxlAf0gp2CVror6PSjHwf9iQoGTgp?=
 =?us-ascii?Q?t+NEtUHcUOy8Z0C+i6zab/BMBMgvq3p0/ud2HeWWyPO4YesWChgpcsCInWV9?=
 =?us-ascii?Q?I0f8dsAfBGeobdVjGQ5QI9k/o0m66txi1H/S/l2W8iBBx5+seyHzQYPwWeT5?=
 =?us-ascii?Q?tE6AsjYJMA/GF8QysjRf3UVLQPZkp4CaOutmiv/ESC/+r1m8mArSof+hNzIP?=
 =?us-ascii?Q?c24P0MwhDjh/KXgg2tLcFPfqSRgMlEMVy7rueFI0bxacfnECKjczOuiXEs6L?=
 =?us-ascii?Q?WZNg7Z2ZEule/T7tX7Cnv6FQGk10BDpDY8FS5TpUIrisopkdMA0mO6nESmFy?=
 =?us-ascii?Q?rcBlyC6/jX5wkAXeuDg86gw26/Q4wH4EiVyJ2wDY5LTWnkjOTB9nqcBdmIBN?=
 =?us-ascii?Q?NQsvZfMzRGAAJKX2G75mFdk5v4Vn002yr6/sdclqMHnFap1Noi/NIDcGdDH6?=
 =?us-ascii?Q?13H8YbZg+JLYGRsA/5glEDLf+EjomS/5V1U2BDlfIYdeWxm6YgfgBTBkB8Mo?=
 =?us-ascii?Q?d0k1QHOXKOJeqef+OPA95mzqqsL3S062UsDPZNbrC5LQ4e2wnHTMC67TePeA?=
 =?us-ascii?Q?w88Xrj3+5kZLzHsF3E35XuXZPyVz9Mu275GShOrXJalPNB5O9nKbhi7+l9mX?=
 =?us-ascii?Q?hWBBKGE71kVxONLihipWbfZZGlKPG18BWXkdZXzRvviAcJVYF379U2yBaEOk?=
 =?us-ascii?Q?HtHRDNF9ZLbtOEjp14PJMMRtpNmwxTFtYyaQ1FBxt1JAzxfj3XV2wMTCC8N4?=
 =?us-ascii?Q?zvcDr7PfVTfNnmVkdQqil63zSt31soJHtULD9fpX0ez7Vljf04uheGUepMFp?=
 =?us-ascii?Q?lUgjKSRh4EXP3OXcHRNGh34kgxC0UDfN4YcUsyARynirC3qgDgXAUZxsgh9V?=
 =?us-ascii?Q?/FmrcuPHQXS8ZZEjaNyijc9WFEiN/N2+AfxWUlB7foib3FNe1n0vmy3nJZ7f?=
 =?us-ascii?Q?p78OCiKd9qhMNH12KCRaJjh4GwxjBsuQXgaNDQtSv8V1ZDV/zXjRq6nyvQtf?=
 =?us-ascii?Q?k1BaqkYGAPwsIgC9mL2BBcmXWBIJCxx1k5jnRjF9qg28/KQt7XjXVyOlHVXE?=
 =?us-ascii?Q?toTdreuyaji4BaT1UuteF9fdEn6+KKW4PIOn5ygcuxnx/YqYWXgD23OCqJod?=
 =?us-ascii?Q?jpioDg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5495e76c-c307-40aa-d96b-08db8dd53a96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:38:35.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M/L1XXiu88pAZfCo0GXHI/K3Jm+T0ZF9m4/NhRvXbyMRPnN38/ei3UmC/XVSh9ZSLUgQvzsW94BiqhsrE6jCzYLWXm1XsuDB7OvtLK9Zng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 05:22:02PM +0100, Donald Hunter wrote:
> This patchset adds support for netlink-raw families such as rtnetlink.
> 
> The first patch contains the schema definition.
> The second patch extends ynl to support netlink-raw
> The third patch adds rtnetlink addr and route message types
> 
> The second patch depends on "tools: ynl-gen: fix parse multi-attr enum
> attribute":
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> 
> The netlink-raw schema is very similar to genetlink-legacy and I thought
> about making the changes there and symlinking to it. On balance I
> thought that might be problematic for accurate schema validation.
> 
> rtnetlink doesn't seem to fit into unified or directional message
> enumeration models. It seems like an 'explicit' model would be useful,
> to require the schema author to specify the message ids directly. The
> patch supports commands and it supports notifications, but it's
> currently hard to support both simultaneously from the same netlink-raw
> spec. I plan to work on this in a future patchset.
> 
> There is not yet support for notifications because ynl currently doesn't
> support defining 'event' properties on a 'do' operation. I plan to work
> on this in a future patch.
> 
> The link message types are a work in progress that I plan to submit in a
> future patchset. Links contain different nested attributes dependent on
> the type of link. Decoding these will need some kind of attr-space
> selection based on the value of another attribute in the message.
> 
> Donald Hunter (3):
>   doc/netlink: Add a schema for netlink-raw families
>   tools/net/ynl: Add support for netlink-raw families
>   doc/netlink: Add specs for addr and route rtnetlink message types

Hi Donald,

unfortunately this series doesn't apply to current net-next.
Please consider rebasing and reposting.

-- 
pw-bot: changes-requested

