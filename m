Return-Path: <netdev+bounces-30141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70647862B9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039E01C20D40
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A79200AA;
	Wed, 23 Aug 2023 21:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971921FB35
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 21:46:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EDD3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na8xjUoi0/G/JD+l9fJAaXfvpE/EuFqIhr1n9m2GFak469YvtvUvl+qv5V6p2k5BUhqav7RVNl2huAPphaJp+n37neBlu2dQx0uDPJllv/HSTzcHldEeD9Dfrm2gcvKuHcMCGbDataTkTO/7IcxjY44wRQGKKuKONKI5UKq6IvwA2TNlh5103JBzGqitRoLyd3ErPumAg9xDHgxIuumaUobzLVdGCkeE+/N0rS0LbV0REIyLPU4DFQLr2r2k7QVjUEntMxchLycneR1lmAQKi+RSNgavag2Mqm1x7IvslS8dQKIZeZYT3mixfiYkc2QC5fbWEwR6Zn8Lgf5GNxqsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb1llyXgSZeJ1Hs/9wV8kZ2FGuHXHhFfhWnbOTK6+EY=;
 b=DvmZ8PNbvGTiis4h/ZH/+JZeyFEU+nnF1z49CTl9lsUnZhXj5SN/lDaudSKhv9qdpfiQvIFh9Br0jZfWaAhsSl4dZeZQuOH0hwbY7eCnbT/OLUjQ8WETmuk9QUlkl+HJ+LaTedrcvGzknKUUIBWVDl6IbnnQvSqctEkWRRZcxsSG5MTKwxjazL3LiKRYPssQJjDtCjeEKtGhUlTOxDqjDdpt36mT1TBHExEkqGVd5zgX/IHgTHcFafPGCO7G6/+t048YIsfZFF8afKCJ6cw7Jvpi2qvqbYMdmiQb1lO1QpAaec24HfkXh5OuhSOA6qORlIie72nj9vU9SVfdSYFKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb1llyXgSZeJ1Hs/9wV8kZ2FGuHXHhFfhWnbOTK6+EY=;
 b=n99aXjreVQeIvFjy0Br0e88UzQCa7aSHObhWvSfZp85NJ91r5wBk6BCCU8gZr08ibUqj3shdwaqBzHoxQ4iNdO3mx78sDadm7NPUIf0nULYv9GcNYpNKmr+4NghzzCImB3ET3MeljDDKn/uPLQpCO1rkF0wo0TGVK4n93ZJy6pifurgyja3UAXM9ZLpA0eTw8HkSjAxnugg8v+Z1ADloAAwjZNZ2kVeL1l1YhjZslY0U+ySjtBt/lp7hm0Ja5HyfGyOw3dJaB+8oCFHrZ8UzLEf4CvDREoafOPVzxTE2+aqvFC9VBDGEFKK7wTBqyUmd9SzMMNpE2j18IpJrcP/GhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 21:46:35 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 21:46:35 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <netdev@vger.kernel.org>,  Saeed Mahameed <saeed@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Richard Cochran <richardcochran@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  Paolo Abeni
 <pabeni@redhat.com>,  Vadim Fedorenko <vadfed@meta.com>,  Kenneth Klette
 Jonassen <kenneth.jonassen@bridgetech.tv>
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation
 for PTP free running clock
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
	<82ddc62b-4d2c-cf6f-f5c8-812ce795a494@intel.com>
Date: Wed, 23 Aug 2023 14:46:20 -0700
In-Reply-To: <82ddc62b-4d2c-cf6f-f5c8-812ce795a494@intel.com> (Jacob Keller's
	message of "Wed, 23 Aug 2023 12:54:21 -0700")
