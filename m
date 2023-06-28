Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58557417FF
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjF1S0Z (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 14:26:25 -0400
Received: from mail-bn8nam04on2063.outbound.protection.outlook.com ([40.107.100.63]:9728
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231181AbjF1S0Y (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 14:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYRpj54eQ70uKJNIwAaL+4CGwFmVGS5WxCjLxjNm5AigOEGHL37kqkpj47GQFbwZjlzA+oUlmZoc2YL217mFyUl50JNlpoNJj8GT8umpmgg6/UGuAQwDgYmUR5/f7d1ZwlyXei7RkyLvaHg2RxvA6rXefFbltBSnb4e2fV4PlY+a8OXLO50cmBBLbw08rBuq84zPDJxghN9H9MG5uoLmh5YRb+8ovUmexOGCagu6vdIpFR1nhXW1+34dqykb6AYrb3rg+ZNfqfRb8LfheBMsk4W/gNes+FVDjjek9leegqhqBvUD9u/r2eP4jLKG7BKKFTfgIy4R+l7QQas0Qwly6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh39s4IuCaNiVtby+iITS57XzVybgP/Ubstg/K/xdW4=;
 b=Ck/BWDQpBg8aawiv7htabOsyPvi9IhRumccjpuTYuIECvSynhPYriYqdx1U/xiVP/VUin6NEaDfBMjnP5XETMbLNrpJJ38b1/Rzu0X+nbfiTf1xip/V797f7w2OMDyykNfu14VEATvHNK54b6ycdRnwrtDgJDA/jwnn3WykX/6yxNCD7riNyNHCCUQv86K6nBsizz7x4HWT7CaOgjYJVn/9UAscU6ZP4PIPFCSdZlP54Z1UMjbB8Wg2ZRW/N17CMVho0xbHeiKwn4m0XPByDG8LM57Y5fbX/jbqgagoB0+5Mi2Diyqf2AHje7Vb2MxZkxXEv5tXUXErv+2JbpfMcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh39s4IuCaNiVtby+iITS57XzVybgP/Ubstg/K/xdW4=;
 b=Hhg/fkAM3FFqrw839nki6EmNrsmIrMvc+xjPQhivpWsnmO1DMYiZ8B4FK8sr/yPBvuCW4y2rCuhxPfSWIvkhM7c+nfHam7oRzH3kgGAdYZFfNpr5Sifk5Eu1NVaP1bV6DHqQ0qpSlJ+MR2Y6ig5Uxh98hCueuTBF7F54WFhs858=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 18:26:21 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 18:26:21 +0000
Message-ID: <1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
Date:   Wed, 28 Jun 2023 11:26:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Content-Language: en-US
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
Cc:     "brett.creeley@amd.com" <brett.creeley@amd.com>,
        "drivers@pensando.io" <drivers@pensando.io>,
        "nitya.sunkad@amd.com" <nitya.sunkad@amd.com>
References: <20230628170050.21290-1-shannon.nelson@amd.com>
 <CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbbdaf3-96db-43ff-38bf-08db78052c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCO7XAoBGTZ8tefn8sa6j9RDr6KddnvO4BwkhIcx42Cn2RZKHzfhHJDcZLfwmEb0BULTsAd79PSnZrKo8kUaZLwVapvQJFVEtZ2LkoXGEFUD4WHOyFBhLvCWNfXYOu1/7Zk+KY3pWQODQAc1ehDqRbCPZ4mnEVC9uv3+zy5pjGWE3ERxYukI16lSE1uMurK1SLJU52qaj9rJiJ/2RoHdSeviGDHfw+pbUSpdqhXBFLeEWXqFEimoKRpFk5fE5LoYmUJNqxS9ZV0ikgtnVPySrUB46ZWvooX0ASDi5b8+LUbILPtPH2Z4/8qAC82WpEp1la5HYz1TAGUhOVCVEdb5f9VrJVWqSupHR4Aorn5oQWh2d3OrZTJEXiF2nXdu5BSGEbJM1EpkA9H1iduKOzALgcaInW5pnQDl3+h4nFDFcfavmXQUbNo7mTmxofYDr4DMjEUXUAgeThtcuVfmQlVCX/2kCf+eMO/yXot540NejJXB3v6Z0R8dhEgPPNF/rIBBjaVy9XNzhdz3n+bZt++QI+J9KJ7z2AGvrPK/PUxYga6CmqBekut6cAPv0jHK5LGiuzVO3c6XjL5EooBh9eq5VCqIlS/BxIb4mXfGNfDX+rAv39NykEwhxza8KBgmYapAdGcyJWipF+BosfiD3ppcTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(53546011)(966005)(54906003)(6486002)(6666004)(110136005)(83380400001)(26005)(2906002)(6512007)(2616005)(478600001)(6506007)(186003)(5660300002)(44832011)(36756003)(4326008)(31696002)(316002)(66946007)(38100700002)(8936002)(66556008)(8676002)(86362001)(66476007)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRHWkhUTW56TDNRYXVrd1RCU2JUb3RISE9TL1hiMFJMeUl5QWJkOFRZQnlK?=
 =?utf-8?B?R1kzbU1XNHV6dW5TbUJoajhoSzIxM3VSZ0JEVklhTHVMMzhacGlvV3l5NDdj?=
 =?utf-8?B?R2M5ZERRek01ZU9Cd2NuVkF6YWxDMDliTGZOc2VSaHpPWUNrUzgwT2FwWDh3?=
 =?utf-8?B?NXZLZk9DNUhTT0IybFF3RW9PZVVlSDd2bHk5YjdUSnEyT2dWVFBYSHB2d2Nh?=
 =?utf-8?B?Rk5rMUdSUkpaOGowU0hOWEVtc0Fhb3gyd2lFT1ZnU3hJWklBSkdpVWIxS3N5?=
 =?utf-8?B?WWh6aGRjVHVBUUt2TDkxVmlnWVJXcVJHelZKUWpacDAxVWYxTHdUdWlVVUtn?=
 =?utf-8?B?b09LQnhuV2d2aGxicVV6SnNPNjlxU0xHZGVkNURaNzh3QVg4NEZvaTI5S3Bm?=
 =?utf-8?B?TU91N0VvSzBPN1F5SS9pNHFWRzRLbFZrekRVWEYraFRwOWZmVFRvYXdiYUhI?=
 =?utf-8?B?c0tIcGJmYjVnZHBmOUhwSm9xSFE0SmsyVkZVT2d6TEZTNWczYUtPUnhoOElu?=
 =?utf-8?B?blhGVjNONStYM2lhY3B1T3YweUhnbi9SRlhaNFpORFNmMm52Y3ZxYUNEcnNV?=
 =?utf-8?B?MzFlU0JXWUxHUFo5WGpJOVUvOGFYcm04cjg4S2Znc1lvSW01VGZrR2kzM2NG?=
 =?utf-8?B?amVwVnY5bnl0MjlDR1FEbFlJOTE2SnhnUDRINU5BNlV2bmNRZ1ZSakxxQTBh?=
 =?utf-8?B?QXUyUWhJZGhKWU52S2pSQmk5MytvbjR0TWsrVVdkcjhnOStNdFo0WU9INkI3?=
 =?utf-8?B?dm9hdFc0cnFTRC90STF3NWcwRmREV05vUmFEMVgyL2IzZk5DODcyRXFpSFd5?=
 =?utf-8?B?M3E3bzgrMS9zT0d5UVlaSnVBck80YWpnbCtRV2tRdmRwcWRBMDFMU3k2VFFz?=
 =?utf-8?B?SWsyR2laOGdYWHhBQ05wMVVpd0Q3MlRvbHRreUJ6Rmp0SUlpMjVjL1J3djZN?=
 =?utf-8?B?ZlBCZUVvNWczM2VlMDNxblBrTGxGOW5lRFd3M2ROK2FLbEtLTWF1b1hmWmpy?=
 =?utf-8?B?Ym1qOXBOQ3RqVmE4a0ZNbEUwL09HQmVDYkx0WjlCNFhWSDZvcGRsd0N0d2J0?=
 =?utf-8?B?NUx4bjhJMVhVK2NSOFVhdmlwTnVFelhEV1pBUDVJTnY4b3pJK04zTVM2cUZ3?=
 =?utf-8?B?dmhiKzMwcU5JZzJDU2swRFUva2Z6K24zcmJBMEVyR2o1c1JuVk82dlpTNDNa?=
 =?utf-8?B?b0ZnREFSeXpKUGVydGcreDNGYkNraU5aOUIwTUx0bi8vd0NjVk9DSjNCVWtu?=
 =?utf-8?B?QTVnVzBicUNvci9jVE1iYTFqbzU1SGYzaExGYlR0S05Cc1o1UGxaRnhvWXhW?=
 =?utf-8?B?blRQZkJJeVRJTVIzajVPc3VtK2FWWFFZazNNUFhHY1dJZWtNbkc2b2RVd2ph?=
 =?utf-8?B?TWlwY0FNWEppa284QVFmZnN2TXNYYXVjMzVBZWozc1EwVk5oaEdkQzJ6b0dD?=
 =?utf-8?B?VGNhcm1WSU96SGpBMnBYYjd6d09uNWRLcTQrR2FXZ2FuL2VBekF2eFpkbkUz?=
 =?utf-8?B?aFVORmdRcSs3NUIyN0piYkFsZUJTbTVrWHh4L0swS1FVZTFlM2ZVUVJxb3cr?=
 =?utf-8?B?Mi9Ldko2clgxSW1RcndYSjBQYmx0T24rWmpncFVkYmU3KzFYSFoxTVRGSmlE?=
 =?utf-8?B?MkZndmI2TUhOT3RpVC81bWVrbks4ZTdQazg0ODY5bHFsTEFxYkw3MmMwYWNR?=
 =?utf-8?B?dzcyc0Z1K21XWFpueUhwdTBpZ09VYjVKQVhraHp0N0NSK3dTT3drTGlSVU14?=
 =?utf-8?B?UHVkeEJhbGI3aWU3TGEzV0JGTmNkQXQ1NEdDMlhMTkkvSlo0WEZFQU1tVDh6?=
 =?utf-8?B?NGRQYVBXSG5FcVVJaVhuM3RsOFB2RW1NUkFDaTJoOFpiaUJjWGZYbjhQaFhN?=
 =?utf-8?B?akZjQXpIMFBybGJtMGFMcmh3ZTlORloyd2E3TlBtd1NMR0dpWFAxUXBIbG83?=
 =?utf-8?B?eUpGcSs3M0E1TXUxdjVhUWhTd0ZINTVMSTVYUWZVbW15NXd2enlkUFZqYjZH?=
 =?utf-8?B?amZtTkhPeWJUZzd4bitsVytDV0VxRWtJbUU5RmRqZkpmWTR0cjZDRDdUMUVk?=
 =?utf-8?B?TkozZW9temFQQVN5NWtTMDdxWGs4SnE2U092VTFzN1A0dzlVQUpKSmorRWRj?=
 =?utf-8?Q?ClX788Rk7gqCjkAYR+abEFof8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbbdaf3-96db-43ff-38bf-08db78052c17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:26:21.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NqOLPv2lwxRK8K4VN3VaLPzKOjML0mmPGEOwRW83XjrPzsRcddHhOb7fhdzHyEhh21Z9mi0tqYobEgWWWqtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On 6/28/23 10:57 AM, Keller, Jacob E wrote:
> 
>> -----Original Message-----
>> From: Shannon Nelson <shannon.nelson@amd.com>
>> Sent: Wednesday, June 28, 2023 10:01 AM
>> To: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org
>> Cc: brett.creeley@amd.com; drivers@pensando.io; nitya.sunkad@amd.com;
>> Shannon Nelson <shannon.nelson@amd.com>
>> Subject: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
>>
>> From: Nitya Sunkad <nitya.sunkad@amd.com>
>>
>> Remove instances of WARN_ON to prevent problematic panic_on_warn use
>> resulting in kernel panics.
>>
> 
> This message could potentially use a bit more explanation since it doesn't look like you removed all the WARN_ONs in the driver, and it might help to explain why this particular WARN_ON was problematic. I don't think that would be worth a re-roll on its own though.

There has been recent mention of not using WARNxxx macros because so 
many folks have been setting panic_on_warn [1].  This is intended to 
help mitigate the possibility of unnecessarily killing a machine when we 
can adjust and continue.
[1]: https://lore.kernel.org/netdev/2023060820-atom-doorstep-9442@gregkh/

I believe the only other WARNxxx in this driver is a WARN_ON_ONCE in 
ionic_regs.h which can be addressed in a separate patch.

Neither of these are ever expected to be hit, but also neither should 
ever kill a machine.

> 
>> Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
>> Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> index 7c20a44e549b..d401d86f1f7a 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> @@ -475,7 +475,9 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
>>   static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
>>                                      struct ionic_qcq *n_qcq)
>>   {
>> -     if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
>> +     if (n_qcq->flags & IONIC_QCQ_F_INTR) {
>> +             dev_warn(n_qcq->q.dev, "%s: n_qcq->flags and
>> IONIC_QCQ_F_INTR set\n",
>> +                      __func__);
> 
> What calls this function? It feels a bit weird that the only action this code takes was in a WARN_ON state. Definitely agree this shouldn't be WARN_ON.

This isn't the only action in this function - after this 'if' is a bit 
of code to link the queues onto the same interrupt.

> 
> WARN_ON is something which should be used for a highly unexpected state that we are unsure of how to recover from (even if you go on to further protect bad accesses in order to avoid completely hosing the system when not on a panic_on_warn system).
> 
> This change makes sense to me.
> 
> Reviewed-by: Jacob Keller <Jacob.e.keller@intel.com>

Thanks
sln

> 
> Thanks,
> Jake
> 
>>                ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
>>                n_qcq->flags &= ~IONIC_QCQ_F_INTR;
>>        }
>> --
>> 2.17.1
> 
