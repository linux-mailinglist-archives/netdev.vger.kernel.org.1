Return-Path: <netdev+bounces-17267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB288750F2F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E7F281AAE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774420F85;
	Wed, 12 Jul 2023 17:02:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1214F6E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:02:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D41703
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7YAEIgAvCxnmE1i4xQi5PNe5OxvX45HAAO+zt3rDHzQtXB1EzgyWo4+bv9N5Uk5r/Jen5Rmx8SgXLxmPH5bDboKrp5EvuyjgtieQhJyAUoA5z/LCmWvExsHkPiaN2gUj+J3cWlYGr+zUg2NjIMrfzKKKm6frrCYrZ+EIeoQikwwRSi5aHkpCLdr6fnOJKzII5yvDKRPagGp4FhcsmfGtUV9KamyA4nevPvtiG9EukFsdesejFUzEbAPGObihDMtZ05xM/HNV/SisdQZhtDMrSuT0jVmAVBr/wup4oL3DulSgBR7uHQD69GSPfzcjI4AegedWwcDH3ADywrKoLp6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF5vc/ZZ1lSwd4nnyaagp6kwPCe0ApZ2hcjeB04/PN0=;
 b=PWTbFmaDCy3HLnqMAE0YDAgAkn4QLvUPQKXvYLGQDCbxjqnQDMbhrlvggvPPGkUgokKJuyNSvPZ1LR9YVuyeal9JUM8+sBum95S92F6wIImiqAl9bqLdb9r2YOnK8YvX30BOnEFos+gUgTRns0s/Ss/Vig+Tfp92vIf17bgCeAnyIxtKouu6qay7Y0TTFO8w0I8MV4YpW4hkXJEai51qs7Bcv74F9NVHgWn7u40m6i7nf7J4pQkltbX/kIxhcRBqMrYD+hU3moWAeNfmKPnPJvxZduL5FBHAwJfP08aZMEK2nw4jWOKQta3cPz3FXF2+MoQBK3jcV7l/DXNgXmVntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF5vc/ZZ1lSwd4nnyaagp6kwPCe0ApZ2hcjeB04/PN0=;
 b=2QELbUXwH73FCBxNdaGvI4JO8FusquX+unhZLW7qJh8naft4fNSssw/Qot8I0OjcasPx9UQQO45/k2u6Dpkgd+d5YIlUKGQyxlp/4LB4WnQHV/w8fZzJcjoqmGZpDFVoxQI47tGzKhxKBYg+se4EmZVXp+AmUjWdnAtASYcBds8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Wed, 12 Jul 2023 17:02:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 17:02:45 +0000