Message-ID: <87wmxl5t5f.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b45297-a72f-45e5-37fa-08dba4226c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WheGhGlniIGgU/a5q3I6yR/m2hecF9PRCOjAMRrmWzJs+ShXTSiQ9ePgTNbeO1C9bpBUNtpm3LVQo1+h6r0wnoWqdhcIr3xaQCL+OyB5ej3sHQ1bwYrvkQ8Cf78YGYIJnrT33Or/k7dZjgTYeo2ObS7/tr4ymQRLadszhoMMOmdhhMUSzExw90sUX0pN50r7j+qTXpF4yws8rqKiaE9LS8rlJclT5BwEFE4CQCi4npwRSWUpXxFyzVw4wTum2EUTclmB9jN8PLiLSgtnruNSNhClPaacGAO8k76jj3NcR9r1xK6954oi3FbXv8AMKwKf95mVLjAz661kQgvhc2v60s9E46rALXvG3UD6AcM2gr+dzavK9zdc0cpKsE3AYn7fmyTzgjpxALljI+NLxIvYqbbVT0MzQ1R0eCXqiIdkVdlb75P1rUlpHb1fp01/v+wMUVQ9Kz/Rc19IUKJxFF2CaWrobqH7CI1J3J9L9jQd8Kd8/VzvDQtqGdiPFbXiKo5Fh3K3kS2WsnGP34+lXoRXDF0x4cJLU0RZRKDlUIrCJjTYskez7+RkQTHyDnktaZWiW3wyKOjJqVoW/FyDiFZN5a1RNpLooHZtPMcZkKPmnI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(478600001)(966005)(86362001)(36756003)(6486002)(6506007)(66476007)(54906003)(66556008)(316002)(6916009)(66946007)(53546011)(6666004)(41300700001)(6512007)(38100700002)(8676002)(4326008)(8936002)(5660300002)(26005)(2616005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x60BnbeD3Eoi7OooBK30nXUmI4cB1X6VC9suPEqnf0+7VbKNNPvF4WOkuruZ?=
 =?us-ascii?Q?AT3MHY9+W5t75WKuffzrwG5rt3ItvgT/b06EOb6jfRqudebp4rjYMtvAIa2o?=
 =?us-ascii?Q?Px+XCVQyYgmfv3uH/1oIL3J5/jkS4mB5+jnAlr3jbctlMTeQIziL2z/NHvNl?=
 =?us-ascii?Q?grlJBZlYURx24yQDDgJxJ0Ingjiu+81SUMlRNOvLHCQtAyfkzFFeITa9lUm8?=
 =?us-ascii?Q?yMBSYZTx7l5nUTe6jpa2MdCUG732KEPqkmL26on7k8DpHYHdIwGel6lJF460?=
 =?us-ascii?Q?m3MiZMXEww22L7gOqLyuAcksoJLfucyvw9gEs5gXaSItBtAGzimWdJf/VhDN?=
 =?us-ascii?Q?rCg0iN05w8dlrkGlv3cntP7xHaq3CzQE3CvHW4fxV/KXAhnl5ScdBKskchO9?=
 =?us-ascii?Q?oVDRHn74BWPJ24T8Yqr6vBE4TPI0lIPs0hIzJbopKkbePqLmTljSp7+7hMbq?=
 =?us-ascii?Q?zQse7+Bt6WOkb53W/S9eruqH4UP0qzgBlvSsKqZeblGPs7J8K7W9/T6VvXLh?=
 =?us-ascii?Q?PcrHRABRojKYEDCxqnQOGIk7uSBz5fXVY6UkYVqxvjBkds72IrDbPQrOx0U/?=
 =?us-ascii?Q?svMkcSW3ld7dpRh7BFivHfZZzwZf6r7RE0eoASv52qW0VL08XlUTi4kIzaFy?=
 =?us-ascii?Q?fbk9QMID6MczYzZY0sRKj86a98Fqp2apYO4nLGaENtSU1ffs/LX+V+a7WUt5?=
 =?us-ascii?Q?xptw1NGA4vC786rqbcgaVqo98mIqrYBvmEM4PCL/Z4RuE5joCE/1++P/anp6?=
 =?us-ascii?Q?pLnjsHiKP+nsKS9olksT4fdruuYmAuDFOmA180Mjz1WTKCh33nrAHsm4RYnm?=
 =?us-ascii?Q?DrfhJCyAjga9kTXfLhTH/ykNKsKW29UVrs60uZQr5RAwsN1mJQMEgl4qhbcX?=
 =?us-ascii?Q?hlQDc4JwXFbn4150EJn00HFt2S+W/l/SbuozchcjCpGjW1jsJeouuCS5f4BX?=
 =?us-ascii?Q?xc81uUMkVxCe99c1wBzKMOznwwdoA1K4T/mNmqMWzsPoq3ybmNth4uIhUT9I?=
 =?us-ascii?Q?t8vB5B7+CuTYhTNXKBUY+f+sMLdKi9s75VdijKPlM7N+hQ+2m+OdwCHwSl3P?=
 =?us-ascii?Q?NHyQaVs0NwmlxxUsYI7vpsoQky0wuKh7geBQBS6JBB1mfObQcVSm3tqzvPxF?=
 =?us-ascii?Q?/Fm74rBaZ5oCeeGd7BwfYtDCsLDY24MoJlIN9PqTpmy6SlC4PATNxocpSMu6?=
 =?us-ascii?Q?2k1xXBb3pIWPlEafRQa4I52vBzXvWvYqr+TVsdMu+mRXg4PPO1XkVVUJkSoA?=
 =?us-ascii?Q?a6fPNwiPBnhTwIDLj2MMi6rr4H3MVdzkqkwPNzY7W3Qdqfgo30QfESZdDhde?=
 =?us-ascii?Q?VnQVvZbo/TFRY9lFwgQnyQE30KzMKovJMmp5XMOSWNRdIwqCLjRZnvIJa7Lm?=
 =?us-ascii?Q?j0XCfl86JDwNNeGUR0jagbvdZ8lghtkgjyLrrw2GmU8seEkHROVWH8CmsrpP?=
 =?us-ascii?Q?CQ+f6RzqOBEsfTITfsOXo/rruE+rYSFIkxt7/aHA48SOUe5FZyWr/Jg8RUXo?=
 =?us-ascii?Q?MMx7pABqa1oU1cWDoTyFq1NANF8DPS996d8d1e5EpsmkVimhwChAYqW5bJEZ?=
 =?us-ascii?Q?Z2qERue8RB5FEGZITOUo7sJrn6WNfqNX+Q3FrJldfyX4Qa6WUB6XLR4JVKUR?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b45297-a72f-45e5-37fa-08dba4226c0a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 21:46:35.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7H6SuKSa/OErT07ptQBBAVahpDDCxRQ9Hib/5GXcvXiZKBkG3++dWH34Q1FuXKnWZusE5fHFPQCVTvRQLgpV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 23 Aug, 2023 12:54:21 -0700 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 8/21/2023 4:05 PM, Rahul Rameshbabu wrote:
>> Use a dynamic calculation to determine the shift value for the internal
>> timer cyclecounter that will lead to the highest precision frequency
>> adjustments. Previously used a constant for the shift value assuming all
>> devices supported by the driver had a nominal frequency of 1GHz. However,
>> there are devices that operate at different frequencies. The previous shift
>> value constant would break the PHC functionality for those devices.
>> 
>> Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
>> Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>> 
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
>> Notes:
>>     Devices tested on:
>>     
>>       * ConnectX 4
>>       * ConnectX 4-Lx
>>       * ConnectX 5
>>       * ConnectX 6
>>       * ConnectX 6-Dx
>>       * ConnectX 7
>> 
>>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 ++++++++++++++++---
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index 377372f0578a..aa29f09e8356 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -32,16 +32,13 @@
>>  
>>  #include <linux/clocksource.h>
>>  #include <linux/highmem.h>
>> +#include <linux/log2.h>
>>  #include <linux/ptp_clock_kernel.h>
>>  #include <rdma/mlx5-abi.h>
>>  #include "lib/eq.h"
>>  #include "en.h"
>>  #include "clock.h"
>>  
>> -enum {
>> -	MLX5_CYCLES_SHIFT	= 31
>> -};
>> -
>>  enum {
>>  	MLX5_PIN_MODE_IN		= 0x0,
>>  	MLX5_PIN_MODE_OUT		= 0x1,
>> @@ -93,6 +90,31 @@ static bool mlx5_modify_mtutc_allowed(struct mlx5_core_dev *mdev)
>>  	return MLX5_CAP_MCAM_FEATURE(mdev, ptpcyc2realtime_modify);
>>  }
>>  
>> +static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
>> +{
>> +	/* Optimal shift constant leads to corrections above just 1 scaled ppm.
>> +	 *
>> +	 * Two sets of equations are needed to derive the optimal shift
>> +	 * constant for the cyclecounter.
>> +	 *
>> +	 *    dev_freq_khz * 1000 / 2^shift_constant = 1 scaled_ppm
>> +	 *    ppb = scaled_ppm * 1000 / 2^16
>> +	 *
>> +	 * Using the two equations together
>> +	 *
>> +	 *    dev_freq_khz * 1000 / 1 scaled_ppm = 2^shift_constant
>> +	 *    dev_freq_khz * 2^16 / 1 ppb = 2^shift_constant
>> +	 *    dev_freq_khz = 2^(shift_constant - 16)
>> +	 *
>> +	 * then yields
>> +	 *
>> +	 *    shift_constant = ilog2(dev_freq_khz) + 16
>> +	 */
>> +
>
> I appreciate the derivation here. It helps understand the calculation
> here, and makes it clear why this is the best constant. Deriving it in
> terms of the frequency is useful since it makes supporting other
> frequencies much simpler in the future if thats ever necessary for the
> device family, rather than just adding a table of known frequencies. Nice!
>
>> +	return min(ilog2(dev_freq_khz) + 16,
>> +		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
>> +}
>> +
>>  static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
>>  {
>>  	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
>> @@ -909,7 +931,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
>>  
>>  	dev_freq = MLX5_CAP_GEN(mdev, device_frequency_khz);
>>  	timer->cycles.read = read_internal_timer;
>> -	timer->cycles.shift = MLX5_CYCLES_SHIFT;
>> +	timer->cycles.shift = mlx5_ptp_shift_constant(dev_freq);
>>  	timer->cycles.mult = clocksource_khz2mult(dev_freq,
>>  						  timer->cycles.shift);
>
> And you already derive the multiplier in terms of the frequency and
> shift, so the change in shift won't break the multiplier. Good.
>
>>  	timer->nominal_c_mult = timer->cycles.mult;
>
>
> Not really an issue of this patch, but a few drivers use a nominal
> multiplier in calculations with timecounter and cycle counter, I wonder
> if this could be baked into the cyclecounter code in the future...

This ran through my mind as I was making this patch. As you mentioned,
the logic used here is not specific to mlx5. Rather, it's a general
calculator for the shift value given a frequency. I wanted to look at
all the use cases of cyclecounter before providing a general API for
this. I will likely follow up with you if I have concerns with regards
to the generalization for the cyclecounter API and hopefully can share
an RFC.

Thanks,

Rahul Rameshbabu

>
> At any rate, this fix looks good to me.

