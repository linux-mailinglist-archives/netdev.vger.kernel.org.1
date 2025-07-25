Return-Path: <netdev+bounces-210234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D44B12756
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB70189E7F1
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C44258CD4;
	Fri, 25 Jul 2025 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhH2V1yH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECC1D9A5D;
	Fri, 25 Jul 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485919; cv=none; b=UvHjlqg6z6bINMmi97ctJlzqhFtEpvMgeDYEToB9KVZwOVGcxtR1EeygSdd6y0ZpyhSU++2/s7NIXqSDYMZG8xQJ/HbrSTOWNyEjmJagWLuAfaQFe0W8NL1XbEYH8phT0oVwguT0FlmHCpl+VnNQVaeK3J42VXm7GzEliwoCgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485919; c=relaxed/simple;
	bh=30Lu0lu5cTdskwZvddFTxEhvmB6dDSde5G6CiimxE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHoCMEILvqmc4WsYz8e2ILSErtUByCtosP8m3XirrCtHPlO2WQ9kKwIsaUcCWF9X1i4WHylnLmFcpsaqBBF8fIyT4yLD42b+qXoNFlTG/JXdjcwhuD59Bp1U1BYtm0MlDumq8OHW5vWjQpge43KrCBlq/g3IrotIJLgrPJnnVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhH2V1yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A37C4CEE7;
	Fri, 25 Jul 2025 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485918;
	bh=30Lu0lu5cTdskwZvddFTxEhvmB6dDSde5G6CiimxE18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhH2V1yHUI/4eJQ6O6SG1WTvCOkt3dRljpQMyc6AJJvfc9Ge6R4yFP34FihWPc4AU
	 sCHjWECuBb9JWB5DHvvXko61NyKC4mpUdZUBDorYydB9bN4zn+wWJXl9dRjjTi5oNm
	 69IZ10ziTsotIvFjLvZ5zVRy0Aw8VaWi36Zm01diusnQXnPMP/Er4YWcGxQ/lIZD03
	 JQewW2m6ut/0cqUi+V2EZFgFNUuRVVyZlHJl/PRCu3xi28NZFElIJzIx9EKtLDIFJ7
	 E4curYdmx/NhdLREspoJMKHpBsLMP0OxYHetdO3gTNCl53Mvd6oA2GnJE7/UAegz/B
	 yCq9g/Ji9+iCQ==
Date: Fri, 25 Jul 2025 18:25:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, dinguyen@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: altr,socfpga-stmmac: Add
 compatible string for Agilex5
Message-ID: <175348591737.2024488.4815901624908424031.robh@kernel.org>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
 <20250724154052.205706-2-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724154052.205706-2-matthew.gerlach@altera.com>


On Thu, 24 Jul 2025 08:40:48 -0700, Matthew Gerlach wrote:
> Add compatible string for the Altera Agilex5 variant of the Synopsys DWC
> XGMAC IP version 2.10.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v2:
>  - Remove generic compatible string for Agilex5.
> ---
>  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml      | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


