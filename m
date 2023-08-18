Return-Path: <netdev+bounces-28938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC8781322
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921282824CE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB201B7E5;
	Fri, 18 Aug 2023 18:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AD1B7E4
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A1EC433C8;
	Fri, 18 Aug 2023 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384993;
	bh=E2NilpaHDitNnVEICGmFjHWn3jghjuxJfQm6i/3vhf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPqfWylzXUKh/Kkj3LjJyeh0Ozac3H+Cn/tiV7IQzed/3/CD/lwe7q/Xp8nG8BeRg
	 +hs1sgcVjsyKTk4K9rIXw25in0NQ0JfzjXZAQIDho4G0H0P+0c2kw7T1V739G+naab
	 WRpyx3Jm/3s9H5GyUxlHdFj1VCIpDStzqvQ+Za55SckbaVHSXAGHvNAHgLl7kpeWSq
	 ALlgIxGCWLJ4YYQe/DclcF615RAiEF8wnF4KftAp6YjEvQxU/f/HWjzoPqftEPC4PW
	 iDu4z5RjaaB+ZBRczELucbrUOKdIox59e+Qcy5WL9JDtJ5jfuSfEleEwPUj8VLXYDA
	 nA+Dcn9bw695g==
Date: Fri, 18 Aug 2023 21:56:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: horatiu.vultur@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	richardcochran@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/3] net: lan966x: Fix return value check for
 vcap_get_rule()
Message-ID: <20230818185626.GG22185@unreal>
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
 <20230818050505.3634668-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818050505.3634668-3-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:05:04PM +0800, Ruan Jinjie wrote:
> As Simon Horman suggests, update vcap_get_rule() to always
> return an ERR_PTR() and update the error detection conditions to
> use IS_ERR(), so use IS_ERR() to fix the return value issue.
> 
> Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - Update vcap_get_rule() to always return ERR_PTR instead of checking IS_ERR_OR_NULL()
> - Update the commit message.
> - Check IS_ERR() instead of NULL.
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

