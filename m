Return-Path: <netdev+bounces-30507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC52787976
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC2F281666
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88861FD8;
	Thu, 24 Aug 2023 20:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF37F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 20:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA6C433C7;
	Thu, 24 Aug 2023 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692909615;
	bh=sThFy8cM/rbLrz7RtjiioPh05v5HydKm+YY+jWATBdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlMRT5GQ2yVUJg9abNW7hHJDhW+IFgayTVedMmWA5pQYTWhNnti/1f9itFwONolwb
	 8lq2JL02L9z+AYUa13TLe9B21DZ5ypjpSYo98pcvRm1rSA45DpAftj67GxvjIEj0hk
	 wwVTJUkAEsFGxerofPyo544hBFz18wHiIC2iv4z5L15QBlnK93DzbQJM3NdskZl6Kl
	 gKVlID1CfcR9ebTFHKYGBWZi8wZv/5e8CN7gPolwqVP0NPB3fwVo8IN39XxQJuD36P
	 0IyqM/PIKpA0eCBtOvE+TTII3AuX0fLm44y9UuBzcrQYq0ufuBh8rbYbula6ruvWWO
	 +5ffbmWsw7PSg==
Date: Thu, 24 Aug 2023 13:40:14 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadfed@meta.com>,
	Kenneth Klette Jonassen <kenneth.jonassen@bridgetech.tv>
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for
 PTP free running clock
Message-ID: <ZOfALr40vfTt7RJp@x130>
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230821230554.236210-1-rrameshbabu@nvidia.com>

On 21 Aug 16:05, Rahul Rameshbabu wrote:
>Use a dynamic calculation to determine the shift value for the internal
>timer cyclecounter that will lead to the highest precision frequency
>adjustments. Previously used a constant for the shift value assuming all
>devices supported by the driver had a nominal frequency of 1GHz. However,
>there are devices that operate at different frequencies. The previous shift
>value constant would break the PHC functionality for those devices.
>
>Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
>Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
>Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Acked-by: Saeed Mahameed <saeedm@nvidia.com>

I have nothing else in my queue so just go ahead and apply directly to net.

Thanks,
Saeed.


