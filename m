Return-Path: <netdev+bounces-210427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3483B1340C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5677F3AAA2D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E5218821;
	Mon, 28 Jul 2025 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN7Iq9NC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C6290F;
	Mon, 28 Jul 2025 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679611; cv=none; b=usDw9xrBKoLM4BiL46ghUBJJV2KFu4PQF2i84G5EUZhtR9YV/9QrwEfhkXyZvp5aoEJaaJ2KIqH8D4v/QBPiILkJvTwa41xare1XtjzJWTEpK2iu+KQit0sh0r9GPeHYG6WOJxntfLHQWNOB4f+6c6E7AbGOgqBmcwykVAGmjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679611; c=relaxed/simple;
	bh=SCnFBh2pOHaMVAfqrFukG2B0hL6vIjUPCh6ccF3qkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR82ekqL2MS65WV3zRfSa3ZX9QtzCUX+zi3U/y1hjFeFVIOX+heole3j6n1e7lGZQHeUodnf5/ojnL1nus2gFamHf01po3X96KhXZf0NbT/oh8sElMsFXbb7NqP6iHPUvI5OITIkwZQNn/GrotiDQ/YMJUTKCYOy4FNuMO9PyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN7Iq9NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7FC4CEE7;
	Mon, 28 Jul 2025 05:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679611;
	bh=SCnFBh2pOHaMVAfqrFukG2B0hL6vIjUPCh6ccF3qkK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gN7Iq9NCeErSi0+I/651qC9gtqQbPYvfmJV/9O29RskqzV2JOSeMUnqJEZ8x5Hmfj
	 UPXZkvom7b/Ucz+4yw0MAJLkNC0EKS5NRdGb2ZDBd4ke6nOXvxig9Ax55Qr1QSxIIF
	 K4KfW4nkV0054baygkRJdm3iPcSJeO6UJxQPCi3lFfHmNuZPDHxxpZhG+cbzctyYpC
	 gwwJBiixcOmqCGMu+ZIaxUB4M0b6n6zAT3mN9Z6UaR5TPGpKQwZdHU1/UkFonUkua0
	 uqxhfMrnFUcE6Y0EJm6sMPgsXcYiL6vfHEElFG9NMVInU0jERzCxr3qqIlEJu8WxlR
	 E0/RtxjrwuITA==
Date: Mon, 28 Jul 2025 07:13:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <20250728-pompous-bull-of-argument-ddda6c@kuoka>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
 <20250727-airoha-en7581-wlan-offlaod-v6-1-6afad96ac176@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-1-6afad96ac176@kernel.org>

On Sun, Jul 27, 2025 at 04:40:46PM +0200, Lorenzo Bianconi wrote:
> Document memory regions used by Airoha EN7581 NPU for wlan traffic
> offloading. The brand new added memory regions do not introduce any
> backward compatibility issues since they will be used just to offload
> traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
> if these memory regions are not provide, it will just disable offloading
> via the NPU module.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml | 22 ++++++++++++++++++----

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


