Return-Path: <netdev+bounces-185227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BAA995ED
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2157C1B6750C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB328A1CF;
	Wed, 23 Apr 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HTgGcYUY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E52820AF;
	Wed, 23 Apr 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427566; cv=none; b=Ufh2CyzAlNinMALQdObQdGOkblnHDSYy+eLmUBMPkRVDgxy+CbsV2VhtpYY02DbyyJpdsBrC95xr4b4EXgos8MPQrhuz/fxK2eBnx3wVW9oMBgd1HiHqlUr9o5YG7H96GMA6onwjvJNaoKsyPy9AQAIyBKxkTp1PwpvHes5Lh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427566; c=relaxed/simple;
	bh=sX77W58og4f7TVzBiVcSzr1pOUIuK6lzidg8w6JHimQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5ioafuIyU/qeHkCJEFusHx4N4IfehjPcudXLttrpFNYrmDiWTlaxUgUHSa+kem3gHCoZJBEa7D6L5uzcmgPxJj3xHtVlmkWlKTVqhnbK7K0uwMMsfkrEHeu0raMxgMK7r9JXoJo1kBZT7zpftneZopQESc8XMwWWxpvuzZAKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HTgGcYUY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9eg5/u6HzX0Cp+nICWQL7K//s1nQYj6V4b9sPm0RHqc=; b=HTgGcYUYQrh/dviTjPqiP+NehA
	j9fzKjHgaPNTBMwNKS+qS5WEXTole8ST55pYhA+OG/elfkf+SOkH46lYaUW1+ymoVsNRt7m+PCjN3
	fFDnjgFQ9nuHL5oKa+aHDDUnP1XDpoJg565TXYNMX0onQw2zzfYR2KVgbvQ1V4jIQsJM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7dRI-00AMTD-Pu; Wed, 23 Apr 2025 18:59:12 +0200
Date: Wed, 23 Apr 2025 18:59:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaoto-A1
 board
Message-ID: <de5ecf8c-2dcb-4228-8cb0-daea4767639f@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>

> +&emac0 {
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +
> +	allwinner,tx-delay-ps = <100>;
> +	allwinner,rx-delay-ps = <300>;

Same issue here.

     Andrew

