Return-Path: <netdev+bounces-21237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DE762F35
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3217281AB4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93BA92C;
	Wed, 26 Jul 2023 08:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB7947E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:08:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8305BB6
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn/SFAfQRGfnxLhaBTo0EcqZJOOfCf8yTsZrdLxqwgalRyA+loAOwD167rhIwNVAi241mEvNmAAE+jNRyKLNj4pTe3vbS9siuXFrY8eYAYFXEscgY0lbb09Q41Vh/WPtIN7prFWzCluYtpbgJ7m9VUwCbalZQ3zJy5BNeh7cMzZeyOwrpREvD1uHIgHM9e6Y/pbJT9bt0rX6uQUGXk6H5ZRYNOxXVxO2njijQzAY9Uq+Zh3T3P2vJuhjNCVAGEOlsrNQZCtqZojhceTFKgP3TmJG0cAVrIRCQrbBJ4FdXa7iPtbYzz+vPf9U6tLHoMLceuTYH6OimG2QSt8ERDNH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9p3dcO64JuSSA+QaClMG+6FErlXHeQMsWqz8G2zSqI=;
 b=fBo/c3G5+uUV8ZBc3zOOxTVy/wp5XJOJqz0NWBcQycQnEBeafCd/gGe2u5ywPd+CSFC6CEBCvGkpyDgZg5LvOZKmXFkEgq0539Q1wddYHW0InDdgY32yduv6KHDvtDR8WPhkCuskNW+GS1yF+1mAKA6Cy9MoNi8hqje2bOwg2V8rTU+96wP2rYGTofZoeKfuoXKoASIY+ucXsr/f2rnECc3iMRseUe0C/tPeLy+wv7YX2NqDq+hMs227v8uyEeYd/Lz54FWOTb+F+6D2OQsm2BWKZ8n1YbZTetasnvfOv/lgnLtKjr7wsigYSmOpS4GI5puy43Hj38BSyKIYyokpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9p3dcO64JuSSA+QaClMG+6FErlXHeQMsWqz8G2zSqI=;
 b=kZHaCH+SkeONbgcrzMHf0iM8mQ7L7bh/4w9g2fnqD4bo84wf87bUkmJyCHgq/7hx2p6A+FpYLrAg3PJB6S+JHOcsmE2xXqaKtPxo5W0ShM6cHvnnIrE8H1tBj/ZkDjPJGIwsRWF0fKsVsCdvCBph+faqpSF8ldEk7d0Ce38bSjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3971.namprd13.prod.outlook.com (2603:10b6:5:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 08:08:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:08:03 +0000
Date: Wed, 26 Jul 2023 10:07:56 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	sasha.neftin@intel.com,
	Alejandra Victoria Alcaraz <alejandra.victoria.alcaraz@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix Kernel Panic during ndo_tx_timeout callback
Message-ID: <ZMDUXFWXOVuQyzSx@corigine.com>
References: <20230724161250.2177321-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724161250.2177321-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3971:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9e2c31-a60a-4cfe-7b54-08db8daf6f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZwpCZBYO0V18n9F2gOHvGFlELq4BnvifsP3aLs57twMdoH2NA0D3/xEdh1B/Pm8EyIjrF/PAguNMMPKtUVaCH3jAmmOUOPrNwRNjv3yDSWIBK55XqrjRve7RY66TVuRVDN4yOsfkNk7+DVrQOuS9MmyPX56dO/Jo0cdkIQmR+VLeI8Gk8t4oVue7W9nxcQkM/GQcxgFwp0R/BuXTFCN4ewFTVNiQ3PpgiBhH5g7/7AZ4JfTJSTr8ubi6ZONLgDO4HMRUs6towQxfn6EZZfHyM2n+iEFwrhBO9UHi7K9ZqEkS036e57fLXm1dlFPc3dlnMREMRjdvBbPvcv0SJqYbXEW497WWm9s5w5DUNb+0D9f+nqv52jR4kzqlpZOtoxz8KEh/hjfSsOzOR1YOnqWC56HX90Mgo8Ht/8F0abq/ODGMzY3P2d5Ssr9Ejm8c2O8fPODE5YGXSVLBt9P/wpIl0GunhP1QUVzH5qASmlY7zgqvdzM35vP6hAFyno/zewXlP/gT4SCusrFbCM9J+NDoIdhNFUWZKR+5pmli3Nfo72cDTMaDAYe0ahUYZIJthJ2D19GYhWkHtTXG+XYN/s3xyndJBx9WSFl5GsL+VKuwCcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199021)(6486002)(6916009)(6666004)(66946007)(66476007)(66556008)(6512007)(44832011)(4326008)(54906003)(38100700002)(2906002)(36756003)(478600001)(41300700001)(83380400001)(7416002)(2616005)(5660300002)(8936002)(8676002)(6506007)(316002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AExxxYlzyxKIm+SvsskY7z43YfA8wOMcDpXY+b8nAnJUKVKEDvGnHri58CJJ?=
 =?us-ascii?Q?3P/DpEHLW1PMRNtrWQJGGBrBv+/p/lqWc7dLQaCrsASkjyXQSIkL/Uu+ClF5?=
 =?us-ascii?Q?gNDbaIVYh0DZ3tsVvY0GOFDTouX4HRlVWQ730yzr6C3rwCrAnw1NIar2p178?=
 =?us-ascii?Q?MG5sbRtLD+P2IpYUR1tV5Qio0sW0QEft4eyAdJg/EMfeK8B7xptd/jPjCwy1?=
 =?us-ascii?Q?xf/17o4qlWUP4nlNwXjyzZQapwt0MI9pFQt3RvoZDLPRblDx2121S7lX/hMA?=
 =?us-ascii?Q?xwgsZEIeXsXweVMAM6Q3pXvzZTEambxQwGNttDsl42M0zapGa9vBp29S5Ch8?=
 =?us-ascii?Q?5MhkMmsDHBlc/KyfzkoMmJvk/kjOT3ZzGPfIEYus64fkFv2NuxYmFaqlGN5i?=
 =?us-ascii?Q?qvSKS+ccNHY9R3UNfcBkbgYTIH8zGVMCsEyBs3MLlqvTWBIXquoMtnGADGUv?=
 =?us-ascii?Q?vGiPi/t3IMe4rEzDzqkEsGJIVcuG3zb1IGiO3xEWJA58JqHZEiRkm+gz4EGd?=
 =?us-ascii?Q?VavFiszGZRXZQjcwtSPtkFKoRZ5sNKP1pttSGYldtsNofzL60DICPkwIU1wQ?=
 =?us-ascii?Q?ng3Sg4Q1B8R+wXakY9pf6/eC1OSNfpmLxSF0/mBVHT0u5280USXNvRullK40?=
 =?us-ascii?Q?3RU0b2YO4v50yBGsMvkudyTy2UG7QwvYfiYNTFq1BgIG6z5JlB371QPj0YVj?=
 =?us-ascii?Q?N+Ew6OVKtgaU5Awqymf2uyNA9hwKU+8RayNnb7Tc5D72eVXMBn4h0zj4k3M0?=
 =?us-ascii?Q?yMpj6imrDW+KGpSVd8pffl0C463G6cWc1RiREloN6q7MJr2pWf9fAMkwwFic?=
 =?us-ascii?Q?jbmJ3MbXHFwZ77w1y1JC7ZQxq+TURjcaLWsVNnqGou19aAVF5Z+kNknsKWsq?=
 =?us-ascii?Q?5FAeyEk496t2gAB1Op497kIWNINuqe2QIKiHQduji5ZyeIiSTeEaD6JNHCsn?=
 =?us-ascii?Q?VhjFE1rKz9pW9ZENzF/6+sCR3p9LMLAgyvCvHVNMj8GN7i7UlxYgmqccM1HU?=
 =?us-ascii?Q?IcXAebvYCB1nE7n4bwVSjJCB5FRqIW+O3SplTJhK8+qdm2/DyhH85bQhah1t?=
 =?us-ascii?Q?uZ2xhTQzJ+tzZrdeSSEsD0uxZkdjDCkFrGlL4g3yo8tJ1ILEyVBCRnrCf5YA?=
 =?us-ascii?Q?Pzt0zNfrivhZwu8/+FS92dMNsEpjiutfi5ouJgwrvtnlmbc3oj4N01HtpSaN?=
 =?us-ascii?Q?xiUPDM9wuR4G2gZ6ETAyo5XazAmWjIEoWDZpgauM5Dzi8GEkBQCfaypBzxbt?=
 =?us-ascii?Q?UTjpHyVwzHDqSkf48KvOt3IcQdUO6i/NrvQEYnc7DYM6Fak5NxXDpS26CqXa?=
 =?us-ascii?Q?0E529Iz3qBEWleKeVDzdC03VES8Pw29x8v5ytAZzIoMBQVzfOx4BmfVzcwC7?=
 =?us-ascii?Q?sNeNRDwmBVQCMdvN2K8s4yXMAKz0Gxj17nY9N4dw3LIp6wxQu5LQWZEWh4wS?=
 =?us-ascii?Q?ZxUH0QTFPcZR/HPz1KffqRyNiT+m0cuOribX/Q0rzNoAC5cHf5ZtDmvlHMAB?=
 =?us-ascii?Q?mg0GqRdeChYj+aRahPErHHsg8qUH389xg6Sp9XMxNE8RHMtOL8rKPLQbmkmk?=
 =?us-ascii?Q?a8LhCFhKRrUI5+i+t6eZidxWH8wlfjUxinLDjuNHjFYSOtO60HisaCejp6cf?=
 =?us-ascii?Q?wzIurvB2a8iaVuZVmJM0YoeCFZjmkua+/5wyAnAum9j5d9D3yTKrhJZDySwt?=
 =?us-ascii?Q?Ub5XVA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e2c31-a60a-4cfe-7b54-08db8daf6f5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:08:03.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SCsfE1P8jv0v90tJ+Pm+Z96EJ6uQ+RVPJy0+cJz9Fv1NeImxEeQWdyf/fzYUYTeRgqkQRDNMVpyRDwUBZTYCQWwgjOR3ZIHgqGG5gPG5xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3971
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:12:50AM -0700, Tony Nguyen wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> The Xeon validation group has been carrying out some loaded tests
> with various HW configurations, and they have seen some transmit
> queue time out happening during the test. This will cause the
> reset adapter function to be called by igc_tx_timeout().
> Similar race conditions may arise when the interface is being brought
> down and up in igc_reinit_locked(), an interrupt being generated, and
> igc_clean_tx_irq() being called to complete the TX.
> 
> When the igc_tx_timeout() function is invoked, this patch will turn
> off all TX ring HW queues during igc_down() process. TX ring HW queues
> will be activated again during the igc_configure_tx_ring() process
> when performing the igc_up() procedure later.
> 
> This patch also moved existing igc_disable_tx_ring_hw() to avoid using
> forward declaration.

...

> Fixes: 9b275176270e ("igc: Add ndo_tx_timeout support")
> Tested-by: Alejandra Victoria Alcaraz <alejandra.victoria.alcaraz@intel.com>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

...

