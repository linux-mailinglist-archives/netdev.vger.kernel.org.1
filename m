Return-Path: <netdev+bounces-14383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20629740847
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 04:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B6E281161
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7C15A0;
	Wed, 28 Jun 2023 02:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96941842
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 02:23:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6F30D6
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0SHeXdPiqfBEQ4ZYIPL36uPAlSrRoa+IcJvEP7cQlE7/nJqyE/0J8b3bpZ+Bkzb9/UgWxS1DN/ZqIdHtUNDb1hFIpTElnbQpPEND97K1KbTs3bTBgER3aZPPjS/+BznhhaiyEt8sIlLkeVWae275IgWSK7uwKxv2C3QFif8+dvlk6bg3fpDsfgdP/WCmBZZF6qK3gHWjlzDyQvI2J6OEOqaX8bpCGJm14qrwwNc8DaslgaaJXOssYSdiS7A9o9grm1ZjPgA8MG/3VX5RwBpAnFg4BCDMnPgurpGNLwRjUHIJZmxufMJSTfyydKBoC715fTmhWrGnk2ztVYrub/BxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD8X4tATvbwmwI0tLV6Lu3NlqfRCRxm4dFtL2GnOEYE=;
 b=obe+3l5IzM/cijw/L6s1Ii4w7ikrbvs8BzMeQ5yxmi68WTmZ3XlQ57EUiz4VzJ/Yvga+DkB7XNKNtunHGITfaxO947dMjtKt1oQBfV8cJv/7CWUZfsxvjBetbGNEihcc0V3VTebcrskX0n5poyS86imS/bYk2XN8iDLfcUpXJk8U2T/vfJe8ngDjp70zu64AEXDi1QccQcOGo4QuRSGF8qOfXTlInH3xkJSHlgTWwrNdD+/zQ31MFLgwq26Z1Zro3Mm/2RsBjLPir5J/z24l4ZZJUX/lN8MQSEBctAHBlER2qlaHgy8MgpZagmtYaS7EJB4I+PBmm6tSt6nxw6RZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD8X4tATvbwmwI0tLV6Lu3NlqfRCRxm4dFtL2GnOEYE=;
 b=qkZhy6Yg7QqBJ+ZdsBb+ckN/+gi+mMjVfpDOVFJAZtbxyjYRH6q7REawl/JGkP+ad9fvQZRENPV6CRe4lQA0O0GPVz7XbzPYjiWJ0xhNt5LGi+fAcyM2DHw/JcjwI8pbHR6keBLivVFVBcNBJzSKn5A2KUZ35Y4WHWPOOeJFgAgZMF9z2ClMpS/9PGz3qZgHSFq+xXHgEeC58Mpc4pfgQwIsxlAl2dyJbu49BUCI8xBF36e1WVDNZUnA7nMM/Avi8i4VucK6nK4NV5nxbv4HZ/vfhCWmXBAu6jfgFb+wxIAZEyi0IgvFqquzSRy7U0b+pHCO/oXAJNWduHj+/vJJzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:22:45 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 02:22:44 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,  Richard Cochran <richardcochran@gmail.com>,
  Paolo Abeni <pabeni@redhat.com>,  Jakub Kicinski <kuba@kernel.org>,
  Saeed Mahameed <saeed@kernel.org>,  Gal Pressman <gal@nvidia.com>,
  "David S. Miller" <davem@davemloft.net>,  lkft-triage@lists.linaro.org,
  LTP List <ltp@lists.linux.it>,  Nathan Chancellor <nathan@kernel.org>,
  Naresh Kamboju <naresh.kamboju@linaro.org>,  Linux Kernel Functional
 Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
	<7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
Date: Tue, 27 Jun 2023 19:22:38 -0700
In-Reply-To: <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch> (Andrew Lunn's
	message of "Wed, 28 Jun 2023 03:16:43 +0200")
