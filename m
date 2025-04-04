Return-Path: <netdev+bounces-179300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE19A7BD1B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B267A8541
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A58635C;
	Fri,  4 Apr 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx8JTxqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462E2C9D;
	Fri,  4 Apr 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771674; cv=none; b=aLrCZMAsBAot6I1s8zBCpj4k7cp0LXTbOCZR3TSe4hIlBm9BjoCUfEuetoacj+gHSg2kUEfmVI6FTipXFQzLLgLNAEjCJrgccVC6w8Zl47QTqlPn96O7ZZU05naio/B58uDQ3j+DbCcmdcgk3a9CRpGGcrmpHl+PsuN4TzdHqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771674; c=relaxed/simple;
	bh=zukieTYHY0jzSOeUPQlnmK/fGkj4XrPKI8i8gJlsziQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOvA3ggIJBfFDBFxkDphsRULe1PuhQ3laUHmjSsx1rFdfCNob2n/B7TeRlKVhf3JERcRr0c+h1uwW3jrbp5ordkUM2i5FXEatb/6Np2aN2CZ3ViAiPAynlZHqoxoT5BFxOuQ8kmU6S5PyTwdQBFx2YCp9gvVntdUjefj68q6oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx8JTxqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC08C4CEDD;
	Fri,  4 Apr 2025 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743771674;
	bh=zukieTYHY0jzSOeUPQlnmK/fGkj4XrPKI8i8gJlsziQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx8JTxqJLf6DgwOHKwifg+Je7IIAWq3ErZQy+rLBkMg6iY40gu82pyshEIf0pPstr
	 +FkiZGjjm93tOkwY6ib0eeC5BfpGmF5ctdcQHJ2F/lSbH42wIxWtYmVABdid8rLWlF
	 xviHGCefw9GAtIzOb4o5ZMeMPRRZsoFpxEt0EIS4snBZ99LqZKtPRasOHo8OSskyfB
	 qDJtD2zWxvwNyh49uzlKPqCk9cl4S5xpGj2iUc25ovkup6/hNsGBq3Tf+cDZNtiMHR
	 AtnrtH7VhsxwNUPIPi/V7Bw3gXLXJmf2u2irZ91WqqNM6DQVjMw0wbnfUYGN3o7kTF
	 pBRq/bxW3elVA==
Date: Fri, 4 Apr 2025 14:01:07 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v13 10/14] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250404130107.GB278642@google.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315154407.26304-11-ansuelsmth@gmail.com>

On Sat, 15 Mar 2025, Christian Marangi wrote:

> Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> switch and a NVMEM provider. Also provide support for a virtual MDIO
> passthrough as the PHYs address for the switch are shared with the switch
> address.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  MAINTAINERS                 |   1 +

This won't apply before the others.  If I were you, I'd pull this change
out of here and add a MAINTAINERS entry as the final patch.

>  drivers/mfd/Kconfig         |  12 +
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/airoha-an8855.c | 429 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 443 insertions(+)
>  create mode 100644 drivers/mfd/airoha-an8855.c

-- 
Lee Jones [李琼斯]

