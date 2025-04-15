Return-Path: <netdev+bounces-182574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F51A8926E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79703B7457
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34F215077;
	Tue, 15 Apr 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j1WBpnjY"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16A21323C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686846; cv=none; b=oizJkY0w14t0L08xmSaY4aIZz3rbJxQm2kwfRk471C52AxBoEb4SnIiq+V3w6FPJ2n1qOYIuD3V156mkmsJmOA9XUZW+ayP0mu9aoGeKfyuNztA13/OdqsBW7Oz1Bp824mdGF1JE+sJzPY6GqtOmb402rkBalcbyFAgZYwhHniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686846; c=relaxed/simple;
	bh=5Nj8N9v4V3zy/bm1kIRHGzCFw5OTZILcPj9dHz5jeys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQTwC4afk4+PJ5SiOJFT56gSeDMdW7Dxb326arybpqY5eyJl95RS0vKjqUwc706dWgVytOEXvoyf74u4FsIggE9RXjG7zz8aNROB9TDatf+rvZGRJD5+eBJ061Cgvr3LzF10fp2bj+e9p/BvUhp3afUs4DSSolZP+yOHS9sniTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j1WBpnjY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06e7bfb3-88fb-41ba-876c-a31cb46f3557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744686832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDjkqbAP1OiqGgRVIwoiUHC9xsTKg6jR4G+CB2Ipjz4=;
	b=j1WBpnjYwqBfHgrLi6XmjS03noUEr+rjFMtLNQmgqws2uaQeBkB/5PeF5vE+gYI/JKpwzl
	vmMhX8K0DVM3RIV/+3Awpp30r+duCAASQBXT1dhqYkrgpYa4/YNNFyqqyTIK7jKp1wInXk
	gjyaFQdVVAfSN169DrHjUb+VcnM7sXU=
Date: Tue, 15 Apr 2025 11:13:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 14/14] yt6801: update ethernet documentation
 and maintainer
To: corbet@lwn.net, Frank Sae <Frank.Sae@motor-comm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
 "andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
 horms@kernel.org, linux-doc@vger.kernel.org, geert+renesas@glider.be,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <20250408092835.3952-15-Frank.Sae@motor-comm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250408092835.3952-15-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Frank, Xiaogang, Zhang Fei, and Sun Hua,

在 4/8/25 5:28 PM, Frank Sae 写道:
> Add the yt6801.rst in ethernet/motorcomm folder
> Add the yt6801 entry in the index.rst.
> Add myself as the maintainer for the motorcomm ethernet driver.
Would it be possible to split it into two patches?

patch 1 Add docs
patch 2 Modify MAINTAINERS

> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
>   .../device_drivers/ethernet/index.rst         |  1 +
>   .../ethernet/motorcomm/yt6801.rst             | 20 +++++++++++++++++++
>   MAINTAINERS                                   |  8 ++++++++
>   3 files changed, 29 insertions(+)
>   create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> index 05d822b90..7a158af55 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -46,6 +46,7 @@ Contents:
>      mellanox/mlx5/index
>      meta/fbnic
>      microsoft/netvsc
> +   motorcomm/yt6801
>      neterion/s2io
>      netronome/nfp
>      pensando/ionic
> diff --git a/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
> new file mode 100644
> index 000000000..dd1e59c33
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================================================

> +Linux Base Driver for Motorcomm(R) Gigabit PCI Express Adapters
The title is great!

> +================================================================
> +

> +Motorcomm Gigabit Linux driver.
> +Copyright (c) 2021 - 2024 Motor-comm Co., Ltd.
I'm not sure if it's appropriate to write it this way. I don't object to 
them, but I think it's a bit strange to put them below the title.

Actually, this is a suitable place to write an introduction.

> +
> +

> +Contents
> +========
> +
> +- Support
Could this be all of the content? It appears to deviate slightly from 
the title.

> +
> +

> +Support
> +=======
> +If you got any problem, contact Motorcomm support team via support@motor-comm.com
> +and Cc: netdev.
I think this part of the content can be written in the code comments.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c5c2e2c1..1d7700e6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16351,6 +16351,14 @@ F:	drivers/most/
>   F:	drivers/staging/most/
>   F:	include/linux/most.h
>   
> +MOTORCOMM ETHERNET DRIVER
> +M:	Frank <Frank.Sae@motor-comm.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	https://www.motor-comm.com/

> +F:	Documentation/networking/device_drivers/ethernet/motorcomm/*
I'm quite interested in the long-term planning of this directory. 
Because compared with the documents in other parallel directories 
(wangxun is not a good example), there is still a great deal of content 
that needs to be written. Of course, I'm not sure if there are any 
engineers in your team whose mother tongue is Chinese. If it's 
convenient, it would be even better if a Chinese document could be 
prepared as well.


Thanks,
Yanteng


