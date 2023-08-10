Return-Path: <netdev+bounces-26401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B2F777B4B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170D0281F41
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A01FB5D;
	Thu, 10 Aug 2023 14:52:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD591E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:52:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::610])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D422106
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE8Cg23tiZmTs4pxkw6XgHujwrkiP3TBg9o/3E3DjiPxuiYFc0oKe8788C4oqLav/PTvTHFVMbH+tgsxzpfjcxBKawH4xHXa6HVxMt/qbIxXj9+Cw+PV+3379nIslQn6BjyErEjynLKOcf6rsLBS3FLRrT3QjhBzpaCbCf0IlV1LkJ4S0oBklFeXuUzxieZt8F10TQOckHkp6/rt21Yc3jgzplHi/aNsHjOc9kZEzbXTcJ/hXJ1xZKzc4LXVszx/Wt3XOMsd61lsfS6bpdXS3sqQ4NrzYmSmUZXA86p75yknwEZ4VaUDNTksUzDX4kG8HT8eX6s8flk+ZD/wm9sLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWUAVBoAHQP+dHG9ECsRX4+IX5o33Bw39bZUHd6naj4=;
 b=nATtuibqeQjsWroy/lU7yJuM382pTX3vnkF3fE5mW/tr0nh7QUvUWhmKQVHRGQRBnfAFXQAK0h+wssv2dHDi+vD/b4tDv1MaqI5FEkzYLhqhEIwZL7N0SYxHwkADZ3HBcF+I/5iXynSLFA/N+4fjv5i3GnWbgmNzCpxBHQ+SX4G8pxf66vmYYuKXeN4byH/hkLgUiEdR59K4vKFCbmpvOU7ulIfuCZop/S7Bfi13UraIlDxlBfED3v/sSmkQMvavzvYMqpH7omfgTeTt2esAq4OXbFKsBaobX3YPtHgFcaNiwdzCGFApSEFAFILGZUZYJwuu7KGrZz6xESjRr3yPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWUAVBoAHQP+dHG9ECsRX4+IX5o33Bw39bZUHd6naj4=;
 b=Hm5CffEpuQ2D2ugKPbuDIEd4iBeMEZmyXdmsH/Tod/1eMeg4jpeCPY1aufUEmr4SOSr5fj2HfbcnOkYA/oQ1mql5NaWh4jqiRe4lb0ABPZaYwi1qDiyn3tJ5EPuaZMswgBnwv0WGLI9raQmb9/3P6MyLgxj6K83/7FQBZkkfPzn8kioRZ8nI/r3fkS1xhwNv8TmgykvyfUasbyKYkNZCBEyUKovbqZkG9uqUzvf3PaYY40jw/wnTgQzdpZU49Kct467BH5GmaHGEPAptik5raN0jcN9UCQmnEbf8NU9Xo4Yh3H0KDvOldbWXXKIKBBZthZUCerfMR82A3JX1qiCnUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:52:09 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:52:08 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 12/26] nvme-tcp: Only enable offload with TLS if the
 driver supports it
In-Reply-To: <02837791-9e54-5b17-28a5-0df35bb93806@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-13-aaptel@nvidia.com>
 <02837791-9e54-5b17-28a5-0df35bb93806@grimberg.me>
