Return-Path: <netdev+bounces-53464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2B803154
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8074280E2C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB722EE5;
	Mon,  4 Dec 2023 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKzxgZqZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D5D5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 03:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Acdilke53NTFq27UOme3yq8kHagLSfgy0zIDkqS9bGriJ5eAyAw0wY1HoGc62uYaaRCQ7+098jLKC3peu2RP4gVrCpbqAO2UizrVufSN+NeE+rgX0X3J0Nv6VWfy92YoOgH/ipeYknP2hm3Kva6EyOMGwR89asKgCmyHG5YtjoQkQDlUnO23S8LEE5xQGC7bdydN+jQHd764pDe+6fj+48cDzaGpzVZ8ICjc6SgeKS7vUr09GfiZv+YWTHBeKop9TRgTQ5sf6T3SL84bmnG85laYFXWLaDdTNKtF0Wi3QIUGNaxP8dEmBAd0FCZ9LQicmRInE+2wJ0j7+gGWVb6t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFk2Ebx+H5q4Wp/urupPueeF48s63z2pnUW4PQEc/SQ=;
 b=IM9fyvP1T9/073CYGlyXgoFN4DSYLhsIh/1DLiYC+qx5Z5urSpB6DjjhM7qLHz/KL0A1Aglv5t5B2WtmGvdlnv0dcyfcvG8Kzmd3NO3KRcz/Jp9zyne2NDCZDmsbaHFC6cNzUtHHCnSYRkppi62GuQv4QsuS1nW2F3l4UdYGPX1Tad+hP6DAu8OJ4NCvA/JE5j4cEOVO4vBKOuiD2z+wNqyh4WmxM7y7Ui5TiYMU2hbzzcHSiu4tu3DxLjQnQuiuNL6XwdMwh+/f1jnURz4wjHNTWvHORiRSQ67yeJrcCyLIc2ljMOCSBQ5fff5EsiGxBNS03QAHjp/r1VGx0mVmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFk2Ebx+H5q4Wp/urupPueeF48s63z2pnUW4PQEc/SQ=;
 b=TKzxgZqZNdH3MMzcnE5PsDkHF1BXoAT3Ru80q3TchpcW2SBip2Z3L/10HW0T3Y0RQk2GpUGP0IFDgJs2JhvaAp4YEd0ufDv+cbjzIKnZD9ukqru+IojhP0B09+w0cQmSHv2+lbXgOnH6L7gXkgWnU+1h27VSjlO9aJBwprzYy6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 11:14:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 11:14:00 +0000
Date: Mon, 4 Dec 2023 13:13:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 8/8] selftests: forwarding: ethtool_mm:
 support devices with higher rx-min-frag-size
