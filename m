Return-Path: <netdev+bounces-251430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB1D3C66C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5956CAFB5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AE3D667D;
	Tue, 20 Jan 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae9fJv6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB263D666F;
	Tue, 20 Jan 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903736; cv=none; b=gmBvlrQlSuli1eBE64wPvQxhQ5EzPBjEWcyuX2B53SnRcr/jlQmAdfh3aSGM3P587o7zz+KFcAhXvGgMKZeDIF7/ICCPcFu6BJ1Vos1tiUH21Vg58lakuI5DLzvt3tB6QdMGusk2EmFnNKqwTFJCpJ5bWpPMrge05VhrUnVauO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903736; c=relaxed/simple;
	bh=FUBbceT0gdVJ7BI0SLVl6AzOLKzEY4BtDPW5/kA7ii4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY/csjQcNnx0OWcDctdW1e1EV2j1MhY3kol3W4x2/hgZ5qdprtaXPXjS46Jo+hZCATj32tRwgbvE0v55PUXJJsESm6OQRu7zv82fatrlYT+2tWpH+7iY1M823i5d/U61WJHANK3DIraqOgIf/xeEvSqrjToGl2dV0p8Xp1FUsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae9fJv6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC2C2BC86;
	Tue, 20 Jan 2026 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768903735;
	bh=FUBbceT0gdVJ7BI0SLVl6AzOLKzEY4BtDPW5/kA7ii4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ae9fJv6bDlrMXR5M59I1lB7gTIx2ntm6gGmBVjMEkocWwK+hMSl72gMBz2WPVTQSK
	 UEiucSpuMXdD7EcmqVbWwwOIijO2OGiHyPDwhphIcloHGlnpJAaBLvIpDAU2HuhNim
	 KdLB1m+8GikASNKh6VSic3YsePYCq2g1y8OosWFywWRNpPDkV7KpkEtwwXDtwwtxj3
	 +chDGZ5SWBjXWBXf8S+QIIL6ED9rwjA5t8XZdGaLfMinOE6WW1LqWSTi6x0Lvz4uSB
	 SKQwjD4MsWqencUUS0USrEUp545ctHEiLvjK9AxLgzjBiQeP6639k3ILAFcOw9SypE
	 5/wIdyvu7iMaw==
Date: Tue, 20 Jan 2026 11:08:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add
 firmware-name property
Message-ID: <20260120-vagabond-jaybird-of-pizza-6bc8ca@quoll>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
 <20260119-airoha-npu-firmware-name-v3-1-cba88eed96cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-airoha-npu-firmware-name-v3-1-cba88eed96cc@kernel.org>

On Mon, Jan 19, 2026 at 04:32:40PM +0100, Lorenzo Bianconi wrote:
> Add firmware-name property in order to introduce the capability to
> specify the firmware names used for 'RiscV core' and 'Data section'
> binaries. This patch is needed because NPU firmware binaries are board
> specific since they depend on the MediaTek WiFi chip used on the board
> (e.g. MT7996 or MT7992) and the WiFi chip version info is not available
> in the NPU driver. This is a preliminary patch to enable MT76 NPU
> offloading if the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


