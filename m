Return-Path: <netdev+bounces-209967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE6B118EA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA63AB923
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADC291C0B;
	Fri, 25 Jul 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5DjHfnL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B028937A;
	Fri, 25 Jul 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427517; cv=none; b=RIkXiDbSKopTyKw1x4GgWqMrSjIRpsYg+DB78eXFaMyv4jUGx6SDvhve4ZxEeaa8lJQpDFOjAWaDPmdxKBKb1oisQ8C6jVJiJfIXqLCgoUxEVPyLgr/B7CbLxmkUkxkZc6A+7YfAohdyCvmE9xA7sFrGjgOqkyMArafPuQlVYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427517; c=relaxed/simple;
	bh=NIrSmkNaqlrDP1N8LHUNlwi4EoCzvpR2Fghdour3+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJB4WwjT+/EfycChdKBilzZZmCXvCUUMw81DapJwN0oHUUo1KGYhwHcsKOHIffOggRA/8zF6RInE43/TMv22csLm2ASjaxWB3jJlnh01aP63l3Y1qqKKr7NbNoEtJwD3ALfgWEd8w40hmVgez8+0j0aD4E405jf7wic/VjWQwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5DjHfnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B42CC4CEE7;
	Fri, 25 Jul 2025 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753427517;
	bh=NIrSmkNaqlrDP1N8LHUNlwi4EoCzvpR2Fghdour3+lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5DjHfnLxJRHxrPjixKz9e3HA4B5jay/iIi78te15+dbbNIE0kXL8+FKl9usFF17H
	 hAyffWg4KLQWOsMgfLORmx9/b7N2uUrlXzbivw7rMtDcUphHTjr9GvssiRqDWArnaZ
	 +vgPEilcy1tEERdqMPT7SZlKBiJy/OuTEQmufjIJv+falGZ9toEzooVaRQALQs587P
	 8OX7gJrzRuWL4bneig6TgESlt7wUYZ8El/1dMOhJUzD22CJ/Z+oHqxqj8umMYS5Nfn
	 StEOFycqJoRP376PkhQ7dbRiTk9AluSEuQB+X1uR9qr7hNNDOX+oLX0+C2Vexiy8lE
	 5UN6/xybxXzWw==
Date: Fri, 25 Jul 2025 09:11:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <20250725-amiable-strict-pudu-5cce71@kuoka>
References: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
 <20250723-airoha-en7581-wlan-offlaod-v5-1-da92e0f8c497@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-airoha-en7581-wlan-offlaod-v5-1-da92e0f8c497@kernel.org>

On Wed, Jul 23, 2025 at 07:19:50PM +0200, Lorenzo Bianconi wrote:
> Document memory regions used by Airoha EN7581 NPU for wlan traffic
> offloading. The brand new added memory regions do not introduce any
> backward compatibility issues since they will be used just to offload
> traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
> if these memory regions are not provide, it will just disable offloading
> via the NPU module.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..f99d60f75bb03931a1c4f35066c72c709e337fd2 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -41,9 +41,18 @@ properties:
>        - description: wlan irq line5
>  
>    memory-region:
> -    maxItems: 1
> -    description:
> -      Memory used to store NPU firmware binary.

I still do not get why this cannot be kept backwards compatible. I
looked at your driver code and NPU offload support RFC, and they look
correct. Yet what stops any future developer from changing:

	mt76_npu_init(mdev, pci_resource_start(pdev, 0),
		pdev->bus && pci_domain_nr(pdev->bus) ? 3 : 2);

into:

	ret = mt76_npu_init(...)
	if (ret)
		goto err...;

? Why would anyone NOT DO such change in the future?

I think I asked about this last time as well - why you cannot keep new
entries optional (minItems: 1)?

Best regards,
Krzysztof


