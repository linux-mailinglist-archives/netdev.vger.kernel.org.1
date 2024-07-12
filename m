Return-Path: <netdev+bounces-110973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5C92F2EC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8286828392B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C5376;
	Fri, 12 Jul 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYvpvW6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642F173
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742808; cv=none; b=pooHNw+CeQq9hDjgOuhSjybu5FEY7qzEySA6YtTFPIZwaESfyC152I1CUFH5BLOXHxwTpIZSS4IyfjCDyNZSZwjSIMo6bTKktNCwusQo504EbnmHLbN2aa5449JdBBD2nfbW7rPWYD5ShlOMuPx6itIDlgkuaBPSksslz8vm0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742808; c=relaxed/simple;
	bh=3Xq8esxEnSLbDRxJCz4HxzDLmwYJ5RAGn3DTX+JPgG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbNfWt3Nn+oRM/5y72PBGPMBcjKCZdfbD85XfJ+Dc0ScoTyiiFzT2D7OPXGP7XTbDg74pi4m98AVZTjFAGkiMJYtL9LsvbVLFJbLqGk8Phim+6GHOv+FX/HztVZy44WU/FZLOM8K3lvHBV16KDwYEIwPJjP41VquI37D7RSnwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYvpvW6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8555C116B1;
	Fri, 12 Jul 2024 00:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720742808;
	bh=3Xq8esxEnSLbDRxJCz4HxzDLmwYJ5RAGn3DTX+JPgG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYvpvW6RoHK9OE9saPVoPYmmfNQOvrcoAsg6n8c0q6aLpJpcyTLU/xjAgYugBM0ga
	 oY1xlpmDaUSbfuFtwJdNwRKw9DtPKNmQ+co7RBjv14V4uCfC4caUAevjyV8iJZVFBN
	 hp4I3ChcNalA1cS0dFcziF8ZnALormn0ufIx3EhFD+Bdbvb1kf8MSAaqAH/bQcEEfN
	 C/pm3CnOlolaOdAvT9AmezVccrX1QU2DPa3lmWnlW3Xj0ZwTwtclhGxIdw4Rrm0SxB
	 B/rbv5xaw6vsgeWijrG1oV3YKyQ26zyxk6LRcAeUFuwIvDVlowuN+9IZ1Q/8L7Cyza
	 UQj6dYQLIXeXg==
Date: Thu, 11 Jul 2024 17:06:46 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, tariqt@nvidia.com, rrameshbabu@nvidia.com,
	saeedm@nvidia.com, yuehaibing@huawei.com, horms@kernel.org,
	jacob.e.keller@intel.com, afaris@nvidia.com
Subject: Re: [PATCH net-next v2] eth: mlx5: expose NETIF_F_NTUPLE when ARFS
 is compiled out
Message-ID: <ZpBzlkdMP6wnQnz7@x130>
References: <20240711223722.297676-1-kuba@kernel.org>
 <ZpBlOWzyihXUad_V@x130>
 <20240711161615.123a5008@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240711161615.123a5008@kernel.org>

On 11 Jul 16:16, Jakub Kicinski wrote:
>On Thu, 11 Jul 2024 16:05:29 -0700 Saeed Mahameed wrote:
>> >+#if IS_ENABLED(CONFIG_MLX5_EN_ARFS)
>> > 		netdev->hw_features	 |= NETIF_F_NTUPLE;
>> >+#elif IS_ENABLED(CONFIG_MLX5_EN_RXNFC)
>> >+		netdev->features	 |= NETIF_F_NTUPLE;
>>
>> Why default ON when RXNFC and OFF when ARFS ?
>> Default should be off always, and this needs to be advertised in
>> hw_features in both cases.
>>
>> I think this should be
>> #if IS_ENABLED(ARFS) || IS_ENABLED(RXFNC)
>> 	netdev->hw_features |= NTUPLE;
>
>That's what I thought, but on reflection since the filters can be
>added, and disable doesn't actually do anything - "fixed on" started
>to sound more appropriate. The additional "[fixed]" could also be useful
>for troubleshooting, to signal that this is a different situation than
>ARFS=y. No hard preference tho.
>

Agreed, Thanks.

>> Otherwise LGTM
>>
>> Acked-by: Saeed Mahameed <saeedm@nvidia.com>
>
>Thanks!

