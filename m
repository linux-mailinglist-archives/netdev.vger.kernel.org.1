Return-Path: <netdev+bounces-17498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E7751D04
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EFC1C2130A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E05F9FC;
	Thu, 13 Jul 2023 09:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83926F9F7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:18:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B617B4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7hT+qePL7JLD7PNUvAcfVh89FpAwJ+zubcCIticS/67XGv2LR8hr3tHePfQdO+8dgt+HfFUsOcF9s5MhUlLZ1LhmNVMonhLYn7hDKbekUA8sXCW19J7GB1YMmHJ/bpoub0qFOqRPH3Ew6dGZ6wuHxAgcyS5Ri7rGhPjludta+dQ50LSjlSlu5p/4Irdtd9GLoD2MK6lohhVhtq0m7fAEWioPxvuWkAT6jyVfoMI1nTCTnKegKhPXclZRBaDaqlRTwbiZgW5JrYjX6mblNawN5Iwc6ON0Rq1wWdED0f150sIAaTvFheXFcUVvKhiRygIy4IhvJxEOR79Ae4b3z9eRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/4nGnohG3iE7223loFa57/eJ2+iG+q65IBShGtRs9w=;
 b=JvILyjmKjiqPh2i5lU/ZjfjIyajXyY08vvq2kuXHwVoFM8/qQIndDS/sDJQHnRGc/oDMhonLWpzNOgk3uJAXPcRzz6pTs+bR9rw1XsX8DnGT+ZGYFvm42K+Lns11YJV0zlqX1PqqBsaYfN9qY24N9OCgumbMhldQCWkxzb4SCwsIoM/G2ztHd6A1JL7s6y1RPWjO5AagIdx+sUYDFEWEy13IscHPzqqvDfChmpAH7kHb0VpDnazPy/2O/xPtWWUq/GFgxVrDaA/2hJz3bbif4fs7/bwOPcJdy9oyxZJajknLSA2My/Znd1l1WYnB3EjG+k8k6H0mGpiMfi7CGnuVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/4nGnohG3iE7223loFa57/eJ2+iG+q65IBShGtRs9w=;
 b=MOFrvJuOWqmXM2LXlUN9ZgfOoNLzgIxpsLdPohPNEZHD76F6ZaCN3RFBmycFrInNmo6zzvwWdeWh92WhpceBSW5TqK4FKD1AIzbfmxrJyh2gtdWH5zd4bJdYQM0WOFdEtrgWSEtOQo0iivr4NecDi6ZQag4Jn7mL+o0NPvQpsvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:18:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:18:08 +0000
Date: Thu, 13 Jul 2023 10:18:01 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 4/5] net: sched: cls_bpf: Undo
 tcf_bind_filter in case of an error
