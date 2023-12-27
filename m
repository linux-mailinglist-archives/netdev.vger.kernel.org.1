Return-Path: <netdev+bounces-60411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3A81F1A6
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03C21C223B8
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1247776;
	Wed, 27 Dec 2023 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJZRIdji"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7847761
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXCFW+//WRJdASrOaibJg9T/Jh68p6AHP+2r7TzjDJKYV5+kD4jueTHwxoyQEltq11UDT8HmzPlLc5PxIx/fxpqqt41DwxksmYZGpvNjX1pyleHR7erx1UTmtlUoTVzxfblJWJMtT65aRyatZ6Wb7rahO459reeN048/nqspMqAuHkeEmQ/cJXaiAJFy4+GgnxA8fLJD8efzj1ZCWd+NuR9VnJCzLdHwWtN0Xngg4/pI1nKaXb2/diekczb6aGc4j54eXOTNPdJHiCpiSdorca9xe5L8rgT8GbpQnIq4bhylmO2cxajJBn4bA5NO0gr50xjSDOIburp0hC/MMxqkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv82ZzV4S5xEq4mLJdxtMkeL9oy3V+5Zy0cZ0h2gxQk=;
 b=SZ6AFsjkANPnPo9whvorI7BfLTYcw5Cb3KnI4+RN4OyODTDspmuCukhbes27rFxZv9I8/owspa77O5QmJf/OBhuWEDKTHJJx8ZTnNbyJILJdjBqmzVKM/CR/+KHZXX/fQGHwJIwweJRv2+hhkSHXK8slaUNlHnz55BAJdHlUUspkCSI3XEZGwUzYJUBB4B3MKPUfvWrqz26dEi3InEWfuiRbDuoGYaoiK7RLk+18HB5CHYvjA1/MPM6Aq8PgdJItKsFCZFsTdCqNqKIFm5cmkBz3qAGlyXXZaX6bI5htrKVY8/9gc5BHxUhhYIP8++2nrbtFAxLEIs2jdEJ+oMm2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv82ZzV4S5xEq4mLJdxtMkeL9oy3V+5Zy0cZ0h2gxQk=;
 b=bJZRIdjiJb0tNjXLksvj80+MSXlT/BWcXA9RaJgWls2QyDYcLgfBbxK6ktyY3KxxINTJmr+lqyPra4WuFyO9YKWjz++HdAAxs7BqUmaWMLoTu+PSWN6RuuttBRG9ZQU5q/4gCianJKR2fYm7Lrgi6jliPbFZsrtEd3+4ku6tKx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7220.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 19:47:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 19:47:02 +0000
Date: Wed, 27 Dec 2023 21:47:00 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 05/10] selftests: Introduce Makefile
 variable to list shared bash scripts
