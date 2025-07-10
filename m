Return-Path: <netdev+bounces-205660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAF4AFF891
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 07:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C68562DBE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72028540F;
	Thu, 10 Jul 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db3VTi44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F9284B2E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126290; cv=none; b=Jc5+2KISetZJbRbSZfeKrFq8neko9AW5wl1omM/3kbReIURhRuzxooSFH43SKv1SFBNzlcH5a/U/LeXY3AXR4BuAHlQe7x7Z0SACFyDnD9nyColDQv29aP+i953nzr9p8U6zD9KKjGZfrZRvHYDzzKvqrbaA/zyBH8oy5AKR0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126290; c=relaxed/simple;
	bh=Z5Wx4lIjk++hUL947Li6KQCLDmY/rZH7tZACSF8THIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlCfVvYtq4Ssz7+WqMKufwy1u7SZrTBLXYt17T89lNMMd4F4MHjzK+IfwqWGjwU70B7VY+HveSV/7ko9ZTTsh/Q3EYrAt3TAFlcS3s5zfXJuO8Uc275gxPLhI6FTUcHPAIAbiJ1Mq9lyOIQqVKQNJ34ew2BU0SilRfkmvNXPILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db3VTi44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9AFC4CEF4;
	Thu, 10 Jul 2025 05:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752126289;
	bh=Z5Wx4lIjk++hUL947Li6KQCLDmY/rZH7tZACSF8THIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=db3VTi442a7VOkQef0dzJil54jlGvPGXNb764OCz1mVAtKCH8fOF2HWP6uwSdpUqI
	 +sWXcZ+sQ4w36hLonvZ40l9UfKGB+vP3M6A/3900AiTC7XImECoyl79MzHln17Y9tD
	 Z0XE1MF4e2rEgs+j0Ehc4Pc/sp6l3dc+OSd7f+r4g1ysu5RLKISVFxyzHs9i17uwTe
	 e6nmaNQx98yJq1GX3/ha5ApPQSLwsX32TQBwjjeFIcArf1ofOvpJqnSh4RU91kQRrD
	 Tu61/cQvtKU3TE2YS6YLbtVuhdCWzu7PLdqdMbSWIVpb6I0vSN/DhaGWuX6nvj0FaV
	 jfglbi+gb09Lw==
Date: Wed, 9 Jul 2025 22:44:48 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 02/13] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <aG9TUPziunm1tRgR@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-3-saeed@kernel.org>
 <20250709195300.6d393e90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250709195300.6d393e90@kernel.org>

On 09 Jul 19:53, Jakub Kicinski wrote:
>On Tue,  8 Jul 2025 20:04:44 -0700 Saeed Mahameed wrote:
>> Selects which algorithm should be used by the NIC in order to decide rate of
>> CQE compression dependeng on PCIe bus conditions.
>>
>> Supported values:
>>
>> 1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
>>    but maintaining a balance between bandwidth savings and performance
>> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>>    compression rate and maximizing performance, particularly under high
>>    traffic loads.
>
>This description sounds like 'aggressive' always  wins. Higher
>compression rate and higher performance. You gotta describe the trade
>offs for the knobs.

Right I will add few words on latency costs.

>
>> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>> index 7febe0aecd53..417e5cdcd35d 100644
>> --- a/Documentation/networking/devlink/mlx5.rst
>> +++ b/Documentation/networking/devlink/mlx5.rst
>> @@ -117,6 +117,15 @@ parameters.
>>       - driverinit
>>       - Control the size (in packets) of the hairpin queues.
>>
>> +   * - ``cqe_compress_type``
>> +     - string
>> +     - permanent
>> +     - Configure which algorithm should be used by the NIC in order to decide
>> +       rate of CQE compression dependeng on PCIe bus conditions.
>> +
>> +       * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
>> +       * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
>
>Line wrap please.

ack.

>
>You already have a rx_cqe_compress ethtool priv flag.
>Why is this needed and how it differs.
>Is it just the default value for the ethtool setting?

cqe compression can be enabled or disabled per queue,
the priv flag is to enable/disable it on the netdev queues.

This permanent devlink parameter selects the internal ASIC
mechanism/algorithm for compression which is global for
all the queues that enable compression.

>-- 
>pw-bot: cr

