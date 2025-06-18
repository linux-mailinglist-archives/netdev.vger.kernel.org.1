Return-Path: <netdev+bounces-198994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4827ADE9A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2320F1756DD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BC28EA7C;
	Wed, 18 Jun 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osupgM4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3928DB46;
	Wed, 18 Jun 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245138; cv=none; b=rEo6uCQnHL7znFIswI3pgraYQf7oHvtEL8xKOq3XcwQZf6lgj9XYy2zAkTa0WF6W/QZ3xRSsBEpsCLhH1pVraQdW/s03k9aBEiKG4lVROgenbkeKmEfF7egUWoHVXL/dJmOZO8P+EiY5HRt2QXZTdjSSnXo2UgROBr6YyvyJl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245138; c=relaxed/simple;
	bh=7ov9a6Yz+wU2ty7RNsjV6EqGhHay+VwwWCf1OS+O+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8pYOjqdpextzQWi8Z7Oqqyzbi+E0yXhaJiIkPNyYtvkEOgnUZh5sc91mknYhmNHcupSyqRjqhV+rKnEq8wnBK4QBDjmFaq0CsSEcnlVjDvP+ZH39HAIg4RZgM5r0ZPpivv67+pwDJZm0SS+rj4XF/GRZW/jMm14XWAGAowkELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osupgM4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755C2C4CEED;
	Wed, 18 Jun 2025 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750245137;
	bh=7ov9a6Yz+wU2ty7RNsjV6EqGhHay+VwwWCf1OS+O+/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osupgM4m6EIhNRFLPJgSGtTLehHSXmjKaTS5vwuEQ3mUrNrZjKrD/fFeT+mmxofHE
	 8ZHkP7gGTJydS76K1+2U7uSX/wNKGdr6YFcVAuzC4IYMoaHfMX8qRvQwZk1NiA0WSW
	 R7EBbpTDzc6awbVT3Yy6Oy6TgnFUScc13z69UjZSvR2zFCvDSeYOyzuZPf2rAh+ZFu
	 wQh/NboCzTSmn+FfI3TyLMc/UyHIPT00xI8cCE3z+J8GUChoZIuWotpG5InjkItYde
	 g72s6+0mqB4p10ncqGRayfi0gpnt8uG0AdnUkFrPr93q8J/evrnSR/dpp7vkHycWuM
	 JMi7R4hzCNYaA==
Date: Wed, 18 Jun 2025 12:12:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 5/8] net: hns3: set the freed pointers to
 NULL when lifetime is not end
Message-ID: <20250618111212.GI1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-6-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:52AM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> There are several pointers are freed but not set to NULL,
> and their lifetime is not end immediately. To avoid misusing
> there wild pointers, set them to NULL.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 1 +
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 ++++
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 6a244ba5e051..0d6db46db5ed 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -276,6 +276,7 @@ static int hns3_lp_run_test(struct net_device *ndev, enum hnae3_loop mode)
>  			good_cnt++;
>  		} else {
>  			kfree_skb(skb);
> +			skb = NULL;

I am sceptical about the merit of setting local variables to NULL like this.
In general defensive coding is not the preferred approach in the Kernel.

And in this case, won't this result in a NULL dereference when
skb_get(skb) is called if the loop this code resides in iterates again?

>  			netdev_err(ndev, "hns3_lb_run_test xmit failed: %d\n",
>  				   tx_ret);
>  		}

...

