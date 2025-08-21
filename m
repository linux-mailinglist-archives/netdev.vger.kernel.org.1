Return-Path: <netdev+bounces-215522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D5B2EF83
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4655F5E5D47
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A62E8B8E;
	Thu, 21 Aug 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJoRmHDM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF32E88B3;
	Thu, 21 Aug 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760977; cv=none; b=t+Ae6uLqAOrKfe9JB3TAsprnWY8HGwyfC/iMUWvcmUSlp9Wpq+iTaBxWcHdvLtwN/m6/BnWBR2R17GvvRJwx/nX1G0c9y4smpWa/acUJYMxAC/FKubu0bvthYG/DXTq2nMIjTmqmrfN0FkmvHY7oUCjY+Q9imMu/DKFp3reIVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760977; c=relaxed/simple;
	bh=T46ijkWrftgyRm8rX/GBvJ6Yur70E701SHV6rcR7lC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghlwF6S4ihsn+X4QTx1FAcwuSG3jWOC67Fvn3b+LutXo2WGXwuS9SGH9S+QtlaMc49jfZOlYXjNEAmg0Ss6qQy/tUV37XaNVVFE3FvV3icC932UOypX9BCFVNa34h/RuQnzcKU3uBLNoPQ6Tw8+Tpy6rbVpKxXkSrdSzl7fUSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJoRmHDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05172C4CEED;
	Thu, 21 Aug 2025 07:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755760977;
	bh=T46ijkWrftgyRm8rX/GBvJ6Yur70E701SHV6rcR7lC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJoRmHDMZNHujyjato45IzZ3S6xhMQYYvgUamdzPh3iuT0NVgUKsSp+MZMevYvgS2
	 XC31JHTFdSwB6+c1ZnzhPzmmNtjjgRfWhtnGCUApevzphn2u/TqolBK7eNPDTI7OiA
	 vOA8CJAJjwUMpxxwux7t7FWHgYe70uKvmKl2j61IIhMtI/EnGwMw95xIO8WtSqd/tK
	 QbBIpMWj8m/CazJcc2y02uhoWq3gYn4COeIokf2azni+0u7a6ktkYGf0hctUqMbp/B
	 oferhbf5rEmt+ylI+Xxj854jSM3hMTp7fkw0A3eAEfmbrNsZDV+/fYXTwg66LxXJ1w
	 wvxGT+UuowE6g==
Date: Thu, 21 Aug 2025 09:22:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <20250821-melodic-giga-python-6b2dc2@kuoka>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820075420.1601068-2-mmyangfl@gmail.com>

On Wed, Aug 20, 2025 at 03:54:14PM +0800, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.

Please use standard email subjects, so with the PATCH keyword in the
title. 'git format-patch -vX' helps here to create proper versioned patches.
Another useful tool is b4. Skipping the PATCH keyword makes filtering of
emails more difficult thus making the review process less convenient.

> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

...

> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      External MDIO bus to access external components. External PHYs for GMACs
> +      (Port 8-9) are expected to be connected to the external MDIO bus in
> +      vendor's reference design, but that is not a hard limitation from the
> +      chip.
> +
> +allOf:

This goes after required: block.

But don't resend just for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


