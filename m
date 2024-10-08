Return-Path: <netdev+bounces-132988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6C99410C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B201F29AA2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239C1865EF;
	Tue,  8 Oct 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="DBHCw0DM"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6F1514FE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373159; cv=fail; b=GXg60IFJtG4sYG13LJUU66pO5zth0/rfdGPuSzDH4OSMKVOFuhzE34GgaU6kLidPvC3Kdo3sbQ0Xn+tzONm4cRe2NeenJGjirO96Vdpp/fblmTFF+TW8C6ojOyiNbiW1Sz+YfzbqLRRVdfgDz6ihP5i+H6P9Is1vmZ9EXq40Pvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373159; c=relaxed/simple;
	bh=mguTBsrWgCnX2M7GMlJ/+7hJ7FiqrzENi6GvnUPJj/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEk3n2cfVSjE+j+H4hWzdUKCWXVwhaXXySmEiPq2dRrVatA4VID0Q0kahq9cUlA7ooAjA9so27yeOyUL6e7D1I+k8duUMBqhH5y3WVneCu2WoIzEah8zglo+3MZGx5dEtJ0sTaHBWI3ortV009p6sHJwUetVs0pV921cJ06EUbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=DBHCw0DM; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from eu1-mdac22-4.fra.proofpoint.com (unknown [10.70.45.129])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8E0F7600AF;
	Tue,  8 Oct 2024 07:39:09 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03lp2113.outbound.protection.outlook.com [104.47.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 36B96B0005F;
	Tue,  8 Oct 2024 07:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtS1UP+V8pMiy2PPEO7XuVjS/DfBuTRSuTA5I97IweSRs4n2Isy6sQn+FqU80U0psw10ra8EleHMjwRATAdZYNp387hrbVSqQYkMyE/K/oQMzdl68Q70U7euc4a8Ti3LRBmJm2Q3WIBuzi0upXmNYBVKo3GqNbPeKz43B4k9c6YU4hBzLzvZ8D5zOBnt54B56zTl72uXl/3HT65Y54ZNm4/iztkh3RsrTqFqkMX6/t6gQHIo70kAuqvZH8oGCLuPnCR20aiJveNTcyjFCxBbe7wJN4N6Bjf4MurR3WGjo7hER0yrySjdBCSSVWSoYv0QtWXP6c6vtsOZOZmeE7TGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkYFHsgf/vdiWn0U0Zq9N2S37li/gMm7v9yJIdSIKuo=;
 b=vx8VuViNcGzkCNcgg9PH4aQb7OHsM+tCXVueJdmgFhSXsg5NiFRA8RJVmeKtbdFQdAC/vPGV3HG2cYMT90DNwI/bh2z4+jE1Yo1XlfA9IPKg8DgqmeeypAqUokCC+5LOv7JrAvAWZ0ZAuL3E2LDpxn+suGH9LtWQkIV8vE0ZKg0kP0OTVtcQuVcZe0FIKMajU4oPBWq9jisWiaXI2SPZ10qCXn9BfkNIXaJ8d57N0flKXSE9inR2/hCAXozDA7WHSqj7MHeLZNRm0xTE1W5HedBlvEt11LYriFi6/kqMAZl+v3rqzIBmCzErhZz+ER8rW/r+fYLt5+CDXWitUR8ESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkYFHsgf/vdiWn0U0Zq9N2S37li/gMm7v9yJIdSIKuo=;
 b=DBHCw0DMlmJBBxPKvn+XGqRYYeZz0Oqxg/rPK08cLVYCRYY18H2cO7wqb9GbCPkJH75s/U5XfbXF1IcVvMFe3lz6Xdl9XwjZjZD48rBG6xBLOGfV67VMNqjK8fn7NdSW9oaB3N6Y2jpjCjbdN/QNt39H9MteIaKuHV+PxhsD8C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DB9PR08MB6603.eurprd08.prod.outlook.com (2603:10a6:10:25a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 07:39:04 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:39:03 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Date: Tue,  8 Oct 2024 07:38:55 +0000
Message-ID: <20241008073855.811502-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006155218.58158-1-kuniyu@amazon.com>
References: <20241006155218.58158-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DB9PR08MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: defca5c2-c3d9-4194-eaca-08dce76c4862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFyqG76Ba9c8j5xeeEfE8mGVOILoBUuI1KsiozjlA4TQFJIZqphahCE43m1t?=
 =?us-ascii?Q?8GhI7vd8m9MDOF1K7p8BRt4mZQ/aNdkekrs5C3LgFlbDLoozW2ghM78fpQtc?=
 =?us-ascii?Q?ht7WBtAT2Z2MiC89fZ3Lz8yW4JIR4sEgbKmgDeAnz2bA1q6xoUlJDsnphL4K?=
 =?us-ascii?Q?k4r5EZQcfkKqdCgFvTY6+4xHH+GmXaSTVHpTjOeu1h2JSjZTKlJxDdDigpM9?=
 =?us-ascii?Q?xQGBvGVW3nUYsq/5E4jibcnFhergMJIra2UUpAj+bZsy0feXF82K/Rl5twvv?=
 =?us-ascii?Q?m0B/Wdyp6SlWBaExsdZVQzhtaOtueF3y3XW/ugJxV+cW26ZPqhEiPSJSVpwZ?=
 =?us-ascii?Q?Z+IcXWJXK7ajDVtR5dcK3jSppynWYkelXw+unk+U0bNKOHafWdPSOIOzeYUa?=
 =?us-ascii?Q?zlboWIZzhZG54iSsh9IU5eTLjLWTbG/GIxP2c3xRM6NZMyuaQatTQ1ZHUlUQ?=
 =?us-ascii?Q?tff8g/7LDOzlGHg6Z1OJH2LUi/d28zvpP1JipRFvJbj20oNhrkenED5nhdtK?=
 =?us-ascii?Q?1uUWTvl2iv+PSRKB0lwpocoMLXPtsVKkZWascdZ6zKsP91mTY9TWqaUg+VYH?=
 =?us-ascii?Q?L5Qy3bnhFfxApgyouIEHIlaxLjZYeNetPG2MBEXcYQcmr2cBymY0q/aqeZD/?=
 =?us-ascii?Q?o0Z192aWS7orPPuL6DN6FdHZseZcqtg1cOcqXo8LcaSa35BBA6h+w32t0vl4?=
 =?us-ascii?Q?XqaBR/Ieq19KqUVIqIXIQ4ylyyytbXPvMpKNgIEp2b6P5A6NoSMLpyl66KHe?=
 =?us-ascii?Q?k/T0QxF96DqYir64smQaC2RPsDX6TyOqxfhprF6bYXovINubhPfEU94QuDab?=
 =?us-ascii?Q?YX7XnoiCpXSLgkmY0GPTfVXxLL8WlTBGxlr8qtozgts4ww28tBbQym5rq8tR?=
 =?us-ascii?Q?Ty+KZ7k505XB+1dx/tTCstyy5xxpGaIM8PE4/0cx0qrMtwmmqOjVEydoAFB8?=
 =?us-ascii?Q?N+H4WXn/mJ3LykqruY3KOby8+uaFD/7mAEQ14EqUjSICmdOgpmPg8yQSUQHS?=
 =?us-ascii?Q?L/isHNdhg64TXww74onZyog+qj5zerCqDtxYlzlsu54E04uhJ+JUpQmBRCL3?=
 =?us-ascii?Q?wcCv+VBB81p74V1a4g7Sk36Q/t1wKEgqjXWW0fPu8M7fSDUg9Bkw3DEi+Ldr?=
 =?us-ascii?Q?lz8CHMCHahMfmJD4mi+nJuG9n+1dXh3jd1iUYM6OUzk+2MhoPRy71DfosbyX?=
 =?us-ascii?Q?UxlmmErn9/QrOVuQa9fCm/JltHOLyWprrfblN2qM/UGV8DtYtBH1y/RN6HbX?=
 =?us-ascii?Q?czDn+ze4S/vCk8ECsYA7YXtu+/hLQqowaGhp7an6Dh+Fh4TQ37wz74sgW7GS?=
 =?us-ascii?Q?PU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6sUxruPS18Rfe8XBcuiMfBmrfry+xHnMOwO3oWxRxvl7dSPsi1ed/LyaC/Q?=
 =?us-ascii?Q?ihj7sRLh0VDRCzqGGfxNN4+r45uA4sp2l4X43iafwnmAaz8xlZElT0pSe2SH?=
 =?us-ascii?Q?Of8/AtDM+mt93bqbdpgQIPTPVlwOv+XLfCFKKDN0K9f+0NuXjlB/DnImX0vN?=
 =?us-ascii?Q?ZePBFtPj8P1i8yxXAyVkaJZEiBHRvze8qE+lojF+mfMnbnZKIsxMhvPq/UYG?=
 =?us-ascii?Q?388xFYun9CIoNeZi2XqFs1UGQIZhD1hbgwkXUgsxoDbE/OtjMrogjo/A3dlf?=
 =?us-ascii?Q?8QWc/iQiYKmwPT7cX3Dp0QXUcy4JYBqZR1hC6ZVPdNaWvgWdRXcezhtRRhT2?=
 =?us-ascii?Q?FZDZf2ss76ayfFWIm5oOFw/wj/U7RwEXBMsXgENlz3qAFLj+QqY/JvrjdX31?=
 =?us-ascii?Q?1eZ9Aj07GlVxPmnMNNaIbTDDqqbkmWaTnSzGfZmD1J6iaE4epj9sdlasQJLs?=
 =?us-ascii?Q?INiU9ca6bgdg7f7GnSNani5W+fXittbEOadpoMW2qM3d+AOpbzEusw5BGy6E?=
 =?us-ascii?Q?tncjMTdRAQ3WxV88d2g/JrZMfvtRa27UKFYie4DnBqVDkAUNZPbrPL+iL6rO?=
 =?us-ascii?Q?4wcQvUN9PlDwxLtFwftcIGgedAwHsNiucryAsqIUipZar9BpGdIqTc4mbMwW?=
 =?us-ascii?Q?NTe2AB1Gzw0VPhG6wNzqIRuxDa0Z9cejn5k5Br2BFw7ryaFhLu0dvKOga2U/?=
 =?us-ascii?Q?tQDJsIHtOBBlLlHnKLgIOyC4rDbckZavvoUSqBeuSiDNQ9DC7XHGA0stePQf?=
 =?us-ascii?Q?a9Q0p46YZ3fxFyuQc1bCEIv+vSSqt3nK2dx0ev25yxMl/Pr9QdgrcodtlohN?=
 =?us-ascii?Q?Qtx8DDaPgshZ2XSxbaUS2AjhUQz26xwTGUxa85RQMcyAIXQQayrl8HGdApP2?=
 =?us-ascii?Q?GQ1FCN+1bLImenbVT5AV6vTyzfxaCgNPoRUKSLg9WtviUV42u03n1WTEFAQu?=
 =?us-ascii?Q?eGtyd7WqnIAzAyUPYFQXmJBtHFJlnbYt53rzoX4J48gGyrFVshuzGUEVmHRH?=
 =?us-ascii?Q?H/Ra3Qjnk466h6BpheWefvdlu2smXLMUEBTyiz5RhArNSObfm2isY4yyMJw4?=
 =?us-ascii?Q?9W05k8MWXhhSstj2jf6k6aQ/Csqfm+dwcqDnirDglnyy0qzXpNcCpfp1XRe8?=
 =?us-ascii?Q?JhNRZo0BWSC8F+4D6MPcxXaNUd1nOggbvKD22oc4A4Gp9jsu9+sMXTmxLm6P?=
 =?us-ascii?Q?J6+SfuxYHWjGjH99fIW2CDo0hEMHysRJCT95Gdh0JerwoRpNYJqBC45jhU/w?=
 =?us-ascii?Q?grVyolARxIeVAv7ec/cyH3UehpSmptVACqhoh+GM0qNkvBmTOvEJMZ4sj/y4?=
 =?us-ascii?Q?pykKDLKn/yLiw8Ur0JjMdGCcvE0JGNJoYmlbMkx/V6T38rHzIhpBP+p2R+Us?=
 =?us-ascii?Q?MkovSBMqBCzvBnEybJOkYPjqx6bCI6OKqSaoNoLzpTERRbO2w2JjOOz2sJcq?=
 =?us-ascii?Q?KruxKhLfCHP/SmctqEH39fqbrWSUYPcYXSW+nLf6+alqQo9aK/0csRkPZT5u?=
 =?us-ascii?Q?ANVTXb0JsqlU5mbWWmGHSehB0E75uOg/8cc5dhUYBOMuam228WJcqT4tyt2/?=
 =?us-ascii?Q?fM+3FFCE4OD3We3IRzC4mrAJ15vGyQG2WfXhGEug?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j08WJ6PyOIZsRN5ThJSkC3829O4XTLGO8buABALO1MffPYUs/vGkbe6CRhvhmxO/vTEgfpbaHwnwCuUMLAFDyvrvqGQC5FrnPl6LTzCHBk0lM3u5Tb1mtVx/WuTHi5u9FM15rbN0LjFgsHeNxzCxmZ9WGQOqkIWKYe3sizGVYztv/bvjevWeMB86bMxkii4TZ7LUv1OxxQrZmwz0cO+/4Zs/ANfN67Fl45ENrCDdtNCiYA5RrFVnGWq80u9to1kIYY7r7FsTPBYSfYY92JjaMRanT6F/J6b0gAlcce/IrxjeCsq59R5Bl/pP2yXyxEPGsGH+vzIogT5IPdxV2SgSAzVhSh85R2/kO8iqJIUkoKHXMTCSIRLYwAEa/F9au7iOG0NbIaXEKTvORuYL3wL2kg4lKLf6BuitIxNTA2NmXJeF8ztHM1pVcQ/meWBFZaLIgYmV2sr0T1afXof0ds4mvfQE1IFttH+6WbGAyPNn+OPstPd1cgOXGlGlxwrIxutcU0EP+kyF2u3KVJH8zUk8Nrx5ZaE3ph8CJuMRFqsaVosnWs/P7Ki3f06fsU5o66aXfsV54XsUu1MrbrADpNdyG/3uIGz3dTUmgCPNW+1zKHKOHz0bDSj5WGWP2I1UasJ8
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defca5c2-c3d9-4194-eaca-08dce76c4862
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:39:03.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBoeci2DDhfupDORRX5uAXv1xwdkEsdOy3h+ZTiM7ACSS8SbearyfSAqHYFNx+PQu8yCv9+q9PwCrA/4d16kDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6603
X-MDID: 1728373149-0Ra9JiVjSxZq
X-MDID-O:
 eu1;fra;1728373149;0Ra9JiVjSxZq;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


Thank you for reviewing this

> > Use doubly-linked instead of singly-linked list when linking neighbours,
> > so that it is possible to remove neighbours without traversing the
> > entire table.
> > 
> > Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> > ---
> >  include/net/neighbour.h |   8 +--
> >  net/core/neighbour.c    | 124 ++++++++++++++--------------------------
> >  2 files changed, 46 insertions(+), 86 deletions(-)
> > 
> > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> > index a44f262a7384..5dde118323e3 100644
> > --- a/include/net/neighbour.h
> > +++ b/include/net/neighbour.h
> > @@ -135,7 +135,7 @@ struct neigh_statistics {
> >  #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
> >  
> >  struct neighbour {
> > -	struct neighbour __rcu	*next;
> > +	struct hlist_node	list;
> >  	struct neigh_table	*tbl;
> >  	struct neigh_parms	*parms;
> >  	unsigned long		confirmed;
> > @@ -190,7 +190,7 @@ struct pneigh_entry {
> >  #define NEIGH_NUM_HASH_RND	4
> >  
> >  struct neigh_hash_table {
> > -	struct neighbour __rcu	**hash_buckets;
> > +	struct hlist_head	*hash_buckets;
> >  	unsigned int		hash_shift;
> >  	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
> >  	struct rcu_head		rcu;
> > @@ -304,9 +304,9 @@ static inline struct neighbour *___neigh_lookup_noref(
> >  	u32 hash_val;
> >  
> >  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> > -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> > +	for (n = (struct neighbour *)rcu_dereference(hlist_first_rcu(&nht->hash_buckets[hash_val]));
> 
> This for loop and hlist_first_rcu(&nht->hash_buckets[hash_val])
> can also be written with a macro and an inline function.

Good point, I'll convert all of these to use `neigh_{first,next}_rcu{,protected}`.

> 
> >  	     n != NULL;
> > -	     n = rcu_dereference(n->next)) {
> > +	     n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list))) {
> 
> This part is also reused multiple times so should be an inline function.
> 
> I have similar patches for struct in_ifaddr.ifa_next (not upstreamed yet),
> and this will be a good example for you.
> https://github.com/q2ven/linux/commit/a51fdf7ccc14bf6edba58bacf7faaeebe811d41b
> 
> 
> >  		if (n->dev == dev && key_eq(n, pkey))
> >  			return n;
> >  	}
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 77b819cd995b..86b174baae27 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/string.h>
> >  #include <linux/log2.h>
> >  #include <linux/inetdevice.h>
> > +#include <linux/rculist.h>
> >  #include <net/addrconf.h>
> >  
> >  #include <trace/events/neigh.h>
> > @@ -205,18 +206,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
> >  	}
> >  }
> >  
> > -static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
> > -		      struct neigh_table *tbl)
> > +static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
> >  {
> >  	bool retval = false;
> >  
> >  	write_lock(&n->lock);
> >  	if (refcount_read(&n->refcnt) == 1) {
> > -		struct neighbour *neigh;
> > -
> > -		neigh = rcu_dereference_protected(n->next,
> > -						  lockdep_is_held(&tbl->lock));
> > -		rcu_assign_pointer(*np, neigh);
> > +		hlist_del_rcu(&n->list);
> >  		neigh_mark_dead(n);
> >  		retval = true;
> >  	}
> > @@ -228,25 +224,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
> >  
> >  bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
> >  {
> > -	struct neigh_hash_table *nht;
> > -	void *pkey = ndel->primary_key;
> > -	u32 hash_val;
> > -	struct neighbour *n;
> > -	struct neighbour __rcu **np;
> > -
> > -	nht = rcu_dereference_protected(tbl->nht,
> > -					lockdep_is_held(&tbl->lock));
> > -	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
> > -	hash_val = hash_val >> (32 - nht->hash_shift);
> > -
> > -	np = &nht->hash_buckets[hash_val];
> > -	while ((n = rcu_dereference_protected(*np,
> > -					      lockdep_is_held(&tbl->lock)))) {
> > -		if (n == ndel)
> > -			return neigh_del(n, np, tbl);
> > -		np = &n->next;
> > -	}
> > -	return false;
> > +	return neigh_del(ndel, tbl);
> >  }
> >  
> >  static int neigh_forced_gc(struct neigh_table *tbl)
> > @@ -388,21 +366,20 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
> >  
> >  	for (i = 0; i < (1 << nht->hash_shift); i++) {
> >  		struct neighbour *n;
> > -		struct neighbour __rcu **np = &nht->hash_buckets[i];
> > +		struct neighbour __rcu **np =
> > +			(struct neighbour __rcu **)&nht->hash_buckets[i].first;
> 
> This will be no longer needed for doubly linked list,

This is not as-necessary with a doubly-linked list, but unfortunately
I cannot eliminate it completely, as the `n` might be released in the loop
body.

I can convert this function to use a `struct neighour *next` instead,
if it is more palatable.

> 
> >  
> >  		while ((n = rcu_dereference_protected(*np,
> >  					lockdep_is_held(&tbl->lock))) != NULL) {
> 
> and this while can be converted to the for-loop macro.

As far as I understand, this cannot be converted into the for-loop macro,
as the cursor can be released during the loop-body, resulting in use-after-free
when trying to increment it.

> 
> >  			if (dev && n->dev != dev) {
> > -				np = &n->next;
> > +				np = (struct neighbour __rcu **)&n->list.next;
> >  				continue;
> >  			}
> >  			if (skip_perm && n->nud_state & NUD_PERMANENT) {
> > -				np = &n->next;
> > +				np = (struct neighbour __rcu **)&n->list.next;
> >  				continue;
> >  			}
> > -			rcu_assign_pointer(*np,
> > -				   rcu_dereference_protected(n->next,
> > -						lockdep_is_held(&tbl->lock)));
> > +			hlist_del_rcu(&n->list);
> >  			write_lock(&n->lock);
> >  			neigh_del_timer(n);
> >  			neigh_mark_dead(n);

== SNIP ==

> 
> > +			hlist_del_rcu(&n->list);
> > +			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
> >  		}
> >  	}
> >  
> > @@ -693,11 +666,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
> >  		goto out_tbl_unlock;
> >  	}
> >  
> > -	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
> > -					    lockdep_is_held(&tbl->lock));
> > -	     n1 != NULL;
> > -	     n1 = rcu_dereference_protected(n1->next,
> > -			lockdep_is_held(&tbl->lock))) {
> > +	hlist_for_each_entry_rcu(n1,
> > +				 &nht->hash_buckets[hash_val],
> > +				 list,
> > +				 lockdep_is_held(&tbl->lock)) {
> 
> Let's define hlist_for_each_entry_rcu() as neigh-specific macro.

Can you elaborate on this?
Do you want the `list` parameter to be eliminated?

> 
> >  		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
> >  			if (want_ref)
> >  				neigh_hold(n1);
> > @@ -713,10 +685,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
> >  		list_add_tail(&n->managed_list, &n->tbl->managed_list);
> >  	if (want_ref)
> >  		neigh_hold(n);
> > -	rcu_assign_pointer(n->next,
> > -			   rcu_dereference_protected(nht->hash_buckets[hash_val],
> > -						     lockdep_is_held(&tbl->lock)));
> > -	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
> > +	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
> >  	write_unlock_bh(&tbl->lock);
> >  	neigh_dbg(2, "neigh %p is created\n", n);
> >  	rc = n;
> > @@ -976,7 +945,7 @@ static void neigh_periodic_work(struct work_struct *work)
> >  		goto out;
> >  
> >  	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
> > -		np = &nht->hash_buckets[i];
> > +		np = (struct neighbour __rcu **)&nht->hash_buckets[i].first;
> 
> No np here too,

Same as the other loop in `neigh_flush_dev`, we must keep `np` in order to avoid
UAF, because `n` might be freed in the loop body.


