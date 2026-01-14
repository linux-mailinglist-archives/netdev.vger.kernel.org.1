Return-Path: <netdev+bounces-249749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F544D1D263
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635683026B2C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8137F11A;
	Wed, 14 Jan 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn3wYT/R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823137F724;
	Wed, 14 Jan 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379746; cv=none; b=dRXtGObgVQX2zjYhza4wjbdS3Cq2bNovCRMYAqFFNRwMHcZ0CFn8fbncXCgP8jYyiHayPgSj67k//wdAQx6CbCAh/ORU98+T48sa9BXU/kqHci2h/njAS6xjEQGrYmZdrocOtTPyKWtMRcyLm1MqwkkCd+KH1v3Tet420Ns7fA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379746; c=relaxed/simple;
	bh=DxiGW0weUzqeG+ae5w/kEulEAA0JgRZ+wmxUHIbNego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1LlR2l1JKJDNuoFS0c7HWuNj36IX7d5qr3gBKUpmz39l/8WyuRuJ4BcNA/aB4C8EG25NyPsvpgfZzhBPrq//TfNKoGY/uxd6FXkW++51GJ3o/GPolBM68QnZU8mJp8pzJIzVcItnLHwcFvYIC+FBv7i/tVzi57fj/wj1KaLAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn3wYT/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C85C19425;
	Wed, 14 Jan 2026 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768379745;
	bh=DxiGW0weUzqeG+ae5w/kEulEAA0JgRZ+wmxUHIbNego=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zn3wYT/RVmzxK7Adq94nG8mMzMm8Mq2Oype7ZkPP7gJRq7vg7PiW/4LU/KiucA7Qj
	 LA3JI3gE6AHRP3+oBm7i8XOeKO5b3NINHcpoRKeQw2yT3Wdf6wK21T3RipFCvcBVAs
	 aQ5DoaOsS6aCQQoT1IKJplhovM6KfZ2JxEj2f5DedIEzTFe7j8bM9D6FZZZU88j+nO
	 jRhUpT4iAhr8F3UFYm0bMXZShm3WxHnIqeAy8SzbIMCLvqTeoEcx9er4jAdrykpRTp
	 4TW0qqjXpoArUkRryT7hPxoYkAR9JXxFNDSOddXTtPya1Q+sqoK3ALqqweFxs+mfBM
	 OnxWHetWDUK2Q==
Date: Wed, 14 Jan 2026 09:35:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <20260114-heretic-optimal-seahorse-bb094d@quoll>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>

On Tue, Jan 13, 2026 at 09:20:27AM +0100, Lorenzo Bianconi wrote:
> Introduce en7581-npu-7996 compatible string in order to enable MT76 NPU
> offloading for MT7996 (Eagle) chipset since it requires different
> binaries with respect to the ones used for MT7992 on the EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..96b2525527c14f60754885c1362b9603349a6353 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - airoha,en7581-npu
> +      - airoha,en7581-npu-7996

This does not warrant new compatible. There is some misunderstanding and
previous discussion asked you to use proper compatible, not invent fake
one for non-existing hardware.  Either you have en7996-npu or
en7581-npu. Not some mixture.


Best regards,
Krzysztof


