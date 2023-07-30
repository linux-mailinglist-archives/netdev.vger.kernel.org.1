Return-Path: <netdev+bounces-22641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628576865F
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2053E2817A5
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650DDF6E;
	Sun, 30 Jul 2023 16:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C09DDD4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 16:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2BEC433C7;
	Sun, 30 Jul 2023 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690733839;
	bh=LtRI832gyIYu/qcJ+wjkvVdT8FFjcWSt8xXU7OGyoS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CooAZJGiMMBFMdqGtCR9L0N5bQXg3qva6MJqDpnhvuZnGj1fGgFmyGd2su8O3TA6C
	 80ATMmVJRhSf6xcCqXjHDSTPRKOufCK6qiV84mr3btY3sXp12ltv9MfzeEoabmYFH0
	 Ez5FXFxdFTD3Dbp81wAutggX6a2xMrjSMOzxqhGx1uKbUwNRmPy74XhckU8uzz3Qd+
	 C7lq+tbYyJRAwkmiuUXhnN9p3VJTsZCu4gNLkEZ70gzzu3b4K+V6nWfq/J3xQE5e7z
	 o49cSuNiIFMSKiPpZm+T41unmC+nkpiwodgtHpTAcUlxoP8OYQs32qFG12FUXBUj7T
	 WJSSs2E5oGDXQ==
Date: Sun, 30 Jul 2023 18:17:15 +0200
From: Simon Horman <horms@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <ZMaNC+tTV+tX44qz@kernel.org>
References: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>

On Fri, Jul 28, 2023 at 11:51:03PM +0100, Mark Brown wrote:

...

> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 2d7347b71c41..cdb05db3d6ac 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
>  		return err;
>  	}
>  
> +	/*
> +	 * SynQuacer is physically configured with TX and RX delays
> +	 * but the standard firwmare claimed otherwise for a long

nit: firwmare -> firmware

...

