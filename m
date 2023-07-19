Return-Path: <netdev+bounces-19121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1254759CC1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DEE2819A0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE612B7C;
	Wed, 19 Jul 2023 17:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D212B70
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:48:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7B1BF6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5REetBbtLmJvRMFpsXn8uh3xDFMtSSJ6Esj7oNtuWUtP6djL7P/dCQjIBGwQGXKIGc/6fHq25GiprZPmtFDo8rdQopG+UdMo07u+DYmxOy2lTJaCpRMBahCwuY3FV7lXh/ijUPWVxjgkD7iX/QRQSNuSwtxYU5xyfHsUY0H8IudCs7Ii3+p4EPPcJGJbhGaj9bfeUy/DkuEf9E5Ky2FwwVvN84iwIT2ZIhyPHrD6S/QGeCReOf2segeM1DccsEqbPoataKa2xrAfR81VPp1u203AS0vv6CZbsgLBo3AIx5u4dwAH6xBzLeJUpSJ4/NE0cGro5Iocu8tXytwknGSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwG+02DgxuNlN68wXm/g57mvNMfYau7Vl4wI5JM7zpQ=;
 b=j/fDgI1/uUPvsSWhBqkI++A3oA5ZKDVede6mwn7rLcVV3t9fUUrRtyQGkCTKldsWhjzJb4RS/Bq5XbmvscaBzR2VDRaq3eLa0Xp8Z57b+TdEwj53hagzq41n6obvm1Ag3LnzVGp0PmP4uY6Mfw2sIpg9tR6/ZzxwtjOes/p571PM+dWOFqWULVsdc45Ysu3PQdBsSYf/W2QrTtLTn8km42mJXMX8t+YhRa3ljjVHSyDWLIgfbnnpsLSCanO4l3HBFT+l4+Qq1APtTPYeL4M0PFCJIcUmkzJifLcx5QGD85WHNz3w3NxTqGBjfEwV9IhnwpiESjXozp+sybGlh9h78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwG+02DgxuNlN68wXm/g57mvNMfYau7Vl4wI5JM7zpQ=;
 b=ZudC/tEFibYRHiFFJXWQoGOrRDUx9o8Yd3eOv/uJeyA/XndrEuMWsSNAgtJ/9z/J5K8tPRFn5RvFJNXNH6BU1y7YhzItr4lxJ3C0k/mRl0g8uzUJ6io3ZuJ+X5lHxnsHBKP2oskB7kDW2mr5/J+yaIhGDvazMa8OoieZ5szq7CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5314.namprd13.prod.outlook.com (2603:10b6:510:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 17:48:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:48:31 +0000
Date: Wed, 19 Jul 2023 18:48:23 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH v3  net-next 2/4] ionic: extract common bits from
 ionic_probe
