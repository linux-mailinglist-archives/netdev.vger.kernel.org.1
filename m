Return-Path: <netdev+bounces-27090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5E77A57D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701E9280F44
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0F1C20;
	Sun, 13 Aug 2023 07:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B917C5
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49EEC433C7;
	Sun, 13 Aug 2023 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691913484;
	bh=ystoTSJws45wK7h4BKVQPt8bhKj/KA+BpBvEG2CO3so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8nsrDPD6apHcXoGZZt/dhQzNeUkfFcZ4/CsmUaozUNTnkO3fmXQeHgBP7v1LLE7g
	 ipVJqgpWt8rNSM4cFP17BKT6KYhr1xBmIeSCJk6R4skfwQ4nwwLpEA/RzqTTPHBbuD
	 mnSg6l6kUUQAR0SGaXhHo2Va+b8pcau5gRbGBDKSWcovZZmfAeOqPuSnBrpbN85gAL
	 GjHADbAClyXIurLbKKlJOovL7eBiypG758llrSS4rS0BnemsVuJxAjv0aPVnhBknrm
	 VgLBvypYz+JW93Y0b+jWHK8niJ7WHT4an43dxSK+uxCP8HD59MlmY/mP1HW+Vo6AQ9
	 KZFryZZI94mag==
Date: Sun, 13 Aug 2023 10:58:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 5/5] bonding: remove unnecessary NULL check in
 bond_destructor
Message-ID: <20230813075800.GC7707@unreal>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-6-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809124107.360574-6-shaozhengchao@huawei.com>

On Wed, Aug 09, 2023 at 08:41:07PM +0800, Zhengchao Shao wrote:
> The free_percpu function also could check whether "rr_tx_counter"
> parameter is NULL. Therefore, remove NULL check in bond_destructor.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/bonding/bond_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

