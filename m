Return-Path: <netdev+bounces-69337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DA84AB41
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E45289B92
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64012646;
	Tue,  6 Feb 2024 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI/vqiUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107F10F4
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180994; cv=none; b=ivuRC9NIYD9Sxw0ru4gKjEtykAx+is1g/IECWV4B48g6za3PbXj+sT4mTNhlk2DWGx+hpdsQbGYdK4cKPFtMIml1cBHn2fkKmjpljHDr9MRlkLtLaGP/npDsrs0WSL9Uo9VthKg6KIiAYicXIotlZFM4yRNFHD08zapqLfxTVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180994; c=relaxed/simple;
	bh=6ZssyP4M/OUfBFwgrVVpvy3y6KOZHJMB+La9o2a83Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPqNHKN+/STgjtekmjO4pJ36U/mArsaQGieqACWHwQf+7reRrPeY3yQA+motKpk1cO38x+bOM4wB93W1cdp65ksBhAUitrX+6wCiH31fJctc5jvJWnZJIyhfk+Gf54atRjHSdMlq+o+05AtGszLK4fZJHMQ1RRyRtpgUcA+jw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI/vqiUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01374C433C7;
	Tue,  6 Feb 2024 00:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180994;
	bh=6ZssyP4M/OUfBFwgrVVpvy3y6KOZHJMB+La9o2a83Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI/vqiUNopa4P52qrDLNxMUMQIC9PRZ66qexxr6X2dm1TzfrzRIOgavbp03cfFKTz
	 L7twlI/qjvFI+OZG5PElCgQqVYlmzI8WB5AZv38DJNAX4iNXXwa1oQhdgJodc6W2+N
	 +1ohcMacP7++iHNqICqdjpEUMD7V6qADvPBeumhkAt5NhlzYCIOQgjWuVxNzicIy/g
	 Qc3V/TphsWxofK8vlouEcV4cDMpPzPLg/c+OnJYhuJO02DY3ugd1R32Q9BvGudQonA
	 XxPkGTvYZvQaLWBp+hsVIZc5N3/VMwQWwnu86tU8bGzrtLfQr9XXBVGfSPXhiyhtDY
	 K8sVxOJGwv4sw==
Date: Mon, 5 Feb 2024 16:56:32 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [net-next V3 13/15] net/mlx5: DR, Change SWS usage to debug fs
 seq_file interface
Message-ID: <ZcGDwJDGvX2WwqEg@x130>
References: <20240202190854.1308089-1-saeed@kernel.org>
 <20240202190854.1308089-14-saeed@kernel.org>
 <20240204142448.GA941651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240204142448.GA941651@kernel.org>

On 04 Feb 14:24, Simon Horman wrote:
>On Fri, Feb 02, 2024 at 11:08:52AM -0800, Saeed Mahameed wrote:
>> From: Hamdan Igbaria <hamdani@nvidia.com>
>>
>> In current SWS debug dump mechanism we implement the seq_file interface,
>> but we only implement the 'show' callback to dump the whole steering DB
>> with a single call to this callback.
>>
>> However, for large data size the seq_printf function will fail to
>> allocate a buffer with the adequate capacity to hold such data.
>>
>> This patch solves this problem by utilizing the seq_file interface
>> mechanism in the following way:
>>  - when the user triggers a dump procedure, we will allocate a list of
>>    buffers that hold the whole data dump (in the start callback)
>>  - using the start, next, show and stop callbacks of the seq_file
>>    API we iterate through the list and dump the whole data
>>
>> Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>>  .../mellanox/mlx5/core/steering/dr_dbg.c      | 735 ++++++++++++++----
>>  .../mellanox/mlx5/core/steering/dr_dbg.h      |  20 +
>>  2 files changed, 620 insertions(+), 135 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
>
>...
>
>> +static struct mlx5dr_dbg_dump_data *
>> +mlx5dr_dbg_create_dump_data(void)
>> +{
>> +	struct mlx5dr_dbg_dump_data *dump_data;
>> +
>> +	dump_data = kzalloc(sizeof(*dump_data), GFP_KERNEL);
>> +	if (!dump_data)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&dump_data->buff_list);
>> +
>> +	if (!mlx5dr_dbg_dump_data_init_new_buff(dump_data))
>> +		kfree(dump_data);
>
>Hi Hamdan and Saeed,
>
>dump_data may be freed above.
>But it is returned unconditionally below.
>This seems a little odd.
>
>Flagged by Smatch and Coccinelle.
>


Thanks Simon, Fixed in V4.

