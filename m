Return-Path: <netdev+bounces-15733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF2749703
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A251C20D08
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488E184C;
	Thu,  6 Jul 2023 08:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212715C6
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779F1C433C8;
	Thu,  6 Jul 2023 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688630585;
	bh=FcEud5Lep22fWBHlZm+HD0C/uSsh5csuoYd4o4CyWrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqTBIvtoD8WmdWHgSO9pRu1mY6CHEJInu6Y4T/vTsjFMQzSNN7R3VTeOTAR6Lkb+f
	 KxI95xA2jFLgn/k75udrn1sL8V3OjRkGSkEt6psDeFmYAW74GV21rW4phCT4lNkz8S
	 kOmwjPrsdZ8aRhyqD3GQduS4aiYD4ErxQXxsW1MUXNSMbDsyuA83RAzJH/ZIPlIbXU
	 y/WRvqLHU7C1F9hxFk0NWCLGzbyl3bCQeF0CDWS0hRHFRzsy0jzvMYr0DpefAYy129
	 aGH/BngbwEwO6O7tzQheFRFm41lS+dgO33dlsTlBqMGqnmGyXL08tLwqenKdYviFow
	 4sD5ccq6l7XGQ==
Date: Thu, 6 Jul 2023 11:03:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
	shailend@google.com, haiyue.wang@intel.com
Subject: Re: [PATCH net] gve: Set default duplex configuration to full
Message-ID: <20230706080301.GU6455@unreal>
References: <20230706044128.2726747-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706044128.2726747-1-junfeng.guo@intel.com>

On Thu, Jul 06, 2023 at 12:41:28PM +0800, Junfeng Guo wrote:
> Current duplex mode was unset in the driver, resulting in the default
> parameter being set to 0, which corresponds to half duplex. It might
> mislead users to have incorrect expectation about the driver's
> transmission capabilities.
> Set the default duplex configuration to full, as the driver runs in
> full duplex mode at this point.
> 
> Fixes: 7e074d5a76ca ("gve: Enable Link Speed Reporting in the driver.")
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