Message-ID: <ZLgh54I53tdedi/y@corigine.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717170001.30539-3-shannon.nelson@amd.com>
X-ClientProxiedBy: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 964538aa-e0b5-4b8b-a387-08db88805d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qA3pdT3w7N6jJIC99TisUkAUv6rj71eVbqkvDwwzGbzgX1INZkgraiRfCMNtjdE5oCY3SSQhn6NdAkH7Iivcp4GE/0vn5CNtjHgLlD4U3o5aDMVCik5dMHF8TZHqwJv1oCWNoXAsTWMf7rk7ZmLvOqQhgQ83NcfoXDhGyF4B2s7dRGcYMV5nE6+lYID7rgPranTlbLIxIxrjiuce67+9CQfPGaI1it/3K09aPLXYNutDflATOU5sA25ilT2Exn60XiucEdMFFm8JSWmxxrDT/FlELOCLa+mMTMn/Ujy80+cGqy7d19cVvVZCzZReiv3mLFOqeh6DkrN3gh2eGrl29F9gfX0lgT2/LoHEb/pu+hhNX3gY58GHNKKlMG84lQHmd5AofJ+cAoxcY9qNGcN7vkKjOwWpORzmfKGNP9AwqlU6yLQvOWZqHunfZIFhRxqyA1RSzcSuFxCeSkbG7/FxSDZYmHn0teoul1KiXPIQyVBKZL4GGK2ZscTW5muUliOxMRhQrKukkjK4UhuIrAsgIvOFd+RtW6Q3uexJNvo2760MVy450f5AmPA2PS//HIffh5MPA9DuvjIK7wei9BQneEFvayfd9SUgxF8RDG9WzGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39830400003)(451199021)(6512007)(6486002)(6666004)(55236004)(6506007)(83380400001)(36756003)(2616005)(186003)(86362001)(38100700002)(26005)(5660300002)(8676002)(8936002)(41300700001)(4326008)(6916009)(66946007)(66556008)(316002)(66476007)(2906002)(44832011)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lardV1PYBz8TVwhe7DGHjB65jowRYpVvjTgsKEscmYtQTuh0zPRK/FwRf4Ap?=
 =?us-ascii?Q?863wgJFdJwX47OeTQKazkW/7KhPTeJ66AFZBPY+OKnLALn3nJzm4UlgE3kNt?=
 =?us-ascii?Q?CE1OF/MZvjRUTo9UDe6eCGRN39SQhKHwiGG/TWWWTTDWWgpMkAaPtKasmDo8?=
 =?us-ascii?Q?8PxXFvCHlOBrIZQ5YWe78GMuVeMtqI+r39CfkhL+RUTSqCvXSFnkVQZWubzR?=
 =?us-ascii?Q?SpYKSrfldGIH2UGEiP8fz5WPPwY1MgSIF24N3c9uPfcZ8nHC4c0gT2N2FCba?=
 =?us-ascii?Q?Xkz5FlWvDmwQp+TgwI6oUgpzpwsP63O/CfWxFckgQFpxs0/lgwME0dXs1Mgl?=
 =?us-ascii?Q?DUqHOKeR2BaLaOEK0Z6s2A+RknZqdYliiEZOnde5z1K3XcBqb4aa8HmciZ5E?=
 =?us-ascii?Q?VqLPMnec8DHbDwZwGYZd/UFCgKXs5YgO1HKF7DhfNNngzIhirGIarDf4LWLL?=
 =?us-ascii?Q?kmI2qDNe6hYgsegvEZxPWx6Xna7J6DyrgOZTcCNLMqTmjeKHe4qSxOxVt0RD?=
 =?us-ascii?Q?acvOOo7471XlAbq6zja6fnMdXt/XKeT0Imbx06gNYjWAl1lyIC6ch5e/JH19?=
 =?us-ascii?Q?x8UzBBA3dGlmNR1bociANn/pkRAiyo8R8IieimnQqW+heE8RM2b1ZZmiu0HC?=
 =?us-ascii?Q?Gsq6QKcGNDHBfZh6MPnFvxAaDiwTc69HmFMnaIRmAi/mNpsTzwd6ISETi59b?=
 =?us-ascii?Q?UpSiQcBWVHZdswEvEBso7chhYmVNFQ8xHrthBjzM6CE/MlyASqe7DkOpxL9x?=
 =?us-ascii?Q?TmRwOaKEZkV+EMEd+IfpqIHAZSXu1Kw2RxP35uisstLHdT7YrsyveKRaslTS?=
 =?us-ascii?Q?/19ScZg8zaW6WuOnfib6ti96IRvgexrdGdlEYaTgnNRdoqRpMiDkrhafj+JB?=
 =?us-ascii?Q?ptQj0EJZgQCEtHBdn0EGN+2MEr2MWCteq+9m0TfAHi5SD0qpDASkSNrewzJs?=
 =?us-ascii?Q?zofS7WCk9L8p+293tBXKTugEjJcr0gHL6Or9L966nr3eNgta0DQIj5Ntg9FB?=
 =?us-ascii?Q?fIHUlzCiT6ElTK5AgQkp+vcHb7vp+Q3Z8hDKIKTSABFLUR8WRud0KkFqUfJA?=
 =?us-ascii?Q?2N+IXKs+hFWbL52adMJeRqwuCAtJsC9ai6QhXRBnRfqp+p50tbcNIav86BM5?=
 =?us-ascii?Q?90gI7MYJHGv03c2Dk2SXY5jBdqNwGPy+btIDVOmAjPrj3dm6crlq5mPbuHvi?=
 =?us-ascii?Q?Iz44lQYKubEudfhAPcehPbC7cTMgC5COnrxVgVxvCQMovRJdrv8o2b2JyOGs?=
 =?us-ascii?Q?qXj2eWwY7UgspeEONeN490LM7qdmcfj4bR2+SY5lVHNPnjQi/bL1gZbzoam2?=
 =?us-ascii?Q?kCZx0be3OUNYLJGYKuzKarRyt18UiFy3Jxr4NjHjl2Y7KztudC99i6gt9nNY?=
 =?us-ascii?Q?nZ6jDHQ3kxlr9Pqag1BRSzbNnZJj56ZxGJf8EaLBshsKo613SZF6VH8KgWeI?=
 =?us-ascii?Q?VhPVytxNAhI+kOLK09hHzuJ5QWINFpXsDwyjVA7gXkjjSHcEV1/qzSI1pT3e?=
 =?us-ascii?Q?rOLNahLNNgswlaUr9/1b6GoKe5GLbvHpV75eweut+4J/UlKGd1QPw0Iuadjw?=
 =?us-ascii?Q?V5AThspXkCxEhxuSp1T5+QPygd+TYEAHx/km3Vkv6u8aZhtrCjg6Yx037VQZ?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964538aa-e0b5-4b8b-a387-08db88805d59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:48:30.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJVImEWIE8cWTb3XGUz6eJtSfMqnN3XqnpRGByPtQpCXkogktfkW3qsKE/vjWqBnabVXhphBhh5yAVoDfMYudivrsGjXzRvrfbdNxVyFu14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:59:59AM -0700, Shannon Nelson wrote:
