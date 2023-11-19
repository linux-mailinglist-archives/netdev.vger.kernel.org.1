Return-Path: <netdev+bounces-49054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AE7F0863
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495F71C203A8
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722712E46;
	Sun, 19 Nov 2023 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTvUJdqD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E3C1
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 10:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb3pwOj8IZNpzET6eWCVSG3DG0DW4EHbz/YPui4SbQDsAwcYdkeSrjTfrdYfNLPMj6omMTEcpVdZcoSy+V0r5yi7ecrSN9ZIWXc99tIApXscJUjAUwxsgLtFdDEZiHrhVcaSt5dzSsHeowEtnrnRoF85oFrfEWENruvITxPK9I9zkIdONODNF+r30Nm6d/4ywTFgiFKvEAGlyMtFGfE2+6nYcbbd5STrBQhiScej3DxyyvP8kH3Kx+wtIPUAPzHUBxWwNPZHuC9elZ4tB84Xff6tkzQvKxu+0aewBgvqA5pU+VXdT9R6QL4UF95ymz2byHRoNMP7j632E3EBtV5G5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwa14e7SVx2fniMYDbbfDA2auj41lowZb00qk17+6fU=;
 b=TM2xoTtXDVDguhHBUQasN9FS2OrsQrkxg9tpYWRQEmQkfv5qO9PXddSxtSY6PmWqPa5pzYXZXdJoy0E52ud0QyXdpPS+1paRqWpbCRm5FPpK5JBplmKqsQV8yfA9mN7vLjCXDpDy1HsnKiFTvT3Rr3S9Esre8BDmzfQVff/Zef1iu4EAjzfDqewQ6HW3BVfvhVsQ02Be+LVc2calTFVDiGQRrx8a2GwR1cDTv1IxW8/G9ZorblpZ0UcIw0+qz6NWpwJ2E9m1hw7LD/m1OYXQUNsDsUToL+Dzmfz4V8VzQol4WTF0vwuaCW1DtsNs02HOw2Wa9dxUIIVt14u3JqB2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwa14e7SVx2fniMYDbbfDA2auj41lowZb00qk17+6fU=;
 b=jTvUJdqDbwkEeDsWKF3enHZIq+VfdW3F5Due8tTR3/qK80PJdj0rvuJ+1Sf01NNzxIz/BnbAmkbt0jCb69QbUUxHePdkJ/Pw1NoLoyDEHKTG1sOYgAddNm51rnZ/CVp3MnB9u9MnPgie3ohk1hpSr7VDLf74/GDDvZmgRsvVoLJyRqXDAnJvLiDCRDt4IvJCe9vTfeggL/sjbe3+5dmUUJ8GI/GYUyFCXtX/nRNkY3gJqKXCJbbsNIvSUENrzcGiFByjsTCL9FnPAxZT0QId8pnuospdrsfH2PmZXpEvl77qTDAGFQCmMXbELwkibQaMOH+dac1VSxg7HmzIfHVjhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 18:54:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4%3]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 18:54:17 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Saeed Mahameed' <saeed@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
  Tariq Toukan <tariqt@nvidia.com>,  Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net V2 14/15] net/mlx5e: Check return value of snprintf
 writing to fw_version buffer
References: <20231114215846.5902-1-saeed@kernel.org>
	<20231114215846.5902-15-saeed@kernel.org>
	<81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com>