Message-ID: <ZK/BSeUzjPhhQz2T@corigine.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
 <20230712211313.545268-5-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211313.545268-5-victor@mojatatu.com>
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f45ceee-d345-4a58-b2e0-08db83821271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UUQqsik3fW1FN0moCZ4fXqBiAD6LwJW/0kuPR700P9J7Y7zHpLE7n5W8vGkCY0PFLTH4SVOktAxm1e4zpvZq69WH8RnvEX/ToXW6hIaOxMr9wTWieZ2DXFLbRiUg3JwjXxqPR2Rlz2f/T29waM2sVWxieZlRAbzVKfQq+NORMVWVw+zbO6SOn/jb1GIOW1SvXWTUWjcGlORM809FTKwhZ+SVHWe+BJHr67H3vcfTFLuR6YcGddGYmllFgmy+op/3l5Ox8F7OaSItllU0eg6i2ARgJFki8/B7CXXr5cjSN8wrq2kwqk2aJmxVYeOrJnd2iApMjTTqYtcnzPwrGN02MFWVKuP70adTZYWB2++r6UJehDrBEeA/e7uCABwhwwBktGmP4gEE7WvCaNNd7aIIaeCIPJxsPCXt+hLIaHz7oPLwe/9Cwbo/Mg/dPOdgjNzXP27fYYUB19uv4mmjf3tKAjM9FNzGqc5rcuLJwjY5yEOZJu+OCLcbnL73n7owcCzkHorYruOC79Q+7DZTIJ7x+jMUl8IUZdhjIa71gCcLkVdUfQE+0Yn1q5ljGQss2KevRKUZdrZq25sMZx7ficOGSW23Uloj2LTm/nuLqNxe17Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(4744005)(86362001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8UaV5MBhG0Tplw6rFAufOqslDR4bGTPn87MHUxxPJgVFNN25yB31V1az+v8?=
 =?us-ascii?Q?jeYsUgEczTOgCdES+NyCkClHgCGVyLu2YkMjf6sD+0wWr5zu3mVU7u6Sf3jf?=
 =?us-ascii?Q?nM73XnZ8+ntM+/UNqS7ObCRdotmk82uJeBk1BAwgX0TPRuSrzpkfuhRFebyc?=
 =?us-ascii?Q?b1SCGT/r4oG7RSK9ArihtXMNzRy4w4x9vIaDJVmIn7gYdtB2bYToNOaxrGZz?=
 =?us-ascii?Q?dAY7oxOprfaKdBvsVQHVslC3WBXC/6leheK3r8HxqEjJ+v3NfX2KNyR7SVEW?=
 =?us-ascii?Q?blKbbx6EXw2tBuxbBB+jJ4xDk0GufVsEu63qyzXvXuTI52Hf123lMayG+iV8?=
 =?us-ascii?Q?BFfICnzhirEx4dbKNOqHH0nu27x0SPb47FltNqnsYQ4JaR3KMlZuX8ykPaoi?=
 =?us-ascii?Q?7gMWQHDrLRn0SbL0LaSSGEBt8H9TDHWjFRsmNtS5pVGEmFMB6Yj8FxPIDabv?=
 =?us-ascii?Q?bKRap/1fx+q2m/X+DQnGn1Oh/gRbgafVkKp/0FPSQHstkshg3rSK0QBVMk6j?=
 =?us-ascii?Q?9Vo187Ml0cwZdyeumXHVSp0nQLSAkmf7d8tQghWekIVXKlC3LMxzzDbL4Di+?=
 =?us-ascii?Q?c6rpEa4dafavjYABiQTgaMQgPTFIS1CmNksAk1xlnD6BfQuILxPEYGLI/SKA?=
 =?us-ascii?Q?h7RRmFqDBd7x646I2P5903LeXoMVYgN9gbWlQNYVdabZnU5rBaBdAyTY77cK?=
 =?us-ascii?Q?3r2noT2if9e6d6H6wp9IbCdwr3X8rQAk7qe20yglH1gxKPCiDDD29g0vJqKi?=
 =?us-ascii?Q?9OmvKRpje0CGjjixfYP6hEwb9+Mh/VdEWjFmTQ9V8bk1IT/Iuq4nh28xBoRz?=
 =?us-ascii?Q?n+rlF8/Y4rsMV+ZsdsLZVZGAMeB+oESO5FoXKTKRgb1kSAX1eza10Qcu/TP9?=
 =?us-ascii?Q?sN5d+5kVWTre24aZ/SvpL2ONJxRceQM7ZT7grAtPIWo0xRDNSr2DlZC5LDk0?=
 =?us-ascii?Q?2i8Fz+EwlQTRwbpwHb1oDvu9Emk6XzjzamVAsVWZgyIpMvukZBE8toKXWPKg?=
 =?us-ascii?Q?5T/+5RGk0dkS3obYl8XVPKBkDyk4OdK4UF9yl14KXG5hkdrXTY/W1X0/VmSh?=
 =?us-ascii?Q?McDyT9cTsyRAO0BkQH34AvzTLOeh99Ykrs7Lk0/mM+TttxyVC6Opo1GkpOPy?=
 =?us-ascii?Q?o0Rvnl1j9yZzntQPRVJ6ZU5IriO0Pq/gF6/6njWh/YDexipIQ7+R8aaaoMJi?=
 =?us-ascii?Q?apsxhFmiWVQPaVoadr4svalDlNJBezOJzvGdKz32qPtk2JopUGeKd/EzwOSd?=
 =?us-ascii?Q?CiD1vYPUE6Kw7Fgd5iy1RkPlbFTa82gZKv38k/nssBolUOr+HtMLDkPH/qrc?=
 =?us-ascii?Q?CPKNd95QlJ6lraNPQJrn0iimlju1VUok7NfyaHExwQD6f9z9gyry5Q3CmZaM?=
 =?us-ascii?Q?U5vMguQ8X+522aw9KOSncap/QvW1RxVoMJlVQlPfFn+LiDEfz2H+PXGjpkIh?=
 =?us-ascii?Q?QrG/+d9hq80ZAt40/xWJn6H1QVizk+h9edmFZLvoR+GR2xWyJjyOtwB1DoxA?=
 =?us-ascii?Q?Pof9rcxlxT0u/NJNR4z8/gS8TqbcDgOfcW6wownKB5SzRmaLi1qzOKCVtvUt?=
 =?us-ascii?Q?WfFTATTKvpsYfGjB/VTNpmcJURoWpnHlro2IfPWSWEcmRDWNe+eWT95+/1UF?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f45ceee-d345-4a58-b2e0-08db83821271
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:18:08.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJvQE20FBN8WRF4y7bMGhRdG/B68h/JzroxsWo08kkaWmQFAu5lwqTZC3Uv4CvT4zvf8PcUE4B14ZbZukjv0nh/g52nYC18gr4DEZi/9ZdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:13:12PM -0300, Victor Nogueira wrote:
> If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
> was done before the error.
> 
> Fix that by calling tcf_unbind_filter in errout_parms.
> 
> Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


