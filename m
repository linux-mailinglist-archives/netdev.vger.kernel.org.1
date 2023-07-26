Return-Path: <netdev+bounces-21643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD875764146
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78699281FD0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204001BF0F;
	Wed, 26 Jul 2023 21:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C371BEEA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB3C433C8;
	Wed, 26 Jul 2023 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407240;
	bh=C91Krd55OrPIx5Jyw6mn5zYw0gxr/XSzRAIUuYIkFTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InioLv+zRG/gAe/lMz9n2yBf0TxnjKCqMq8j4mYMqg4GCbcPfHOKwHAZyg6nFPa6V
	 0e4SU9w9LqznX9YZFNt6oRlA+YO1EMt/GOhqfD6e8ww1zrYABS8ClfRGe31jC5BMQn
	 e85nwDR99YgpKU+88XUhLILxbjkWnunp/AVJ3XkNqAAYgIZwt0asEykyf0ChViO+0T
	 eHl6pwpf25WCT5SgO4t2I3CMVgTmM0dOM/LxY9v8T+JVQooQO2PXAau06L8FqoJTGa
	 levET5moNX9Qrg9GZlBVnc49tWtvOc2tWYGMNiwfshgrsdoeijCXR1qpWsfAKe6Hvy
	 Sp+AIp6e0jVvg==
Date: Wed, 26 Jul 2023 14:34:00 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [net-next 02/14] net/mlx5: Expose NIC temperature via hardware
 monitoring kernel API
Message-ID: <ZMGRSFy04JHCthin@x130>
References: <20230724224426.231024-1-saeed@kernel.org>
 <20230724224426.231024-3-saeed@kernel.org>
 <20230725203152.363d5dae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230725203152.363d5dae@kernel.org>

On 25 Jul 20:31, Jakub Kicinski wrote:
>On Mon, 24 Jul 2023 15:44:14 -0700 Saeed Mahameed wrote:
>> Expose NIC temperature by implementing hwmon kernel API, which turns
>> current thermal zone kernel API to redundant.
>>
>> For each one of the supported and exposed thermal diode sensors, expose
>> the following attributes:
>> 1) Input temperature.
>> 2) Highest temperature.
>> 3) Temperature label.
>> 4) Temperature critical max value:
>>    refers to the high threshold of Warning Event. Will be exposed as
>>    `tempY_crit` hwmon attribute (RO attribute). For example for
>>    ConnectX5 HCA's this temperature value will be 105 Celsius, 10
>>    degrees lower than the HW shutdown temperature).
>> 5) Temperature reset history: resets highest temperature.
>>
>> For example, for dualport ConnectX5 NIC with a single IC thermal diode
>> sensor will have 2 hwmon directories (one for each PCI function)
>> under "/sys/class/hwmon/hwmon[X,Y]".
>>
>> Listing one of the directories above (hwmonX/Y) generates the
>> corresponding output below:
>>
>> $ grep -H -d skip . /sys/class/hwmon/hwmon0/*
>
>I missed it glancing on the series yesterday because it's just
>a warning in pw - we should really get hwmon folks and ML CCed
>on this one.

Ok I will remove this patch from the series and send it separately with the
proper CCs.

>-- 
>pw-bot: cr

