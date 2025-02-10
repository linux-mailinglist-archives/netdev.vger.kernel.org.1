Return-Path: <netdev+bounces-164640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B9A2E92E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B690C7A3E70
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903261D61B5;
	Mon, 10 Feb 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M52Tf+wi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647531D47C7;
	Mon, 10 Feb 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182755; cv=none; b=R13NL53+PBDfrmau3tLOCBZEY/OKmf8Z9DgnGzfBgDPgGooXLw5EaWUasi0vCcd+5/NxM7LIvZsx6p8REayBfqq4DC9oKcsPEb00i4QQP2TNM0rmX2iyliCwyvkPnI4BXJtQb8a3FqsdetWU8R1BHJNQ549QbjD5DuwPEXfhhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182755; c=relaxed/simple;
	bh=Xhm1EhuWSeR0HnKbycECrEOCwoXKQXTmtIjJmXXW/G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQUTfEmpzRX0pOPVNK2ZJxsjDs4Lss1Lo9j3XuGRNY7KGl0sF9sagz6a5uoI9R6FLto3g6jQ/ANC5hvLRvBZrhkn9jHf1fx4vzg4CrkE+AkQ68OUS/4tjuMeSz6WVJDWR0gZkMrY7JHwmTGKxlwLlezpogg8/2alhMenhy/Kl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M52Tf+wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CABC4CED1;
	Mon, 10 Feb 2025 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182755;
	bh=Xhm1EhuWSeR0HnKbycECrEOCwoXKQXTmtIjJmXXW/G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M52Tf+wiSyn/N0JgepdvasifZj0RiK/ofryUtmeYDrx5xGiCDD7Z4IHdLUvxvEPnH
	 ZE2GaG73x3m+U53r3h00/BRLb4gTA5KCFt0rMLfdAUupPGef4mdXlJjMJaWJ17XFK1
	 bA1RiPRgVnCQhVUrvpOVqwSZAmvwqto48rmkkwHZTWXvTRIGG2FM7qy8ONy+ewLAX6
	 R0C9vdXqSqwRk19lpGUV3Xec1C5HqgMMYZeXAmfM8m3I3BsSJDku2eSsnB9Fzd9v+J
	 EW3dZdjYiyUTLm/FIws9sDSHPoWSnLMPENuVHnnnmQ6j9+yz4eM/P47jbcXR1Yn7wD
	 Mu+eS6qmCI+DA==
Date: Mon, 10 Feb 2025 11:19:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, kernel@pengutronix.de, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: socfpga-dwmac: fix typo
Message-ID: <20250210-calm-oriole-of-experiment-17a66c@krzk-bin>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
 <20250205-v6-12-topic-socfpga-agilex5-v4-1-ebf070e2075f@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205-v6-12-topic-socfpga-agilex5-v4-1-ebf070e2075f@pengutronix.de>

On Wed, Feb 05, 2025 at 04:32:22PM +0100, Steffen Trumtrar wrote:
> The phandle to the SGMII converter must be called
> "altr,gmii-to-sgmii-converter".
> 
> This is how the phandle is called in the example and the driver. As
> there are no upstream users of this binding anyway, this shouldn't
> break anything.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/socfpga-dwmac.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> index 612a8e8abc88774619f4fd4e9205a3dd32226a9b..67784463f6f5a3ba7d2e10810810ab2d51715842 100644
> --- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> @@ -24,7 +24,7 @@ Optional properties:
>  altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
>  		DWMAC controller is connected emac splitter.
>  phy-mode: The phy mode the ethernet operates in
> -altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
> +altr,gmii-to-sgmii-converter: phandle to the TSE SGMII converter

You remove it in the next patch, so just squash it and mention any
changes done during conversion. This is noop otherwise.

Best regards,
Krzysztof


