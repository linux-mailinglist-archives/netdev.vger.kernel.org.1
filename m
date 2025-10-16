Return-Path: <netdev+bounces-230143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AFBE46D6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02D334EDD1F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF288329C58;
	Thu, 16 Oct 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6wE2v29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E62329C51;
	Thu, 16 Oct 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630379; cv=none; b=loYXHeaanJ4KHXCrcbqVH6wVHvvMcOKMih3LG1iAgEStne+NDrXOUcPr9rek0o7Jz9EDnpYmgmcYALeVkYVX7tbocGA/FXAA1IF8kAMLspUeu4huPIFJ0He3XHmeQoFAr8og0mcrqrGCuoRFVFxgj1WVqOqtSKPyJTmlPA7sDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630379; c=relaxed/simple;
	bh=SJlzwOOY6t7zuzTUWnggtH3r47vy917/ILKlY4X2z2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwxyIyC3til7CxMeXSLpgxFMimS6zewYD+wij5WU87EVN2MElc3pSS26M5m8etXg+YJFNLeev9n6FejVA2Rt15U1enZBlq4BsdQ/z36f6BNcoUvASd9u1bQ/LseQvhj2NCYAPtD6BkdKjY2GhtN0tsxAZ04wR+HgHBXf1yFspiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6wE2v29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE6C4CEF1;
	Thu, 16 Oct 2025 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630379;
	bh=SJlzwOOY6t7zuzTUWnggtH3r47vy917/ILKlY4X2z2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6wE2v29DTycMLwHb8XFJFqEWdwScI3nta6k826+Pg1j67L2VFtrhbBTmBaugVUej
	 a+2ERtrJD+AOE15b+x1ojsY5O5/mNRHit3m6j81bDRTPLggc6kDN/01J4kiVela95u
	 3iUEvnxEZjzfswNFVKsvBGsvPrvsZV9PK2IqAr6Ucmk/wU+At16EPsw5wH41aWp1s+
	 dJs4ufb0xmzWOwFoAIfLqOAOtZ+OsmNL67vpBBaeFtwkvR/LkAVjnnhJ/DU4mGtLkc
	 aV2S/KL9pUSZBuMpgvNmMVsR8qHaHR5XDuqbkcr4ffMAxDkXf9AdkP3UzUU2pA6Hzi
	 3Q4X0CkfTXEaQ==
Date: Thu, 16 Oct 2025 16:59:34 +0100
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
Subject: Re: [PATCH net-next v2 10/13] net: airoha: Select default ppe cpu
 port in airoha_dev_init()
Message-ID: <aPEWZhetZ74NVgjr@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-10-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-10-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:24PM +0200, Lorenzo Bianconi wrote:
> Select the PPE default cpu port in airoha_dev_init routine.
> This patch allows to distribute the load between the two available cpu
> ports (FE_PSE_PORT_CDM1 and FE_PSE_PORT_CDM2) if the device is running a
> single PPE module (e.g. 7583) selecting the cpu port based on the use
> QDMA device. For multi-PPE device (e.g. 7581) assign FE_PSE_PORT_CDM1 to
> PPE1 and FE_PSE_PORT_CDM2 to PPE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