Message-ID: <091345df-9563-9c37-5efd-5df19e2acca2@amd.com>
Date: Wed, 12 Jul 2023 10:02:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 5/5] ionic: add FLR recovery support
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 brett.creeley@amd.com, drivers@pensando.io
References: <20230712002025.24444-1-shannon.nelson@amd.com>
 <20230712002025.24444-6-shannon.nelson@amd.com> <ZK5r307SRIBUfpgF@shredder>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <ZK5r307SRIBUfpgF@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9e2b07-67a5-4f1c-b86f-08db82f9d03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XN2zfK4yVeeB9Samxu2VY9lwV7DzKhhjz/PB5i4DZ9MFvAqCTQ58+y+F3xQeGopHKN7ToNWVc2UM7G6mp6jJWU+5gzAsyslYYxPhBpsWhTWyI31dt+ph4rdTqtORy7HL1rqTEHPAbsfNh+EpwBhFgtaEqz7mCNHMxsN8Mhqcpp7nUp4SUFfpm1cr6JCc5eH8SPIXND9wsnKM9si1EIvehTwVU68z5rrgSvQshcjAi21jmnV7rO2kCcyfKGotQJRSXRnQNeYY6SSGvQ2V9cVfbuEWZDqNGRCClyHv7V0wsSCP75z7gp9IMQzISzT+B7yFEWpMR1JZN0XRdN0R9CEih7LCBC1biGAEItJYzUf5Fj9RgB8xB6mgvg+5XWgKrX26e5JcxJBA5Jd2W4e//948p02LWfF8HYaoitox+SECumfryLuPtaRd0htNg5UxGnqBRZSaYHTNx+DmRgUomRDfPQYF7AEDI296KMsZAy82wxJd7hH5dpC5mVK4UaXXG6tDXMYuR9/iR9pfaUeTVeI9QcnV1xXh/0S4HjcwOWIIdpWxkZnhou4B0NIb/xTqar2XRziM/GgFZVhR/0IX4oMgnwpmXboJTaRpj9mE2Io8gke7jB4q73QhdeID79KLYlRrrS8NWesCUiwCf3asM4KJ3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(2906002)(478600001)(36756003)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(44832011)(316002)(66556008)(66946007)(66476007)(4326008)(6916009)(31696002)(83380400001)(31686004)(53546011)(86362001)(2616005)(186003)(26005)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNJeGwzY1BWb3R3REJuNWRMcmFSTHU1Y0t6RURmaTZCcGZiUXdJY2trY2Ns?=
 =?utf-8?B?SHkxVExrN2JmU1lJUldnUFF1aEtsOEpxRXcrMmM0UWsvdnNkSVFHd01NY3JF?=
 =?utf-8?B?cWdSQWhTbkRTYzVBUzRHUWoxRTNsYkRXSnJoRFBhMkFXQS9wRm1kYjRmaG1M?=
 =?utf-8?B?bGhmOG83MDQ5MG9xRjh0NWd3eFVPVnl4Z2Ewa3VyS2Z6QWFKQ1ZZT0szalFC?=
 =?utf-8?B?bnFWNHBLdldsbGdPYTVadUQvK244dm5xYUx6ZFNYQTBsOFhTODcxQXhGTnJH?=
 =?utf-8?B?ckVaUEdTamlaL2czUFdPQzZ4aWJacWFuVTdPM29pSGNMbGttMUJpcUp3ektm?=
 =?utf-8?B?dzZnY2xCdm9UalA2emcrcmgyME50bm5WMlBUaG1ZS1VhZDVya3dZK2VuOGtC?=
 =?utf-8?B?amoyamJDcmY5ZmVTdDlleUdBYXRIWUZjTEpQRXpWMHA1a3kzVDYrek8yQTA0?=
 =?utf-8?B?OG4yR2pBT01pWERGc2kveWpkWmE4NkxoT28vZWc0eUJYNHJjV3hKRkZBZDFU?=
 =?utf-8?B?TmtPRHFLeHlGU1F6bGJBb1hhT3E0T1NvcHFVbkQwbExvcVc2aDNhMUNmZmJC?=
 =?utf-8?B?RFRnaUJ6K2kvclJwcjJKTXY0UHN0TzMrdGhiZXhkNU9haVAzaDlBT2FETXYy?=
 =?utf-8?B?R3BDb1piTlVvQ3lvem1xUFZLVVN6UDYwS2FYdTZoZVBHUXMzMEIrWVFBYUg1?=
 =?utf-8?B?UUdjbjhNY0dBMWloeGJzNUJBVUErNk1HUXAzQytvZHV6TnE1TmZwYUtRdTQ4?=
 =?utf-8?B?S3ZsR3FjdkQrVkxleHFSNFppNEZWWm02S0QrS1k2L1RocnFCL1hGYnlvamZS?=
 =?utf-8?B?ZnlFbDZNaVZPV21HRXNLNERDeVU2N1VuUmJzNEQyaTM5OUNIMURQbkRYY2dK?=
 =?utf-8?B?bWpycTJrS1JCaXc2ZjdiaUIwd1FHcE5MdHlwWjdlSC9ld1R2aitPZVFDak9y?=
 =?utf-8?B?VmtrSktTWUZibmJmczBWTUFyeEl6YjJmODBicUVoNzJwcXFYWE1WWW9DL0N3?=
 =?utf-8?B?M0htOHFCU3g0dlg3K0xpUFpzVWZNTEVOci9NdldoNzhablhhS0srdEVkWU9t?=
 =?utf-8?B?WDVEeUFKQUE1LzJDZkRvbisrTUF1OEhTVit3d0FFazRCSXFtcXl4NnF1cHB3?=
 =?utf-8?B?TEFwdzFMOXBTZDFJQUVkZ2h4R0hUWXg5ZllSUnJLUHg5bVZFemtBYmdGcnRU?=
 =?utf-8?B?Rkpnb1Q3aGhvaTlNeUUwSlBIUVNzY3NJQm04TGk2SzVUajlmTW9GL0VzYjJJ?=
 =?utf-8?B?M3BWRkhZdHY2WGpzbU5YRWl2Z1MxMTBvOSswcTJOV2xkN1U2Q0tOSDNGZlBt?=
 =?utf-8?B?OHErK1hqYUU5VEJaOWVKQkl4WlFXZUFJTXJiSWY4elRNZlhzeTJhNUZQSzhU?=
 =?utf-8?B?OUR1WGdnNkVNSjZmMEVpSmU1Vi8rd3QxY0I1SDVpTGxWZDE5bXl6Z0tweTVk?=
 =?utf-8?B?N0pXdnFMSFdXWkNSeGVHNWloNm45cTR1WitYN3lrS2svODMwcWQ4Y2tERXlX?=
 =?utf-8?B?ajk5UlE4UVRuUEFvT1UzYlhWOFZqUWFWY2cxdmMrZGY5R1ZNU3Q2QjUzYldZ?=
 =?utf-8?B?U1RCSHQrVW1iQ3c4Sjd0ZEpWeERwUTRrbjVwOE9JSmwvS3dMY2I0ajVOKzZQ?=
 =?utf-8?B?R0JwSEhZR2tnOElxSFBqZG52WEpvVFlSeDZPbXpIZWx6c0MvY2pDT0p5S3k5?=
 =?utf-8?B?c014TWRGQmV4UGxCMzhlU0NGMCtNaGZCR3hzNDdnVWZOUCtPbHR4WCt3WGJC?=
 =?utf-8?B?V0JCbkxtQ0crbjVNby8vYWczbENJRks5ek9lamd1OU5Hait4dlpaSHp4enEz?=
 =?utf-8?B?NER0R0dOZm5yVzhtQ0N3WmtyM25yRDdUbVdSTU42ODlMMTRMWlBtcDZrRnVT?=
 =?utf-8?B?QmpFaTdqWVlsMWI5a1dNT1k5eThMQ1lGWUVuWFNRSlVJZWlpUTlETGhxTzVH?=
 =?utf-8?B?a05MdzFOWnJHMWc4RGxxV1ZRV1dZZjlrRmRFQmN2aDlKMXBPVjh6T1JSbFcz?=
 =?utf-8?B?UlFPVTB4cHBkdDNHOEYyaEZvMU9Xc0FvZmlCdFV3aDB5by9KL2RNYTJJcjJM?=
 =?utf-8?B?R0VFMWd3UElrcWlseXdib05TL3RrUitvNUl3R1ZyNG5zYlk1aU9GZFJqOWZE?=
 =?utf-8?Q?UP9moSWPzyZzzCeMd8zb6DK33?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e2b07-67a5-4f1c-b86f-08db82f9d03a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:02:45.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sFkNvfp2eTIp77cS45c5OLh7BsKYB/RR7aG2Grs6KhEufZGo0cX5hagD3Ad0RoGJ26mej3SjhBqiK09hBUj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/12/23 2:01 AM, Ido Schimmel wrote:
