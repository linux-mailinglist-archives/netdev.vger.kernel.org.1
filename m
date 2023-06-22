Return-Path: <netdev+bounces-13049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6D73A0A5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039891C210B6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F31E51C;
	Thu, 22 Jun 2023 12:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF93AAB8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:15:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70893171C;
	Thu, 22 Jun 2023 05:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLzqCl/AckUEl+QSfd51Ev2JYpVSghu8dI69YZi26KZWVmubwOMgSgBVwfgOEhyvGlnPjAfCC0JlI/3ZlP4eLG4XcQ4t2eNAHKul85tKRm8H3W3WyMq4CC44Cugbm6xCaggTGICYEsbZvGA8Q7qvftwdPgBovxUbwQri4R+3SzwITeKTZZpSpjfCjckFwSXzxAXZiU6XJwdIuNn2sm+vLfnhAu+p+v1iqrCslGJ7MDc9mScATXHtS3F5qeBD2e6kO0N8AT0k4I5UyyCTU05lQle5pb6Oomy3oDIelqdWsmCXqfZfvtbIvcGY2b7ipVtkIhXHDW4vh/7c3SdNkpBZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aTfjldFCDTeAuTZgeuuUnTcdILxNU9B+BRHitthBaQ=;
 b=SBInTOQFQgLFKJYA9/pWHbbnXug5Ph//of82N67xoPYzckqJ7SeWY94YmlgIDikaRMDO76yOV0kSlqh/Ru2wucac9NshQHU4rJ++nXbA1GWtMduUxpviZbm9ZvtPbi6fgJrPM0m1xXO3uwdcBx3vb8BND0CPGmJNnqzGJWzwovf+6e5iAvaQFYbDxlLT2DH407I0nN2klC4IXXCcH/kILsMqVIoPL99R3RSWdm+XVRuq0xPGEWXmGzSCj/mT0Qdr/eBK1pNj2T969qeqzmTv0jAf0mehYmHqm0Oj78m/fTMqZIvy7tgF5JPKQZPycEZzGsJVDkuJqH8nGpjUu8RurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aTfjldFCDTeAuTZgeuuUnTcdILxNU9B+BRHitthBaQ=;
 b=iFXCCZwpqdKt1eGo3+r6PF9EPb/3xqQq7RF+VqZHITBPw2lzyl8Y/eiNAe+rcv8OrArUOubYDHhKss+GaeXaQcQgjdWVYHyszRzpNDiZB2xx9EQznNrA/mf4wstfxHVaAe87ZhmXD+l/UajREoioKFvU0Tk73teXBp/shddBU4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5660.namprd13.prod.outlook.com (2603:10b6:a03:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 22 Jun
 2023 12:15:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 12:15:01 +0000
Date: Thu, 22 Jun 2023 14:14:53 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next 07/11] net: stmmac: platform: provide
 stmmac_pltfr_remove_no_dt()
Message-ID: <ZJQ7PX01NAXmr7RV@corigine.com>
References: <20230621153650.440350-1-brgl@bgdev.pl>
 <20230621153650.440350-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621153650.440350-8-brgl@bgdev.pl>
