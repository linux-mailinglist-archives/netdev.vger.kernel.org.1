Return-Path: <netdev+bounces-46823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD37E692A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E637F280FE6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0E19456;
	Thu,  9 Nov 2023 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="Pi8dpa1u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220F19445
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:07:01 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2131.outbound.protection.outlook.com [40.107.249.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCC271F
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itt7fYhqOuyghwUb1SETy4yyDUdjeOn3kM3LL9Idi2l/vCN5rKK5LNt8fcnA9vfWCt859+my6WtaU3cb7nhLIKyn57wwcbSNxjoI+bJDEmgmwd3ItOWI3aFWTFYOHWGcEnOD49lDieeMv9tAfoNvT8wHhGq/OCF6LMCzDq/6Agv54n5MQeye22CVnmtTkQsWinssyOzdpZ4odj1ZyChuN3seah3Y3nWnx5VUQ6AY/PDQiFO3zAnWNnpfzC5qLQrC7X9inZRilcfaVxwN0jaI44No5s1aWyw3lqML9HmucP4nZIIrwrWSfsM6ieZ2RrnxgKsm9qIpPsB0tJZjQSOLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaoJN6gZBBwTGjILENQ26ngGRIiznMdMj7xvskTuD2g=;
 b=oPi1GowhIJkad0ZntCcvdO0DSZmquR2FLN0Fz21h2u7CFSKoUDGMI3rI5HWgXkhAqX04rKqCvFJkexiLolB7Dcnz1xh0yLx0teTXqRddzq2xmzIYB3/zQcQMUUiNBSHegVTDTDuVaQ2Q/eVVLf7P34JlzVMt5AO1nNDlKb5MGPbnA9IkRdigN1TzC5Htx3pVfqXonHUsiCseSErQmXud6jtrBE+ln6H07UwWWcnqLQ4KU5DZpNBQolGPeC2HnvgA9YJO777hwq++0qcaDyi5LT5l8nuk6TFCpSMXW0vinpyE2XgstFmFVZX6PzCzbjYjAnYjTVYAK/8P7++hAkeYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaoJN6gZBBwTGjILENQ26ngGRIiznMdMj7xvskTuD2g=;
 b=Pi8dpa1ueqzfTg0Nwfx7wKEDmvAQyv/gVjSJxzierGIOw6ytbkB7i89yd5qywNE/TLT3RuXVDy0PdnMGpLgagP4Pwh18cWG02qwueFTToD/6lWkERckzSNyQfgZ+UNUDFQ9BTss3WaJZsn2pFGHJH62Y11rBFqR+fVhaiVAqRi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13) by PA6PR05MB11145.eurprd05.prod.outlook.com
 (2603:10a6:102:3c9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 11:06:58 +0000
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925]) by AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 11:06:58 +0000
Date: Thu, 9 Nov 2023 12:06:51 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, "brouer@redhat.com" <brouer@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "mcroce@microsoft.com" <mcroce@microsoft.com>, 
	"leon@kernel.org" <leon@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v4] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <4fxnidhi7gfpzmeels363loksphtifgsan6w64n5y7dxzi7dyx@jwbe4gp37mwy>
