Return-Path: <netdev+bounces-228157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C56BC31BD
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 03:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15973A78DB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCED28D84F;
	Wed,  8 Oct 2025 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkOePaD/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6313774D
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759886348; cv=none; b=SYBMkX7KCtyMhGWrGLBkr+BaYmqq5RYM0epiBLdno7T7kJ7ILTY5Xby2gSkCkisk268R7MkvmsObJ5yBghOKZgfxB5NMAi8yS6ABo+nGGX8Kpx3xUpxoS8CarUQZW7oCR7faxVzR8NK/XF8VLtxdSvNqRig1VvpBytk1PRkNIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759886348; c=relaxed/simple;
	bh=zRIRO8JY0ArcL+mLSKmlCdBHU4bZsKNq+Hrby8YfU2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sp/rftUgZklvY25B5UQgUpHjsQh5W6245l2lPUAy1Fn610jplfBYKrPNo1MLOw24H6PhyCXfoOYgVTmGfeLfy2+LTMsfCxM25B+tjq6nS3gTeYAKhWJFbgMqg0QMjF+ORBQyMuJZEBGlWTNjIELKP8vIbjbDQYrLYo4JyZ0eTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkOePaD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5FBC4CEF1;
	Wed,  8 Oct 2025 01:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759886344;
	bh=zRIRO8JY0ArcL+mLSKmlCdBHU4bZsKNq+Hrby8YfU2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkOePaD/y66IPXTVbZMycsyGYWXuTIjkH7AGpuDLztAPFQdSglaFW0p9kPRkFFTda
	 NnqDm9z/PzwmlrfwJTf8YWWtPt1FsnjSeXkizFrLC5F8kWdW+XNIqxM5Dx6DvGdfSv
	 zK+kuxTJ2+kRkztWY/Vxb+ZfqgOX0Ru57qxH96IirFgQY/IqxCQOQoS+vaVqGWwBVH
	 /o2jMKTYyndVzJoTAiUXzStyfLUlwiSdcP2ESjvevhzpLjMS01O7duDb1S6PcYvTKq
	 SB93V0Qi0+GR4JVjfsFDLf6OvV2xdumg6DAdA9mZItVXDuWJZyjSsXhKSivJafoD2o
	 C7ukcEEGvC2Ow==
Date: Tue, 7 Oct 2025 18:19:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Frank Li
 <Frank.Li@nxp.com>, Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
Message-ID: <20251007181903.36a3a345@kernel.org>
In-Reply-To: <20251005204946.2150340-1-pbrobinson@gmail.com>
References: <20251005204946.2150340-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Oct 2025 21:49:42 +0100 Peter Robinson wrote:
> The NETC V4 Timer PTP IP works with the associated NIC
> so depend on it, plus compile test, and default it on if
> the NIC is enabled similar to the other PTP modules.
> 
> Fixes: 87a201d59963e ("ptp: netc: add NETC V4 Timer PTP driver support")

You put a Fixes tag here, suggesting this is a fix.
What bug is it fixing? Seems like an improvement to the default 
kconfig behavior, TBH. If it is a bug fix please explain in the
commit message more. If not please drop the Fixes tag and repost
next week. Also..
 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/ptp/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 5f8ea34d11d6d..a5542751216d6 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -255,6 +255,8 @@ config PTP_S390
>  
>  config PTP_NETC_V4_TIMER
>  	tristate "NXP NETC V4 Timer PTP Driver"
> +	depends on NXP_ENETC4 || COMPILE_TEST

.. why? Does the clock driver not work at all without the networking
driver? Or you just think that they go together?

> +	default y if NXP_ENETC4

Isn't this better written as:

	default NXP_ENETC4

?

>  	depends on PTP_1588_CLOCK
>  	depends on PCI_MSI
>  	help