Message-ID: <20231227194700.zqhod5nbn6bibub3@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231227194356.7g3aec3kujnk2qo2@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227194356.7g3aec3kujnk2qo2@skbuf>
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c67606-4923-4f54-daf2-08dc071498ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIX4tJZaUnEqW7KlJ+XgnjvKexo/Wqpxj614vGM3jzpJl+cXv0qjSf09YSLxsHF6lsJ6MWFfWtvhedGN2Vl41KNf33ExhuLnfZ+70pv3ewQ1Q2yqsDbyqOz/Q1g++/H1iGnGEMWWbb9gMZNUnK595UEbuvPGMJUgna3Sxs9chDzFl5DyePVTSte5z6fMWb78yVrecGibmxlOPdTnhV6k2q+80srwHVhljoU54KCofgofrehlP8HFQXRo48mty9uvnzRuaFOtQKkdlr+g9/UWp1c+iqRvQ4guBXI+oBbS3Dv21ryNYacbJ3b42kgerHnDT61WirQx/aCp6Xy1ZCtR1DaBpGbYP/dJlVk0LlXhY+yPrUOFn8G51x/XEaCYNaJVE+JVVMCdNjy0uX6RF/m9cus/fNGEmYIzWqShO3aF//W1eBLI6690h7bOjdOy6Vk0UKqgo5l3kcWYLBK6KaPOfQyB4qTany9W2bAHshSgpx4E+IEDtwBb8740UnZhIOkolB/D3IPbSZyGFuMTq9pY78I9TZH+tozl95XHJRj6ehU96xxXva9OSujTJwyswGyz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6506007)(9686003)(66476007)(6512007)(86362001)(6916009)(66556008)(66946007)(54906003)(316002)(41300700001)(6486002)(8936002)(8676002)(33716001)(38100700002)(2906002)(4326008)(44832011)(1076003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+Ir2HG8tOZTStG0qCAKdz46LZz1BsY2EnpCc484Lxfj02Reo+2iDWas4V8R?=
 =?us-ascii?Q?DLyTYMrtS1RqYm1ZnyJ7w9pFpbjGxGOsVz10DhNQBBXISmrLzW9U/wauPM16?=
 =?us-ascii?Q?WQEK/Fuwa64Hk84tRfjkIZevwVZYw39L4Dj1UBUMvGL2zrUIJ/oW3eMQYX2x?=
 =?us-ascii?Q?Tc/kbicE5w4nZ3SVkLjF+ZqWOcp6aVPv4HPV6bgNqQyLUR3pi64uhiA+jtM5?=
 =?us-ascii?Q?0zJZmOhOiSgwGIKYfsRtTIXkTzV70wVJee+jD/wfVZKiC/SveAmHl+fZW7Nm?=
 =?us-ascii?Q?zQ6CY//8hwrJwYyWWbdqhaYT7VOmmPk0MYwgJOkSd4SAEyIvr4OiEdjsoxLJ?=
 =?us-ascii?Q?nOoIrZ02y1YF+Fv7tZrtgPAiV1YqbBA8jRlX3a7pZrORpW5eVE56DcKAnY5j?=
 =?us-ascii?Q?kq1ZxsmnqiLsrDC4GWUQ2YQfARCkoo4A6K7Gq3lwxpFl0iUHz0RY5OcsxFQQ?=
 =?us-ascii?Q?GO5LuhifRucjG4IzeTChNSkXu8ZuDBu45pJFSKOALHR8QhssEcxzONyLGEYM?=
 =?us-ascii?Q?1gr7Bqg4y4z6ItuF05yMWE23gG4RovubUPLpT+5NTf3hrV4dUyInefZE21pK?=
 =?us-ascii?Q?lM/sSLdoxCTRj75hMofk2kAIarwl4vMJ7qZMuGtIieuX4HtBMvLDb8SbGHyF?=
 =?us-ascii?Q?jFag5p7ZF+IqhBKF9NA+fHNxTwKc+TZbGoTiqJZmesVTlXit79EMzrgtLEsz?=
 =?us-ascii?Q?ERvS2bSYyovoXOze6TG8oimEdpGYqnEVK/xkurp56O3WbAcwk6ELPhO77Tr9?=
 =?us-ascii?Q?foIKkWhe2ponwXD55IFyKwVZDp7811m1/rgD1uUAyknHuCHPTWLH7+WHQL0d?=
 =?us-ascii?Q?J50pCTN1gXOYm3lOx3epTTTIOmm4xZM3f4t3Q5fz2Hdx/rjjPpv4TpQC5VUj?=
 =?us-ascii?Q?vH9SANIiAqzUFjEsg5Ib0i/j+ExdiJXBhJkzUbDvqcWeIN84JsyCP3ydwkvm?=
 =?us-ascii?Q?dXM0R8DNLFmS9TXIAF70bHlaIdE2T8lbli2L2BVAhkHDnIzIk4YgOLXH4ix5?=
 =?us-ascii?Q?p0tXc6jZ7OYD39tUM32kf0ojQz/JjCkwxInqJG00ikO26Bbz3b2os5y7M1Ka?=
 =?us-ascii?Q?FQi1L1WS2ZUKHVBhjQEYg+g12C4i+MxLByYyGspPxuhEjofKMzd5AyLFaTu+?=
 =?us-ascii?Q?R/gNSGrHwTlCHcGYJ2yck/d0AJiuIiwoaJTIV1nIlchUfMPgJFFUT8jkH/Bz?=
 =?us-ascii?Q?FT7UtO0cP6ZIY3LCWuDAr6dn2iMB6sjS8hD94asPPGVEWlEKSUx0ul/Tqb2I?=
 =?us-ascii?Q?d2axZAVQlBGbxlRSpHOt5Z8fJ/xREILKoWD2r20aDEkkhV6SXNr57EmJHjgy?=
 =?us-ascii?Q?Di6OQwIbJmiDXmOZRoQDnRRsh7a+WGHQZA/PRJFX+PqDYSP93WoTsTNDzvec?=
 =?us-ascii?Q?pZzcM74hVs2DWF6yE1X3NpS1jScJUknkTg5gzMQ+8uijX5RzZqcCmVJoq1k2?=
 =?us-ascii?Q?912yq3NSBU40oLh7gaafIdPEv+999dILmRzXe6lN+l9M2nyBJ920poupapW0?=
 =?us-ascii?Q?q1gmH8xgipWcz2qAW1wJ20Z+xpydo7nP/Wq1mDKA0Lz7cwoZ7MpwW/fxVWIr?=
 =?us-ascii?Q?czS/r/1WiijAzRIvOWvsgVeqUhmj3Hia+2wYUHOxqbYBRAiqgmP4K3KWTAl7?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c67606-4923-4f54-daf2-08dc071498ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:47:02.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuzcOqQOxnrRKAVbmg/h/5VYUsFloIVN5wmZMHklaQlVt2xxJFBqI/sE+IeRETuUIIubo+C4DmMf1aEI3d+cOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7220

On Wed, Dec 27, 2023 at 09:43:56PM +0200, Vladimir Oltean wrote:
> On Fri, Dec 22, 2023 at 08:58:31AM -0500, Benjamin Poirier wrote:
> > diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> > index ab376b316c36..8b79843ca514 100644
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -255,9 +255,15 @@ Contributing new tests (details)
> >  
> >     TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
> >     executable which is not tested by default.
> > +
> >     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
> >     test.
> >  
> > +   TEST_INCLUDES lists files which are not in the current directory or one of
> > +   its descendants but which should be included when exporting or installing
> > +   the tests. The files are listed with a path relative to
> > +   tools/testing/selftests/.
> > +
> >   * First use the headers inside the kernel source and/or git repo, and then the
> >     system headers.  Headers for the kernel release as opposed to headers
> >     installed by the distro on the system should be the primary focus to be able
> 
> I've never had to touch this infrastructure, but the fact that TEST_INCLUDES
> is relative to tools/testing/selftests/ when all other TEST_* variables
> are relative to $PWD seems ... inconsistent?

To solve the inconsistency, can it be used like this everywhere?

TEST_INCLUDES := \
	$(SRC_PATH)/net/lib.sh

(I haven't tried this)

