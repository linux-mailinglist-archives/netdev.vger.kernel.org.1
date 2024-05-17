Return-Path: <netdev+bounces-97020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0D8C8C9D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354B5B23969
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7A13E411;
	Fri, 17 May 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYHVe5SC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C13E3FE;
	Fri, 17 May 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973026; cv=none; b=JM2FByjQ9OXmvL5JULwGMZ6QL6pXZ2+WosD6VEFPIq0uD9T2exiAkqxaS+oIQOluFAXykGezdHBkZ8vxegKdpOkffMNj+MnkJFMXyAFa7JceJ++ntG7V5BDMr17AmClWIcMOgAnoNvtqipq9nZakZNteEFp5k/HHECYZihLkg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973026; c=relaxed/simple;
	bh=wOOGkoKGvagnGIuFGWUQi+/XM0qoo+nYaSgD8aHlsL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt3RwuLmMTSIhjvcx8rTRcZchEM2r+b3D8D3HFso6IEMj/V+kjrj1fMM6XY6n8O2MoxpoVLho844KdOVcSFy2aeiXbF9B7mS4BV5OTuD2aCE086n8UvwDNjHXMnUOmewy0tSwtn6TwVDuUfUyfEXaEv6O30NjKmFqWGdU1fvz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYHVe5SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28112C2BD10;
	Fri, 17 May 2024 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973026;
	bh=wOOGkoKGvagnGIuFGWUQi+/XM0qoo+nYaSgD8aHlsL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYHVe5SCP6vA21VjqimT/TCTDdevm3GBnC0jNIcGMi4NC0y534bpkezsXTWFHIQ3x
	 tHdW1E6UrATEXk2Sv699qrRPCF4xTRlt5Msr8tlu2hE7CeL3FejaF5YEgs7hF1Siat
	 /RiHSin+ADfp0NALuswp/5/Fq58sS7X8dL7vmCkdtJUq/3Ce4suEhjozC3GaXWE/wH
	 kyjdYfHG55mCJZI89RTY9YW8iWjv2vPsGvYRpHd3NTf9mXtgmUa7kJdzyvO18rfp7V
	 v7GUKyzk55Ah2Ef8TfaC4hT/xtxyA6MPvykOEVQjsrupvIytHl+zSNbgmK9Re2SmUS
	 HnZDnpUFtHbnA==
Date: Fri, 17 May 2024 12:10:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng
 <dqfext@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 0/5] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Message-ID: <20240517121025.42b76cb4@kernel.org>
In-Reply-To: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 18:29:03 +0800 Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MTK ethernet phy drivers and integrate common manipulations
> into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


