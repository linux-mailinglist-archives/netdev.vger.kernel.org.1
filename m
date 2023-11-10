Return-Path: <netdev+bounces-47023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9E7E7A4B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D628150F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201A879FA;
	Fri, 10 Nov 2023 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmu4/nEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2715CA73
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C6BC433C8;
	Fri, 10 Nov 2023 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699606278;
	bh=peSr/sRwOFewRWkDxG8KYeXEM6sSyB3N4H7+yu0gHMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cmu4/nEtatRoyUILGZ8gNUO601cPJerdj7Tl0yEUWagoBHCXPcYy17ujIZWYx7ByN
	 g953j469ObxWML+1XgwJKLdD1Onh40anFXJDRvyppOqh+6SISpC54MNf4hvJUG5cdV
	 21MuPe2Xx+hezEGJk1SvnYLEo1usRrQ0H7sRyfJguBCSVcCTRiQgaNDLTeBEMi+FRJ
	 uXXFsd3FAjey1KaJaZaLUi4DaqjlH/rLhSLYSMUoxh9kYSFH4peLdI/lQY0l8SAren
	 2uDzYEuS9Rdipzj6bQMlwoj1yXqqoY6TXGLxFyIKUMYig/hiBWAVtHUXG9+w7GGdw8
	 ge4KH4Kcgl1tw==
Message-ID: <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
Date: Fri, 10 Nov 2023 10:51:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
Content-Language: en-US
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 s-vadapalli@ti.com, nm@ti.com, srk@ti.com,
 Md Danish Anwar <danishanwar@ti.com>
References: <20231110084227.2616-1-r-gunasekaran@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231110084227.2616-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ravi,

On 10/11/2023 10:42, Ravi Gunasekaran wrote:
> Grygorii is no longer associated with TI and messages addressed to
> him bounce.
> 
> Add Siddharth and myself as reviewers.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b151710e8c5..bd52c33bca02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
>  F:	drivers/counter/ti-eqep.c
>  
>  TI ETHERNET SWITCH DRIVER (CPSW)
> -R:	Grygorii Strashko <grygorii.strashko@ti.com>
> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
> +R:	Ravi Gunasekaran <r-gunasekaran@ti.com>

Could you please add me as Reviewer as well. Thanks!

>  L:	linux-omap@vger.kernel.org
>  L:	netdev@vger.kernel.org
>  S:	Maintained

> F:      drivers/net/ethernet/ti/cpsw*
> F:      drivers/net/ethernet/ti/davinci*

What about am65-cpsw*?

And drivers/net/ethernet/ti/icssg/*

I also see 

OMAP GPIO DRIVER
M:      Grygorii Strashko <grygorii.strashko@ti.com>

Maybe a separate patch to remove the invalid email-id?

-- 
cheers,
-roger

