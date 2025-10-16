Return-Path: <netdev+bounces-230140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9027BE45E2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C394263E2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC234F47A;
	Thu, 16 Oct 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICMMHz+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2A34F46B;
	Thu, 16 Oct 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630049; cv=none; b=B0VfmUA75EurDp2Jay7w9giKPtaozqL+HsD+/iXpmOEsdBJrWfuvj4k9vBVCktAlXSJMIEhIDzxhENsk4OUQhVvuBHa/YeNd5oZhr8g5ASXVSPKcJ5ufNcvE9+8980T4eSffP17234j3lDxOMaqnGFo8XNUIvl5j0y1439hOmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630049; c=relaxed/simple;
	bh=MzbQ2BY+xkSQDjQHaiNk2TeebhTVZYDmnm7F8+q9KHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap157Glm0gzkJ1rT+BBmJeucX1svnpv1I0P6yFSq3UvqgcU2M93ad+VYB4h9E+1YHoUT9PrUcdwwOhp3lbMon8VnzDFB2CH+SFWEobOk001bl4rZNaBMKgWldRvgEucHdvjStyHeyWPWhCH6unneK7phwutFe6VpZeDz551mtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICMMHz+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD18C4CEFB;
	Thu, 16 Oct 2025 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630048;
	bh=MzbQ2BY+xkSQDjQHaiNk2TeebhTVZYDmnm7F8+q9KHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICMMHz+rh+Oy/eceOUktsQjXuWuXOPJuWINTXnkn0zPWMs8d4XlCQF5zPTIwunhfv
	 suUTNdZdTUg7ztTsPIjyCA/jegFv+M9IJHkb/O0DXAY3kWNIOy+1n1ejALSvWuFZFO
	 vT1VKA+TjXeh2fkX2EJBTcTFC3NwA+Qwvpjr41Tt2cVY4lH5QCQaIywSn/K2v4vK29
	 dD1D5MfPVQPUc8VHj5+ahgdXuvzIcPcHLEWyIMKg8A059HUMEjH81sVx690GnTkiFy
	 ZlKY1arAUEms2HW4jzQYJ5t+WB73ghVMr7A9BWaUMth9kdJ41Z5aaAcUMNJ/35kvWw
	 zCfhKIeRZ1mMg==
Date: Thu, 16 Oct 2025 16:54:03 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/13] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Message-ID: <aPEVG0smO9lUek4W@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-8-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-8-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:22PM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
> the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
> This is a preliminary patch to enable netfilter flowtable hw offload for
> AN7583 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


