Return-Path: <netdev+bounces-16135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A9D74B7AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA711C210B6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3117729;
	Fri,  7 Jul 2023 20:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB56174FB
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:12:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0289E7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 13:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0ciYwcP48d1RoDC8394KvZEEyZQgkKSjUhhWoLIP7DQW1xLNVF3ANGVB0gfJ54kjrItYnrMkCJePvqOiW1anGS1M6yP4WvOO1KNpQqSfY0ow/bFro32Vv1cJsNr0dMLAExV447ZH2c7mnn+O38/n4Nx3UKAYCF9txHEtpxcmkD1YIz1rweSUqLycVsgLfhEPTAu95rWcJl4xscs/T9sfsmZ9ofqTMpj7TLaX558lXyXn3ee6rq+ZbEs1PyyIUvjZPP2wSAHW7gbIOMOcKkUj06H9MRoTykQGfoLonK5Er6CMMqX2MEeqFr1cq3GdL+WKq6p/xjxx2yb3LpW+FIKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1E6xDSPstYvkHKd+32GjOE3+EN29AZqzq5zr6b18jU=;
 b=TuxUQtsNHU/ZrESPeGYhxK2AM9MJiovzIWrz8XLyb0ZsMELtUjMhbGhJ5UoY4VFLs4+Wtrz/SHR5uJvAXi1Wi8c9wlKfZhwliSLvjRCyoH6QavxjMie7tcra09bYWA7UW8z07SJGDbk8c9qX3OFnFVN+BuRKuBcbbo/SyqXL9+g4KIehq/+swkCbFDKDWoZLQ8GIlkYZfa/chVL71p7xp5zWP55tMETS/dGZsOGAStWe4T1S+v7hVVZvbbUtlwmyAHqG6zwc0H54zxrJBLS+436QrUkWPEm/qtCyfGi7eGJQI2EEfsP8bbcQ3wkmAhaExYXzFhgjKlrSTZmW9mzoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1E6xDSPstYvkHKd+32GjOE3+EN29AZqzq5zr6b18jU=;
 b=2u8n/sgtEgeMhugjuBLZjdaYJd5pz4fMBawLOHs1n8+XlhFQwzCW4afyaGHHdXkK1rYPIVcZKlbw9SP9SOmPBd9GCtl+BV4yg4TZb/Trm+gUte4x1zdDm9ffPMFX5HYtr18k39YS0deh5PF4CRA5lG7Tp6d2llhBCZSUnufPYFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:48 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:48 +0000
