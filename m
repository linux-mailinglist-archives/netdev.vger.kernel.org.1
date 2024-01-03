Return-Path: <netdev+bounces-61333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D282371D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE0287CAE
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1491D6A7;
	Wed,  3 Jan 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI62ZjKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC41D6A1;
	Wed,  3 Jan 2024 21:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE6CC433C8;
	Wed,  3 Jan 2024 21:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704317306;
	bh=uZGv1TtbceVdC6xdzXDRgTCsPdPQsJVLXEULQtO+dd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BI62ZjKJ2wJb17mqCbG3XCi+2GAmNOV+sI/aDehbqUJEU1ooVkHc0VtV5gHDGwSws
	 Pplyb0MJpzISpVkV0bkt6rkCeOvbDDmmld57MJGxv78EO7cCQ+NNWFd0gz131+FTqD
	 Llzx1LB2wyEPquYOWzlhPUqxMPIz4X4ctukcsW4ZCUiHRT2mH86VNe4iXQ6yFdNX+i
	 +89KnWrjlil5EN5o8RCn0cIjyiRozztim2WuSwoIWyL+8JaHj54JHNkvOp9aqqduWP
	 Z3Gd7WczkroKNmGcSVzSDpIYpvVohBS3LQW/+NEHM66n7vf9N5TksYYwqSAYGQrbQO
	 RrcQDRt8QUWNQ==
Date: Wed, 3 Jan 2024 21:28:22 +0000
From: Simon Horman <horms@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH net] MAINTAINERS: I don't want to review Renesas Ethernet
 Switch driver
Message-ID: <20240103212822.GA48301@kernel.org>
References: <6498e2dd-7960-daeb-acce-a8d2207f3404@omp.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6498e2dd-7960-daeb-acce-a8d2207f3404@omp.ru>

+ Shimoda-san

On Wed, Jan 03, 2024 at 11:56:15PM +0300, Sergey Shtylyov wrote:
> I don't know this hardware, I don't have the manuals for it, so I can't
> provide a good review.  Let's exclude the Ethernet Switch related files.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Hi Sergey,

I don't know the back story to this, if there is one.
But could I suggest that:

1. The patch also updates the title MAINTAINERS section to cover the
   remaining two drivers.

   e.g.: RENESAS ETHERNET DRIVERS ->
         RENESAS ETHERNET AVB AND SUPERH ETHERNET DRIVERS

   Or alternatively, create separate sections for each driver.

   n.b.: This may involve moving sections to maintain alphabetical order
         by section title

2. Reaching out to Shimoda-san (CCed) or other relevant parties
   to see if an appropriate maintainer or maintainers for the
   Renesas Ethernet Switch driver can be found.

   n.b.: It may still be a holiday period in Japan for the rest of the week.

3. Rephrase the subject and patch description as splitting out maintenance of
   the Renesas Ethernet Switch driver .

> ---
> The patch is against the 'main' branch of DaveM's 'net.git' repo...
> 
>  MAINTAINERS |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: net/MAINTAINERS
> ===================================================================
> --- net.orig/MAINTAINERS
> +++ net/MAINTAINERS
> @@ -18358,6 +18358,9 @@ L:	linux-renesas-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/net/renesas,*.yaml
>  F:	drivers/net/ethernet/renesas/
>  F:	include/linux/sh_eth.h
> +X:	Documentation/devicetree/bindings/net/renesas,*ether-switch.yaml
> +X:	drivers/net/ethernet/renesas/rcar_gen4_ptp.*
> +X:	drivers/net/ethernet/renesas/rswitch.*
>  
>  RENESAS IDT821034 ASoC CODEC
>  M:	Herve Codina <herve.codina@bootlin.com>