Message-ID: <87ilb8ba1d.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b694a0-dfd1-4d99-5be6-08db777e8ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4LfC+EvZIIhu0w3pHN+BZGxZ+LgABRt3/K7Zt5JS05J5Hk6uBSmZeKGvG48U+hrkUYtg+CI1cgAsEq4KGHvUcBTXZi9C4M5Nb7OdC6vnufnIIoph5aYnD5hagjvmyXeIRLYv5TYGqaW15UU3Cdcek4ZVM2X2oSF5mkfBlCbovSu0kVWBRKfb507NcAfgaecDhx68pUy/0znkE1LZfajV4HhTsCPbaJVSMBUTrJh88Ij4ja9Vxevz8oEulWjauj9GqIBa1+KXSrViDQVRwCe02pPZyfZj+BcIOoOemt3WirEqZy1vC1+Gwh+zMKMv53cAMkxi/6dRgWDzwTR2rhOIHJxodIUB4/NYihqn8abISBfLTiwOR5VRx4eCTahKEHAX2NtZII3z9LcLyf/6/I1NeG/KIK0iGZDLRpzGR9GltfiuFl5Cq9IBsBm2aFNZG6B4j0DMKKHhoJyXoa7bOHiCGkh2XFqSLKkmXzQ+0VZUbOd1CUTZHinZ76NTJeYQOM38/MRGb3EZZldwMVtLQUk8EyyRtaasKMoAr4nNK+CmPr14VyUQhlBsTeyev0L1IKjUK1SW2+2NcrFte3x3DaPfVBxWK5YpJFzNI7vKxotsIfyeGaRQwgtONniP7m/SMOSMXCjyg3vbJV+xhBFMBdNOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(83380400001)(6916009)(186003)(26005)(6506007)(6512007)(6666004)(6486002)(966005)(54906003)(478600001)(86362001)(2616005)(66476007)(66946007)(41300700001)(7416002)(316002)(4326008)(66556008)(8936002)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgGpArlEWXMHSC03IGCjbBvnL4kozKbUWJ6uBGAGZNJ1WFWDhOUGUJI08skr?=
 =?us-ascii?Q?OEwB/vExsLkxEOhiTISMEM/OKbfeQV8CmtZOgeYu9U8TZbwHQDAvxH6ixJlB?=
 =?us-ascii?Q?OxMqkNYyPtXbvbQyHm1iX9GPuxByGkxKyep/2brUCYSV4KrwnGKRhqUYvNtB?=
 =?us-ascii?Q?SaEj+fsaSqvwX0tVORhjauQIGVmSKormYD20XCtDsYXmwR6gpAI0pKGL/U9F?=
 =?us-ascii?Q?U2x2qX8y4pEar8PR1cCfaF35w+mKRql+iASFCpKvcdt7gUTHHs+GhEf5BkYa?=
 =?us-ascii?Q?GaWEAsGAzLBBPJtg6d0AlX07bhaJH6HJafa8unNz6tCntonOEiedPEmT4yXE?=
 =?us-ascii?Q?obGmQrbvxIpjNxAmxFyj8w7nVSV44kmk72GhGjBH3rBrV+RyH4Ogv/pM72mw?=
 =?us-ascii?Q?rK0e4z230/22ISjGhRgySCdBq7dQlH66YVXfXiNti0DQpnhesVR+neYmgoU5?=
 =?us-ascii?Q?2jgTvajOV/VWFe4xDG9Wqc32Zp2EgRmQVvAL/iJ8WokFEF43O+VZGoFH3VAH?=
 =?us-ascii?Q?O295+raxzLC0lUjckp/CHBV1qFLHbKNOettM4NFPhRcZTytXfWbMTx3aUbtz?=
 =?us-ascii?Q?jqM52DdGPmc4TiZtPUHqpagJ5uLRS8qDnnJZz3UhnCyiyBSVise7GN2bdGQY?=
 =?us-ascii?Q?B7W7KZAI4yfkTC2/gqh0HKyd8g51fXN6N1aA9hO5E4Q6wAItzMBVCVyfaYWS?=
 =?us-ascii?Q?WSCpucidatpfD1kwT0IlgTOwnWlgXoZvaqmM5eZ//Cy8iBjXvz2C4HM0aCWL?=
 =?us-ascii?Q?8kUfRkWt/DXYlX4OWm51hLX+xOHdur8oNfvo3PpLbAt78jRlhZ/6426Z27n/?=
 =?us-ascii?Q?Wg19zi/fi//q52ojWEe9HumY4aT8nkX4IRseFCRVeWSQgIv+DNQq7BLaM2bi?=
 =?us-ascii?Q?8Ij9c7p6iR3c5ZpacfXsQBYvb3Q1u1ZJsBTVqwxMIhkYwmPHQuD+xW8oOcHh?=
 =?us-ascii?Q?hAtNgcQwDmCwCcNuPiNcQaMDm6JA5jwc+3PGSdLn84IGeF5UWURjTiRVZjXn?=
 =?us-ascii?Q?Smb8jtUgAAPhVcvJVEyafV88udLnO3xRiWpD+/X3ak1xPzG3n3Ox8SFjeRRC?=
 =?us-ascii?Q?D/yUK1jJq6x6kcngTac11zQ2z1mHamrFwigi6YYhZ8gUCMayJqO5u1tkFudv?=
 =?us-ascii?Q?eeCb6w8j+Fy0B95UzKBX4yc6ZKBLpjYtSc4OIkEIodkirGAdWEGH05+FDTb2?=
 =?us-ascii?Q?QvsG2hPSVYugADTAMVVV0V8wX0DF5Vm7P1S9GEYPCcr6qU/DU5tsddmrbOz5?=
 =?us-ascii?Q?4k3SM5Y3zzfnjPFHt6K6UH5a1Kjmq23l80jRVmWiVS9hPoUI7ykq59L/16tJ?=
 =?us-ascii?Q?4g7HDEk2sf6/xjJWTpGOHuNBb/gDY2ZV7o6BARv6kGsHCJaDMndAIhZIQQbG?=
 =?us-ascii?Q?q2NwId4R4htSUNzAOL2utTbgdhn+/sxCyHox6YwzI9OXc1SHk+tQWN7C/mVR?=
 =?us-ascii?Q?8BmHrCQjYkPbAxVPT9qNqxMsyuqRKC3FCQiNj78W0mbVEeQYNhF72eoO5pVK?=
 =?us-ascii?Q?gEk8DAUFmWP/4VqOnGlbMx0mEB/l90ouJvZVttMILlDkF9bpoHEzyr+/e4Fd?=
 =?us-ascii?Q?meHBNdMWt7bEPHVJ5dnRk96b7t0x6uXaAvCOC8gLHMWbaboN06So6+Bd2IN2?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b694a0-dfd1-4d99-5be6-08db777e8ec2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:22:44.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp7ZYBm7cUu/vERbRClkoC8lehKPvkYmranswDTL7g94KVy5QoQkbMBwUSzFDkgJqnC9aW+/kvTavI7jHf+pPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 28 Jun, 2023 03:16:43 +0200 Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jun 27, 2023 at 04:21:39PM -0700, Rahul Rameshbabu wrote:
>> The .adjphase operation is an operation that is implemented only by certain
>> PHCs. The sysfs device attribute node for querying the maximum phase
>> adjustment supported should not be exposed on devices that do not support
>> .adjphase.
>> 
>> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
>> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/
>
> I think Signed-off-by should be last.

I can agree with this. Follows the "real route" of the patch, reports
came in and then the patch was implemented and signed-off.

>
>> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
>> index 77219cdcd683..6e4d5456a885 100644
>> --- a/drivers/ptp/ptp_sysfs.c
>> +++ b/drivers/ptp/ptp_sysfs.c
>> @@ -358,6 +358,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
>>  		   attr == &dev_attr_max_vclocks.attr) {
>>  		if (ptp->is_virtual_clock)
>>  			mode = 0;
>> +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
>> +		if (!info->adjphase || !info->getmaxphase)
>> +			mode = 0;
>
> Maybe it is time to turn this into a switch statement?

I agree. However, I do not want to conflate two separate things being a
bugfix and a cleanup. I think we can do one of two options.

  1. We can take this patch as is, but I submit a subsequent cleanup patch for
  this.
  2. I can turn this into a two patch submission where the first patch
  does the conversion.

I am a fan of the first option personally.

>
> I also wounder if this really is something for net. How do you think
> this patch matches against the stable rules?

Apologize in advance but not sure I am following along. The commit for
the patch the introduces the problematic logic has made its way to net
and this patch is a fix. Therefore, isn't net the right tree to target?

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c3b60ab7a4dff6e6e608e685b70ddc3d6b2aca81

>
>     Andrew

Thanks,

Rahul Rameshbabu