> Pull out some chunks of code from ionic_probe() that will
> be common in rebuild paths.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

...

> +static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ionic *ionic;
> +	int num_vfs;
> +	int err;
> +
> +	ionic = ionic_devlink_alloc(dev);
> +	if (!ionic)
> +		return -ENOMEM;
> +
> +	ionic->pdev = pdev;
> +	ionic->dev = dev;
> +	pci_set_drvdata(pdev, ionic);
> +	mutex_init(&ionic->dev_cmd_lock);
> +
> +	/* Query system for DMA addressing limitation for the device. */
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
> +	if (err) {
> +		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
> +			err);
> +		goto err_out;
> +	}
> +
> +	err = ionic_setup_one(ionic);
> +	if (err)
> +		goto err_out;
> +
>  	/* Allocate and init the LIF */
>  	err = ionic_lif_size(ionic);
>  	if (err) {
>  		dev_err(dev, "Cannot size LIF: %d, aborting\n", err);
> -		goto err_out_port_reset;
> +		goto err_out_pci;

Hi Shannon,

Prior to this patch, if this error occurred then the following cleanup
would occur.

	ionic_port_reset(ionic);
	ionic_reset(ionic);
	ionic_dev_teardown(ionic);
	ionic_clear_pci(ionic);
	ionic_debugfs_del_dev(ionic);
	mutex_destroy(&ionic->dev_cmd_lock);
	ionic_devlink_free(ionic);

With this patch I am assuming that the same setup has occurred at
this point (maybe I am mistaken). But with the following cleanup on error.

	ionic_clear_pci(ionic);
	mutex_destroy(&ionic->dev_cmd_lock);
	ionic_devlink_free(ionic);

I feel that I'm reading this wrong.

>  	}
>  
>  	err = ionic_lif_alloc(ionic);
> @@ -354,17 +375,9 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	ionic->lif = NULL;
>  err_out_free_irqs:
>  	ionic_bus_free_irq_vectors(ionic);
> -err_out_port_reset:
> -	ionic_port_reset(ionic);
> -err_out_reset:
> -	ionic_reset(ionic);
> -err_out_teardown:
> -	ionic_dev_teardown(ionic);
> -err_out_clear_pci:
> +err_out_pci:
>  	ionic_clear_pci(ionic);
> -err_out_debugfs_del_dev:
> -	ionic_debugfs_del_dev(ionic);
> -err_out_clear_drvdata:
> +err_out:
>  	mutex_destroy(&ionic->dev_cmd_lock);
>  	ionic_devlink_free(ionic);
>  
> -- 
> 2.17.1
> 
> 

