Return-Path: <netdev+bounces-195335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22231ACFA49
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 02:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC803AA4AE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F0A41;
	Fri,  6 Jun 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLO4lH2S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90969257D;
	Fri,  6 Jun 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168431; cv=none; b=F22sYePfyj8OZn06bOkpluhOunV4z9jVn7VsElEtLl9bFK7Wwvz3SgamikflagZu1PuLLW6eOEqloe1NS/0INUiGQ93ztlRQe3JyATyyp8bZX1ZAXAuk8N0XxTsrDGIYSNV2WE7DYWa+Wn86c4wB8gSi+t7z9oHiUwuDAwKPeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168431; c=relaxed/simple;
	bh=WCAnL1RuMU0W+2QGcVKKuVXGaRhQpR/IhkCMFv/QF7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M46Ot4Ui5KsWRTuBzovoB3YKrvlGHRiFzvXjO3IW+CQAGaclAL23qc+Im/Ugr/qZw9GYDk3JVclx1DiK1JABopDwT6MKyVCsnco7DQSTTh7CitgFmQAt0xnaB6L7g+z6nujd/sXFUrwZ1olQmUP0M0btyhaNwBPH9oPhxOM7FxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLO4lH2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E45C4CEE7;
	Fri,  6 Jun 2025 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749168431;
	bh=WCAnL1RuMU0W+2QGcVKKuVXGaRhQpR/IhkCMFv/QF7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLO4lH2SoVVbUbKRIreNMqW0at1MlwNLNSZPPRiPGgGlDSSwFcDZVO9GiK7fjvvLQ
	 txSCX1W7R7wa/vUTA6BQFYmpYlbdLHPtVrXs9KQpz8rs7V5xbhd04lOC7iJpz+TK1D
	 MEtD4mU+MHZPpgXizLtifZ8eLbEu3JRn8gVw4FZF3RdYTH8vr40EKTDq2157vTFe/O
	 GQJlyx2z4dIDg+uB7N049bsA6LTMlcv2SbCcW71XtymH80Up+ka2B/SryhyKIrQBMr
	 KTOPsw8TlY+mAMelna1rVRUYH1U00zh8UWUBOp26t8OhiQWA2yozWzwMWawo2jXSJJ
	 s3vZ7hT872iQw==
Date: Thu, 5 Jun 2025 19:07:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to
 yaml format
Message-ID: <174916842673.3519885.13165846799874556339.robh@kernel.org>
References: <20250602141638.941747-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602141638.941747-1-Frank.Li@nxp.com>


On Mon, 02 Jun 2025 10:16:36 -0400, Frank Li wrote:
> Convert nxp,lpc1850-dwmac.txt to yaml format.
> 
> Additional changes:
> - compatible string add fallback as "nxp,lpc1850-dwmac", "snps,dwmac-3.611"
> "snps,dwmac".
> - add common interrupts, interrupt-names, clocks, clock-names, resets and
>   reset-names properties.
> - add ref snps,dwmac.yaml.
> - add phy-mode in example to avoid dt_binding_check warning.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/nxp,lpc1850-dwmac.txt        | 20 -----
>  .../bindings/net/nxp,lpc1850-dwmac.yaml       | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


