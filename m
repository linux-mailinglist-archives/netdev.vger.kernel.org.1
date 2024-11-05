Return-Path: <netdev+bounces-141996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E689BCE89
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FD1C20444
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C81D47BD;
	Tue,  5 Nov 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP7SG5rM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC01DA5F;
	Tue,  5 Nov 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815248; cv=none; b=AMLKnYoPX53qKrsrul1Wvy/fzO2y2Toobpww6BOthTDd3fs/dwlfSXiT8xHv7r5gAA4Z7SjrWWenUpZf7BGG3CaMPkGpU3YPP2TiaU8xMvCwvzLuITmlVctYSAUP9Ef4rcUOTFaOusVgqpZ11aVTW2z2srVoEVCDAGMsBSFdKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815248; c=relaxed/simple;
	bh=YCW0XGeSSzzVQLlrqXv/VoQiYY8Ddc0JcOH7fxYi49E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkZ8yDT7cU6fSk1+Ka95I9qKR+NwfO9vw1tOLWVqsMonR2/H+0X6+RQmMeUFxVRUWQmedy0yuPWFiUpWUgBs8+82z0h+jFoF2bHtjz2kJJzDYc7KOJBdgWYDq3TJiKTXvgYGKsIrmRVX22Eit4cyi23cP2l462OX/lTL9G1owxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP7SG5rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEB8C4CECF;
	Tue,  5 Nov 2024 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815247;
	bh=YCW0XGeSSzzVQLlrqXv/VoQiYY8Ddc0JcOH7fxYi49E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lP7SG5rMXgGJnNkX17yiqKaryOUIskjfDIuZ5hPwuNKDueqQCa+o+gL7pxZqOK3MM
	 7GASBJS7IuzqA8TA83KJagYa1Xls0pNNyjaShM47l/zw+q6EFHkZNaMR/q0exi0UCd
	 AiR3BxaULqXxGj5mU1D9M6JyLbtjeDTeoyROtKFvCbrePzWn3chfMQNcBxCI63kLrs
	 B4xSDgKFlR4+1UKfNmR5hKrMGlcTJbFXuoGwnREtL0RCFG1wLPlXLZVO4ncnTewkdH
	 dQ0ue+RTSbYMKDfyiG15cazCLmwCsa7fyZ33XsFsuTjJCOx6CUyT0jxfrxGuJ5gYch
	 bb5gUvFzuPMOQ==
Date: Tue, 5 Nov 2024 14:00:43 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: hisilicon: hns3: use ethtool string helpers
Message-ID: <20241105140043.GF4507@kernel.org>
References: <20241101220023.290926-1-rosenp@gmail.com>
 <20241101220023.290926-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101220023.290926-2-rosenp@gmail.com>

On Fri, Nov 01, 2024 at 03:00:23PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> Tested-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 97eaeec1952b..b6cc51bfdd33 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -509,54 +509,38 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset)
>  	}
>  }
>  
> -static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
> -		u32 stat_count, u32 num_tqps, const char *prefix)
> +static void hns3_update_strings(u8 **data, const struct hns3_stats *stats,
> +				u32 stat_count, u32 num_tqps,
> +				const char *prefix)
>  {
>  #define MAX_PREFIX_SIZE (6 + 4)

Hi Rosen,

As per Jakub's feedback on v1, can't this #define be removed?

...