Message-ID: <155e0b8f-7d80-4d2d-a487-46ab9d760771@amd.com>
Date: Fri, 7 Jul 2023 13:12:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 2/4] pds_vdpa: always allow offering
 VIRTIO_NET_F_MAC
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-3-shannon.nelson@amd.com>
 <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: bebaf1ce-442c-4919-5c65-08db7f2688de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J5trdtJ+LjorOtv7jB5xHCN15oQ33Efjt49t5JMyZ9bYK0530FUMKBhtwFVxi5t5Mo0pPjs1oSLz5NlrDzz5NTQPWB9GixtE331ZxuyABoE7YCiQi/Na6nKgNoXeIIuuuXZbQWgx/WtvEzpV5MeW8KEZWtssZlm0/OxHoR9qYMuwCya8fMnpamt5rTRJTMPTZYroPif9N4+ZaFTtuDqb7KQuyX81VOhk95++QM0f5n41FAO8WwkNdIks6GgiioCCijzU9Me6XbfzoCNOdwlMCUbwqkNsBjPE3PVNP0CjilBGz8wezgAmbdxvs1zfljBumOcqu2FiM0HSZLUKoOQNwhrzq2K9cCPhjpBHHLL1DLQOVmEDAoO9Nl5I3J5veMQbhbwLqrlNmqXNrCY+OuH+y7bO6TJFFf55ygF3Z/jHSHOukMV510XIQgrw0orMtuD6vA+shL1KHdouCOlvd/GMENZgOzs/9E9ZhpKoS0D7XLIQJHsAtyXqpZO+zJsxGtqDzOu3LDXT9kaOJY/+S32ZQTxF+ATDTYwg2LwBNdGu62pwg/BAVSy7O2NDOrBJpNZ5mUCeicu10aLtwI1YFdbvGikZPaXrv9Kwf34Ymbk7Cm4TnynxHzHn2cRwHQuDqvhnJ9dZDKubkkfFgciA1gyazw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjlCcnJ1Y2FhOU1uc0dVZk5PbWVvb2lDQVZBM2NVZXBYNXEzWlBVK0E3akJ6?=
 =?utf-8?B?cTcyWll4QzQ1dllDWkFMWUx4MjZDOThRNXVUbmdsKy84bENMcHB1bkZtYi80?=
 =?utf-8?B?dFNETjhYUmpmQXp1QmZsY2ZXWEpGQzhsaEcyOGpWU0dEeTVCRnNyc013Njhp?=
 =?utf-8?B?U09oYVZkL1RiSUVPdnlYazRvNkwxNUtEOWNQMHZSK2NGVmRldUJseDVQU1Fi?=
 =?utf-8?B?U0tTK05hU2JQMnBjR3lscnJMSEpMWVVod1FBT3VtOFVlVHdITjdhb3pKOWxh?=
 =?utf-8?B?NlVBV3BTN1R6SXFwRUFrT0FIcmxSaGNuNU9hWjZSaDlWbkxIYVJSMkVzcVFF?=
 =?utf-8?B?V2t3SUxtMm85KzJNR1AxM3pVdFVUZlQwcjdJc1RJR3Z3Zy9rc1h0NjMwZFY4?=
 =?utf-8?B?WktTa0V1Qm90WTJSVDg5NGlQQk1xaEJrYmpzSm9qRDRWOTNyVlNYczFhWmNl?=
 =?utf-8?B?QStWK0NESnpSZEhjK2VGWnFZMDBEbjBrUUhnRWEyekZRR2VJT3Q3T1pJNHIz?=
 =?utf-8?B?ZnhXb3dON01mU1FVajM0aTRnUzltaC9hUXMwNUN6RlJvcXRYRHJlaW5RRVpo?=
 =?utf-8?B?S2VBMnVXNFRmRGNUNi9vSnI5ZHYyNllYZmE1cDE3TlZBdkVYbHdYWUdDMEg1?=
 =?utf-8?B?K3RhTWZqaE52Mm11MGtGeTRLQjJQTUFudjVOMnFzeThYRnV0alZsc3RVd1VP?=
 =?utf-8?B?TFozMjlBTnNwN0J0eGJIL1VSUDRTdHZnTjc2T000dEZBU2lqNjE0NmFKYWxu?=
 =?utf-8?B?dTZ1SlJKM3BmZjAzT2dMZTlRbVV6QWJBeDg0ejNNVzV3aThtYVZvbzRaQWwv?=
 =?utf-8?B?SnRLS3AyQi9JVmdKanlTMXRWRGQvUmZWeGcxTGFCcCtOTzlUTzU1dlowSGc3?=
 =?utf-8?B?bjBRaFgzM0IwYnFidkpaN1RuY2svVy9UcGcwL09ETTRVc1U2cGVZSWEyVHda?=
 =?utf-8?B?aktTd0pmcWdIL3A0WXpQNnlWWlRobitGaWZjQXV1Mk53WkJIOVFnRzFtVDIx?=
 =?utf-8?B?cHQrL1ZOcngza2MrTmNVQjZUd01VVTN2N1JDdUdPYWJUVUwrWjNvSFIzYkpJ?=
 =?utf-8?B?d1ArejdLN0xKV2FheXdJWTZESHBqNnBWcG5zd3ZYS0U0bzhrS1BMejVTQmJn?=
 =?utf-8?B?SEZ0VGxxNkVSMHV3alVnQ2tmNDB3d2hEUGZUSW1MU3dwdEZQOFZJaXRqN1I1?=
 =?utf-8?B?V2NETE8yZXZNd3BIcnFZMWU1Y3o5d0Z3YjFhZ2d2WlE1bGVxZU5iMjJhR1Mx?=
 =?utf-8?B?M1k3V08vWEtXalFOMlhCd1M1alJPdXdIclVWL3BDRnVTeUJFeUwzYTBCMlE1?=
 =?utf-8?B?S2pDVE04Z1dYcjJSZGVjdE9uZ2xKYUpxeCt3MnZLK1BvVFl1WVVrNElkQ3p5?=
 =?utf-8?B?ZTI4a2ZqaER1V0dUNXFJY214S05BQWtoems5N2Jwc2tZcklucVVmYlRCQkEr?=
 =?utf-8?B?bGxKRllqVW1VODZ4Tnl2Q0NMc0J0bjQrc1VEV1NURU5KbVA3N3VwU3hoY25v?=
 =?utf-8?B?UnUxWkJsVlpINSt3T0h1OWs4dkhiMlhhZUM0SHg3bDlPRTVCQk9RMDYrWkFT?=
 =?utf-8?B?T1ZnTS8zRi8vRGtUSG0zeTQxTHJDT2FwVjRRbWxEQiswYmtNNWswdUpIelBV?=
 =?utf-8?B?aVBSRExDQ0xabmtQSTkrLzFXQUxJM0tRQTgxaGk4eHV2aHhlVnloRjRPQ2sv?=
 =?utf-8?B?NHhja0E1SXB0WFJYK3I4dkVialFlOGdmQmc1WnY1S1Q2QTNQenVMcjN4dk1Y?=
 =?utf-8?B?SVVLWWcycndhQWI3QkpxNlVwM0I5aFh0bTVNMHR2b0ZQZStXbDM0NG8wcC85?=
 =?utf-8?B?TUJqNW1CQ2VZVjZsTTlMMkkrUnNaZER3Z1MwSU5DUnA2djRYbVpxUkVEVlpM?=
 =?utf-8?B?L1A0OHNUTzNETTFHYnVpZ29NR1AxeHROYzE0TFNDSXE5MDNpMVpkSExJc2xN?=
 =?utf-8?B?Tjg5dFVCajdObnJGRmRNNFJiSkZab1g4RTB3QTVZdVRpSzRCYndVWGVYY0Jm?=
 =?utf-8?B?Mk5zdmJjNVhaS3RFQ0lKUG8zRlFSVUdxMTdLYUQ1M3ozTTZ4dmcxaldOcU55?=
 =?utf-8?B?VnlNY09IRk9BOUJ4NnNkUVYvSitVeEdQcUphSUxyY2VEdFNBOWl0TnM1V0Vj?=
 =?utf-8?Q?zWwyLWnKijdqZAI/pnIoXAKbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebaf1ce-442c-4919-5c65-08db7f2688de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:48.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceHq0CRJWkBA8jXQR/jJCdCP99gTewkLVRAiizFVALWYy5xwQUi7TuzaF0TW92lgOP/V0tDH0SYYnLB3CGSAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/7/23 12:44 AM, Jason Wang wrote:
