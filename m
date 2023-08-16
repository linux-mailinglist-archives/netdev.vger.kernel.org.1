Return-Path: <netdev+bounces-28256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DE77EC63
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DE4281CDA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B511AA76;
	Wed, 16 Aug 2023 21:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8833D60
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:58:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF12D50
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDzq97HgTlkI6cjv0e9dOUoCjJMgzL6Y3V9Lt57r5Etx+/c124PM2HPjfJ5tRkSp4FFyxTL0i7DfWOHdfXHHRdlRityVhJr3V6pgeiw9ZlCwfJcxuovTU0v6wXwth7W5Dz+Tv6Qy353eFS57WG1JYYi629lRV011SdsiBITYLjBbv3J1KnpoBI/NQ9oFlLhxGucbN3iqmKw+LxqdUzxSg3Xu++TuGVePY3XLupDw14wOzdWnb8va5LM4mG3Kqsk1nlOIUgeJi/mVKwiq/pux7uTwX7FWM6nTzpvQlqw9XzoBeSYPtySRhZu3BDzInrfIIaztL+vU9r48/mwpsWP4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEvOm6VZGIJ9jB1eQ3iGjYYRDwEsSryRdxnR0A4sjk0=;
 b=ANk+Jfihuab3lbu9QYKyRlyZAriakfazHAt4f6F5uVeATELc2Mdcbr45cuMm6cjNpDFShL9rH+zQ2p71ibS7pXjEc7Cq6juTgtFyD5t0NqanglVjehLEu2DcSwtw7JiUnIWT367nCJNUcwTr6vZ1SDCWk73zDUaki1NQfnIMfGPhzm8/cn3WEHXePQfOrEn45ff9qyZ6BfRaYki/VZrFe7nzNmSyf9MGAoO4mnN2nU6rdcWohAkQZDIkJR1wAnpRjdNY74BnaMFzRzD6BB83p7xvqFtFzlfy+AWguLElMOs9lIrft7VYO2ncVA/53TsNuVYWOEdpPGqLPuLHyZoEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEvOm6VZGIJ9jB1eQ3iGjYYRDwEsSryRdxnR0A4sjk0=;
 b=ULq9ILT/EJXb1+c2xTBlrt6TfrxXr9jxs692ksjcC38C9s1d8O+Q2/HQjp1f4DEIA+w8IRMbSWvE4ioGDEfdXfBcnKgD6urZ0lMJYgZrQg2hwcJ7m6IzVz6fXcTdMVIMJbIegdrIqo8Y/8pNz/t4nMzruPOsgUdp+krZLewP9LP+y2Nf46JeNWLAymFfbEsa+TVjhcvDKuas/nskO5lEjKp67SiRqpBjbCnpmHLngdcscmmJ/ldHQ3LikAa1H301ffu0bsmBRwgDdJp/sHohraMsct+7XsutDWMZrxsnnGvWfQRQbGMsjbFl9CDcDI+KXxtIFQauV+Wbx6qbRgmeyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:57:35 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 21:57:34 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Gal Pressman <gal@nvidia.com>,  Bar Shapira <bshapira@nvidia.com>,
  Vadim Fedorenko <vadim.fedorenko@linux.dev>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Jakub Kicinski <kuba@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value
 to improve ptp free running mode precision"
References: <20230815151507.3028503-1-vadfed@meta.com>
	<875y5gl01k.fsf@nvidia.com>