> 
> On Tue, Jul 11, 2023 at 05:20:25PM -0700, Shannon Nelson wrote:
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> index b141a29177df..8679d463e98a 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> @@ -320,6 +320,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>        if (err)
>>                goto err_out;
>>
>> +     pci_save_state(pdev);
> 
> Can you please explain why this is needed? See more below.
> 
>> +
>>        /* Allocate and init the LIF */
>>        err = ionic_lif_size(ionic);
>>        if (err) {
>> @@ -408,12 +410,68 @@ static void ionic_remove(struct pci_dev *pdev)
>>        ionic_devlink_free(ionic);
>>   }
>>
>> +static void ionic_reset_prepare(struct pci_dev *pdev)
>> +{
>> +     struct ionic *ionic = pci_get_drvdata(pdev);
>> +     struct ionic_lif *lif = ionic->lif;
>> +
>> +     dev_dbg(ionic->dev, "%s: device stopping\n", __func__);
> 
> Nit: You can use pci_dbg(pdev, ...);
> 
>> +
>> +     del_timer_sync(&ionic->watchdog_timer);
>> +     cancel_work_sync(&lif->deferred.work);
>> +
>> +     mutex_lock(&lif->queue_lock);
>> +     ionic_stop_queues_reconfig(lif);
>> +     ionic_txrx_free(lif);
>> +     ionic_lif_deinit(lif);
>> +     ionic_qcqs_free(lif);
>> +     mutex_unlock(&lif->queue_lock);
>> +
>> +     ionic_dev_teardown(ionic);
>> +     ionic_clear_pci(ionic);
>> +     ionic_debugfs_del_dev(ionic);
>> +}
>> +
>> +static void ionic_reset_done(struct pci_dev *pdev)
>> +{
>> +     struct ionic *ionic = pci_get_drvdata(pdev);
>> +     struct ionic_lif *lif = ionic->lif;
>> +     int err;
>> +
>> +     err = ionic_setup_one(ionic);
>> +     if (err)
>> +             goto err_out;
>> +
>> +     pci_restore_state(pdev);
>> +     pci_save_state(pdev);
> 
> It's not clear to me why this is needed. Before issuing the reset, PCI
> core calls pci_dev_save_and_disable() which saves the configuration
> space of the device. After the reset, but before invoking the
> reset_done() handler, PCI core restores the configuration space of the
> device by calling pci_restore_state(). IOW, these calls seem to be
> redundant.
> 
> I'm asking because I have patches that implement these handlers as well,
> but I'm not calling pci_save_state() / pci_restore_state() in this flow
> and it seems to work fine.

I want to say that I took that from other examples, but I suspect I was 
looking at some older .slot_reset handlers which use them.

Yes, I believe you are right that these are already handled in the pci.c 
code that calls into our handlers.  It is redundant - probably doesn't 
hurt, but isn't needed.  I can pull those out in a v2.

Thanks,
sln


> 
>> +
>> +     ionic_debugfs_add_sizes(ionic);
>> +     ionic_debugfs_add_lif(ionic->lif);
>> +
>> +     err = ionic_restart_lif(lif);
>> +     if (err)
>> +             goto err_out;
>> +
>> +     mod_timer(&ionic->watchdog_timer, jiffies + 1);
>> +
>> +err_out:
>> +     dev_dbg(ionic->dev, "%s: device recovery %s\n",
>> +             __func__, err ? "failed" : "done");
>> +}
>> +
>> +static const struct pci_error_handlers ionic_err_handler = {
>> +     /* FLR handling */
>> +     .reset_prepare      = ionic_reset_prepare,
>> +     .reset_done         = ionic_reset_done,
>> +};

