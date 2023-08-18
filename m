Return-Path: <netdev+bounces-28937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB79C781321
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A315A2824A4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1541B7E4;
	Fri, 18 Aug 2023 18:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9E19BBE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79FC433C7;
	Fri, 18 Aug 2023 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384984;
	bh=hI7sDkcMLbQVdysnlBH36J0XAQpUpzgf7DTFx9Kp0Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW5WLekcF0hUuFAU6QxzZ/uE1xajc79qOZp4BBy2bhvLjfFlyQdPNdCRDdKB0PYgz
	 mFWs/XxMTqb5UamENiQZmAxjzbOg62qiXCjubj4/2RZShVEYCUGKlKPhna0F42p0Zj
	 P0PMN1cNtDHA6d33es69CJzpSsEc29fq3+UX3mEjTbgB4VsWYQiKEfET9ADBpXytPw
	 eSdzsIy0vkppjQXjgab/RWj7YBN3c2NRlkfmOFUT7Bl0qx/iaFVYqDisZSTP594at5
	 LxBBnve2b4czQS4uxBb1K6bWDgJRmg69uib3EvB2RSoyfoxG75Bqpt8Xs7Eg55murq
	 WoPYsrztMCwoQ==
Date: Fri, 18 Aug 2023 21:56:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: horatiu.vultur@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	richardcochran@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/3] net: microchip: vcap api: Always return
 ERR_PTR for vcap_get_rule()
Message-ID: <20230818185616.GF22185@unreal>
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
 <20230818050505.3634668-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818050505.3634668-2-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:05:03PM +0800, Ruan Jinjie wrote:
> As Simon Horman suggests, update vcap_get_rule() to always
> return an ERR_PTR() and update the error detection conditions to
> use IS_ERR(), which would be more cleaner in this case.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/microchip/vcap/vcap_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

