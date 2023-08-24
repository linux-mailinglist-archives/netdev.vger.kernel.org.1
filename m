Return-Path: <netdev+bounces-30262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED997786A46
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB561C20DDC
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692BCA68;
	Thu, 24 Aug 2023 08:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E7AD4F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A31C433C7;
	Thu, 24 Aug 2023 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692866456;
	bh=SeRpl/Lqvfu6SpTnWQk+VFBgnbTMZ4t6/vR015hlaHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjnN6EoW4WWuqahgBn+Mp8DBmtItIuxELzCcktvjxVlDSmGYk67SvTGfoWswcsDFh
	 9eSDIXBxLJw4UaLyxs4tCtCv7b3mpeKmZjfs0PWuj6UmCTzUIglWReP69FHm9Px/bE
	 KNm3gpikF+dygOsg/3MRzZ1C/6XRKkCaBXfZnbCl7hOPoM919x+IAGp9CRFbFGNga8
	 lcN+fWovUJ0FxQ7gfY5n8xtR/kplzjmrXtVT3KKHU0ZYor6gruxmy22bnDgUgBwfkX
	 a4GUgItoEC6FKam22vOBkMKTisLp8gV9nwFISfYYFUW9PR+uN7l07YlVqPTTw9NB6n
	 fpq3PidD7pL4A==
Date: Thu, 24 Aug 2023 10:40:48 +0200
From: Simon Horman <horms@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeed@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadfed@meta.com>,
	Kenneth Klette Jonassen <kenneth.jonassen@bridgetech.tv>
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for
 PTP free running clock
Message-ID: <20230824084048.GD3523530@kernel.org>
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821230554.236210-1-rrameshbabu@nvidia.com>

On Mon, Aug 21, 2023 at 04:05:54PM -0700, Rahul Rameshbabu wrote:
> Use a dynamic calculation to determine the shift value for the internal
> timer cyclecounter that will lead to the highest precision frequency
> adjustments. Previously used a constant for the shift value assuming all
> devices supported by the driver had a nominal frequency of 1GHz. However,
> there are devices that operate at different frequencies. The previous shift
> value constant would break the PHC functionality for those devices.
> 
> Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
> Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


