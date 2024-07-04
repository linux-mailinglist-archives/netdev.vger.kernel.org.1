Return-Path: <netdev+bounces-109272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D5927A38
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99DE2857B9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B01B14E0;
	Thu,  4 Jul 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="appUfOoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9781B012B;
	Thu,  4 Jul 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107159; cv=none; b=RysNdRKiB8g/CQ1RT9H5MJlkSaDldbq5pPnBIG58IVySFqwQR8IF0jcT/MI9/jSBLOjj8fNkYc8e0uQyWUsvygWNd3n+M1h2wOsGVrEMugx7sY2pj3KKUAgntFsH+boIQbXdU8yymOzxES/Y6ow2ELwxJpfwnlNweVHXlUB2zV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107159; c=relaxed/simple;
	bh=BPia1XTw5EqPymabVp1MSYoRjr4IprzDUwrpt+2SMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRip8abrX+s9z3qw7KklQonuTh+KVZjEm24NB84UFD0Q5oDb1xwRVd6UlU8+5ESRvzoffa41c7s3Lmgfm/nhsk5pDp8seKgcV74xJIi5iENMGWhHh3NoD3dvHVwImChCJlGLUpj8tiN0xnOZzR9noyhYfmIfFQWdoAfyVvfyXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=appUfOoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C08C3277B;
	Thu,  4 Jul 2024 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720107159;
	bh=BPia1XTw5EqPymabVp1MSYoRjr4IprzDUwrpt+2SMEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=appUfOoSUGRAbC3AgYNmvw+JnlvdX9cmKklRWc5eYj5vJicB0vIzLxF2S9kkcao0I
	 scslKSS69xufPP4m00C50H2aTpEvZfW0+nhQJfdInWE63Rgo+NBjKT3bUZqaDUpPeB
	 g93cMCp+7J31RllKKec1L8Uw6QacBT7iHv+8b/bLxafvBUVduMB6fl2tqKUXJDe02v
	 IJ0evEjepySopi+i0eN5IjF9RyCsZ6i34Q3O5QgkUDde5VlXB1+L3+/IiZh8R9tbM1
	 kPeBNQijU6LRCm3XSDxWFz0hKjNpa3Iuh125cHkmdNKz8l/vG3TvjUmxBQbRV5kiSH
	 Uh6Jds9vH5kBw==
Date: Thu, 4 Jul 2024 08:32:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, DENG Qingfang
 <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Landen Chao
 <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix impossible MDIO address
 and issue warning
Message-ID: <20240704083237.0be7de00@kernel.org>
In-Reply-To: <1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org>
References: <1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 16:08:22 +0100 Daniel Golle wrote:
> +return (phy_addr - MT7530_NUM_PORTS & ~MT7530_NUM_PORTS) + MT7530_NUM_PO=
RTS & PHY_MAX_ADDR - 1;

This is still unindented! :)
Also GCC doesn't trust you with removal of the parenthesis:

../drivers/net/dsa/mt7530-mdio.c:149:18: warning: suggest parentheses aroun=
d =E2=80=98-=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
  149 | return (phy_addr - MT7530_NUM_PORTS & ~MT7530_NUM_PORTS) + MT7530_N=
UM_PORTS & PHY_MAX_ADDR - 1;
../drivers/net/dsa/mt7530-mdio.c:149:58: warning: suggest parentheses aroun=
d =E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
  149 | return (phy_addr - MT7530_NUM_PORTS & ~MT7530_NUM_PORTS) + MT7530_N=
UM_PORTS & PHY_MAX_ADDR - 1;

even your you're correct.

