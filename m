Return-Path: <netdev+bounces-237788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FDC5038C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C94E2716
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36D627AC4C;
	Wed, 12 Nov 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSnBeDlT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93308276050;
	Wed, 12 Nov 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911756; cv=none; b=KKADOQwIXQE37uIHybGaDDoB/74CtjGiOWq2Gcudq0z4c0WnoPussckkDovUEPFK5sBaH+EweruiP0FaEs2LlIefLTMBkmfGkYqO+b8s9cLdYKf+2XnrDpP6sZc0UM+05uOWS3+OqgX4scKIdu4DcYh3zfD6m7wNJcQnAex1LeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911756; c=relaxed/simple;
	bh=K65sgs1DD2NGgj7iE4ACL+5DzhBQLGH7U8L+SZ9papI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYD68gIYWWjY29h9jFvwvjIv9tOzx0/AsvOhw4dp8vp0JzjWPDxDyBlpbEg9696Hia+lgZeqhUMkNs/eYIsbkAuA+Hh+g5olnCD79OJ7cFrI3a78x6c0b+qsraxp7tJOHcWXYHr/XKBMhTbKHBg+Ta8C0Bh9a6MkEId9wY1Ec+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSnBeDlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C5AC16AAE;
	Wed, 12 Nov 2025 01:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762911756;
	bh=K65sgs1DD2NGgj7iE4ACL+5DzhBQLGH7U8L+SZ9papI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSnBeDlTEcrLuDmBG81Q86x97mw/FZhKmHkUeNlF6VXFQTea5tBJxXISesPs50LUJ
	 eHaRaQgfuFx3OGdb1ZA4k+qudlLbXts9mlxIkHYMN1ihd4lK5bYCMsdEkVoGlG62dS
	 2VeOnUHF+l8wLLyMXf1iPvuyX973SORLUnECwPpcy+XT3qM2SA/6Ughacn/iT+AI7o
	 VtgxJrJ7dMozdjmBGwS/GN5fF+QHWq+dEFkOjHiake5dlCUcGFbDGUMDWrzNSukcOq
	 5OZ5qIRTIEaIrjEFzoe5aKL+M2BIv3BnhTdshyOYE90+EJkM8bWy0JM3ZOTumH48WK
	 kvO+9NDAiMQ9g==
Date: Tue, 11 Nov 2025 17:42:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpll: zl3073x: fix kernel-doc name and missing
 parameter in fw.c
Message-ID: <20251111174234.53be1a97@kernel.org>
In-Reply-To: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
References: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 19:50:30 +0000 Kriish Sharma wrote:
> Documentation build reported:

What do you mean by "documentation build"? make htmldocs?

>   Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
>   Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
> 
> The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
> function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
> This patch updates the comment to correctly document the
> `zl3073x_fw_component_flash()` function and its arguments.
> 
> Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  drivers/dpll/zl3073x/fw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
> index def37fe8d9b0..ca5210c0829d 100644
> --- a/drivers/dpll/zl3073x/fw.c
> +++ b/drivers/dpll/zl3073x/fw.c
> @@ -352,9 +352,9 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
>  }
>  
>  /**
> - * zl3073x_flash_bundle_flash - Flash all components
> + * zl3073x_fw_component_flash - Flash all components
>   * @zldev: zl3073x device structure
> - * @components: pointer to components array
> + * @comp: pointer to components array
>   * @extack: netlink extack pointer to report errors
>   *
>   * Returns 0 in case of success or negative number otherwise.

This now makes the kernel-doc script realize that the return value is
not documented. Please also add a : after the Returns on the last line
-- 
pw-bot: cr

