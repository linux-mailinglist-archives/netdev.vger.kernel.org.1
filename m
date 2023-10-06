Return-Path: <netdev+bounces-38618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77D7BBB09
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808E928234D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15459273C8;
	Fri,  6 Oct 2023 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjSvapXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5C22EFC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72BC433CB;
	Fri,  6 Oct 2023 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696604440;
	bh=OXsf+3j2eEKMJ6aL+eP0osCFeo54NmRtRUnA8ZWuaVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjSvapXH0BMLiUJ4ChyZ3XngRSb0gIQdUxrKL+PDeUg9uVF6F9LriRQn1KE4ql197
	 J24794rqptDXuFbOtaECaNH27rmguZLcU3wH/W0ar+kUkGbEwpm9eHhyj2znRD+EoI
	 pOjD31HQacujhFmvuPej/uMvGc8vGZultXT6SHPCNO+gX9RMHSX6bOWNI8wU/pvcrN
	 IJJx7OlzIX8k1SoO15MvZY4sxXH5os1N6PqvLH4tJzfYdVnHLK18NC4Twa8h04wb/y
	 J9TgiW3bqRNcxkNHShxKdoiJmzxP0lLq/oH0HF8azm4awbnJOL30J77DbXy7u1L0Vg
	 roS2K86qsNYOA==
Date: Fri, 6 Oct 2023 08:00:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v3 1/2] tools: ynl-gen: lift type requirement
 for attribute subsets
Message-ID: <20231006080039.1955914d@kernel.org>
In-Reply-To: <20231006114436.1725425-2-jiri@resnulli.us>
References: <20231006114436.1725425-1-jiri@resnulli.us>
	<20231006114436.1725425-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Oct 2023 13:44:35 +0200 Jiri Pirko wrote:
> +      # type property is only required if not in subset definition
> +      if:
> +        properties:
> +          subset-of:
> +            not:
> +              type: string
> +      then:
> +        properties:
> +          attributes:
> +            items:
> +              required: [ type ]

Nice!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

