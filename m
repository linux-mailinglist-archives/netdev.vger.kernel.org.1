Return-Path: <netdev+bounces-60408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3FC81F19B
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7183FB21251
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33946B94;
	Wed, 27 Dec 2023 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nm5jDmgd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029C47F46
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAT+rISoSlkv6EATXg8Zcq5I6vsEC1Xtw+8/xdP1cS7kVT76jA3JmFRXzr6fJHhsCqrQlyMxeciyXlAQlgIq+TzfILEaSnf/dgDdOSX5x0Xi0sid1TpTkaVB0Pfr3QYX0tGZ92cU5ZXz75HUOEIYGePT64au1yUnn7IcGwA0utLn72UPDdUmBGvjqw2hofVuPazJ1lKQVM1YMBD5RyKvpqwCphMqgJHQKfx18qz4Oc4IK4VASg313AhcXAqs4BoK9T6OSyMYaV9VLf+oZ1Oh+2gvGgZhcEYixzv3bnYktD7M8iE+mgLevmFo4R3rj5P8J3gLwvjTVwDFf66CXcSx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riLh8SvR4YeE7ueHS2r/2YkyTvt9MudbE/PT8uWTm6E=;
 b=nH0QXEpG8fWQnn/MYhK+poPVejIibcAz8pEsVeyxsdyq/3BJcZ5eC3pZioDOHIEbwuMYfNCV3aMPw4EtDH90ph8EJUDq181PJNEzGyEwiFxYSTK6ybKDBh9Cyu1+h82tFj8x812RxSzo7bIGfOAt5hhXmA64jdRaRonLo8/AplzM6JJutZ+nrGil0/p3lacHkv8jZB09QClR6CM+fInYsR9vlnpvz7DUR/aIhdTyn51aNHzBp9VfKmnrNF0Mcvgj4vJSKoo24V5p1FTNhcZVDDWFjhHB07OnVlC/cjMrgIB9rcZ5y92XeVdyn5SoPeIFB1m2EGy2xvuwdWhBOsAO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riLh8SvR4YeE7ueHS2r/2YkyTvt9MudbE/PT8uWTm6E=;
 b=nm5jDmgdPzSg5AgJbOBbBASKJrK9XkvuZsXdgOrww4XJtU+XP3l6c8ZTsMyJpmVT8fFucO5PVvenZNowVP0S2X4FWgEDLLBKDHP7pCHNVLCFw6kY8+mukQrGKBRJzER773+7+2Z/czVpHZRwIyLACLVf9w/mrOoBFtNKvNDYMe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 19:24:23 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 19:24:22 +0000
Date: Wed, 27 Dec 2023 21:24:18 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 02/10] selftests: forwarding: Remove
 executable bits from lib.sh
