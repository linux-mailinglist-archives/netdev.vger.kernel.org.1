Return-Path: <netdev+bounces-16512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8A74DA9E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0C1C20ABA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5D12B8B;
	Mon, 10 Jul 2023 15:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D412B78
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:57:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5660CA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVulPLWUrjHwCwx2Rs5dlCbP4T9j7xBqUz9NzoafIJQH+CEh4AvFkUGhYcFfCCJzPvumwJfRf5X3BIupWr+3dXeIDDPe40flifOrN+NW+rYhj0MlzrcK/P1PSgdyep0XoHqfzjHua/3egyM2pZCRvptYysTquyQ/9wFGTg+fpT6hrfqxwoIKvlN17iW3c+DPyk/fxIGZfDjKm4VlfVrP+iuMHWE3FDeVll8cjhqTIb4avGdY5+DIMGiZM8tQzga+75kZo5OEM6c5+kQrmNZm215THHHibeePVY6eaqL6WZDqhsQ9YgFSQQrPM9wRLYMaLBswk1tQXcNes1bkdVRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKZZKh+kQrDBSBrbC1eVTgtaJtYjg34AXZR2HQ35ZHw=;
 b=S7PK+HX67LO8FXgbjPEnx/zjrS5y2t7WlZerlZ41SiW9x3hHiIWO9riEXKsuGDT8RVHuvuqO68xc39PphJPYR/wYeU956LsJNZVgcvD3ffdCVM57yIIK4DkfA+uHeFQdbSA2tCocqK/iXpqY+iq13dY+PZbvlYfbDoTW5PkbuYFNZ6r7Mc+KBhFlCojAFks7QZPtnpYqh4txAXxqVsDjttf+aSVTUaK+hmhsCtczlE+HARWtL07BbS3Ww/5xLrvgEp28rJu4T/up7hTDS2KSp/iymnNgLdR+HdKNJTweS/gELeUCeW8Q0EGpBEb9M8sLzvzXP8pkmeis7SfNU/4RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKZZKh+kQrDBSBrbC1eVTgtaJtYjg34AXZR2HQ35ZHw=;
 b=VT1XTGRgvgY17fMCABTVUJnVY8vhSkoe76nzivyazWOBMtFz8f4u6Ea27mHsqQWUydIzly61P31+VCvleTvvUx8XrRL5Xbr0dBtCAThqFA4h0YF5c84vKfKVzG4QLWVa9ABidNfTa9eZvqOWLcyb/5gQNj3wYSG7glb71qVYwjK0j/STgGINHQqBdrCHNxAElex24ESdVgOptng0gU2xigTP03Inp/LIzuipkg8C+NK1g9j/ll1MkkC6JXo8R1wsY+BRdhYB+uqXhUk9UilVlViaI+x09c2Eno7Y/NWncI52hQXH5M/mQWrRjZw5h5DnqjyiNGnAKLI8sOSMAK4yPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 15:57:32 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::2c53:d30a:a55b:3e60]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::2c53:d30a:a55b:3e60%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:57:32 +0000
Message-ID: <9c25971b-78e9-956f-95a5-38e688240ef6@nvidia.com>
Date: Mon, 10 Jul 2023 18:57:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug] failed to enable eswitch SRIOV in
 mlx5_device_enable_sriov()