References: <4wba22pa6sxknqfxve42xevswz4wfu637p5gyyeq546tmzudzu@4z3kphfrpm64>
 <ZUyOsB7p6j21e42c@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyOsB7p6j21e42c@lore-desk>
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB10778:EE_|PA6PR05MB11145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5255489a-53ce-4816-4311-08dbe113fda1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OY9z5bX3PfGmmdmHphJpOSVXN7YMEetTan5JujGK06PTJ4PtFoCf1imZzdrE0eqJSRTn2EuQ5JhteXGrJngeMpO50cSYivIBksMy5xHhUT4YFxx2Y/XAoWMjDm7P2xJlix+eAEt9Ie8DgkeNkJlEc2b+qKfMVHsTw3DzNbd0Wy4lzBt6ua65vPymESrT8A4MpK6WuqFMgU05a3f03U2GmruFz55GS7d4yUGO2yyqff2/Hr1uC4yDFpNzgHTAGlUkilm1LYR1YBdSCKY/eIcGMCHiqw7Rm1W4eWz5HO+0jANFwjUeP0dUeRNPBZ+zz6M3TiXTjTRw0Qr7kxLtly+7EsZNYSvthiyk/hCxkee8I57LXsBkVHAGxat+Re1bh6pdK3FRdaKqkUfuM0b3xuhgF28RdggzvdVi//N55kzDzsYzU424W7EKwde4Fg33AukG62hrDP3uYv8ofMEO7ztTJwNhXU8nb8Uor2NsODKGeyoCjMUwaD6ePjLqkAxaWhTQFs02uDugUMnGJCgkTxwVJwLWtwkugdM7mbH2I7i1n1HT/lAhO00OtHKUMNgfRSzO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB10778.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(39830400003)(346002)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(4326008)(8676002)(41300700001)(83380400001)(86362001)(316002)(44832011)(6512007)(9686003)(8936002)(5660300002)(66899024)(66946007)(66556008)(66476007)(6916009)(6506007)(54906003)(33716001)(6666004)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgLBB8MnVCcUuIzmQwC+d/B8MhG/44JYvtqvf+Kt5CuuUc7+cDqMR5nO14s6?=
 =?us-ascii?Q?KQX0xNKEyqG1C2LZgBaRJ5CreQfD7giOCLXkez7nd7+KIPDo5sY1EgDN3S2k?=
 =?us-ascii?Q?i2ljpk3GBPkz6j7TJt0PRH2kQ3H1koqEhCQ1UzV8KKs0WammRzooXEhZAl+D?=
 =?us-ascii?Q?CoNM+cecFO3bXS0kwkd2p4Ycl5KNDrBjJcAZ08RNpjbhdf6yFtF7UrQjBvup?=
 =?us-ascii?Q?hzNOPz4au4FH4LnHaGmW7oTBNPrp+O8ssnR0Kj94SdkolT2gVKaYdtKxckI5?=
 =?us-ascii?Q?o9YqwUER4O14++NO+eukzp00uByNHEiUUw6+GcGxiVQ1dkEuHrCV6T0owa3z?=
 =?us-ascii?Q?aCvdIZPA+KyD0LnefOpJkxUHmuCif+ZC9MwG9QTvpdDAKKvfcLjVkOEHnDwd?=
 =?us-ascii?Q?kpJF7N8DjjJ6Or6cqYW5PccYOah7yBJwaf5azDH+wl4BYpi/ffIzbXqA+0pZ?=
 =?us-ascii?Q?0TJXme6gIQ6PSca3e9kT/84x6GosBVyGLuZoBJzAlXEPcoMkm9PDw4fyVVYW?=
 =?us-ascii?Q?52y6Y+PayXrhtKv9lgxFpV5brjo/qBuhCMCP5iVJhqK4jKInzFKScpd82UdC?=
 =?us-ascii?Q?+WDgLg3aB2OJaHOMYBQNZwCNLySUPOoAMgeqP+Vl9gYaE60o+7LSts0NpH0c?=
 =?us-ascii?Q?qodYi4x+bZsm//Tb/bHEheTMlOdk8KQZY/eynQYu/vN/z5k79uPUBOYWR9hn?=
 =?us-ascii?Q?WmnetKj1focbf2Kg9qpDVObJ7037tqgy1RzNbAX7VKLogoMKg7RxujlZ6Pes?=
 =?us-ascii?Q?qnLAhY1akeqjDGZs1IeM48LxKZdnYeyudEreqpRYgWQBPP699fWnU/6z21VO?=
 =?us-ascii?Q?oCCfpJohYICXGl4jKIED2bXpgGInugOkXvhBzWxg76AesKuaIqQzdZAj1hnY?=
 =?us-ascii?Q?aFtz6vhsu4Ee2sax+0eRLoikIQ8zk+MDj3bGA2fb2jcrjQsFWwiWM+RHMdiR?=
 =?us-ascii?Q?osf3oG+18enLiRCNJwPvxUJdn7EJQ/5utp6Y75NDa7iLNhjeZPmyBa9lFscG?=
 =?us-ascii?Q?6P742XvCGy4ET9cg8v3DLLl7dNrLF90SRhAkARU7d7d8TV1RTqm19dHIlknA?=
 =?us-ascii?Q?VvUdvI/w3XQKd7NfufgkMXEuT8J5NI6Zyn3gOzVsjz0wexNgH/l5tSRdSUgJ?=
 =?us-ascii?Q?R/34Z9QdyTDOjrflpsqxj8Qo+y794o5ml0CNYuScaKpeOOLH4W44pS3YXw0u?=
 =?us-ascii?Q?aAOzXyF/I84zQW6JEaL3sNS2ypOc1PJo/MIPKe0FJ9skL+cQbdee4/j58LNr?=
 =?us-ascii?Q?rGJCfc4/QdHC+5he7/cQFU//76mXyFSdXS6mSOxnFYgVvsJQu/IDSdOhjfVt?=
 =?us-ascii?Q?F9dsiL7nnDH1K1YMFK+axCPWJrTKNrjpjhrXH99mMkz2ALBsOLzHoYXhCAE8?=
 =?us-ascii?Q?bYG51dhWY8Qb7t5ZMSCxPX9mE8gEXEJYQLsNy8ui1jiRa3wLLvLOtKI0uIcF?=
 =?us-ascii?Q?PQJ/XUTDL5m2O/13T5xEhFykKA82Su8UtcbM8tndF+HQXq1PMHWwVJZtgdQe?=
 =?us-ascii?Q?fmK5Iix7WDOQ7Toz/g4utOeKSrjSYG02BO8g6pYHi2CCrdEO7ietuWxJ6gvH?=
 =?us-ascii?Q?EedTJOSchRH629zvq8MbQK0wbcLYKD9SadfhdkhL/jrFE1H0IlBCP/f4/Gz0?=
 =?us-ascii?Q?LyHsQ8tMr6rrShf//hi4T4ENCSXUH+fFCkW0+LxckD4ovjXln+LKJ+YfTQyH?=
 =?us-ascii?Q?/iZhNg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255489a-53ce-4816-4311-08dbe113fda1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB10778.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:06:58.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjxcJtb3tXCESd18sTcvUuoJLAwIPuJuKiGd1eJdbZjq4C53l4fOvZO5MVF54aDeBm6sDjnAv59HXBqz+k7OOGArsBIwSeYlN3Q0m9pOcvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR05MB11145

