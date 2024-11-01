Return-Path: <netdev+bounces-141103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FAC9B98D2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F948B221A3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B41D0BA4;
	Fri,  1 Nov 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnoVXOdr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2A156880;
	Fri,  1 Nov 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489999; cv=none; b=vAGyBsG9SG0xNO6LBJscGYugJehgQNt1qPLpEcuUVCFXNTcN7DEbNaIgdMwmWfIn9NgpcnhFcGeUr6++P9V+FvKNQq6rN1ffuJXlL8wRU4OZTeXqu4b824THy+MjIBFYbEfCtAIniHLXFUMxD6tZIsRVZIksefaejLOP0jP/F38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489999; c=relaxed/simple;
	bh=5+9HDlpS67+JWi5nzbq2AXQUu22Nar07vzHHwqy/OSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAy8f64B6EQnzxcfJ2BGOa4hE4DpK8aUq7/LR9KGXjRRVaUlH0VlcualYe7HuTMoiKafyL0qksukkMG9NVMeEe9WgSLX+5aJCP+mrqkjYel4gN1AjTrCotLJ8yPQb2chRbK8y86Lftuf3ftGqows1s8KZAvVwWrsdDX9md1A25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnoVXOdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDB8C4CECD;
	Fri,  1 Nov 2024 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489999;
	bh=5+9HDlpS67+JWi5nzbq2AXQUu22Nar07vzHHwqy/OSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnoVXOdrZPUOnM9cGquOLHBhymk3J6J9E8gDaTfNxb8EMhp3KqiAQBnzmd8ST8TaG
	 Toe2zs350GKtznaD5wDnnP5vwr4DtYvhhJrRjeuj7Ut55Ja9mazExS+GEPqJYPObPJ
	 oB9hMGv0KaZb7y+L+Fi93tNkIArjiw1nVPBXHnTXURh23XUORgJdWLxVIpzOxwLupR
	 X4h9lNOljpW0wvnZmG+5XrJZ+LhGQqVXjgPECgcBmkLmP+/ghYX/yOle7RPvBPGb+a
	 onT9WxXzi5bprjZ7clmNfkc2+8ftThDsPOujGbPR4DQ7bsIkKFoH9euTwfjx8XdKkN
	 S/Ym04e01/mhw==
Date: Fri, 1 Nov 2024 14:39:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, krzk+dt@kernel.org,
	edumazet@google.com, a.fatoum@pengutronix.de, davem@davemloft.net,
	pabeni@redhat.com, dinguyen@kernel.org, marex@denx.de,
	kuba@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, s.trumtrar@pengutronix.de,
	joabreu@synopsys.com, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, conor+dt@kernel.org,
	alexandre.torgue@foss.st.com
Subject: Re: [PATCH v4 12/23] dt-bindings: net: snps,dwmac: add support for
 Arria10
Message-ID: <173048999498.4080241.4644127959389900220.robh@kernel.org>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
 <20241029202349.69442-13-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029202349.69442-13-l.rubusch@gmail.com>


On Tue, 29 Oct 2024 20:23:38 +0000, Lothar Rubusch wrote:
> The hard processor system (HPS) on the Intel/Altera Arria10 provides
> three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
> can be used to transmit and receive data at 10/100/1000 Mbps over
> ethernet connections in compliance with the IEEE 802.3 specification.
> The EMACs on the Arria10 are instances of the Synopsis DesignWare
> Universal 10/100/1000 Ethernet MAC, version 3.72a.
> 
> Support the Synopsis DesignWare version 3.72a, which is used in Intel's
> Arria10 SoC, since it was missing.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