To: Aleksander Trofimowicz <alex@n90.eu>, netdev@vger.kernel.org
References: <875y6rrdik.fsf@n90.eu>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <875y6rrdik.fsf@n90.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dab3e35-b0c3-4239-95ed-08db815e5e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kaZRBNhejHSeBIQHmNVtPhzwuPMId2v8V2L8jfd5Kd2nXVdI8fhUYipX3ijJJ7kXo/S4k1qpH9VwgCR2aq62mdzCOxsj7xZvXtMYmEFTPKelvY/HN6u6V0ig/gUDDiRBFEZ+D1TpKfwkUtVS/OOY4WikFiEjIwzMrH4fi4HGs1uGLGiQQw0Rwctq6cMV3K8GPApycp1N0cjJFfNYDfW9e9ETFCzI6nrgYorhhKXqwyQCPtWntPZ+qJbhEBMOVubvZkMw0/rhZPPm8Edk/1wEfi01jiDsBhWbrdR8X3oRGMSIJpAF1ax4GKMTDIa5DKQKyuFilG1nWRSz0NfWV2OFcniMR7sV1cxy6sEP+pdnJUxtBLFHLOCocxN0c3JHuRk/fkzLdhfdTqzjV5tXE91Arx/SlfxbPZ2SfFxAyhlt7b7dW0JZyBdcGPxf7/QtFTKDmTIFfgqawBWhyRCBhcgYYI0V6LpN11VLVGbimClE0TjFW6Ay4wW/3Ivi2Wu/BVJY3HGBX74R9HUTuBPuEFqXF6i+RWV2vvywfJ8A9bXImA/O9MOIZV93reeSctIvWT9wbdxTqgvuU2yhk092ftsYIDPiCuTQDQVDhjvKruhKxL4D25Ipj3hWWU/mUs5AeZkTfhgsM4YybbgrgHmBLxAIQnW1hhMwVH3G3OdHw3VUy8Mguf9A5cvEISzYadNOp6wPOHP6F5tanpKI2YJDdE2XjKsBLTn1A0q7qpfgqwXxDtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(31686004)(478600001)(6666004)(6486002)(83380400001)(36756003)(31696002)(86362001)(2616005)(30864003)(2906002)(26005)(53546011)(6506007)(66946007)(186003)(6512007)(966005)(38100700002)(8676002)(5660300002)(316002)(66556008)(66476007)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHRVQnYwQUd2b0lJdXk5VlV2SThYVTZQTVpaK01tbU1Sc2hYeTlRbTN0Ulpr?=
 =?utf-8?B?WTZld0VnVmlJZjBCRlQrZVhEV2lOVEJuM0wrcXRtLytnNS9XUkxHYkJIZEF0?=
 =?utf-8?B?M2Q0UE5YNlpsY3ZPUXZucVFiWCtXc0xyUWNxdlRhS1UycDlFSTZHSnNCVHVF?=
 =?utf-8?B?dGY1UTcxczZyNnpaUmRjeVd4UDdlZ0ZpdTJSYkhQQXBxZkxybklSSm1CWWd5?=
 =?utf-8?B?ZzZXT25vQXNYMnFlRWkweno0YzJ5TXFsMmZKVU1MUGRBUGNEb01WdjVUNS9G?=
 =?utf-8?B?VkZtdUpSRzFFUzhLRUsxcG5VUFZOaE9jQnpSK2FrQjh5d2pxQjJFaTd2MHNw?=
 =?utf-8?B?TG5HR2Y3L2UvZENEMHRQaWYxM2laVEJxRUJ4YkdHYlBzMkhjV3VTTi8wZy9y?=
 =?utf-8?B?U3lGSDNIK0ZHUTJNM1NrUmJUZDRPY0NGc09maWFXeEdnNUxQbUpsT2kwSVVQ?=
 =?utf-8?B?RHd0YVJVSFFiS2pmOVA4TmxBMTF0eEY5ajhNLzZ0Slk2c1UzdDBlSUl3ZVB2?=
 =?utf-8?B?NGRCNDJhRXVJV1FjWjd0NzRiSmo1anM1Q3NPdjRpK2QxZU83aERVbGhSNkNq?=
 =?utf-8?B?QnNGQ3ZvNll0TmFjUFZYVmhmL2FMVVd0WUJnNW5uYWJxVWZZT1BLYjduc3Zk?=
 =?utf-8?B?cWFQRVdhTnNBVlcxY1oxTzJ1Tm5xR1gralh2RGhTSDkyc0lyQVlENXNnS05S?=
 =?utf-8?B?QnJMTFRlU3pCYTJDSmpybG5hMVFvSzRmdThzelF2eWg0cGRsbGx3ajlHblkw?=
 =?utf-8?B?QkFweDdaeUNOeHRmOTBJMUdncEplUWJKaWdIZ2FJU0xjV0gxUGNlR1FkUWh6?=
 =?utf-8?B?WkgzZTIzbXdWWGsyYWg0bk41T21DK2dJMkJNSmZWWThGMVVUQ3hKZUI1bjhR?=
 =?utf-8?B?TTJLZmZhLzYxZGJiSGlDYWtMTTczMU1kVjMxTk5FSkQ2aFY3NWthL3kwcWxB?=
 =?utf-8?B?WjNCVjRjbjI1Zmtyb3FGaFM3S3B0SXgyVEM1WVhlUGVwMW9tVHFCV096Zi9G?=
 =?utf-8?B?T1E5NjN5U0pQZy9uVmRocWRwbFRVUTcyWEhnQjBVQnNzbDlIdzVtaE1mSlUz?=
 =?utf-8?B?WFAxN1VET3NTS3BBRm5hV0NUK2ZvSVBBZHVSU25vTlhVOXhKaDFFVDBxYlJL?=
 =?utf-8?B?Mlh3MGdsb3RlclJNQjAwd1NRVmsrN3Z5UE5QSm1talZDaDMyQ0VMWFJDa3BD?=
 =?utf-8?B?TGRVN1IzTitDNUhSVUt6MmFNLys2Y0U4WWxtRUJuY1VEaHVQTUl5MDNzYUZt?=
 =?utf-8?B?ajFjbjQzZW0zOEQ2T1A1c21DM2o3bXRDQWEyaTRtbnlJblpvWlBPNFFZcjkz?=
 =?utf-8?B?WDFxRS9ab3d1NHlPOWxGdFg3eVdTaldQRjNKNkFNa1JFQ3lxb0Njd1RVRFo3?=
 =?utf-8?B?Q1hIS3pOSEVsWTdHczhYZGU5Q24yZmhmODl3d0NONkNkb0h3djVhSnlLanZo?=
 =?utf-8?B?SldqelJWb2pseFlUM1EzS1F4a3Zjc1NJMGVPZmV1S1R4UnVFenNVMkVwTGwx?=
 =?utf-8?B?TEpQK211N2E3Ky9OQkR0VUJQQ1I4cHFKYS9SSi9ibjNoaGMyekYxMHJQTC9E?=
 =?utf-8?B?MEpRZ0JJYkltckVQNXJBZm54K2tESmhralgwa0huUmx0SWdIMlRmRlRCM3Vx?=
 =?utf-8?B?c1JmdU5La1YrTkk5b204L0pjUkJOTkRnL1FBcDlhRnIydmxkZnFTZDB3NGNR?=
 =?utf-8?B?U1RLYmxmTWpBNTNqMm9WTmVMSm1SdnJUcnpQSkF2c0pMOUtZV2ZSRzB1cjhV?=
 =?utf-8?B?T2NIUkFLYUM5bVlyNjB6T3NnWnVEWVVUa2RhbTk2RTBmT2xKNitwTFZoWVp5?=
 =?utf-8?B?RVlidkpSTUtkQSsyVHcxZ2I5NWRFaGhjQ2JDSEpTUkM5WnJvKzVBaWNsSnB0?=
 =?utf-8?B?UmFzK0RDTzhZL0tKbDRwbVNuTFM4V2NCUitScGc3VGYxZzV5MkVBWU5pWk11?=
 =?utf-8?B?MGNERDlnMHBSTkJWVStmV2o3WWtPb1RBU3lwZlVxSFl3c0Zpd0Q0MTVNMExn?=
 =?utf-8?B?ek9OTnhUVyt1ZHM0VnVQSU1PSkpzcnZ5ZzRrQUlHaUdTUFp3MFByVGw1L0Vz?=
 =?utf-8?B?LzRGOTNQMHdoVkprR1B0QUJ6bTlQb3BuRmJPMHp6RkxwcnlrMmdYRHBUcSta?=
 =?utf-8?Q?T/lGd+1zjw1748Qt+o4ayRwN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab3e35-b0c3-4239-95ed-08db815e5e9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:57:31.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yWLsLxKsbqZhgY966rcb3xxm5CFyl0zae/pHrPhfVuISBl+rJivL8+A6UkR6TNAn5W6SfajAmWR4fDA5dgV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/07/2023 18:25, Aleksander Trofimowicz wrote:
> Hi,
> 
> I've noticed a regression in the mlx5_core driver: defining VFs via
> /sys/bus/pci/devices/.../sriov_numvfs is no longer possible.
> 
> Upon a write call the following error is returned:
> 
> 
> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_cmd_out_err:803:(pid 1097): QUERY_HCA_CAP(0x100) op_mod(0x40) failed, status bad parameter(0x3), syndrome (0x5add95), err(-22)
> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_device_enable_sriov:82:(pid 1097): failed to enable eswitch SRIOV (-22)
> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_sriov_enable:168:(pid 1097): mlx5_device_enable_sriov failed : -22
> 

Hi Aleksander,

This should fix the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c?id=6496357aa5f710eec96f91345b9da1b37c3231f6

Mark

> 
> which could be traced back to a second call to mlx5_vport_get_other_func_cap() in
> mlx5_core_sriov_configure()->[...]->mlx5_esw_vport_enable()->[...]->mlx5_esw_vport_caps_get():
> 
> 
>  7678.225594 |   21)   bash-1604    |               |      mlx5_esw_vport_enable [mlx5_core]() {
>  7678.225594 |   21)   bash-1604    |               |        mlx5_eswitch_get_vport [mlx5_core]() {
>  7678.225594 |   21)   bash-1604    |   0.300 us    |          __rcu_read_lock();
>  7678.225595 |   21)   bash-1604    |   0.270 us    |          __rcu_read_unlock();
>  7678.225595 |   21)   bash-1604    |   1.320 us    |        } /* mlx5_eswitch_get_vport [mlx5_core] */
>  7678.225595 |   21)   bash-1604    |   0.260 us    |        mutex_lock();
>  7678.225596 |   21)   bash-1604    |               |        esw_legacy_vport_acl_setup [mlx5_core]() {
>  7678.225596 |   21)   bash-1604    |               |          esw_acl_ingress_lgcy_setup [mlx5_core]() {
>  7678.225597 |   21)   bash-1604    |   0.290 us    |            esw_acl_ingress_allow_rule_destroy [mlx5_core]();
>  7678.225597 |   21)   bash-1604    |   0.290 us    |            esw_acl_ingress_lgcy_cleanup [mlx5_core]();
>  7678.225598 |   21)   bash-1604    |   1.720 us    |          } /* esw_acl_ingress_lgcy_setup [mlx5_core] */
>  7678.225598 |   21)   bash-1604    |               |          esw_acl_egress_lgcy_setup [mlx5_core]() {
>  7678.225599 |   21)   bash-1604    |               |            mlx5_fc_create [mlx5_core]() {
>  7678.225599 |   21)   bash-1604    |               |              mlx5_fc_create_ex [mlx5_core]() {
>  7678.225600 |   21)   bash-1604    |   0.760 us    |                kmalloc_trace();
>  7678.225600 |   21)   bash-1604    | ! 500.430 us  |                mlx5_cmd_fc_alloc [mlx5_core]();
>  7678.226101 |   21)   bash-1604    | ! 502.070 us  |              } /* mlx5_fc_create_ex [mlx5_core] */
>  7678.226101 |   21)   bash-1604    | ! 502.650 us  |            } /* mlx5_fc_create [mlx5_core] */
>  7678.226102 |   21)   bash-1604    |   0.410 us    |            esw_acl_egress_vlan_destroy [mlx5_core]();
>  7678.226102 |   21)   bash-1604    |               |            esw_acl_egress_lgcy_cleanup [mlx5_core]() {
>  7678.226103 |   21)   bash-1604    |               |              mlx5_fc_destroy [mlx5_core]() {
>  7678.226103 |   21)   bash-1604    | ! 239.330 us  |                mlx5_fc_release [mlx5_core]();
>  7678.226343 |   21)   bash-1604    | ! 240.080 us  |              } /* mlx5_fc_destroy [mlx5_core] */
>  7678.226343 |   21)   bash-1604    | ! 240.680 us  |            } /* esw_acl_egress_lgcy_cleanup [mlx5_core] */
>  7678.226343 |   21)   bash-1604    | ! 745.110 us  |          } /* esw_acl_egress_lgcy_setup [mlx5_core] */
>  7678.226344 |   21)   bash-1604    | ! 747.640 us  |        } /* esw_legacy_vport_acl_setup [mlx5_core] */
>  7678.226344 |   21)   bash-1604    |               |        kmalloc_trace() {
>  7678.226344 |   21)   bash-1604    |               |          __kmem_cache_alloc_node() {
>  7678.226344 |   21)   bash-1604    |   0.250 us    |            should_failslab();
>  7678.226345 |   21)   bash-1604    |   1.080 us    |          } /* __kmem_cache_alloc_node */
>  7678.226345 |   21)   bash-1604    |   1.570 us    |        } /* kmalloc_trace */
>  7678.226346 |   21)   bash-1604    |               |        mlx5_vport_get_other_func_cap [mlx5_core]() {
>  7678.226346 |   21)   bash-1604    |               |          mlx5_cmd_exec [mlx5_core]() {
>  7678.226346 |   21)   bash-1604    |               |            mlx5_cmd_do [mlx5_core]() {
>  7678.226346 |   21)   bash-1604    |               |              cmd_exec [mlx5_core]() {
>  7678.226347 |   21)   bash-1604    |   0.750 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
>  7678.226348 |   21)   bash-1604    |   0.250 us    |                _raw_spin_lock();
>  7678.226348 |   21)   bash-1604    |   0.260 us    |                _raw_spin_unlock();
>  7678.226349 |   21)   bash-1604    |   7.290 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
>  7678.226356 |   21)   bash-1604    |   0.560 us    |                kmalloc_trace();
>  7678.226357 |   21)   bash-1604    |   0.260 us    |                __init_swait_queue_head();
>  7678.226358 |   21)   bash-1604    |   0.250 us    |                __init_swait_queue_head();
>  7678.226358 |   21)   bash-1604    |   0.250 us    |                init_timer_key();
>  7678.226359 |   21)   bash-1604    |   4.160 us    |                queue_work_on();
>  7678.226363 |   21)   bash-1604    |   0.260 us    |                _mlx5_tout_ms [mlx5_core]();
>  7678.226363 |   21)   bash-1604    |   0.250 us    |                __msecs_to_jiffies();
>  7678.226364 |   21)   bash-1604    | + 36.880 us   |                wait_for_completion_timeout();
>  7678.226401 |   21)   bash-1604    | # 1772.890 us |                wait_for_completion_timeout();
>  7678.228175 |   21)   bash-1604    |   0.440 us    |                _raw_spin_lock_irq();
>  7678.228175 |   21)   bash-1604    |   0.330 us    |                _raw_spin_unlock_irq();
>  7678.228176 |   21)   bash-1604    |   1.290 us    |                cmd_ent_put [mlx5_core]();
>  7678.228177 |   21)   bash-1604    |   3.020 us    |                mlx5_copy_from_msg [mlx5_core]();
>  7678.228181 |   21)   bash-1604    |   0.530 us    |                dma_pool_free();
>  7678.228182 |   21)   bash-1604    |   0.380 us    |                kfree();
>  7678.228182 |   21)   bash-1604    |   0.720 us    |                dma_pool_free();
>  7678.228183 |   21)   bash-1604    |   0.360 us    |                kfree();
>  7678.228184 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228185 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228186 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228186 |   21)   bash-1604    |   0.360 us    |                kfree();
>  7678.228187 |   21)   bash-1604    |   0.480 us    |                dma_pool_free();
>  7678.228188 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228188 |   21)   bash-1604    |   1.030 us    |                dma_pool_free();
>  7678.228190 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228190 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228191 |   21)   bash-1604    |   0.360 us    |                kfree();
>  7678.228192 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228193 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228193 |   21)   bash-1604    |   0.360 us    |                kfree();
>  7678.228194 |   21)   bash-1604    |   0.710 us    |                free_msg [mlx5_core]();
>  7678.228195 |   21)   bash-1604    | # 1848.590 us |              } /* cmd_exec [mlx5_core] */
>  7678.228195 |   21)   bash-1604    |               |              cmd_status_err [mlx5_core]() {
>  7678.228196 |   21)   bash-1604    |   0.950 us    |                mlx5_command_str [mlx5_core]();
>  7678.228197 |   21)   bash-1604    |   1.780 us    |              } /* cmd_status_err [mlx5_core] */
>  7678.228197 |   21)   bash-1604    | # 1851.180 us |            } /* mlx5_cmd_do [mlx5_core] */
>  7678.228198 |   21)   bash-1604    |   0.260 us    |            mlx5_cmd_check [mlx5_core]();
>  7678.228198 |   21)   bash-1604    | # 1852.150 us |          } /* mlx5_cmd_exec [mlx5_core] */
>  7678.228198 |   21)   bash-1604    | # 1852.620 us |        } /* mlx5_vport_get_other_func_cap [mlx5_core] */
>  7678.228199 |   21)   bash-1604    |               |        mlx5_vport_get_other_func_cap [mlx5_core]() {
>  7678.228199 |   21)   bash-1604    |               |          mlx5_cmd_exec [mlx5_core]() {
>  7678.228199 |   21)   bash-1604    |               |            mlx5_cmd_do [mlx5_core]() {
>  7678.228199 |   21)   bash-1604    |               |              cmd_exec [mlx5_core]() {
>  7678.228200 |   21)   bash-1604    |   0.710 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
>  7678.228201 |   21)   bash-1604    |   0.270 us    |                _raw_spin_lock();
>  7678.228201 |   21)   bash-1604    |   0.260 us    |                _raw_spin_unlock();
>  7678.228202 |   21)   bash-1604    |   7.160 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
>  7678.228209 |   21)   bash-1604    |   0.570 us    |                kmalloc_trace();
>  7678.228210 |   21)   bash-1604    |   0.260 us    |                __init_swait_queue_head();
>  7678.228210 |   21)   bash-1604    |   0.250 us    |                __init_swait_queue_head();
>  7678.228211 |   21)   bash-1604    |   0.290 us    |                init_timer_key();
>  7678.228212 |   21)   bash-1604    |   4.280 us    |                queue_work_on();
>  7678.228216 |   21)   bash-1604    |   0.340 us    |                _mlx5_tout_ms [mlx5_core]();
>  7678.228217 |   21)   bash-1604    |   0.260 us    |                __msecs_to_jiffies();
>  7678.228217 |   21)   bash-1604    | + 37.490 us   |                wait_for_completion_timeout();
>  7678.228255 |   21)   bash-1604    | ! 316.610 us  |                wait_for_completion_timeout();
>  7678.228572 |   21)   bash-1604    |   0.280 us    |                _raw_spin_lock_irq();
>  7678.228573 |   21)   bash-1604    |   0.250 us    |                _raw_spin_unlock_irq();
>  7678.228573 |   21)   bash-1604    |   1.280 us    |                cmd_ent_put [mlx5_core]();
>  7678.228575 |   21)   bash-1604    |   2.840 us    |                mlx5_copy_from_msg [mlx5_core]();
>  7678.228578 |   21)   bash-1604    |   0.510 us    |                dma_pool_free();
>  7678.228579 |   21)   bash-1604    |   0.380 us    |                kfree();
>  7678.228580 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228580 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228581 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228581 |   21)   bash-1604    |   0.380 us    |                kfree();
>  7678.228582 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228583 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228584 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228584 |   21)   bash-1604    |   0.410 us    |                kfree();
>  7678.228585 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228586 |   21)   bash-1604    |   0.380 us    |                kfree();
>  7678.228587 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228587 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228588 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
>  7678.228589 |   21)   bash-1604    |   0.370 us    |                kfree();
>  7678.228589 |   21)   bash-1604    |   0.380 us    |                kfree();
>  7678.228590 |   21)   bash-1604    |   0.640 us    |                free_msg [mlx5_core]();
>  7678.228591 |   21)   bash-1604    | ! 391.590 us  |              } /* cmd_exec [mlx5_core] */
>  7678.228591 |   21)   bash-1604    |               |              cmd_status_err [mlx5_core]() {
>  7678.228592 |   21)   bash-1604    |   0.270 us    |                mlx5_command_str [mlx5_core]();
>  7678.228592 |   21)   bash-1604    |   0.450 us    |                _raw_spin_lock_irq();
>  7678.228593 |   21)   bash-1604    |   0.310 us    |                _raw_spin_unlock_irq();
>  7678.228593 |   21)   bash-1604    |   2.030 us    |              } /* cmd_status_err [mlx5_core] */
>  7678.228593 |   21)   bash-1604    | ! 394.300 us  |            } /* mlx5_cmd_do [mlx5_core] */
>  7678.228594 |   21)   bash-1604    |               |            mlx5_cmd_check [mlx5_core]() {
>  7678.228594 |   21)   bash-1604    |               |              mlx5_cmd_out_err [mlx5_core]() {
>  7678.228595 |   21)   bash-1604    |   0.260 us    |                _raw_spin_trylock();
>  7678.228595 |   21)   bash-1604    |   0.280 us    |                _raw_spin_unlock_irqrestore();
>  7678.228596 |   21)   bash-1604    |   0.260 us    |                mlx5_command_str [mlx5_core]();
>  7678.228596 |   21)   bash-1604    | ! 158.330 us  |                _dev_err();
>  7678.228755 |   21)   bash-1604    | ! 160.760 us  |              } /* mlx5_cmd_out_err [mlx5_core] */
>  7678.228755 |   21)   bash-1604    | ! 161.340 us  |            } /* mlx5_cmd_check [mlx5_core] */
>  7678.228755 |   21)   bash-1604    | ! 556.330 us  |          } /* mlx5_cmd_exec [mlx5_core] */
>  7678.228755 |   21)   bash-1604    | ! 556.810 us  |        } /* mlx5_vport_get_other_func_cap [mlx5_core] */
>  7678.228756 |   21)   bash-1604    |               |        kfree() {
>  7678.228756 |   21)   bash-1604    |   0.350 us    |          __kmem_cache_free();
>  7678.228757 |   21)   bash-1604    |   0.860 us    |        } /* kfree */
>  7678.228757 |   21)   bash-1604    |               |        esw_legacy_vport_acl_cleanup [mlx5_core]() {
>  7678.228757 |   21)   bash-1604    |   0.310 us    |          esw_acl_egress_lgcy_cleanup [mlx5_core]();
>  7678.228758 |   21)   bash-1604    |   0.350 us    |          esw_acl_ingress_lgcy_cleanup [mlx5_core]();
>  7678.228758 |   21)   bash-1604    |   1.370 us    |        } /* esw_legacy_vport_acl_cleanup [mlx5_core] */
>  7678.228758 |   21)   bash-1604    |   0.250 us    |        mutex_unlock();
>  7678.228759 |   21)   bash-1604    | # 3165.340 us |      } /* mlx5_esw_vport_enable [mlx5_core] */
> 
> 
> This second call was introduced in [0].
> 
> Device in use: MCX416A-CCAT.
> 
> [0] https://lore.kernel.org/netdev/20221206185119.380138-9-shayd@nvidia.com/
> --
> Kind regards,
> Aleksander Trofimowicz
> 

