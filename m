Return-Path: <netdev+bounces-205127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62401AFD7CB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D7D3B6696
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81C21767A;
	Tue,  8 Jul 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOJePljD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F13224D7;
	Tue,  8 Jul 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004945; cv=none; b=IK/sWnC3jvkFK+kt45/sGLqZO+jQ0fVKSNHPPO4l4VfhgeX9Yv45lw6nb5oEW+x5guJkO0xYddEUYs1cG89+QThMhsyBGat8kmEw1iTGwYV3kxVrTfkDh/INVdPXiuKhWpCnYJUqy1jju6G8BczfiKuD6Cng1CTzIM0q8QJPEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004945; c=relaxed/simple;
	bh=CwVILos/EFGVl/HPlWBYtRO23IjPE9Xo1PtpRcBZodM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neQSlgFFwSOfBx/T095BAki0eoNj122hIrFKV4jE38jOoGtc9+D3aqbAv2L1s6Gjp7FpTG8xBr5/PvHypo50rTSjX3P8efKdFD8AMP7msBdXpicJKcVpSPn8RFcm6gY+sX//ezY6bGUvbsq5uld5r+vbZS8frx03XbYa65Xqz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOJePljD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07804C4CEED;
	Tue,  8 Jul 2025 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752004945;
	bh=CwVILos/EFGVl/HPlWBYtRO23IjPE9Xo1PtpRcBZodM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOJePljD4+t0xDpG6/Nzl7obj7K68l/6m+/EBsX0vxIb+RhCGGQMv9edn+KtAeLJn
	 KjqyXFgo59givxvTHyc3iSF1J8p8HIU9izQyZLr2DRR0WnmnWPPSHyI1zHnnvuuFXN
	 qXKOPsy/qrQnozOjdp4bhfzhdUQQu4IGYN7QX4E8Mn58pnh2jbdD5l/QFgsRB3N1c8
	 6B9F/yHKc+uDM29CB0mhnZxMqzT92Ez94eKpXOZ1TYUdhCH1Y/M2qPYm9qlqlW+aXX
	 L1ZuXhYgQ4E012X/oKHsen6mqJdMf2VBE9n/iBvkVa3Jb9L/v0ABmqoseKW2XgTDSu
	 Aw2nLGOuXAHNw==
Date: Tue, 8 Jul 2025 15:02:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, davem@davemloft.net,
	krzk+dt@kernel.org, dinguyen@kernel.org, devicetree@vger.kernel.org,
	mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com,
	alexandre.torgue@foss.st.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH] dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems
 to iommus
Message-ID: <175200494323.868123.7054361203778123218.robh@kernel.org>
References: <20250707154409.15527-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707154409.15527-1-matthew.gerlach@altera.com>


On Mon, 07 Jul 2025 08:44:09 -0700, Matthew Gerlach wrote:
> Add missing 'minItems: 1' to iommus property of the Altera SOCFPGA SoC
> implementation of the Synopsys DWMAC.
> 
> Fixes: 6d359cf464f4 ("dt-bindings: net: Convert socfpga-dwmac bindings to yaml")
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


