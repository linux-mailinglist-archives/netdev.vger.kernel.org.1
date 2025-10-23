Return-Path: <netdev+bounces-231949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC52BFED72
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B6D1A04717
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197A19C54F;
	Thu, 23 Oct 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPHi4rNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99745157A5A;
	Thu, 23 Oct 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182795; cv=none; b=AyG+Y9GA9QZTLaAeMoMk9PFft7cwReJpYK8GjiFtFKDyncNw0JNX0WL3I+MzOrG4jssYVtx9iTvn8quA4ttfaSALq2oC4mRHL460OgoA1TbxqND9kNP1odzqjOlcAEEmBb0q7VSZPBRbKgeoF6P+SfNDKXz16rDnrsbId1r4vIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182795; c=relaxed/simple;
	bh=tWLpPoCH5+m0T9D8bTmmZrdgyYAjQrhj1vJe92xH2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isnCiVFsgPwrUXsQxt7MDzirEErZ4aaNoPATJbCq8RR546g+mr4/hyWPeVCfbVZmXMM9CbJQGh0ek5wMbmxgcSuih41psAorkkekH7eLzohcgrur1f9JP9x43BSeNL80fE51q6x4jJ70YQfH28Ci+ke3wDProtehuG9BXG2txaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPHi4rNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF45C4CEE7;
	Thu, 23 Oct 2025 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182795;
	bh=tWLpPoCH5+m0T9D8bTmmZrdgyYAjQrhj1vJe92xH2V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kPHi4rNsjNNgojJZjnHJvM3QdbWDXlEWQIABex9ix1ehpdbfQoaV1JqeGOKz7gQYg
	 qzqewwiU8PN6M2/zcosndWhepuJ0vFVm1bk9yiJYNhYANfnKhbLNoUK5WY57YI8kgO
	 zu/hkaKnx/m7BBWFlwWtq3VQoh4wObPDFJ2rNsdhHX0Nkf4Ou3Ajzt7qQF4HMJdOd3
	 EjrMtpd5+cl6JA6a0pH73A9C3kHafjDr2574dhtDaXb+9oVUfX8pB/kaR1bFnwHgxE
	 W6Y6H81pEqBJWJ7QyTvgAiWu35e9Nngojr0aLXiO7lcGZkpN5exjfEBONZ4NkCwP2M
	 rHVqc247ZGMMQ==
Date: Wed, 22 Oct 2025 18:26:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 0/4] DWMAC support for Rockchip RK3506
Message-ID: <20251022182633.77f2cbce@kernel.org>
In-Reply-To: <20251021224357.195015-1-heiko@sntech.de>
References: <20251021224357.195015-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 00:43:53 +0200 Heiko Stuebner wrote:
> Some cleanups to the DT binding for Rockchip variants of the dwmac
> and adding the RK3506 support on top.
> 
> As well as the driver-glue needed for setting up the correct RMII
> speed seitings.

Looks like its not your first contribution, feel free to add yourself
as the maintainer for stmmac/dwmac-rk.c (anyone else who wants to be
listed please raise a hand, Jonas?)

