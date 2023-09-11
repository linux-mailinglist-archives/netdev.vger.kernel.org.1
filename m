Return-Path: <netdev+bounces-32835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D06F79A86E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A0D2811EA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222F11710;
	Mon, 11 Sep 2023 13:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F511184
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:59:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB73CD7
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTe59agz9FnGAziX46QrWBMoVff8co7dCOA/ii3VNRN/1rBoMaqyfzhHOaP7757VlGZitYoRZ+gLn7sQ2wWlIHOLZu9sVBtAjas2NU2/NMMMGceIsUKicTD1VWmqg8CUPQr7kECseQmRimISQ1NlSF/Q1yAgtkfPaW8PjXCD37MiZ5Vw4yFLyOg8KsjR++ISWoJpjs+acN0uR7yRO+4fUIXu4U44Ea5dJQ9xk4FeN2E16O/a5HCsBQrpHLcXkK9+HltJmDRaUQPZygcBU1kJgntPdWk7LLqgwTD0s5C7r5RqK+yZDYl3HOq8eJgJe2p9egg02R7JFeYpFc8NwbAL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CF44g3dP9i88MgfaJOTX/TJ2B4UzgtM9W9VEYJs94w=;
 b=HWCfCJB8EOTMLCdA7XbiCNtXSXO5TTVHllzwJlPDwjBZT8oUHUB9J6BI0TOx1KL8HcwtyR2PmX+WkZI6L+8fGBsbS9NwitwH6SITOh0GiuQuRYl36qv385+ctmjhZ/c3fHN/YEyz4+2/UpUIvPKqjhzrYm7qUw0ywTfsBWCJQKMryIAHynBShaj8nwrJEnALHSNgS6bUwUMHAqUGI5GidmyO3vV+AFp8Eh8UlNf+u7Mgi3kasPr/hdCTf2Q0YLKLzWiCTfc2q9xETC7Wcdk+pBCuvl1vuEahR/tmNA18ICu9e/JA9DviU27fMP9ob0qVb5ZLhlyQwTSSOlyxyst38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CF44g3dP9i88MgfaJOTX/TJ2B4UzgtM9W9VEYJs94w=;
 b=HtIgf4JN5cemEu3cGfIaaE0eJutJdktH8yXMDfZImTYDR+E28Bdw72EF/QDGyW2nRTyu/rzVUEHzPtCRyhdVkImqYe/mxHa+to1GY/NWpe6OElitkE0Dra0rIQJkojgcG7bTJ7sYbKm1Qcp/pwXOdMJxlocwKH9vRia6LvQRWT7BsIAs2+l2irSMBRwXSaIQzBCLVEIx+zNdQADu9LyRAuA9fUR8AiIr7GOWSDR9dALtw8CZh8sTnQ6SN2Rfgb+BL2RYwl0uL3e66d8JenYsZSOpUGWvgk8RejweAxdWXc5/ZS2mWSdcELe6sBY6B8NSofg23q8avaHEFR8z5B00DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 13:59:20 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 13:59:20 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v14 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
In-Reply-To: <20230908144909.5d7a36ce@kernel.org>
References: <20230906113018.2856-1-aaptel@nvidia.com>
 <20230906113018.2856-3-aaptel@nvidia.com>
 <20230908144909.5d7a36ce@kernel.org>
Date: Mon, 11 Sep 2023 16:59:14 +0300
Message-ID: <253r0n47qvh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cdfff4-9763-4d94-8607-08dbb2cf4bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aChXwyeacNJP2Ej7/25n3jpUTHr/MvxYVjX0RgC5wfNn2AiSIs9Ro9nuvhNvWbBLx1xdD8Wk383cEMdsBmj96PujLnfeyMt5fLwi2Ew3NKWzO3IsAcaiMJCv28SvE/GuxSRDW32W6l1fn27MsaA/2Tj+qHh4gID4y7sV5z1rwP7UrfoKZlvxwy7XQX94r4jzDQcqrr+esrWDcUyeahb5nViKCq/ZLqKK/8IcoJhoSARqB+YVTLi4Ek6hdNPNZdEoC8qD1HkPaFih1LLbF9so140K1i861UJ+C5X1NUAK+FLWiHlGbd5w4m4VWg1DDbPJqsAdP8jmvPfOYNEUjPC3vvAx2jO++nf/HGyKdpw+6g2ORbVMITIbRBQQb2b3Lg4MLEcai2CzuQwKUZQ9waNP8prNLhLF/ToXQkOMPQ6fg4BQpyhepunh2AttyiaDfVDIoCZj6HKNDavb6FMHsoHXaZ81xbZ56/hR+X68s+9kl5bfxaJ4PdHQ5K9yxCkV3Fl4qH906LaKrdnotYqVv4YKhYteplXTsodu+QzHBR/6dgFrklWmhWiTANj5u2UIOjzZZP2/fmQs3LQutp+QMQ+7j//B4kTuKFwh5Ahm2now1hBJ/p1RwQ4LhlP8mPjzNH11
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(1800799009)(451199024)(186009)(5660300002)(6512007)(6666004)(6506007)(6486002)(86362001)(107886003)(38100700002)(26005)(9686003)(478600001)(66476007)(8936002)(4326008)(66946007)(8676002)(41300700001)(7416002)(2906002)(316002)(6916009)(66556008)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHQ5GLDzPZNXf5tf3MpBBRItW+l7oYVAibmgBWwZI3DtoQmjPVBtja0YoZqR?=
 =?us-ascii?Q?HJXbjI/AudJNvS7Nzk7mLJE0yG7eGJTqc8wDI7xko6pkFC5HaKLYIuIMl1Lu?=
 =?us-ascii?Q?qy9j2o7ktZsliti3olKfSOnKIf+RAV5gC/6mwx27r+ScCu6Sr9dVwRrYFe8w?=
 =?us-ascii?Q?CtR9Aj5mFv6chcdDREro/yGW5rCSSU7VOwzR02PJBpT/PaqSQHBTsW01Q7F2?=
 =?us-ascii?Q?5r5OGl+v2wJI+mKm0fszLeZajmDlyUajzlDovVtlEHiF75K1AR9i/arjICEF?=
 =?us-ascii?Q?Y8m9R4QLXFvz2pztE9eGTKWAmPrNjyJp6yT541KNd0cnUmt9kNePsiVzv0Dw?=
 =?us-ascii?Q?LsHB0hH4H8mLFCaHBBEBo5TEbbs8ndhMwxywkDBCEjQRm5tFzoyuZ2YeW6yj?=
 =?us-ascii?Q?LWFknY9SnyWL9YnJtBwo7HzPs9WXT4HIzYYG0J+mTU/pXNPnnSJ6l4GAPhwt?=
 =?us-ascii?Q?pfTDQyMwfo9W04QXWtQtM4Jp0lHGeDAUhboqL1lgWXh1e1wvfS7bUAC+TThB?=
 =?us-ascii?Q?2jlgq162gm7hbHwZ+146Oa80v/sI666WD6b/ZbtDYM7cmNfghK6Bs1WPRaZb?=
 =?us-ascii?Q?OjIsJ3wqAwMfC0bHkwnksbVJ4JyZ4jCyrThT1bkDyOKdywBGdurtgR4qMPm1?=
 =?us-ascii?Q?wg3T1BoLCT1GVy5Sn9eDAkMytjdTdMe5RdZAXxQPYdt4Rjh5REM0Gmrau5xS?=
 =?us-ascii?Q?RQKxvslBJ2NFV4GaSCxoN40G8YiZsGS7VNHxeDXl1/RWQNlqeLc+WkPt7+eT?=
 =?us-ascii?Q?pRHKvKsmLmtsBZrl7b19c+O0l+pAmJUuQkP/xV1MaklaOMrNlNVXp1hNld7i?=
 =?us-ascii?Q?k8sE3iRBaduAxcjtwCIFFS2YZaw00a41nheNJPWlnTOECRwbirYE39Rr5OSl?=
 =?us-ascii?Q?jwxYaTlRmPk4PabEELge8JZTwUwKd1jgyjG24mFUJfHklPnzblEfBJgs58lQ?=
 =?us-ascii?Q?TKYzfOyGAAOwuqBwlT/qav1mHYqVKRkG7I6omxadh7SdNig9vw2mdpPjFwFj?=
 =?us-ascii?Q?xxH1t/BE46zqVvQjNubJr1ygZyKqsQW9Je7dE56TFsipKneR5P2d8uu9TjRX?=
 =?us-ascii?Q?BbNl3TNqGJicG3tAr4YHscxRpQTS7N/IQwfWDh4zQKo+Jv2uIsEWy6AvHY8q?=
 =?us-ascii?Q?uGKFY1dPLhReDohT2UfO8XEmfqhZp1Ur1BDOBu+ZhxQzcR+L4Nn9YdlpzCgD?=
 =?us-ascii?Q?AE1D4YykNYm0bEPVxMfH6Lz6CUW+2UrSEGL30I3AYbuLD24j4MB/D8JF8il2?=
 =?us-ascii?Q?8fiJFcQjaz69q8txwc47rlE3bcBfi1mu5HOk0hZHrYMExRjxfSSE/HaoLRwg?=
 =?us-ascii?Q?7/Lz72z/eVHmr0Qe7oIHstEnQHH/YO6QD/fNGUjAQTpkwrf5MKjZAOnuxFJK?=
 =?us-ascii?Q?JWRrDCqqKvIiOq1C8OVn2Fg53d9X/8GQsPKuRJ2sC7as4QUHeU7iXOY2FyoL?=
 =?us-ascii?Q?Q4o3a691kp/VN6E8MZACzlXXrlmlWDNtmYNi/WFmGlWkrSyKOEpBH4gi8x0D?=
 =?us-ascii?Q?C4Q05yU70C1dEVx3lQhV97mZj0kg0VEuYxPKn/tGvJO2XOKlDJC14DPTTErq?=
 =?us-ascii?Q?ytuyiKr8cCwpnITZeRHfnxry/TIdTQ82mfUVoe+V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cdfff4-9763-4d94-8607-08dbb2cf4bac
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:59:20.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfUu0RB0sdBmbo81u6HhX023UqjagmxeMLWNJodZAaIWA62GYdZ8Ls/X8k7Xz9FH59RWttgPht/uiDrnhxz/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:
> Looks mostly good, but we lost dump support. TAL at netdev_nl_dev_get_dumpit(),
> the iteration is not that hard, I reckon we should support dumps.

Ok, we will add dumpit support for ULP_DDP_CMD_GET.

IIUC the dumpit should loop over all the netdev in its callback and
write a ULP_DDP_CMD_GET reply msg for each.

> Are the ifdefs still needed? Can't we compile out all of the family code
> if the config is not selected?

They are not, we will remove the ifdefs.

>> +
>
> nit pointless empty line.

Ok

>> +     if (!data->dev) {
>> +             kfree(data);
>> +             return -EINVAL;
>
> ENOENT ? Maybe also
>
>                 NL_SET_BAD_ATTR(info->extack, info->attrs[ULP_DDP_A_DEV_IFINDEX])
> ?

Ok, sounds good.

>> +     ret = apply_bits(data, &wanted, &wanted_mask, info->extack);
>> +     if (ret < 0)
>> +             return ret;
>
> leaks rsp

Oops, thanks for spotting that.

>> +     notify = !!ret;
>> +     ret = prepare_data(info, data, ULP_DDP_CMD_SET);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = fill_data(rsp, data, ULP_DDP_CMD_SET, info->snd_portid, info->snd_seq, 0);
>
> fill_date() can probably use genlmsg_iput() ?

Probably yes, unless it makes the dumpit function more complex.

Thanks

