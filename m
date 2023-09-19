Return-Path: <netdev+bounces-34898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F37A5C68
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E63281AF0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859B38F94;
	Tue, 19 Sep 2023 08:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319838DFD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730CCC433C7;
	Tue, 19 Sep 2023 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695111709;
	bh=5KvkCNbn7OGLui117QthN2hn9WpFyd/IQKnUULbQkuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeHyZ4F7dmLbzDy3WrecV3HkXWskU/mhS8/+rWohZbGdJwfEPb2wu9Ck8UlTBz8zq
	 sn0JFy+se6hf4zi2OQ01tTvTBsZRF49hUIelwCWyXVkzZutOL85Y+NI0L8aFvuiYDZ
	 Zsi+ggMZVZ2SQaNfak+hiZNN4rPtCENtRnzmNPkZ56uM6SdJemUczfGAdrc5a65iPx
	 weaVEvnJbP0yoxer0kAZBESrJoDvCxcoDXRjMYk/I/oss1scSq23KpNS4cWqGkdYBH
	 PkdMXJgITd3RzRoIy++gdx/nBOAJKWf+wrXUsg2FhzcnBJo9gLTBjOzbb/FkdPXu5i
	 SS/ouGFmK5IBA==
Date: Tue, 19 Sep 2023 11:21:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 31/54] net: ethernet: mellanox: Convert to
 platform remove callback returning void
Message-ID: <20230919082144.GF4494@unreal>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-32-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918204227.1316886-32-u.kleine-koenig@pengutronix.de>

On Mon, Sep 18, 2023 at 10:42:03PM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

