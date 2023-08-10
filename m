Return-Path: <netdev+bounces-26240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEB7774DE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AF281FE2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833371EA87;
	Thu, 10 Aug 2023 09:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912C3D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EBFC433C8;
	Thu, 10 Aug 2023 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691660850;
	bh=3p2S0xJsyaUNjI6/wCP/dkRJDszAuff7uBz02OIuMAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JppuMrvY5f5iojL5qBuAWPzRRw3lBRLTkdVhsuv2631DtLQ9MSURn5C6Gvd27xGNP
	 h6aamJBL5jtY4xdeXakT35BD2zLTqx9BAMqMptz4mS0Nyx1nkl6ZHvRYHOIZfdYMZ/
	 3fn770ETQukOCSR8uzhnIgu8auKRngIX/XqMi35BRyaj1QhqMZWofiWaMEU6Wj6+ty
	 FOUUhUHEH1TybY+fX8W5Fc4NpGJ8D8NqvSb/BDDzHg9xPXTBP6ufpJQit90hRjQUrj
	 dGaR2vFQiQViDi1xQCBk+AyeReRvAUGXU3mO2YIRuXNhgUJO8pwNx5OIDIyYSmDcY6
	 bzaXO3MnMN+uw==
Date: Thu, 10 Aug 2023 11:47:26 +0200
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net-next 0/2] Support more IPsec selectors in mlx5 packet
 offload
Message-ID: <ZNSyLnC6n1burMsk@vergenet.net>
References: <cover.1691521680.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691521680.git.leonro@nvidia.com>

On Tue, Aug 08, 2023 at 10:14:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> These two patches add ability to configure proto both UDP and TCP selectors
> in RX and TX directions.
> 
> Thanks
> 
> Emeel Hakim (1):
>   net/mlx5e: Support IPsec upper protocol selector field offload for RX
> 
> Leon Romanovsky (1):
>   net/mlx5e: Support IPsec upper TCP protocol selector

Thanks Emeel and Leon,

this looks good to me.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

