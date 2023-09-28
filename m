Return-Path: <netdev+bounces-36799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2B7B1CBA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 954F82829C6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE50374FF;
	Thu, 28 Sep 2023 12:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7058BF4
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 12:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2714C433C8;
	Thu, 28 Sep 2023 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695904971;
	bh=Jtx2o5xpKA5SOo7oGfW5jDPzdyBgHKowCU3rfSEsVTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4/BsBeoFQD46BDCiT2rFr/Fj9dPITWOizkTbzv46Jnol47La5IGJPIlL64Bb6hiA
	 NQA8/OXZrkAZjAID6n9FOewpK8lXR1SJh5BELq/lTu63nNmJ3XT1v7yMgd0mU5Ce3u
	 jVLGlR1lBJyh7wQLqY7bUzP2b8sQxT6ic6xPjXmlN6yqXpaw7JtLpeiRW1bIcPJAKO
	 +3KoOoSy4IbFL52u9weYQsfjfSLBSbJ7ou3Of7/gMCmFIdBga1JFLf261+aJcYG0sb
	 JWOHTo0B03Qj0tJR7s0VBJKIbKhru8Mq/2a9L4tfT++gVI9/VP6qJjltc2DKdUYbK2
	 0+LC27BC8HGRQ==
Date: Thu, 28 Sep 2023 14:42:36 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Vadim Pasternak <vadimp@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 0/3] mlxsw: Provide enhancements and new feature
Message-ID: <20230928124236.GI24230@kernel.org>
References: <cover.1695396848.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695396848.git.petrm@nvidia.com>

On Fri, Sep 22, 2023 at 07:18:35PM +0200, Petr Machata wrote:
> Vadim Pasternak writes:
> 
> Patch #1 - Optimize transaction size for efficient retrieval of module
>            data.
> Patch #3 - Enable thermal zone binding with new cooling device.
> Patch #4 - Employ standard macros for dividing buffer into the chunks.
> 
> Vadim Pasternak (3):
>   mlxsw: reg: Limit MTBR register payload to a single data record
>   mlxsw: core: Extend allowed list of external cooling devices for
>     thermal zone binding
>   mlxsw: i2c: Utilize standard macros for dividing buffer into chunks
> 
>  drivers/net/ethernet/mellanox/mlxsw/core_env.c     | 2 +-
>  drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   | 2 +-
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 1 +
>  drivers/net/ethernet/mellanox/mlxsw/i2c.c          | 4 +---
>  drivers/net/ethernet/mellanox/mlxsw/reg.h          | 6 +++---
>  5 files changed, 7 insertions(+), 8 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