On Thu, Nov 09, 2023 at 08:48:00AM +0100, Lorenzo Bianconi wrote:
> > Calling page_pool_get_stats in the mvneta driver without checks
> > leads to kernel crashes.
> > First the page pool is only available if the bm is not used.
> > The page pool is also not allocated when the port is stopped.
> > It can also be not allocated in case of errors.
> > 
> > The current implementation leads to the following crash calling
> > ethstats on a port that is down or when calling it at the wrong moment:
> > 
> > ble to handle kernel NULL pointer dereference at virtual address 00000070
> > [00000070] *pgd=00000000
> > Internal error: Oops: 5 [#1] SMP ARM
> > Hardware name: Marvell Armada 380/385 (Device Tree)
> > PC is at page_pool_get_stats+0x18/0x1cc
> > LR is at mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
> > pc : [<c0b413cc>]    lr : [<bf0a98d8>]    psr: a0000013
> > sp : f1439d48  ip : f1439dc0  fp : 0000001d
> > r10: 00000100  r9 : c4816b80  r8 : f0d75150
> > r7 : bf0b400c  r6 : c238f000  r5 : 00000000  r4 : f1439d68
> > r3 : c2091040  r2 : ffffffd8  r1 : f1439d68  r0 : 00000000
> > Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 066b004a  DAC: 00000051
> > Register r0 information: NULL pointer
> > Register r1 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> > Register r2 information: non-paged memory
> > Register r3 information: slab kmalloc-2k start c2091000 pointer offset 64 size 2048
> > Register r4 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> > Register r5 information: NULL pointer
> > Register r6 information: slab kmalloc-cg-4k start c238f000 pointer offset 0 size 4096
> > Register r7 information: 15-page vmalloc region starting at 0xbf0a8000 allocated at load_module+0xa30/0x219c
> > Register r8 information: 1-page vmalloc region starting at 0xf0d75000 allocated at ethtool_get_stats+0x138/0x208
> > Register r9 information: slab task_struct start c4816b80 pointer offset 0
> > Register r10 information: non-paged memory
> > Register r11 information: non-paged memory
> > Register r12 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> > Process snmpd (pid: 733, stack limit = 0x38de3a88)
> > Stack: (0xf1439d48 to 0xf143a000)
> > 9d40:                   000000c0 00000001 c238f000 bf0b400c f0d75150 c4816b80
> > 9d60: 00000100 bf0a98d8 00000000 00000000 00000000 00000000 00000000 00000000
> > 9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9dc0: 00000dc0 5335509c 00000035 c238f000 bf0b2214 01067f50 f0d75000 c0b9b9c8
> > 9de0: 0000001d 00000035 c2212094 5335509c c4816b80 c238f000 c5ad6e00 01067f50
> > 9e00: c1b0be80 c4816b80 00014813 c0b9d7f0 00000000 00000000 0000001d 0000001d
> > 9e20: 00000000 00001200 00000000 00000000 c216ed90 c73943b8 00000000 00000000
> > 9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9e60: 00000000 c0ad9034 00000000 00000000 00000000 00000000 00000000 00000000
> > 9e80: 00000000 00000000 00000000 5335509c c1b0be80 f1439ee4 00008946 c1b0be80
> > 9ea0: 01067f50 f1439ee3 00000000 00000046 b6d77ae0 c0b383f0 00008946 becc83e8
> > 9ec0: c1b0be80 00000051 0000000b c68ca480 c7172d00 c0ad8ff0 f1439ee3 cf600e40
> > 9ee0: 01600e40 32687465 00000000 00000000 00000000 01067f50 00000000 00000000
> > 9f00: 00000000 5335509c 00008946 00008946 00000000 c68ca480 becc83e8 c05e2de0
> > 9f20: f1439fb0 c03002f0 00000006 5ac3c35a c4816b80 00000006 b6d77ae0 c030caf0
> > 9f40: c4817350 00000014 f1439e1c 0000000c 00000000 00000051 01000000 00000014
> > 9f60: 00003fec f1439edc 00000001 c0372abc b6d77ae0 c0372abc cf600e40 5335509c
> > 9f80: c21e6800 01015c9c 0000000b 00008946 00000036 c03002f0 c4816b80 00000036
> > 9fa0: b6d77ae0 c03000c0 01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
> > 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
> > 9fe0: b6dbf738 becc838c b6d186d7 b6baa858 40000030 0000000b 00000000 00000000
> >  page_pool_get_stats from mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
> >  mvneta_ethtool_get_stats [mvneta] from ethtool_get_stats+0x154/0x208
> >  ethtool_get_stats from dev_ethtool+0xf48/0x2480
> >  dev_ethtool from dev_ioctl+0x538/0x63c
> >  dev_ioctl from sock_ioctl+0x49c/0x53c
> >  sock_ioctl from sys_ioctl+0x134/0xbd8
> >  sys_ioctl from ret_fast_syscall+0x0/0x1c
> > Exception stack(0xf1439fa8 to 0xf1439ff0)
> > 9fa0:                   01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
> > 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
> > 9fe0: b6dbf738 becc838c b6d186d7 b6baa858
> > Code: e28dd004 e1a05000 e2514000 0a00006a (e5902070)
> > 
> > This commit adds the proper checks before calling page_pool_get_stats.
> > 
> > Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
> > ---
> 
> Hi Sven,
> 
> first of all thx for fixing it. Just minor comments inline.
> 
> Regards,
> Lorenzo
> 
> > 
> > Change from v3:
> > 	* Move the page pool check back to mvneta
> > 
> > Change from v2:
> > 	* Fix the fixes tag
> > 
> > Change from v1:
> > 	* Add cover letter
> > 	* Move the page pool check in mvneta to the ethtool stats
> > 	  function
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index 8b0f12a0e0f2..bbb5d972657a 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
> >  {
> >  	if (sset == ETH_SS_STATS) {
> >  		int i;
> > +		struct mvneta_port *pp = netdev_priv(netdev);
> 
> nit: reverse christmas tree here (just if you need to repost)
> 
> >  
> >  		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
> >  			memcpy(data + i * ETH_GSTRING_LEN,
> >  			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
> >  
> > -		data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> > -		page_pool_ethtool_stats_get_strings(data);
> > +		if (!pp->bm_priv) {
> > +			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> > +			page_pool_ethtool_stats_get_strings(data);
> > +		}
> >  	}
> >  }
> >  
> > @@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_port *pp, u64 *data)
> >  	struct page_pool_stats stats = {};
> >  	int i;
> >  
> > -	for (i = 0; i < rxq_number; i++)
> > -		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> > +	for (i = 0; i < rxq_number; i++) {
> > +		if (pp->rxqs[i].page_pool)
> > +			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> > +	}
> >  
> >  	page_pool_ethtool_stats_get(data, &stats);
> >  }
> > @@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
> >  	for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
> >  		*data++ = pp->ethtool_stats[i];
> >  
> > -	mvneta_ethtool_pp_stats(pp, data);
> > +	if (!pp->bm_priv && !pp->is_stopped)
> 
> do we need to check pp->is_stopped here? (we already check if page_pool
> pointer is NULL in mvneta_ethtool_pp_stats).
> Moreover in mvneta_ethtool_get_sset_count() and in mvneta_ethtool_get_strings()
> we just check pp->bm_priv pointer. Are the stats disaligned in this case?

Hi Lorenzo,

so the buffer manager (bm) does not support the page pool.
If this mode is used we can skip any page pool references.

The question is do we end up with a race condition when we skip the is_stopped check
as the variable is set to true just before the page pools are
deallocated on suspend or interface stop calls.

Best
Sven

> 
> > +		mvneta_ethtool_pp_stats(pp, data);
> >  }
> >  
> >  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
> >  {
> > -	if (sset == ETH_SS_STATS)
> > -		return ARRAY_SIZE(mvneta_statistics) +
> > -		       page_pool_ethtool_stats_get_count();
> > +	if (sset == ETH_SS_STATS) {
> > +		int count = ARRAY_SIZE(mvneta_statistics);
> > +		struct mvneta_port *pp = netdev_priv(dev);
> > +
> > +		if (!pp->bm_priv)
> > +			count += page_pool_ethtool_stats_get_count();
> > +
> > +		return count;
> > +	}
> >  
> >  	return -EOPNOTSUPP;
> >  }
> > -- 
> > 2.42.0
> > 



