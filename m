Return-Path: <netdev+bounces-29431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3547833B5
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAE31C209E1
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3311715;
	Mon, 21 Aug 2023 20:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35B8468
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BE5C433C8;
	Mon, 21 Aug 2023 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692650184;
	bh=K/xF+93uPq0auz1mTESGR8Ar8vwak7/ibe2h9dVVD/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atFXh4WrO0oDRofMsbGeGYNDRyw1Z+bahIpXV3JivQSyf6pSSM3yG4N8ms+YvtUTE
	 mYbhOBXTg0h6Jz5TgMutKi+71bGQUuO2B/5Eqr4f3r8ARI0afTEadi8vHfB4Lx0OnW
	 Q/efGJmE/wau+RL/5jl+PGUfeWl9nvPXRLc8QlcZxuHNzYWllU6oXfuAj9Nrxk8KRu
	 QNiFOIY2SwqV1bvvlgqwDNQIxUOU+4ibCFReMdDxGFt+kN35F/fjUtarYrHJbzAoGi
	 I2OrmUlpgg+wT9xP9ZO6v0uRUj7s/nm1hw8yBv3Mg63pR3NMTDlBxWTXJxwwSiwzy6
	 WPcXmR1tIZIxg==
Date: Mon, 21 Aug 2023 22:36:16 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: microchip: Remove unused declarations
Message-ID: <20230821203522.GG2711035@kernel.org>
References: <20230821135556.43224-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821135556.43224-1-yuehaibing@huawei.com>

On Mon, Aug 21, 2023 at 09:55:56PM +0800, Yue Haibing wrote:
> Commit 264a9c5c9dff ("net: sparx5: Remove unused GLAG handling in PGID")
> removed sparx5_pgid_alloc_glag() but not its declaration.
> Commit 27d293cceee5 ("net: microchip: sparx5: Add support for rule count by cookie")
> removed vcap_rule_iter() but not its declaration.
> Commit 8beef08f4618 ("net: microchip: sparx5: Adding initial VCAP API support")
> declared but never implemented vcap_api_set_client().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