Date: Wed, 16 Aug 2023 14:57:26 -0700
In-Reply-To: <875y5gl01k.fsf@nvidia.com> (Rahul Rameshbabu's message of "Tue,
	15 Aug 2023 09:53:27 -0700")
Message-ID: <87zg2qhcqh.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BL0PR12MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: f2173ae0-84c7-44ea-a485-08db9ea3cc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XkP9+YEijldQ2cc357ln/cg6YqFgE92NU6ceNcG/ge/6xMCjmZfTNYGK/+RWQfbl5EFz0Kisqq0zESTlD0Jzpm3J9d8bViDZMP+p/Or7C2p13wFxT2Ft/K7CklqhILVFtKiCSq37UPtJJ0HmgYdg35oppKv4pTyqyhbUd0TzKb02tPYgZNj34sn51Ou/7PCXjXUaKr9esNCEG9Wn3o6++fDZO35dEqKfGmmx7IlAdgKTn0nAOCEBXYBWmHyubZvaKWsaB5bW+ilgZvAw8iC+ZOgd+aTBFkrSzWlKNmyE9LdTlKZmMlFY8FlsLwh7qwX5GN/3w6BbFVzVJ8vwq9c5EEVrGiSkDIMitLhWgF76n/AVaPXjfAT4ic2y3pCDwqPIfhXv41DWuHqK68IWdlC75ZAIM37H+ZvdvM3r4I249TFegb7qJGxwTeZ/E8OT9eLvv++kHGLKShfsJSfIcW+MpUPm6NSFc+SElBpm9kNaXAoPsNLyTRgXfE9vPRQ4bvnZYP1A55Sqo5Agv+/jKi6AD+p8kTi4eZaWXmVezeWJgSLtff+S/9/KBqf2H6pPGMtR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(5660300002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(66899024)(2906002)(15650500001)(83380400001)(26005)(478600001)(86362001)(6512007)(36756003)(6506007)(6666004)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55SulnSVEU4aDhibzad9G3HBGKe3dDWozyKnmyGi6x6j9ISW3JmW1BZhL130?=
 =?us-ascii?Q?rCSybcMinYDbTafn1rKv+ykhoFG1mwKFBEQ2ucPtEhpnW/pY47QNJfK60yRP?=
 =?us-ascii?Q?iYciWUKDisXBeXp8u3l0dBAq4MSKMH1D5jNspCyDizixcSZJjzkAyMKtjXyk?=
 =?us-ascii?Q?llNQQ0ZLRDoSjplG/pOLNiWLmZsCMU638M/FmLgDkBgBaF6iW5reT48F3GNL?=
 =?us-ascii?Q?lz8/Yuo8+de0Zmn/w82MJ9YMMdAsTomCVgISMRz3R2PU1d+lGCgXbmU+KTUS?=
 =?us-ascii?Q?b0ADPpKxjlwqkXOw1jThQ/UCuvTPlDWkjzTykB0FiwWQlA8nQnZQZ1hBZgKL?=
 =?us-ascii?Q?Ym9Qewa3KIu5M7InVxCGf6hGq3qAxQZfwULfIgPdA5Ksts3wO503hU9mVxsZ?=
 =?us-ascii?Q?RFUZDJLDrWOypXAz/d86uefUODRFPBgZwUGx1gpQl7YBMipx3Zoiq6jyhMw8?=
 =?us-ascii?Q?HJwNyjrX9j39uxXiqiteXJZOWVIREbKDho7QkKduLwafJuNVcTPeJIhO7yH7?=
 =?us-ascii?Q?USCm0cQEMqPwPB92TC+6PN5/fi2Meg58NnL6aTzG/pJLkw7nLmsE4ZVfOJqC?=
 =?us-ascii?Q?V0ImvQNbHWdLjwXPekBB7ATbf3cFz0A3oQ021RRUTFvxiwDUcOstNrNZDkTu?=
 =?us-ascii?Q?MP+VLFHfTlEMS3M1J7NsDtwoI8OQIDH5UFoL1i0K1pSyQxZW6oWWZM6jfYNi?=
 =?us-ascii?Q?xtlOmCdZWxixTdwwPKcmnGL3s6VMlPRKL248+2jZpZxUW7NFFQRrybmEddrV?=
 =?us-ascii?Q?qXMWgiUdk2+ggTdx76vKByhsxSpeiZPzMXcoRCOgGpl9P509TQ+ts5vGieFq?=
 =?us-ascii?Q?nkcqMNoEpN7gUrPqekOe2beFrTgHFVBPjlOXq8arshUYvqKr5JSAiaf4OUKU?=
 =?us-ascii?Q?tfsnWEzXWAQqv0k42Erfi+qo418kqY+1/HRMXthD1NI9nDoDyC2DcaW+rqPa?=
 =?us-ascii?Q?PZC6R61s+EGqnRCJ7I0RFys8SuBDfrRJkjZow17cKzB9wWn/9oA4WIM9PYur?=
 =?us-ascii?Q?ix0hEftaGdb+rQabAaYw4xDqkNTzlL5Nj5hCPBS+oUYru/1fy8+Jyy/qgUKs?=
 =?us-ascii?Q?9Y2rpblYzjMI2ew4XVH3YPBHFsha5PEwfTEH8ShJOK+1G6/YSbb5TnhxNhYV?=
 =?us-ascii?Q?Mktzd+5DPoGOKAfDbc3a6PU9jAJ3siUv/1tLaAdaVs/Bljizg7zuM10D/WqF?=
 =?us-ascii?Q?/wbcCZ2Zn29hrrbb9NBvRkrQpqRuiUVsJ3WnO2wSQn0knJbis/n3VN4+PXDT?=
 =?us-ascii?Q?51+QxjKiFfwFRDuch8un1qxVg9xOrwuciNcUgYMR77HhCulb3d3n8TKF8Q84?=
 =?us-ascii?Q?l3XL90lldvC6IRxluQck6z4KaE4O59bogseMRT47rlTh5NDCb8aCdnR05LIW?=
 =?us-ascii?Q?J1tIVcSmEXIOF2Vl/fINrT/2xkc//iV+CSBB7s+1JkPr0Mi/3OenAxXwh4bE?=
 =?us-ascii?Q?k3ec3PTf/ARcUC0hvUumZik18ZXfixHngMVXp8g1orTrRN04KmQ30FolXJRf?=
 =?us-ascii?Q?Es2QbrxuUAitNo3q4HPDA5inQIOKNMtkbh9oAo96TnGvpqgvT8FjqLJNK2sk?=
 =?us-ascii?Q?fhU1rL7Ugux5f83mS1EJckglf/n2ErX2q1TgaSI5aOT7szm/haE3zj35/uWq?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2173ae0-84c7-44ea-a485-08db9ea3cc0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:57:34.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7q33zzRlGlc7qqu4FsthamRaOZ7HbH3B0L4Wb6hBEH0/sjmSlAspaCqyho1HbC3YlRBUhbY1T44kjwQ/JoEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug, 2023 09:53:27 -0700 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> On Tue, 15 Aug, 2023 08:15:07 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
>>
>> There was an assumption in the original commit that all the devices
>> supported by mlx5 advertise 1GHz as an internal timer frequency.
>> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
>> as an internal frequency and the original commit breaks PTP
>> synchronization on these cards.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>
> I agree with this revert. This change was made with the assumption that
> all mlx5 compatible devices were running a 1Ghz internal timer. Will
> sync with folks internally about how we can support higher precision
> free running mode while accounting for the different device timer clock
> speeds.

I have prepared a patch that resolves the issue of selecting a valid
shift constant based on the device frequency. The patch includes logic
for picking the optimal shift constant for PTP frequency adjustment
based on the device frequency. I have tested this against a variety of
mlx5 devices and believe this solution would be ideal. I expect this
patch to make its way to the mailing list by the end of the week.

--
Thanks,

Rahul Rameshbabu

