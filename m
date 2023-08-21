Return-Path: <netdev+bounces-29447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A197834F7
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0A1C209E6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEAA125CB;
	Mon, 21 Aug 2023 21:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5F11720
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:44:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82826180
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fndCyG24klN2PW5xXRvoSGAKwO41au3RQGPGqLBH9looXU5BDk2KqgIVjJ6KBss2hXijN2h9EfmPtpXrTTvxHUer9qPuRqhiDep3Foj04A/bXe7afi/nciioXlIuI7JyvPsTENLM/p7SXTMKhub0iILa6sjhyTmQ9iQvGSJuGktXgUvA1rhSSuVe0NMS4EpEvpzmUuU+TjqfB9k6so3EpyA3xy7WDY+SxElLQT6KPXpwwb/IhAin6OqUkwgVO14noCg6ohcbK2SLaNhctmA3rsLoNL9zh1CJZP56f9OPZmJBh3xovuH71q/Az33+fzEgQQDP/RbCaxIcHR2i8KKIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsvvraszChXlmRk2nV7jCDj22Cn/BjHF2/Ofw+P7fhs=;
 b=M+AtE+tOWFdmpNfYtSduFYU0oulfnQEHo7PRX+ArqVICkMhmxFHFnYmMjTWwsnZ2RwKJ//DDhp8mmxOTwO3aCYTcIL99TlMGzlN5+bnUsRoMlCVJ3u6Bim66dxKwDRJZtAPBsqhG8GxB1uYGVTrrzZEh5yg+JiLBtIgd3fjdo0Kgdyl/nA7Q4zg7QBJ/F2bcEaxe69afP/hTZQnowKjyqLq7W0N7AiTp/PwY9Vdq//GcMiOSQ23FnDqk3LFRbK0Ik8gLVS28iTMx5dn2ICnMUBugkKn+IjvrDu40187lAci0nMZmjEzWf5qsfPsq91BvxFtz6Ht7T5CNWt+hpA+41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsvvraszChXlmRk2nV7jCDj22Cn/BjHF2/Ofw+P7fhs=;
 b=S9oFULMC6B5rhAjglb0LVhOFAj+3UrL/SfUBoLA77bbZWhcj1HENwqY8F1eTnK4rH7VrBae4ul1ODjX7JzKTuaHyXwDW94R813ConCdH/eknYYAFOE226J/Q0++URaYS8L9aAClj8jaRxGvKknUVMWNu0ywxv0DJtEtG5ZCoONukWrzuFVPpL2jmG/e6Bt6QiT9y99Nbc+pzQq4+NZ4E9n07j5sur9rqaCugdioB34Tcv8VevBHoazPNHQL27qHGtPQLnBk/xwR5fhwmreZ0jjLd90ZZajz7/+qre/OQIu1FnIe1bDb1gh9d70QsknjP/iFQGfOn+NWxnuSDDIiLeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 21:44:42 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 21:44:42 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Saeed Mahameed <saeed@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Gal Pressman <gal@nvidia.com>,  Bar
 Shapira <bshapira@nvidia.com>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,  Richard Cochran <richardcochran@gmail.com>,
  "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value
 to improve ptp free running mode precision"
References: <20230815151507.3028503-1-vadfed@meta.com>
	<20230816193822.1a0c2b0c@kernel.org> <ZN5Mvh9c+joFcJbb@x130>
	<BLAPR15MB3874DB4725CD5B5139DAA868BC1EA@BLAPR15MB3874.namprd15.prod.outlook.com>
Date: Mon, 21 Aug 2023 14:44:34 -0700
In-Reply-To: <BLAPR15MB3874DB4725CD5B5139DAA868BC1EA@BLAPR15MB3874.namprd15.prod.outlook.com>
	(Vadim Fedorenko's message of "Mon, 21 Aug 2023 21:37:51 +0000")
Message-ID: <87il98nk8t.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e60ec3e-f494-4fc2-538f-08dba28fd3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eR26rdklAO2RZkPEIBkipiCL7QOHvHyJYHfoEm07c2oXIK7/OWjDsCEbujVlUUFU+jMjTJ5vEbArCU0bF/BzZ7or3m3G94jFK5VQrtxnEtUB5ObSkyFe4njZ7ORL6jpsO8EbBmtYwqfPl7rBU9q96G1h+xIsIyZY6ZdbmM/hKdgn9Q3PoBz1R3gBu0348xXz9cFMQY+3tsepOje9WCMJBt5z6V3volsJ1jbyh4iuhD6V7birdqiFZ+a8NZZiQlLw8qIkiuVzUQrYaaL+1KP/LHtVH7HhPVRMLToh+qUkkeGSS2E2Wraaq9jXL0fqOnA8jgoQnCXGtpOK7dE2tzpg2jSP9OkOkeLlE8SJq536xmfklpZdG0OypuVtohzXK4ou63drPV9EFYTOeLjzwkBtWok307vrTy+BXVf5aBXFybt9ubnYpElqDbDmEDh1j61PPIulhObzZ205biFu6Y9HyYInjhMmONExuNNr8EDZ3indrH5JEpBq16OXhuzgEdYXVE6KNfW7QsWhsz/r2Y6Cyh1t/GQ2Ckwgblc3PmQxt1fMcWawNAI255lyN5of3GCq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(6512007)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(15650500001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyOvMupj9DTApEG9ApBfV7ZqQQHEoDKPX0HKEfHXxppZgmtnQkZAx2szeUUi?=
 =?us-ascii?Q?We031O3qy6xuf25T3i2FoQeT5Fd/2l7Y+OuuU4PZM2PD+FkIBmuf+UWicKpv?=
 =?us-ascii?Q?7tiZXytRoCE95vJyMYX0FWuyURuOJ2xWEydjATgmdhUU8f7qNEqquT23Jdq3?=
 =?us-ascii?Q?oI6s8o9cZ3OZxtEOsJDLHx+F4wiNQ3enANQkJgFuOq+bIj4EkAy5oS1ak6tT?=
 =?us-ascii?Q?p2QHlv4eZZK8DrKEVS3cuF0sg5SInIObZwcrXotQyyEycz+iWE8hyUu29SN4?=
 =?us-ascii?Q?bvKbLwbq3A8ZV9WYT55v4g4s8S9eIfhZdAUuDY6S/caWZDFyoGL23koizW9x?=
 =?us-ascii?Q?GZ1PO27fM0lSEEaLDSs2ouCu8nqANl4VMR+GWGUZxP5Z25vanCrHt9IBoL9k?=
 =?us-ascii?Q?Z1MTOOhNiAKdtc896wakmbohl44VRHIP62uhNlJrYog038DfpjmuqNI9TIdO?=
 =?us-ascii?Q?kUL8m1cBzkIraooyS+zzqzGcrD7ceahhjwl/k4v2ra8bMZpeHBZJsdMKbmsO?=
 =?us-ascii?Q?O8cNCLu/D8wXAvcNZ3yeNkf5Rh3sa8fY/I0la/ZN8UFTUgRWeWXTFN3Kgwfw?=
 =?us-ascii?Q?FXcM+vbH5YhCXqm18e3xKZuYES6SxRnPDxyUitF/4XYdKPtNJ0HuZVeE8yEK?=
 =?us-ascii?Q?wsaskLNISdJUbV9aJoeBxFXpsWnyV+pHA6QWDqCHvvguK/ywMgSM674je+/q?=
 =?us-ascii?Q?23xUorJs3SEpAodythfym9eA9BrAPh4n3xLkeNi5VsxyXeXrMqmnH8brw1Df?=
 =?us-ascii?Q?KFV2mH460HWCXmtk4RU6dgZxnZKJv520egemZgjD9eQMaYcQxP6UvmGvKhuN?=
 =?us-ascii?Q?L4YSWE5WDQ+hYJQ9P8faCuYmGMbigTu6bAq2I7PZrBfNAqBy7eFQD1ESEw/Q?=
 =?us-ascii?Q?pds2kitUFLPuce4WiZLE5Jh+fRZ8Sm7NsjYUi3m9nD0CFaZ0SnggmjECMxmG?=
 =?us-ascii?Q?HtK+F1ul39BO/OCfSO5lNU8xQBqi8NgQksWRIlbn+CtAzscvRVPzw0Hwh6at?=
 =?us-ascii?Q?dLkvK1vyH+dgH3LXtlecgTonj5GwHYeFShX7XrxWTXAak+/aE56iTp6MvIuN?=
 =?us-ascii?Q?Tif93WbiPhtQEKTfq8Vcm88weh0bjFqF7lwCwa867n54kc4gJ3OwgpkHhLG/?=
 =?us-ascii?Q?KLUCpwhzAKoxz5BdVtuOj0EwcPeZpkMCg9aK9bAjihBJ+ogsKU4fDQ1fIJwS?=
 =?us-ascii?Q?tMrU0IJvHKcGL03hiSTRaVNEJTkLdL6+2O49Bk6jYGi8ZsDlehvZEouKfGJN?=
 =?us-ascii?Q?C66c3FX7/EEkLy0vNRpHGUFxQZ1yrz+MfaaP+i2hEl8917fm2oYWOSUgl9PA?=
 =?us-ascii?Q?tp3eUFZnfDDbDcfIwJnZPTFuOlbR6iDA2dBl3Z9cHPk00tMM1MAC1lIl/wvs?=
 =?us-ascii?Q?6oPfPrCyuOtm8sX9StrH5y23qYU3YP/GidEbbRHOQFZMRopfoHJTUNHgdotG?=
 =?us-ascii?Q?TwbuXUttSb1uWg83ZLNeZQNFPdoWqcAB04p31zrforbxBnPD8WzRIUcsYLUg?=
 =?us-ascii?Q?CgIFxCUbF2PT5BV4pSDw7JNmMzyJDzy5dgfjJtAGGWQKWThPmb0LvDLA904N?=
 =?us-ascii?Q?8HtuDHwnouOTBE8idnQBG5udOe335swsTfB8zy1ZCzcMzIysHb56p9TQZC6v?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e60ec3e-f494-4fc2-538f-08dba28fd3fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 21:44:42.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVELxZLESOvj4YaVPUxsDUj0VllzugouFBlJ7QPpESoxcLwhDmmECieYU0WtEQw9x9qCElicimCpGxfLO2aWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 21 Aug, 2023 21:37:51 +0000 Vadim Fedorenko <vadfed@meta.com> wrote:
> Hi!
>
> I have tested the diff, looks like it works on both CX4 and CX6 cards I have
> right now. Wasn't able to find CX5 to test it, but I think it's ok to publish it
> and wait for some other users of CX5 to test.

Thanks Vadim. I have tested on CX5 myself, but a CX5 user reached out to
me directly since he was also impacted by the original change. If we
can, getting his feedback would be good.

>
> Best,
> Vadim
>
> ________________________________________
> From: Saeed Mahameed <saeed@kernel.org>
> Sent: 17 August 2023 17:37
> To: Jakub Kicinski
> Cc: Saeed Mahameed; Vadim Fedorenko; Rahul Rameshbabu; Gal Pressman; Bar
> Shapira; Vadim Fedorenko; Richard Cochran; netdev@vger.kernel.org
> Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value to
> improve ptp free running mode precision"
>
> On 16 Aug 19:38, Jakub Kicinski wrote:
>>On Tue, 15 Aug 2023 08:15:07 -0700 Vadim Fedorenko wrote:
>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
>>>
>>> There was an assumption in the original commit that all the devices
>>> supported by mlx5 advertise 1GHz as an internal timer frequency.
>>> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
>>> as an internal frequency and the original commit breaks PTP
>>> synchronization on these cards.
>>
>>Hi Saeed, any preference here? Given we're past -rc6 and the small
>>size of the revert it seems like a tempting solution?
>
> Rahul's solution is also very small and already passed review, we will be
> conducting some tests, share the patch with Vadim for testing and I will be
> submitting it early next week.
>

Hi Saeed, I think we can send the patch out whenever you want to. I will
share the patch directly with the individual CX5 user who reached out to
me as well.

--
Thanks,

Rahul Rameshbabu