Message-ID: <20231227192418.2ckjzjz5ijxf6jxo@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-3-bpoirier@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222135836.992841-3-bpoirier@nvidia.com>
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fa3ff0-90c3-437f-34f3-08dc07116df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T7VnPxl+u8ETt9cwRdqGf6fRBJw4Uk2IG+03hlzAGQirZ6+sgv8MpT8YhSVSVka43PDXY4M4koXo1kv/Xws6FiWdVJ8KAIlinoPN/8yo0Vg8wD59xwA4MTkMvpCDHonGcPlypXqrke5NW/vvnBtwfI/S3NBoMEJVv26TRSg5fo4UXF9O9JJJsXFRbMyxYIqEwppSBkgadPNyjy3MH5eUhKOp/KDRsqE2BRYon3h2Bq/EvY/Ugj4Ck+XcY9yMMIs6zBeg4rBwRpa9mpOzLs221FRkxwVhVDEl5bHelBuEnmNfgUp/JRmBOSn28i0Drj6O4pmviTRHtbVYto34SXX2EJmFpGiNmTgf0ONNivVWSr6OK5lqlTOeQZrX6EiUO5CJpijKwX3i8Z1PtjJeqkUrYhCNGkPPHoAodMuZEWMFKOChFbKPI5JKIXSW/HXtDy+Yc2wURauAqmhdBKMB+UVBPG9Ju4ZNZyqbZAKIWVgQdA1coB3+x5kz0iLmKRzSAV4/Ji1DJvsKLDoepRsmOg6zeMq1wtYNVeaK7uCALIeT8h9V+IpUuHkZO1edWBrmm16y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6916009)(6666004)(6512007)(6506007)(66946007)(66556008)(66476007)(6486002)(86362001)(9686003)(316002)(38100700002)(33716001)(26005)(1076003)(41300700001)(8936002)(2906002)(5660300002)(4744005)(478600001)(44832011)(4326008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fag8wQ1fm5fKCbRY55/pKk56UBHPUMpl1O2lKAGgff5biCf+Fkgkin5KWndL?=
 =?us-ascii?Q?JahBsKc2PdSLTD4QlxKdEQOzjMPt+u2Lqyr/6E8MGmPfPeDhcHWO18reYgua?=
 =?us-ascii?Q?xnN6fvOHMMboszBYFABo7ar1Nx0Lrefy67wJDfoayve5Y/BLOKdV9qb4xeku?=
 =?us-ascii?Q?aZ4IXofz57/5KbHF5aNCKtbTBN0V/ihGqBDq81sQGeX1WttONR+Ap4feyYcN?=
 =?us-ascii?Q?Dm3RSNVqVCYAQT08ElijMbEs2eRkFIZqqQSRoWfszhk4iTmAm1FR0srMu+X6?=
 =?us-ascii?Q?udONvGPnCUIFLGzlVvTRldCMn+jqyGM28C9EeCj/s9ihe7AjGW4FjmDB/HWh?=
 =?us-ascii?Q?D8Jhf62qPWW7FoEF8aP/9cxPMRoxQIFV+hgbAhClBQ3NF6D3fHBzP9mlf6+f?=
 =?us-ascii?Q?7Cs5QfdfLCzd5sGYxuWb0aNiyfxIAWV4LBGVjRr+oVFf1BW9cS1mWoZ4IbUM?=
 =?us-ascii?Q?6kxZh2WZ/4ekN3AV0Nvc1VfCMOED9R4Xl3krjXw6J3xwbgUVyNhx291shxVp?=
 =?us-ascii?Q?DwbtexcUpz0PO5rG0pJfxjETdfKIQRAu/odWs6aRBkaTx4fb4s68m3Ftei20?=
 =?us-ascii?Q?vND7zQYUILdJ4anD02OSKfJ36gdA+2Y6iyFaG0BEoAm43G5y91IdcFPyDklo?=
 =?us-ascii?Q?ldoki2s2nk7Ye+dTY65ZjPdwft7YcArv4Ot2Ii37Fcnk/AF6VGy/ByjjLMMo?=
 =?us-ascii?Q?f6UXcL9am0ziRr2nStbgbruTTRLbdugVpy9vYD3G+JduNWkoYKY1ufmijd7S?=
 =?us-ascii?Q?xSY0iQa6BJnZeebjD54DO5d4Pg9MIn1VWRAvRfVK++6gIGU96EGYpVbioK38?=
 =?us-ascii?Q?7rV4v4+7KESFa4Xtv/Va0FkybjOJ7tgpn8KomnqwYKTNB1CbEKFZlWAn974z?=
 =?us-ascii?Q?MSvDw0rGkESjzzc/5z1sgO3Nun0noZ61gwUrOLdWshr0WRn7Zu7GMLgzgYMM?=
 =?us-ascii?Q?Cul6MsHT3GUoYjeS7IXR9IUGyF7oKhNeTErXPJCaIlyYFJKkXpzKA8Opfpjy?=
 =?us-ascii?Q?BOH6pRZ6erIzkoc56NNjPpUUSbwa9TcAHfdxu9Pog7T29hkyFfZwhyKowC92?=
 =?us-ascii?Q?ecQOrMnnL3ZG2PN7jzEhj/HcJ8byasTPu/4Mtlfq1sbfXSqumLCh9bE3zfra?=
 =?us-ascii?Q?nmCpzMbRGG8nysoSvZiQB2w0wnkq02JyXADsGY8C8iqH5i8lSCpXsIFlbHSe?=
 =?us-ascii?Q?Gter0P/5u2FQuE9XMBeFA89/4DFWJvXRqjM6XlGVj36pSyDfV1IgpmdFDUuN?=
 =?us-ascii?Q?U/JEG6sq9p6NzFgGx6uFPLC61Bkl+BSsjWsC9ZRb2F2aDllVKCgaAmSHT517?=
 =?us-ascii?Q?9/t4LxTDzmqx9ESDw6zSORuDVXz02/rz9qT5RTPk/DjqUONmN/DKOrk2FIoC?=
 =?us-ascii?Q?bARSy7VFhqoMOx+5xVvsTwAC2cWcdWVCnMATCMnjuC7IF0LMWaq5CCbxEZwu?=
 =?us-ascii?Q?obOfrng1k25bXUPDWpHg290Hy1NLblAf8/qSilx6O97AKpZdgn6+To9A31b8?=
 =?us-ascii?Q?g/8oY4lAERYb3t2eTbvgDTA1nODLQQ3dmRmNC7TWK9LsXelyBb6dgZk5mMAQ?=
 =?us-ascii?Q?4abwaz5zeoSJxQnifnRWnqRBbbtilTCJdpkol0PIIZWGhM1qNCLmXRSD5Hsy?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa3ff0-90c3-437f-34f3-08dc07116df1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:24:22.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyriRAOxS7OCMqq+4/PE+AFEIAVXiYmyhjAknKVUnoyfKSWakyd5+VUUUIXRqYyJsKvt1BLPGP/eMUTuzXOxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

On Fri, Dec 22, 2023 at 08:58:28AM -0500, Benjamin Poirier wrote:
> The lib.sh script is meant to be sourced from other scripts, not executed
> directly. Therefore, remove the executable bits from lib.sh's permissions.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