Date: Thu, 10 Aug 2023 17:52:03 +0300
Message-ID: <253h6p7vtkc.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb01661-7866-47d4-5508-08db99b15ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LtWDH43uFhizULJeXCbxGHq13r/dd34Q5bNRWakXgGX8mCp4xp9LiO+tS9NqgYCrfLPBs4ML+RE/dWbIrO6WSMvBipV+3PcNe6BszMwNCgFDjG13PwDWkAV25AO0M9waRJbqfLVtEx28c0fLsZxxKElwnsubodKchRccFzHP+WIFMPl+gkVPJdIs8xvWedzsPD93dCvzdMkLSEHVb5KiDeGprQxzQnw6Pc5Q9kinwq6nGWhub6CRDpxpysubgfpjesZHW5N1XXrAE0AeP+RS2f4Gr+DMm/SexQlva+aeUneuUTLCPJ21A/gY/LCoOMANYgmxQ7Qv1r/1IolS7HMW/mypUpWc7n/bMV47w0VNbekMPotrAcg35uS82DaqOdObfrBw/lllO+ekGLc99sCKNauchX0Nhyo9NkYAT84MutESM4f4vqW6HjwiSrC043Q1SdnVstO8C1VQcIkk7XlW3//TLmcjlM+BFTZ0tcRnhtU3QF+SOZmXF0CqpfhJdzEaJObOh3H1ja8eQrEZON35wsTyUnFnFVBnon/RMhMCSOtZMieZRsWWFKtsIQRb8aRw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(1800799006)(186006)(451199021)(4744005)(316002)(5660300002)(2906002)(8936002)(8676002)(41300700001)(66556008)(66946007)(66476007)(4326008)(478600001)(7416002)(86362001)(6666004)(6486002)(6512007)(38100700002)(6506007)(107886003)(26005)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYuJ0zPYwFLbWYF3olGDjuvEzdOGcOihRHIkwuqXJ/M32++hNsWtK7fMzAvX?=
 =?us-ascii?Q?0Q8TXjBt+MlOKwhudbRhJZAslCaKAeDDtXGWh1y15O91TM4Qoo8TqLur+2wj?=
 =?us-ascii?Q?KwVOGn1+4Egg53R/mHceM/e13D3jhS2pfZQvju5P3GhAHuX8ldo13WHwH9+f?=
 =?us-ascii?Q?7ko85xUuUAhU/tpow1yUm5aAQTMYLKjayL4cNoqdJZNMcMOUZmVGnrOsVpNw?=
 =?us-ascii?Q?TrsciSDBvgPIBm5FK4TwwSmIBvCx4KUVvAju+Kr1oMjYBRbASCoq3BGLNlDZ?=
 =?us-ascii?Q?kAg3leTdwHr8eCr7kXxISyWujUAqsxyEQEcSh/1hr0RacKq8V1GuCQeV52yK?=
 =?us-ascii?Q?XmW68PQk8o3f7HO+9AQB5J2APtKH4yW5ZPnbawh3SMrhKei0O5CE9duqjXV/?=
 =?us-ascii?Q?oSNOzObrLU3lw3fSisF89fitEYzFRB5wNf18wTzytAHs9GiqL8nbXRA8xRgs?=
 =?us-ascii?Q?8rZCvdJBgFssdNwoJv3qHQUZtnWPIYg/LGX37x+TkS2ikCo4TEdWDqsiQfVn?=
 =?us-ascii?Q?B1jhJhX+w75FXpr0AsgZ7esaEahiPZ1MebWjhPmM7LSNKAjzamEeu4/MU+QJ?=
 =?us-ascii?Q?10yjATPExn4lq5xZjPrGiPpMUr6SJ22D/ZR4FCk3qbiVc67wDZEcJI/wC5Ky?=
 =?us-ascii?Q?dQHdUCj5O6bhENTX1fsVPd9vqCKZnV3zatwLinHAYMCpEfT28dUA1K1jHN+j?=
 =?us-ascii?Q?//b9ECszJ+q1IMpfED+oTtDy1tgbvYeNbrV0jchuNSKfXLh1Oet2/+Kgq/M+?=
 =?us-ascii?Q?FCHsRvNil74iM/1IsHG6KesNVQ115o9HI+s2lGDcMlie7ZwOYL338ukJ1aFW?=
 =?us-ascii?Q?hg+SIOjiW6YthDjMdz0cxE0DfDs6XYhsO0/Y6BzIGhYTcaqV82eXa7iWVLyc?=
 =?us-ascii?Q?7Gg9dHYTIEgt5robYq2hMw42oZaWtafX0wVzgQsHBoGNwb5acj3DG2HB7Fpi?=
 =?us-ascii?Q?6fy908q2e/lKV2AWbe6yUyi/rSEMhOxVptli/tPu/qhpQTTKEbCHUWBT3HL5?=
 =?us-ascii?Q?rV2R2wY6TuqkL4bv/KN1KAFQLZlFD53+1E6UC893E8iTBcqBgqjFWyxerBGe?=
 =?us-ascii?Q?6EOX9rfqtQIpwhu4TWf4mhfgaEf14sTLWkLcx1kkrN8bQDAyuSFgOvFaFaFz?=
 =?us-ascii?Q?VIWqmyRL66/uMfRAD0ufCaDm2FA1BLwhXYCP878+kj1hW1UKiI2FleMEb/yq?=
 =?us-ascii?Q?fiO7yUf1GD0O26dIUe2fhgQF1OlVEbYJaBwfkfVpm/sioHG0XQg6S22SeuzQ?=
 =?us-ascii?Q?YZd6HetO5+9hvZoSJhcmnR/aF2M1rYZ90l/H8fhXoWjAD2FigX0cUsutBCsr?=
 =?us-ascii?Q?APj4+XRA+2Vuy+MGtsAt2M+3/e/dvY7wQ4Z1su9e9PADeQWlcU8xZbB3rFXP?=
 =?us-ascii?Q?cFiy0Gha789Pap/6RYh063bWbbEC/JSy3lCr2pHaWH+JsEjZSmkGlCc0B+bd?=
 =?us-ascii?Q?TM9UsFGj1nIFTYEtlOTWmZwLhgAMC8gC4sZNrlAEIafAO6dt0QpWHQ5mJvbX?=
 =?us-ascii?Q?54HP7M5bxqjJVzN1LuRgpDrES8DFYRLklOg7EanVEKjq0BBaWoUzOzaZNgH1?=
 =?us-ascii?Q?BLhTQ3T/e2EIP8U3dofAAKQPy+rfpVYn2S2/Ah6k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb01661-7866-47d4-5508-08db99b15ec8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:52:08.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXmBskgqF0ygKfOf4jP1Kaqrdclm4UAEH9lUzB3h/Ct6QggszHCK2HxpmDkyybaQFFh+cnu9uNW7Zo6UR3O2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     /* If we are using TLS and netdev doesn't support it, do not offload */
>> +     if (queue->ctrl->ctrl.opts->tls && !queue->ddp_limits.tls)
>> +             return false;
>
> Same for this, fold to the first patch.

Ok

> Other than that I had a question on one of my other responses.
> I don't think that tls_device supports 1.3, so what does tls
> here mean? That any device that enables this supports _all_
> tls versions?

This is a catch-all for all TLS versions.
We can split the logic between TLS version once a HW device will allow it.

Thanks