Message-ID: <20231204111357.kg4z3tud6nvwn2ly@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-9-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201135802.28139-9-rogerq@kernel.org>
X-ClientProxiedBy: BE1P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bbbc66-f940-4d2b-d6f2-08dbf4ba1da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfhEYBkjGcP7wtYi7DI/hELDJ4gfft8h6aomQkM2DwR5Gwd3PCvsW88iSKMzxUWiDrKUaqTmvetxagD1rTL2mp29sjes7o3hn5thvqLxpUfSrb1RgdpPThYQ8D8VQKjrYohcYIwGKpr5JR4CZeQ9WA8zlERCWTpdMrFYFpXD7yeGHOF0KjmyDejAWJizQOuyv07MYkNCkUvqcdgwSnC3mRciNc1ptjvFjF8jXz0oCjI+gO4PCAscVf0RZw13McpzkNTsgqK0b5ezueaqEdMsawLw61E/Bh5ADOocQdRC1OjKuMxXy1NzXhL8YjeEA/l2/yoREDQc57mr5HsgzKm2IeYvcXoIo+eEd7+M0Dp7X/iial3wm7dmB1TR66PyaRJ1F77ipJE1A0PlQAb+0cgEHlh+qRXn2TizlctTt2dkEGqU0fGVNFVb6GClKncCQUmd/mIRxWebqLcNtja3ancb7qwXo/MXflUvnV5fPOErawJyA7ESIMq5+f9hV9aXrzFelR2wiYfEhzgoSy3vg4DdlRfk++r/Xqq/gAHQDvXTmWnFud1WV0TbbX7rVcTPMJoX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6916009)(66476007)(66556008)(44832011)(66946007)(316002)(4326008)(8936002)(8676002)(86362001)(33716001)(9686003)(6512007)(6506007)(478600001)(6486002)(6666004)(2906002)(1076003)(26005)(83380400001)(38100700002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Am1OpORmkuFRw5bUbXkEhAv3vU/ZDouCI6B9xmmXtpN84GCmJmg4EJ2Tpunp?=
 =?us-ascii?Q?UQ1/BRD0Jrpx4K8F5VNNqgV8NV+ObmS2iF/9Cs3iNLuTsxZ+IJEmViugtwMJ?=
 =?us-ascii?Q?rY03E81XZLwqru2JWUByoGCax97I4nw+REcKS4CAMnZQO6kSP+8FSuSNfIWT?=
 =?us-ascii?Q?U+uumLlPzrXbZLWQIUhfQqil4xSfTTWsoQVxaiWCWNMojvShT9lKb5RPPqkx?=
 =?us-ascii?Q?Kh9cDAsCRzPuCeFU5RSghF3s9bjrAQk1Eh3/Tjp/mLcIjZAt7m/H+gxnzzc6?=
 =?us-ascii?Q?oDuPKuPa/rQ5S5ClA4uFUNA5peRsvmY3WN5Lw9YvyuaERmhDyrw6KqPzYmDT?=
 =?us-ascii?Q?2/yA1z4rSYjiNsYy3r6mf8WcyZqPYSoSIYyuQTy+3fYkPh++VnfrRt9/qat2?=
 =?us-ascii?Q?teBDguaPBZUslIMCJ4r/uGD+iqXSpZuxCGmzStzGZJ8WB1xr8Irxm+kg0+lE?=
 =?us-ascii?Q?8FAj11La/H+Xz3LDbslc7Cr1zx+h3qhpI0ohaGCjicKCq7ANDjn3efmP8yR9?=
 =?us-ascii?Q?tyTat1pBJFuOsnVRba//jomvVpgRL/5v87LM2nmh0f71QsOlugwZbTgNaq5X?=
 =?us-ascii?Q?kLC3G44x3adSHjhsvsBKiKtR+joxS0bavtN0NeSu9MPtrTtGTNoD4P/P1iEH?=
 =?us-ascii?Q?5cug9can5K7XcUMn3SLGYOIwscLFaAgiQ9zV8svjiGH+8HAHg5alwZ3L+eCT?=
 =?us-ascii?Q?Bj6o+KfjEH8a1F5fFXxVcLsnA/jBv6TFuSfloActZzR/wGLFZeROtE3i8v8t?=
 =?us-ascii?Q?dNQr07IkIm/BM+bJDCCSZPekTdaUpLTP2mX2H0ZjYCcNrCzCMXhYNUJKq6A7?=
 =?us-ascii?Q?az1gHZsWlK1a2EuFcHy+krrcVCe2mGHhwnmBOPr5e8XQS+5+5xHr7Nm2DpYU?=
 =?us-ascii?Q?yQnW/TyPhAFOMtYohp4fi1OAi8ERw3u4f76zIncEQsug3gzIj3KLQwrfL7iY?=
 =?us-ascii?Q?LSwxjdlxG1Ow83TzY3ILy+iG5bvllKLfT656S6UmIQ4fZFPIxlfg/D6pgunf?=
 =?us-ascii?Q?4n+X0gzMGFAKXOWRR8rhDX+gpipanFVBxctLfYq6PAsu/YRjPkL6e/puVpuA?=
 =?us-ascii?Q?H2OEQwH8BqVFmv/v7gjYsOEmFI7zTYsGjiwPowDWSIjXzEjWAZnpo3ZHM/Cd?=
 =?us-ascii?Q?KCZaYrdrcgrJanU4Eq4G93EMVrUMeRs1bV1nP6Cx0TCZ9/Cj4aUZPFJ+RSZt?=
 =?us-ascii?Q?0OsmSc6C92tQGzvc2rCLvrg7cd+KZRZi2hEy+57XqeOfF9yhDipJDOUD8LfK?=
 =?us-ascii?Q?kFu6ybfsv13j+PC3tpODfzibox+ns2WmzSDeUAqUUzYMgRWDSKxWiNHUhpuk?=
 =?us-ascii?Q?wAWiG5S92H7wNNUQLQTfLEXJpriL9RDsVVUfi2uKc53TmqGxoevFqYm9c4ww?=
 =?us-ascii?Q?enbkh1B6zeYtcT7U3/S89bEN0/jn/SOUVzGVjpjGCsStGrfPXHSL1Js2Lzo5?=
 =?us-ascii?Q?AqQEeKKVNgD2r+ZnTbJL+DC52Xlt5g0EPcYLFgfyMnYlwA624iFmahu4ZWdu?=
 =?us-ascii?Q?JXKtX1S4ui2PuQCBaQ0HkKb37QV/dDXFufeNHMcIrK+w1zpQG07B6jukA4LE?=
 =?us-ascii?Q?LuD2NKj6FLrCDDvP9V6//T6e+irxQEqHrmcPjVxFl2tnTFPT3MtS6eEVtq0l?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bbbc66-f940-4d2b-d6f2-08dbf4ba1da5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:14:00.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEDNABpwGDcVioAMq2oo4yVYw45L4a+jXWnPUSut6wCBiYQwiV9bujgVwoju50Upze5Bvo5WjD2fSj4pDtyEpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470

On Fri, Dec 01, 2023 at 03:58:02PM +0200, Roger Quadros wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Some devices have errata due to which they cannot report ETH_ZLEN (60)
> in the rx-min-frag-size. This was foreseen of course, and lldpad has
> logic that when we request it to advertise addFragSize 0, it will round
> it up to the lowest value that is _actually_ supported by the hardware.
> 
> The problem is that the selftest expects lldpad to report back to us the
> same value as we requested.
> 
> Make the selftest smarter by figuring out on its own what is a
> reasonable value to expect.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Roger Quadros <rogerq@kernel.org>
> ---

This needs your sign off as well after mine, otherwise in the git log it
will imply that I sent the patch myself. I think you can reply with the
tag to this email and either the patchwork bot or one of the maintainers
will pick it up automatically, it's not a reason in itself to resend.