X-ClientProxiedBy: AM0PR03CA0100.eurprd03.prod.outlook.com
 (2603:10a6:208:69::41) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ba6acb-d358-4c70-44c0-08db731a4d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cgEFbYOHrpzoAh8AJtQwGQP5ctKxF+TElStxU4grN+5FV4qETlMgF+T1DrbJbBInBwZpJ0PoazzpaJCjpY4Lu/p7X3F0QUXctr0VlG3ho2U8YbpdGFZrObJOrqMV60Jm2zUe6jpztGVQ0A8Z1f+eNf0xpJ03ZxV93gEx/gNTuhqcowdxdFjgKa50i7ic7gwPkLQIhpFirKSodt+5xxPIeAtucUR3qGreRTuhPZmyHq/pc/AHJ/XH0g522UWi2S9g5pekJMhBlisc8l5BvPA8c5fc/nhxfgFyH6iga8EDObBcnlUQ5OBetpOzCMbjTbsirME4d+Qdf05uFIMksoSpnsHliAb6tbq5dA39e50fV0J9FltBUSRASm9qPiCvoZQVbevH1jWI9a9hMCCaz1UgJPv+6JLSPDGfwySs03PtR91jxe/GEG+7n0Ck44w0tQ8KJJDfhz/moK7ZcdlMWaCfuyrsUmZ3y8Qpdulebuj8EfMuwDLQUI1EgwzRXPpUoSZ9wlQIeMhwA8OgGbxzfCYUazsGf5ujM30o47VZNEDSKDVSKLA8qBLPGbiB65s8OOp8EyzTxMTbbCwlFCJvdDJuisNUUBAeAtB8VSEvStK42kg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39830400003)(366004)(136003)(346002)(376002)(451199021)(38100700002)(83380400001)(478600001)(6506007)(186003)(6512007)(2616005)(8936002)(7416002)(6666004)(86362001)(44832011)(6916009)(6486002)(36756003)(5660300002)(316002)(66556008)(4326008)(2906002)(66946007)(66476007)(8676002)(41300700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZgP9GRSgs2QfUOKI17kZuUJVAyhU6NxGuwunzwAxwIwSCwqUuzscSaG2tjY?=
 =?us-ascii?Q?JP8MqnJyp6jEwBRz3tTCatBK09N/jOSGnDs5ysJCUsas291XbwoK0rz5Lbcw?=
 =?us-ascii?Q?b8jlWPywkTGyWoqVS8pHeTgwT0TBeNORRkduwAqrhYdNSKADNarbxgDogx89?=
 =?us-ascii?Q?FglJbGlz90mzcZK8tnhKqxUfgI6ZO43oBxPZgTk5siRTuaGQGHqBmwQeNM6p?=
 =?us-ascii?Q?J8bxMEQyda0XAsjldr07FzBzf6qv48HACG+oP9Oct8qOPLVemHKYwZGcHBjS?=
 =?us-ascii?Q?VWQPCx5se+eWdUaqK5lXOxhMmyzX0QtKx4XBjQDjZ1LwHwePw3T4iNYxKynX?=
 =?us-ascii?Q?2IPup+rD7xHAy2HK4HHPPP10iGUD5Gpocapi2Xe1icP4/eeTc9en5J6XU0nC?=
 =?us-ascii?Q?9rj6IGywubSdbWzIcV4DdTfP+CbWeErqLK3713jfRnqVghETri92LLJST59h?=
 =?us-ascii?Q?Apxl7ziovDbsYnWA/Ce1QeT9cw1b3HYXNyxHK0t906aySt4pL2XHIRm8Z6yn?=
 =?us-ascii?Q?psu7sM1hC/IpgqwuOZB2Wkb9rExA2VTFzOLGiPJ1ysPvYHYUnVtpBggiTGm6?=
 =?us-ascii?Q?k3RgiP6g/XAjXe5BwzCXhofMUEmkZ4SVraAHfXVgYtcGZOtQyhd5ycGhxq+d?=
 =?us-ascii?Q?4KVNuCtxPoeiSwkFbWLuvOcA6wbJ5tKYhQLubDs7toYTgLgEe85leS/C58VI?=
 =?us-ascii?Q?5wvun4P8BUZB4AgXsx+VdxS6N+ZvrWELI22v/t339gKaLQwF10cKpqV9cdMt?=
 =?us-ascii?Q?C4AwDflo5N6YgFr80Yfykd6xT9c+oV/JaA1YZ8pS7UBimlADk0cdis+xYp/x?=
 =?us-ascii?Q?kqU5mdZtjwm39B8wBiFqwe0yLeAytap8FKMKv7wlUEQ3GaMl1/9gYugbg1Rn?=
 =?us-ascii?Q?86GFpQW1kE8kMjatfNFnMDc8Z5TtBsb1k9cM5NVj0Lr85w4C/NtM0jSM+HxB?=
 =?us-ascii?Q?ASpf2ZyWEU/IaJAcW9vWW7Sou8LzN6ukp/aZSXGk0mJomMuUbQDg81KAgD8X?=
 =?us-ascii?Q?7yNpmSOdVnsan6okxuTPMU8ZImiEutR/REIcdKoHoTrpAYBy5kgQ5U4DDF4h?=
 =?us-ascii?Q?7JplSj6af6Ddi7cMLhqfLm+xi5jremegNP09FR3DJah7VzAZVWlumgKq97/B?=
 =?us-ascii?Q?Q+o8D7UbZuwsCCASI55bNV/vQ01buQdicFvckHbmQhtJKusTF9vSevqZrCtd?=
 =?us-ascii?Q?LyU+VIh7ALc8OkQlkC7OCrdNJxViYNGmGnUqMRgAvx62huxetr6wlzGH9iuo?=
 =?us-ascii?Q?XGnLsG4WSNUmVabmW6Wv431Is9iUjuV/8sZizczltZGxOFRkRgb12uxT4lFB?=
 =?us-ascii?Q?9AR1lH0JPq/4UE9zgb0p+ltAVl3sc4sASmziJejqZFrvnHiKVn3/FKa1A137?=
 =?us-ascii?Q?BsRy0a1Ai1hUnRVeJ/+cv5MGY+78ToDJi7JDOi0KayPFf3ZjFnvb+3NlbvIS?=
 =?us-ascii?Q?f1NGiGzPYNGu1Y1Q9Orw50NYO/b4NfK0XPzTB8ofUGPK2hIElZa74l9PkiwN?=
 =?us-ascii?Q?jqK4KaT92zKfQYZlqhfDXA39LNl8pOBtF3Bts2YE5P8uTzdRN4GBzD+JjDRH?=
 =?us-ascii?Q?tn9EL1H4WUy8UlmShiwxHAm3w8jm+9vLvG8svyM9D/EXKSBB8DiNMc2OUUKw?=
 =?us-ascii?Q?/QWAdofXFuuSFbuRSpYWdxHM3XmYTYCNre5AvkL76Qla7xCETwResHHaRHNo?=
 =?us-ascii?Q?RHI3EA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ba6acb-d358-4c70-44c0-08db731a4d7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:15:01.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BJhvCmnKe3VXlS7Nh6P5DZbXbC7CpXkGI1gpQmkOexJTkwTZnll5iE88MH8LcGS5RBJs/xmKbckLzVeVpO1QSCKdjq/F9vLZY7bSX9NERM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5660
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 05:36:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a variant of stmmac_pltfr_remove() that only frees resources
> allocated by stmmac_pltfr_probe() and - unlike stmmac_pltfr_remove() -
> does not call stmmac_remove_config_dt().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 20 +++++++++++++++++--
>  .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 

Hi Bartosz,

some minor feedback from my side as it looks like there will be a v2 anyway.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index df417cdab8c1..58d5c5cc2269 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -762,6 +762,23 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
>  
> +/**
> + * stmmac_pltfr_remove_no_dt
> + * @pdev: pointer to the platform device
> + * Description: This undoes the effects of stmmac_pltfr_probe() by removing the
> + * driver and calling the platform's exit() callback.
> + */
> +void stmmac_pltfr_remove_no_dt(struct platform_device *pdev)
> +{
> +	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct plat_stmmacenet_data *plat = priv->plat;

nit: please use reverse xmas tree - longest line to shortest - for
     new Networking code.

     e.g.:

	struct net_device *ndev = platform_get_drvdata(pdev);
	struct stmmac_priv *priv = netdev_priv(ndev);
	struct plat_stmmacenet_data *plat = plat;

	plat = priv->plat;

> +
> +	stmmac_dvr_remove(&pdev->dev);
> +	stmmac_pltfr_exit(pdev, plat);
> +}
> +EXPORT_SYMBOL_GPL(stmmac_pltfr_remove_no_dt);
> +
>  /**
>   * stmmac_pltfr_remove
>   * @pdev: platform device pointer

...

