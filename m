Return-Path: <netdev+bounces-184792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD6A9733A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8911B189DCE3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9C2918F0;
	Tue, 22 Apr 2025 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rss73jhJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009A281369;
	Tue, 22 Apr 2025 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341313; cv=none; b=O0/lyNBknnpjPvRsMzfzxM40zo5yRqeK+Ej7jG/96/dN3D3uElMyDsb2YRHP/CGI+0JtRRXo/sshtSINl1qjR/DRoTTOF3sP9xwOiH/WYY2rz73wfD/WUB3DnQTcpUpM767pYElnwRZhYdi96qSJwRBHoc8NavP05mv1xjyu0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341313; c=relaxed/simple;
	bh=fWsF0GzHzlvgBL9N9CUgvfUgXQvfItKvtkOWsRSc+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJo9IOD3X1omb/Io5YheMPE9og/ryef2V1XpqttbzN3QWuoVRGfJEOIJlNxQ4H0Q2zasymOfhCapZnuzl009Moe/jEAwaUf4SzwTZCG1DOnXdB1SXXEPihDT6dkXoedsZOYJTNY/LvzMsv31T3gxd3SwNJBKIkaLsV8XIsbaj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rss73jhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4254BC4CEE9;
	Tue, 22 Apr 2025 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745341313;
	bh=fWsF0GzHzlvgBL9N9CUgvfUgXQvfItKvtkOWsRSc+bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rss73jhJ0CKIlbRiAaKJHj2//3AaDHJ5IrR8Cd9T7hfaNA1GdgiAIjGp3HUSxWCzb
	 cU2MzG7R0obgILiH3ftg3wxow0dUQS46vFM2fJlQV58NX62gd8SJ0xMvf1re77cXaD
	 3hDzfuPEPSGbXtSYKrGBbJWJFBgWGoW25TvJ4TTbzyYnt3B6qBk/Z/F8NHPkvuq1fi
	 o+JDmN9LrYL6prgG0bW6Dpu7mForovlR48291c/KA1MKQU6Db3ruymz5nNTbi2VSBP
	 /Y/hB+v3PcivBpFx9cXGZPasqJeLNkodMel4JPc164ryHsKoYMklIuDJjgHqlLmMhq
	 ev2eOWEeTzzag==
Date: Tue, 22 Apr 2025 18:01:48 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: ethernet: mtk_eth_soc: net: revise NETSYSv3
 hardware  configuration
Message-ID: <20250422170148.GK2843373@horms.kernel.org>
References: <b71f8fd9d4bb69c646c4d558f9331dd965068606.1744907886.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71f8fd9d4bb69c646c4d558f9331dd965068606.1744907886.git.daniel@makrotopia.org>

On Thu, Apr 17, 2025 at 05:41:07PM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> Change hardware configuration for the NETSYSv3.
>  - Enable PSE dummy page mechanism for the GDM1/2/3
>  - Enable PSE drop mechanism when the WDMA Rx ring full
>  - Enable PSE no-drop mechanism for packets from the WDMA Tx
>  - Correct PSE free drop threshold
>  - Correct PSE CDMA high threshold
> 
> Fixes: 1953f134a1a8b ("net: ethernet: mtk_eth_soc: add NETSYS_V3 version support")
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I agree that this addresses the review of v2.
And otherwise looks good to me too.

Reviewed-by: Simon Horman <horms@kernel.org>

