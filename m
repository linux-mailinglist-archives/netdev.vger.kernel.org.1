Return-Path: <netdev+bounces-34187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8D7A283C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6DD1C20F4E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B611CA0;
	Fri, 15 Sep 2023 20:37:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101A101C6
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE791C433C7;
	Fri, 15 Sep 2023 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694810240;
	bh=56Zy9LV9wFITzJ+B1bNvNEoS/gcZIlNi5Xg66GKek9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kvc5x6fHRLwdMwhhjNE4H5GZfqTZRXXL1DKuH8qYFieRQdm0XhVC+kP68pVqpzKQz
	 Kalts67rVHMh+uwiE1FvXnr5ddgE1g1vRJc5qM/RPOrYV8y2iHG42XKp+my3PY8jyY
	 kbm2sPwVNGDOgU+SBau7qhGAfzpTIVoQbXAHRhG44fzMUR25XpDp7Bf7MBCfC+zJQK
	 URcFJR7Hry7fL7/Uv2bG0N847r59o4TTYdRlsc1SjpDnpOO1tteG6Q8Yf7FISKTwPC
	 vdI2B3hrE+HCWmF2s7LkS0J5nf4CebAbsm8sSwz8rGaKa6maMfkceuLAi+/X1w5CZs
	 XVVTQX6/vTtTg==
Message-ID: <facce62d-07cd-4899-866b-c9d7eebe38a8@kernel.org>
Date: Fri, 15 Sep 2023 23:37:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update Bhupesh's email address
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, netdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, vkoul@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
References: <20230915191600.3410862-1-bhupesh.linux@gmail.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230915191600.3410862-1-bhupesh.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bhupesh,

On 15.09.23 22:16, Bhupesh Sharma wrote:
> Update the email address for Bhupesh's maintainer entry and fill in
> .mailmap accordingly.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
> ---
>   .mailmap    | 5 +++++
>   MAINTAINERS | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index a0a6efe87186..a69dfc6bbf1f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -94,6 +94,11 @@ Ben M Cahill <ben.m.cahill@intel.com>
>   Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
>   Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
>   Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
> +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
> +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhsharma@redhat.com>
> +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@freescale.com>
> +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@st.com>
> +Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>

This line looks like an unintentional change?

BR,
Georgi

>   Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
>   Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
>   Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa7487b7729b..620301a2b5ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17740,7 +17740,7 @@ F:	drivers/net/ethernet/qualcomm/emac/
>   
>   QUALCOMM ETHQOS ETHERNET DRIVER
>   M:	Vinod Koul <vkoul@kernel.org>
> -R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +R:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   L:	netdev@vger.kernel.org
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained


