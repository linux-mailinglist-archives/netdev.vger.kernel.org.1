Return-Path: <netdev+bounces-154089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9199FB3F3
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B19166153
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41481C07C3;
	Mon, 23 Dec 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq9mThRr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B321B6CFE;
	Mon, 23 Dec 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978181; cv=none; b=UBVBOr2zKv+RBCsoVZ0gKO2mhp77swaHMzSls/VnDtiSza36hUV2efztx/SyJy8F1dEEhpgv4fhwL4dB/yBXt++vnORfGDPMe7Vhcjg0+smk0WFkVKhFNXT0CXYCDDzcILab3h3RRQZsuI5A0eGR8+kPZfIMhJFwj/juGLFsdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978181; c=relaxed/simple;
	bh=dvic7CQvdaQvsQq9bVY/SP52KhgXeQuTCZCa+4u5Vno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb5m51/0vyr+mTwphTizvLEjHByTDdh80gXXhDVw7HdLAjLhym9NTqIq5Mu8E9vGLB3lcp8GkbekYxX48YXJRGDBRztzZvaDHTYHfVrHuBFFCUQVCQS0RicENlhEJ7v1D8xXgrMo5Sds9/fSRbFWKik2MtwQhn40NreC0XdLKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq9mThRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B66C4CED4;
	Mon, 23 Dec 2024 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978181;
	bh=dvic7CQvdaQvsQq9bVY/SP52KhgXeQuTCZCa+4u5Vno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wq9mThRr+RpHKMktF0pHzR6SYDmsCgmKrcgnkf8IFOgc/SVMR4M1ilhnyRQoSA1BW
	 v78XhBo9UWIaqW5pnr3UX4zrH5im99okLeoC7dXhimup5ad8YDgIjepvBN3mvv1j+P
	 wLiSOlDv99IXYJnSkFbXGp/GtuwNWp3D6UjfdHhZ1DKVmcWJgLeRC+Q1L8xFISoBsD
	 XYlTAwaLPyzV6wIbQGZJyOUF+09BNRgwOUv2iAsarWpy4XvX7zIzHHx+Tmio/NCMAA
	 aa4bBEJrJe9R0421kkKF+3mcd53NW7iqpBibS++Fhog9LqvAMl1A30xraux7oBEQjc
	 7HFEbAcYsseTA==
Date: Mon, 23 Dec 2024 10:22:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v3 0/3] riscv: sophgo: Add ethernet support for
 SG2044
Message-ID: <20241223102259.06661253@kernel.org>
In-Reply-To: <20241223005843.483805-1-inochiama@gmail.com>
References: <20241223005843.483805-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 08:58:36 +0800 Inochi Amaoto wrote:
> The ethernet controller of SG2044 is Synopsys DesignWare IP with
> custom clock. Add glue layer for it.
> 
> Since v2, these patch depends on that following patch that provides
> helper function to compute rgmii clock, As for now, this patch is merged
> in net/for-next
> https://lore.kernel.org/netdev/173380743727.355055.17303486442146316315.git-patchwork-notify@kernel.org/

## Form letter - winter break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

