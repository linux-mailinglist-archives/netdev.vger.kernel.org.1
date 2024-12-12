Return-Path: <netdev+bounces-151447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B19EF2AE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CDB286F3E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AB232372;
	Thu, 12 Dec 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2xMnYbA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECA23236B;
	Thu, 12 Dec 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021714; cv=none; b=X3WfWx3vBvNSglTjwF/4BWUSrdpzIYNKjy7479xouCGhIAUdBzGsNhBVTnUAXkNMxt6OQEBCQ0FB5sJlGNz2NOHXWhT0qFZd2pI80MzZaRdXskeNHGlwM0IVTMSH8drm0WdbP3sAdamsTXOiQ6TN86AavASxTJ3xKClYmLdL9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021714; c=relaxed/simple;
	bh=rnD2w38HGxhe3xIojnMw1nLLyIOcrO+dYYpscVFNKy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akxKesMwqesOaXeoUVJku973RtLWcGsr60v6Hlbc7RCBZJKbNMMn+wniySuSWK5PNuBQPxfTHis6QOx7gxVcN9n8Ac/qJWl2Tt1IpukfCWkUtdp+Gxz2Ik6mby+NpT2JC+UchQTr4Ncu5KA3JbBvXzUTPmOf9YugEPBBRed/iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2xMnYbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B054EC4CECE;
	Thu, 12 Dec 2024 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021713;
	bh=rnD2w38HGxhe3xIojnMw1nLLyIOcrO+dYYpscVFNKy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2xMnYbA7bUTKf5yAjSHTT65c9h4KL17vAdHR8CiDIGUmE0ID2QfYfziNG5hrWNYv
	 fdYmgdquBtET+aj0ty5WSMwQdVTIikJGQwMwJS5oy3mfkq65gRMmRw1qSt6BjS7f4S
	 muUwavP6U2HfrKCJV+0Zh30dWzHyLp+q76R84tSTNhEhT80DiBoI6BOmTmrE/68vOv
	 tvP5O/SDNNVLuej3wIjN76Wkn7gQm+C7oYvklz3jilgq60f0zLMR0WdzmJKYNYg2dC
	 i8odM+fYNEaRPoqILp0QYR2pqWXRAZTgcjJBl2z3TjCFz9JoVBgsyT1AuKo6vJ4MMv
	 EStYqxB3Hxn6Q==
Date: Thu, 12 Dec 2024 16:41:49 +0000
From: Simon Horman <horms@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH net-next] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
Message-ID: <20241212164149.GB73795@kernel.org>
References: <20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com>

On Wed, Dec 11, 2024 at 09:28:20PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify framer_provider_simple_of_xlate() implementation by API
> class_find_device_by_of_node().
> 
> Also correct comments to mark its parameter @dev as unused instead of
> @args in passing.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/net/wan/framer/framer-core.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
> index f547c22e26ac2b9986e48ed77143f12a0c8f62fb..7b369d9c41613314860753b7927b209e58f45a91 100644
> --- a/drivers/net/wan/framer/framer-core.c
> +++ b/drivers/net/wan/framer/framer-core.c
> @@ -732,8 +732,8 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
>  
>  /**
>   * framer_provider_simple_of_xlate() - returns the framer instance from framer provider
> - * @dev: the framer provider device
> - * @args: of_phandle_args (not used here)
> + * @dev: the framer provider device (not used here)
> + * @args: of_phandle_args
>   *
>   * Intended to be used by framer provider for the common case where #framer-cells is
>   * 0. For other cases where #framer-cells is greater than '0', the framer provider
> @@ -743,20 +743,14 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
>  struct framer *framer_provider_simple_of_xlate(struct device *dev,
>  					       const struct of_phandle_args *args)
>  {
> -	struct class_dev_iter iter;
> -	struct framer *framer;
> -
> -	class_dev_iter_init(&iter, &framer_class, NULL, NULL);
> -	while ((dev = class_dev_iter_next(&iter))) {
> -		framer = dev_to_framer(dev);
> -		if (args->np != framer->dev.of_node)
> -			continue;
> +	struct device *target_dev;
>  
> -		class_dev_iter_exit(&iter);
> -		return framer;
> +	target_dev = class_find_device_by_of_node(&framer_class, args->np);
> +	if (target_dev) {
> +		put_device(target_dev);
> +		return dev_to_framer(target_dev);
>  	}
>  
> -	class_dev_iter_exit(&iter);
>  	return ERR_PTR(-ENODEV);

Hi Zijun Hu,

FWIIW, I think it would be more idiomatic to have the non-error path in the
main flow of execution, something like this (completely untested!):

	target_dev = class_find_device_by_of_node(&framer_class, args->np);
	if (!target_dev)
		return ERR_PTR(-ENODEV);

	put_device(target_dev);
	return dev_to_framer(target_dev);

Also, is it safe to put_device(target_dev) before
passing target_dev to dev_to_framer() ?

>  }
>  EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);

...