Date: Sun, 19 Nov 2023 10:54:00 -0800
In-Reply-To: <81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com> (David
	Laight's message of "Sun, 19 Nov 2023 10:46:57 +0000")
Message-ID: <87v89xbmlz.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 4941d4fc-1433-4b73-0139-08dbe930ee79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JXYMTrgYgIkM51Qu0lzT7jDyDI6z24XtfzwXXhqb2kVZk69MrW955+EBXtDaq9pgPbhtvYmzfIPPtUcdii06bqLcZO57LY23Jc1pvERChCIT3lsHkdi6Vm4jP7wPR9D0lIEVKbqTUx00NEScOFaxFJ1qpLztHurJbivufWpwo7YGIIjlVpNljaD3SEhXKI+EJSNDIb/vhMMST9VLimLEp+hbHVDRTuERhyKtB18bwXdK+CyPjzaNP0OYzMO63VdERkRRX1OAyLkjhvujK/isPbZVgIGNSKh/zAQ02H9NWHZE++qyKexqayWVh3G2XReIACYYKr62wLCkbU4D6cj1ZCg64vvtw6CVQ8BnhgMzPlFFmG5mrEjyiwPvK8se1YyuJDuBma0vCtJ8TTvGMIfV41nCbjRO8G0s/qxzDKxlKnwT9xQCkID+zR0yfekvL+r2TT34cNWrPgIWjQK3U98CG2C/OgiPfYQqtpgNZ3gJ0fonfaGduebtF7nXf42ubGp5cdQ0FEW8FjULmn7nOegbqC8SmYq9Ztk/d3Lx/jzz8MdhSI9CeXdwlxQ6Gq8JygATpDpKku4gOWPDylEeQHLV2pcISz5suXQw6Oar1Pz8tPYRTqDBthtjZjy55Ko0AKWJyywtyNmWlUmmeBIDK7PKIFA7cFs9XiiuSNXCq1ABXm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(36756003)(5660300002)(86362001)(2906002)(6512007)(6506007)(107886003)(2616005)(26005)(83380400001)(6486002)(966005)(478600001)(6666004)(4326008)(8936002)(8676002)(38100700002)(66476007)(66556008)(54906003)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqTZDZWuL0Bm8SVLian4/l/AcR/1o+QsaPkIYObK+4r9z0dvpPUidSPKWsJS?=
 =?us-ascii?Q?AARXXkUvvYzW2dJADgcjdKO3SX7SQHHQIqshmAw/3hpF5/Q9VIYWki8nYohM?=
 =?us-ascii?Q?OpbruUVLw8sSOEG0a8fZA0lm24ipSU/S0BWwin7J5ZLPibEIklIfPQ3jLjBh?=
 =?us-ascii?Q?szRgu/QOKQ0I/UKH/eCeEM+bIQRnGg8ECophPtVCfwweF6NPqwUJTbxQGaua?=
 =?us-ascii?Q?C6r8LBhsIB1OSRJ2vxYWXAgoSTFXhu3trHgtkZvH9u7B9iO8c2bO3U9VozXg?=
 =?us-ascii?Q?O2N6O5NHnGid9MRNXVmv6hvhnkNGR29ZOqZMMPO1AbmXceid8tBw82Usguw4?=
 =?us-ascii?Q?TXheKXlIKnrz8H53WP7xWWJBNnhHOmR42JQyKGgfPX5Q0PokSZ/EVTbUNKg6?=
 =?us-ascii?Q?6okt+TraHoI277LLbEWOy1oI7aiNK8g2ZfiEx0Kx0jrkX1G4jfWPgfcJxTS4?=
 =?us-ascii?Q?R1vxui6whNRqFX7h4FuBOlTt3CBPXCWKK2aljZRJlVfj5/h+tR1Lu9ExyfqB?=
 =?us-ascii?Q?bNGgoxI6iP43NkeX3H9j1utQNW/DF6amF/hkO5K1ZMF/ls4fVqZE3pCd91tE?=
 =?us-ascii?Q?VExVSbaB9RivzO/WwReYK+hnK0+gtn5gx+Tzp6eXxFU6I3QHwaQAF/65xkpO?=
 =?us-ascii?Q?AlbOwdEbdhh/+Tj5pQpRGRm4MMmBxIXD6yzmR82GNny+AHSbug52HsOJOCJB?=
 =?us-ascii?Q?B2+Jd75/BPXHLRTto8XpgReC6Vf4jmJ7o4Ng84G57a3WI2NvsGYZAPuOgBwe?=
 =?us-ascii?Q?gKsmNO+ZIv41glLm0lI4zV2e+BRUaUU8ybQFW0/KlV6lqQRA7+QDbP2wbAiP?=
 =?us-ascii?Q?7l3GUI7dvTOjSG8Yy0dIlu77XOKxQvkMdiGGy2ueCdlWjF5KQlWoIR95QhMg?=
 =?us-ascii?Q?KMJllFKuHeDhCBVGkf4hWmqt5bi/rLBUxmvVXKuBBGHwivruJUNG6xV62ox3?=
 =?us-ascii?Q?cYIndq5lZePkIcqiYXKT2/09ZiIwAc1r2z19WD9Sz7XN/DCC+Zxxq3HzK8t6?=
 =?us-ascii?Q?PkDdQHwBrdm688ryUh6uD5KEoS3+Kc9xMPp+Hf8ZxcmE+L0TC1Gs8A9Bhy5Z?=
 =?us-ascii?Q?OTsordnRudxLeT6lYlJ3CAE5wvfv7R2HySVkxZ/xiNEOjheyCR/wnz1Y046q?=
 =?us-ascii?Q?OMudKRN88KqCkSx+kyInNcmhAILXWi1ZR6dyb31FCLAZUtyfZekt6ZKNgr7A?=
 =?us-ascii?Q?UG8BYVvdWdEc+++G5knGXvF9ZMgR3GpyawydU5HO7pwOsbUWvx8Wrf0WuSEV?=
 =?us-ascii?Q?h6xsbGjt782zCGjH2wYsE9j4I6TuOghAwMfSmV4hxlegD3oZ33vR8VHV6yHz?=
 =?us-ascii?Q?aTOYuC7BZPT5hmVQjvJuHGzp7qfRE7sET5T6A7NSUA6yQq0PcB7bI6o1sDtV?=
 =?us-ascii?Q?M4kv1p8U3+qYqICKoV+YAy3Xb2ilE6el66gzDuaRDeC+W5VqEr0/3iPXxPfy?=
 =?us-ascii?Q?LA/tlAKJTkCOOavIHnYg4TjAY3JyBNGN2605vvS+0jBWeLXxHKnn1LxAbwdh?=
 =?us-ascii?Q?EdlKG++V9mOojUbNLVjjS4YpAkV5+NFBpm62714zJiDU0KwprKYwkGGVOnxq?=
 =?us-ascii?Q?BbNQOkbkn0RtmYBY2a6E2K3PmTtO1j2qy6Z8Z9oF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4941d4fc-1433-4b73-0139-08dbe930ee79
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 18:54:17.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAJsU7/5xOagPe2G2hC17Neq44g/a8gekyWO5vbvVwAJVnhcwmo7Y457Vm/L2eQYu3jRsTixTMnS7QrEzpid6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

On Sun, 19 Nov, 2023 10:46:57 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> From: Saeed Mahameed
>> Sent: 14 November 2023 21:59
>> 
>> Treat the operation as an error case when the return value is equivalent to
>> the size of the name buffer. Failed to write null terminator to the name
>> buffer, making the string malformed and should not be used. Provide a
>> string with only the firmware version when forming the string with the
>> board id fails.
>
> Nak.
>
> RTFM snprintf().
>
>> 
>> Without check, will trigger -Wformat-truncation with W=1.
>> 
>>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c: In function 'mlx5e_ethtool_get_drvinfo':
>>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:49:31: warning: '%.16s' directive output may
>> be truncated writing up to 16 bytes into a region of size between 13 and 22 [-Wformat-truncation=]
>>       49 |                  "%d.%d.%04d (%.16s)",
>>          |                               ^~~~~
>>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:48:9: note: 'snprintf' output between 12 and
>> 37 bytes into a destination of size 32
>>       48 |         snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       49 |                  "%d.%d.%04d (%.16s)",
>>          |                  ~~~~~~~~~~~~~~~~~~~~~
>>       50 |                  fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
>>          |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       51 |                  mdev->board_id);
>>          |                  ~~~~~~~~~~~~~~~
>> 
>> Fixes: 84e11edb71de ("net/mlx5e: Show board id in ethtool driver information")
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae7176
>> 1a9d8e5e41cc732c
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 215261a69255..792a0ea544cd 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -43,12 +43,17 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
>>  			       struct ethtool_drvinfo *drvinfo)
>>  {
>>  	struct mlx5_core_dev *mdev = priv->mdev;
>> +	int count;
>> 
>>  	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
>> -	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>> -		 "%d.%d.%04d (%.16s)",
>> -		 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
>> -		 mdev->board_id);
>> +	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>> +			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
>> +			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
>> +	if (count == sizeof(drvinfo->fw_version))

This should be >= now that I think about it.

From the kernel docs: If the return is greater than or equal to size,
the resulting string is truncated.

The return value *can* be greater than the size parameter expressing
what the length would have been.

https://docs.kernel.org/core-api/kernel-api.html#c.snprintf

>> +		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>> +			 "%d.%d.%04d", fw_rev_maj(mdev),
>> +			 fw_rev_min(mdev), fw_rev_sub(mdev));
>> +
>>  	strscpy(drvinfo->bus_info, dev_name(mdev->device),
>>  		sizeof(drvinfo->bus_info));
>>  }
>> --
>> 2.41.0
>> 

--
Thanks,

Rahul Rameshbabu