> 
> On Fri, Jun 30, 2023 at 8:36 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
>> Our driver sets a mac if the HW is 00:..:00 so we need to be sure to
>> advertise VIRTIO_NET_F_MAC even if the HW doesn't.  We also need to be
>> sure that virtio_net sees the VIRTIO_NET_F_MAC and doesn't rewrite the
>> mac address that a user may have set with the vdpa utility.
>>
>> After reading the hw_feature bits, add the VIRTIO_NET_F_MAC to the driver's
>> supported_features and use that for reporting what is available.  If the
>> HW is not advertising it, be sure to strip the VIRTIO_NET_F_MAC before
>> finishing the feature negotiation.  If the user specifies a device_features
>> bitpattern in the vdpa utility without the VIRTIO_NET_F_MAC set, then
>> don't set the mac.
>>
>> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   drivers/vdpa/pds/vdpa_dev.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
>> index e2e99bb0be2b..5e761d625ef3 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.c
>> +++ b/drivers/vdpa/pds/vdpa_dev.c
>> @@ -316,6 +316,7 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
>>   {
>>          struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
>>          struct device *dev = &pdsv->vdpa_dev.dev;
>> +       u64 requested_features;
>>          u64 driver_features;
>>          u64 nego_features;
>>          u64 missing;
>> @@ -325,18 +326,24 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
>>                  return -EOPNOTSUPP;
>>          }
>>
>> +       /* save original request for debugfs */
>>          pdsv->req_features = features;
>> +       requested_features = features;
>> +
>> +       /* if we're faking the F_MAC, strip it from features to be negotiated */
>> +       driver_features = pds_vdpa_get_driver_features(vdpa_dev);
>> +       if (!(driver_features & BIT_ULL(VIRTIO_NET_F_MAC)))
>> +               requested_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
> 
> I'm not sure I understand here, assuming we are doing feature
> negotiation here. In this case driver_features we read should be zero?
> Or did you actually mean device_features here?

Yes, this needs to be cleared up.  I'll address it in v2.
sln

> 
> Thanks
> 
>>
>>          /* Check for valid feature bits */
>> -       nego_features = features & le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
>> -       missing = pdsv->req_features & ~nego_features;
>> +       nego_features = requested_features & le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
>> +       missing = requested_features & ~nego_features;
>>          if (missing) {
>>                  dev_err(dev, "Can't support all requested features in %#llx, missing %#llx features\n",
>>                          pdsv->req_features, missing);
>>                  return -EOPNOTSUPP;
>>          }
>>
>> -       driver_features = pds_vdpa_get_driver_features(vdpa_dev);
>>          dev_dbg(dev, "%s: %#llx => %#llx\n",
>>                  __func__, driver_features, nego_features);
>>
>> @@ -564,7 +571,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>>                  u64 unsupp_features =
>> -                       add_config->device_features & ~mgmt->supported_features;
>> +                       add_config->device_features & ~pdsv->supported_features;
>>
>>                  if (unsupp_features) {
>>                          dev_err(dev, "Unsupported features: %#llx\n", unsupp_features);
>> @@ -615,7 +622,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          }
>>
>>          /* Set a mac, either from the user config if provided
>> -        * or set a random mac if default is 00:..:00
>> +        * or use the device's mac if not 00:..:00
>> +        * or set a random mac
>>           */
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>                  ether_addr_copy(pdsv->mac, add_config->net.mac);
>> @@ -624,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>
>>                  vc = pdsv->vdpa_aux->vd_mdev.device;
>>                  memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
>> -               if (is_zero_ether_addr(pdsv->mac)) {
>> +               if (is_zero_ether_addr(pdsv->mac) &&
>> +                   (pdsv->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
>>                          eth_random_addr(pdsv->mac);
>>                          dev_info(dev, "setting random mac %pM\n", pdsv->mac);
>>                  }
>> @@ -752,6 +761,10 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
>>          mgmt->id_table = pds_vdpa_id_table;
>>          mgmt->device = dev;
>>          mgmt->supported_features = le64_to_cpu(vdpa_aux->ident.hw_features);
>> +
>> +       /* advertise F_MAC even if the device doesn't */
>> +       mgmt->supported_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>> +
>>          mgmt->config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>>          mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>          mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>> --
>> 2.17.1
>>
> 

