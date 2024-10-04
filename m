Return-Path: <netdev+bounces-132306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59899130C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBE81F22D09
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166014AD24;
	Fri,  4 Oct 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvFjo0y2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B066231C9A;
	Fri,  4 Oct 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084736; cv=none; b=W3/qTGyqQpfhkqqxuqYAqq6yF1KCIh5FyxVuC66TjtM57LlX4Q1XtKGRVIrZ/7NYAOQ4ipjAsFc2CJy28/9Om2Lq1i93HANlVfI3gZLZ/ZhCy2N0lqSCkOfNH+M5CF3u5YGKqDy+P7SCMrhuzdIM095OllYz8a/Ow2RHW5BRXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084736; c=relaxed/simple;
	bh=7jC2gHy2fxjiaZD9qpqj1t/m59qEIgQGhuTYsWqqZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQocIP4q8SD18ezT2L1vOmZBlE2OuCHCPb4UemGzzwyeR284v/Js6tJmCT96o+7zhyVZ5AG9R2oPnTF/rObb4fUgjWUzD239kPtAaABmhiqrZ3F0VQBxqAOBkCyy0+JAWS1DsZ3xeZAbMs52jcTIzLo7idW5Ha5CirFpjMU5Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvFjo0y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4796C4CEC6;
	Fri,  4 Oct 2024 23:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084736;
	bh=7jC2gHy2fxjiaZD9qpqj1t/m59qEIgQGhuTYsWqqZRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvFjo0y2kPX6QmXy3vZgV2bDnqlvwoOZC0LdOpbY25FNC/QasLlpcAm7Mlxw9oz/B
	 0Kp9UJYUH7RigLevnnejpbvbA4pfomFtv/+6xz/MlND/c2nR02t29vgQdkdFzlKx+e
	 3nioZcWunEVhF+DVM/tePS6aExEUm+pmtdaJ8Btd04esFnHzMjZMF1hpWePIvGr+Mh
	 Zc1k+cB+HHgaF1Xvz5Ed3T3ZxZofepfPtvCYWZHZv0vbB7twi0ZXpe/2WIXUen9/Y+
	 Zw0wCyg/oOpHU4zyhS2r20pJbGi7nAh2AOfGkxGByQSwDrV/DV9W9KMuLDv095jBnW
	 nqe24D0nsfpgA==
Date: Fri, 4 Oct 2024 16:32:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 03/17] net: ibm: emac: use
 module_platform_driver for modules
Message-ID: <20241004163213.2d275995@kernel.org>
In-Reply-To: <20241003021135.1952928-4-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:21 -0700 Rosen Penev wrote:
> These init and exit functions don't do anything special. Just macro it
> away.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/mal.c   | 10 +---------
>  drivers/net/ethernet/ibm/emac/rgmii.c | 10 +---------
>  drivers/net/ethernet/ibm/emac/tah.c   | 10 +---------
>  drivers/net/ethernet/ibm/emac/zmii.c  | 10 +---------
>  4 files changed, 4 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> index d92dd9c83031..a632d3a207d3 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -779,12 +779,4 @@ static struct platform_driver mal_of_driver = {
>  	.remove_new = mal_remove,
>  };
>  
> -int __init mal_init(void)
> -{
> -	return platform_driver_register(&mal_of_driver);
> -}
> -
> -void mal_exit(void)
> -{
> -	platform_driver_unregister(&mal_of_driver);
> -}
> +module_platform_driver(mal_of_driver);

This is not 1:1, right? We're now implicitly adding module_init()
module_exit() annotations which weren't there before. Needs to be
at least mentioned in the commit msg.

