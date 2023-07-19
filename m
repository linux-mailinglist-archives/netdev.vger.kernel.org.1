Return-Path: <netdev+bounces-18876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B4758EFF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C8281696
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD34C2DF;
	Wed, 19 Jul 2023 07:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602EC8F5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D50C433C7;
	Wed, 19 Jul 2023 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689751675;
	bh=Cp6J/572Dt6KcFLwrp6zphOtvizpdc0o6lNOS/062XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfu4ixc+J7CHr/1VwQ7bNJiEOgCJcVCVOymR5LRpgRoRK5qN+8sN7prqqXUarbM0N
	 hYltDsGXAleum2eIOGgindNBn1q/cuCefzy9PCmU0UFysyAuwA4b8O2Gvp//4QKJIv
	 /03vJipq/GEcY86ddzEhfTkY4NJOCth6EupBiYb9iVnrWJ0tFqCiwra56s7ivhrSmK
	 q+OM975YsAmuQg/sVC/iQXGCrL809EnMHHoglN7A3opqLbQ/H4vvZxVVq+1L1b7V+P
	 XNY+pXCoSNVDy84FAc+zImytfLPKpe9jwTJomN7oRm8mdPWp+qES/4J8jTyQONlK57
	 fKhZ2gZowmBng==
Date: Wed, 19 Jul 2023 10:27:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230719072751.GG8808@unreal>
References: <20230718155814.1674087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - use Thorsten's wording for bug fixing requirements
>  - put more words into the review/response timeline expectations
> v1: https://lore.kernel.org/all/20230713223432.1501133-1-kuba@kernel.org/
> 
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: gregkh@linuxfoundation.org
> Cc: linux@leemhuis.info
> Cc: broonie@kernel.org
> Cc: krzk@kernel.org
> ---
>  .../feature-and-driver-maintainers.rst        | 155 ++++++++++++++++++
>  Documentation/maintainer/index.rst            |   1 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst

<...>

> +Maintainers must be human, however, it is not acceptable to add a mailing
> +list or a group email as a maintainer. Trust and understanding are the
> +foundation of kernel maintenance and one cannot build trust with a mailing
> +list.

+1

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

