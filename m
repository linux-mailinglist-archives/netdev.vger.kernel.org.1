Return-Path: <netdev+bounces-135597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521B99E4F7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A333284847
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393891D4146;
	Tue, 15 Oct 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAg1GQG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D561D31AF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990252; cv=none; b=SWvK8jRpSOGUawpYHDdIce1XzpSGn4acdZ3kiWidFyXTeh9LV+DPioysQw0NgtbjeflkheMUHKKZ5gBLAdZfknP1ULyXm2YqHoe4emq8SO9CZXwv8uMISG3J7SLW6hI2HzfxjuvkAUs6cczN6AShBeB3woL1Ai51xQEyqUg4Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990252; c=relaxed/simple;
	bh=FJalwVIpV+3V4WaKSK0bzrRpstf425/VtGiAZx9TKNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYQUtq5mwFwSenm7GIAwvN92qipPaB2Yqtd+DOkWdpfksdBSJWshjZT3P9kJ0/xs/2mK5U8rKgXdcu0hhOo2hAyGVwtxzQvEUZTaMrljrU9Om+sN1vsiWDk2uGHwLp5QT2tVAhScgdHndrEj7DtRAX/9MZplN79HU7oNCz+59zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAg1GQG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD1C4CEC6;
	Tue, 15 Oct 2024 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728990251;
	bh=FJalwVIpV+3V4WaKSK0bzrRpstf425/VtGiAZx9TKNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAg1GQG7kBgPV7D6mVHLf/28AVe6DDzUVp9JYg0JJetYS9Q6ECFdvu7vFmg2NWC0i
	 DUIcw3xxEjDt7eIxc8+/7SuJ9ybeyrvw2U7eOzQxw7ipkWlNPa9UUK+V7QLs1ApEBO
	 rBVDyZMA5rjc2T0ULujAm+23Y1JjfBsxhR5gUTnrSyXK1fTWrGL8LCitW7gqmJY/37
	 e3T9Fj4F0ntz51rDnp7HfA0BF4pLMGT+OJbpqcR0xRAvAIjJ5H+iSQLdxsZUY9gu51
	 aDxa1NnSvDHdMMBMbMfFUtbLsxadZu32f8Vzw7W0MhZWqBww/NiAwMNmpgoewIkaUN
	 04SuMH27B8/zQ==
Date: Tue, 15 Oct 2024 12:04:07 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com,
	cratiu@nvidia.com
Subject: Re: [PATCH net-next V2 09/15] net/mlx5: Remove vport QoS enabled flag
Message-ID: <20241015110407.GD569285@kernel.org>
References: <20241014205300.193519-1-tariqt@nvidia.com>
 <20241014205300.193519-10-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014205300.193519-10-tariqt@nvidia.com>

On Mon, Oct 14, 2024 at 11:52:54PM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Remove the `enabled` flag from the `vport->qos` struct, as QoS now
> relies solely on the `sched_node` pointer to determine whether QoS
> features are in use.
> 
> Currently, the vport `qos` struct consists only of the `sched_node`,
> introducing an unnecessary two-level reference. However, the qos struct
> is retained as it will be extended in future patches to support new QoS
> features.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 ++++++-------
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

...

> @@ -933,7 +932,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
>  	}
>  
>  	esw_qos_lock(esw);
> -	if (!vport->qos.enabled) {
> +	if (!vport->qos.sched_node) {
>  		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
>  		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.sched_node->bw_share, NULL);

Sorry, another nit from my side:

If we get here then vport->qos.sched_node is NULL,
but it is dereferenced on the line above.

Flagged by Smatch.

>  	} else {

...

